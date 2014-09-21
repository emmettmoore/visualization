import csv

def read_csv():
    with open('data.csv', 'Ur') as f:
        data = list(list(rec) for rec in csv.reader(f, delimiter=','))
        return data
def fewer_fields(my_data):
    new_fields = []
    for i, elem in enumerate(my_data[0]):
        if elem in ['EDT', 'Events', 'Mean Wind SpeedMPH', 'Mean TemperatureF']:
            new_fields.append(i)
    for row in my_data:
        for i, elem in enumerate(row):
            if i not in new_fields:
                del row[i]
    return my_data

adjusted_wind_data = fewer_fields(read_csv())
print adjusted_wind_data 
