create or replace function nhle.faceoffpercentages(params json, token uuid) returns json
    language plv8
as
$$
for (item of params.items){
plv8.execute(
'insert into nhle.faceoffpercentages(defensivezonefaceoffpct, defensivezonefaceoffs, evfaceoffpct, evfaceoffs, faceoffwinpct, gamesplayed, lastname, neutralzonefaceoffpct, neutralzonefaceoffs, offensivezonefaceoffpct, offensivezonefaceoffs, playerid, positioncode, ppfaceoffpct, ppfaceoffs, seasonid, shfaceoffpct, shfaceoffs, shootscatches, skaterfullname, teamabbrevs, timeonicepergame, totalfaceoffs) values($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21, $22, $23)',
[item.defensiveZoneFaceoffPct, item.defensiveZoneFaceoffs, item.evFaceoffPct, item.evFaceoffs, item.faceoffWinPct, item.gamesPlayed, item.lastName, item.neutralZoneFaceoffPct, item.neutralZoneFaceoffs, item.offensiveZoneFaceoffPct, item.offensiveZoneFaceoffs, item.playerId, item.positionCode, item.ppFaceoffPct, item.ppFaceoffs, item.seasonId, item.shFaceoffPct, item.shFaceoffs, item.shootsCatches, item.skaterFullName, item.teamAbbrevs, item.timeOnIcePerGame, item.totalFaceoffs]);
}

return {inserted: params.items}

$$;


alter function nhle.faceoffpercentages(json, uuid) owner to neuroplane;