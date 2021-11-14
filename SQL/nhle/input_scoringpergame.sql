create or replace function nhle.scoringpergame(params json, token uuid) returns json language plv8

as
$$
for (item of params.items){
plv8.execute(
'insert into nhle.scoringpergame(assists, assistspergame, blockedshots, blockspergame, gamesplayed, goals, goalspergame, hits, hitspergame, lastname, penaltyminutes, penaltyminutespergame, playerid, points, pointspergame, positioncode, primaryassistspergame, seasonid, secondaryassistspergame, shootscatches, shots, shotspergame, skaterfullname, teamabbrevs, timeonice, timeonicepergame, totalprimaryassists, totalsecondaryassists) values($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21, $22, $23, $24, $25, $26, $27, $28)',
[item.assists, item.assistsPerGame, item.blockedShots, item.blocksPerGame, item.gamesPlayed, item.goals, item.goalsPerGame, item.hits, item.hitsPerGame, item.lastName, item.penaltyMinutes, item.penaltyMinutesPerGame, item.playerId, item.points, item.pointsPerGame, item.positionCode, item.primaryAssistsPerGame, item.seasonId, item.secondaryAssistsPerGame, item.shootsCatches, item.shots, item.shotsPerGame, item.skaterFullName, item.teamAbbrevs, item.timeOnIce, item.timeOnIcePerGame, item.totalPrimaryAssists, item.totalSecondaryAssists]);
}

return {inserted: params.items}

$$;


alter function nhle.scoringpergame(json, uuid) owner to neuroplane;