#include <iostream>
#include <cstdlib>
#include <ctime>
#include <vector>
using namespace std;

int main(int argc, const char * argv[])
{
    srand(time(0));
    vector<int> numbers;
    int index;
    int number;
    int num2sLeft;
    int num3sLeft;
    int num4sLeft;
    int num5sLeft;
    int num6sLeft;
    int num7sLeft;
    int num8sLeft;
    int num9sLeft;
    int num10sLeft;
    int num11sLeft;
    int num12sLeft;
    string input;
    
    for (int i = 0; i < 3; i++)
    {
        numbers.push_back(2);
        numbers.push_back(12);
    }
    
    for (int i = 0; i < 6; i++)
    {
        numbers.push_back(3);
        numbers.push_back(11);
    }
    
    for (int i = 0; i < 9; i++)
    {
        numbers.push_back(4);
        numbers.push_back(10);
    }
    
    for (int i = 0; i < 12; i++)
    {
        numbers.push_back(5);
        numbers.push_back(9);
    }
    
    for (int i = 0; i < 15; i++)
    {
        numbers.push_back(6);
        numbers.push_back(8);
    }
    
    for (int i = 0; i < 18; i++)
    {
        numbers.push_back(7);
    }
    
    for (;;)
    {
        num2sLeft = 0;
        num3sLeft = 0;
        num4sLeft = 0;
        num5sLeft = 0;
        num6sLeft = 0;
        num7sLeft = 0;
        num8sLeft = 0;
        num9sLeft = 0;
        num10sLeft = 0;
        num11sLeft = 0;
        num12sLeft = 0;
        
        cout << "Press any key and then Enter to roll." << endl;
        cin >> input;
        
        index = rand() % numbers.size();
        number = numbers.at(index);
        numbers.erase(numbers.begin() + index);
        cout << "You rolled a " << number << ". " << endl;
        
        for (int i = 0; i < numbers.size(); i++)
        {
            if (numbers.at(i) == 2)
            {
                num2sLeft++;
            }
            else if (numbers.at(i) == 3)
            {
                num3sLeft++;
            }
            else if (numbers.at(i) == 4)
            {
                num4sLeft++;
            }
            else if (numbers.at(i) == 5)
            {
                num5sLeft++;
            }
            else if (numbers.at(i) == 6)
            {
                num6sLeft++;
            }
            else if (numbers.at(i) == 7)
            {
                num7sLeft++;
            }
            else if (numbers.at(i) == 8)
            {
                num8sLeft++;
            }
            else if (numbers.at(i) == 9)
            {
                num9sLeft++;
            }
            else if (numbers.at(i) == 10)
            {
                num10sLeft++;
            }
            else if (numbers.at(i) == 11)
            {
                num11sLeft++;
            }
            else
            {
                num12sLeft++;
            }
        }
        
        if (num2sLeft <= 2 && num3sLeft <= 4 && num4sLeft <= 6 && num5sLeft <= 8
            && num6sLeft <= 10 && num7sLeft <= 12 && num8sLeft <= 10 &&
            num9sLeft <= 8 && num10sLeft <= 6 && num11sLeft <= 4 && num12sLeft <= 2)
        {
            numbers.push_back(2);
            numbers.push_back(3);
            numbers.push_back(3);
            numbers.push_back(4);
            numbers.push_back(4);
            numbers.push_back(4);
            numbers.push_back(5);
            numbers.push_back(5);
            numbers.push_back(5);
            numbers.push_back(5);
            numbers.push_back(6);
            numbers.push_back(6);
            numbers.push_back(6);
            numbers.push_back(6);
            numbers.push_back(6);
            numbers.push_back(7);
            numbers.push_back(7);
            numbers.push_back(7);
            numbers.push_back(7);
            numbers.push_back(7);
            numbers.push_back(7);
            numbers.push_back(8);
            numbers.push_back(8);
            numbers.push_back(8);
            numbers.push_back(8);
            numbers.push_back(8);
            numbers.push_back(9);
            numbers.push_back(9);
            numbers.push_back(9);
            numbers.push_back(9);
            numbers.push_back(10);
            numbers.push_back(10);
            numbers.push_back(10);
            numbers.push_back(11);
            numbers.push_back(11);
            numbers.push_back(12);
        }
    }
    
    return 0;
}
