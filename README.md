# RBS_theoryII
This system is based on dialogue theory II, which allows the user ask why or why not questions based even they agree with the conclusion. We've created a big example for traffic route chosen, long chaining and provide one step of explanations. 

Some note: 
1. List all the possible rules and conditions in route1.pl. I test a small example in route2.pl (based on route1.pl), run ``deduce_backwards(chosen_route(alex, c), NodeList).`` , the system will print out the trees.

2. Example running: 
⋅⋅* ``['~/RBS_theoryII/chat.pl'].``
..* ``['~/RBS_theoryII/route4.pl'].``
..* ``chat.``
If you want to print out the trees: ``deduce_backwards(valid_route(c), NodeList).`` or ``deduce_backwards(find_route(00,30), NodeList).``
