SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER FUNCTION [dbo].[pr_fn_COFDA_CostOfFinding] ()  

/****************************************************************************************************************
	=========================================
	Function Returning a table 
	=========================================

	Note:
	-	Data is sourced from a fictional tables that hosts "refined" data 
    -   Data flow = RAW --> REFINED --> PRODUCED
    -   This view represents the MVP transformation which will feed t_rf and vw_pr series (aka lego bricks or data products)
    
	Change log:
	-	20210327	:	@bencarpena	:	new; v1

******************************************************************************************************************/



RETURNS TABLE 
AS
RETURN	(
		
			SELECT	p1.[Year], p1.SBU
					,
					dbo.fn_LeadP_Get_CostofFinding
					(
						p2.Total_Exploration,
						p1.Discoveries,
						p1.Extensions

					) as [Cost of Finding],
                    (
                        CASE 
                            When p1.Year = Year(GETDATE()) Then 
                                dbo.fn_LeadP_Get_CostofFinding_RollingAvg(p1.[Year], p1.SBU)
                            Else '---'

                        End

                    ) as [Rolling Average],
                   
                    '$/bbl' as [Unit]

		
			From	dbo.t_rf_ds1001_COFDA_DenoNR p1
					Inner Join dbo.t_rf_ds1001_COFDA_NumCostsPerHFM p2
					On 
					p2.SBU = p1.SBU AND p2.[Year] = p1.[Year]

			Where 
				p1.Discoveries <> 0 
				Or
				p1.Extensions <> 0

        UNION

        SELECT	Year(GETDATE()) as [Year], s1.SBU
					,
					'---' as [Cost of Finding],
                    dbo.fn_LeadP_Get_CostofFinding_RollingAvg(s1.[Year], s1.SBU) as [Rolling Average],
                   
                    '$/bbl' as [Unit]

			From	dbo.t_rf_ds1001_COFDA_DenoNR s1
					Inner Join dbo.t_rf_ds1001_COFDA_NumCostsPerHFM s2
					On 
					s2.SBU = s1.SBU AND s2.[Year] = s1.[Year]

			Where 
				s1.Discoveries <> 0 
				Or
				s1.Extensions <> 0

	

)






