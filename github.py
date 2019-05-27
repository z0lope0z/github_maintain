import csv
import json
import pdb
import sys
from collections import defaultdict

csvfile = open('team.csv', 'r')

fieldnames = ("Username", "Team1", "Team2", "Team3", "Team4", "Team5", "Team6")
reader = csv.DictReader(csvfile, fieldnames)

return_value = defaultdict(str)

users = []
memberships = []

index = 0
for row in reader:
    if index == 0:
        teams = row.keys()
        teams.remove('Username')
        return_value['teams'] = ",".join(teams)
    else:
        username = row['Username']
        users.append(username)
        maintainer_key = "users_{}_maintainer".format(username)
        for key, value in row.items():
            if key != "Username" and (value == "member" or value == "maintainer"):
                member_key = "{}_{}_{}".format(key, username, value)
                memberships.append(member_key)
    index += 1
return_value['memberships'] = ",".join(memberships)
return_value['users'] = ",".join(users)
output_json = json.dumps(return_value)
sys.stdout.write(output_json)
