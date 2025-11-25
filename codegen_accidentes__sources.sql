{{
    codegen.generate_source(
        schema_name = 'ACCIDENTES',
        database_name = 'ALUMNO1_DEV_GOLD_DB',
        generate_columns = True,
        include_descriptions=True,
        include_data_types=True,
        name='modelos_silver',
        include_database=True,
        include_schema=True
        )
}}