SELECT 
  CASE
    WHEN delay_days <= -14 THEN '1. Early >14 days'
    WHEN delay_days <= -7  THEN '2. Early 7-14 days'
    WHEN delay_days <= 0   THEN '3. Early 0-7 days'
    WHEN delay_days <= 3   THEN '4. Late 1-3 days'
    WHEN delay_days <= 7   THEN '5. Late 4-7 days'
    WHEN delay_days <= 14  THEN '6. Late 8-14 days'
    ELSE                        '7. Late 14+ days'
  END AS delay_band,
  COUNT(*) AS order_count,
  ROUND(AVG(review_score), 2) AS avg_review_score,
  ROUND(AVG(delay_days), 1) AS avg_delay_days
FROM `olist-ops-analysis.olist.orders_master`
WHERE delay_days IS NOT NULL
  AND review_score IS NOT NULL
GROUP BY delay_band
ORDER BY delay_band
