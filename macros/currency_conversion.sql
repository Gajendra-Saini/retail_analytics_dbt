{% macro convert_to_usd(column_name) %}
    {{ column_name }} * 0.032
{% endmacro %}
