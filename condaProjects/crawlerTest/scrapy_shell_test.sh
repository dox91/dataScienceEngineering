# https://apify.com/page-analyzer
# documentation: https://docs.scrapy.org/en/latest/topics/selectors.html#topics-selectors

###########################################################
### In order to crawl dynamically changing data, use scrapy + splash (server)
###########################################################
# note: when starting splash in docker: disable private mode with --disable-private-mode
# https://stackoverflow.com/questions/45976331/issue-with-scraping-js-rendered-page-with-scrapy-and-splash

# Start splash server
cd $HOME/CodingProjects/dataScienceEngineering/condaProjects/crawlerTest
sudo bash ../../initialSetup/setup_start_splash.sh
# Start Conda environment with python +  scrapy + scrapy-splash
. $HOME/CodingProjects/dataScienceEngineering/condaProjects/conda_activate_environment.sh bigData-env

# Variables for splash
SPLASHSERVER="http://localhost:8050"
RENDERTYPE="render.html"
TIMEOUT="10"
WAITSEC="0.5"

# Other variables
XMKT="nyse" # stock exchange: e.g., nyse, xetr, lse

###########################################################
### URLS to investigate (https://www.stockmarketclock.com)
###########################################################

# generic information on stockmarket exchanges
URL1="https://www.stockmarketclock.com/exchanges"
# specific information for one stockmarket exchange=${XMKT}
URL2="https://www.stockmarketclock.com/exchanges/${XMKT}#"
# trading hours information for one stockmarket exchange=${XMKT}
URL3="https://www.stockmarketclock.com/exchanges/${XMKT}/trading-hours"

# predefine scrapy shell arguments for different URLs
SCRAPYSHARG1="${SPLASHSERVER}/${RENDERTYPE}?url=${URL1}&timeout=${TIMEOUT}&wait=${WAITSEC}"
SCRAPYSHARG2="${SPLASHSERVER}/${RENDERTYPE}?url=${URL2}&timeout=${TIMEOUT}&wait=${WAITSEC}"
SCRAPYSHARG3="${SPLASHSERVER}/${RENDERTYPE}?url=${URL3}&timeout=${TIMEOUT}&wait=${WAITSEC}"

###########################################################
### Test1 with URL1: list of exchanges (stock markets) 
###########################################################
#scrapy shell 'https://www.stockmarketclock.com/exchanges/'
scrapy shell ${SCRAPYSHARG1}
response.xpath('//td[@data-title="Symbol"]').get()
response.xpath('//td[@data-title="Symbol"]/b/text()').getall()
response.xpath('//td[@data-title="Name"]/b/a/text()').getall()
response.xpath('//td[@data-title="Status"]/span').getall() # dynamically generated data with javascript

# get opening time for ${XMKT} only
response.xpath('//td[@data-title="Status"]/span[@data-exchange="${XMKT}"]').getall()

# exit shell
exit()

###########################################################
### Test2 with URL2: get specific information for ${XMKT}
###########################################################
#scrapy shell 'https://www.stockmarketclock.com/exchanges/${XMKT}#'
scrapy shell ${SCRAPYSHARG2}
response.css('table').getall()
response.css('td.Symbol').get()

response.xpath('//td[@data-title="Symbol"]').get()
response.xpath('//td[@data-title="Opening Bell"]/text()').get()
response.xpath('//td[@data-title="Closing Bell"]/text()').get()
response.xpath('//td[@data-title="Location"]/text()').get()

response.xpath('//td[@data-title="Status"]/text()').get() # dynamically generated data with javascript

response.xpath('//a[@href="#""]/text()').get()
response.xpath('//a[contains(@href, "title")]')
response.xpath('a/@data-placement').get()

# exit shell
exit()

###########################################################
### Test3 with URL3: get trading hours information for ${XMKT}
###########################################################
#scrapy shell 'https://www.stockmarketclock.com/exchanges/${XMKT}/trading-hours'
scrapy shell ${SCRAPYSHARG3}

# remaining opening time: days 
response.xpath('//td/span[@data-exchange-clock-days="${XMKT}"]/text()').get()
# remaining opening time: hours 
response.xpath('//td/span[@data-exchange-clock-hours="${XMKT}"]/text()').get()
# remaining opening time: minutes 
response.xpath('//td/span[@data-exchange-clock-minutes="${XMKT}"]/text()').get()
# remaining opening time: seconds 
response.xpath('//td/span[@data-exchange-clock-seconds="${XMKT}"]/text()').get()

# time zone 
tz = response.xpath('//p[@class="top-spaced"]/i/text()').getall()
tz[0]
tz[1]

# exit shell
exit()

###########################################################
### Test4 with URL4: upcoming holidays
###########################################################
#scrapy shell 'https://www.stockmarketclock.com/exchanges/${XMKT}/trading-hours'
scrapy shell ${SCRAPYSHARG3}



###########################################################
### Further tests
########################################################### 
scrapy shell 'https://www.stockmarketclock.com/exchanges/xetr/market-holidays/2019'
response.xpath('//tr').getall()

[tdit.attrib['data-title'] for tdit in response.css('td')]
# get alle feiertage (names)
response.xpath('//b/a/text()').getall()
# ohne next feiertag, just unique list
link = response.xpath('//div[@class="table-responsive"]')
link = response.xpath('//tbody')
link.xpath('//b/a/text()').getall()
# get alle feiertage (dates)
response.xpath('//td[@data-title="Observed Date"]/text()').getall()

# exit shell
exit()