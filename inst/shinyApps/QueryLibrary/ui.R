library(shiny)
library(shinydashboard)
library(shinyFiles)
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
      menuItemCopyDivToClipboard("target", "Copy query to clipboard"),
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
  
  dashboardBody(tabItems(tabItem(
    tabName = "select",
    tabsetPanel(
      tabPanel("Select",
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
        actionButton("executeButton", "Run"),
        box(
          title = "Console",
          width = NULL,
          height = '80%',
          column(width = 6,
                 pre(textOutput(outputId = "target"))),
          column(width = 6,
                 textAreaInput("sqlToRun", NULL, "Add query to execute"))
          
        ),
        
        box(
          title = "Results",
          width = NULL,
          height = '80%',
          DT::dataTableOutput("resultsTable")
        )
      )
    )
    
  ), 
    
    # tabItem(tabName = "execute", h2("Execute the query"),
    #         actionButton("executeButton","Execute Query"),
    #         box(
    #           title = "Console",
    #           width = NULL,
    #           height = '80%',
    #           column(
    #             width=6,
    #             pre(textOutput(outputId = "target"))
    #           ),
    #           column(
    #             width=6,
    #             textAreaInput("sqlToRun", NULL, "Add query to execute")               
    #           )
    # 
    #         ),
    # 
    #         box(
    #           title = "Results",
    #           width = NULL,
    #           height = '80%'#,
    #          # DT::dataTableOutput("resultsTable")
    #         )
    #         ),

    tabItem(tabName = "configuration", h2("Configuration"),
            fluidRow(column(
              width = 6,
              fluidRow(
                column(
                  width = 1,
                  shinyFilesButton("loadConfig", "Load", "Select Configuration file", multiple = FALSE)
                ),
                column(
                  width = 1,
                  shinySaveButton("saveConfig", "Save", "Save file as...", filename = configFilename, filetype = list(settings = "Rds"))
                ),
                column(width = 10,textOutput("loaded"),
                       textOutput("saved"))
              )
              )
            ),
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
                textInput("password", NULL),
                
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