# Remote Authentication Use Case

> ## Success Case
1. ✅ System validates the data
2. ✅ System creates a request to the login api url
3. System validates the data received from the api
4. System delivers the user account data

> ## Exception - Invalid Url
1. ✅ System returns the "unexpected error message"

> ## Exception - Invalid Data
1. ✅ System returns the "unexpected error message"

> ## Exception - Invalid Response
1. System returns the "unexpected error message"

> ## Exception - Internal Server Error
1. System returns the "unexpected error message"

> ## Exception - Invalid Credentials
1. System returns an error message informing that the credentials are incorrect