import os
import requests
import sys
import pandas as pd
# import re
username = 'frank.keenan'
password = os.environ.get('DPSPASS')
server = 'https://dws-dps.idm.fr'
api_url = f"{server}//api/v1/users?format=FULL"
dictRoles = {}
IsDictRole = {}
allRoles = set()


def storeDatabaseNames():
    api_url = f"{server}//api/v1/projects?format=FULL"
    response = session.get(api_url)
    if response.status_code != 200:
        print(f"Invalid response from API.{api_url}\n")
        sys.exit(0)
    dict_info = response.json()
    if dict_info:
        df = pd.DataFrame(dict_info)
        column_to_delete = "jdbcPassword"
        if column_to_delete in df.columns:
            df.drop(column_to_delete, axis=1, inplace=True)
        excel_file = "DPS_Projects_Info.xlsx"
        df.to_excel(excel_file, index=False)
        dict = {}
        for i in range(len(df)):
            dict[df["code"].iloc[i]] = df["name"].iloc[i]
        return dict
        ##



def storeUsers():
    api_url = f"{server}//api/v1/users?format=FULL"
    response = session.get(api_url)
    if response.status_code != 200:
        print(f"Invalid response from API.{api_url}\n")
        sys.exit(0)
    users_info = response.json()
    if users_info:
        df = pd.DataFrame(users_info)
        column_to_delete = "password"
        if column_to_delete in df.columns:
            df.drop(column_to_delete, axis=1, inplace=True)
        excel_file = "dps_users.xlsx"
        df.to_excel(excel_file, index=False)
        # Step 3: Extract the desired column from the DataFrame
        users = df['login']
        user_list = users.to_list()
        return (user_list)
  #      print(user_list)


def addRoleToProject(project, role):
    if project not in dictRoles:
        dictRoles[project] = set()
    dictRoles[project].add(role)
    allRoles.add(role)
    projectRole = f"{project}\t{role}"
    IsDictRole.setdefault(role, {})[project] = "True"
  #  IsDictRole.setdefault(role, {})[project] = "True"
   # IsDictRole[project][role] = "True"



def storeRolesAndDicts(login):
    api_url = f"{server}/api/v1/users/{login}/project_profiles?format=FULL"
    response = session.get(api_url)
    if response.status_code != 200:
        print(f"Invalid response from API.{api_url}\n")
        sys.exit(0)
    user_projects = response.json()
    for project in user_projects:
        role = user_projects[project]
        #print(f"{project} role{role}")
        # print()
        addRoleToProject(project, role)
        udicts = set()


with requests.Session() as session:
    session.auth = (username, password)
    DictNames = storeDatabaseNames()
    print("Data written to DPS_Projects_Info.xlsx")
    sys.exit(0)
