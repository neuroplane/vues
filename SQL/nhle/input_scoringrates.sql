create or replace function nhle.scoringrates(params json, token uuid) returns json language plv8

as
$$
for (item of params.items){
plv8.execute(
'insert into nhle.scoringrates(assists5v5, assistsper605v5, gamesplayed, goals5v5, goalsper605v5, lastname, netminorpenaltiesper60, offensivezonestartpct5v5, oniceshootingpct5v5, playerid, points5v5, pointsper605v5, positioncode, primaryassists5v5, primaryassistsper605v5, satpct, satrelative5v5, seasonid, secondaryassists5v5, secondaryassistsper605v5, shootingpct5v5, skaterfullname, teamabbrevs, timeonicepergame5v5) values($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21, $22, $23, $24)',
[item.assists5v5, item.assistsPer605v5, item.gamesPlayed, item.goals5v5, item.goalsPer605v5, item.lastName, item.netMinorPenaltiesPer60, item.offensiveZoneStartPct5v5, item.onIceShootingPct5v5, item.playerId, item.points5v5, item.pointsPer605v5, item.positionCode, item.primaryAssists5v5, item.primaryAssistsPer605v5, item.satPct, item.satRelative5v5, item.seasonId, item.secondaryAssists5v5, item.secondaryAssistsPer605v5, item.shootingPct5v5, item.skaterFullName, item.teamAbbrevs, item.timeOnIcePerGame5v5]);
}

return {inserted: params.items}

$$;


alter function nhle.scoringrates(json, uuid) owner to neuroplane;