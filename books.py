from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import time
import csv


# Windows users need to specify the path to chrome driver you just downloaded.
# driver = webdriver.Chrome('path\to\where\you\download\the\chromedriver')
driver = webdriver.Chrome()

driver.get("http://coverspy.tumblr.com/tagged/Penguin-Books")

SCROLL_PAUSE_TIME = 5

# Get scroll height
last_height = driver.execute_script("return document.body.scrollHeight")

while True:
    # Scroll down to bottom
    driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")

    # Wait to load page
    time.sleep(SCROLL_PAUSE_TIME)

    # Calculate new scroll height and compare with last scroll height
    new_height = driver.execute_script("return document.body.scrollHeight")
    if new_height == last_height:
        break
    last_height = new_height
    
csv_file = open('books.csv', 'w')
# Windows users need to open the file using 'wb'
# csv_file = open('books.csv', 'wb')
writer = csv.writer(csv_file, delimiter = ';')
writer.writerow(['title','author','hashtag','loves'])
# Page index used to keep track of where we are.
index = 1
while index < 3:
	try:
		print("Scraping Page number " + str(index))
		index = index + 1

		# Find all the reviews.
		reviews = driver.find_elements_by_xpath("//*[contains(@id, 'post-')]")
		for review in reviews:
			# Initialize an empty dictionary for each review
			review_dict = {}
			# Use Xpath to locate the title, content, username, date.
			# Once you locate the element, you can use 'element.text' to return its string.
			# To get the attribute instead of the text of each element, use 'element.get_attribute()'
			title = review.find_element_by_xpath('.//div[1]/div[2]/p').text
			title1 = ''.join(map(str, title))
			hashtag = review.find_element_by_xpath(".//div[1]/div[3]/ul/li[1]/ul").text
			hashtag = hashtag.replace('#', ',')
			hashtag = hashtag[1:]
			title = title1.split(',', 1)[0]
			author = title1.split(', ',1)[1]
			loves = review.find_element_by_xpath(".//div[1]/div[3]/ul/li[3]/a").text
			loves = loves.replace('Permalink','0')
			print('='*50)
			print(title)
			print('='*50)
			review_dict['title'] = title
			review_dict['author'] = author
			review_dict['hashtag'] = hashtag
			review_dict['loves'] = loves
			writer.writerow(review_dict.values())



		
		time.sleep(3)
	except Exception as e:
		print(e)
		csv_file.close()
		driver.close()
		break
		
		#how to scroll down a page in selenium, writing a csv files when entries have commas