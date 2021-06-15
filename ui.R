#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinythemes)
library(ggplot2)
library(DT)

#Import Data
data <- read.csv("IPTA-combined_new.csv")
website <- read.csv("IPTA-website.csv")
facilities <- read.csv("IPTA-facilities.csv")

shinyUI(fluidPage(
    
    navbarPage("UniCheck", theme = shinytheme("united"),
               tabPanel("Program Finder", fluid = TRUE, icon = icon("globe"),
                        
                        # Sidebar layout with a input and output definitions
                        sidebarLayout(
                            sidebarPanel(
                                
                                titlePanel("Desired Program Characteristics"),
                                selectInput("fld",
                                            "Field:",
                                            c("All",
                                            unique(as.character(data$Field)))),
                                
                                selectInput("lct",
                                            "Location:",
                                            c("All",
                                            unique(as.character(data$Location)))),
                                
                                ),
               
                            # Show a table
                            mainPanel(
                                DT::dataTableOutput("table")
                            #    textOutput("pricing")
                                )
                            )
                ),
               
               tabPanel("Facilities", icon = icon("archway"),
                        sidebarLayout(
                          sidebarPanel(
                            
                            titlePanel("Available Facilities in Each University"),
                            selectInput("uni",
                                        "Select University:",
                                        c("All",
                                          unique(as.character(facilities$University))))
                         ),
             
                        mainPanel(
                            DT::dataTableOutput("table2")
                          )
                        )
                ),
                      
                tabPanel("Statistics", icon = icon("chart-bar"),
                         sidebarLayout(
                           sidebarPanel(
                             
                             titlePanel("QS University Rankings"),
                             selectInput("ranking",
                                         "Ranking by:",
                                         c("All",
                                           "Region"))
                           ),
                           
                           mainPanel(
                             htmlOutput("desc"),
                             tableOutput("table3"),
                             plotOutput("rankBar")
                           )
                         )
                ),    
                 
      
               tabPanel("Info", icon = icon("info-circle"),
                                   fluidRow(
                                       column(6,
                                              h2(tags$b("About UniCheck")),
                                              br(),
                                              h5(p("This application is intended to facilitate useful comparisons between public universities in Malaysia based on the field of study, range of tuition fees and location.  Future undergraduate students or anyone interested can search for the univiersities fitting a particular set of criteria relevant to them.")),
                                              h5(p("The project began as our course assignment to create a data product which will be beneficial to others with the need to practice R, a programming language used primarily for analysing and reporting data.")),
                                              h5(p("We hope you find it useful to guide you in choosing the best university for yourself.")),
                                              br(),
                                              h3(tags$b("Click on the following logo to directly go to the official website of university :")),
                                              h5(tags$a(
                                                href="https://www.umk.edu.my/", 
                                                tags$img(src="umk.png", 
                                                         title="University Malaysia Kelantan", 
                                                         width="300",
                                                         height="200")),
                                              ),
                                              h5(tags$a(
                                                href="https://www.ump.edu.my/", 
                                                tags$img(src="ump.png", 
                                                         title="Universiti Malaysia Pahang", 
                                                         width="300",
                                                         height="150")),
                                              ),
                                              h5(tags$a(
                                                href="www.unimap.edu.my/", 
                                                tags$img(src="unimap.png", 
                                                         title="Universiti Malaysia Perlis", 
                                                         width="300",
                                                         height="200")),
                                              ),
                                              h5(tags$a(
                                                href="https://www.unimas.my/", 
                                                tags$img(src="unimas.png", 
                                                         title="Universiti Malaysia Sarawak", 
                                                         width="300",
                                                         height="150")),
                                              ),
                                              h5(tags$a(
                                                href="https://www.ums.edu.my/", 
                                                tags$img(src="ums.png", 
                                                         title="Universiti Malaysia Sabah", 
                                                         width="300",
                                                         height="280")),
                                              ),
                                              h5(tags$a(
                                                href="https://www.upm.edu.my/", 
                                                tags$img(src="upm.png", 
                                                         title="Universiti Putra Malaysia", 
                                                         width="300",
                                                         height="200")),
                                              ),
                                              h5(tags$a(
                                                href="https://www.unisza.edu.my/", 
                                                tags$img(src="unisza.png", 
                                                         title="Universiti Sultan Zainal Abidin", 
                                                         width="300",
                                                         height="150")),
                                              ),
                                              h5(tags$a(
                                                href="https://www.utem.edu.my/", 
                                                tags$img(src="utem.png", 
                                                         title="Universiti Teknikal Malaysia Melaka", 
                                                         width="300",
                                                         height="170")),
                                              ),
                                              h5(tags$a(
                                                href="https://www.uum.edu.my/", 
                                                tags$img(src="uum.png",
                                                         title="Universiti Utara Malaysia", 
                                                         width="300",
                                                         height="130")),
                                              ),
                                              h5(tags$a(
                                                href="https://www.umt.edu.my/", 
                                                tags$img(src="umt.png", 
                                                         title="Universiti Malaysia Terengganu", 
                                                         width="300",
                                                         height="200")),
                                              ),
                                              h5(tags$a(
                                                href="https://www.usm.my/", 
                                                tags$img(src="usm.png", 
                                                         title="Universiti Sains Malaysia", 
                                                         width="300",
                                                         height="130")),
                                              ),
                                              h5(tags$a(
                                                href="https://www.ukm.my/", 
                                                tags$img(src="ukm.png", 
                                                         title="Universiti Kebangsaan Malaysia", 
                                                         width="300",
                                                         height="150")),
                                              ),
                                              h5(tags$a(
                                                href="https://www.utm.my/", 
                                                tags$img(src="utm.png", 
                                                         title="Universiti Teknologi Malaysia", 
                                                         width="300",
                                                         height="100")),
                                              ),
                                              h5(tags$a(
                                                href="https://www.uthm.edu.my/", 
                                                tags$img(src="uthm.png", 
                                                         title="Universiti Tun Hussein Onn", 
                                                         width="300",
                                                         height="100")),
                                              ),
                                              h5(tags$a(
                                                href="https://www.uitm.edu.my/", 
                                                tags$img(src="uitm.png", 
                                                         title="Universiti Teknologi Mara", 
                                                         width="300",
                                                         height="120")),
                                              ),
                                              h5(tags$a(
                                                href="https://www.um.edu.my/", 
                                                tags$img(src="um.png", 
                                                         title="Universiti Malaya", 
                                                         width="300",
                                                         height="150")),
                                              ),
                                              h5(tags$a(
                                                href="https://www.usim.edu.my/", 
                                                tags$img(src="usim.png", 
                                                         title="Universiti Sains Islam Malaysia", 
                                                         width="300",
                                                         height="300")),
                                              ),
                                              h5(tags$a(
                                                href="https://www.upsi.edu.my/", 
                                                tags$img(src="upsi.png", 
                                                         title="Universiti Pendidikan Sultan Idris", 
                                                         width="300",
                                                         height="150")),
                                              ),
                                              h5(tags$a(
                                                href="https://www.iium.edu.my/", 
                                                tags$img(src="uiam.png", 
                                                         title="Universiti Islam Antarabangsa Malaysia", 
                                                         width="300",
                                                         height="120")),
                                              ),
                                              h5(tags$a(
                                                href="https://www.upnm.edu.my/", 
                                                tags$img(src="upnm.png", 
                                                         title="Universiti Pertahanan Nasional Malaysia", 
                                                         width="300",
                                                         height="120")),
                                              ),
                                              
                                            
                                              
                                       ),
                                       column(6,
                                              h2(tags$b("How To")),
                                              br(),
                                              h5(p("In Program Finder, user can search for their desired program simply by selecting the preferred field of study and the location of the university (either West or East Malaysia).")),
                                              h5(p("If user click on the Facilities tab, they can survey some facilities that are provided by each university.")),
                                              h5(p("The Statistics tab displays the ranking of these public universities based on QS World University Rankings.
                                                   User can choose to view the overall ranking or ranking by region.")),
                                              br(),
                                              h5(tags$b("For more information, please visit the official website of the university.")),
                                              
                                           
                                              
                                      mainPanel(
                                          
                                                tableOutput("websites")
                                              )
                                              
                                       )
                                       
                                       
                                      
                                       )
                                   )
                          )
               
                )

)

    
