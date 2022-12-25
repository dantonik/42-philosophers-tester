import os
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

url = "https://nafuka11.github.io/philosophers-visualizer/"

try:
    chrome_options = Options()
    chrome_options.add_experimental_option("detach", True)
    driver = webdriver.Chrome(options=chrome_options)
    driver.get(url)
except Exception:
    print("Error opening the website in Chrome")
    print("Trying to open in Firefox . . .")
    try:
        driver = webdriver.Firefox()
        driver.get(url)
    except Exception:
        print("Error opening the website in Firefox")


i = 0
for file in os.listdir('fails'):
    filename = 'fails/' + os.fsdecode(file)
    with open(filename) as f:
        if i != 0:
            driver.execute_script(f"window.open('about:blank', '{i}');")
            driver.switch_to.window(f"{i}")
            driver.get(url)
        lines = f.readlines()
        textarea = driver.find_element(By.CSS_SELECTOR, "textarea")
        textarea.clear()
        textarea.send_keys(lines)
        i += 1
