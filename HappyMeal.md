# Happy Meal Protocol

---
## Arch Notes 1 : Starter guides
- Key design, engineering and solution architecture concepts
- https://github.com/bencarpena/benchmarking/blob/main/_bdf/_readme/bm_arch_01_archnotes.md

## Arch Notes 2 : Optimized
- Data products must be optimized for consumption
- https://github.com/bencarpena/benchmarking/blob/main/_bdf/_readme/bm_arch_02_designnotes.md


## Arch Notes 3 : Data Ops
- Data Ops and Data Factory
- Refer to Level Up slides

---
## Making it real
> Concepts applied in the real world

### Data transformation flows
- Data transformation flow : RAW --> REFINED --> PRODUCED --> ARCHIVED
- Sample of produced data product: https://github.com/bencarpena/benchmarking/blob/main/_bdf/ds0000/vw_pr_ds0000_MasterDomainModel.sql

### Domain Model
- Domain model (some literature call it Data Model)
- Organizes benchmarking data into domains
- Components:
    - Domains - e.g. ESG, Security
    - Items - represented by rows
    - Attributes - represented by columns
    - Values - represented by cells

- Domain Model starter here: https://github.com/bencarpena/binsh/blob/main/ds0000_Domain_Model.xlsx

### Domain Model by-products
- We now have our :
    - One-stop-shop reference table
    - Decoder ring
    - Data catalogue

- Codes (queries + stored procs) referencing Domain Model
    - https://github.com/bencarpena/benchmarking/blob/main/_bdf/tsqls/20200811_bak/vw_pr_ds1001_COFDA_COFDAPerCountry.sql
    - https://github.com/bencarpena/benchmarking/blob/main/_bdf/tsqls/archived/sp_rf_ds5001_TransformAndEnrich_BenchmarkingMetrics.sql

### Transformations and Enrichments
>Depending on the data we are working with, there will be multiple levels of transformations. The first step almost always involves flattening your dataset.
- Key-enabler of automations in the data factory
    - Level 1 transforms : Flatten your data (create the DNA aka building block for the lego brick)
        - https://github.com/bencarpena/targetprocess/blob/main/sql/vw_rf_ds1101_aad_identities.sql
    - Level 2 transforms : Stored procedure with Cursor enabled
        - https://github.com/bencarpena/benchmarking/blob/main/_bdf/tsqls/archived/sp_pr_ds5001_TransformAndEnrich_BenchmarkingMetrics.sql
    - Level 3 transforms : Stored procedures that hydrate and produce data products
        - https://github.com/bencarpena/benchmarking/blob/main/_bdf/tsqls/archived/sp_pr_ds1201_TransformAndEnrich_Routine_20201015.sql
        - https://github.com/bencarpena/benchmarking/blob/main/_bdf/tsqls/archived/sp_pr_ds1001_COFDA_GenerateSQLDataProducts.sql
        - https://github.com/bencarpena/benchmarking/blob/main/_bdf/tsqls/sp_pr_COFDA_Hyd_CostOfFinding.sql
    - User defined functions
        - Returns a table: https://github.com/bencarpena/binsh/blob/main/sqls/pr_fn_COFDA_CostOfFinding.sql
        - Returns a value: https://github.com/bencarpena/binsh/blob/main/sqls/pr_fn_LeadP_Get_CostofFindingnDeveloping_RollingAvg.sql
---
## Lego bricks (aka data products; data products are ingredients of your Happy Meal!)
- Form factor: SQL Views
    - dbo.vw_pr_ds8001_CP_BenchmarkingMetrics
        - https://github.com/bencarpena/benchmarking/blob/main/_bdf/tsqls/20200811_bak/vw_pr_ds5001_BenchmarkingMetrics.sql
    - restricted.vw_pr_ds1201_Resources_ResourceInventory
        - https://github.com/bencarpena/benchmarking/blob/main/_bdf/tsqls/20200811_bak/restricted.t_pr_ds1201_ResourceInventory_Reserves.sql
    - dbo.vw_pr_ds1103_RealizedPrice_Monthly
        - https://github.com/bencarpena/benchmarking/blob/main/_bdf/tsqls/20200811_bak/vw_pr_ds1103_RealizedPrice_Monthly.sql
    - dbo.vw_pr_ds1101_UnitOperatingCost_Monthly
        - https://github.com/bencarpena/benchmarking/blob/main/_bdf/tsqls/20200811_bak/vw_pr_ds1101_UnitOperatingCost_Monthly.sql
- Form factor: Parquet files
    - Data stored in data lake in parquet file format
