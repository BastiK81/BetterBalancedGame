--==========
-- Inca
--==========
UPDATE Units SET Combat=25, RangedCombat=40 WHERE UnitType='UNIT_INCA_WARAKAQ';

-- 24/05/2021: Change era from game to personal.
UPDATE Requirements SET RequirementType='REQUIREMENT_PLAYER_ERA_AT_LEAST' WHERE RequirementId='REQUIRES_ERA_ATLEASTEXPANSION_INDUSTRIAL';

INSERT INTO Modifiers(ModifierId, ModifierType) VALUES
    ('BBG_INTERNATIONAL_TRADE_ROUTE_GOLD_GRASS_MOUNTAIN_ORIGIN', 'MODIFIER_PLAYER_ADJUST_TRADE_ROUTE_YIELD_PER_TERRAIN_INTERNATIONAL'),
    ('BBG_INTERNATIONAL_TRADE_ROUTE_GOLD_PLAIN_MOUNTAIN_ORIGIN', 'MODIFIER_PLAYER_ADJUST_TRADE_ROUTE_YIELD_PER_TERRAIN_INTERNATIONAL'),
    ('BBG_INTERNATIONAL_TRADE_ROUTE_GOLD_DESERT_MOUNTAIN_ORIGIN', 'MODIFIER_PLAYER_ADJUST_TRADE_ROUTE_YIELD_PER_TERRAIN_INTERNATIONAL'),
    ('BBG_INTERNATIONAL_TRADE_ROUTE_GOLD_TUNDRA_MOUNTAIN_ORIGIN', 'MODIFIER_PLAYER_ADJUST_TRADE_ROUTE_YIELD_PER_TERRAIN_INTERNATIONAL'),
    ('BBG_INTERNATIONAL_TRADE_ROUTE_GOLD_SNOW_MOUNTAIN_ORIGIN', 'MODIFIER_PLAYER_ADJUST_TRADE_ROUTE_YIELD_PER_TERRAIN_INTERNATIONAL');
INSERT INTO ModifierArguments(ModifierId, Name, Value) VALUES
    ('BBG_INTERNATIONAL_TRADE_ROUTE_GOLD_GRASS_MOUNTAIN_ORIGIN', 'Origin', '1'),
    ('BBG_INTERNATIONAL_TRADE_ROUTE_GOLD_GRASS_MOUNTAIN_ORIGIN', 'Amount', '1'),
    ('BBG_INTERNATIONAL_TRADE_ROUTE_GOLD_GRASS_MOUNTAIN_ORIGIN', 'TerrainType', 'TERRAIN_GRASS_MOUNTAIN'),
    ('BBG_INTERNATIONAL_TRADE_ROUTE_GOLD_GRASS_MOUNTAIN_ORIGIN', 'YieldType', 'YIELD_GOLD'),
    ('BBG_INTERNATIONAL_TRADE_ROUTE_GOLD_PLAIN_MOUNTAIN_ORIGIN', 'Origin', '1'),
    ('BBG_INTERNATIONAL_TRADE_ROUTE_GOLD_PLAIN_MOUNTAIN_ORIGIN', 'Amount', '1'),
    ('BBG_INTERNATIONAL_TRADE_ROUTE_GOLD_PLAIN_MOUNTAIN_ORIGIN', 'TerrainType', 'TERRAIN_PLAINS_MOUNTAIN'),
    ('BBG_INTERNATIONAL_TRADE_ROUTE_GOLD_PLAIN_MOUNTAIN_ORIGIN', 'YieldType', 'YIELD_GOLD'),
    ('BBG_INTERNATIONAL_TRADE_ROUTE_GOLD_DESERT_MOUNTAIN_ORIGIN', 'Origin', '1'),
    ('BBG_INTERNATIONAL_TRADE_ROUTE_GOLD_DESERT_MOUNTAIN_ORIGIN', 'Amount', '1'),
    ('BBG_INTERNATIONAL_TRADE_ROUTE_GOLD_DESERT_MOUNTAIN_ORIGIN', 'TerrainType', 'TERRAIN_DESERT_MOUNTAIN'),
    ('BBG_INTERNATIONAL_TRADE_ROUTE_GOLD_DESERT_MOUNTAIN_ORIGIN', 'YieldType', 'YIELD_GOLD'),
    ('BBG_INTERNATIONAL_TRADE_ROUTE_GOLD_TUNDRA_MOUNTAIN_ORIGIN', 'Origin', '1'),
    ('BBG_INTERNATIONAL_TRADE_ROUTE_GOLD_TUNDRA_MOUNTAIN_ORIGIN', 'Amount', '1'),
    ('BBG_INTERNATIONAL_TRADE_ROUTE_GOLD_TUNDRA_MOUNTAIN_ORIGIN', 'TerrainType', 'TERRAIN_TUNDRA_MOUNTAIN'),
    ('BBG_INTERNATIONAL_TRADE_ROUTE_GOLD_TUNDRA_MOUNTAIN_ORIGIN', 'YieldType', 'YIELD_GOLD'),
    ('BBG_INTERNATIONAL_TRADE_ROUTE_GOLD_SNOW_MOUNTAIN_ORIGIN', 'Origin', '1'),
    ('BBG_INTERNATIONAL_TRADE_ROUTE_GOLD_SNOW_MOUNTAIN_ORIGIN', 'Amount', '1'),
    ('BBG_INTERNATIONAL_TRADE_ROUTE_GOLD_SNOW_MOUNTAIN_ORIGIN', 'TerrainType', 'TERRAIN_SNOW_MOUNTAIN'),
    ('BBG_INTERNATIONAL_TRADE_ROUTE_GOLD_SNOW_MOUNTAIN_ORIGIN', 'YieldType', 'YIELD_GOLD');
INSERT INTO TraitModifiers(TraitType, ModifierId) VALUES
    ('TRAIT_LEADER_PACHACUTI_QHAPAQ_NAN', 'BBG_INTERNATIONAL_TRADE_ROUTE_GOLD_GRASS_MOUNTAIN_ORIGIN'),
    ('TRAIT_LEADER_PACHACUTI_QHAPAQ_NAN', 'BBG_INTERNATIONAL_TRADE_ROUTE_GOLD_PLAIN_MOUNTAIN_ORIGIN'),
    ('TRAIT_LEADER_PACHACUTI_QHAPAQ_NAN', 'BBG_INTERNATIONAL_TRADE_ROUTE_GOLD_DESERT_MOUNTAIN_ORIGIN'),
    ('TRAIT_LEADER_PACHACUTI_QHAPAQ_NAN', 'BBG_INTERNATIONAL_TRADE_ROUTE_GOLD_TUNDRA_MOUNTAIN_ORIGIN'),
    ('TRAIT_LEADER_PACHACUTI_QHAPAQ_NAN', 'BBG_INTERNATIONAL_TRADE_ROUTE_GOLD_SNOW_MOUNTAIN_ORIGIN');
--add prod on mountain wonders
INSERT INTO RequirementSets(RequirementSetId, RequirementSetType) VALUES
    ('REQSET_PLOT_IS_MOUNTAIN_WONDER_BBG', 'REQUIREMENTSET_TEST_ANY');
INSERT OR IGNORE INTO Requirements(RequirementId, RequirementType)
    SELECT 'REQ_'||WonderTerrainFeature_BBG.WonderType||'_BBG', 'REQUIREMENT_PLOT_FEATURE_TYPE_MATCHES'
    FROM WonderTerrainFeature_BBG WHERE TerrainClassType = 'TERRAIN_CLASS_MOUNTAIN';
INSERT OR IGNORE INTO RequirementArguments(RequirementId, Name, Value)
    SELECT 'REQ_'||WonderTerrainFeature_BBG.WonderType||'_BBG', 'FeatureType', WonderTerrainFeature_BBG.WonderType
    FROM WonderTerrainFeature_BBG WHERE TerrainClassType = 'TERRAIN_CLASS_MOUNTAIN';
INSERT INTO RequirementSetRequirements
    SELECT 'REQSET_PLOT_IS_MOUNTAIN_WONDER_BBG', 'REQ_'||WonderTerrainFeature_BBG.WonderType||'_BBG'
    FROM WonderTerrainFeature_BBG WHERE TerrainClassType = 'TERRAIN_CLASS_MOUNTAIN';
--work impassible terrain
INSERT INTO Modifiers(ModifierId, ModifierType)
    SELECT 'TRAIT_MODIFIER_WORK_'||Terrains.TerrainType||'_MOUNTAIN_WONDER_BBG', 'MODIFIER_PLAYER_ADJUST_TERRAIN_WORKABLE'
    FROM Terrains WHERE TerrainType NOT LIKE '%MOUNTAIN%'
        AND TerrainType NOT LIKE '%HILLS%'
        AND TerrainType NOT IN ('TERRAIN_OCEAN', 'TERRAIN_COAST');
INSERT INTO ModifierArguments(ModifierId, Name, Value)
    SELECT 'TRAIT_MODIFIER_WORK_'||Terrains.TerrainType||'_MOUNTAIN_WONDER_BBG', 'Ignore', 1
    FROM Terrains WHERE TerrainType NOT LIKE '%MOUNTAIN%'
        AND TerrainType NOT LIKE '%HILLS%'
        AND TerrainType NOT IN ('TERRAIN_OCEAN', 'TERRAIN_COAST');
INSERT INTO ModifierArguments(ModifierId, Name, Value)
    SELECT 'TRAIT_MODIFIER_WORK_'||Terrains.TerrainType||'_MOUNTAIN_WONDER_BBG', 'TerrainType', Terrains.TerrainType
    FROM Terrains WHERE TerrainType NOT LIKE '%MOUNTAIN%'
        AND TerrainType NOT LIKE '%HILLS%'
        AND TerrainType NOT IN ('TERRAIN_OCEAN', 'TERRAIN_COAST');
INSERT INTO TraitModifiers
    SELECT 'TRAIT_CIVILIZATION_GREAT_MOUNTAINS', 'TRAIT_MODIFIER_WORK_'||Terrains.TerrainType||'_MOUNTAIN_WONDER_BBG'
    FROM Terrains WHERE TerrainType NOT LIKE '%MOUNTAIN%'
        AND TerrainType NOT LIKE '%HILLS%'
        AND TerrainType NOT IN ('TERRAIN_OCEAN', 'TERRAIN_COAST');
--add prod to mountain wonder modifiers
INSERT INTO Requirements(RequirementId, RequirementType) VALUES
    ('REQ_PLOT_IS_MOUNTAIN_WONDER_BBG', 'REQUIREMENT_REQUIREMENTSET_IS_MET');
INSERT INTO RequirementArguments(RequirementId, Name, Value) VALUES
    ('REQ_PLOT_IS_MOUNTAIN_WONDER_BBG', 'RequirementSetId', 'REQSET_PLOT_IS_MOUNTAIN_WONDER_BBG');
INSERT INTO RequirementSets VALUES
    ('REQSET_PLOT_IS_MOUNTAIN_WONDER_LATE_BBG', 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements VALUES
    ('REQSET_PLOT_IS_MOUNTAIN_WONDER_LATE_BBG', 'REQ_PLOT_IS_MOUNTAIN_WONDER_BBG'),
    ('REQSET_PLOT_IS_MOUNTAIN_WONDER_LATE_BBG', 'REQUIRES_ERA_ATLEASTEXPANSION_INDUSTRIAL');
INSERT INTO Modifiers(ModifierId, ModifierType, SubjectRequirementSetId) VALUES
    ('TRAIT_MODIFIER_MOUNTAIN_WONDER_PRODUCTION', 'MODIFIER_PLAYER_ADJUST_PLOT_YIELD', 'REQSET_PLOT_IS_MOUNTAIN_WONDER_BBG'),
    ('TRAIT_MODIFIER_MOUNTAIN_WONDER_LATE_PRODUCTION', 'MODIFIER_PLAYER_ADJUST_PLOT_YIELD', 'REQSET_PLOT_IS_MOUNTAIN_WONDER_LATE_BBG');
INSERT INTO ModifierArguments(ModifierId, Name, Value) VALUES
    ('TRAIT_MODIFIER_MOUNTAIN_WONDER_PRODUCTION', 'YieldType', 'YIELD_PRODUCTION'),
    ('TRAIT_MODIFIER_MOUNTAIN_WONDER_PRODUCTION', 'Amount', 2),
    ('TRAIT_MODIFIER_MOUNTAIN_WONDER_LATE_PRODUCTION', 'YieldType', 'YIELD_PRODUCTION'),
    ('TRAIT_MODIFIER_MOUNTAIN_WONDER_LATE_PRODUCTION', 'Amount', 1);
INSERT INTO TraitModifiers VALUES
    ('TRAIT_CIVILIZATION_GREAT_MOUNTAINS', 'TRAIT_MODIFIER_MOUNTAIN_WONDER_PRODUCTION'),
    ('TRAIT_CIVILIZATION_GREAT_MOUNTAINS', 'TRAIT_MODIFIER_MOUNTAIN_WONDER_LATE_PRODUCTION');
--Mountain Wonders - Terrace Farm Interraction
--MountainWonder Yields From Terrace
INSERT INTO RequirementSets VALUES
    ('REQSET_TERRACE_FARM_MOUNTAIN_WONDER_BBG', 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements VALUES
    ('REQSET_TERRACE_FARM_MOUNTAIN_WONDER_BBG', 'REQ_PLOT_IS_MOUNTAIN_WONDER_BBG'),
    ('REQSET_TERRACE_FARM_MOUNTAIN_WONDER_BBG', 'ADJACENT_TO_OWNER');
INSERT INTO Modifiers(ModifierId, ModifierType, SubjectRequirementSetId) VALUES
    ('MODIFIER_TERRACE_FARM_MOUNTAIN_FOOD_MOUNTAIN_WONDER_BBG', 'MODIFIER_PLAYER_ADJUST_PLOT_YIELD', 'REQSET_TERRACE_FARM_MOUNTAIN_WONDER_BBG');
INSERT INTO ModifierArguments(ModifierId, Name, Value) VALUES
    ('MODIFIER_TERRACE_FARM_MOUNTAIN_FOOD_MOUNTAIN_WONDER_BBG', 'YieldType', 'YIELD_FOOD'),
    ('MODIFIER_TERRACE_FARM_MOUNTAIN_FOOD_MOUNTAIN_WONDER_BBG', 'Amount', 1);
INSERT INTO ImprovementModifiers VALUES
    ('IMPROVEMENT_TERRACE_FARM', 'MODIFIER_TERRACE_FARM_MOUNTAIN_FOOD_MOUNTAIN_WONDER_BBG');
--terrace farms yields from mountain wonders
INSERT INTO Adjacency_YieldChanges(ID, Description, YieldType, YieldChange, TilesRequired, AdjacentFeature)
    SELECT 
       'Terrace_MountainWonder'||(SELECT COUNT(*)
        FROM (SELECT WonderType AS t2 FROM WonderTerrainFeature_BBG  WHERE TerrainClassType = 'TERRAIN_CLASS_MOUNTAIN')
        WHERE t2<= t1.WonderType), 'Placeholder', 'YIELD_FOOD', 1, 1, t1.WonderType
FROM WonderTerrainFeature_BBG AS t1
WHERE t1.TerrainClassType = 'TERRAIN_CLASS_MOUNTAIN'
ORDER BY WonderType;
INSERT INTO Improvement_Adjacencies
    SELECT DISTINCT 
       'IMPROVEMENT_TERRACE_FARM', 'Terrace_MountainWonder'||(SELECT COUNT(*)
        FROM (SELECT WonderType AS t2 FROM WonderTerrainFeature_BBG  WHERE TerrainClassType = 'TERRAIN_CLASS_MOUNTAIN')
        WHERE t2<= t1.WonderType)
FROM WonderTerrainFeature_BBG AS t1
WHERE t1.TerrainClassType = 'TERRAIN_CLASS_MOUNTAIN'
ORDER BY WonderType;
