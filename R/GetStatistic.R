GetStatistic <-
statistic <-
function (statistic, period = "LifeToDate", count = NULL, response.group = NULL, 
    keypair = credentials(), print = getOption('MTurkR.print'),
    browser = getOption('MTurkR.browser'), log.requests = getOption('MTurkR.log'), 
    sandbox = getOption('MTurkR.sandbox'), validation.test = getOption('MTurkR.test')) {
    if(!is.null(keypair)) {
        keyid <- keypair[1]
        secret <- keypair[2]
    }
    else
        stop("No keypair provided or 'credentials' object not stored")
    operation <- "GetRequesterStatistic"
    value.long <- c("NumberAssignmentsAvailable", "NumberAssignmentsAccepted", 
        "NumberAssignmentsPending", "NumberAssignmentsApproved", 
        "NumberAssignmentsRejected", "NumberAssignmentsReturned", 
        "NumberAssignmentsAbandoned", "NumberHITsCreated", "NumberHITsCompleted", 
        "NumberHITsAssignable", "NumberHITsReviewable")
    value.double <- c("PercentAssignmentsApproved", "PercentAssignmentsRejected", 
        "TotalRewardPayout", "AverageRewardAmount", "TotalRewardFeePayout", 
        "TotalFeePayout", "TotalRewardAndFeePayout", "TotalBonusPayout", 
        "TotalBonusFeePayout", "EstimatedRewardLiability", "EstimatedFeeLiability", 
        "EstimatedTotalLiability")
    if(!statistic %in% value.long & !statistic %in% value.double) 
        stop("Statistic not valid")
    if(!period %in% c("OneDay", "SevenDays", "ThirtyDays", "LifeToDate")) 
        stop("Period not valid")
    GETparameters <- paste("&Statistic=", statistic, "&TimePeriod=", 
        period, sep = "")
    if(!is.null(count)) {
        if(is.na(as.numeric(count))) 
            stop("Count must be numeric or coercible to numeric")
        else
            GETparameters <- paste(GETparameters, "&Count=", count, sep = "")
    }
    auth <- authenticate(operation, secret)
    if(browser == TRUE) {
        request <- request(keyid, auth$operation, auth$signature, 
            auth$timestamp, GETparameters, browser = browser, 
            sandbox = sandbox, validation.test = validation.test)
		if(validation.test)
			invisible(request)
    }
    else {
        request <- request(keyid, auth$operation, auth$signature, 
            auth$timestamp, GETparameters, log.requests = log.requests, 
            sandbox = sandbox, validation.test = validation.test)
		if(validation.test)
			invisible(request)
        request$statistic <- statistic
        request$period <- period
        if(request$valid == TRUE) {
            if(!is.null(count) & period == "OneDay") {
                request$value <- setNames(data.frame(matrix(nrow = count, ncol = 2)),
                                        c("Date", "Value"))
                for (i in 1:count) {
                    request$value[i, 1] <- strsplit(strsplit(request$xml, 
                        "<Date>")[[1]][2], "</Date>")[[1]][1]
                    if(statistic %in% value.long) 
                        request$value[i, 2] <- strsplit(strsplit(request$xml, 
                        "<LongValue>")[[1]][2], "</LongValue>")[[1]][1]
                    else if(statistic %in% value.double) 
                        request$value[i, 2] <- strsplit(strsplit(request$xml, 
                        "<DoubleValue>")[[1]][2], "</DoubleValue>")[[1]][1]
                    else
                        warning("Cannot print statistic value")
                }
                if(print == TRUE) {
                    message("Statistic (", statistic, ", past ", count, 
                        " days) Retrieved: ", request$value)
                }
            }
            else {
                request$date <- strsplit(strsplit(request$xml, 
                    "<Date>")[[1]][2], "</Date>")[[1]][1]
                if(statistic %in% value.long) 
                    request$value <- strsplit(strsplit(request$xml, 
                    "<LongValue>")[[1]][2], "</LongValue>")[[1]][1]
                else if(statistic %in% value.double) 
                    request$value <- strsplit(strsplit(request$xml, 
                    "<DoubleValue>")[[1]][2], "</DoubleValue>")[[1]][1]
                if(print == TRUE) 
                    message(statistic, " (", period, "): ", request$value)
            }
            invisible(request$value)
        }
        else if(request$valid == FALSE) {
            if(print == TRUE) 
                warning("Invalid Request")
            invisible(NA)
        }
    }
}
