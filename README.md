# SentinelWallet

A Swift SDK that talks to the [Sentinel](https://sentinel.co) blockchain (a Cosmos SDK chain) over gRPC. It lets an iOS app query on-chain state — nodes, plans, balances, subscriptions, sessions — and submit signed transactions to subscribe to plans, start/stop dVPN sessions, and transfer funds.

## Installation

Add the package via Swift Package Manager: `File > Add Package Dependencies…` in Xcode and point it at this repository.

## Overview

The public surface is organised around three providers that each wrap a slice of the chain's gRPC API:

| Provider | Use it for |
| --- | --- |
| `AsyncNodesProvider` | Browsing active nodes and plans |
| `AsyncSubscriptionsProvider` | Reading wallet state — balances, subscriptions, active sessions, fee grants |
| `AsyncTransactionProvider` | Sending signed transactions — subscribe, start/stop session, transfer, cancel |

All three share the same shape:

- Construct with an optional `ClientConnectionConfiguration` (defaults to `grpc.sentinel.co:9090`).
- Reconfigure at runtime via `ConfigurableProvider.set(host:port:)`.
- Async/await API. Most methods come in two flavours: an `Async…ProviderType` returning JSON strings, and a `Typed…ProviderType` returning the underlying protobuf types.

```swift
let nodes = AsyncNodesProvider()
let subscriptions = AsyncSubscriptionsProvider()
let transactions = AsyncTransactionProvider()

// Point them at a different gRPC endpoint if needed:
nodes.set(host: "grpc.example.com", port: 9090)
```

## `AsyncNodesProvider`

Read-only queries against the Sentinel `node` and `plan` modules.

```swift
let nodes = AsyncNodesProvider()

let activeNodesJSON = try await nodes.getActiveNodes(limit: 50, offset: 0)
let nodesForPlanJSON = try await nodes.getActiveNodes(for: planID, limit: 50, offset: 0)
let plansJSON = try await nodes.getPlans(limit: 50, offset: 0)
```

All three methods return raw JSON strings produced from the protobuf response.

## `AsyncSubscriptionsProvider`

Reads everything tied to a particular wallet address.

```swift
let provider = AsyncSubscriptionsProvider()

// JSON variants
let balanceJSON = try await provider.fetchBalance(for: wallet)
let subsJSON    = try await provider.fetchSubscriptions(limit: 50, offset: 0, for: wallet)
let sessionJSON = try await provider.fetchSessions(for: wallet)        // nil when none active
let grantJSON   = try await provider.fetchGrants(for: wallet, granter: granter)

// Typed variants (same provider conforms to TypedSubscriptionsProviderType)
let coins: [Cosmos_Base_V1beta1_Coin] =
    try await provider.fetchBalance(for: wallet)

let subs: Sentinel_Subscription_V3_QuerySubscriptionsForAccountResponse =
    try await provider.fetchSubscriptions(limit: 50, offset: 0, for: wallet)

let activeSessionID: UInt64? = try await provider.fetchSessions(for: wallet)
```

`fetchSessions` returns the id of the most recent active session, or `nil` if there isn't one. `fetchGrants` queries the `feegrant` module — useful before sending a transaction with a `granter` set on the `Fee`.

## `AsyncTransactionProvider`

Builds, signs (locally, via `Signer` + the user's mnemonic), and broadcasts transactions.

Every transaction needs a `TransactionSender`:

```swift
let sender = TransactionSender(
    owner: walletAddress,            // bech32 sentinel address
    ownerMnemonic: mnemonicWords,    // [String], BIP39 words
    chainID: chainID                 // e.g. "sentinelhub-2"
)
```

### Subscribe to a plan

```swift
let details = PlanPaymentDetails(address: planProviderAddress, denom: "udvpn")

// JSON response
let txJSON = try await transactions.subscribe(
    sender: sender,
    plan: planID,
    details: details,
    fee: .standart                   // or Fee(for: gas) / Fee(gas, [.init(...)], granter:)
)

// Or typed Bool (success/failure), uses Fee.standart internally
let ok = try await transactions.subscribe(sender: sender, plan: planID, details: details)
```

### Start / stop a session on a node

`startSession` will atomically cancel an existing active session if you pass its id in `activeSession`, then open a new one against `node`.

```swift
let ok = try await transactions.startSession(
    sender: sender,
    on: subscriptionID,
    activeSession: previousSessionID,   // pass nil if none
    node: nodeAddress
)

let stopped = try await transactions.stopSession(
    sender: sender,
    activeSession: sessionID,
    node: nodeAddress
)
```

### Cancel subscriptions

```swift
let ok = try await transactions.cancel(
    subscriptions: [subscriptionID1, subscriptionID2],
    sender: sender,
    node: nodeAddress
)
```

### Direct transfer

```swift
let payment = DirectPaymentDetails(amount: "1000000", denom: "udvpn", memo: nil)

let txJSON = try await transactions.transfer(
    sender: sender,
    recipient: recipientAddress,
    details: payment,
    fee: .standart
)
```

### Look up a broadcast transaction

```swift
let txJSON = try await transactions.getTx(by: txHash)
```

### Fees

```swift
Fee.standart                                    // 30_000 gas, 3_000 udvpn
Fee(for: 50_000)                                // gas → amount = gas, fee = gas * 10
Fee("50000", [CoinToken(denom: "udvpn", amount: "5000")], granter: feeGranter)
```

Setting `granter` on the `Fee` makes the transaction pay fees from a feegrant authorization — pair it with `AsyncSubscriptionsProvider.fetchGrants` to verify the grant exists first.

## Configuration

`ClientConnectionConfiguration` defaults to `GlobalConstants.defaultLCDHostString` (`grpc.sentinel.co`) and `defaultLCDPort` (`9090`). Override either at construction or at runtime:

```swift
let provider = AsyncTransactionProvider(
    config: .init(host: "grpc.example.com", port: 9090)
)
provider.set(host: "grpc.other.com", port: 9090)
```

The connection is `insecure` gRPC (plain h2c). Each call opens and closes its own channel.

## License

MIT — see [LICENSE](LICENSE).
