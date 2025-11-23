{% test valores_no_negativos(model, column_name) %}

   select *
   from {{ model }}
   where {{ column_name }} < 0

{% endtest %}