# Setting Up PostgreSQL Sandbox on Mac

This guide walks you through setting up a PostgreSQL development environment on your Mac. It includes steps for installing PostgreSQL, setting up sample databases, and performing basic database operations.

## Prerequisites

Before you start, ensure you have administrative access to your Mac and an internet connection to download the necessary files.

## Step 1: Install PostgreSQL

1. Visit the official PostgreSQL download page: [PostgreSQL Downloads](https://www.postgresql.org/download/).
2. Choose macOS and follow the instructions to download and install PostgreSQL.
3. During installation, remember to note down the database name and password you set up.

## Step 2: Download and Install the dvdrental Database

1. Download the dvdrental sample database from [PostgreSQL Sample Database](https://www.postgresqltutorial.com/postgresql-getting-started/postgresql-sample-database/).
2. Extract the zipped dvdrental database files to a known directory on your Mac.

## Step 3: Database Restoration and Setup

### Using pgAdmin

1. Open pgAdmin and connect to your PostgreSQL server.
2. Create a new database named `dvdrental`.
3. Right-click on the `dvdrental` database, select `Restore`, and navigate to the folder where you extracted the dvdrental database files. Follow the prompts to restore the database.

### Using Shell Commands

1. Open the Terminal.
2. Navigate to the PostgreSQL bin directory or export to path so it will be accessible everywhere (which will most likely be @ cd /Library/PostgreSQL/<version>/bin:
3. Log in to the PostgreSQL shell:
4. Use the following shell commands for basic operations:
- List all databases: `\l`
- Quit: `\q`
- Create a database: `CREATE DATABASE dbname;`

### Using pg_restore

Alternatively, you can use `pg_restore` (pg_restore -U postgres -d dvdrental path/to/extracted/files) to restore the dvdrental database without pgAdmin:

## Step 4: Setting Up the ds2 Database

1. Download the ds2 database from [Dell DVD Store](https://linux.dell.com/dvdstore/).
2. Follow the instructions in the dvdstore README for detailed setup and restoration steps.

## Step 5: Setting Up the Practice Database

1. Use the `aggregate.sql`, `billing.sql`, `student_course.sql`, and `vehicle.sql` scripts to create and populate the practice database.
2. These scripts will create the necessary tables and populate them with data.

## Exploring the Databases

Once you've set up the databases, log in to pgAdmin and explore the `dvdrental`, `ds2`, and the practice database to confirm that everything is working correctly.

## Conclusion

You now have a PostgreSQL sandbox environment on your Mac with three databases for practice and exploration. Happy querying!


