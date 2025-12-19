## Show Me the Money! A Roadmap to Biomedical Grants 

### Welcome to our Project 4 repository!
This repo contains the project proposal, exploratory data analysis, and all source code for Show Me the Money!, an interactive dashboard that integrates NIH and NSF data to visualize the biomedical funding landscape from 2021 to 2025.

Our goal is to provide a clear and accessible resource that helps students, researchers, and institutions identify trends in funding by state, year, funding agency, and research topic, supporting a better understanding of current funding patterns.

## Team Members
This project is created and maintained by:
- [Lo-Yu Chang](https://github.com/loyuchang)
- [Linda Ye](https://github.com/lindaye-md)
- [Ding Ding](https://github.com/dding0211)
- [Hui Yao](https://github.com/HuiYao-Amber)

## Repo structure
- `Proposal/`: Contains the project proposal document outlining objectives, methodology, and expected outcomes.
- `Analytical_pipeline/`: Contains scripts and notebooks for data cleaning, transformation, and analysis.
    - `1_data_cleaning/`: Scripts for cleaning raw datasets. Part of the raw data can be found in [here](https://drive.google.com/drive/folders/1jD7aWVwk_U4ekBQCSTjx3RjZw6K6dV7V)
    - `1.1_exploratory_analysis`: Notebooks for initial data exploration and visualization.
    - `2_ML`: Scripts for machine learning models applied to the data attempting to predict funding amount based on historical data.
    - `3_text_analysis_files/`: Scripts for text analysis on research topics and abstracts.
- `Draft_dashboard/`: Contains the code for the draft code for individual tabs of the dashboard.
- `Final_dashboard/`: Contains the final version of the interactive dashboard code.
    - `data/`: Contains cleaned datasets used in the dashboard.
- `Final_write_up/`: Contains the final project report summarizing findings and insights.

## Link to the deployed dashboard
The interactive dashboard can be accessed [here](https://loyuchang.shinyapps.io/show_me_the_money/).

## Baisc introduction to the dashboard
The dashboard consists of four main tabs:
- `Introduction`: Provides an overview of the project, its objectives, and the data dictionary.
- `Funding Breakdown`: Visualizes funding trends over time, by state, and by agency.
- `Interactive Heatmap`: Allows users to explore funding distribution across states, years, grant types, and agencies.
- `Text Analysis`: Presents insights from text analysis of research topics and abstracts.