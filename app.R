#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a plot
ui <- fluidPage(
  # Application title
  titlePanel("SAFE-Q Visualisation of Outputs: Demo"),
  em("Disclaimer: For demonstration purposes only, underlying data is randomly generated."),
  p(" "),
  
  sidebarLayout(
    sidebarPanel(
      p("Select factor from the left panel to see its impact on the amount of food waste."),
  selectInput(inputId = "var", "Factor Affecting Food Waste:",
              c("Surplus Food" = "Surplus",
                "Portion Size" = "PortionSize",
                "Open Buffet" = "OpenBuffet",
                "Buying Behaviour" = "BuyingBehaviour",
                "Break in the Cold Chain" = "BreakColdChain",
                "Retailer Discounts and Promotions" = "Retailerprices",
                "Socio-economic Status" = "Socioeconomicstatus",
                "Cost of Food" = "Costoffood",
                "Package Size" = "Packagesize",
                "Appearance of Product" = "Appearanceofaproduct",
                "Demand Planning" = "DemandPlanning",
                "Shelf Life" = "ShelfLife",
                "Food Product Type" = "FoodProductType",
                "Storage Conditions" = "StorageRefCond"
                ))),
  mainPanel(plotOutput("foodwastePlot")
)
)
)

# Define server logic required to draw a plot
server <- function(input, output) {
  
   data<-read.csv(file="SampleSimulationOutput.csv")
   str(data)
   head(data)
   summary(data$AmountFoodWaste)
   data$AmountFoodWaste <- factor(data$AmountFoodWaste, levels = c("Low", "Medium", "High") )
   data$Socioeconomicstatus <- factor(data$Socioeconomicstatus, levels = c("Low", "Medium", "High") )
   data$Packagesize <- factor(data$Packagesize, levels = c("Singleitems", "Multipack") )
   data$FoodProductType <- factor(data$FoodProductType, levels = c("Fresh", "Frozen", "Dry") )
   data$StorageRefCond <- factor(data$StorageRefCond, levels = c("Inadequate", "Adequate") )
  output$foodwastePlot <- renderPlot({
    plot(AmountFoodWaste~get(input$var), data = data, xlab = "States of the Factor Affecting Food Waste", main = "Probability of Food Waste", ylab = "Amount of Food Waste", col=c("gray90", "maroon", "seashell"))
  })
}


# Run the application 
shinyApp(ui = ui, server = server)

