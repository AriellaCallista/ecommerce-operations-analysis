-- Q1: On-time delivery rate by state
-- What is the overall on time delivery rate and which states have the worst late delivery rates?

SELECT
  customer_state,
  COUNT(*) AS total_orders,
  SUM(is_late) as late_orders,
  ROUND(SUM(is_late) / COUNT(*) * 100, 1) AS late_rate_pct,
  ROUND(AVG(delivery_days), 1) AS avg_delivery_days,
  ROUND(AVG(delay_days), 1) AS avg_delay_days,
  RANK() OVER (ORDER BY SUM(is_late)/COUNT(*) DESC) AS rank_worst
FROM `olist-ops-analysis.olist.orders_master`
WHERE is_late IS NOT NULL
GROUP BY customer_state
ORDER BY late_rate_pct DESC
