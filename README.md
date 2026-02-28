Banking System Database Project
1. Introduction

This project presents the design and implementation of a comprehensive Banking System database using Microsoft SQL Server. The objective is to simulate a real-world banking environment by modeling core financial operations, digital services, risk management, and supporting departments within a structured relational database.

2. Objectives

Design a normalized multi-schema database architecture

Implement relational integrity using primary and foreign keys

Develop a staging process using BULK INSERT

Apply MERGE statements for ETL (Extract, Transform, Load) operations

Create analytical views for risk detection and KPI monitoring

3. System Architecture

The database is organized into multiple schemas representing different banking domains:

core_banking

digital_banking

loans_credit

compliance

human_resources

investments

insurance_security

merchant_service

This separation ensures modularity, scalability, and logical data organization.

4. Data Integration Process

The system follows a structured ETL workflow:

Data is imported into temporary staging tables using BULK INSERT.

Data validation and transformation occur in staging.

MERGE statements synchronize staging data with production tables.

This approach simulates enterprise-level data warehousing practices.

5. Analytical Components

The project includes several analytical views for monitoring and evaluation:

Top customers by total balance (currency conversion applied)

Customers with multiple active loans

Fraud-detected transactions

Total loan amount per branch

High-value transactions within short time intervals

Suspicious cross-country transaction patterns

These views demonstrate practical risk analysis and KPI computation in banking systems.
