create or replace function nhle.summaryshooting(params json, token uuid) returns json language plv8

as
$$
for (item of params.items){
plv8.execute(
'insert into nhle.summaryshooting(gamesplayed, playerid, positioncode, satagainst, satahead, satbehind, satclose, satfor, satrelative, sattied, sattotal, seasonid, shootscatches, skaterfullname, teamabbrevs, timeonicepergame5v5, usatagainst, usatahead, usatbehind, usatclose, usatfor, usatrelative, usattied, usattotal) values($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21, $22, $23, $24)',
[item.gamesPlayed, item.playerId, item.positionCode, item.satAgainst, item.satAhead, item.satBehind, item.satClose, item.satFor, item.satRelative, item.satTied, item.satTotal, item.seasonId, item.shootsCatches, item.skaterFullName, item.teamAbbrevs, item.timeOnIcePerGame5v5, item.usatAgainst, item.usatAhead, item.usatBehind, item.usatClose, item.usatFor, item.usatRelative, item.usatTied, item.usatTotal]);
}

return {inserted: params.items}

$$;


alter function nhle.summaryshooting(json, uuid) owner to neuroplane;