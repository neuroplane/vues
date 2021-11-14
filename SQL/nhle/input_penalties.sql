create or replace function nhle.penalties(params json, token uuid) returns json language plv8

as
$$
for (item of params.items){
plv8.execute(
'insert into nhle.penalties(assists, gamemisconductpenalties, gamesplayed, goals, lastname, majorpenalties, matchpenalties, minorpenalties, misconductpenalties, netpenalties, netpenaltiesper60, penalties, penaltiesdrawn, penaltiesdrawnper60, penaltiestakenper60, penaltyminutes, penaltyminutespertimeonice, penaltysecondspergame, playerid, points, positioncode, seasonid, skaterfullname, teamabbrevs, timeonicepergame) values($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21, $22, $23, $24, $25)',
[item.assists, item.gameMisconductPenalties, item.gamesPlayed, item.goals, item.lastName, item.majorPenalties, item.matchPenalties, item.minorPenalties, item.misconductPenalties, item.netPenalties, item.netPenaltiesPer60, item.penalties, item.penaltiesDrawn, item.penaltiesDrawnPer60, item.penaltiesTakenPer60, item.penaltyMinutes, item.penaltyMinutesPerTimeOnIce, item.penaltySecondsPerGame, item.playerId, item.points, item.positionCode, item.seasonId, item.skaterFullName, item.teamAbbrevs, item.timeOnIcePerGame]);
}

return {inserted: params.items}

$$;


alter function nhle.penalties(json, uuid) owner to neuroplane;