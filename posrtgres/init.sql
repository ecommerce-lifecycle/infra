-- Optional: schema/table banane ki zarurat nahi if JPA ddl-auto=update
-- CREATE TABLE product (...);

-- Seed data (optional)
INSERT INTO product (product_id, name, description, price, category, active, created_at, updated_at)
VALUES
  (gen_random_uuid(), 'iPhone 15', 'Latest Apple iPhone', 79999, 'Mobile', true, now(), now()),
  (gen_random_uuid(), 'Samsung Galaxy S23', 'Flagship Samsung phone', 74999, 'Mobile', true, now(), now());
