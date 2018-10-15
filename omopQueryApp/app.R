library(shiny)
library(shinydashboard)
library(SqlRender)
source("widgets.R")
source("markdownParse.R")

ui <- dashboardPage(
  dashboardHeader(title = "OMOP Queries"),
  
  dashboardSidebar(
    sidebarMenu(
      menuItemCopyDivToClipboard("target", "Copy query to clipboard"),
      menuItemDownloadLink("save", "Save query to file")
    )
  ),
  
  dashboardBody(
    fluidRow(
      column(width = 9,
             selectInput(
               inputId = 'selectedFileName',
               label = 'Select File',
               choice = list.files('../', recursive = TRUE, pattern='*.md')
             )
      )
    ),
    fluidRow(
      column(width = 8, 
             box(
               # title = "Description",
               width = NULL,
               status = "primary",
               uiOutput(outputId = "markdown")
             )
        ),
      column(width = 4,
             box(
               title = "Sql Render translation", 
               width = NULL,
               pre(textOutput(outputId = "target"))
             ),
             box(background = "light-blue",
                 h4("Target dialect"), width = NULL,
                 selectInput("dialect", NULL, choices = c("BigQuery", "Impala", "Netezza", "Oracle", "PDW", "PostgreSQL", "RedShift", "SQL Server" ), selected = "SQL Server"),
                 
                 h4("Oracle temp schema"),
                 textInput("oracleTempSchema", NULL),
                 
                 h4("Parameters"),
                 uiOutput("parameterInputs"),
                 
                 textOutput("warnings")
             )
          )
        )
  )
)

server <- shinyServer(function(input, output, session) {
  
  inputFileName <- reactive({paste0("../", input$selectedFileName)})
  
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

  output$markdown <- renderUI({
    includeMarkdown(inputFileName())
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
})

# Run the application 
shinyApp(ui = ui, server = server)
