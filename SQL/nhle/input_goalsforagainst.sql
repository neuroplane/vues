create or replace function nhle.goalsforagainst(params json, token uuid) returns json
    language plv8
as
$$
for (item of params.items){
plv8.execute(
'insert into nhle.goalsforagainst(assists, evenstrengthgoaldifference, evenstrengthgoalsagainst, evenstrengthgoalsfor, evenstrengthgoalsforpct, evenstrengthtimeonicepergame, gamesplayed, goals, lastname, playerid, points, positioncode, powerplaygoalfor, powerplaygoalsagainst, powerplaytimeonicepergame, seasonid, shorthandedgoalsagainst, shorthandedgoalsfor, shorthandedtimeonicepergame, skaterfullname, teamabbrevs) values($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21)',
[item.assists, item.evenStrengthGoalDifference, item.evenStrengthGoalsAgainst, item.evenStrengthGoalsFor, item.evenStrengthGoalsForPct, item.evenStrengthTimeOnIcePerGame, item.gamesPlayed, item.goals, item.lastName, item.playerId, item.points, item.positionCode, item.powerPlayGoalFor, item.powerPlayGoalsAgainst, item.powerPlayTimeOnIcePerGame, item.seasonId, item.shortHandedGoalsAgainst, item.shortHandedGoalsFor, item.shortHandedTimeOnIcePerGame, item.skaterFullName, item.teamAbbrevs]);
}

return {inserted: params.items}

$$;


alter function nhle.goalsforagainst(json, uuid) owner to neuroplane;