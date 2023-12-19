import csv

# Data to be written to the CSV file
data = [
    ['Ethnicity', 'AgeGroup', 'Drinks'],
]

# Black, old
for i in range(30):
    data.append([
        0, 1, 0
    ])

for i in range(48):
    data.append([
        0, 1, 1
    ])

for i in range(17):
    data.append([
        0, 1, 2
    ])

# Black, young
for i in range(25):
    data.append([
        0, 0, 0
    ])

for i in range(72):
    data.append([
        0, 0, 1
    ])

for i in range(13):
    data.append([
        0, 0, 2
    ])

# =================
# Hispanic, old
for i in range(7):
    data.append([
        1, 1, 0
    ])

for i in range(5):
    data.append([
        1, 1, 2
    ])

# Hispanic, young
for i in range(8):
    data.append([
        1, 0, 0
    ])

for i in range(7):
    data.append([
        1, 0, 1
    ])

for i in range(19):
    data.append([
        1, 0, 2
    ])
# =================
# White, old
for i in range(60):
    data.append([
        2, 1, 0
    ])

for i in range(2):
    data.append([
        2, 1, 1
    ])

for i in range(17):
    data.append([
        2, 1, 2
    ])

# White, young
for i in range(26):
    data.append([
        2, 0, 0
    ])

for i in range(10):
    data.append([
        2, 0, 1
    ])

for i in range(34):
    data.append([
        2, 0, 2
    ])


# File path to save the CSV file
file_path = 'output.csv'

# Writing data to the CSV file
with open(file_path, mode='w', newline='') as file:
    writer = csv.writer(file)
    writer.writerows(data)

print(f"Data has been written to '{file_path}' successfully!")