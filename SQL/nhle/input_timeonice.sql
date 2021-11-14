create or replace function nhle.timeonice(params json, token uuid) returns json language plv8

as
$$
for (item of params.items){
plv8.execute(
'insert into nhle.timeonice(evtimeonice, evtimeonicepergame, gamesplayed, lastname, ottimeonice, ottimeoniceperotgame, playerid, positioncode, pptimeonice, pptimeonicepergame, seasonid, shtimeonice, shtimeonicepergame, shifts, shiftspergame, shootscatches, skaterfullname, teamabbrevs, timeonice, timeonicepergame, timeonicepershift) values($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21)',
[item.evTimeOnIce, item.evTimeOnIcePerGame, item.gamesPlayed, item.lastName, item.otTimeOnIce, item.otTimeOnIcePerOtGame, item.playerId, item.positionCode, item.ppTimeOnIce, item.ppTimeOnIcePerGame, item.seasonId, item.shTimeOnIce, item.shTimeOnIcePerGame, item.shifts, item.shiftsPerGame, item.shootsCatches, item.skaterFullName, item.teamAbbrevs, item.timeOnIce, item.timeOnIcePerGame, item.timeOnIcePerShift]);
}

return {inserted: params.items}

$$;


alter function nhle.timeonice(json, uuid) owner to neuroplane;