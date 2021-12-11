	--1	Count all records ingested
	SELECT FORMAT(SUM(CAST(REPLACE(rows, ',', '') as int)), 'N0') + ' rows' as Record_Count 
    From dbo.vw_pr_ds0000_Ingested_Index


	--2 Display all ingested data with row counts
	SELECT * From dbo.vw_pr_ds0000_Ingested_Index