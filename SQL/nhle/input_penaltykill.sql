create or replace function nhle.penaltykill(params json, token uuid) returns json language plv8

as
$$
for (item of params.items){
plv8.execute(
'insert into nhle.penaltykill(gamesplayed, lastname, playerid, positioncode, ppgoalsagainstper60, seasonid, shassists, shgoals, shgoalsper60, shindividualsatfor, shindividualsatforper60, shpoints, shpointsper60, shprimaryassists, shprimaryassistsper60, shsecondaryassists, shsecondaryassistsper60, shshootingpct, shshots, shshotsper60, shtimeonice, shtimeonicepctpergame, shtimeonicepergame, skaterfullname, teamabbrevs) values($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21, $22, $23, $24, $25)',
[item.gamesPlayed, item.lastName, item.playerId, item.positionCode, item.ppGoalsAgainstPer60, item.seasonId, item.shAssists, item.shGoals, item.shGoalsPer60, item.shIndividualSatFor, item.shIndividualSatForPer60, item.shPoints, item.shPointsPer60, item.shPrimaryAssists, item.shPrimaryAssistsPer60, item.shSecondaryAssists, item.shSecondaryAssistsPer60, item.shShootingPct, item.shShots, item.shShotsPer60, item.shTimeOnIce, item.shTimeOnIcePctPerGame, item.shTimeOnIcePerGame, item.skaterFullName, item.teamAbbrevs]);
}

return {inserted: params.items}

$$;


alter function nhle.penaltykill(json, uuid) owner to neuroplane;