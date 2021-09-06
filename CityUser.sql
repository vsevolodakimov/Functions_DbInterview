CREATE FUNCTION [dbo].[CityUser]
(
  @UserID INT -- id Участника
)
RETURNS TABLE
AS
RETURN(
		SELECT CASE WHEN T2.[Category] = 1 THEN 'Мужчина' ELSE 'Женщина' END AS 'Пол'
		       T2.[LastName] AS 'Фамилия',
			   T2.[FirstName] AS 'Имя',
			   T2.[MiddleName] AS 'Отчество',
			   T3.[CityName] AS 'Город'
		FROM [DbInterview].[dbo].[Users] AS T2
			 JOIN
			 [DbInterview].[dbo].[ListCities] AS T3
			 ON T2.[CityID] = T3.[ID]
		WHERE T2.UserID = @UserID
      )
GO