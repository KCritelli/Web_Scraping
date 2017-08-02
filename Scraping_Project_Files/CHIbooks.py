from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import time
import csv




# Windows users need to specify the path to chrome driver you just downloaded.
# driver = webdriver.Chrome('path\to\where\you\download\the\chromedriver')
driver = webdriver.Chrome()

driver.get("https://twitter.com/CoverSpyCHI")

SCROLL_PAUSE_TIME = 3

# Get scroll height
last_height = driver.execute_script("return document.body.scrollHeight")

index = 1
while index < 100:
	index += 1
	try:
		# Scroll down to bottom
		driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")
    	# Wait to load page
		time.sleep(SCROLL_PAUSE_TIME)
		print('scrolling!')
	except:
		print('We are at the end of the page')
		break
    # Calculate new scroll height and compare with last scroll height
#     new_height = driver.execute_script("return document.body.scrollHeight")
#     if new_height == last_height:
#         break
#     last_height = new_height

csv_file = open('CHI_books.csv', 'w',encoding='utf-8')
# Windows users need to open the file using 'wb'
# csv_file = open('books.csv', 'wb')
writer = csv.writer(csv_file, delimiter = ';')
writer.writerow(['Title','Author','Description'])
#
#
# 		# Find all the reviews.
reviews = driver.find_elements_by_xpath("//*[contains(@id, 'stream-item-tweet-')]")

for review in reviews:
			# Initialize an empty dictionary for each review
	review_dict = {}
			# Use Xpath to locate the title, content, username, date.
			# Once you locate the element, you can use 'element.text' to return its string.
			# To get the attribute instead of the text of each element, use 'element.get_attribute()'
	try:
		title = review.find_element_by_xpath('.//div[2]/div[2]/p').text
		title1 = ''.join(map(str, title))
		Title = title1.split(',', 1)[0]
	except:
		Title = "NA"
	try:
		Author = title1.split(', ',1)[1]
	except: 
		Author = "NA"
	try:
		Description=Author[Author.find("(")+1:Author.find(")")]
		Author = Author[0:Author.find(" (")]
	except:
		Description = "NA"

	print('='*50)
	print(Title)
	print('='*50)
	review_dict['Title'] = Title
	review_dict['Author'] = Author
	review_dict['Description'] = Description
	writer.writerow(review_dict.values())
#
csv_file.close()
driver.close()