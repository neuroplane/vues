create or replace function nhle.summary(params json, token uuid) returns json language plv8

as
$$
for (item of params.items){
plv8.execute(
'insert into nhle.summary(assists, evgoals, evpoints, faceoffwinpct, gamewinninggoals, gamesplayed, goals, lastname, otgoals, penaltyminutes, playerid, plusminus, points, pointspergame, positioncode, ppgoals, pppoints, seasonid, shgoals, shpoints, shootingpct, shootscatches, shots, skaterfullname, teamabbrevs, timeonicepergame) values($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21, $22, $23, $24, $25, $26)',
[item.assists,
    item.evGoals,
    item.evPoints,
    item.faceoffWinPct,
    item.gameWinningGoals,
    item.gamesPlayed,
    item.goals,
    item.lastName,
    item.otGoals,
    item.penaltyMinutes,
    item.playerId,

    item.plusMinus, item.points, item.pointsPerGame, item.positionCode, item.ppGoals, item.ppPoints, item.seasonId, item.shGoals, item.shPoints, item.shootingPct, item.shootsCatches, item.shots, item.skaterFullName, item.teamAbbrevs, item.timeOnIcePerGame]);
}

return {inserted: params.items}

$$;


alter function nhle.summary(json, uuid) owner to neuroplane;