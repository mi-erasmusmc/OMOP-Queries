library(shiny)
library(shinydashboard)
library(shinyFiles)
library(shinyjs)
library(shinycssloaders)
library(SqlRender)
library(DT)
source("global.R")
source("widgets.R")
source("markdownParse.R")

ui <- dashboardPage(
  dashboardHeader(title = "Query Library"),
  
  dashboardSidebar(
    sidebarMenu(
      menuItem("Home", tabName = "select", icon = icon("home")),
      menuItemCopyTextAreaToClipboard("target", "Copy query to clipboard"),
      menuItemDownloadLink("save", "Save query to file"),
      menuItem("Configuration", tabName = "configuration", icon = icon("cog")),
      menuItem("Feedback", icon = icon("comment"), href = "https://github.com/mi-erasmusmc/OMOP-Queries/issues")
    ),
    tags$footer(
      align = "right",
      style = "
      position:absolute;
      bottom:0;
      width:100%;
      height:175px;
      color: black;
      padding: 10px;
      text-align:center;
      background-color: #eee;
      z-index: 1000;",
      HTML(
        "<a href=\"https://www.apache.org/licenses/LICENSE-2.0\">Apache 2.0</a>
        <div style=\"margin-bottom:10px;\">open source software</div>
        <div>provided by</div>
        <div><a href=\"http://www.ohdsi.org\"><img src=\"images/ohdsi_color.png\" height=42 width = 100></a></div>
        <div><a href=\"http://www.ohdsi.org\">join the journey</a> </div>
        <div>"
      )
      )
    ),
  
  dashboardBody(
    useShinyjs(),
    tabItems(tabItem(
    tabName = "select",
    tabsetPanel(tabPanel("Select",
                         h2("Select a query"),
                         fluidRow(
                           column(
                             label = 'selectedQuery',
                             width = 6,
                             offset = 0,
                             DTOutput("queriesTable")
                           ),
                           column(
                             width = 6,
                             box(
                               title = "Query Description",
                               width = NULL,
                               status = "primary",
                               uiOutput(outputId = "html")
                             )
                           )
                         )),
                tabPanel(
                  "Execute",
                  box(
                    title = "Execute",
                    width = NULL,
                    height = '80%',
                    actionButton("importButton", "Import selected query", icon = icon("home")),
                    textAreaInput("target", NULL, ""),
                    actionButton("executeButton", "Run", icon = icon("play")),
                    actionButton(
                      "copyClipboardButton",
                      "Copy to clipboard",
                      icon = icon("file-text-o")
                    ),
                    actionButton("saveToFileButton", "Save query to file", icon = icon("floppy-o"))
                  ),
                  ### show timer
                  conditionalPanel("updateBusy() || $('html').hasClass('shiny-busy')",
                                   id='progressIndicator',
                                   "Running Query",
                                   div(id='progress',includeHTML("timer.js"))
                  ),
                  tags$head(tags$style(type="text/css",
                                       '#progressIndicator {',
                                      # '  position: fixed; top: 120px; right: 80px; width: 170px; height: 60px;',
                                       '  padding: 8px; border: 1px solid #CCC; border-radius: 8px; color:green',
                                       '}'
                  )),
                  
                  box(
                    title = "Results",
                    width = NULL,
                    height = '80%',
                    withSpinner(tableOutput("testTable"))
                  )
                
                  
                  
                ))
    
  ), 
    tabItem(tabName = "configuration", h2("Configuration"),
            shinyFilesButton("loadConfig", "Load", "Select Configuration file", multiple = FALSE),
            shinySaveButton("saveConfig", "Save", "Save file as...", filename = configFilename, filetype = list(settings = "Rds")),
            fluidRow(offset = 5, column(
              width = 6,
              box(
                background = "light-blue",
                h4("Target dialect"),
                width = NULL,
                selectInput(
                  "dialect",
                  NULL,
                  choices = c(
                    "BigQuery",
                    "Impala",
                    "Netezza",
                    "Oracle",
                    "PDW",
                    "PostgreSQL",
                    "RedShift",
                    "SQL Server"
                  ),
                  selected = "SQL Server"
                ),
                
                h4("server"),
                textInput("server", NULL),
                
                h4("username"),
                textInput("user", NULL),
                
                h4("password"),
                passwordInput("password", NULL),
                
                h4("port"),
                textInput("port", NULL, value = 1521),
                
                h4("cdm schema"),
                textInput("cdm", "Schema containing the clinical data tables", value =
                            "cdm"),
                
                h4("vocabulary schema"),
                textInput("vocab", "Schema containig the vocabulary", value =
                            "cdm"),
                
                h4("Oracle temp schema"),
                textInput("oracleTempSchema", NULL),
                
                h4("Extra Setting"),
                textInput("extraSettings", NULL),
                
                actionButton("testButton","Test Connection")
                
                #h4("Parameters"),
                #uiOutput("parameterInputs"),
 
              ),
              textOutput("connected"),
              textOutput("warnings")
            )
            ))
  ))
)