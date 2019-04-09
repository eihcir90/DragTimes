USE DragTimeWarehouse
GO

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