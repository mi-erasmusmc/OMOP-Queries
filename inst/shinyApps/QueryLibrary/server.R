library(shiny)
library(shinydashboard)
library(SqlRender)
library(DT)
source("global.R")
source("widgets.R")
source("markdownParse.R")

server <- shinyServer(function(input, output, session) {
  
  inputFileName <- reactive({paste0(queryFolder, "/",mdFiles[input$queriesTable_rows_selected])})
  
  sourceSql <- reactive({getSqlFromMarkdown(inputFileName())})
  
  parameters <- reactive({
    sql <- sourceSql()
    params <- regmatches(sql, gregexpr("@[a-zA-Z0-9_]+", sql))[[1]]
    params <- unique(params)
    params <- params[order(params)]
    params <- substr(params, 2, nchar(params))
    return(params)
  })
  
  targetSql <- reactive({
    parameterValues <- list()
    for (param in parameters()) {
      value <- input[[param]]
      if (!is.null(value)) {
        parameterValues[[param]] <- value
      }
    }
    sql <- do.call("renderSql", append(sourceSql(), parameterValues))$sql
    warningString <- c()
    handleWarning <- function(e) {
      output$warnings <- e$message
    }
    oracleTempSchema <- input$oracleTempSchema
    if (oracleTempSchema == "")
      oracleTempSchema <- NULL
    sql <- withCallingHandlers(suppressWarnings(translateSql(sql, targetDialect = tolower(input$dialect), oracleTempSchema = oracleTempSchema)$sql), warning = handleWarning)
    if (!is.null(warningString))
      output$warnings <- warningString
    return(sql)
  })
  
  renderedFilename <- reactive({createRenderedHtml(inputFileName(),targetSql())})
  
  output$html <- renderText({
    includeHTML(renderedFilename())
  })
  
  output$target <- renderText({
    targetSql()
  })
  
  output$parameterInputs <- renderUI({
    params <- parameters()
    sql <- sourceSql()
    
    createRow <- function(param, sql) {
      # Get current values if already exists:
      value <- isolate(input[[param]])
      
      if (is.null(value)) {
        # Get default values:
        value <- regmatches(sql, regexpr(paste0("\\{\\s*DEFAULT\\s*@", param, "\\s=[^}]+}"), sql))
        if (length(value) == 1) {
          value = sub(paste0("\\{\\s*DEFAULT\\s*@", param, "\\s=\\s*"), "", sub("\\}$", "", value)) 
        } else {
          value = ""
        }
      }
      textInput(param, param, value = value)
    }
    lapply(params, createRow, sql = sql)
  })
  
  output$save <- downloadHandler(
    filename = function() {
      paste('query-', Sys.Date(), '.sql', sep='')
    },
    content = function(con) {
      SqlRender::writeSql(sql = targetSql(), targetFile = con)
    }
  )
  
  output$queriesTable <- renderDT({
    table <- queriesTable
    selected <- input$perAggregateKey_rows_selected
    if (!is.null(selected)) {
      keys <- keyToRows()[, 1]
      table <- table[table[, input$aggregateKey] == keys[selected], ]
    }
    return(table)
  },
  server = FALSE,
  caption =
    "Table 1: OMOP-CDM V5 Queries"
  ,
  filter = list(position = 'top'),
  extensions = 'Buttons',
  rowname = FALSE,
  selection = 'single',
  options = list(
    autoWidth = FALSE,
    lengthMenu = c(25, 50, 75, 100),
    searchHighlight = TRUE,
    dom = 'Blfrtip',
    buttons = I('colvis'),
    processing=FALSE
  ))
  
})