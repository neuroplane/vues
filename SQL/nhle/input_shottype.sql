create or replace function nhle.shottype(params json, token uuid) returns json language plv8

as
$$
for (item of params.items){
plv8.execute(
'insert into nhle.shottype(gamesplayed, goals, goalsbackhand, goalsdeflected, goalsslap, goalssnap, goalstipin, goalswraparound, goalswrist, lastname, playerid, seasonid, shootingpct, shootingpctbackhand, shootingpctdeflected, shootingpctslap, shootingpctsnap, shootingpcttipin, shootingpctwraparound, shootingpctwrist, shots, shotsonnetbackhand, shotsonnetdeflected, shotsonnetslap, shotsonnetsnap, shotsonnettipin, shotsonnetwraparound, shotsonnetwrist, skaterfullname, teamabbrevs) values($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21, $22, $23, $24, $25, $26, $27, $28, $29, $30)',
[item.gamesPlayed, item.goals, item.goalsBackhand, item.goalsDeflected, item.goalsSlap, item.goalsSnap, item.goalsTipIn, item.goalsWrapAround, item.goalsWrist, item.lastName, item.playerId, item.seasonId, item.shootingPct, item.shootingPctBackhand, item.shootingPctDeflected, item.shootingPctSlap, item.shootingPctSnap, item.shootingPctTipIn, item.shootingPctWrapAround, item.shootingPctWrist, item.shots, item.shotsOnNetBackhand, item.shotsOnNetDeflected, item.shotsOnNetSlap, item.shotsOnNetSnap, item.shotsOnNetTipIn, item.shotsOnNetWrapAround, item.shotsOnNetWrist, item.skaterFullName, item.teamAbbrevs]);
}

return {inserted: params.items}

$$;


alter function nhle.shottype(json, uuid) owner to neuroplane;