# Background
My family enjoys playing a board game called "Catan" (previously titled "The Settlers of Catan").  This game involves rolling two dice and using the sum to produce resources for players.  Unfortunately, this method was a bit too random for us and limited the influence of player skill.  My solution to this problem was to write a random number generator which would alter the probability distribution of generated numbers as the game progresses.

# Estimated Timeline
* Created: July 2015
* Last major update: September 2015
* Added to repository: April 2022

# Solution Method
In my program, a virtual bag of numbers is created.  Each value would be placed into the bag a number of times equal to 3 times the probability of its sum appearing on two dice, times 36.  As an example, the faces of two dice sum up to "6" 5 times out of 36; so 3 * 5/36 * 36 = 15 "6s" would be initially placed into the bag.  After the bag is fully stocked with numbers, the program randomly grabs any value from the bag without replacement.  In the event that a full "set" of numbers is removed from the bag (i.e. one "2", two "3s", three "4s", ..., two "11s", and one "12"), that set is placed back into the bag.  This method ensures that variance still has an impact on the game but its effect is diminished.

# Program Requirements
* Anything that runs C++, such as Xcode
