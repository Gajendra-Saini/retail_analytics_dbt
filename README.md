
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

<img width="1317" height="707" alt="Screenshot 2026-02-13 at 5 09 09 PM" src="https://github.com/user-attachments/assets/ea25a57f-35bd-4c67-b10f-04ff7078a913" />
<img width="1469" height="803" alt="Screenshot 2026-02-13 at 5 30 08 PM" src="https://github.com/user-attachments/assets/86e1710f-c241-4712-8295-e5653cb68470" />
<img width="1469" height="835" alt="Screenshot 2026-02-13 at 5 31 01 PM" src="https://github.com/user-attachments/assets/37960905-f2ef-42a8-ae44-9459fe76f2bd" />

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

## 🔄 Data Flow

1. Raw transactional data loaded into Snowflake.
2. Staging layer cleans and standardizes data.
3. Fact table built using incremental strategy.
4. Dimension table built using snapshot (SCD Type 2).
5. Static enrichment applied using dbt seeds.
6. Reusable business logic applied using macros.
7. Data quality enforced using tests.
8. Models deployed to production using dbt Cloud jobs.
9. Lineage and documentation generated inside dbt.

---

# 🧱 Step-by-Step Implementation

## 1️⃣ Raw Data Layer (Snowflake)

Raw retail data was first loaded into **Snowflake**.

### Tables Created

- `CUSTOMERS`
- `ORDERS`
- `ORDER_DETAILS`
- `BRANCHES`
- `CATEGORIES`

These represent the untransformed **source layer**.

<img width="1462" height="824" alt="Screenshot 2026-02-13 at 4 56 28 PM" src="https://github.com/user-attachments/assets/b8758d88-e3b9-4e96-ae8b-e9e6b1f10d25" />

---

## 2️⃣ Staging Layer (dbt Models)

The staging layer standardizes and cleans raw data using **dbt models**.

### Project Structure

<img width="1470" height="808" alt="Screenshot 2026-02-13 at 4 57 59 PM" src="https://github.com/user-attachments/assets/369cc41d-9ed3-4553-982c-d77833820655" />
<img width="1468" height="823" alt="Screenshot 2026-02-13 at 4 58 46 PM" src="https://github.com/user-attachments/assets/1cbc9c4c-7692-4144-962c-0b3982b837ac" />

### Staging Models

- `stg_customers.sql`
- `stg_orders.sql`
- `stg_order_details.sql`
- `stg_branches.sql`
- `stg_categories.sql`
- `schema.yml`

Each staging model performs:

- Column renaming and standardization  
- Data type casting  
- Basic data cleaning  
- Preparation for downstream fact and dimension models  

---

## 3️⃣ Incremental Fact Table

Built a central transactional fact table using an **incremental merge strategy**.

### File Location

`models/gold_layer/sales_fact.sql`

### Configuration

```sql
{{ config(
    materialized='incremental',
    unique_key=['order_id','item_id'],
    incremental_strategy='merge'
) }}
```

### Incremental Logic

```sql
{% if is_incremental() %}
    where order_ts > (
        select max(order_ts) from {{ this }}
    )
{% endif %}
```

<img width="1469" height="830" alt="Screenshot 2026-02-13 at 5 02 05 PM" src="https://github.com/user-attachments/assets/d5e34c5b-1a05-4ebe-bef7-f4ed9679b4a9" />

---

## 4️⃣ Slowly Changing Dimension (SCD Type 2)

Implemented historical tracking using **dbt snapshots**.

### File Location

`snapshots/customers_snapshot.sql`

### Snapshot Metadata Columns Created

- `DBT_VALID_FROM`  
- `DBT_VALID_TO`  
- `DBT_SCD_ID`  
- `DBT_UPDATED_AT`  

<img width="1462" height="818" alt="Screenshot 2026-02-13 at 5 03 25 PM" src="https://github.com/user-attachments/assets/acf26369-097c-43e5-b234-bfe5205d6b5e" />

---

## 5️⃣ Dimension Table (Using Snapshot)

The dimension table reads from the snapshot and selects only the current active records.

### Example

```sql
with source as (
    select *
    from {{ ref('customers_snapshot') }}
    where dbt_valid_to is null
)

select * from source
```

<img width="1470" height="673" alt="Screenshot 2026-02-13 at 5 06 04 PM" src="https://github.com/user-attachments/assets/450f4551-a96b-4459-b9b8-231669072d4f" />

---

## 6️⃣ Advanced Data Tests

Implemented data quality validation using built-in **dbt tests**.

### Tests Implemented

- `not_null`  
- `unique`  
- `relationships`  

### Example (Referential Integrity Test)

```yaml
- name: user_id
  tests:
    - relationships:
        to: ref('stg_customers')
        field: user_id
```
<img width="1470" height="807" alt="Screenshot 2026-02-13 at 5 27 45 PM" src="https://github.com/user-attachments/assets/25e4fa32-7d25-4a0e-8791-c20a7dbc9780" />

---

## 7️⃣ Seeds (Static Data Enrichment)

Used **dbt seeds** to manage static mapping data.

### File Location

`seeds/city_mapping.csv`

### Seeds Screenshot

<img width="1470" height="783" alt="Screenshot 2026-02-13 at 5 07 37 PM" src="https://github.com/user-attachments/assets/705250f2-cfdf-4c6b-b3a8-3af6983c260f" />

---

## 8️⃣ Macros (Reusable SQL Logic)

Created a reusable macro for currency conversion.

### File Location

`macros/currency_conversion.sql`

<img width="1469" height="757" alt="Screenshot 2026-02-13 at 5 08 31 PM" src="https://github.com/user-attachments/assets/06a66198-2fb3-4e60-9166-e2147e88a1cc" />

---

## 9️⃣ Lineage & Documentation

The project provides full lineage tracking using dbt documentation.

### Data Flow

Source → Staging → Fact → Snapshot → Dimension

<img width="1317" height="707" alt="Screenshot 2026-02-13 at 5 09 09 PM" src="https://github.com/user-attachments/assets/ea25a57f-35bd-4c67-b10f-04ff7078a913" />

---

## 🔟 Deployment Workflow

A production-style workflow was followed.

### Steps

1. Feature branch created  
2. Changes committed  
3. Pull Request raised  
4. Code merged into `main`  
5. Production job executed  

### Final Snowflake Structure

- `ANALYTICS` schema (Fact tables)  
- `STAGING` schema (Views)  
- `SNAPSHOTS` schema (SCD history tracking)  
- `DEV` schemas for development
- `RAW` schema for raw data

<img width="411" height="324" alt="Screenshot 2026-02-13 at 5 10 02 PM" src="https://github.com/user-attachments/assets/afd0253e-3b12-4e8c-9c23-25068318da58" />
<img width="452" height="828" alt="Screenshot 2026-02-13 at 5 29 08 PM" src="https://github.com/user-attachments/assets/3e0f5097-b4d7-4ad9-8e4b-5fccf3db4871" />
<img width="457" height="687" alt="Screenshot 2026-02-13 at 5 29 28 PM" src="https://github.com/user-attachments/assets/e673b08b-c6cd-4b35-9477-79f4cb385d89" />

