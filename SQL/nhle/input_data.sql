create or replace function nhle.inputdata(params json, token uuid) returns json
    language plv8
as
$$
    for (item of params.items){
         plv8.execute('insert into nhle.summary(skaterFullName, assists,evGoals,evPoints,gameWinningGoals,gamesPlayed,goals,otGoals,faceoffWinPct,penaltyMinutes,playerId,plusMinus,points,pointsPerGame,positionCode,ppGoals,ppPoints,seasonId,shGoals,shPoints,shootingPct,shootsCatches,shots,teamAbbrevs,timeOnIcePerGame) values($1, $2, $3, $4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$20,$21,$22,$23,$24,$25)',
        [item.skaterFullName,
            item.assists,
            item.evGoals,
            item.evPoints,
            item.gameWinningGoals,
            item.gamesPlayed,
            item.goals,
            item.otGoals,
            item.faceoffWinPct,
            item.penaltyMinutes,
            item.playerId,
            item.plusMinus,
            item.points,
            item.pointsPerGame,
            item.positionCode,
            item.ppGoals,
            item.ppPoints,
            item.seasonId,
            item.shGoals,
            item.shPoints,
            item.shootingPct,
            item.shootsCatches,
            item.shots,
            item.teamAbbrevs,
            item.timeOnIcePerGame
            ]);
    }

    return {inserted: params.items}

$$;


alter function nhle.inputdata(json, uuid) owner to neuroplane;