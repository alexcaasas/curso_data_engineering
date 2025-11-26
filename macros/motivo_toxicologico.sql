{% macro motivo_toxicologico(cols) %}

    (
        case
            when
                (
                    {% for col in cols %}
                        {{ col }} = '-' {% if not loop.last %} and {% endif %}
                    {% endfor %}
                )
            then 'Limpio'

            else
                (
                    regexp_replace(
                        {% for col in cols %}
                            (
                                case
                                    when {{ col }} = '+'
                                    then '{{ col | replace("_", " ") }} y '
                                    else ''
                                end
                            )
                            {% if not loop.last %} || {% endif %}
                        {% endfor %},
                        ' y $',
                        ''
                    )
                )
        end
    )

{% endmacro %}
