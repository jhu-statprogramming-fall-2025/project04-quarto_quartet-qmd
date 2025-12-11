
library(shiny)
library(dplyr)
library(ggplot2)
library(scales)
library(DT)
library(readr)


# load data 
merged_data <- readRDS("merged_data.rds")
data_dictionary <- read_csv("data_dictionary.csv")



# Data preparation for merged data happen here 
# Precompute some summaries data from our dataset for the plots
amount_summary <- merged_data %>%
  filter(Source %in% c("NIH", "NSF"),
         Notification_year >= 2021,
         Notification_year <= 2025) %>%
  group_by(Notification_year, Source) %>%
  summarise(
    total_award = sum(Award_amount, na.rm = TRUE),
    .groups = "drop"
  )

count_summary <- merged_data %>%
  filter(Source %in% c("NIH", "NSF"),
         Notification_year >= 2021,
         Notification_year <= 2025) %>%
  group_by(Notification_year, Source) %>%
  summarise(
    n_awards = n(),
    .groups = "drop"
  )


#To build each page add a new tabpanel and add output plots in the server by calling the tabpanel

# ---- UI ----
ui <- navbarPage(
  "Show Me the Money!",

  
  # Tab 1: Introduction UI 
  tabPanel(
    "Introduction",
    fluidPage(
      br(),
      h3("Show Me the Money! A Roadmap to Biomedical Grants"),
      p(
        "In a period marked by tightening research budgets, this dashboard", 
        "combines data from both the NIH and NSF to provide a snapshot of the",
        "biomedical funding landscape from 2021 to 2025"
      ),
      p(
        "The dashboard features an interactive map that allows users to examine ",
        "funding patterns by state, as well as plots by agency and grant type. ",
        "Additional text analysis highlights emerging research topics and keywords, ",
        "helping users identify areas of growing scientific interest."
      ),
      p(
        "This platform is designed for students, junior faculty, and researchers ",
        "who want easy access to aggregated funding data from major federal agencies. ",
        "Our goal is to provide a practical, accessible resource for navigating ",
        "the biomedical grants landscape."
      ),
      
      h5("Use the tabs below to explore award amounts and award numbers from 2021–2025."),
      br(),
      
      # Introduction Plot with 2 tabs 
      tabsetPanel(
        # Award Amount plot tab 
        tabPanel(
          "Award Amount",
          br(),
          plotOutput("intro_amount_plot", height = "450px")
        ),
        
        # Number of Awards plot tab 
        tabPanel(
          "Number of Awards",
          br(),
          plotOutput("intro_count_plot", height = "450px")
        )
      )
    )
  ),
  
  # Tab 2: Data Summary UI 
  tabPanel(
    "Data Summary",
    fluidPage(
      br(),
      h3("Funding Data Summary"),
      
      p("This dataset compiles all NIH and NSF award records from 2021 
       through December 1, 2025. It includes key information such as 
       project titles, funding amounts, award dates, and participating 
       institutions. For transparency and reproducibility, our raw 
       data and scripts are available in our project’s GitHub 
       repository."),
      
      # GitHub link with icon
      tags$p(
        tags$b("GitHub Repository: "),
        tags$a(
          href = "https://github.com/lindaye-md/jhu-biostat777-project-4.git",
          target = "_blank",
          icon("github"), 
          " View Project Repository"
        )
      ),
      
      br(),
      h3("Funding Data"),
      DTOutput("data_preview"),
      
      br(),
      h3("Data Dictionary"),
      DTOutput("data_dictionary")
    )
  )
  

  # Add tabpanel3 UI here 
  # Add tabpanel4 UI here 
)


# ---- SERVER ----
server <- function(input, output, session) {
  
  # Tab 1 Output: Award Amount plot
  output$intro_amount_plot <- renderPlot({
    
    ggplot(amount_summary,
           aes(x = Notification_year,
               y = total_award,
               color = Source,
               group = Source)) +
      geom_line(size = 1.3) +
      geom_point(size = 3) +
      geom_text(
        aes(label = paste0(round(total_award / 1e9, 2), "B")),  # e.g. 9.1B
        vjust = -0.8,
        size  = 4,
        fontface = "bold", 
        color = "black",
        show.legend = FALSE
      ) +
      facet_wrap(~ Source, ncol = 1, scales = "free_y") +
      scale_y_continuous(
        labels = scales::label_dollar(scale = 1e-9, suffix = "B"),
        expand = expansion(mult = c(0.05, 0.20))   # extra space on top for labels
      ) +
      labs(
        title = "Total Award Amount by Year (NIH vs NSF)",
        x = "Award Notice Year",
        y = "Total Award Amount (Billion $)"
      ) +
      theme_minimal(base_size = 14) +
      theme(
        legend.position = "none",
        strip.text = element_text(size = 13, face = "bold"),
        plot.margin = margin(20, 20, 20, 20)
      )
  })
  
  # Tab 2 Output: Number of Awards plot 
  output$intro_count_plot <- renderPlot({
    
    ggplot(count_summary,
           aes(x = Notification_year,
               y = n_awards,
               color = Source,
               group = Source)) +
      geom_line(size = 1.3) +
      geom_point(size = 3) +
      geom_text(
        aes(label = scales::comma(n_awards)),
        vjust = -1.2,               # lifts labels above the point
        size  = 4,                  # bigger labels
        fontface = "bold",          # bold so easier to see
        color = "black",            # dark label for clarity
        show.legend = FALSE
      ) +
      facet_wrap(~ Source, ncol = 1, scales = "free_y") +
      scale_y_continuous(
        labels = scales::comma,
        expand = expansion(mult = c(0.05, 0.25))   # extra top space for labels
      ) +
      labs(
        title = "Number of Awards by Year (NIH vs NSF)",
        x = "Award Notice Year",
        y = "Number of Awards"
      ) +
      theme_minimal(base_size = 14) +
      theme(
        legend.position = "none",
        strip.text = element_text(size = 13, face = "bold"),
        plot.margin = margin(20, 20, 20, 20)
      )
  })
  
  
  #Tab 2 out put: Data table
  output$data_preview <- renderDataTable({
    datatable(
      head(merged_data),   
      options = list(
        pageLength = 10,
        autoWidth  = TRUE,
        scrollX    = TRUE
      ),
      rownames = FALSE
    )
  })



# Tab2 Output: Data dictionary table
output$data_dictionary <- renderDataTable({
  datatable(
    data_dictionary,
    options = list(
      pageLength = 10,
      autoWidth  = TRUE,
      scrollX    = TRUE
    ),
    rownames = FALSE
  )
})

   # Add Tab 3 outputs here 
   # Add Tab 4 outputs here 


}

# ---- RUN APP ----
shinyApp(ui, server)


