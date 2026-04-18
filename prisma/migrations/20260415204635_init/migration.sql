-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Invite" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "slug" TEXT NOT NULL,
    "greeting" TEXT NOT NULL,
    "pronoun" TEXT NOT NULL DEFAULT 'вас',
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO "new_Invite" ("createdAt", "greeting", "id", "pronoun", "slug") SELECT "createdAt", "greeting", "id", "pronoun", "slug" FROM "Invite";
DROP TABLE "Invite";
ALTER TABLE "new_Invite" RENAME TO "Invite";
CREATE UNIQUE INDEX "Invite_slug_key" ON "Invite"("slug");
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
