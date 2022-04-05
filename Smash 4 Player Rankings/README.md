# Background
My friends and I played "Super Smash Bros. for Wii U" a lot while in college.  We enjoyed competing on evenly matched teams, although it was difficult to determine optimal team compositions when more than 4 players were in attendance.  Therefore, I implemented a Python program that would calculate player scores based upon match history and assign players to teams for an upcoming match.

# Estimated Timeline
* Created: September 2016
* Last major update: September 2018
* Added to repository: April 2022

# Method for Team Assignment
* Players would be assigned a score that best reflects stock difference in 3-stock matches.  For example, if Player A consistently defeated Player B by 2 stocks in 1v1 matches, Player A could have a score of 3 while Player B could have a score of 1.
* Every player pairing is represented as a row in a matrix.  A "1" marks that a player is on the first team, a "-1" is for the second team, and a "0" is for non-participating players.  For example, if there were 4 total players, a match with Player A and Player D against Player B would be represented as \[1, -1, 0, 1\].
* Matrices are used to solve systems of equations.  In this case, there are many more player combinations (equations) than players (variables), so the matrix pseudoinverse is calculated to minimize the squared error across all pairings.
* After player scores are determined, the optimal teams are chosen for an upcoming match by generating all possible team combinations and selecting the one with the smallest expected stock difference.

# Project Requirements
* Python 3
* NumPy package
