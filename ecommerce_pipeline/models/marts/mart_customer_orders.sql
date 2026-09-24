with orders as (
    select * from {{ ref('int_orders_with_payments') }}
),

customers as (
    select * from {{ ref('stg_customers') }}
),

order_items as (
    select
        order_id,
        count(order_item_id) as total_items,
        sum(price) as total_items_value,
        sum(freight_value) as total_freight_value
    from {{ ref('stg_order_items') }}
    group by order_id
),

final as (
    select
        c.customer_unique_id,
        c.customer_city,
        c.customer_state,
        count(o.order_id) as total_orders,
        sum(o.total_payment_value) as lifetime_value,
        avg(o.total_payment_value) as avg_order_value,
        sum(i.total_items) as total_items_purchased,
        min(o.order_purchased_at) as first_order_date,
        max(o.order_purchased_at) as last_order_date
    from customers c
    left join orders o on c.customer_id = o.customer_id
    left join order_items i on o.order_id = i.order_id
    group by 1, 2, 3
)

select * from final
