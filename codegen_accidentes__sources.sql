{{
    codegen.generate_source(
        schema_name = 'ACCIDENTES_TRAFICO',
        database_name = 'ALUMNO1_DEV_BRONZE_DB',
        generate_columns = True,
        include_descriptions=True,
        include_data_types=True,
        name='desarrollo',
        include_database=True,
        include_schema=True
        )
}}