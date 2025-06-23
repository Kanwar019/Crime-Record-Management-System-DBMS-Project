# Crime Record Management System (CRMS) – DBMS Project

## 📘 Overview

The **Crime Record Management System (CRMS)** is a database-driven project designed to efficiently store, manage, and retrieve information related to crimes, criminals, cases, evidence, and related entities. It streamlines the digital handling of crime-related data for administrative and legal purposes.

## 🛠️ Tech Stack

- **Database:** Oracle Live SQL
- **Language:** PL/SQL (Procedures, Functions, Triggers, Views)
- **Frontend:** (Optional – SQL interface or application layer if extended)
- **Environment:** Oracle Live SQL / SQL Developer

## 📂 Schema Design

The database includes the following key tables:

- **Users** – Stores user login and roles.
- **Crime** – Details of crimes reported (location, type, date, etc.).
- **Criminal** – Profiles and information on individuals involved in crimes.
- **Cases** – Legal case information mapped to crimes and victims.
- **Evidence** – Records and status of evidence associated with cases.
- **Victim** – Details of individuals affected by reported crimes.
- **Trial** – Court proceedings and their status.
- **Associated_With** – Relation mapping criminals to crimes.
- **References_To** – Connects evidence and trials to specific cases.

## 🔁 Core Functionalities

- Add/update/delete crime records
- Associate criminals with crimes
- Track case progress and trials
- Manage evidence with case linkage
- Retrieve victim and case summaries
- Trigger alerts for missing mandatory data

## 📌 Sample Queries & Operations

- Insert a new crime and link it with a case and criminal
- Generate a report of all unsolved crimes in a given location
- Track evidence status for a specific case
- View trials scheduled for a particular date

## 📋 PL/SQL Components

- **Procedures** for inserting and updating multi-table data
- **Functions** to fetch dynamic summaries or counts (e.g., total crimes by type)
- **Triggers** to enforce data integrity rules (e.g., auto-update crime status when trial completes)
- **Views** for simplified reporting (e.g., view_case_summary)

## 📈 Future Scope

- Web-based UI with admin login
- Integration with law enforcement systems
- Visual dashboards for crime statistics
- Role-based access control (RBAC)

## 👨‍💻 Made By -

> Kanwarajaybir Singh
> 102317223

## 📜 License

This project is developed as part of an academic curriculum and is open for learning and non-commercial use.
