# Deep Dive into Database Workflows with Prisma Migrate

This repository contains the starter project for the **Deep Dive into Database Workflows with Prisma Migrate** workshop by [Alex Ruheni](https://twitter.com/ruheni_alex).

## Setup

### Clone this repository

You can clone this repository with the following command:

```
git clone git@github.com:ruheni/deep-dive-into-database-workflows.git
```

### Install dependencies

```
cd deep-dive-into-database-workflows
npm install
```

### Set up the development database with Docker

```
docker-compose up -d
```

If you don't have Docker or PostgreSQL set up on your computer, you can set one up for free on [Railway](https://railway.app/).

Rename `.env.example` file to `.env`.

Update your database's connection string in your `.env` file.

