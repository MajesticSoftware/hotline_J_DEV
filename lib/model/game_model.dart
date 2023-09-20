class HotlinesModel {
  String teamName;
  String value;
  String tittle;
  String playerName;
  String bookId;
  String teamId;

  HotlinesModel({
    required this.teamName,
    required this.teamId,
    required this.value,
    required this.tittle,
    required this.playerName,
    required this.bookId,
  });
}

///MLB STATICS MODEL

class MLBPitchingStaticsModel {
  String playerName;
  String wl;
  String era;
  String whip;
  String ip;
  String h;
  String k;
  String bb;
  String hr;

  MLBPitchingStaticsModel({
    required this.playerName,
    required this.wl,
    required this.era,
    required this.whip,
    required this.ip,
    required this.h,
    required this.k,
    required this.bb,
    required this.hr,
  });
}

class HitterPlayerStatMainModel {
  String playerName;
  String position;
  String hr;
  String rbi;
  String sb;
  String bb;
  String avg;
  String run;
  String runValue;
  String totalBase;
  String totalBaseValue;
  String stolenBase;
  String stolenBaseValue;
  String obp;
  String obpValue;
  String slg;
  String slgValue;
  String hAb;
  String ab;
  String hAbValue;
  HitterPlayerStatMainModel({
    required this.playerName,
    required this.position,
    required this.hr,
    required this.rbi,
    required this.sb,
    required this.bb,
    required this.avg,
    required this.run,
    required this.runValue,
    required this.totalBase,
    required this.totalBaseValue,
    required this.stolenBase,
    required this.stolenBaseValue,
    required this.obp,
    required this.obpValue,
    required this.slg,
    required this.slgValue,
    required this.hAb,
    required this.ab,
    required this.hAbValue,
  });
}

class RunningBacks {
  String carries;
  String yard;
  String avgCarry;
  String tds;
  String longestRun;
  String fumbles;
  RunningBacks({
    required this.carries,
    required this.yard,
    required this.avgCarry,
    required this.tds,
    required this.longestRun,
    required this.fumbles,
  });
}

List awayTeamOffenseValue = [
  '22.3%',
  '19.3',
  '31%',
  '43%',
  '98',
  '201.6',
  '1.4',
  '1.7',
  '4.9',
  '51%',
  '55%',
  '82%'
];
List homeTeamOffenseValue = [
  '27.5%',
  '22.6',
  '56%',
  '71%',
  '122',
  '288.4',
  '1.1',
  '2.4',
  '4.2',
  '48%',
  '76%',
  '81%'
];
List homeTeamDefenseValue = [
  '-12.1%',
  '19.8',
  '31%',
  '43%',
  '92.3',
  '201',
  '2.3',
  '1.9',
  '5.2',
  '51%',
  '55%'
];
List awayTeamDefenseValue = [
  '-11.3%',
  '22.1',
  '56%',
  '71%',
  '89.2',
  '221',
  '1.9',
  '2.6',
  '4.3',
  '76%',
  '81%'
];

List awayTeamStat = ['1-4', '2-6', '3-4', '-2.3'];
List homeTeamStat = ['3-2', '5-1', '6-2', '+7.2'];

List awayTeamInjury = [
  'J.Williams (O)',
  'J.Goff (Q)',
];
List homeTeamInjury = [
  'P.Mahomes (O)',
  'T.Kelce (Q)',
];
List gamblingList = [
  'Action: Having a wager on a game or event.',
  'Backdoor Cover: A score that happens late in a game that helps an underdog cover the spread but doesn’t affect the game’s outcome. If a football team that’s a +8.5 underdog is trailing by 10 points but only loses by three after scoring a last-minute touchdown, that’s a backdoor cover.',
  'Bad Beat: This term originated in poker, when a strong hand with high mathematical odds of winning still loses. In sports betting, a bad beat is when a bettor loses a wager they were seemingly on the verge of winning. What constitutes a bad beat can be debated.',
  'Cover: An instance where the favored team wins by exceeding the point spread. If a basketball team is favored by 4.5 points and wins by 5, it has covered the spread and bettors who have wagered on the favorite to cover are paid out.',
  'Edge: An advantage a gambler may feel they have through extensive research of a game or a team. An edge is where there might be value in a sports bet.',
  'Even Money: Odds that return the same amount as the original bet, often referred to as “50-50” odds. A winning \$1,000 bet would pay \$1,000 in profit if the odds were even money.',
  'Favorite: The expected straight-up winner of any game or event. Favorites are priced with a negative number and are considered to be “giving points” on the spread.',
  'Futures Bet: A wager on something that will take place longer-term than a wager on an individual game or event. Examples include preseason bets on whether a team will win a championship or which player will win awards, such as MVP.',
  'Hedging: Making a bet on the opposite side of an original wager to minimize risk and guarantee at least some return. An example would be making a large futures wager on a football team to win the Super Bowl, then betting against that team in the Super Bowl itself.',
  'Hook: A half point added to a point spread. A 3.5-point spread is commonly called “three and the hook.” Football games are often decided by just three points.',
  'In-Game Wager: A bet made on an event after it has started. This is also called a live bet.',
  'Juice (also known as “vigorish” or “vig”): The amount charged by sportsbooks for taking a bet. If a bet is offered at -110, bettors would need to wager \$110 to win \$100. The \$10 on the \$110 bet is the juice. This can also be called the rake.',
  'Laying Points: Betting on a favorite. If a bettor makes a wager on a team that’s a +6.5 favorite, that wager pays out if the team wins the game by seven points or more.',
  'Leg: A wager that is part of a parlay bet.',
  'Line Movement: When the odds for a game change from the time bets open to the time the game begins. Lines move for various reasons, including a significant injury on one side, a change in weather conditions, or a large amount of public money being bet on one side versus the other.',
  'Moneyline: A straight bet made simply on a contest’s outcome with no point spread involved. Favorites have negative odds, while underdogs are listed with positive odds.',
  'Odds: The measure of how much a bettor can win on a specific wager, per \$100 in American odds. For example, a bettor will win \$124 with a \$100 bet at +124 odds but must wager \$124 to win \$100 if the odds are -124.',
  'Over/Under: This can be a number posted on how many scoring units will be scored in a game or match, as well as how many games a team will win during a season. If a football game’s over/under is 43.5 and the two teams combine to score 44 points, bets on the over are paid out. If a baseball team’s preseason win total over/under is 82.5, and it wins 81 games, futures bets on the under are paid out.',
  'Parlay: A single wager that involves the bettor making multiple bets and tying them into one. The payouts of parlays are typically larger than a wager on a single game because each individual bet must win in order for a parlay to pay out.',
  'Pick ‘em: A game or event on which neither side is the favorite or the underdog.',
  'Point Spread (a.k.a. “the spread”): The number made by oddsmakers that levels the playing field between two opponents. A favorite is listed with a negative spread (-3.5), while an underdog is listed with a positive spread (+3.5). A winning wager on a favorite means that the contest was decided by a margin that exceeded the spread.',
  'Prop Bet: A bet made on something that may occur during a game that isn’t necessarily tied to the game’s outcome. These bets are often closely tied to the game itself, like a wager on whether or not an individual player will score a touchdown. There are also props that are only loosely connected to the game, like wagers on a football game’s opening coin toss.',
  'Push: A wager that results in a tie. If a football point spread is three points and the final score is 24-21, the original stakes are returned to bettors.',
  'Record Against the Spread (ATS): This refers to how a team has performed relative to the point spread. A team’s actual win-loss record often varies, sometimes drastically, from its record against the spread. For example, a football team might finish the season with a 10-7 record straight up, but if it frequently fails to cover the point spread, it could have a significantly worse record against the spread.',
  'Same-Game Parlay: A specific parlay type that combines multiple wagers from the same sporting event into one bet. Like traditional parlays, SGPs are usually difficult to win.',
  'Straight Up: A wager made when the bettor only needs a team to win a game or an event outright with no regard to the point spread.',
  'Taking Points: Betting on an underdog. If a bettor makes a wager on a team that’s a +6.5 underdog, that wager pays out if the team wins the game outright or loses by 6 points or less.',
  'Teaser: A bet that combines multiple games and allows the bettor to move the lines of each game involved in the wager. Similar to a parlay, a teaser bet only pays if each team involved covers the new line.',
  'Underdog: The expected straight-up loser of any game or event. Underdogs are priced with a positive number and are considered to be “getting points” on the spread.',
];
