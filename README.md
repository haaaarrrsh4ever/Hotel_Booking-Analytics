# 🏨 Hotel Booking Analytics Dashboard

An end-to-end Hotel Booking Analytics project built using **Snowflake**, **SQL**, **Snowpark**, **Python**, and **Streamlit**. This project demonstrates a modern data engineering and analytics workflow, from raw data ingestion to an interactive business dashboard.

---

# 📌 Project Overview

This project simulates a real-world hotel booking analytics solution by implementing a Medallion Architecture (Bronze, Silver, Gold) within Snowflake. The cleaned and transformed data is then visualized through an interactive Streamlit dashboard hosted inside Snowflake.

The dashboard enables users to analyze booking trends, revenue, customer behavior, hotel performance, and booking status using dynamic filters and visualizations.

---

# 🚀 Tech Stack

- Snowflake
- SQL
- Snowpark
- Python
- Streamlit
- Pandas

---

# 🏗 Architecture

```
                 Raw Hotel Booking Data
                         │
                         ▼
                  Bronze Layer
            (Raw Data Ingestion)
                         │
                         ▼
                  Silver Layer
      (Data Cleaning & Transformation)
                         │
                         ▼
                   Gold Layer
        (Business Ready Aggregations)
                         │
                         ▼
         Streamlit Analytics Dashboard
```

---

# 📂 Project Structure

```
Hotel-Booking-Analytics-Dashboard
│
├── README.md
├── streamlit_app.py
│
├── sql
│   ├── bronze_layer.sql
│   ├── silver_layer.sql
│   └── gold_layer.sql
│
└── screenshots
    ├── dashboard.png
    ├── filters.png
    ├── charts.png
    └── kpis.png
```

---

# 📊 Dashboard Features

### 📈 Key Performance Indicators

- Total Bookings
- Total Revenue
- Unique Customers
- Total Hotels
- Average Guests

---

### 📊 Interactive Charts

- Daily Booking Trend
- Daily Revenue Trend
- Revenue by Hotel City
- Room Type Distribution
- Booking Status Analysis
- Monthly Revenue Trend

---

### 🎯 Interactive Filters

- Hotel City
- Room Type
- Booking Status
- Date Range

---

### 📋 Detailed Analytics

- Top Hotels by Revenue
- Top Customers
- Complete Booking Details
- Dynamic Data Table

---

# 🔄 ETL Pipeline

### Bronze Layer

- Loaded raw hotel booking dataset into Snowflake.
- Preserved original data without modifications.

### Silver Layer

- Removed duplicate records.
- Standardized data types.
- Cleaned null values.
- Applied business validation rules.
- Improved data quality.

### Gold Layer

Created business-ready analytical tables for reporting:

- Daily Booking Aggregation
- Hotel City Revenue
- Clean Booking Dataset
- Business Metrics

---

# 📈 Business Insights

The dashboard helps answer questions such as:

- Which cities generate the highest revenue?
- How do bookings change over time?
- Which room types are booked the most?
- What is the booking status distribution?
- Who are the top customers?
- Which hotels generate maximum revenue?

---

# 💡 Skills Demonstrated

### SQL

- Joins
- Aggregations
- Window Functions
- CTEs
- Data Cleaning
- ETL Development

### Snowflake

- Warehouses
- Databases
- Schemas
- Stages
- COPY INTO
- Streams
- Tasks
- Time Travel
- Snowpark

### Python

- Pandas
- Data Processing
- Snowpark Integration

### Streamlit

- Interactive Dashboard
- KPI Cards
- Charts
- Filters
- Data Tables

---

# 📸 Dashboard Preview

## Main Dashboard

> Add your dashboard screenshot here.

```
screenshots/dashboard.png
```

---

## KPI Section

> Add KPI screenshot here.

```
screenshots/kpis.png
```

---

## Charts

> Add charts screenshot here.

```
screenshots/charts.png
```

---

# 🎯 Project Highlights

✔ End-to-End Data Pipeline

✔ Medallion Architecture

✔ Snowflake Data Warehouse

✔ SQL Transformations

✔ Snowpark Integration

✔ Interactive Streamlit Dashboard

✔ Business Intelligence Reporting

✔ Real-World Analytics Use Case

---

# 🚀 Future Enhancements

- Plotly Interactive Visualizations
- Export Dashboard Data to CSV
- Advanced KPI Cards
- Forecasting Dashboard
- Occupancy Rate Analysis
- Hotel Performance Scorecards
- Customer Segmentation
- Mobile Responsive Layout

---

# 👨‍💻 Author

**Harsh Yadav**

MCA Graduate | SQL Developer | Snowflake Enthusiast | Data Analytics Learner

GitHub: https://github.com/YOUR_USERNAME

LinkedIn: https://linkedin.com/in/YOUR_PROFILE

---

# ⭐ If you found this project helpful, consider giving it a Star!
