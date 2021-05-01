CREATE TABLE public.customers (
	customer_id text NULL UNIQUE PRIMARY KEY,
	customer_unique_id text NOT NULL,
	customer_zip_code_prefix int8 NULL,
	customer_city text NULL,
	customer_state text NULL
);


CREATE TABLE public.orders (
	order_id text PRIMARY KEY,
	customer_id text unique NULL,
	order_status text NULL,
	order_purchase_timestamp text NULL,
	order_approved_at text NULL,
	order_delivered_carrier_date text NULL,
	order_delivered_customer_date text NULL,
	order_estimated_delivery_date text NULL,
    CONSTRAINT fk_order
      FOREIGN KEY(customer_id) 
	  REFERENCES customers(customer_id)
	  ON DELETE CASCADE
);



CREATE TABLE public.order_itens (
	order_id text PRIMARY KEY,
	order_item_id int8 NULL,
	product_id text NULL,
	seller_id text NULL,
	shipping_limit_date text NULL,
	price float8 NULL,
	freight_value float8 NULL,
    CONSTRAINT fk_order
      FOREIGN KEY(order_id) 
	  REFERENCES orders(order_id)
	  ON DELETE CASCADE
);

