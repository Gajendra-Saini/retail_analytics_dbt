# 🚀 Retail Analytics Project using dbt
**End-to-End Modern Data Stack Implementation using Snowflake & dbt**

---

## 📌 Project Details

This project demonstrates the complete design and implementation of a modern cloud-based data warehouse using Snowflake and dbt.

The goal was to build a production-ready analytics layer starting from raw data ingestion to fully transformed fact and dimension tables, including historical tracking, testing, and performance optimization.

The project simulates a real-world retail analytics use case involving:

- Customers
- Orders
- Order Details
- Branches
- Product Categories

The final output supports scalable analytics, historical tracking, and BI-ready data models.

---

## 🔥 Project Highlights

- Designed full medallion-style warehouse architecture (Raw → Staging → Analytics)
- Implemented incremental fact tables using `merge` strategy
- Built Slowly Changing Dimension (SCD Type 2) using dbt snapshots
- Created reusable business logic using dbt macros (Jinja templating)
- Enforced referential integrity using relationship tests
- Integrated static mapping data using dbt seeds
- Implemented version-controlled development workflow (feature → PR → main → prod)
- Enabled full data lineage visibility in dbt
- Applied Snowflake performance tuning (clustering + incremental loads)
- Built production-style folder structure

---

## 🛠️ Technology Stack

- **Azure Data Lake (Raw Layer Concept)**
- **Snowflake (Cloud Data Warehouse)**
- **dbt (Data Transformation & Modeling)**
- **dbt Cloud (Orchestration & Deployment)**
- **GitHub (Version Control & PR Workflow)**
- **SQL**
- **Jinja (Templating Engine in dbt)**

---

## 🏗️ High-Level Architecture

The data pipeline follows a modern layered architecture:

