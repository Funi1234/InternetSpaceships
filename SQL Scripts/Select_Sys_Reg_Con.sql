SELECT sys.solarSystemName as "System", reg.regionName as "Region", con.constellationName as "Constellation" FROM eve.mapsolarsystems AS sys
join eve.mapregions as reg on sys.regionID = reg.regionID
join eve.mapconstellations as con on sys.constellationID = con.constellationID;