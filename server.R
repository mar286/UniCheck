#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinythemes)
library(ggplot2)
library(dplyr)
library(DT)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    # Filter data based on selections
    output$table <- DT::renderDataTable(DT::datatable({
        data <- read.csv("IPTA-combined_new.csv")
        if (input$fld != "All") {
            data <- data[data$Field == input$fld,]
        }
        if (input$lct != "All") {
            data <- data[data$Location == input$lct,]
        }

        data
    }))
    
#    output$pricing <- ({
#        renderText(input$prc)
#    })

    output$table2 <- renderDataTable({
        facilities <- read.csv("IPTA-facilities.csv")
    
    
        if (input$uni != "All") {
            facilities <- facilities[facilities$University == input$uni,]
        }
    
        facilities
        
        })
    
    output$desc <- renderUI({
      
      if (input$ranking == "All") {
          all <- "<b>QS World University Rankings</b><br/>"
          all1 <- "Universities are evaluated according to these six metrics:"
          all2 <- "- Academic Reputation (40%)"
          all3 <- "- Employer Reputation (10%)"
          all4 <- "- Faculty/Student Ratio (20%)"
          all5 <- "- Citations per faculty (20%)"
          all6 <- "- International Faculty Ratio (5%)"
          all7 <- "- International Student Ratio (5%)"
          all0 <- "."
          
          HTML(paste(all,all1,all2,all3,all4,all5,all6,all7,all0, sep = '<br/>'))
      }
      
      else if (input$ranking == "Region") {
          rgn <- "<b>QS Asia University Rankings</b><br/>"
          rgn1 <- "There are 11 indicators used to compile the rankings as follows:"
          rgn2 <- "- Academic Reputation (30%)"
          rgn3 <- "- Employer Reputation (20%)"
          rgn4 <- "- Faculty/Student Ratio (10%)"
          rgn5 <- "- International research network (10%)"
          rgn6 <- "- Citations per Paper (10%) and Papers per Faculty (5%)"
          rgn7 <- "- Staff with a PhD (5%)"
          rgn8 <- "- Proportion of International Faculty (2.5%) and Proportion of International Students (2.5%)"
          rgn9 <-  "- Proportion of Inbound Exchange Students (2.5%) and Proportion of Outbound Exchange Students (2.5%)"
          rgn0 <- "."
          
          HTML(paste(rgn,rgn1,rgn2,rgn3,rgn4,rgn5,rgn6,rgn7,rgn8,rgn9,rgn0, sep = '<br/>'))
          
      }
      
    })
  
      
    output$table3 <- renderTable(
      bordered = TRUE,
      width = "100%",
      align = "c",
      {
        
        if (input$ranking == "All") {
          rankAll <- read.csv("Top 5 Uni (QS ranking).csv")
          colnames(rankAll)
          rankAll
        }
        
        else if (input$ranking == "Region") {
          rankRegion <- read.csv("Top 5 Uni by region.csv")
          rankRegion
        }
        
    })
      
    
    output$rankBar <- renderPlot({
      
        if (input$ranking == "All") {
          data <- data.frame(
            University=rep(c("UM","UPM","UKM","USM","UTM"), each = 2),
            Score=c(70.1, 69.8, 52.7, 52.2, 52, 52, 51.9, 51, 44.2, 45.1),
            Year=rep(c("2021", "2022"), 5)
          )
          data$University <- factor(data$University, levels = c("UTM","USM","UKM","UPM","UM"))
          
          ggplot(data, aes(x=University, y=Score, fill=Year)) + 
            geom_bar(position="dodge", stat="identity", width=0.7) +
            coord_flip() +
            labs(
              title = "Scores of Top 5 Malaysian Universities based on QS World University Rankings 2021 and 2022"
            )
        }
        
        else if (input$ranking == "Region") {
          data <- data.frame(
            University=c("UM","UPM","USM","UKM","UTM"),
            Score=c(94.6, 79.8, 75, 74.4, 71.3)
          )
          data <- arrange(data, Score)
          data <- mutate(data, University=factor(University, levels=University))
          
          ggplot(data, aes(x=University, y=Score, fill=as.factor(University))) + 
            geom_bar(stat="identity", width=0.7) +
            scale_fill_brewer(palette = "Set1") +
            theme(legend.position="none") +
            coord_flip() +
            labs(
              title = "Scores of Top 5 Malaysian Universities based on QS Asia University Rankings 2021"
            )
        }
        
    })
    
    output$websites <- renderTable(
      bordered = FALSE,
      colnames = FALSE,
      {
        website <- read.csv("IPTA-website.csv")
        website
    })
    
    


})

