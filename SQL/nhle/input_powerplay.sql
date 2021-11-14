create or replace function nhle.powerplay(params json, token uuid) returns json language plv8

as
$$
for (item of params.items){
plv8.execute(
'insert into nhle.powerplay(gamesplayed, lastname, playerid, positioncode, ppassists, ppgoals, ppgoalsforper60, ppgoalsper60, ppindividualsatfor, ppindividualsatforper60, pppoints, pppointsper60, ppprimaryassists, ppprimaryassistsper60, ppsecondaryassists, ppsecondaryassistsper60, ppshootingpct, ppshots, ppshotsper60, pptimeonice, pptimeonicepctpergame, pptimeonicepergame, seasonid, skaterfullname, teamabbrevs) values($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21, $22, $23, $24, $25)',
[item.gamesPlayed, item.lastName, item.playerId, item.positionCode, item.ppAssists, item.ppGoals, item.ppGoalsForPer60, item.ppGoalsPer60, item.ppIndividualSatFor, item.ppIndividualSatForPer60, item.ppPoints, item.ppPointsPer60, item.ppPrimaryAssists, item.ppPrimaryAssistsPer60, item.ppSecondaryAssists, item.ppSecondaryAssistsPer60, item.ppShootingPct, item.ppShots, item.ppShotsPer60, item.ppTimeOnIce, item.ppTimeOnIcePctPerGame, item.ppTimeOnIcePerGame, item.seasonId, item.skaterFullName, item.teamAbbrevs]);
}

return {inserted: params.items}

$$;


alter function nhle.powerplay(json, uuid) owner to neuroplane;