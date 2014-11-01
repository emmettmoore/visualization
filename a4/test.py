import csv
import sys


def main():
    
    signups            = []
    first_row = True
    curr_IPs = []
    with open('data_aggregate.csv', 'rb') as f:
        for row in f:
            if first_row:
                first_row = False 
                continue
            this_row = row.split(',')
            if this_row[3] not in curr_IPs:
                curr_IPs.append(this_row[3])
    print "num protocols is %d" % len(curr_IPs)
    print
    print curr_IPs


def write_to_csv(beg, adv, sdt, rem):
    keys = ['name', 'email', 'year', 'level']
    f = open('./beg.csv', 'wb')
    dict_writer = csv.DictWriter(f, keys)
    dict_writer.writer.writerow(keys)
    dict_writer.writerows(beg)

    f = open('./adv.csv', 'wb')
    dict_writer = csv.DictWriter(f, keys)
    dict_writer.writer.writerow(keys)
    dict_writer.writerows(adv)

    f = open('./sdt.csv', 'wb')
    dict_writer = csv.DictWriter(f, keys)
    dict_writer.writer.writerow(keys)
    dict_writer.writerows(sdt)

    f = open('./rem.csv', 'wb')
    dict_writer = csv.DictWriter(f, keys)
    dict_writer.writer.writerow(keys)
    dict_writer.writerows(rem)

def get_beginner_team(signups, remainder, fields):
    beginner_team = []
    for i, member in enumerate(signups):
        if member[fields['level']] == 'Beginner':
            if member[fields['tuesday']] == 'Yes':
                beginner_team.append({'name': member[fields['name']], 'email': member[fields['email']], 'year': member[fields['year']]})
            else:
                remainder.append({'name': member[fields['name']], 'email': member[fields['email']], 'year': member[fields['year']], 'level': member[fields['level']]})
    return beginner_team

def get_advanced_team(signups, remainder, fields):
    advanced_team = []
    for i, member in enumerate(signups):
        if member[fields['level']] == 'Advanced':
            if member[fields['thursday']] == 'Yes':
                advanced_team.append({'name': member[fields['name']], 'email': member[fields['email']], 'year': member[fields['year']]})
            else:
                remainder.append({'name': member[fields['name']], 'email': member[fields['email']], 'year': member[fields['year']], 'level': member[fields['level']]})
    return advanced_team

def get_sdt_team(signups, remainder, fields):
    sdt = []
    for i, member in enumerate(signups):
        if member[fields['level']] == 'Self Directed Training':
            sdt.append({'name': member[fields['name']], 'email': member[fields['email']], 'year': member[fields['year']]})
    return sdt
if __name__ == '__main__': main()


