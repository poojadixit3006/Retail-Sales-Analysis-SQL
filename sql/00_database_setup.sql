CREATE TABLE retail.customers (
    customer_id VARCHAR(10) PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    segment VARCHAR(50) NOT NULL
);

CREATE TABLE retail.products (
    product_id VARCHAR(10) PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    sub_category VARCHAR(50) NOT NULL,
    unit_price NUMERIC(12, 2) NOT NULL
);

CREATE TABLE retail.sales (
    order_id VARCHAR(20) PRIMARY KEY,
    order_date DATE NOT NULL,
    ship_date DATE NOT NULL,

    customer_id VARCHAR(10) NOT NULL,
    product_id VARCHAR(10) NOT NULL,

    quantity INTEGER NOT NULL,
    unit_price NUMERIC(12, 2) NOT NULL,
    discount_percentage NUMERIC(5, 2) NOT NULL,

    sales NUMERIC(14, 2) NOT NULL,
    cost NUMERIC(14, 2) NOT NULL,
    profit NUMERIC(14, 2) NOT NULL,

    city VARCHAR(100) NOT NULL,
    state VARCHAR(100) NOT NULL,
    region VARCHAR(50) NOT NULL,
    salesperson VARCHAR(100) NOT NULL,
    payment_mode VARCHAR(50) NOT NULL,

    CONSTRAINT fk_customer
        FOREIGN KEY (customer_id)
        REFERENCES retail.customers(customer_id),

    CONSTRAINT fk_product
        FOREIGN KEY (product_id)
        REFERENCES retail.products(product_id)
);