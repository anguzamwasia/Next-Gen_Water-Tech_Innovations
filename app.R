library(shiny)
library(leaflet)
library(ggplot2)
library(shinyjs)

ui <- fluidPage(
  useShinyjs(),  # Initialize shinyjs
  
  tags$head(
    tags$style(HTML("
      .hero { 
        text-align: center; 
        padding: 150px 50px; 
        background: url('https://images.unsplash.com/photo-1495774539583-885e02cca8c2?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8d2F0ZXJ8ZW58MHx8MHx8fDA%3D') no-repeat center center; 
        background-size: cover; 
        color: white;
        height: 100vh;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        font-family: 'Arial', sans-serif;
      }
      h1, h2 {
        font-size: 3em;
        font-weight: bold;
      }
      p {
        font-size: 1.5em;
        max-width: 600px;
        margin: 20px auto;
      }
      .donate-section {
        max-width: 600px;
        margin: 0 auto;
        text-align: center;
      }
      .join-button {
        background-color: #28a745;
        color: white;
        padding: 10px 20px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
      }
      .join-button:hover {
        background-color: #218838;
      }
      .project-section {
        margin-top: 50px;
      }
      .project {
        margin-bottom: 40px;
      }
      .project-img {
        max-width: 100%;
        height: auto;
        margin-top: 20px;
      }
      .form-popup {
        display: none;
        position: fixed;
        left: 50%;
        top: 50%;
        transform: translate(-50%, -50%);
        background: white;
        padding: 20px;
        border-radius: 5px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
        z-index: 1000;
      }
      .form-popup input,
      .form-popup textarea {
        width: 100%;
        margin-bottom: 10px;
      }
      .form-popup button {
        background-color: #007BFF;
        color: white;
        border: none;
        padding: 10px;
        border-radius: 5px;
        cursor: pointer;
      }
      .form-popup button:hover {
        background-color: #0056b3;
      }
      .overlay {
        display: none;
        position: fixed;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        background: rgba(0, 0, 0, 0.5);
        z-index: 999;
      }
    "))
  ),
  
  navbarPage("WaterMonitor",
             tabPanel("Home",
                      div(
                        class = "hero",
                        h1("Next-Gen Water-Tech Innovation"),
                        p("We track water usage, monitor leakage, and address littering in natural rivers to build a sustainable future.")
                      )
             ),
             
             tabPanel("Water Usage",
                      sidebarLayout(
                        sidebarPanel(
                          h3("Input Your Water Usage Data for the Week"),
                          numericInput("day1", "Day 1 Water Usage (liters):", 0),
                          numericInput("day2", "Day 2 Water Usage (liters):", 0),
                          numericInput("day3", "Day 3 Water Usage (liters):", 0),
                          numericInput("day4", "Day 4 Water Usage (liters):", 0),
                          numericInput("day5", "Day 5 Water Usage (liters):", 0),
                          numericInput("day6", "Day 6 Water Usage (liters):", 0),
                          numericInput("day7", "Day 7 Water Usage (liters):", 0),
                          actionButton("submit_usage", "Submit")
                        ),
                        mainPanel(
                          plotOutput("usage_chart"),
                          textOutput("total_usage")
                        )
                      )
             ),
             
             tabPanel("Share Leaking Locations",
                      h3("Monitor Water Leakages"),
                      leafletOutput("leakage_map"),
                      div(class = "upload-section",
                          fileInput("leakage_photo", "Upload Your Photo of Water Leakage", multiple = TRUE, accept = c('image/png', 'image/jpeg')),
                          textOutput("leakage_photo_status")
                      )
             ),
             
             tabPanel("Share Littered Locations",
                      h3("Track Littering in Natural Rivers"),
                      leafletOutput("littering_map"),
                      div(class = "upload-section",
                          fileInput("littering_photo", "Upload Your Photo of Littering", multiple = TRUE, accept = c('image/png', 'image/jpeg')),
                          textOutput("littering_photo_status")
                      )
             ),
             
             tabPanel("Projects",
                      div(class = "project-section",
                          h2("Join Our Clean Water Projects"),
                          div(class = "project",
                              h3("1. Cleaning Rivers and Drainages"),
                              p("Join us in cleaning up rivers and drainages in our community to prevent water pollution and protect our waterways."),
                              img(src = 'https://media.istockphoto.com/id/1353826551/photo/volunteer-picking-up-plastic-bottle-from-polluted-lake.webp?a=1&b=1&s=612x612&w=0&k=20&c=ovU_5vuHGGEQeNeGRaLoyiyNzKrt39qgQwVL4qb_ATc=', 
                                  alt = 'Cleaning Rivers Project Image', 
                                  class = 'project-img'),  # Project image
                              actionButton("join_cleaning", "Join Now", class = "join-button")
                          ),
                          div(class = "project",
                              h3("2. Run for Clean Water"),
                              p("Participate in our annual marathon to raise awareness and funds for clean water projects."),
                              img(src = 'https://media.istockphoto.com/id/1921750831/photo/marathon-runners-multiracial-group-of.jpg?s=612x612&w=0&k=20&c=PAMysCaY4wqAx0GztuKAJPR3eD5sPcGfw03pjvDmbQI=', 
                                  alt = 'Run for Clean Water Image', 
                                  class = 'project-img'),
                              actionButton("join_run", "Join Now", class = "join-button")
                          ),
                          div(class = "project",
                              h3("3. Water Conservation Workshops"),
                              p("Learn how to conserve water through practical tips and workshops."),
                              img(src = 'https://media.istockphoto.com/id/1496376731/photo/woman-giving-speaker-presentation.webp?a=1&b=1&s=612x612&w=0&k=20&c=fpAOdGo8AT99X63KDmGmV6LbdJZ9I7GpLJB1Wzdi8Os=',
                                  alt = 'Water Conservation Workshops Image', 
                                  class = 'project-img'),
                              actionButton("join_workshop", "Join Now", class = "join-button")
                          )
                      ),
                      # Form Popup
                      div(id = "form_popup", class = "form-popup",
                          h3("Join Us"),
                          textInput("form_name", "Name:"),
                          textInput("form_email", "Email:"),
                          textInput("form_phone", "Phone Number:"),
                          textAreaInput("form_message", "Message:", ""),
                          actionButton("submit_form", "Submit"),
                          actionButton("close_form", "Cancel", class = "join-button")
                      ),
                      div(id = "overlay", class = "overlay")
             ),
             
             tabPanel("About",
                      div(class = "about-page",
                          h2("About Us"),
                          p("WaterMonitor is dedicated to tracking and improving water usage, monitoring leakage, and addressing littering in natural rivers. We aim to create a sustainable future through community involvement and innovative solutions."),
                          h3("Our Goals"),
                          p("1. Reduce water wastage and encourage efficient usage."),
                          p("2. Identify and repair water leakages promptly."),
                          p("3. Combat littering and promote clean rivers."),
                          h3("Our Approach"),
                          p("We use advanced technology and community-driven initiatives to achieve our goals. Our platform allows users to track water usage, report issues, and participate in various projects.")
                      )
             ),
             
             tabPanel("Donate",
                      div(class = "donate-section",
                          h2("Support Our Clean Water Projects"),
                          radioButtons("donation_amount", "Select Donation Amount:",
                                       choices = c("$10", "$25", "$50", "$100", "Other")),
                          conditionalPanel(
                            condition = "input.donation_amount == 'Other'",
                            numericInput("other_amount", "Enter Donation Amount:", value = 0, min = 1)
                          ),
                          textInput("donor_name", "Your Name:"),
                          textInput("donor_email", "Your Email:"),
                          textInput("donor_phone", "Your Phone Number:"),
                          actionButton("submit_donation", "Donate Now", class = "donation-button"),
                          textOutput("donation_confirmation")
                      )
             )
  )
)

server <- function(input, output, session) {
  
  # Example of rendering a map with littering markers and user input
  output$littering_map <- renderLeaflet({
    leaflet() %>%
      addTiles() %>%
      setView(lng = 36.8219, lat = -1.2921, zoom = 12)  # Set to Nairobi
  })
  
  observeEvent(input$littering_map_click, {
    click <- input$littering_map_click
    leafletProxy("littering_map") %>%
      addMarkers(lng = click$lng, lat = click$lat, popup = "User-reported littering location.")
  })
  
  # Example of rendering a map with leakage markers and user input
  output$leakage_map <- renderLeaflet({
    leaflet() %>%
      addTiles() %>%
      setView(lng = 36.8219, lat = -1.2921, zoom = 12)  # Set to Nairobi
  })
  
  observeEvent(input$leakage_map_click, {
    click <- input$leakage_map_click
    leafletProxy("leakage_map") %>%
      addMarkers(lng = click$lng, lat = click$lat, popup = "User-reported leakage location.")
  })
  
  # Donation confirmation text
  observeEvent(input$submit_donation, {
    donation_amount <- ifelse(input$donation_amount == "Other", input$other_amount, input$donation_amount)
    output$donation_confirmation <- renderText({
      paste("Thank you", input$donor_name, "for donating", donation_amount, "to our clean water projects!")
    })
  })
  
  # Water usage chart
  output$usage_chart <- renderPlot({
    usage <- c(input$day1, input$day2, input$day3, input$day4, input$day5, input$day6, input$day7)
    days <- 1:7
    df <- data.frame(days, usage)
    ggplot(df, aes(x = days, y = usage)) +
      geom_line(color = "blue", size = 1.5) +
      geom_point(size = 3, color = "red") +
      ggtitle("Your Water Usage Over the Week") +
      xlab("Days") +
      ylab("Water Usage (liters)")
  })
  
  # Total usage text
  output$total_usage <- renderText({
    total_usage <- sum(c(input$day1, input$day2, input$day3, input$day4, input$day5, input$day6, input$day7))
    paste("Total Water Usage for the Week:", total_usage, "liters")
  })
  
  # Show form popup
  observeEvent(input$join_cleaning, {
    shinyjs::show("overlay")
    shinyjs::show("form_popup")
  })
  
  observeEvent(input$join_run, {
    shinyjs::show("overlay")
    shinyjs::show("form_popup")
  })
  
  observeEvent(input$join_workshop, {
    shinyjs::show("overlay")
    shinyjs::show("form_popup")
  })
  
  # Close form popup
  observeEvent(input$close_form, {
    shinyjs::hide("overlay")
    shinyjs::hide("form_popup")
  })
  
  # Form submission
  observeEvent(input$submit_form, {
    output$confirmation_message <- renderText({
      paste("Thank you,", input$form_name, "for joining our project! We will contact you at", input$form_email, "soon.")
    })
    shinyjs::hide("overlay")
    shinyjs::hide("form_popup")
  })
}

shinyApp(ui = ui, server = server)