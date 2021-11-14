create or replace function nhle.faceoffwins(params json, token uuid) returns json language plv8

as
$$
for (item of params.items){
plv8.execute(
'insert into nhle.faceoffwins(defensivezonefaceofflosses, defensivezonefaceoffwins, defensivezonefaceoffs, evfaceoffs, evfaceoffslost, evfaceoffswon, faceoffwinpct, gamesplayed, lastname, neutralzonefaceofflosses, neutralzonefaceoffwins, neutralzonefaceoffs, offensivezonefaceofflosses, offensivezonefaceoffwins, offensivezonefaceoffs, playerid, positioncode, ppfaceoffs, ppfaceoffslost, ppfaceoffswon, seasonid, shfaceoffs, shfaceoffslost, shfaceoffswon, skaterfullname, teamabbrevs, totalfaceofflosses, totalfaceoffwins, totalfaceoffs) values($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21, $22, $23, $24, $25, $26, $27, $28, $29)',
[item.defensiveZoneFaceoffLosses, item.defensiveZoneFaceoffWins, item.defensiveZoneFaceoffs, item.evFaceoffs, item.evFaceoffsLost, item.evFaceoffsWon, item.faceoffWinPct, item.gamesPlayed, item.lastName, item.neutralZoneFaceoffLosses, item.neutralZoneFaceoffWins, item.neutralZoneFaceoffs, item.offensiveZoneFaceoffLosses, item.offensiveZoneFaceoffWins, item.offensiveZoneFaceoffs, item.playerId, item.positionCode, item.ppFaceoffs, item.ppFaceoffsLost, item.ppFaceoffsWon, item.seasonId, item.shFaceoffs, item.shFaceoffsLost, item.shFaceoffsWon, item.skaterFullName, item.teamAbbrevs, item.totalFaceoffLosses, item.totalFaceoffWins, item.totalFaceoffs]);
}

return {inserted: params.items}

$$;


alter function nhle.faceoffwins(json, uuid) owner to neuroplane;