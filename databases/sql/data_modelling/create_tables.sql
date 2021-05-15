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
	  ON DELETE SET NULL
);



CREATE TABLE public.geolocation (
	geolocation_zip_code_prefix int8 not null ,
	geolocation_lat float8 NULL,
	geolocation_lng float8 NULL,
	geolocation_city text NULL,
	geolocation_state text NULL
);

CREATE TABLE public.sellers (
	seller_id text PRIMARY KEY,
	seller_zip_code_prefix int8 NULL,
	seller_city text NULL,
	seller_state text null
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
	  ON DELETE SET null,
	CONSTRAINT fk_seller
      FOREIGN KEY(seller_id) 
	  REFERENCES sellers(seller_id)
	  ON DELETE SET null,
	CONSTRAINT fk_product
      FOREIGN KEY (product_id) 
	  REFERENCES products(product_id)
	  ON DELETE SET NULL
);


CREATE TABLE public.order_reviews (
	review_id text PRIMARY KEY,
	order_id text NULL,
	review_score int8 NULL,
	review_comment_title text NULL,
	review_comment_message text NULL,
	review_creation_date text NULL,
	review_answer_timestamp text null,
	CONSTRAINT fk_order
      FOREIGN KEY(order_id) 
	  REFERENCES orders(order_id)
	  ON DELETE SET NULL
);

CREATE TABLE public.products (
	product_id text PRIMARY KEY,
	product_category_name text NULL,
	product_name_lenght float8 NULL,
	product_description_lenght float8 NULL,
	product_photos_qty float8 NULL,
	product_weight_g float8 NULL,
	product_length_cm float8 NULL,
	product_height_cm float8 NULL,
	product_width_cm float8 NULL

);




