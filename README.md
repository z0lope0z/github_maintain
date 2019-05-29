# Maintain your github registration by providing a CSV file to terraform!


## Use-case

For a given CSV file (team.csv):

   | Username | Team1 | Team2 | Team3 | Team4 | Team5 | Team6 |
   |----------|-------|-------|-------|-------|-------|-------|
   |User1 | member | maintainer | member | member | maintainer | member |
   |User2 | maintainer | member	| member | maintainer	| member | member |
   |User3 | member | member | maintainer | member | member | member |
   |User4 |  | member | member | member | member | maintainer | 
   |User5 | member |  | member | member |  | member | 
   |User6 | member | member | member | member | member |  |
   |User7 | member | member | member | member | member | member |
   |User8 | member | member |  | member | member | member |
   |User9 | member | member |  | member | member | member |
   |User10 | member | member |  | member | member | member |
   
 
 Simply run terraform apply
 
 It will automatically create the github teams, and attach the appropriate users to those teams
 
 
 ## How it works
 1. The csv file is fed into terraform using an external data source - a python script is used to do the transform
 2. The various teams are created as part of the team module
 3. The teams ids and names are collected
 4. The appropriate members/maintainer role is created for each user in the team
