from selenium import webdriver
# from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.by import By
import time

topic_search = input("Enter the topic for which you want to search: ")

topic_search = topic_search.replace(" ", "+")

browser = webdriver.Chrome()   

for i in range(1):
    url = "https://www.google.com/search?q=" + topic_search + "&start=" + str(i*10)  # Adjusted the URL
    browser.get(url)

time.sleep(2)
denyCookies = browser.find_element(By.ID, "W0wltc")
denyCookies.click()

time.sleep(20)
# Don't forget to close the browser after your operation
browser.quit()
