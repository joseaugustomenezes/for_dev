# HTTP

> ## Success
1. Request with valid http verb (post)
2. content type set as JSON on headers
3. Ok - 200 and response with data
4. No content - 204 and response without data

> ## Errors
1. Bad request - 400
2. Unauthorized - 401
3. Forbidden - 403
4. Not found - 404
5. Internal server error - 500

> ## Exception - Status code different from the mentioned above
1. Internal server error - 500

> ## Exception - Http request thrown a unexpected exception
1. Internal server error - 500

> ## Exception - Invalid http verb
1. Internal server error - 500