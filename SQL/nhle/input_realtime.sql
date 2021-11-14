create or replace function nhle.realtime(params json, token uuid) returns json language plv8

as
$$
for (item of params.items){
plv8.execute(
'insert into nhle.realtime(blockedshots, blockedshotsper60, emptynetassists, emptynetgoals, emptynetpoints, firstgoals, gamesplayed, giveaways, giveawaysper60, hits, hitsper60, lastname, missedshotcrossbar, missedshotgoalpost, missedshotovernet, missedshotwideofnet, missedshots, otgoals, playerid, positioncode, seasonid, shootscatches, skaterfullname, takeaways, takeawaysper60, teamabbrevs, timeonicepergame) values($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21, $22, $23, $24, $25, $26, $27)',
[item.blockedShots, item.blockedShotsPer60, item.emptyNetAssists, item.emptyNetGoals, item.emptyNetPoints, item.firstGoals, item.gamesPlayed, item.giveaways, item.giveawaysPer60, item.hits, item.hitsPer60, item.lastName, item.missedShotCrossbar, item.missedShotGoalpost, item.missedShotOverNet, item.missedShotWideOfNet, item.missedShots, item.otGoals, item.playerId, item.positionCode, item.seasonId, item.shootsCatches, item.skaterFullName, item.takeaways, item.takeawaysPer60, item.teamAbbrevs, item.timeOnIcePerGame]);
}

return {inserted: params.items}

$$;


alter function nhle.realtime(json, uuid) owner to neuroplane;