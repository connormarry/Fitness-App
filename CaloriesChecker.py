# initialize variables:
gender, age, weight, height, activity, option = '', 0.0, 0.0, 0.0, 0, ''

while 1:
    isError = 0

    # Prompt user for necessary values
    gender = input("Please enter your gender (m/f): ")
    age = input("Please enter your age: ")
    weight = input("Please enter your current weight (in lbs): ")
    height = input("Please enter your current height (in inches): ")
    activity = input("Please enter your activity level on a scale from 1 (sedentary) to 5 (extra active): ")
    option = input("Please enter your goal: lose weight, maintain weight, gain weight (type l, m, or g): ")

    # Error Check (gender)
    if gender.lower() != 'm' and gender.lower() != 'f':
        print("Error: please type either 'm' or 'f' for gender")
        isError = 1

    # Error Check (age)
    if int(age) < 0:
        print("Error: age must be positive")
        isError = 1
    elif int(age) < 10:
        print(f"Error: {age} years old is too young to workout")
        isError = 1
    elif int(age) > 120:
        print(f"Error: {age} years old is too old to workout")
        isError = 1

    # Error Check (weight)
    if float(weight) < 0:
        print("Error: weight must be positive")
        isError = 1

    # Error Check (height)
    if float(height) < 0:
        print("Error: height must be positive")
        isError = 1

    # Error Check (activity level)

    if int(float(activity)) > 5 or int(float(activity)) < 1:
        print("Error: please enter an activity level between 1 and 5 as an integer ")
        isError = 1

    # Error Check (choose option)
    if option != 'l' and option != 'm' and option != 'g':
        print("Error: please type either 'l', 'm', or 'g' for your goal: ")
        isError = 1

    if isError:
        print("\nPlease fix the errors above and try again:\n")
    else:
        break

# if the user inputs reasonable values, the program continues


height = float(height) * 2.54  # convert height to cm
weight = float(weight) * 0.453592  # convert weight to kg

# find activity multiplier
if int(activity) == 1:
    activity = 1.2
elif int(activity) == 2:
    activity = 1.375
elif int(activity) == 3:
    activity = 1.55
elif int(activity) == 4:
    activity = 1.75
elif int(activity) == 5:
    activity = 1.9

# calculate BMR
if gender == 'm':
    bmr = (13.397 * float(weight)) + (4.799 * float(height)) - (5.677 * float(age)) + 88.362
else:
    bmr = (9.247 * float(weight)) + (3.098 * float(height)) - (4.330 * float(age)) + 447.593

bmr *= activity

low = 0
high = 0

if option.lower() == 'l':
    low = bmr - 1000
    high = bmr - 500
    print(f"\nYou should eat between {int(low)} and {int(high)} calories per day in order to lose weight!\n")
elif option.lower() == 'm':
    print(f"\nYou should eat {int(bmr)} calories per day in order to maintain your current weight!\n")
elif option.lower() == 'g':
    low = bmr + 250
    high = bmr + 500
    print(f"\nYou should eat between {int(low)} and {int(high)} calories per day in order to gain weight!\n")

