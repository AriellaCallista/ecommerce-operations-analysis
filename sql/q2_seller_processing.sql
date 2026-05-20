SELECT
  s.seller_state,
  COUNT(DISTINCT o.seller_id) AS seller_count,
  COUNT(*) AS total_orders,
  ROUND(AVG(o.processing_days), 2) AS avg_processing_days,
  ROUND(APPROX_QUANTILES(o.processing_days, 100)[OFFSET(50)], 2) AS median_processing_days,
  ROUND(AVG(o.is_late) * 100, 1) AS late_rate_pct,
  ROUND(AVG(o.review_score), 2) AS avg_review_score
FROM `olist-ops-analysis.olist.orders_master` o
LEFT JOIN `olist-ops-analysis.olist.sellers` s
  USING (seller_id)
WHERE o.processing_days IS NOT NULL
GROUP BY s.seller_state
ORDER BY avg_processing_days DESC
