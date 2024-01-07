from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.by import By
import time

browser = webdriver.Chrome()   
url = "https://10fastfingers.com/typing-test/english"
browser.get(url)

denyCookies = browser.find_element(By.ID, "CybotCookiebotDialogBodyButtonDecline")
denyCookies.click()
time.sleep(1)

InputField = browser.find_element(By.ID, "inputfield")
spans = browser.find_elements(By.CSS_SELECTOR, "#row1 span")
for span in spans:
    text = span.text
    InputField.send_keys(text, " ")
time.sleep(10)

browser.quit()