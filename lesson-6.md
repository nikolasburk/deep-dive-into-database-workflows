# Troubleshooting failed migrations

## Goal

The goal of this lesson is to learn when migrations might fail to be applied to your database and how you can resolve them.

## Introduction

Sometimes, there is a possibility that a migration might fail when you’re applying it to your database. A migration might fail if:

- You customize a migration that might have an error
- You add a `NOT NULL` constraint to a column that already has data
- The migration process stops unexpectedly
- The database shuts down in the middle of the migration process

Prisma Migrate tracks the status of a migration in a `logs` column inside the `_prisma_migrations` table.

You can resolve the failed migrations in one of two ways:

- Roll back, fix the migration, and re-deploy
- Manually complete migration steps and resolve the migration

## Setup

You can continue working in the same `deep-dive-into-database-workflows` project that you set up in the previous lesson. However, the starter lesson is located in the `prisma-` branch of the repo you cloned.

Before you switch to that branch, you need to commit the current state of your project. For simplicity, you can use the `stash` command to do this:

```
git stash

```

Switch to the `prisma-` branch:

```
git checkout 
```

## Tasks

The tasks in this lesson will simulate failed migrations creating a schema drift.

### Task 1: Moving backwards and reverting database changes

In this task, you will:

- Move the database schema ahead of the Prisma schema – including the migration history and migrations table
- Revert the changes using `prisma migrate diff` and `db execute`

This is to ensure that the Prisma schema, migration history, migrations table and database schema will remain in sync.

1. Execute the following SQL on your database to create a table in the database:

```sql
CREATE TABLE "Order" (
    "id" SERIAL,
    "value" TEXT,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Order_pkey" PRIMARY KEY ("id")
);
```

Once you execute the SQL, the database schema will now be ahead of the Prisma schema, migrations history, and migrations table

1. Run `prisma migrate dev` to see the schema drift and exit the step by pressing “N”
2. Use the `migrate diff` command to create a diff:
- from the database (using the URL)
- to the schema datamodel
- output the SQL into a file called `rollback.sql`
1. Inspect the `rollback.sql` file to ensure it contains the desired changes.
2. Execute the `rollback.sql` file on your database using. the `db execute` command

Refer to the following docs to learn how to use the right arguments when using `migrate diff` and `db execute` command:

- `migrate diff`: https://www.prisma.io/docs/reference/api-reference/command-reference#migrate-diff
- `db execute`: https://www.prisma.io/docs/reference/api-reference/command-reference#db-execute

- Solution
    
    Create a diff of your migrations history from the database:
    
    ```bash
    npx prisma migrate diff \
    --from-url "DATABASE_URL" \
    --to-schema-datamodel ./prisma/schema.prisma \
    --script > rollback.sql
    ```
    
    Apply the changes to your database:
    
    ```bash
    npx prisma db execute \
    --url "DATABASE_URL" \
    --file rollback.sql
    ```
    

### Task 2: Moving forward and applying missing changes

In this task, you will:

- Move the database schema ahead of the Prisma schema – including the migration history and migrations table
- Move the Prisma schema, migration history, and migrations table forward

1. Execute the following SQL on your database to create a table in the database:

```sql
CREATE TABLE "Order" (
    "id" SERIAL,
    "value" TEXT,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Order_pkey" PRIMARY KEY ("id")
);
```

Just like Task 1, the database schema is ahead of the Prisma schema, migrations history, and migrations table.

1. Run `prisma migrate dev` to see the schema drift and exit the step by pressing “N”
2. Use the `migrate diff` command to create a diff:
- from your Prisma schema data models
- to the database (using the URL)
- output the SQL into a file called `migration.sql`
1. Inspect the `migration.sql` file
2. Create a new folder inside `./prisma/migrations` and move `migration.sql` into the folder
3. Mark the migration as applied using the `migrate resolve` command
4. Introspect the database to sync the changes with your Prisma schema file
5. Run `prisma migrate dev` to confirm if there is a schema drift

- Solution
    
    Create a diff of your Prisma schema from your database:
    
    ```bash
    npx prisma migrate diff \
    --from-schema-datamodel ./prisma/schema.prisma \
    ∙ --to-url "DATABASE_URL" \
    ∙ --script > migration.sql
    ```
    
    Create a folder in the `./prisma/migrations` and move the generated file to the created folder.
    
    Mark the migration as applied using the `prisma migrate resolve` command with the name of the created folder passed as an argument to the CLI:
    
    ```bash
    npx prisma migrate resolve --applied "folder_name"
    ```
    
    Run `prisma db pull` to now sync the changes in the Prisma schema:
    
    ```bash
    npx prisma db pull
    ```