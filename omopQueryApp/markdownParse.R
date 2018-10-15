
getSqlFromMarkdown <- function(filename) {
  markdownLines <- readLines(con <- file(filename))
  close(con)
  
  sqlLines <- character()
  isInSqlSnippet <- FALSE
  for (line in markdownLines) {
    # If line starts with three ticks, it is the start of a snipped
    if (startsWith(line, "```")) {
      isInSqlSnippet <- ! isInSqlSnippet
    } else if (isInSqlSnippet) {
      sqlLines <- c(sqlLines, line)
    }
  }
  return(paste(sqlLines, collapse="\n"))
}

# r <- getSqlFromMarkdown('../md/condition/C07_Find_a_pathogen_by_keyword.md')
# cat(r)