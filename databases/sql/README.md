# SQL DataBases simple explanation

## Understanding basic SQL relationships, normalization and kimball

Dataset: https://www.kaggle.com/olistbr/brazilian-ecommerce

Scripts:
**/data_modelling**
- create_tables.sql      - Explaining about table relationships, fks and pks
- normlize_state.sql     - Explaining about normalization, data quality and a perfomance.
- insert_data_sql.ipynb  - Notebook to insert some data to sql.
- start_schema.sql       - Small Explanation over start-schemas and DataWareHousing

Creating postgres container:
    
    sudo docker run --name some-postgres -p 5432:5432 -e POSTGRES_PASSWORD=mysecretpassword -d postgres


Good materials:

- [Foreign keys](https://www.postgresqltutorial.com/postgresql-foreign-key/)
- [Primary keys](https://www.postgresqltutorial.com/postgresql-primary-key/)
- [Normalization](https://docs.microsoft.com/en-us/office/troubleshoot/access/database-normalization-description#:~:text=Normalization%20is%20the%20process%20of,eliminating%20redundancy%20and%20inconsistent%20dependency.)
- [Normalization Exemplo](https://www.guru99.com/database-normalization.html)
- [Kimball](https://www.holistics.io/books/setup-analytics/kimball-s-dimensional-data-modeling/)