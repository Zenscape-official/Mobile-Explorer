

// switchCase(type){
// 	  switch(type) {
//   //auction
//     case 'Place Surplus Bid Request':
//       return buildtxContainer();
//     case 'Place Debt Bid Request':
//       return buildtxContainer();
//     case 'Place Surplus Dutch Request':
//       return buildtxContainer();
//     case 'Place Dutch Lend Bid Request':
//       return buildtxContainer();
//     case 'Fetch Price Data Response':
//       return buildtxContainer();
//
//   //ESM
//     case 'Deposit ESM Response':
//       return buildtxContainer();
//     case 'Execute ESM Response':
//       return buildtxContainer();
//     case 'Kill Response':
//       return buildtxContainer();
//     case 'Collateral Redemption Response':
//       return buildtxContainer();
//
//   //lend
//     case 'Lend Request':
//       return buildtxContainer();
//     case 'Withdraw Request':
//       return buildtxContainer();
//     case 'Deposit Request':
//       return buildtxContainer();
//     case 'Close Lend Response':
//       return buildtxContainer();
//     case 'Borrow Response':
//       return buildtxContainer();
//     case 'Repay Response':
//       return buildtxContainer();
//     case 'Deposit Borrow Response':
//       return buildtxContainer();
//     case 'Draw Response':
//       return buildtxContainer();
//     case 'Close Borrow Response':
//       return buildtxContainer();
//
//     case 'Borrow Alternate Response':
//       return buildtxContainer();
//     case 'Fund Module Accounts Response':
//       return buildtxContainer();
//     case 'Calculate Interest And Rewards Response':
//
//     //liquidation
//       return buildtxContainer();
//     case 'Liquidate Borrow Response':
//       return buildtxContainer();
//
//   //liquidity
//     case 'Create Pair':
//       return buildtxContainer();
//     case 'Create Pool':
//       return buildtxContainer();
//     case 'Deposit':
//       return buildtxContainer();
//     case 'Withdraw':
//       return buildtxContainer();
//     case 'Limit Order':
//
//       return buildtxContainer();
//     case 'Market Order':
//       return buildtxContainer();
//     case 'Cancel Order':
//       return buildtxContainer();
//     case 'Cancel ALl Orders':
//       return buildtxContainer();
//     case 'Farm':
//       return buildtxContainer();
//     case 'UnFarm':
//       return buildtxContainer();
//
//   //locker
//     case 'Create Locker Request':
//       return buildtxContainer();
//     case 'Deposit Asset Request':
//       return buildtxContainer();
//     case 'Withdraw Asset Request':
//       return buildtxContainer();
//     case 'Close Locker Request':
//       return buildtxContainer();
//     case 'Locker Reward Calc Request':
//       return buildtxContainer();
//
//   //rewards
//     case 'Create Gauge':
//       return buildtxContainer();
//     case 'Activate External Rewards Lockers':
//       return buildtxContainer();
//     case 'Activate External Rewards Vault':
//       return buildtxContainer();
//     case 'Activate External Rewards Lend':
//       return buildtxContainer();
//
//   //tokenMint
//     case 'Mint New Tokens Request':
//       return buildtxContainer();
//
//
//   //vault
//     case 'Create Response':
//       return buildtxContainer();
//     case 'Deposit Response':
//       return buildtxContainer();
//     case 'Withdraw Request':
//       return buildtxContainer();
//     case 'Draw Request':
//       return buildtxContainer();
//
//     case 'Repay Request':
//       return buildtxContainer();
//     case 'Close Request':
//       return buildtxContainer();
//     case 'Deposit And Draw Request':
//       return buildtxContainer();
//     case 'Create Stable Mint Request':
//       return buildtxContainer();
//
//     case 'Deposit Stable Mint Request':
//       return buildtxContainer();
//     case 'Withdraw Stable Mint Request':
//       return buildtxContainer();
//     case 'Vault Interest Calc Request':
//       return buildtxContainer();
//     case 'Send':
//       return buildtxContainer();
//
//     case 'Deposit Request':
//       return buildtxContainer();
//     case 'Execute Contract':
//       return buildtxContainer();
//
//
//
//     default:
//       return buildtxContainer();
//   }
//
// }




//Bank Message Send
//  		"messages":
// [
//   {
//  		"@type": "/cosmos.bank.v1beta1.MsgSend",
//  		"amount": [
//  		{
//  		"denom": "ucmdx",
//  		"amount": "50000000"
//  		}
//  		],
//
//
//
// Create Pool
// [
// * 		{
// * 		"@type": “/comdex.liquidity.v1beta1.MsgCreatePool",
// * 		"app_id": "1",
// * 		"creator": "comdex1dd6an9faxvtd39cqtsw0nz0rsnmpa27xdfrq4g",
// * 		"pair_id": "1",
// * 		"deposit_coins": [
// * 		{
// * 		"denom": "ucmdx",
// * 		"amount": "2000000"
// * 		},
// * 		{
// * 		"denom": "uharbor",
// * 		"amount": "2000000"
// * 		}
// * 		]
// * 		}
// ],
//
// Message Send
//
// * 		"messages": [
// * 		{
// * 		"@type": "/cosmos.bank.v1beta1.MsgSend",
// * 		"amount": [
// * 		{
// * 		"denom": "ucmdx",
// * 		"amount": "50000000"
// * 		}
// * 		],
// * 		"to_address": "comdex1tuuf3l9hlwhevrdqejn23gqgaw0nc8kz6m245n",
// * 		"from_address": "comdex1vgenpdplmlwvmn2kks4h2784ezt8pgup7pqsn5"
// * 		}
// * 		],
//
// Locker Reward Calc Request
//
// [
// * 		{
// * 		"from": "comdex1rt0wfnqcsczl9zl82tr8ael53c5dajdk6hg6zy",
// * 		"@type": "/comdex.locker.v1beta1.MsgLockerRewardCalcRequest",
// * 		"app_id": "2",
// * 		"locker_id": "8068"
// * 		}
// ],
//
// Farm
//
// * 		"messages": [
// * 		{
// * 		"@type": "/comdex.liquidity.v1beta1.MsgFarm",
// * 		"app_id": "1",
// * 		"farmer": "comdex1eclk4hp5xf6kfqan9n5vjd5nqfk6qsj7jd0de4",
// * 		"pool_id": "1",
// * 		"farming_pool_coin": {
// * 		"denom": "pool1-1",
// * 		"amount": "11206029636"
// * 		}
// * 		}
// * 		],
//
// Deposit
//
// * 		"messages": [
// * 		{
// * 		"@type": "/comdex.liquidity.v1beta1.MsgDeposit",
// * 		"app_id": "1",
// * 		"pool_id": "1",
// * 		"depositor": "comdex1eclk4hp5xf6kfqan9n5vjd5nqfk6qsj7jd0de4",
// * 		"deposit_coins": [
// * 		{
// * 		"denom": "ucmdx",
// * 		"amount": "10000000"
// * 		},
// * 		{
// * 		"denom": "uharbor",
// * 		"amount": "6278760"
// * 		}
// * 		]
// * 		}
// * 		],
//
// Transfer
//
// * 		"messages": [
// * 		{
// * 		"@type": "/ibc.applications.transfer.v1.MsgTransfer",
// * 		"token": {
// * 		"denom": "ibc/2E5D0AC026AC1AFA65A23023BA4F24BB8DDF94F118EDC0BAD6F625BFC557CDED",
// * 		"amount": "1000000"
// * 		},
// * 		"sender": "comdex1dd6an9faxvtd39cqtsw0nz0rsnmpa27xdfrq4g",
// * 		"receiver": "cosmos1dd6an9faxvtd39cqtsw0nz0rsnmpa27x2xpzvl",
// * 		"source_port": "transfer",
// * 		"source_channel": "channel-17",
// * 		"timeout_height": {
// * 		"revision_height": "13816432",
// * 		"revision_number": "0"
// * 		},
// * 		"timeout_timestamp": "0"
// * 		}
// * 		],
//
// Send
// * 		"messages": [
// * 		{
// * 		"@type": "/cosmos.bank.v1beta1.MsgSend",
// * 		"amount": [
// * 		{
// * 		"denom": "ucmdx",
// * 		"amount": "50000000"
// * 		}
// * 		],
// * 		"to_address": "comdex1tuuf3l9hlwhevrdqejn23gqgaw0nc8kz6m245n",
// * 		"from_address": "comdex1vgenpdplmlwvmn2kks4h2784ezt8pgup7pqsn5"
// * 		}
// * 		],
//
