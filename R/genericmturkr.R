genericmturkr <-
function (operation, parameters = NULL, keypair = credentials(), 
    print = TRUE, browser = FALSE, log.requests = TRUE, sandbox = FALSE, 
    xml.parse = TRUE, validation.test = FALSE)
{
    if (!is.null(keypair)) {
        keyid <- keypair[1]
        secret <- keypair[2]
    }
    else
        stop("No keypair provided or 'credentials' object not stored")
    operation <- operation
    auth <- authenticate(operation, secret)
    GETparameters <- parameters
    if (browser == TRUE) {
		request <- request(keyid, auth$operation, auth$signature, 
			auth$timestamp, GETparameters, browser = browser, log.requests = log.requests, 
			sandbox = sandbox, xml.parse = xml.parse, validation.test = validation.test)
		if(validation.test)
			invisible(request)
	}
	else{
		request <- request(keyid, auth$operation, auth$signature, 
			auth$timestamp, GETparameters, browser = browser, log.requests = log.requests, 
			sandbox = sandbox, xml.parse = xml.parse, validation.test = validation.test)
		if(validation.test)
			invisible(request)
		if (request$valid == TRUE & print == TRUE) {
			message("Operation (", operation, ") Successful")
			return(request)
		}
		else if (request$valid == FALSE & print == TRUE) {
			warning("Invalid Request")
			return(request)
		}
		else
			invisible(request)
	}
}