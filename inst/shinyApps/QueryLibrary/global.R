source("markdownParse.R")

queryFolder = "./queries"
configFilename = "settings.Rds"

mdFiles = list.files(queryFolder, recursive = TRUE, pattern='*.md')
queriesTable<-as.data.frame(t(sapply(1:length(mdFiles), function(x) strsplit(mdFiles, "/")[[x]])))
cdmVersion<-as.data.frame(sapply(1:length(mdFiles), function(x) getVariableFromMarkdown(paste0(queryFolder,'/',mdFiles[x]),"CDM Version")))
author<-as.data.frame(sapply(1:length(mdFiles), function(x) getVariableFromMarkdown(paste0(queryFolder,'/',mdFiles[x]),"Author")))
queriesTable <- cbind(queriesTable,cdmVersion,author)
colnames(queriesTable) <- c("Type","Query", "CDM_version", "Author")

queriesTable <- data.frame(lapply(queriesTable, function(x) {
                    gsub("_", " ", x)
                }))

queriesTable <- data.frame(lapply(queriesTable, function(x) {
  gsub(".md", "", x)
}))

