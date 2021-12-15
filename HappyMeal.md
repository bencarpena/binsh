# Happy Meal Protocol

### Domain Model
- Domain model (some literature call it Data Model)
- Organizes benchmarking data into domains
- Components:
    - Domains - e.g. ESG, Security
    - Items - represented by rows
    - Attributes - represented by columns
    - Values - represented by cells

- Domain Model starter here: C:\Users\bcarpena\OneDrive - Tesla\docs\MyEHS\_DataEngineering\benchmarkingmetrics

### Arch Notes 1 : Starter guides
- Key design, engineering and solution architecture concepts
- https://github.com/bencarpena/benchmarking/blob/main/_bdf/_readme/bm_arch_01_archnotes.md

### Arch Notes 2 : Optimized
- Data products must be optimized for consumption
- https://github.com/bencarpena/benchmarking/blob/main/_bdf/_readme/bm_arch_02_designnotes.md


### Arch Notes 3 : Data Ops
- Data Ops and Data Factory
- Refer to Level Up slides


### Making it real
> Concepts applied in the real world

#### Data transformation flows
- Data transformation flow : RAW --> REFINED --> PRODUCED --> ARCHIVED
- Sample of produced data product: https://github.com/bencarpena/benchmarking/blob/main/_bdf/ds0000/vw_pr_ds0000_MasterDomainModel.sql

#### Domain Model by-products
- We now have our :
    - One-stop-shop reference table
    - Decoder ring
    - Data catalogue

#### Transformations and Enrichments
- Key-enabler of automations in the data factory
    - Stored procedure with Cursor enabled
        - https://github.com/bencarpena/benchmarking/blob/main/_bdf/tsqls/archived/sp_pr_ds5001_TransformAndEnrich_BenchmarkingMetrics.sql
    - Stored procedure
        - https://github.com/bencarpena/benchmarking/blob/main/_bdf/tsqls/archived/sp_pr_ds1201_TransformAndEnrich_Routine_20201015.sql
        - https://github.com/bencarpena/benchmarking/blob/main/_bdf/tsqls/archived/sp_pr_ds1001_COFDA_GenerateSQLDataProducts.sql
        - https://github.com/bencarpena/benchmarking/blob/main/_bdf/tsqls/sp_pr_COFDA_Hyd_CostOfFinding.sql
    - User defined functions
        - Returns a table: https://github.com/bencarpena/binsh/blob/main/sqls/pr_fn_COFDA_CostOfFinding.sql
        - Returns a value: https://github.com/bencarpena/binsh/blob/main/sqls/pr_fn_LeadP_Get_CostofFindingnDeveloping_RollingAvg.sql

#### Lego bricks (aka data products)
- Form factor: SQL Views
    - dbo.vw_pr_ds8001_CP_BenchmarkingMetrics
        - https://github.com/bencarpena/benchmarking/blob/main/_bdf/tsqls/20200811_bak/vw_pr_ds5001_BenchmarkingMetrics.sql
    - restricted.vw_pr_ds1201_Resources_ResourceInventory
        - https://github.com/bencarpena/benchmarking/blob/main/_bdf/tsqls/20200811_bak/restricted.t_pr_ds1201_ResourceInventory_Reserves.sql
- Form factor: Parquet files
    - Data stored in data lake in parquet file format
