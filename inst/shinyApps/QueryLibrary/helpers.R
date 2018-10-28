executeQuery <- function(sql,connectionDetails,targetDialect) {
   con <- DatabaseConnector::connect(connectionDetails)
   sql <- SqlRender::translateSql(sql,targetDialect = targetDialect)$sql
   results <- DatabaseConnector::querySql(con,sql = sql)
   disconnect(con)
   return(results)
}

getParameters <- function(sql) {
  params <- regmatches(sql, gregexpr("@[a-zA-Z0-9_]+", sql))[[1]]
  params <- unique(params)
  params <- params[order(params)]
  params <- substr(params, 2, nchar(params))
  return(params)
}

