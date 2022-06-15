CREATE EXTENSION IF NOT EXISTS citext;
/*
  Warnings:

  - Changed the type of `name` on the `Product` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.

*/
-- AlterTable
ALTER TABLE "Product" DROP COLUMN "name",
ADD COLUMN     "name" CITEXT NOT NULL;
