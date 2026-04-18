/*
  Warnings:

  - You are about to drop the column `greeting` on the `Guest` table. All the data in the column will be lost.
  - You are about to drop the column `plusOne` on the `Guest` table. All the data in the column will be lost.
  - You are about to drop the column `slug` on the `Guest` table. All the data in the column will be lost.
  - Added the required column `inviteId` to the `Guest` table without a default value. This is not possible if the table is not empty.

*/
-- CreateTable
CREATE TABLE "Invite" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "slug" TEXT NOT NULL,
    "greeting" TEXT NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Guest" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'notInvited',
    "comment" TEXT,
    "wineRed" BOOLEAN,
    "wineWhite" BOOLEAN,
    "strongAlcohol" TEXT,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "inviteId" INTEGER NOT NULL,
    CONSTRAINT "Guest_inviteId_fkey" FOREIGN KEY ("inviteId") REFERENCES "Invite" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Guest" ("comment", "createdAt", "id", "name", "status", "strongAlcohol", "wineRed", "wineWhite") SELECT "comment", "createdAt", "id", "name", "status", "strongAlcohol", "wineRed", "wineWhite" FROM "Guest";
DROP TABLE "Guest";
ALTER TABLE "new_Guest" RENAME TO "Guest";
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;

-- CreateIndex
CREATE UNIQUE INDEX "Invite_slug_key" ON "Invite"("slug");
