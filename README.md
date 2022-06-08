Mobile Tech Challenge

Goal
Create a crypto marketplace screen that displays a list of crypto trading pairs with USD.

Description
You will use the Bitfinex API (https://docs.bitfinex.com/reference#rest-public-tickers ) to retrieve the data. 
The screen should show a list of trading pairs with their current price. 

Requirements

Data on screen should update automatically every 5 seconds.
Users should be able to filter the results using a search bar.
The app should be resilient to network issues.
Users should be able to tell when the data is not updating or it cannot be fetched.
Unit tests for business logic.
Use technologies/patterns/libraries that you are most comfortable with.
Project should be available on a public git repository. We should be able to clone it and run it.
You can use this as a list of pairs or choose your own - ?symbols=tBTCUSD,tETHUSD,tCHSB:USD,tLTCUSD,tXRPUSD,tDSHUSD, tRRTUSD,tEOSUSD,tSANUSD,tDATUSD,tSNTUSD,tDOGE:USD,tLUNA:USD,tMATIC:USD,tNEXO:USD,tOCEAN:USD,tBEST:USD, tAAVE:USD,tPLUUSD,tFILUSD

Our tech stack - iOS (You don’t have to use any of these)
Swift.
Reactive programming with RxSwift. MVVM.
Moya/Alamofire
