/*
  Warnings:

  - You are about to drop the column `pronoun` on the `Invite` table. All the data in the column will be lost.

*/
-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Invite" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "slug" TEXT NOT NULL,
    "greeting" TEXT NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO "new_Invite" ("createdAt", "greeting", "id", "slug") SELECT "createdAt", "greeting", "id", "slug" FROM "Invite";
DROP TABLE "Invite";
ALTER TABLE "new_Invite" RENAME TO "Invite";
CREATE UNIQUE INDEX "Invite_slug_key" ON "Invite"("slug");
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
