# -*- coding: utf-8 -*-
from urllib.request import urlopen
import urllib.request
import re
import pymysql
from bs4 import BeautifulSoup
import pymysql

db = pymysql.connect("localhost", "root", "970306", "special_equipment_cases", charset="utf8")
cur = db.cursor()
sql = 'INSERT INTO cases (case_name, case_describe, case_equipment) VALUES (%s,%s,%s)'

base_url = 'http://decm.jnu.edu.cn/?q=search/node/'

equipment_search = u'游乐设施'

request = urlopen(base_url + urllib.request.quote(equipment_search)+'&page=1') # &page=1
html = request.read()
soup = BeautifulSoup(html, 'html.parser', from_encoding='GB2312')
titles = soup.find_all('dt', class_='title')

for title in titles:
    link = title.find('a').get('href')
    print(title.get_text())
    news_request = urlopen(link)
    news_html = news_request.read()
    news_soup = BeautifulSoup(news_html, 'html.parser', from_encoding='GB2312')
    news_contents = news_soup.select('#center > div > div.content')[0].find_all('p')

    content = ""
    for news_content in news_contents:
        new_content = news_content.get_text().strip()
        if new_content is not "":
            content = content + new_content + '\n'
    print(content)
    cur.execute(sql, (title.get_text(), content, equipment_search))

db.commit()

# print(html)