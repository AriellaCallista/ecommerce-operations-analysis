WITH category_metrics AS (
  SELECT
    p.product_category_name_english AS category,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(AVG(o.review_score), 2) AS avg_review_score,
    ROUND(SUM(o.is_late) / COUNT(*) * 100, 1) AS late_rate_pct,
    ROUND(AVG(o.delivery_days), 1) AS avg_delivery_days,
    ROUND(AVG(o.total_revenue), 2) AS avg_order_value
  FROM `olist-ops-analysis.olist.orders_master` o
  LEFT JOIN `olist-ops-analysis.olist.order_items` i
    ON o.order_id = i.order_id
  LEFT JOIN `olist-ops-analysis.olist.products` p
    ON i.product_id = p.product_id
  WHERE p.product_category_name_english IS NOT NULL
    AND p.product_category_name_english != 'unknown'
  GROUP BY category
  HAVING COUNT(DISTINCT o.order_id) >= 50
)
SELECT *,
  RANK() OVER (ORDER BY late_rate_pct DESC) AS rank_latest
FROM category_metrics
ORDER BY late_rate_pct DESC
LIMIT 20
