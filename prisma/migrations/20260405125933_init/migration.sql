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
    "inviteId" INTEGER,
    CONSTRAINT "Guest_inviteId_fkey" FOREIGN KEY ("inviteId") REFERENCES "Invite" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_Guest" ("comment", "createdAt", "id", "inviteId", "name", "status", "strongAlcohol", "wineRed", "wineWhite") SELECT "comment", "createdAt", "id", "inviteId", "name", "status", "strongAlcohol", "wineRed", "wineWhite" FROM "Guest";
DROP TABLE "Guest";
ALTER TABLE "new_Guest" RENAME TO "Guest";
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
