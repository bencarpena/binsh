/****** Object:  View [dbo].[vw_pr_ds0000_Ingested_Index]    Script Date: 10/16/2020 9:39:17 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[vw_pr_ds0000_Ingested_Index]

AS

/*
   
    
	Change log:
	-	20210913	:	@bencarpena	:	Creation date

*/

SELECT schema_name(tab.schema_id) + '.' + tab.name as [table],

        FORMAT((sum(part.rows)), 'N0') as [rows],
        (GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Central Standard Time') as [Query Time Stamp],
        tab.create_date,
        tab.modify_date


   from sys.tables as tab
        inner join sys.partitions as part
            on tab.object_id = part.object_id
where     part.index_id IN (1, 0) -- 0 - table without PK, 1 table with PK
          And 
               (    
                   tab.name not like 'x_%'
        
               )
group by schema_name(tab.schema_id) + '.' + tab.name, tab.create_date, tab.modify_date
--order by sum(part.rows) desc
GO



--##### timestamp of tables ######
/*
SELECT
        [name]
       ,create_date
       ,modify_date
FROM
        sys.tables
*/