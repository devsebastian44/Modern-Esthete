-- Clean up existing policies to avoid conflicts
DO $$ 
BEGIN
    -- Drop policies for User
    DROP POLICY IF EXISTS "Users can manage their own data" ON "User";
    -- Drop policies for Product
    DROP POLICY IF EXISTS "Public Read Access for Products" ON "Product";
    -- Drop policies for Category
    DROP POLICY IF EXISTS "Public Read Access for Categories" ON "Category";
    -- Drop policies for Address
    DROP POLICY IF EXISTS "Users can manage their own addresses" ON "Address";
    -- Drop policies for Cart
    DROP POLICY IF EXISTS "Users can manage their own carts" ON "Cart";
    -- Drop policies for CartItem
    DROP POLICY IF EXISTS "Users can manage their own cart items" ON "CartItem";
    -- Drop policies for Order
    DROP POLICY IF EXISTS "Users can manage their own orders" ON "Order";
    -- Drop policies for OrderItem
    DROP POLICY IF EXISTS "Users can manage their own order items" ON "OrderItem";
    -- Drop policies for bookmarks
    DROP POLICY IF EXISTS "Allow public delete" ON "bookmarks";
    DROP POLICY IF EXISTS "Allow public insert" ON "bookmarks";
    DROP POLICY IF EXISTS "Users can manage their own bookmarks" ON "bookmarks";
    -- Drop policies for comments
    DROP POLICY IF EXISTS "Allow public insert" ON "comments";
    DROP POLICY IF EXISTS "Users can manage their own comments" ON "comments";
    DROP POLICY IF EXISTS "Public read for comments" ON "comments";
    -- Drop policies for likes
    DROP POLICY IF EXISTS "Allow public delete" ON "likes";
    DROP POLICY IF EXISTS "Allow public insert" ON "likes";
    DROP POLICY IF EXISTS "Users can manage their own likes" ON "likes";
    DROP POLICY IF EXISTS "Public read for likes" ON "likes";
END $$;

-- Enable RLS for all tables (Safe to run multiple times)
ALTER TABLE "User" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "Product" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "Category" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "Order" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "OrderItem" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "Cart" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "CartItem" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "Address" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "bookmarks" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "comments" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "likes" ENABLE ROW LEVEL SECURITY;

-- 1. Product and Category (Public Read-Only)
CREATE POLICY "Public Read Access for Products" ON "Product"
  FOR SELECT USING (true);

CREATE POLICY "Public Read Access for Categories" ON "Category"
  FOR SELECT USING (true);

-- 2. User (Owner access)
CREATE POLICY "Users can manage their own data" ON "User"
  FOR ALL USING (auth.uid()::text = id);

-- 3. Address (Owner access)
CREATE POLICY "Users can manage their own addresses" ON "Address"
  FOR ALL USING (auth.uid()::text = "userId");

-- 4. Cart (Owner access)
CREATE POLICY "Users can manage their own carts" ON "Cart"
  FOR ALL USING (auth.uid()::text = "userId");

-- 5. CartItem (Owner access via Cart)
CREATE POLICY "Users can manage their own cart items" ON "CartItem"
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM "Cart"
      WHERE "Cart".id = "CartItem"."cartId"
      AND "Cart"."userId" = auth.uid()::text
    )
  );

-- 6. Order (Owner access)
CREATE POLICY "Users can manage their own orders" ON "Order"
  FOR ALL USING (auth.uid()::text = "userId");

-- 7. OrderItem (Owner access via Order)
CREATE POLICY "Users can manage their own order items" ON "OrderItem"
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM "Order"
      WHERE "Order".id = "OrderItem"."orderId"
      AND "Order"."userId" = auth.uid()::text
    )
  );

-- 8. Bookmarks (Owner access)
CREATE POLICY "Users can manage their own bookmarks" ON "bookmarks"
  FOR ALL USING (auth.uid() = user_id);

-- 9. Comments (Public read, Owner management)
CREATE POLICY "Public read for comments" ON "comments"
  FOR SELECT USING (true);
CREATE POLICY "Users can manage their own comments" ON "comments"
  FOR ALL USING (auth.uid() = user_id);

-- 10. Likes (Public read, Owner management)
CREATE POLICY "Public read for likes" ON "likes"
  FOR SELECT USING (true);
CREATE POLICY "Users can manage their own likes" ON "likes"
  FOR ALL USING (auth.uid() = user_id);

-- Grant all to authenticated users if needed for PostgREST
-- Note: Prisma bypasses this, but Supabase Auth users might need it
GRANT ALL ON ALL TABLES IN SCHEMA public TO authenticated;
GRANT ALL ON ALL SEQUENCES IN SCHEMA public TO authenticated;
GRANT ALL ON ALL FUNCTIONS IN SCHEMA public TO authenticated;
