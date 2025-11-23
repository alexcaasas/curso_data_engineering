{% macro motivo_toxicologico(cols) %}

(
    case
        -- Caso limpio: todos son '-'
        when (
            {% for col in cols %}
                {{ col }} = '-' {% if not loop.last %} and {% endif %}
            {% endfor %}
        )
        then 'Limpio'

        else (
            regexp_replace(
                -- Concatenamos solo valores positivos sin dejar || colgando
                {% for col in cols %}
                    (case 
                        when {{ col }} = '+' 
                            then '{{ col | replace("_", " ") }} y '
                        else '' 
                    end)
                    {% if not loop.last %} || {% endif %}
                {% endfor %}
            , ' y $', '')
        )
    end
)

{% endmacro %}
