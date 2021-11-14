create or replace function nhle.percentages(params json, token uuid) returns json language plv8

as
$$
for (item of params.items){
plv8.execute(
'insert into nhle.percentages(gamesplayed, lastname, playerid, positioncode, satpercentage, satpercentageahead, satpercentagebehind, satpercentageclose, satpercentagetied, satrelative, seasonid, shootingpct5v5, shootscatches, skaterfullname, skatersavepct5v5, skatershootingplussavepct5v5, teamabbrevs, timeonicepergame5v5, usatpercentage, usatpercentageahead, usatpercentagebehind, usatpercentagetied, usatprecentageclose, usatrelative, zonestartpct5v5) values($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21, $22, $23, $24, $25)',
[item.gamesPlayed, item.lastName, item.playerId, item.positionCode, item.satPercentage, item.satPercentageAhead, item.satPercentageBehind, item.satPercentageClose, item.satPercentageTied, item.satRelative, item.seasonId, item.shootingPct5v5, item.shootsCatches, item.skaterFullName, item.skaterSavePct5v5, item.skaterShootingPlusSavePct5v5, item.teamAbbrevs, item.timeOnIcePerGame5v5, item.usatPercentage, item.usatPercentageAhead, item.usatPercentageBehind, item.usatPercentageTied, item.usatPrecentageClose, item.usatRelative, item.zoneStartPct5v5]);
}

return {inserted: params.items}

$$;


alter function nhle.percentages(json, uuid) owner to neuroplane;