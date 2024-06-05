# Running Prisma Migrate in CI and Production

## Goal

The goal of this lesson is to learn how you can use Prisma Migrate in a CI and production environment

## Introduction

To apply pending migrations to development, testing, and production environments, you can run the `migrate deploy` as part of your CI/CD pipeline.

The command should ideally be run as part of an automated CI/ CD pipeline and not running the command locally to deploy changes to the production database.

`migrate deploy` will:

- Compare applied changes with migration history
- Applies pending migrations
    
    Syncing the migration history (from your local environment) with the production database schema by applying the changes, and updating the `_prisma_migrations` table.
    

## Setup

You can continue working in the same `deep-dive-into-database-workflows` project that you set up in the previous lesson. However, the starter lesson is located in the `ci-cd-env` branch of the repo you cloned.

Before you switch to that branch, you need to commit the current state of your project. For simplicity, you can use the `stash` command to do this:

```
git stash

```

Switch to the `ci-cd-env` branch:

```
git checkout ci-cd-env

```

## Task

1. Create a `.github/workflows/test.yml` file at the root of the project’s directory
2. Add the configuration in the toggle to the file
- Config
    
    ```yaml
    name: test
    on: push
    
    jobs:
      test:
        runs-on: ubuntu-latest
        # Service containers to run with `container-job`
        services:
          # Label used to access the service container
          postgres:
            # Docker Hub image
            image: postgres
            # Provide the password for postgres
            env:
              POSTGRES_USER: postgres
              POSTGRES_PASSWORD: postgres
            options: >-
              --health-cmd pg_isready
              --health-interval 10s
              --health-timeout 5s
              --health-retries 5
            ports:
              # Maps tcp port 5432 on service container to the host
              - 5432:5432
        env:
          DATABASE_URL: postgresql://postgres:postgres@localhost:5432/migrate-deploy
    
        steps:
          - uses: actions/checkout@v2
          - uses: actions/setup-node@v3
            with:
              node-version: '14.x'
          - run: npm install
          # TODO: Add step to apply migration on test database
    ```
    
1. Update the `TODO` by adding a step to apply the migration to your database
2. Create a GitHub repository and push the changes
3. Take a look at the GitHub actions triggered

- Solution
    
    GitHub workflow file:
    
    ```yaml
    name: test
    on: push
    
    jobs:
      test:
        runs-on: ubuntu-latest
        # Service containers to run with `container-job`
        services:
          # Label used to access the service container
          postgres:
            # Docker Hub image
            image: postgres
            # Provide the password for postgres
            env:
              POSTGRES_USER: postgres
              POSTGRES_PASSWORD: postgres
            options: >-
              --health-cmd pg_isready
              --health-interval 10s
              --health-timeout 5s
              --health-retries 5
            ports:
              # Maps tcp port 5432 on service container to the host
              - 5432:5432
        env:
          DATABASE_URL: postgresql://postgres:postgres@localhost:5432/migrate-deploy
    
        steps:
          - uses: actions/checkout@v2
          - uses: actions/setup-node@v3
            with:
              node-version: '14.x'
          - run: npm install
          - run: npm run build
          # TODO: Add step to apply migration on test database
          **- run: npx prisma migrate deploy**
    ```