USE DragTimeWarehouse
GO

/* 
	Store procedure that returns the top X quarter mile times for a provided make. X is a parameter for number
	of records. 
*/
CREATE PROCEDURE spTopXQuarterMileETForYMake(@makeName NVARCHAR(255), @x INT)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT TOP(@x)
	  CarMake.makeName
	  ,CarModel.modelName
	  ,PerformanceData.[1 4 Mile ET]
	  ,PerformanceData.[1 4 Mile MPH]
	FROM
	  CarId
	  INNER JOIN PerformanceData
		ON CarId.carId = PerformanceData.carId
	  INNER JOIN CarMake
		ON CarId.makeId = CarMake.makeId
	  INNER JOIN CarModel
		ON CarId.modelId = CarModel.modelId AND CarMake.makeId = CarModel.makeId
	WHERE CarMake.makeName = @makeName
	ORDER BY PerformanceData.[1 4 Mile ET]
	
END
GO

/* 
	Store procedure that returns the top X quarter mile times for a provided make and a provided model. X is a parameter for number
	of records. 
*/
CREATE PROCEDURE spTopXQuarterMileETForYMakeAndZModel(@makeName NVARCHAR(255), @modelName NVARCHAR(255),@x INT)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT TOP(@x)
	  CarId.carId AS [CarId carId]
	  ,CarId.makeId AS [CarId makeId]
	  ,CarId.modelId AS [CarId modelId]
	  ,CarMake.makeId AS [CarMake makeId]
	  ,CarMake.makeName
	  ,CarModel.modelId AS [CarModel modelId]
	  ,CarModel.makeId AS [CarModel makeId]
	  ,CarModel.modelName
	  ,PerformanceData.carId AS [PerformanceData carId]
	  ,PerformanceData.[1 4 Mile ET]
	  ,PerformanceData.[1 4 Mile MPH]
	  ,PerformanceData.[1 8 Mile ET]
	  ,PerformanceData.[1 8 Mile MPH]
	FROM
	  CarId
	  INNER JOIN PerformanceData
		ON CarId.carId = PerformanceData.carId
	  INNER JOIN CarMake
		ON CarId.makeId = CarMake.makeId
	  INNER JOIN CarModel
		ON CarId.modelId = CarModel.modelId AND CarMake.makeId = CarModel.makeId
	WHERE CarMake.makeName = @makeName AND CarModel.modelName = @modelName
	ORDER BY PerformanceData.[1 4 Mile ET]
END

/* 
	Store procedure that returns the top quarter mile times for a range of weight. 
*/
CREATE PROCEDURE spTopQuarterMilebyWeight(@low INT, @high INT)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT
	  CarMake.makeName
	  ,CarModel.modelName
	  ,CarNDriverData.[Weight with driver (lbs)]
	  ,PerformanceData.[1 4 Mile ET]
	  ,PerformanceData.[1 4 Mile MPH]
	FROM
	  CarId
	  INNER JOIN CarNDriverData
		ON CarId.carId = CarNDriverData.carId
	  INNER JOIN PerformanceData
		ON CarId.carId = PerformanceData.carId
	  INNER JOIN CarMake
		ON CarId.makeId = CarMake.makeId
	  INNER JOIN CarModel
		ON CarId.modelId = CarModel.modelId AND CarMake.makeId = CarModel.makeId
	WHERE [Weight with driver (lbs)] IS NOT NULL AND ([Weight with driver (lbs)] BETWEEN @low AND @high)
END
GO