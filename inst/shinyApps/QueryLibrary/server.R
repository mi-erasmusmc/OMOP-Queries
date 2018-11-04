library(shiny)
library(shinydashboard)
library(shinyjs)
library(shinyalert)
library(SqlRender)
library(DatabaseConnector)
library(DT)
source("global.R")
source("widgets.R")
source("helpers.R")
source("markdownParse.R")

server <- shinyServer(function(input, output, session) {
  query <- reactiveValues()
  
  query$saved <- FALSE
  
  query$name <- reactive({toString(queriesTable$Query[input$queriesTable_rows_selected])})
  
  query$inputFileName <- reactive({paste0(queryFolder, "/",mdFiles[input$queriesTable_rows_selected])})
  
  query$sqlSource <- reactive({getSqlFromMarkdown(query$inputFileName())})
  
  query$parameters <- reactive({getParameters(query$sqlSource())})
  
  query$sqlTarget <- reactive({
    parameterValues <- list()
    for (param in query$parameters()) {
      value <- input[[param]]
      if (!is.null(value)) {
        parameterValues[[param]] <- value
      }
    }
    sql <- do.call("renderSql", append(query$sqlSource(), parameterValues))$sql
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
  
  renderedFilename <- reactive({createRenderedHtml(query$inputFileName(),query$sqlTarget())})
  
  output$html <- renderText({
    includeHTML(renderedFilename())
  })
  
  output$parameterInputs <- renderUI({
    params <- query$parameters()
    sql <- query$sqlSource()
    
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
  
  ### TABLES
  
  output$queriesTable <- renderDT({
    table = queriesTable
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
    lengthMenu = c(10, 50, 75, 100),
    searchHighlight = TRUE,
    dom = 'Blfrtip',
    buttons = I('colvis'),
    processing=FALSE
  ))
  
  # obsolete (does not work to have two DTtables in a the app?)
  output$resultsTable <- renderDataTable(
  query$data,
  server = FALSE,
  caption =
    "Table 2: Query results"
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
  
  output$testTable <- renderTable({query$data})
  
  # Load the app configuration settings
  shinyFileChoose(input, "loadConfig", roots = volumes, session = session)
  
  output$loaded <- renderText({
    if (length(parseFilePaths(roots=volumes,input$loadConfig)$datapath)>0) {
      configFilename = parseFilePaths(roots=volumes, input$loadConfig)$datapath
      if(!file.exists(configFilename)) {return(NULL)}
      
      savedInputs <- readRDS(configFilename)
      
      inputIDs      <- names(savedInputs) 
      inputvalues   <- unlist(savedInputs) 
      for (i in 1:length(savedInputs)) { 
        session$sendInputMessage(inputIDs[i],  list(value=inputvalues[[i]]) )
      }
      return (configFilename)
    } else invisible({NULL})
  })
  
  # save the app configuration settings
  volumes <- c(Home = fs::path_home(), "R Installation" = R.home(), getVolumes()())
  shinyFileSave(input, "saveConfig", roots = volumes, session = session, restrictions = system.file(package = "base"))
  
  output$saved<- renderPrint({
    if (length(parseSavePath(roots=volumes,input$saveConfig)$datapath)>0) {
      configFilename = parseSavePath(roots=volumes,input$saveConfig)$datapath
      saveRDS(isolate(reactiveValuesToList(input))[c("dialect","server","user","password","port","cdm","vocab","oracleTempSchema","extraSettings")], 
              file = configFilename)
      return(cat("saved"))
    } else invisible({NULL})
    })
  
  
  ### BUTTONS
  
  observeEvent(input$importButton,{
    updateTextAreaInput(session, "target", value = query$sqlTarget())
  })
  
  observeEvent(input$executeButton, {
    connectionDetails <- createConnectionDetails(dbms = tolower(input$dialect),
                                                 user = input$user,
                                                 password = input$password,
                                                 server = input$server,
                                                 port = input$port,
                                                 extraSettings = input$extraSettings)
    con <-DatabaseConnector::connect(connectionDetails)
    
    sql <- input$target
    results <- DatabaseConnector::querySql(con,sql)
    disconnect(con)
    #return(as.data.frame(results))
    # Fill in the reactiveValues to tricker table update
    query$sql <- sql
    query$data <- results
  }, ignoreNULL = TRUE)
  
  observeEvent(input$copyClipboardButton, {
    script <- "
            element = $('<textarea>').appendTo('body').val(document.getElementById('target').value).select();
            document.execCommand('copy');
            element.remove();
    "
    runjs("var today = new Date(); alert(today);")
    runjs("
            var element = $('<textarea>').appendTo('body').val(document.getElementById('target').value).select();
            document.execCommand('copy');
            element.remove();
    ")
  })
  
  
  observe({
    toggleState("executeButton", !is.null(input$target) && input$target != "")
  })
 
  observe({
    toggleState("copyClipboardButton", !is.null(input$target) && input$target != "")
  }) 
  
  observe({
    toggleState("saveToFileButton", !is.null(input$target) && input$target != "")
  })

  ## OTHER
  
  
  output$save <- downloadHandler(
    filename = function() {
      paste('query-', Sys.Date(), '.sql', sep='')
    },
    content = function(con) {
      SqlRender::writeSql(sql =  query$sqlTarget(), targetFile = con)
    }
  )
  
  
  output$connected <- eventReactive(input$testButton, {
    connectionDetails <- createConnectionDetails(dbms = tolower(input$dialect),
                                                 user = input$user,
                                                 password = input$password,
                                                 server = input$server,
                                                 port = input$port,
                                                 extraSettings = input$extraSettings)
    con <-DatabaseConnector::connect(connectionDetails)
    if (length(con)>0) {
      disconnect(con)
      return ("Connection Successful")
    } else
      return ("Not Connected")
    
  }, ignoreNULL = TRUE)
  
})