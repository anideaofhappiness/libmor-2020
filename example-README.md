# [Publisher] Faculty Publications
---
## Contents (that should be there for most software)
- Configuration
- Installation
- Operating instructions
- File Manifest
- Copyright and Licensing
- Contact information
- Known bugs
- Troubleshooting
- Acknowledgments
- News

---
## Contents (that feel more useful to me)
- What was the context of what I was trying to do?
- Does this script work yet? How much?
- Were there things I couldn't get to work so I benched them but could revisit later with more time?
- File Manifest _**Including**_
  - where did this come from/how was it made/what does it mean?
  - lazy codebook

---
## Project Goals
Understand faculty publications in the [Publisher] journals
### Major Questions:
1. How extensive are faculty publications in the content we subscribe to?
2. In the content we don't subscribe to?
3. Are there major patterns in publication numbers?
4. How many Gold OA APCs are our faculty likely to have paid?
5. Are there major trends in Gold OA publishing?

---
## Script Status: Operational
Pending features: none
***

## File Manifest
### [PB]-FacPub2019.csv
I gathered the publication data manually from Web of Science (2019/10/09) by using the institution enhanced search and the title of each publication from the [Publisher]. Papers were determined to be GoldOA when WoS indicated they were available for free through the publisher platform and I confirmed that they weren't part of any of the Green OA initiatives (after a 12 month embargo all of [Publisher] publications are made freely OA). I also tracked self-archiving behavior through the unpaywall integration as this might illustrate a desire for OA publication without the funding to support a GoldOA APC.
##### Fields:
  - journal: title of the journal
  - year: year of publication
  - num_pub: number of publications
  - num_goldOA: number of goldOA articles published
  - unpaywall: number of articles found through unpaywall integration. I expected this to be more of a thing and it really wasn't
  - sub: do we subscribe yes/no. Also expected this to be more of a thing and it wasn't

### [PB]-FacPub2019.R
This is the script that I used to do all of the data processing and visualization from the raw data gathered in[PB]-FacPub2019.csv. Everything should be in here and it was working the last time I touched it.
##### Outputs: (nothing automatically, but it will generate a couple of plots)
  - plots saved in Images folder in directory. All graphs include both subscribed and unsubscribed content.
  1. gOA-yr.png :: GoldOA publications per year by journal title
  2. pub-jrnl-yr.png :: articles published per year by journal title
  3. pub-per-yr.png :: articles published per year, does not include journal information
