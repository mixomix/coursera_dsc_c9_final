#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library("shiny")
library("TTR")
library("lubridate")
library("ggplot2")
library("reshape2")

data("EuStockMarkets")

EuStockMarkets <- cbind(as.data.frame(time(EuStockMarkets)),as.data.frame(EuStockMarkets))
EuStockMarkets$x <- format(date_decimal(as.numeric(EuStockMarkets$x)), "%d-%m-%Y")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$distPlot <- renderPlot({
    
    # prepare columns of MAs
    my_MAlist <- data.frame(row.names = 1:nrow(EuStockMarkets))
      
    #if we have to show MA calculate it
    if (input$show_MA & !is.null(input$MA_index_name)) {
      
      #cycle through all MAs to be counted
      for (single_op in input$MA_index_name) {
        
        #compute it
        my_MA <- SMA(x = EuStockMarkets[,single_op], n = input$MA_range)
        
        #add it to output list of MAs
        my_MAlist[,paste("MA of ",single_op)] <- my_MA
        
      }
      
      #include calculated MAs in output
      show_option <- unique(c(input$index_show, input$MA_index_name))
    }
    else {
      show_option <- c(input$index_show)
    }
    
    # data to plot
    plot_data <- cbind(EuStockMarkets[,1], EuStockMarkets[, show_option], my_MAlist)
    
    gd <- melt(plot_data)
    names(gd) <- c("Date","Index","Value")
    
    g <- ggplot(gd, aes(x = as.Date(Date, "%d-%m-%Y"), y = Value, color = Index)) +
      geom_line() +
      scale_x_date() +
      labs(x = "Date", y = "Closing Price") +
      theme_bw()
    
    print(g)
    
  })
  
})
