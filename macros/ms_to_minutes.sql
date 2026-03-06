{% macro ms_to_minutes(column_name) %}
  safe_divide(cast({{ column_name }} as float64), 60000)
{% endmacro %}

