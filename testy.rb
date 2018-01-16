require 'mechanize'

agent = Mechanize.new
page = agent.get('http://surcom.dpiw.tas.gov.au/surcom/jsp/site/mark_search_public.jsp/')
pp page
google_form = page.form('f')
