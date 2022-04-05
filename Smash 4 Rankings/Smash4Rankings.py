import numpy as np

players = ["Austin", "Justin", "Tom", "Jason", "Khalil", "Jinwoo",
           "Jake", "Erik", "Ritsuma", "Amy", "Steve", "Brian"]
playersHashIndex = {"Austin": 0, "Justin": 1, "Tom": 2, "Jason": 3, "Khalil": 4, "Jinwoo": 5,
                    "Jake": 6, "Erik": 7, "Ritsuma": 8, "Amy": 9, "Steve": 10, "Brian": 11}
teams = []
teamMembers = []
stocksLeftPerMatch = []


""" Start of match records """

# Player pairings that occur more often should be more heavily weighted when
# calculating player score. Therefore, common matches are given duplicate rows.
# By the same logic, matches without significant data aren't included.

for i in range(2):
    teamMembers.append([["Austin"], ["Tom"]])
    stocksLeftPerMatch.append(45 / 58)

teamMembers.append([["Austin"], ["Khalil"]])
stocksLeftPerMatch.append(8 / 7)

teamMembers.append([["Austin"], ["Jinwoo"]])
stocksLeftPerMatch.append(31 / 12)

teamMembers.append([["Austin"], ["Steve"]])
stocksLeftPerMatch.append(15 / 29)

for i in range(5):
    teamMembers.append([["Justin"], ["Tom"]])
    stocksLeftPerMatch.append(-5 / 345)

for i in range(3):
    teamMembers.append([["Justin"], ["Jason"]])
    stocksLeftPerMatch.append(26 / 101)

for i in range(2):
    teamMembers.append([["Justin"], ["Khalil"]])
    stocksLeftPerMatch.append(-14 / 49)

# teamMembers.append([["Justin"], ["Jinwoo"]])
# stocksLeftPerMatch.append(5 / 3)

teamMembers.append([["Justin"], ["Jake"]])
stocksLeftPerMatch.append(-15 / 17)

teamMembers.append([["Justin"], ["Erik"]])
stocksLeftPerMatch.append(2 / 13)

teamMembers.append([["Justin"], ["Ritsuma"]])
stocksLeftPerMatch.append(-12 / 11)

teamMembers.append([["Justin"], ["Steve"]])
stocksLeftPerMatch.append(-12 / 12)

for i in range(2):
    teamMembers.append([["Tom"], ["Jason"]])
    stocksLeftPerMatch.append(40 / 57)

teamMembers.append([["Tom"], ["Khalil"]])
stocksLeftPerMatch.append(11 / 37)

# teamMembers.append([["Tom"], ["Jinwoo"]])
# stocksLeftPerMatch.append(2 / 1)

# teamMembers.append([["Tom"], ["Jake"]])
# stocksLeftPerMatch.append(0 / 5)

# teamMembers.append([["Tom"], ["Erik"]])
# stocksLeftPerMatch.append(3 / 2)

teamMembers.append([["Tom"], ["Ritsuma"]])
stocksLeftPerMatch.append(4 / 13)

teamMembers.append([["Tom"], ["Steve"]])
stocksLeftPerMatch.append(-23 / 35)

# teamMembers.append([["Jason"], ["Khalil"]])
# stocksLeftPerMatch.append(-2 / 3)

# teamMembers.append([["Jason"], ["Jinwoo"]])
# stocksLeftPerMatch.append(6 / 5)

teamMembers.append([["Jason"], ["Erik"]])
stocksLeftPerMatch.append(-12 / 13)

# teamMembers.append([["Jason"], ["Ritsuma"]])
# stocksLeftPerMatch.append(-5 / 2)

# teamMembers.append([["Jason"], ["Steve"]])
# stocksLeftPerMatch.append(-4 / 2)

# teamMembers.append([["Khalil"], ["Jinwoo"]])
# stocksLeftPerMatch.append(1 / 2)

for i in range(2):
    teamMembers.append([["Khalil"], ["Ritsuma"]])
    stocksLeftPerMatch.append(-16 / 44)

# teamMembers.append([["Khalil"], ["Steve"]])
# stocksLeftPerMatch.append(-4 / 3)

teamMembers.append([["Jinwoo"], ["Erik"]])
stocksLeftPerMatch.append(-8 / 8)

# teamMembers.append([["Jinwoo"], ["Ritsuma"]])
# stocksLeftPerMatch.append(-9 / 4)

# teamMembers.append([["Jinwoo"], ["Steve"]])
# stocksLeftPerMatch.append(-5 / 2)

# teamMembers.append([["Erik"], ["Steve"]])
# stocksLeftPerMatch.append(-5 / 3)

teamMembers.append([["Austin", "Justin"], ["Tom", "Jason"]])
stocksLeftPerMatch.append(19 / 12)

teamMembers.append([["Austin", "Justin"], ["Tom", "Khalil"]])
stocksLeftPerMatch.append(17 / 34)

# teamMembers.append([["Austin", "Justin"], ["Tom", "Ritsuma"]])
# stocksLeftPerMatch.append(-1 / 3)

teamMembers.append([["Austin", "Justin"], ["Tom", "Steve"]])
stocksLeftPerMatch.append(4 / 35)

for i in range(4):
    teamMembers.append([["Austin", "Jason"], ["Justin", "Tom"]])
    stocksLeftPerMatch.append(32 / 188)

for i in range(2):
    teamMembers.append([["Austin", "Jason"], ["Justin", "Khalil"]])
    stocksLeftPerMatch.append(56 / 75)

teamMembers.append([["Austin", "Jason"], ["Justin", "Jake"]])
stocksLeftPerMatch.append(14 / 16)

for i in range(2):
    teamMembers.append([["Austin", "Jason"], ["Justin", "Erik"]])
    stocksLeftPerMatch.append(48 / 44)

teamMembers.append([["Austin", "Jason"], ["Tom", "Khalil"]])
stocksLeftPerMatch.append(-6 / 25)

teamMembers.append([["Austin", "Jason"], ["Tom", "Erik"]])
stocksLeftPerMatch.append(12 / 14)

teamMembers.append([["Austin", "Erik"], ["Justin", "Tom"]])
stocksLeftPerMatch.append(23 / 28)

teamMembers.append([["Austin", "Erik"], ["Justin", "Steve"]])
stocksLeftPerMatch.append(0 / 9)

teamMembers.append([["Austin", "Jinwoo"], ["Justin", "Jason"]])
stocksLeftPerMatch.append(17 / 14)

teamMembers.append([["Austin", "Jinwoo"], ["Justin", "Jake"]])
stocksLeftPerMatch.append(1 / 6)

# teamMembers.append([["Austin", "Amy"], ["Justin", "Jason"]])
# stocksLeftPerMatch.append(8 / 5)

teamMembers.append([["Austin", "Amy"], ["Justin", "Jake"]])
stocksLeftPerMatch.append(-6 / 13)

teamMembers.append([["Austin", "Brian"], ["Justin", "Jason"]])
stocksLeftPerMatch.append(15 / 8)

teamMembers.append([["Justin", "Tom"], ["Khalil", "Ritsuma"]])
stocksLeftPerMatch.append(-4 / 8)

teamMembers.append([["Justin", "Jason"], ["Tom", "Jinwoo"]])
stocksLeftPerMatch.append(-13 / 35)

# teamMembers.append([["Justin", "Jason"], ["Erik", "Jinwoo"]])
# stocksLeftPerMatch.append(-4 / 4)

teamMembers.append([["Justin", "Jason"], ["Tom", "Erik"]])
stocksLeftPerMatch.append(-9 / 6)

teamMembers.append([["Justin", "Khalil"], ["Tom", "Jason"]])
stocksLeftPerMatch.append(1 / 20)

# teamMembers.append([["Justin", "Jake"], ["Tom", "Jason"]])
# stocksLeftPerMatch.append(4 / 5)

teamMembers.append([["Justin", "Erik"], ["Tom", "Jason"]])
stocksLeftPerMatch.append(-1 / 8)

teamMembers.append([["Tom", "Jason"], ["Jake", "Erik"]])
stocksLeftPerMatch.append(2 / 14)

teamMembers.append([["Justin", "Jason"], ["Tom"]])
stocksLeftPerMatch.append(9 / 6)

teamMembers.append([["Austin", "Justin", "Jake"], ["Tom", "Jason", "Khalil"]])
stocksLeftPerMatch.append(17 / 11)

teamMembers.append([["Austin", "Tom", "Jason"], ["Justin", "Khalil", "Ritsuma"]])
stocksLeftPerMatch.append(13 / 9)

teamMembers.append([["Austin", "Jason", "Jake"], ["Justin", "Tom", "Khalil"]])
stocksLeftPerMatch.append(11 / 13)

teamMembers.append([["Austin", "Jason", "Erik"], ["Justin", "Tom", "Khalil"]])
stocksLeftPerMatch.append(-9 / 13)

teamMembers.append([["Austin", "Jason", "Amy"], ["Justin", "Khalil", "Jinwoo"]])
stocksLeftPerMatch.append(5 / 15)

teamMembers.append([["Austin", "Erik", "Jinwoo"], ["Justin", "Tom", "Jason"]])
stocksLeftPerMatch.append(18 / 9)

teamMembers.append([["Austin", "Tom"], ["Justin", "Jason", "Khalil"]])
stocksLeftPerMatch.append(-22 / 20)

teamMembers.append([["Austin", "Khalil"], ["Justin", "Tom", "Jason"]])
stocksLeftPerMatch.append(-1 / 9)

teamMembers.append([["Austin", "Khalil"], ["Justin", "Jason", "Jinwoo"]])
stocksLeftPerMatch.append(4 / 11)

teamMembers.append([["Austin", "Brian"], ["Justin", "Jason", "Amy"]])
stocksLeftPerMatch.append(-7 / 6)

teamMembers.append([["Justin", "Jason", "Erik"], ["Tom", "Khalil"]])
stocksLeftPerMatch.append(8 / 7)

""" End of match records """


""" Start of player score calculations """

# Generate a matrix that holds team information
for i in range(len(teamMembers)):
    tempTeam = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    for j in range(len(teamMembers[i][0])):
        tempTeam[playersHashIndex[teamMembers[i][0][j]]] = 1
    for j in range(len(teamMembers[i][1])):
        tempTeam[playersHashIndex[teamMembers[i][1][j]]] = -1
    teams.append(tempTeam)

# Calculate player scores using matrix pseudo-inverse:
playerScores = np.dot(np.linalg.pinv(teams), stocksLeftPerMatch)

# Assign scores to players
playerScoresDict = {}
for i in range(len(playerScores)):
    playerScoresDict[players[i]] = playerScores[i]

print("Player scores:")
for i in range(len(playerScoresDict)):
    print(players[i] + ":", round(playerScores[i], 4))
print()
print()

""" End of player score calculations """


""" Start of team assignment for upcoming match """

# Change this line of code to determine teams
participantNames = ["Austin", "Justin", "Tom", "Jason", "Jinwoo"]

# Select only the scores of the participants for the upcoming match, and
# generate the initial vector for recursive attempts at team assignment
participantScores = []
tempPossibleTeams = []
tempBest = []
for i in range(len(participantNames)):
    participantScores.append(playerScoresDict[participantNames[i]])
    tempBest.append(0)
    if i != len(participantNames) - 1:
        tempPossibleTeams.append(1)
    else:
        tempPossibleTeams.append(-1)

tempLowest = 100


def assignTeams(possibleTeams, lowestScoreDiff, bestTeams):
    # Stop the loop when the first player in the match gets assigned to team 2
    if possibleTeams[0] == -1:
        return bestTeams, lowestScoreDiff

    # Calculate expected difference in stocks for teams
    teamOneScore = 0
    teamTwoScore = 0
    for i in range(len(participantScores)):
        if possibleTeams[i] == 1:
            teamOneScore += participantScores[i]
        else:
            teamTwoScore += participantScores[i]
    scoreDiff = teamOneScore - teamTwoScore

    # Determine if current team assignment is the best assignment so far
    if abs(scoreDiff) < abs(lowestScoreDiff):
        lowestScoreDiff = scoreDiff
        for i in range(len(possibleTeams)):
            bestTeams[i] = possibleTeams[i]

    # Assign new teams iteratively (by essentially counting binary, where 1 is 0 and -1 is 1)
    # Example: Teams start as 1, 1, 1, -1, which converts to 0001, so
    #          next teams should be 1, 1, -1, 1, which converts to 0010
    for i in reversed(range(len(possibleTeams))):
        if possibleTeams[i] == 1:
            possibleTeams[i] = -1
            # Test a new assignment of teams to see if it results in a smaller score difference
            bestTeams, lowestScoreDiff = assignTeams(possibleTeams, lowestScoreDiff, bestTeams)
            break
        else:
            possibleTeams[i] = 1

    return bestTeams, lowestScoreDiff


# Call the function to determine the best assignment of teams
best, bestScoreDiff = assignTeams(tempPossibleTeams, tempLowest, tempBest)

# Print the team assignments
print("Team 1: ")
for i in range(len(best)):
    if best[i] == 1:
        print(participantNames[i])
print()
print("Team 2: ")
for i in range(len(best)):
    if best[i] == -1:
        print(participantNames[i])
print()
print("Expected stock difference per match:", bestScoreDiff)

""" End of team assignment """
