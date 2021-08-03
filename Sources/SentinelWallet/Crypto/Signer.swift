//
//  Signer.swift
//  SentinelWallet
//
//  Created by Lika Vorobyeva on 02.07.2021.
//

import Foundation
import HDWallet

final class Signer {
    static func generateSignedRequest(
        with account: Google_Protobuf2_Any,
        to address: String,
        fee: Fee,
        for messages: [Google_Protobuf2_Any],
        memo: String,
        mode: Cosmos_Tx_V1beta1_BroadcastMode = .block,
        privateKey: PrivateKey,
        chainId: String
    ) -> Cosmos_Tx_V1beta1_BroadcastTxRequest {
        guard let authorization = Utils.parseAuthorization(for: account) else {
            fatalError("Failed to get authorization")
        }
        let txBody = Cosmos_Tx_V1beta1_TxBody.with {
            $0.memo = memo
            $0.messages = messages
        }
        let signerInfo = getGrpcSignerInfo(
            account: account,
            privateKey: privateKey,
            sequence: authorization.sequence
        )
        let authInfo = getGrpcAuthInfo(from: signerInfo, with: fee)
        let rawTx = getGrpcRawTx(
            account: account,
            accountNumber: authorization.accountNumber,
            txBody: txBody,
            authInfo: authInfo,
            privateKey: privateKey,
            chainId: chainId
        )

        return Cosmos_Tx_V1beta1_BroadcastTxRequest.with {
            $0.mode = mode
            $0.txBytes = try! rawTx.serializedData()
        }
    }
}

private extension Signer {
    static func getGrpcSignerInfo(
        account: Google_Protobuf2_Any,
        privateKey: PrivateKey,
        sequence: UInt64
    ) -> Cosmos_Tx_V1beta1_SignerInfo {
        let single = Cosmos_Tx_V1beta1_ModeInfo.Single.with { $0.mode = Cosmos_Tx_Signing_V1beta1_SignMode.direct }
        let mode = Cosmos_Tx_V1beta1_ModeInfo.with { $0.single = single }
        let pub = Cosmos_Crypto_Secp256k1_PubKey.with { $0.key = privateKey.publicKey.data }
        let pubKey = Google_Protobuf2_Any.with {
            $0.typeURL = "/cosmos.crypto.secp256k1.PubKey"
            $0.value = try! pub.serializedData()
        }

        return Cosmos_Tx_V1beta1_SignerInfo.with {
            $0.publicKey = pubKey
            $0.modeInfo = mode
            $0.sequence = sequence
        }
    }

    static func getGrpcAuthInfo(
        from signerInfo: Cosmos_Tx_V1beta1_SignerInfo,
        with fee: Fee
    ) -> Cosmos_Tx_V1beta1_AuthInfo {
        let feeCoin = Cosmos_Base_V1beta1_Coin.with {
            $0.denom = fee.tokens[0].denom
            $0.amount = fee.tokens[0].amount
        }
        let txFee = Cosmos_Tx_V1beta1_Fee.with {
            $0.amount = [feeCoin]
            $0.gasLimit = UInt64(fee.gas)!
        }
        return Cosmos_Tx_V1beta1_AuthInfo.with {
            $0.fee = txFee
            $0.signerInfos = [signerInfo]
        }
    }

    static func getGrpcRawTx(
        account: Google_Protobuf2_Any,
        accountNumber: UInt64,
        txBody: Cosmos_Tx_V1beta1_TxBody,
        authInfo: Cosmos_Tx_V1beta1_AuthInfo,
        privateKey: PrivateKey,
        chainId: String
    ) -> Cosmos_Tx_V1beta1_TxRaw {
        let signDoc = Cosmos_Tx_V1beta1_SignDoc.with {
            $0.bodyBytes = try! txBody.serializedData()
            $0.authInfoBytes = try! authInfo.serializedData()
            $0.chainID = chainId
            $0.accountNumber = accountNumber
        }
        let serializedData = try! signDoc.serializedData()
        let sigbyte = try! ECDSA.compactSign(data: serializedData.sha256(), privateKey: privateKey.raw)

        return Cosmos_Tx_V1beta1_TxRaw.with {
            $0.bodyBytes = try! txBody.serializedData()
            $0.authInfoBytes = try! authInfo.serializedData()
            $0.signatures = [sigbyte]
        }
    }
}
