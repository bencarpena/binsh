SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER    Function [dbo].[pr_fn_LeadP_Get_CostofFindingnDeveloping_RollingAvg] (
                                        @SYear nvarchar(4),
                                        @SBU nvarchar(50)
                                                    )
RETURNS nvarchar(50)
AS


/****************************************************************************************************************
	=========================================
	Function Returning a string 
	=========================================

	Note:
	-	Function computes for rolling average
	-	Data is sourced from a fictional tables that hosts "refined" data 
    -   Data flow = RAW --> REFINED --> PRODUCED
    -   This view represents the MVP transformation which will feed t_rf and vw_pr series (aka lego bricks or data products)
    
	Change log:
	-	20210327	:	@bencarpena	:	new; v1

******************************************************************************************************************/




BEGIN 

Declare @COFDRollAvg float
Declare @msg nvarchar(200)
Declare @expcosts float, @devcosts float, @discoveries float, @extensions float, @improvedrecovery float, @revisions float


SET @SYear = Rtrim(Ltrim(UPPER((@SYear))))
SET @SBU = Rtrim(Ltrim(UPPER((@SBU))))


--> //  SET PRECONDITIONS : AUTO MATCH  //

IF (@SYear) = '' or (@SBU) = ''
    Begin
        SET @msg = 'Error : Required parameters missing.'
		SET @COFDRollAvg = -1
    End
Else
    Begin
        SET @msg = 'Success!'
        SET @COFDRollAvg = 0 

        --#### Compute for rolling average ####
		
        SELECT
			
			@expcosts = SUM(s2.Total_Exploration),
			@devcosts = SUM(s2.Total_Development),
			@discoveries = SUM(s1.Discoveries),
			@extensions = SUM(s1.Extensions),
			@improvedrecovery = SUM(s1.Improved_Recoveries),
			@revisions = SUM(s1.Revisions)


            From    dbo.t_rf_ds1001_COFDA_DenoNR s1
                    Inner Join dbo.t_rf_ds1001_COFDA_NumCostsPerHFM s2
                    On 
                    s2.SBU = s1.SBU AND s2.[Year] = s1.[Year]


			Where 
					s1.SBU = @SBU 
					And (
							s1.Discoveries <> 0 
							Or
							s1.Extensions <> 0
							Or
							s1.Revisions <> 0
							Or
							s1.Improved_Recoveries <> 0
						)
			Group by s1.SBU



		 SET @COFDRollAvg = ( (@expcosts + @devcosts) / (@discoveries + @extensions + @improvedrecovery + @revisions ))

    End




RETURN @COFDRollAvg




END
    



