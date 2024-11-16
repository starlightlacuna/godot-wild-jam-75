# Story Outline

## Prologue

This is a short introduction to the world. It has no options to choose from.

1. "Long ago, a war was waged by two nations. One, a nation of powerful warriors; the other a nation of great wizards. The armies of the nation of warriors, with their far superior numbers and better generals, easily conquered much of the territory of the nation of wizards. After tremendous losses, the wizards made their last stand in their capital's citadel."
2. "With the warriors streaming through and sacking their city, the wizards completed their final spell.The earth shook violently and the citadel was sundered as it was swallowed by the ground. When the dust settled, a terrible roar echoed across the land. Monsters erupted from the ruins and ripped and tore through the warrior armies. Thus was the first monster lair created."
3. "Though they only sought to bleed the nation of warriors, in their desperation the wizards made a mistake. Following the first lair, countless others appeared across the world, each bringing ruin to the surrounding lands. It took several generations and the combined efforts of many nations to retake the lost lands and destroy most of the lairs."
4. "Today, monsters are a normal part of life. New lairs materialize seemingly every week, and Ranger companies dedicated to finding and destroying them are ubiquitous. To ensure that their ranks are filled with the best monster slayers, many Ranger companies established academies that train young candidates."
5. "You live near one such academy, and soon you will be old enough to apply for admission. You decide to keep a journal of your time at the Ranger academy."

## Day 1 (Preparations)

The night before the ranger academy's entrance exam, The Student mentally prepares themself. They think about their rival and friend, who is also taking the exam.

The Player will make their first choices in this day. These choices will have both immediate and lasting effects through the rest of the journal entries.

1. Tomorrow's the entrance exam! I've been dreaming of this my whole life. I'm so
   1. excited! [Attitude +1]
   2. nervous... [Attitude -1]
2. {if Attitude > 0: I can't wait to go up to the proctor and flaunt my skills.} {if Attitude < 0: I hope that I don't embarrass myself in front of everyone.}
3. The other day I was at the market and saw my friend Sam. Even though we're not students yet, he's already putting in an order for an arming blade at the swordsmith! He's about the same age as me, but he's always been stronger and faster. Everyone thinks he'll be a great ranger and he's basically guaranteed to be accepted into the academy. I think he's 
   1. annoying. [Camaraderie -1]
   2. cool. [Camaraderie +1]
4. If I get accepted, we'll probably be in the same class. 
5. {if Camaraderie > 0: I'll work hard to catch up to him so our class will be the best in the academy.} {if Camaraderie < 0: I'll work hard to become better than him, so people will finally notice my skills.}
6. Anyway, I have to go to bed. The exam starts an hour after sunrise, so I need all the rest I can get!

## Day 2 (The Exam)

The Student passed the entrance exam and was admitted into the academy.

The text presented to The Player will take on different tones depending on the choices they made in the previous journal entry.

1. I just barely passed the entrance exam. First, they made us find the testing grounds in the middle of the forest surrounding the academy. We were given an hour, and a lot of the other applicants didn't make it in time. {if Camaraderie < 0: They were clearly not ranger material.}{if Camaraderie >= 0: Hopefully they train hard and try again next year.}
2. Then, at the grounds, they gave us wooden swords and had us spar with [b][i]actual rangers[/i][/b]. To pass, we had to land a hit on them. There were over thirty of us and only five rangers, but it wasn't even close. I got scratched and bruised pretty bad. {if Attitude < 0: I'm so weak!}{if Attitude >= 0: Rangers are so strong!}
3. I only managed to get hit one of them when Sam rushed in and feinted an attack. We both ended up facedown on the dirt, but our swords grazed the ranger's armor. Sam's attack was 
   1. lucky for me. It gave me the opening I needed to pass the exam. [Camaraderie -1]
   2. clever. It allowed both of us to pass the exam. [Camaraderie +1]
4. {if Camaraderie > 0: I helped Sam off the ground and thanked him.}{if Camaraderie == 0: Sam helped me off the ground.}{if Camaraderie < 0: Sam offered to help me off the ground, but I waved his hand away.}
5. By the end, a dozen of us were left. We passed the exam and starting tomorrow we'll be classmates. I'm  
   1. worried. Will the classes be as difficult as this exam? [Attitude -1]
   2. relieved. I'm on the way to becoming a ranger! [Attitude +1]
6. ...I'm exhausted, so I'll head off to bed.
   
## ~~Day 3 (Students)~~

~~After a month of classes, The Student has formed a few opinions about some of their classmates. Their friend is also in the class, and The Student has to deal with his presence.~~

~~The Player will have to make multiple choices to flesh out The Student's mindset. A few classmates (five max), will be briefly introduced through small vignettes.~~

~~1. I can't believe it's been a month already!~~

## Day 4 (The Expedition)

The Student and their class embarked on their first expedition. They went to a small lair to clear it out with the aid of a few rangers. Something went wrong, and The Student was injured along with some of their classmates.

The Player will see the consequences of their choices in the previous days. There very few choices to make that will affect at The Student's future in the academy and possibly as a ranger.

1. My class went on our first expedition. Rangers do this all the time. They travel to monster lairs and clear them out. Since we're still students, we weren't supposed to be fighting much. Just observing and providing support like keeping watch and maintaining armor and weapons.
2. Something went wrong though. The lair we targeted had grown faster than expected. The night before the raid, several monsters broke through the rangers' line and charged the camp. We had to fight for our lives.
3. I was tending a fire when a monster jumped out from the underbrush. It sent me flying several meters away with its tails. {if Attitude > 1: I managed to roll as I landed, so I wasn't injured.}{if Attitude <= 1: I landed so hard that a few ribs broke.}
4. Sam rushed over and helped me to my feet. We fought the monster for what felt like an eternity. Our swords barely scratched its hide, but it slashed and clawed us whenever we made any mistake.
5. At one point, Sam was knocked prone and the monster bared its fangs to strike.{if Camaraderie > 1: I pulled him out of the way just in time.}{if Camaraderie <= 1: I couldn't get to him fast enough so he got bit.}
6. We wouldn't have survived had a ranger not come to save us. She slew the monster and protected us until all the monsters were slain.
7. We returned to the academy the next day. Thankfully, nobody died, but several of us were injured. {if Attitude > 1: I only got some cuts and bruises, so I only needed a day before I could return to classes.}{if Attitude <= 0: I got injured pretty badly, and I couldn't move for several days.}
8. {if Camaraderie > 1: Sam wasn't injured too badly. He was back in class after a day.}{if Camaraderie <= 1: Sam had to be treated for the monster's venom. He was comatose for a week.}

# Stats

Attitude (Red/Blue) => #C74738/#38B8C7, #B4251C/#1CACB4
Camaraderie (Green/Purple) => #78B847/#8747B8, #5F9138/#6A3891, #4E782D/#8A50B9
