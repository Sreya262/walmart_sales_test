Walmart Sales Data Analysis

This project is an end-to-end data analysis solution designed to extract meaningful business insights from Walmart sales data. It uses Python for data processing and MySQL for advanced SQL queries to solve real-world business problems.

📌 Project Goals

Clean and preprocess Walmart sales data

Perform SQL-based analysis to identify sales trends, customer behavior, and profit patterns

Develop hands-on skills in Python, Pandas, SQL, and MySQL integration

⚙️ Tools and Technologies

Language: Python 3.8+

IDE: Visual Studio Code

Database: MySQL

Libraries: pandas, numpy, sqlalchemy, mysql-connector-python

Data Source: Kaggle - Walmart Sales Dataset

📁 Project Structure

|-- data/             # Raw and cleaned datasets
|-- sql_queries/      # SQL scripts for business analysis
|-- main.py           # Python script for loading and processing data
|-- requirements.txt  # Python package requirements
|-- README.md         # Project overview and documentation

🚀 Getting Started

1. Clone the Repository

git clone https://github.com/Sreya262/walmart-sales-analysis
cd walmart-sales-analysis

2. Install Python Dependencies

pip install -r requirements.txt

3. Download Dataset Using Kaggle API

Get your kaggle.json API token from Kaggle

Place it in ~/.kaggle/ or your working directory

kaggle datasets download -d <dataset-name>

4. Run the Project

Execute the main.py script to clean and load data into MySQL

🔍 Project Workflow

1. Environment Setup

Create project folders and organize files in VS Code

2. Data Download & Loading

Download dataset from Kaggle using the API

Read it into Pandas DataFrame for processing

3. Data Cleaning

Remove duplicates

Handle missing values

Format currency and fix data types

4. Feature Engineering

Create new columns such as Total Amount = unit_price * quantity

5. Load Data into MySQL

Use SQLAlchemy to connect to MySQL and upload cleaned data

6. SQL Analysis

Answer business questions like:

Revenue trends by branch and category

Best-selling product categories

Performance by city, time, and payment method

Customer buying patterns and peak hours

📊 Key Insights

Sales Insights: Identified high-performing branches and product categories

Profitability: Found the most profitable branches and categories

Customer Behavior: Analyzed shopping times, ratings, and payment preferences

🔮 Possible Improvements

Add interactive dashboards using Tableau or Power BI

Integrate more data sources for deeper analysis

Automate the data pipeline for regular updates

🪪 License

This project is licensed under the MIT License. You are free to use, modify, and distribute it with proper attribution.

🙏 Acknowledgments

Dataset: Kaggle's Walmart Sales Dataset

Inspiration: Business cases from Walmart’s sales and operations




