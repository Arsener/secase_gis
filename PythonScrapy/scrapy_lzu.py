# -*- coding: utf-8 -*-
import requests
import pymysql
import json

db = pymysql.connect("localhost", "root", "970306", "special_equipment_cases", charset="utf8")
cur = db.cursor()
sql = 'INSERT INTO cases (case_name, case_describe, case_equipment, case_place) VALUES (%s,%s,%s,%s)'

login_url = 'http://cm.cm1911.com/PubManage/UserLogin'
base_url = 'http://cm.cm1911.com/ExpertSearch/SearchAll'

headers = {
    'Content-Type':'application/json; charset=utf-8'
}

payload_login = {
    'UName':'lzu',
    'UPwd':'lzu1234',
    'RemenberMe':'false'
}

types = ['电梯', '管道', '起重', '索道', '游乐设施']

payload = {
    'IsQiYe':'true',
    'IsZhengFu':'true',
    'PagerSize':1,
    'Wheres':[{'propertyName': 'CrisisName', 'propertyValue': '', 'compare': 'Contains', 'andOr': 'And'}]
}

session = requests.session()
r_login = session.post(login_url, data=json.dumps(payload_login), headers=headers)

for type in types:
    payload['Wheres'][0]['propertyValue'] = type
    r = session.post(base_url, data=json.dumps(payload), headers=headers)

    cases = json.loads(r.text)
    # print(type(cases['Events'][0]))
    for case in cases['Events']:
        case_name = case['CaseCap']
        case_describe = case['CaseIntro']
        print(case_name)
        print(case_describe)

        case_place = case_name[5:7]
        # if case_place == '上海' or case_place == '北京':
            # case_place = case_place + '市'
        # else:
            # case_place = case_place + '省'
        print(case_place)

        if type == '管道':
            type = '压力管道'
        elif type == '起重':
            type = '起重机械'
        elif type == '索道':
            type = '客运索道'
        elif type == '游乐设施':
            type = '大型游乐设施'

        cur.execute(sql, (case_name, case_describe, type, case_place))

db.commit()