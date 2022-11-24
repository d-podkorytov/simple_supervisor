# An simple_one_to_one supervisor example.

## Modules:
ch_sup.erl is supervisor
ch1.erl    is child service for supervision.

As first it start empty supervisor,
join to it two services with id1 and id2 names.

Services id1 and id2 is ticking loops, with some probability of fail.
Number of restarts is restricted to 4 per minute.
So, if it will reached supervisor, id1 and id2 will terminated.

Also it is a part of my delivering ERLANG to my students .

