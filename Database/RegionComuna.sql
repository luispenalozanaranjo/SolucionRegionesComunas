CREATE DATABASE RegionComuna;
GO

USE [RegionComuna]
GO

/****** Object:  Table [dbo].[Region]    Script Date: 30/04/2025 16:59:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Region](
	[idRegion] [int] IDENTITY(1,1) NOT NULL,
	[Region] [nvarchar](128) NULL,
 CONSTRAINT [PK_Region] PRIMARY KEY CLUSTERED 
(
	[idRegion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


CREATE TABLE [dbo].[Comuna](
	[idComuna] [int] IDENTITY(1,1) NOT NULL,
	[idRegion] [int] NULL,
	[Comuna] [nvarchar](128) NULL,
	[InformacionAdicional] [xml] NULL,
 CONSTRAINT [PK_Comuna] PRIMARY KEY CLUSTERED 
(
	[idComuna] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[Comuna]  WITH CHECK ADD  CONSTRAINT [FK_Comuna_Region] FOREIGN KEY([idRegion])
REFERENCES [dbo].[Region] ([idRegion])
GO

ALTER TABLE [dbo].[Comuna] CHECK CONSTRAINT [FK_Comuna_Region]
GO


USE [RegionComuna]
GO

/****** Object:  StoredProcedure [dbo].[sp_ListarComunasPorRegion]    Script Date: 30/04/2025 17:02:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_ListarComunasPorRegion]
    @IdRegion INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        IdComuna,
        Comuna,
        InformacionAdicional
    FROM 
        Comuna
    WHERE 
        IdRegion = @IdRegion;
END;
GO

USE [RegionComuna]
GO

/****** Object:  StoredProcedure [dbo].[sp_ListarRegiones]    Script Date: 30/04/2025 17:03:16 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_ListarRegiones]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT IdRegion, Region
    FROM Region;
END;
GO


USE [RegionComuna]
GO

/****** Object:  StoredProcedure [dbo].[sp_MergeActualizarComuna]    Script Date: 30/04/2025 17:03:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_MergeActualizarComuna]
    @IdRegion INT,
    @IdComuna INT,
    @Comuna NVARCHAR(100),
    @InformacionAdicional NVARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON;

    MERGE INTO Comuna AS Target
    USING (SELECT @IdComuna AS IdComuna) AS Source
    ON (Target.IdComuna = Source.IdComuna)
    WHEN MATCHED THEN 
        UPDATE SET 
            Comuna = @Comuna,
            InformacionAdicional = @InformacionAdicional,
            IdRegion = @IdRegion
    WHEN NOT MATCHED THEN 
        INSERT (IdRegion, Comuna, InformacionAdicional)
        VALUES (@IdRegion, @Comuna, @InformacionAdicional);
END;
GO


USE [RegionComuna]
GO

/****** Object:  StoredProcedure [dbo].[sp_ObtenerComuna]    Script Date: 30/04/2025 17:03:53 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_ObtenerComuna]
    @IdRegion INT,
    @IdComuna INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        IdComuna,
        Comuna,
        InformacionAdicional
    FROM 
        Comuna
    WHERE 
        IdRegion = @IdRegion
        AND IdComuna = @IdComuna;
END;
GO


USE [RegionComuna]
GO

/****** Object:  StoredProcedure [dbo].[sp_ObtenerRegion]    Script Date: 30/04/2025 17:04:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_ObtenerRegion]
    @IdRegion INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        IdRegion,
        Region
    FROM 
        Region
    WHERE 
        IdRegion = @IdRegion;
END;
GO

--Region

INSERT INTO Region (IdRegion, Region) VALUES (1, 'Tarapacá');
INSERT INTO Region (IdRegion, Region) VALUES (2, 'Antofagasta');
INSERT INTO Region (IdRegion, Region) VALUES (3, 'Atacama');
INSERT INTO Region (IdRegion, Region) VALUES (4, 'Coquimbo');
INSERT INTO Region (IdRegion, Region) VALUES (5, 'Valparaíso');
INSERT INTO Region (IdRegion, Region) VALUES (6, 'Lib. Gral. Bernardo O''Higgins');
INSERT INTO Region (IdRegion, Region) VALUES (7, 'Maule');
INSERT INTO Region (IdRegion, Region) VALUES (8, 'Biobío');
INSERT INTO Region (IdRegion, Region) VALUES (9, 'La Araucanía');
INSERT INTO Region (IdRegion, Region) VALUES (10, 'Los Lagos');
INSERT INTO Region (IdRegion, Region) VALUES (11, 'Aysén del General Carlos Ibáñez del Campo');
INSERT INTO Region (IdRegion, Region) VALUES (12, 'Magallanes y Antártica Chilena');
INSERT INTO Region (IdRegion, Region) VALUES (13, 'Metropolitana de Santiago');
INSERT INTO Region (IdRegion, Region) VALUES (14, 'Los Ríos');
INSERT INTO Region (IdRegion, Region) VALUES (15, 'Arica y Parinacota');
INSERT INTO Region (IdRegion, Region) VALUES (16, 'Ñuble');

--Comuna

INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (1, 15, 'Arica', '<info><superficie>4799.4</superficie><Poblacion Densidad="51.6">247552</Poblacion></info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (2, 15, 'Camarones', '<info><superficie>3927</superficie><Poblacion Densidad="0.31">1233</Poblacion></info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (3, 15, 'Putre', '<info><superficie>5902.5</superficie><Poblacion Densidad="0.43">2515</Poblacion></info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (4, 15, 'General Lagos', '<Info><Superficie>10400</Superficie><Poblacion Densidad="0.19">2000</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (5, 1, 'Iquiqueu', '<info><superficie>2242.1</superficie><Poblacion Densidad="99.6">223463</Poblacion></info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (6, 1, 'Alto Hospicio', '<info><superficie>572.9</superficie><Poblacion Densidad="226.8">129999</Poblacion></info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (7, 1, 'Pozo Almonte', '<Info><Superficie>13765.8</Superficie><Poblacion Densidad="1.28">17656</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (8, 1, 'Camiña', '<Info><Superficie>2200</Superficie><Poblacion Densidad="0.62">1374</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (9, 1, 'Colchane', '<Info><Superficie>4150</Superficie><Poblacion Densidad="0.23">950</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (10, 1, 'Huara', '<Info><Superficie>10815.9</Superficie><Poblacion Densidad="0.29">3155</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (11, 1, 'Pica', '<Info><Superficie>8938.7</Superficie><Poblacion Densidad="1.59">14200</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (12, 2, 'Antofagasta', '<Info><Superficie>30718.1</Superficie><Poblacion Densidad="11.8">361873</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (13, 2, 'Mejillones', '<Info><Superficie>15317.2</Superficie><Poblacion Densidad="0.9">13642</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (14, 2, 'Sierra Gorda', '<Info><Superficie>12614.8</Superficie><Poblacion Densidad="0.12">1463</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (15, 2, 'Taltal', '<Info><Superficie>20105.7</Superficie><Poblacion Densidad="0.64">12919</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (16, 2, 'Calama', '<Info><Superficie>15496.9</Superficie><Poblacion Densidad="10.2">158289</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (17, 2, 'Ollagüe', '<Info><Superficie>3929</Superficie><Poblacion Densidad="0.15">600</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (18, 2, 'San Pedro de Atacama', '<Info><Superficie>23438</Superficie><Poblacion Densidad="0.85">20000</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (19, 2, 'Tocopilla', '<Info><Superficie>4054.7</Superficie><Poblacion Densidad="5.91">23986</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (20, 2, 'María Elena', '<Info><Superficie>12513.3</Superficie><Poblacion Densidad="0.58">7209</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (21, 3, 'Copiapó', '<Info><Superficie>16437</Superficie><Poblacion Densidad="9.64">158438</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (22, 3, 'Caldera', '<Info><Superficie>4666</Superficie><Poblacion Densidad="3.63">16922</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (23, 3, 'Tierra Amarilla', '<Info><Superficie>5524</Superficie><Poblacion Densidad="2.29">12617</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (24, 3, 'Chañaral', '<Info><Superficie>5857.1</Superficie><Poblacion Densidad="2.28">13343</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (25, 3, 'Diego de Almagro', '<Info><Superficie>18464.7</Superficie><Poblacion Densidad="0.73">13510</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (26, 3, 'Vallenar', '<Info><Superficie>7084.2</Superficie><Poblacion Densidad="7.39">52373</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (27, 3, 'Freirina', '<Info><Superficie>3330.5</Superficie><Poblacion Densidad="1.96">6537</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (28, 3, 'Huasco', '<Info><Superficie>1601.4</Superficie><Poblacion Densidad="5.91">9466</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (29, 3, 'Alto del Carmen', '<Info><Superficie>5972.6</Superficie><Poblacion Densidad="0.86">5151</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (30, 4, 'La Serena', '<Info><Superficie>1892.8</Superficie><Poblacion Densidad="104.7">198164</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (31, 4, 'Coquimbo', '<Info><Superficie>1429.3</Superficie><Poblacion Densidad="159.5">227943</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (32, 4, 'Andacollo', '<Info><Superficie>310.3</Superficie><Poblacion Densidad="34.4">10686</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (33, 4, 'La Higuera', '<Info><Superficie>4158.2</Superficie><Poblacion Densidad="0.98">4057</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (34, 4, 'Paihuano', '<Info><Superficie>1495.8</Superficie><Poblacion Densidad="3.04">4545</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (35, 4, 'Vicuña', '<Info><Superficie>7610.8</Superficie><Poblacion Densidad="3.68">28009</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (36, 4, 'Illapel', '<Info><Superficie>2629.1</Superficie><Poblacion Densidad="12.1">31679</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (37, 4, 'Canela', '<Info><Superficie>2196.6</Superficie><Poblacion Densidad="4.67">10259</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (38, 4, 'Los Vilos', '<Info><Superficie>1860.6</Superficie><Poblacion Densidad="9.53">17735</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (39, 4, 'Salamanca', '<Info><Superficie>3787.7</Superficie><Poblacion Densidad="6.84">25920</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (40, 4, 'Ovalle', '<Info><Superficie>3829.4</Superficie><Poblacion Densidad="29.5">113000</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (41, 4, 'Combarbalá', '<Info><Superficie>3629.7</Superficie><Poblacion Densidad="3.73">13532</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (42, 4, 'Monte Patria', '<Info><Superficie>4366</Superficie><Poblacion Densidad="7.08">30893</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (43, 4, 'Punitaqui', '<Info><Superficie>1224.5</Superficie><Poblacion Densidad="8.72">10673</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (44, 4, 'Río Hurtado', '<Info><Superficie>2333.3</Superficie><Poblacion Densidad="1.59">3708</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (45, 5, 'Valparaíso', '<Info><Superficie>401.6</Superficie><Poblacion Densidad="738.8">296655</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (46, 5, 'Casablanca', '<Info><Superficie>952.5</Superficie><Poblacion Densidad="27.7">26378</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (47, 5, 'Concón', '<Info><Superficie>76.9</Superficie><Poblacion Densidad="504.5">38800</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (48, 5, 'Juan Fernández', '<Info><Superficie>96.4</Superficie><Poblacion Densidad="10.6">1022</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (49, 5, 'Puchuncaví', '<Info><Superficie>437.7</Superficie><Poblacion Densidad="37.0">16198</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (50, 5, 'Quintero', '<Info><Superficie>148.9</Superficie><Poblacion Densidad="198.2">29519</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (51, 5, 'Viña del Mar', '<Info><Superficie>121.6</Superficie><Poblacion Densidad="2670.2">324836</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (52, 5, 'Isla de Pascua', '<Info><Superficie>163.6</Superficie><Poblacion Densidad="47.1">7750</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (53, 5, 'Quilpué', '<Info><Superficie>536.9</Superficie><Poblacion Densidad="344.7">185914</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (54, 5, 'Limache', '<Info><Superficie>293.8</Superficie><Poblacion Densidad="171.6">50479</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (55, 5, 'Olmué', '<Info><Superficie>231.8</Superficie><Poblacion Densidad="61.7">14307</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (56, 5, 'Villa Alemana', '<Info><Superficie>96.5</Superficie><Poblacion Densidad="2088.4">201735</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (57, 5, 'Quillota', '<Info><Superficie>302.7</Superficie><Poblacion Densidad="310.6">94130</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (58, 5, 'Calera', '<Info><Superficie>60.5</Superficie><Poblacion Densidad="1204.1">72902</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (59, 5, 'Hijuelas', '<Info><Superficie>267.2</Superficie><Poblacion Densidad="46.1">12320</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (60, 5, 'La Cruz', '<Info><Superficie>78.2</Superficie><Poblacion Densidad="418.2">32701</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (61, 5, 'Nogales', '<Info><Superficie>291.7</Superficie><Poblacion Densidad="41.4">12086</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (62, 5, 'San Antonio', '<Info><Superficie>404.5</Superficie><Poblacion Densidad="287.8">116671</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (63, 5, 'Algarrobo', '<Info><Superficie>175.6</Superficie><Poblacion Densidad="132.1">23202</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (64, 5, 'Cartagena', '<Info><Superficie>245.9</Superficie><Poblacion Densidad="136.9">33672</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (65, 5, 'El Quisco', '<Info><Superficie>50.5</Superficie><Poblacion Densidad="468.7">23664</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (66, 5, 'El Tabo', '<Info><Superficie>98.8</Superficie><Poblacion Densidad="263.1">25996</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (67, 5, 'Santo Domingo', '<Info><Superficie>275.7</Superficie><Poblacion Densidad="30.4">8387</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (68, 5, 'San Felipe', '<Info><Superficie>185.9</Superficie><Poblacion Densidad="433.7">80623</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (69, 5, 'Catemu', '<Info><Superficie>361.6</Superficie><Poblacion Densidad="28.7">10378</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (70, 5, 'Llaillay', '<Info><Superficie>349.1</Superficie><Poblacion Densidad="59.4">20751</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (71, 5, 'Panquehue', '<Info><Superficie>121.9</Superficie><Poblacion Densidad="58.6">7153</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (72, 5, 'Putaendo', '<Info><Superficie>1220.9</Superficie><Poblacion Densidad="6.4">7751</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (73, 5, 'Santa María', '<Info><Superficie>133.2</Superficie><Poblacion Densidad="61.5">8197</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (74, 5, 'Los Andes', '<Info><Superficie>1248.3</Superficie><Poblacion Densidad="64.1">80000</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (75, 5, 'Calle Larga', '<Info><Superficie>321.7</Superficie><Poblacion Densidad="41.7">13412</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (76, 5, 'Rinconada', '<Info><Superficie>122.4</Superficie><Poblacion Densidad="49.5">6059</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (77, 5, 'San Esteban', '<Info><Superficie>1357.1</Superficie><Poblacion Densidad="11.3">15331</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (78, 6, 'Rancaguak', '<Info><Superficie>260.3</Superficie><Poblacion Densidad="941.1">245665</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (79, 6, 'Codegua', '<Info><Superficie>286.1</Superficie><Poblacion Densidad="18.3">5238</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (80, 6, 'Coinco', '<Info><Superficie>98.2</Superficie><Poblacion Densidad="66.7">6550</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (81, 6, 'Coltauco', '<Info><Superficie>145.0</Superficie><Poblacion Densidad="73.2">10615</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (82, 6, 'Doñihue', '<Info><Superficie>78.2</Superficie><Poblacion Densidad="116.5">9113</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (83, 6, 'Graneros', '<Info><Superficie>112.8</Superficie><Poblacion Densidad="343.7">38794</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (84, 6, 'Las Cabras', '<Info><Superficie>749.2</Superficie><Poblacion Densidad="39.4">29527</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (85, 6, 'Machalí', '<Info><Superficie>291.8</Superficie><Poblacion Densidad="167.7">48917</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (86, 6, 'Malloa', '<Info><Superficie>112.6</Superficie><Poblacion Densidad="56.5">6371</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (87, 6, 'Mostazal', '<Info><Superficie>523.8</Superficie><Poblacion Densidad="49.1">25717</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (88, 6, 'Olivar', '<Info><Superficie>44.3</Superficie><Poblacion Densidad="153.7">6807</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (89, 6, 'Peumo', '<Info><Superficie>153.2</Superficie><Poblacion Densidad="67.3">10313</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (90, 6, 'Pichidegua', '<Info><Superficie>320.1</Superficie><Poblacion Densidad="36.3">11610</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (91, 6, 'Quinta de Tilcoco', '<Info><Superficie>94.7</Superficie><Poblacion Densidad="103.4">9796</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (92, 6, 'Rengo', '<Info><Superficie>733.8</Superficie><Poblacion Densidad="108.8">79846</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (93, 6, 'Requínoa', '<Info><Superficie>673.3</Superficie><Poblacion Densidad="41.6">28018</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (94, 6, 'San Vicente', '<Info><Superficie>497.2</Superficie><Poblacion Densidad="82.4">40990</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (95, 6, 'Pichilemu', '<Info><Superficie>749.1</Superficie><Poblacion Densidad="18.6">13913</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (96, 6, 'La Estrella', '<Info><Superficie>435.4</Superficie><Poblacion Densidad="5.3">2311</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (97, 6, 'Litueche', '<Info><Superficie>643.0</Superficie><Poblacion Densidad="7.3">4694</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (98, 6, 'Marchihue', '<Info><Superficie>1126.5</Superficie><Poblacion Densidad="2.9">3306</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (99, 6, 'Navidad', '<Info><Superficie>300.4</Superficie><Poblacion Densidad="11.8">3550</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (100, 6, 'Paredones', '<Info><Superficie>561.5</Superficie><Poblacion Densidad="5.5">3099</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (101, 6, 'Chepica', '<Info><Superficie>166.5</Superficie><Poblacion Densidad="68.2">11361</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (102, 6, 'Chépica', '<Info><Superficie>166.5</Superficie><Poblacion Densidad="68.2">11361</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (103, 6, 'Chimbarongo', '<Info><Superficie>497.9</Superficie><Poblacion Densidad="64.8">32245</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (104, 6, 'Lolol', '<Info><Superficie>596.9</Superficie><Poblacion Densidad="6.6">3953</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (105, 6, 'Nancagua', '<Info><Superficie>113.6</Superficie><Poblacion Densidad="130.1">14783</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (106, 6, 'Palmilla', '<Info><Superficie>112.2</Superficie><Poblacion Densidad="66.5">7464</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (107, 6, 'Peralillo', '<Info><Superficie>273.0</Superficie><Poblacion Densidad="24.7">6750</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (108, 6, 'Placilla', '<Info><Superficie>90.0</Superficie><Poblacion Densidad="78.7">7085</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (109, 6, 'Pumanque', '<Info><Superficie>561.5</Superficie><Poblacion Densidad="3.8">2129</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (110, 6, 'Santa Cruz', '<Info><Superficie>419.5</Superficie><Poblacion Densidad="88.4">37076</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (111, 7, 'Cauquenes', '<Info><Superficie>2126.3</Superficie><Poblacion Densidad="18.3">38906</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (112, 7, 'Chanco', '<Info><Superficie>549.9</Superficie><Poblacion Densidad="14.8">8135</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (113, 7, 'Pelluhue', '<Info><Superficie>371.4</Superficie><Poblacion Densidad="21.6">8025</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (114, 7, 'Curicó', '<Info><Superficie>1328.4</Superficie><Poblacion Densidad="122.7">163071</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (115, 7, 'Hualañé', '<Info><Superficie>629.0</Superficie><Poblacion Densidad="15.8">9934</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (116, 7, 'Licantén', '<Info><Superficie>225.6</Superficie><Poblacion Densidad="16.6">3747</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (117, 7, 'Molina', '<Info><Superficie>909.8</Superficie><Poblacion Densidad="75.6">68792</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (118, 7, 'Rauco', '<Info><Superficie>308.6</Superficie><Poblacion Densidad="28.5">8796</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (119, 7, 'Romeral', '<Info><Superficie>1597.1</Superficie><Poblacion Densidad="10.9">17392</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (120, 7, 'Sagrada Familia', '<Info><Superficie>548.8</Superficie><Poblacion Densidad="30.0">16476</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (121, 7, 'Teno', '<Info><Superficie>629.0</Superficie><Poblacion Densidad="61.3">38488</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (122, 7, 'Vichuquén', '<Info><Superficie>425.8</Superficie><Poblacion Densidad="5.2">2217</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (123, 7, 'Linares', '<Info><Superficie>1466.0</Superficie><Poblacion Densidad="75.7">110541</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (124, 7, 'Colbún', '<Info><Superficie>2899.8</Superficie><Poblacion Densidad="6.5">18843</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (125, 7, 'Longaví', '<Info><Superficie>1560.5</Superficie><Poblacion Densidad="25.0">39020</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (126, 7, 'Parral', '<Info><Superficie>1626.6</Superficie><Poblacion Densidad="41.5">67475</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (127, 7, 'Retiro', '<Info><Superficie>827.0</Superficie><Poblacion Densidad="45.1">37306</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (128, 7, 'San Javier', '<Info><Superficie>1313.4</Superficie><Poblacion Densidad="54.8">72029</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (129, 7, 'Villa Alegre', '<Info><Superficie>189.7</Superficie><Poblacion Densidad="112.1">21280</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (130, 7, 'Yerbas Buenas', '<Info><Superficie>262.1</Superficie><Poblacion Densidad="49.7">13025</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (131, 8, 'Concepción', '<Info><Superficie>221.6</Superficie><Poblacion Densidad="1396.5">309146</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (132, 8, 'Coronel', '<Info><Superficie>279.4</Superficie><Poblacion Densidad="845.2">236833</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (133, 8, 'Chiguayante', '<Info><Superficie>71.5</Superficie><Poblacion Densidad="2458.5">175845</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (134, 8, 'Florida', '<Info><Superficie>609.0</Superficie><Poblacion Densidad="13.5">8207</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (135, 8, 'Hualpén', '<Info><Superficie>53.5</Superficie><Poblacion Densidad="4377.9">234303</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (136, 8, 'Hualqui', '<Info><Superficie>530.5</Superficie><Poblacion Densidad="47.8">25336</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (137, 8, 'Lota', '<Info><Superficie>135.8</Superficie><Poblacion Densidad="740.1">100469</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (138, 8, 'Penco', '<Info><Superficie>108.6</Superficie><Poblacion Densidad="727.8">79006</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (139, 8, 'San Pedro de la Paz', '<Info><Superficie>112.5</Superficie><Poblacion Densidad="1760.6">197865</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (140, 8, 'Santa Juana', '<Info><Superficie>731.2</Superficie><Poblacion Densidad="10.7">7857</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (141, 8, 'Talcahuano', '<Info><Superficie>92.3</Superficie><Poblacion Densidad="3742.8">345574</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (142, 8, 'Tomé', '<Info><Superficie>494.5</Superficie><Poblacion Densidad="133.4">65997</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (143, 16, 'Bulnes', '<Info><Superficie>714.1</Superficie><Poblacion Densidad="32.9">23476</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (144, 16, 'Chillán', '<Info><Superficie>511.2</Superficie><Poblacion Densidad="582.9">297676</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (145, 16, 'Chillán Viejo', '<Info><Superficie>292.0</Superficie><Poblacion Densidad="147.6">43135</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (146, 16, 'Cobquecura', '<Info><Superficie>562.3</Superficie><Poblacion Densidad="8.5">4782</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (147, 16, 'Coelemu', '<Info><Superficie>342.3</Superficie><Poblacion Densidad="29.6">10122</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (148, 16, 'Coihueco', '<Info><Superficie>1794.3</Superficie><Poblacion Densidad="17.5">31421</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (149, 16, 'El Carmen', '<Info><Superficie>664.3</Superficie><Poblacion Densidad="15.8">10488</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (150, 16, 'Ninhue', '<Info><Superficie>401.2</Superficie><Poblacion Densidad="9.2">3691</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (151, 16, 'Ñiquén', '<Info><Superficie>493.9</Superficie><Poblacion Densidad="20.6">10175</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (152, 16, 'Pemuco', '<Info><Superficie>562.7</Superficie><Poblacion Densidad="18.1">10194</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (153, 16, 'Pinto', '<Info><Superficie>1177.3</Superficie><Poblacion Densidad="10.2">12055</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (154, 16, 'Portezuelo', '<Info><Superficie>282.7</Superficie><Poblacion Densidad="12.5">3536</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (155, 16, 'Quillón', '<Info><Superficie>423.0</Superficie><Poblacion Densidad="48.5">20534</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (156, 16, 'Quirihue', '<Info><Superficie>589.0</Superficie><Poblacion Densidad="19.8">11655</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (157, 16, 'Ránquil', '<Info><Superficie>248.3</Superficie><Poblacion Densidad="18.1">4488</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (158, 16, 'San Carlos', '<Info><Superficie>874.7</Superficie><Poblacion Densidad="80.4">70288</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (159, 16, 'San Fabián', '<Info><Superficie>1568.6</Superficie><Poblacion Densidad="2.3">3584</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (160, 16, 'San Ignacio', '<Info><Superficie>363.0</Superficie><Poblacion Densidad="32.5">11797</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (161, 16, 'San Nicolás', '<Info><Superficie>489.6</Superficie><Poblacion Densidad="25.7">12592</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (162, 16, 'Treguaco', '<Info><Superficie>312.6</Superficie><Poblacion Densidad="10.4">3249</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (163, 16, 'Yungay', '<Info><Superficie>823.5</Superficie><Poblacion Densidad="29.0">23903</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (164, 9, 'Temuco', '<Info><Superficie>464.0</Superficie><Poblacion Densidad="861.8">4001407</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (165, 9, 'Carahue', '<Info><Superficie>1330.5</Superficie><Poblacion Densidad="12.7">16926</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (166, 9, 'Cunco', '<Info><Superficie>1902.5</Superficie><Poblacion Densidad="11.5">21886</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (167, 9, 'Curarrehue', '<Info><Superficie>1171.3</Superficie><Poblacion Densidad="3.4">3928</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (168, 9, 'Freire', '<Info><Superficie>931.2</Superficie><Poblacion Densidad="33.6">31299</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (169, 9, 'Galvarino', '<Info><Superficie>568.2</Superficie><Poblacion Densidad="43.8">24867</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (170, 9, 'Gorbea', '<Info><Superficie>582.9</Superficie><Poblacion Densidad="30.4">17729</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (171, 9, 'Lautaro', '<Info><Superficie>901.0</Superficie><Poblacion Densidad="59.8">53893</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (172, 9, 'Loncoche', '<Info><Superficie>971.6</Superficie><Poblacion Densidad="21.8">21164</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (173, 9, 'Melipeuco', '<Info><Superficie>1345.5</Superficie><Poblacion Densidad="3.4">4607</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (174, 9, 'Nueva Imperial', '<Info><Superficie>547.6</Superficie><Poblacion Densidad="71.3">39024</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (175, 9, 'Padre Las Casas', '<Info><Superficie>400.7</Superficie><Poblacion Densidad="388.2">155051</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (176, 9, 'Perquenco', '<Info><Superficie>257.9</Superficie><Poblacion Densidad="44.7">11534</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (177, 9, 'Pitrufquén', '<Info><Superficie>580.0</Superficie><Poblacion Densidad="71.3">41389</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (178, 9, 'Pucón', '<Info><Superficie>1252.3</Superficie><Poblacion Densidad="16.8">21006</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (179, 9, 'Saavedra', '<Info><Superficie>870.4</Superficie><Poblacion Densidad="14.1">12271</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (180, 9, 'Teodoro Schmidt', '<Info><Superficie>649.9</Superficie><Poblacion Densidad="21.2">13768</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (181, 9, 'Toltén', '<Info><Superficie>857.0</Superficie><Poblacion Densidad="17.6">15091</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (182, 9, 'Vilcún', '<Info><Superficie>1420.9</Superficie><Poblacion Densidad="20.8">29609</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (183, 9, 'Villarrica', '<Info><Superficie>1760.5</Superficie><Poblacion Densidad="37.5">66033</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (184, 9, 'Cholchol', '<Info><Superficie>427.0</Superficie><Poblacion Densidad="23.6">10068</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (185, 14, 'Valdivia', '<Info><Superficie>1015.6</Superficie><Poblacion Densidad="169.8">172920</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (186, 14, 'Corral', '<Info><Superficie>584.9</Superficie><Poblacion Densidad="6.5">3817</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (187, 14, 'Lanco', '<Info><Superficie>532.4</Superficie><Poblacion Densidad="24.1">12845</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (188, 14, 'Los Lagos', '<Info><Superficie>1791.2</Superficie><Poblacion Densidad="15.2">27212</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (189, 14, 'Máfil', '<Info><Superficie>582.9</Superficie><Poblacion Densidad="12.8">7458</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (190, 14, 'Mariquina', '<Info><Superficie>1317.2</Superficie><Poblacion Densidad="13.2">17389</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (191, 14, 'Paillaco', '<Info><Superficie>896.7</Superficie><Poblacion Densidad="24.0">21502</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (192, 14, 'Panguipulli', '<Info><Superficie>3292.0</Superficie><Poblacion Densidad="10.8">35478</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (193, 10, 'Puerto Montt', '<Info><Superficie>1673.0</Superficie><Poblacion Densidad="213.2">356371</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (194, 10, 'Calbuco', '<Info><Superficie>590.0</Superficie><Poblacion Densidad="64.1">37884</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (195, 10, 'Cochamó', '<Info><Superficie>3910.0</Superficie><Poblacion Densidad="0.7">3001</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (196, 10, 'Fresia', '<Info><Superficie>1278.8</Superficie><Poblacion Densidad="14.2">18209</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (197, 10, 'Frutillar', '<Info><Superficie>831.4</Superficie><Poblacion Densidad="31.8">26470</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (198, 10, 'Los Muermos', '<Info><Superficie>1218.0</Superficie><Poblacion Densidad="14.6">17747</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (199, 10, 'Llanquihue', '<Info><Superficie>420.4</Superficie><Poblacion Densidad="50.0">21020</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (200, 10, 'Maullín', '<Info><Superficie>860.3</Superficie><Poblacion Densidad="16.5">14191</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (201, 10, 'Puerto Varas', '<Info><Superficie>4064.9</Superficie><Poblacion Densidad="18.9">76721</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (202, 10, 'Castro', '<Info><Superficie>473.5</Superficie><Poblacion Densidad="133.6">63243</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (203, 10, 'Ancud', '<Info><Superficie>1252.4</Superficie><Poblacion Densidad="36.8">46068</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (204, 10, 'Chonchi', '<Info><Superficie>1392.5</Superficie><Poblacion Densidad="16.3">22701</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (205, 10, 'Curaco de Vélez', '<Info><Superficie>80.0</Superficie><Poblacion Densidad="30.7">2456</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (206, 10, 'Dalcahue', '<Info><Superficie>1239.4</Superficie><Poblacion Densidad="18.4">22957</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (207, 10, 'Puqueldón', '<Info><Superficie>119.2</Superficie><Poblacion Densidad="25.6">3048</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (208, 10, 'Queilén', '<Info><Superficie>223.9</Superficie><Poblacion Densidad="8.5">1906</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (209, 10, 'Quellón', '<Info><Superficie>3115.6</Superficie><Poblacion Densidad="16.8">52313</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (210, 10, 'Quemchi', '<Info><Superficie>220.3</Superficie><Poblacion Densidad="27.7">6096</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (211, 10, 'Quinchao', '<Info><Superficie>160.0</Superficie><Poblacion Densidad="29.2">4671</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (212, 11, 'Coyhaique', '<Info><Superficie>7290.2</Superficie><Poblacion Densidad="9.9">72339</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (213, 11, 'Lago Verde', '<Info><Superficie>5405.8</Superficie><Poblacion Densidad="0.2">1112</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (214, 11, 'Aisén', '<Info><Superficie>11609.0</Superficie><Poblacion Densidad="1.5">17169</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (215, 11, 'Cisnes', '<Info><Superficie>13790.0</Superficie><Poblacion Densidad="0.6">8122</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (216, 11, 'Guaitecas', '<Info><Superficie>278.0</Superficie><Poblacion Densidad="10.0">2780</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (217, 11, 'Cochrane', '<Info><Superficie>8549.0</Superficie><Poblacion Densidad="0.3">2928</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (218, 11, 'O''Higgins', '<Info><Superficie>8199.5</Superficie><Poblacion Densidad="0.2">550</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (219, 11, 'Tortel', '<Info><Superficie>19930.6</Superficie><Poblacion Densidad="0.0">507</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (220, 11, 'Chile Chico', '<Info><Superficie>5748.0</Superficie><Poblacion Densidad="0.6">4572</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (221, 11, 'Río Ibáñez', '<Info><Superficie>5897.0</Superficie><Poblacion Densidad="0.5">3205</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (222, 12, 'Punta Arenas', '<Info><Superficie>17546.0</Superficie><Poblacion Densidad="8.5">145590</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (223, 12, 'Laguna Blanca', '<Info><Superficie>3705.0</Superficie><Poblacion Densidad="0.3">181</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (224, 12, 'Río Verde', '<Info><Superficie>9997.2</Superficie><Poblacion Densidad="0.1">358</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (225, 12, 'San Gregorio', '<Info><Superficie>5972.6</Superficie><Poblacion Densidad="0.1">667</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (226, 8, 'Lebu', '<Info><Superficie>561.4</Superficie><Poblacion Densidad="48.3">27100</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (227, 8, 'Arauco', '<Info><Superficie>956.1</Superficie><Poblacion Densidad="40.4">38679</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (228, 8, 'Cañete', '<Info><Superficie>1089.2</Superficie><Poblacion Densidad="33.9">37003</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (229, 8, 'Contulmo', '<Info><Superficie>638.8</Superficie><Poblacion Densidad="9.9">6330</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (230, 8, 'Curanilahue', '<Info><Superficie>994.3</Superficie><Poblacion Densidad="34">33892</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (231, 8, 'Los Álamos', '<Info><Superficie>599.1</Superficie><Poblacion Densidad="37.6">22524</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (232, 8, 'Tirúa', '<Info><Superficie>624.4</Superficie><Poblacion Densidad="17.6">11019</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (233, 8, 'Los Ángeles', '<Info><Superficie>1748.2</Superficie><Poblacion Densidad="125">218515</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (234, 8, 'Antuco', '<Info><Superficie>1884.1</Superficie><Poblacion Densidad="2.28">4306</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (235, 8, 'Cabrero', '<Info><Superficie>639.8</Superficie><Poblacion Densidad="48">30725</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (236, 8, 'Laja', '<Info><Superficie>339.8</Superficie><Poblacion Densidad="70.2">23873</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (237, 8, 'Mulchén', '<Info><Superficie>1925.3</Superficie><Poblacion Densidad="16.1">31041</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (238, 8, 'Nacimiento', '<Info><Superficie>934.9</Superficie><Poblacion Densidad="29.8">27944</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (239, 8, 'Negrete', '<Info><Superficie>156.5</Superficie><Poblacion Densidad="66.4">10429</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (240, 8, 'Quilaco', '<Info><Superficie>1123.7</Superficie><Poblacion Densidad="3.71">4179</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (241, 8, 'Quilleco', '<Info><Superficie>1121.8</Superficie><Poblacion Densidad="8.94">10032</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (242, 8, 'San Rosendo', '<Info><Superficie>92.4</Superficie><Poblacion Densidad="39.2">3611</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (243, 8, 'Santa Bárbara', '<Info><Superficie>1254.9</Superficie><Poblacion Densidad="11.6">14592</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (244, 8, 'Tucapel', '<Info><Superficie>914.9</Superficie><Poblacion Densidad="16.6">15205</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (245, 8, 'Yumbel', '<Info><Superficie>727</Superficie><Poblacion Densidad="30.4">22132</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (246, 8, 'Alto Biobío', '<Info><Superficie>2124.6</Superficie><Poblacion Densidad="3.18">6775</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (247, 9, 'Angol', '<Info><Superficie>1194.456</Superficie><Poblacion Densidad="90.7">5846</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (248, 9, 'Collipulli', '<Info><Superficie>1295.926</Superficie><Poblacion Densidad="10.6">14820</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (249, 9, 'Curacautín', '<Info><Superficie>1.664</Superficie><Poblacion Densidad="10.9">1781</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (250, 9, 'Ercilla', '<Info><Superficie>499.78</Superficie><Poblacion Densidad="90.6">4581</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (251, 9, 'Lonquimay', '<Info><Superficie>3914.211</Superficie><Poblacion Densidad="20.6">492</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (252, 9, 'Los Sauces', '<Info><Superficie>849.87</Superficie><Poblacion Densidad="40.6">5178</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (253, 9, 'Lumaco', '<Info><Superficie>1.119</Superficie><Poblacion Densidad="80.6">1005</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (254, 9, 'Purén', '<Info><Superficie>464.912</Superficie><Poblacion Densidad="20.5">1882</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (255, 9, 'Renaico', '<Info><Superficie>267.4</Superficie><Poblacion Densidad="40.4">1083</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (256, 9, 'Traiguén', '<Info><Superficie>908</Superficie><Poblacion Densidad="21.2">1931</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (257, 9, 'Victoria', '<Info><Superficie>1.256</Superficie><Poblacion Densidad="20.6">3546</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (258, 14, 'La Unión', '<Info><Superficie>2137</Superficie><Poblacion Densidad="50.6">39538</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (259, 14, 'Futrono', '<Info><Superficie>2267.515</Superficie><Poblacion Densidad="20.6">26167</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (260, 14, 'Lago Ranco', '<Info><Superficie>1763.310</Superficie><Poblacion Densidad="30.6">29258</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (261, 14, 'Río Bueno', '<Info><Superficie>2211.732</Superficie><Poblacion Densidad="40.6">92514</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (262, 10, 'Osorno', '<Info><Superficie>951</Superficie><Poblacion Densidad="182.3">173410</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (263, 10, 'Puerto Octay', '<Info><Superficie>1795.7</Superficie><Poblacion Densidad="5.11">9192</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (264, 10, 'Purranque', '<Info><Superficie>1458.8</Superficie><Poblacion Densidad="14.4">21080</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (265, 10, 'Puyehue', '<Info><Superficie>1597.9</Superficie><Poblacion Densidad="7.37">11787</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (266, 10, 'Río Negro', '<Info><Superficie>1265.7</Superficie><Poblacion Densidad="11.2">14275</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (267, 10, 'San Juan de la Costa', '<Info><Superficie>1.517</Superficie><Poblacion Densidad="5.03">7639</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (268, 10, 'San Pablo', '<Info><Superficie>637.3</Superficie><Poblacion Densidad="16.5">10553</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (269, 10, 'Chaitén', '<Info><Superficie>8470.5</Superficie><Poblacion Densidad="0.59">5020</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (270, 10, 'Futaleufú', '<Info><Superficie>1.280</Superficie><Poblacion Densidad="2.19">2806</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (271, 10, 'Hualaihué', '<Info><Superficie>2787.7</Superficie><Poblacion Densidad="3.41">9525</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (272, 10, 'Palena', '<Info><Superficie>2763.7</Superficie><Poblacion Densidad="0.66">1827</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (273, 12, 'Cabo de Hornos', '<Info><Superficie>15578.7</Superficie><Poblacion Densidad="0.13">1983</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (274, 12, 'Antártica', '<Info><Superficie>1250257.6</Superficie><Poblacion Densidad="0.0001">137</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (275, 12, 'Porvenir', '<Info><Superficie>9707.4</Superficie><Poblacion Densidad="0.75">7323</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (276, 12, 'Primavera', '<Info><Superficie>4253.4</Superficie><Poblacion Densidad="0.16">694</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (277, 12, 'Timaukel', '<Info><Superficie>10758.9</Superficie><Poblacion Densidad="0.02">282</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (278, 12, 'Natales', '<Info><Superficie>49924.1</Superficie><Poblacion Densidad="0.47">23782</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (279, 12, 'Torres del Paine', '<Info><Superficie>6.630</Superficie><Poblacion Densidad="0.15">1021</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (280, 13, 'Santiago', '<Info><Superficie>23.250</Superficie><Poblacion Densidad="875.9">3147218</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (281, 13, 'Cerrillos', '<Info><Superficie>21.88</Superficie><Poblacion Densidad="360.7">95642</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (282, 13, 'Cerro Navia', '<Info><Superficie>11</Superficie><Poblacion Densidad="12951.3">142465</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (283, 13, 'Conchalí', '<Info><Superficie>10.7</Superficie><Poblacion Densidad="12654.0">139195</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (284, 13, 'El Bosque', '<Info><Superficie>14.2</Superficie><Poblacion Densidad="12285.7">172000</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (285, 13, 'Estación Central', '<Info><Superficie>15</Superficie><Poblacion Densidad="13786.1">206792</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (286, 13, 'Huechuraba', '<Info><Superficie>44.8</Superficie><Poblacion Densidad="2500.6">112528</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (287, 13, 'Independencia', '<Info><Superficie>7</Superficie><Poblacion Densidad="20295.0">142065</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (288, 13, 'La Cisterna', '<Info><Superficie>10</Superficie><Poblacion Densidad="10043.4">100434</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (289, 13, 'La Florida', '<Info><Superficie>70.2</Superficie><Poblacion Densidad="35749.0">224335</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (290, 13, 'La Granja', '<Info><Superficie>10</Superficie><Poblacion Densidad="12255.7">122557</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (291, 13, 'La Pintana', '<Info><Superficie>30.6</Superficie><Poblacion Densidad="6107.5">189335</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (292, 13, 'La Reina', '<Info><Superficie>23</Superficie><Poblacion Densidad="4358.7">100252</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (293, 13, 'Las Condes', '<Info><Superficie>99</Superficie><Poblacion Densidad="33410.9">330759</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (294, 13, 'Lo Barnechea', '<Info><Superficie>1024</Superficie><Poblacion Densidad="121.1">124076</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (295, 13, 'Lo Espejo', '<Info><Superficie>7</Superficie><Poblacion Densidad="14837.8">103865</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (296, 13, 'Lo Prado', '<Info><Superficie>7</Superficie><Poblacion Densidad="14914.7">104403</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (297, 13, 'Macul', '<Info><Superficie>12.9</Superficie><Poblacion Densidad="10356.5">134635</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (298, 13, 'Maipú', '<Info><Superficie>135</Superficie><Poblacion Densidad="4254.4">578605</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (299, 13, 'Ñuñoa', '<Info><Superficie>16</Superficie><Poblacion Densidad="14717.1">250192</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (300, 13, 'Pedro Aguirre Cerda', '<Info><Superficie>10</Superficie><Poblacion Densidad="10780.3">107803</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (301, 13, 'Peñalolén', '<Info><Superficie>54</Superficie><Poblacion Densidad="4940.7">266798</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (302, 13, 'Providencia', '<Info><Superficie>14</Superficie><Poblacion Densidad="11267.7">157749</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (303, 13, 'Pudahuel', '<Info><Superficie>197</Superficie><Poblacion Densidad="1284.9">253139</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (304, 13, 'Quilicura', '<Info><Superficie>58</Superficie><Poblacion Densidad="4391.2">254694</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (305, 13, 'Quinta Normal', '<Info><Superficie>13</Superficie><Poblacion Densidad="10489.8">136368</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (306, 13, 'Recoleta', '<Info><Superficie>16</Superficie><Poblacion Densidad="11879.3">190070</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (307, 13, 'Renca', '<Info><Superficie>24</Superficie><Poblacion Densidad="6993.3">160847</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (308, 13, 'San Joaquín', '<Info><Superficie>9.7</Superficie><Poblacion Densidad="10348.5">103485</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (309, 13, 'San Miguel', '<Info><Superficie>10</Superficie><Poblacion Densidad="13305.9">133059</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (310, 13, 'San Ramón', '<Info><Superficie>7</Superficie><Poblacion Densidad="12358.5">86510</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (311, 13, 'Vitacura', '<Info><Superficie>28</Superficie><Poblacion Densidad="3456.2">96774</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (312, 13, 'Puente Alto', '<Info><Superficie>88</Superficie><Poblacion Densidad="7339.8">645909</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (313, 13, 'Pirque', '<Info><Superficie>445</Superficie><Poblacion Densidad="97.3">43368</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (314, 13, 'San José de Maipo', '<Info><Superficie>4994.8</Superficie><Poblacion Densidad="3.7">18644</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (315, 13, 'Colina', '<Info><Superficie>971</Superficie><Poblacion Densidad="185.7">180353</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (316, 13, 'Lampa', '<Info><Superficie>452</Superficie><Poblacion Densidad="280.7">126898</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (317, 13, 'Til Til', '<Info><Superficie>653</Superficie><Poblacion Densidad="32.8">21477</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (318, 13, 'San Bernardo', '<Info><Superficie>155</Superficie><Poblacion Densidad="2160.2">334836</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (319, 13, 'Buin', '<Info><Superficie>214</Superficie><Poblacion Densidad="512.3">109641</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (320, 13, 'Calera de Tango', '<Info><Superficie>73</Superficie><Poblacion Densidad="390.7">28525</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (321, 13, 'Paine', '<Info><Superficie>820</Superficie><Poblacion Densidad="100.9">82766</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (322, 13, 'Melipilla', '<Info><Superficie>1345</Superficie><Poblacion Densidad="105.2">141612</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (323, 13, 'Alhué', '<Info><Superficie>845</Superficie><Poblacion Densidad="8.7">7405</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (324, 13, 'Curacaví', '<Info><Superficie>693</Superficie><Poblacion Densidad="52.5">36430</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (325, 13, 'María Pinto', '<Info><Superficie>393</Superficie><Poblacion Densidad="37.8">14926</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (326, 13, 'San Pedro', '<Info><Superficie>788</Superficie><Poblacion Densidad="15.1">11953</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (327, 13, 'Talagante', '<Info><Superficie>126</Superficie><Poblacion Densidad="649.5">81838</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (328, 13, 'El Monte', '<Info><Superficie>118</Superficie><Poblacion Densidad="339.1">40014</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (329, 13, 'Isla de Maipo', '<Info><Superficie>189</Superficie><Poblacion Densidad="212.5">40171</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (330, 13, 'Padre Hurtado', '<Info><Superficie>80</Superficie><Poblacion Densidad="915.9">74188</Poblacion></Info>');
INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (331, 13, 'Peñaflor', '<Info><Superficie>69</Superficie><Poblacion Densidad="1464.6">101058</Poblacion></Info>');

SELECT 
    'INSERT INTO Region (IdRegion, Region) VALUES (' +
    CAST(IdRegion AS VARCHAR) + ', ''' +
    REPLACE(Region, '''', '''''') + ''');'
FROM Region;


SELECT 
    'INSERT INTO Comuna (IdComuna, IdRegion, Comuna, InformacionAdicional) VALUES (' + 
    CAST(IdComuna AS VARCHAR) + ', ' +
    CAST(IdRegion AS VARCHAR) + ', ''' +
    REPLACE(Comuna, '''', '''''') + ''', ''' +
    REPLACE(CAST(InformacionAdicional AS NVARCHAR(MAX)), '''', '''''') + ''');'
FROM Comuna;
