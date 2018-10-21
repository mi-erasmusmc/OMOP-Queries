queryFolder = "./queries"

mdFiles = list.files(queryFolder, recursive = TRUE, pattern='*.md')
queriesTable<-as.data.frame(t(sapply(1:length(mdFiles), function(x) strsplit(mdFiles, "/")[[x]])))
colnames(queriesTable) <- c("Type","Query")

queriesTable <- data.frame(lapply(queriesTable, function(x) {
                    gsub("_", " ", x)
                }))

queriesTable <- data.frame(lapply(queriesTable, function(x) {
  gsub(".md", "", x)
}))

