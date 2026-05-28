create table users
(
    user_id    serial
        primary key,
    first_name varchar(50)               not null,
    last_name  varchar(50)               not null,
    email      varchar(100)              not null
        unique,
    phone      varchar(50),
    password   varchar(100)              not null,
    created_at date default CURRENT_DATE not null
);

create table categories
(
    category_id   serial
        primary key,
    category_name varchar(100) not null
        unique,
    description   text
);

create table addresses
(
    address_id   serial
        primary key,
    user_id      integer      not null
        constraint fk_addresses_users
            references users,
    country      varchar(50)  not null,
    city         varchar(50)  not null,
    street       varchar(100) not null,
    house_number varchar(20)  not null,
    postal_code  varchar(20)
);

create table products
(
    product_id     serial
        primary key,
    name           varchar(100)   not null,
    description    text,
    price          numeric(10, 2) not null
        constraint products_price_check
            check (price > (0)::numeric),
    stock_quantity integer        not null
        constraint products_stock_quantity_check
            check (stock_quantity >= 0),
    category_id    integer        not null
        constraint fk_products_categories
            references categories
);

create table orders
(
    order_id     serial
        primary key,
    user_id      integer                                      not null
        constraint fk_orders_users
            references users,
    address_id   integer                                      not null
        constraint fk_orders_addresses
            references addresses,
    order_date   date        default CURRENT_DATE             not null,
    status       varchar(30) default 'new'::character varying not null,
    total_amount numeric(10, 2)                               not null
        constraint orders_total_amount_check
            check (total_amount >= (0)::numeric)
);

create table order_items
(
    order_item_id     serial
        primary key,
    order_id          integer        not null
        constraint fk_order_items_orders
            references orders,
    product_id        integer        not null
        constraint fk_order_items_products
            references products,
    quantity          integer        not null
        constraint order_items_quantity_check
            check (quantity > 0),
    price_at_purchase numeric(10, 2) not null
        constraint order_items_price_at_purchase_check
            check (price_at_purchase > (0)::numeric)
);

create table payments
(
    payment_id     serial
        primary key,
    order_id       integer        not null
        unique
        constraint fk_payments_orders
            references orders,
    payment_method varchar(50)    not null,
    payment_status varchar(30)    not null,
    payment_date   date,
    amount         numeric(10, 2) not null
        constraint payments_amount_check
            check (amount >= (0)::numeric)
);





