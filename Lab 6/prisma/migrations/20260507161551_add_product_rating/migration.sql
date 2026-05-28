-- AlterTable
ALTER TABLE "products" ADD COLUMN     "is_available" BOOLEAN NOT NULL DEFAULT true,
ADD COLUMN     "rating" INTEGER;
