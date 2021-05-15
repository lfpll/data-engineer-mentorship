-- Start of explanation of a star schema
-- Ask for the mentored to develop the rest

CREATE TABLE "fact_orders" (
  "id" int,
  "date_id" int,
  "customer_id" int,
  "seller_id" int,
  "order_id" int,
  "order_item_id" int,
  "preco_do_item" float,
  "custo_do_frete" float
);

CREATE TABLE "dim_customer" (
  "customer_id" int,
  "customer_name" string,
  "customer_zip_code" string,
  "customer_state" string,
  "cusomter_city" string
);

CREATE TABLE "dim_seller" (
  "seller_id" int,
  "seller_name" string,
  "seller_zip_code" string,
  "seller_state" string,
  "seller_city" string,
  "seller_score" int
);

CREATE TABLE "order_item" (
  "order_item_id" int,
  "shipping_limit_date" int,
  "product_category_name" string,
  "product_name_lenght" int,
  "product_description_lenght" int,
  "product_photos_qty" int,
  "product_weigth_g" int,
  "product_lenght_cm" int,
  "product_height_cm" int,
  "product_widht_cm" int
);

ALTER TABLE "dim_customer" ADD FOREIGN KEY ("customer_id") REFERENCES "fact_orders" ("customer_id");

ALTER TABLE "dim_seller" ADD FOREIGN KEY ("seller_id") REFERENCES "fact_orders" ("seller_id");

ALTER TABLE "order_item" ADD FOREIGN KEY ("order_item_id") REFERENCES "fact_orders" ("order_item_id");
