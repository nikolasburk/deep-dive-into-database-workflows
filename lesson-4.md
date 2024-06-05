# Customizing migrations

## Goal

The goal of this lesson is to learn how you can customize your database migrations before applying them to your database schema

## Introduction

The Prisma schema is an abstraction over the database and sometimes it won’t provide 100% coverage of the features that you may need such as loading extensions on PostgreSQL or database views. 

In other use cases, you may need to edit a migration to rename a column or relation without incurring any data loss.

If you run into such scenarios, you would have it is to edit a migration before it’s applied to the database.

Prisma Migrate supports this workflow by allowing you to create a draft migration using the `--create-only` flag when working with `prisma migrate dev`.

## Setup

You can continue working in the same `deep-dive-into-database-workflows` project that you set up in the previous lesson. However, the starter lesson is located in the `customize-migrations` branch of the repo you cloned.

Before you switch to that branch, you need to commit the current state of your project. For simplicity, you can use the `stash` command to do this:

```yaml
git stash
```

Switch to the `customize-migrations` branch:

```yaml
git checkout customize-migrations 
```

## Tasks

### Task 1: Enable an extension

In your Prisma schema:

1. Add the `citext` native type to the `name` field in the `Product` table
2. Create a draft database migration
3. Enable the extension using SQL
4. Re-run the migration to apply it to the database

Refer to the [Prisma docs](https://www.prisma.io/docs/concepts/database-connectors/postgresql#native-type-mappings) to find the right native type attribute to use.

If you try running `npx prisma migrate dev --name add-citext-native-type` without enabling the extension, Prisma Migrate will throw an error.

- Error
    
    ```bash
    ❯ npx prisma migrate dev
    Environment variables loaded from .env
    Prisma schema loaded from prisma/schema.prisma
    Datasource "db": PostgreSQL database "schema-prototyping", schema "public" at "localhost:5435"
    
    ✔ Enter a name for the new migration: … add-citext-native-type
    Applying migration `20220610114025_add_citext_native_type`
    Error: P3018
    
    A migration failed to apply. New migrations cannot be applied before the error is recovered from. Read more about how to resolve migration issues in a production database: https://pris.ly/d/migrate-resolve
    
    Migration name: 20220610114025_add_citext_native_type
    
    Database error code: 42704
    
    Database error:
    ERROR: type "citext" does not exist
    
    DbError { severity: "ERROR", parsed_severity: Some(Error), code: SqlState(E42704), message: "type \"citext\" does not exist", detail: None, hint: None, position: None, where_: None, schema: None, table: None, column: None, datatype: None, constraint: None, file: Some("parse_type.c"), line: Some(270), routine: Some("typenameType") }
    ```
    
    Fix:
    
    1. Mark the previous migration as rolled back using `prisma migrate resolve --rolled-back`
    2. Update the migration file to enable the extension.
    3. Redeploy the migration using `prisma migrate deploy`

Note: The `CITEXT` extension allows you to query a column in a case-insensitive manner

- Solution
    
    Prisma schema:
    
    ```groovy
    model Product {
      id          String   @id @default(uuid()) /// or @default(cuid())
      name        String   @db.Citext
      description String?  @db.VarChar(1000)
      sku         String
      price       Decimal  @db.Decimal(10, 2)
      createdAt   DateTime @default(now()) @db.Time()
      updatedAt   DateTime @updatedAt @db.Timestamptz()
    
      categories Category[]
    }
    
    model Category {
      id       String    @id @default(uuid()) /// or @default(cuid())
      name     String
      products Product[]
    }
    ```
    
    Create a draft migration:
    
    ```bash
    npx prisma migrate dev --create-only --name add-citext-native-attribute
    ```
    
    Update the draft migration by enabling the extension:
    
    ```sql
    CREATE EXTENSION IF NOT EXISTS citext;
    
    -- AlterTable
    ALTER TABLE "Product" ALTER COLUMN "name" SET DATA TYPE CITEXT;
    ```
    
    Apply the migration to the database:
    
    ```bash
    npx prisma migrate dev
    ```
    
    Review the database schema, 
    

### Task 2: Rename a field

In your project:

1. Rename the `description` field to `content`
2. Create a draft migration
3. Update the SQL to rename the column
- Solution
    
    Rename the field in your Prisma schema
    
    ```groovy
    model Product {
      id        String   @id @default(uuid()) /// or @default(cuid())
      name      String   @db.Citext
      **content   String?  @db.VarChar(1000)**
      sku       String
      price     Decimal  @db.Decimal(10, 2)
      createdAt DateTime @default(now()) @db.Time()
      updatedAt DateTime @updatedAt @db.Timestamptz()
    
      categories Category[]
    }
    
    model Category {
      id       String    @id @default(uuid()) /// or @default(cuid())
      name     String
      products Product[]
    }
    ```
    
    Create a draft migration
    
    ```bash
    npx prisma migrate dev --name rename-description-field --create-only
    ```
    
    Update the draft migration
    
    ```sql
    ALTER TABLE "Product" RENAME COLUMN "description" TO "content";
    ```
    
    Apply the migration:
    
    ```bash
    npx prisma migrate dev
    ```
    

In this case, Prisma Migrate is unaware that you would like to rename a field and will assume that you would like to delete the `description` column and create a new one called `content`. 

This type of schema change is destructive and it would prompt a reset of the database – leading to data loss.

But, editing the draft migration allows you to avoid such a destructive change.