create or replace function nhle.shootout(params json, token uuid) returns json language plv8

as
$$
for (item of params.items){
plv8.execute(
'insert into nhle.shootout(careershootoutgamedecidinggoals, careershootoutgamesplayed, careershootoutgoals, careershootoutshootingpct, careershootoutshots, lastname, playerid, positioncode, seasonid, shootoutgamedecidinggoals, shootoutgamesplayed, shootoutgoals, shootoutshootingpct, shootoutshots, shootscatches, skaterfullname, teamabbrevs) values($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17)',
[item.careerShootoutGameDecidingGoals, item.careerShootoutGamesPlayed, item.careerShootoutGoals, item.careerShootoutShootingPct, item.careerShootoutShots, item.lastName, item.playerId, item.positionCode, item.seasonId, item.shootoutGameDecidingGoals, item.shootoutGamesPlayed, item.shootoutGoals, item.shootoutShootingPct, item.shootoutShots, item.shootsCatches, item.skaterFullName, item.teamAbbrevs]);
}

return {inserted: params.items}

$$;


alter function nhle.shootout(json, uuid) owner to neuroplane;