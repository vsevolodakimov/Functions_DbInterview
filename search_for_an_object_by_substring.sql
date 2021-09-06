CREATE FUNCTION [dbo].[search_for_an_object_by_substring]
(
  @NameObject VARCHAR(50) --Объявление входящих параметров
)
RETURNS TABLE
AS
RETURN(
		WITH Description_object AS
		(
			SELECT DISTINCT
				   T2.id,	
				   T3.[name]	
			FROM [syscomments] AS T2
				 JOIN 
				 [sysobjects] AS T3
				 ON T2.[id] = T3.[id]
			WHERE T2.[text] LIKE '%' + @NameObject + '%'
		)
		SELECT @@SERVERNAME AS 'Сервер',
			   DB_NAME() AS 'База_данных',
			   OBJECT_SCHEMA_NAME(T2.[parent_object_id], DB_ID(DB_NAME())) AS 'Схема_родительского_объекта',
			   OBJECT_NAME(T2.[parent_object_id]) AS 'Родительский_объект',
			   SCHEMA_NAME(T2.[schema_id]) AS 'Схема',
			   T2.[name] AS 'Имя_объекта',
			   T6.[value] AS 'Описание_объекта',
			   T2.[type_desc] AS 'Тип_объекта',
			   T2.[create_date] AS 'Дата_создания_объекта',
			   T2.[modify_date] AS 'Дата_изменения_объекта'	
		FROM [sys].[objects] AS T2
			 LEFT JOIN 
			 [sys].[extended_properties] AS T6   
			 ON T2.[object_id] = T6.[major_id] AND T6.[minor_id] = 0 
			 JOIN
			 Description_object AS T4
			 ON T2.[object_id] = T4.[id]
      )
GO
