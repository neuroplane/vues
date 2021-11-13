create or replace function nhle.bios(params json, token uuid) returns json
    language plv8
as
$$
for (item of params.items){
plv8.execute(
'insert into nhle.bios(assists, birthcity, birthcountrycode, birthdate, birthstateprovincecode, currentteamabbrev, currentteamname, draftoverall, draftround, draftyear, firstseasonforgametype, gamesplayed, goals, height, isinhalloffameyn, lastname, nationalitycode, playerid, points, positioncode, shootscatches, skaterfullname, weight) values($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21, $22, $23)',
[item.assists, item.birthCity, item.birthCountryCode, item.birthDate, item.birthStateProvinceCode, item.currentTeamAbbrev, item.currentTeamName, item.draftOverall, item.draftRound, item.draftYear, item.firstSeasonForGameType, item.gamesPlayed, item.goals, item.height, item.isInHallOfFameYn, item.lastName, item.nationalityCode, item.playerId, item.points, item.positionCode, item.shootsCatches, item.skaterFullName, item.weight]);
}

return {inserted: params.items}

$$;


alter function nhle.bios(json, uuid) owner to neuroplane;