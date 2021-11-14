create or replace function nhle.puckpossesions(params json, token uuid) returns json language plv8

as
$$
for (item of params.items){
plv8.execute(
'insert into nhle.puckpossesions(faceoffpct5v5, gamesplayed, goalspct, individualsatforper60, individualshotsforper60, lastname, oniceshootingpct, playerid, positioncode, satpct, seasonid, shootscatches, skaterfullname, teamabbrevs, timeonicepergame5v5, usatpct, zonestartpct) values($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17)',
[item.faceoffPct5v5, item.gamesPlayed, item.goalsPct, item.individualSatForPer60, item.individualShotsForPer60, item.lastName, item.onIceShootingPct, item.playerId, item.positionCode, item.satPct, item.seasonId, item.shootsCatches, item.skaterFullName, item.teamAbbrevs, item.timeOnIcePerGame5v5, item.usatPct, item.zoneStartPct]);
}

return {inserted: params.items}

$$;


alter function nhle.puckpossesions(json, uuid) owner to neuroplane;