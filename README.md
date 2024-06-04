# Deep Dive into Database Workflows with Prisma Migrate

This repository contains the starter project for the **Deep Dive into Database Workflows with Prisma Migrate** workshop by [Alex Ruheni](https://twitter.com/ruheni_alex).

# Welcome

👋 Welcome to the **Deep Dive into Database Workflows with Prisma Migrate** workshop.

# Prerequisites

In order to successfully complete the tasks in the workshop, you should have:

- [Node.js](https://nodejs.org/en/) installed on your machine (14.X / 16.x)
- It is recommended (but not required) to use [VS Code](https://code.visualstudio.com/) for the practical tasks
- [PostgreSQL VS Code](https://marketplace.visualstudio.com/items?itemName=cweijan.vscode-mysql-client2) extension for viewing the database(optional)
- A PostgreSQL database

> The workshop will use a database hosted on Docker. If you don’t have a local database set up, you can set up a cloud-hosted database on [Railway.app](http://Railway.app) for free.
> 

That's it 🙌 (*no prior knowledge about SQL or Prisma is required*)

# What you'll do

In this workshop, you’ll learn about migrations, the database schema, and the different workflows you can use when working with Prisma Migrate. 

You’ll start by getting a good understanding of what database migrations are and the problems that they solve. This lesson will be theoretical. *(lesson 1).*

Then, you’ll get started with schema prototyping with Prisma Migrate by defining a schema, evolving the schema, and monitoring the database’ schema state without migrations *(lesson 2)*.

Next, you'll learn how you can start tracking the migration history, and look at the state that Prisma Migrate looks at when determining the status of a migration *(lesson 3).*

In the 4th lesson, you’ll learn why you might need to edit migrations and how you can accomplish that.

You’ll then learn how you can run a migration in a CI/CD or production environment smoothly. *(lesson 5)*.

Finally, we’ll cover the different ways in which you can troubleshoot failed migrations. (lesson 6)

*Disclaimer*: The workflows that we’ll cover in this workshop are specific to the relational databases that Prisma supports – except PlanetScale.

# Lessons

[Migration fundamentals](https://www.notion.so/Migration-fundamentals-fac8131432ae4637b90e0360bcca15ef?pvs=21)

[Schema prototyping](https://www.notion.so/Schema-prototyping-b4087c5b2438467fb59c11ba67f55b4b?pvs=21)

[Developing with Prisma Migrate](https://www.notion.so/Developing-with-Prisma-Migrate-18be8cbebb0e4905b99c0a674c65e840?pvs=21)

[Customizing migrations](https://www.notion.so/Customizing-migrations-cb6b00fc1b5140609a48e29675fa5e32?pvs=21)

[Running Prisma Migrate in CI and Production](https://www.notion.so/Running-Prisma-Migrate-in-CI-and-Production-1edb43af5a4946798ab8029b492d5b9b?pvs=21)

[Troubleshooting failed migrations](https://www.notion.so/Troubleshooting-failed-migrations-0d8bebb88bed44578315e10722bdf049?pvs=21)

# What does a lesson look like?

A *lesson* is structured in two parts:

1. **Host walk-through:** At the beginning of each *lesson*, your host will walk you through the different *tasks* you'll encounter in this lesson. Please *be attentive* during that time and follow the host's explanations to be sure that you can accomplish the tasks yourself when you're working on them later. **Do not code along or work on the tasks yourself yet!** Instead, you can think of questions or raise anything that you don't understand (e.g., in the **Q & A** section of Zoom).
2. **Do it yourself:** Once the host is done showing and explaining the different tasks, you get dedicated time to work on the tasks yourself!

# Want to host this workshop yourself?

Hosting workshops is incredibly fun! 😄 It's also a great way to deepen your understanding of the topics you're teaching and giving back to the community by sharing your knowledge.

The materials for this workshop are free to use and can be shared with anyone you know! If you want to host this workshop yourself and want some advice on how to get started, feel free to [reach out](mailto:burk@prisma.io).

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

