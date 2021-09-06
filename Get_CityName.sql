CREATE FUNCTION [dbo].[Get_CityName]
(
  @id INT --ќбъ¤вление вход¤щих параметров
)
RETURNS TABLE
AS
RETURN(
		SELECT [ID],
               [CityName]
        FROM [DbInterview].[dbo].[ListCities]
		WHERE [ID] = @id
      )
GO
