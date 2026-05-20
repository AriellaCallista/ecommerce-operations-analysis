SELECT
  FORMAT_DATE('%Y-%m', DATE(order_purchase_timestamp)) AS order_month,
  COUNT(DISTINCT order_id) AS total_orders,
  ROUND(SUM(total_revenue), 0) AS total_revenue,
  ROUND(AVG(delivery_days), 1) AS avg_delivery_days,
  ROUND(SUM(is_late) / COUNT(*) * 100, 1) AS late_rate_pct,
  ROUND(AVG(review_score), 2) AS avg_review_score
FROM `olist-ops-analysis.olist.orders_master`
WHERE order_purchase_timestamp IS NOT NULL
GROUP BY order_month
ORDER BY order_month

