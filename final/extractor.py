import random
import time
missed_fucks = ["fuck that", "fuck you!", "fuck you you fucker", "fuck me", "fuck", "fucking god dammit", "motherfucker", "fuck?", "fucker!", "fucking fuck", "fuckkkk","fucking", "fuck you!"]
write_to = open("recordedFucks.csv", "w+")
wowRecordedFucks = 462
def checkForFuck(line):
	if "fuck" in line:
		return 1;

script = "wowScript.txt"
infile = open(script, "r")
fuck_lines = []
for line in infile:
	line = line.replace('*','')
	line = line.replace('\n','')
	if checkForFuck(line):
		fuck_lines.append(line)

#this is to account for the discrepencies between the script and the movie
while len(fuck_lines) < wowRecordedFucks: 	
	fuck_lines.append(random.choice(missed_fucks))

random.shuffle(fuck_lines)

for line in fuck_lines:
	write_to.write(line + ',\n')

				

