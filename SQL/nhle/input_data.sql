create or replace function nhle.inputdata(params json, token uuid) returns json
    language plv8
as
$$
    for (item of params.items){
         plv8.execute('insert into nhle.summary(skaterFullName, assists,evGoals,evPoints,gameWinningGoals,gamesPlayed,goals,otGoals,faceoffWinPct,penaltyMinutes,playerId,plusMinus,points,pointsPerGame,positionCode,ppGoals,ppPoints,seasonId,shGoals,shPoints,shootingPct,shootsCatches,shots,teamAbbrevs,timeOnIcePerGame) values($1, $2, $3, $4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$20,$21,$22,$23,$24,$25)',
        [item.skaterFullName,
            item.assists != "" ? item.assists : null,
            item.evGoals != "" ? item.evGoals : null,
            item.evPoints != "" ? item.evPoints : null,
            item.gameWinningGoals != "" ? item.gameWinningGoals : null,
            item.gamesPlayed != "" ? item.gamesPlayed : null,
            item.goals != "" ? item.goals : null,
            item.otGoals != "" ? item.otGoals : null,
            item.faceoffWinPct != "" ? item.faceoffWinPct : null,
            item.penaltyMinutes != "" ? item.penaltyMinutes : null,
            item.playerId != "" ? item.playerId : null,
            item.plusMinus != "" ? item.plusMinus : null,
            item.points != "" ? item.points : null,
            item.pointsPerGame != "" ? item.pointsPerGame : null,
            item.positionCode != "" ? item.positionCode : null,
            item.ppGoals != "" ? item.ppGoals : null,
            item.ppPoints != "" ? item.ppPoints : null,
            item.seasonId != "" ? item.seasonId : null,
            item.shGoals != "" ? item.shGoals : null,
            item.shPoints != "" ? item.shPoints : null,
            item.shootingPct != "" ? item.shootingPct : null,
            item.shootsCatches != "" ? item.shootsCatches : null,
            item.shots != "" ? item.shots : null,
            item.teamAbbrevs != "" ? item.teamAbbrevs : null,
            item.timeOnIcePerGame != "" ? item.timeOnIcePerGame : null
            ]);
    }

    return {inserted: params.items}

$$;


alter function nhle.inputdata(json, uuid) owner to neuroplane;