-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Guest" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "slug" TEXT NOT NULL,
    "plusOne" BOOLEAN NOT NULL DEFAULT false,
    "greeting" TEXT,
    "status" TEXT NOT NULL DEFAULT 'notInvited',
    "comment" TEXT,
    "wineRed" BOOLEAN,
    "wineWhite" BOOLEAN,
    "strongAlcohol" TEXT,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO "new_Guest" ("comment", "createdAt", "greeting", "id", "name", "plusOne", "slug", "status", "strongAlcohol", "wineRed", "wineWhite") SELECT "comment", "createdAt", "greeting", "id", "name", "plusOne", "slug", "status", "strongAlcohol", "wineRed", "wineWhite" FROM "Guest";
DROP TABLE "Guest";
ALTER TABLE "new_Guest" RENAME TO "Guest";
CREATE UNIQUE INDEX "Guest_slug_key" ON "Guest"("slug");
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
