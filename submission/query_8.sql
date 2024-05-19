WITH
    yesterday AS (
        SELECT
            host,
            metric_name,
            metric_array,
            month_start
        FROM
            host_activity_reduced
        WHERE
            month_start = '2023-01-01'
    ),
    today AS (
        SELECT
            host,
            metric_name,
            metric_value,
            date
        FROM
            daily_web_metrics
        WHERE
            month_start = '2023-01-02'
    )
SELECT
    t.host,
    COALESCE(y.metric_name, t.metric_name) AS metric_name
FROM
    yesterday y
    FULL OUTER JOIN today t ON y.host = t.host
    AND y.metric_name = t.metric_name