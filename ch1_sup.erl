-module(ch1_sup).
-behaviour(supervisor).

-export([start_link/0]).
-export([init/1,start/0]).

start_link() ->
 {ok, Pid} = supervisor:start_link({local, ?MODULE}, 
 ?MODULE, []),
 {ok, Pid}.

init(_Args) ->
 RestartStrategy = {simple_one_for_one, 4, 60}, % restart no more 4 times per one minute, 
                                                % replace 4->4000 for long working  
 ChildSpec = {ch1, {ch1, start_link, []},
 permanent, brutal_kill, worker, [ch1]},
 Children = [ChildSpec],
 {ok, {RestartStrategy, Children}}.


start()->
% Start empty supervisor
 {ok,SPid}=start_link(),
 
% Start two children services
 {ok, Child1Pid} = supervisor:start_child(SPid, [id1]),
 {ok, Child2Pid} = supervisor:start_child(SPid, [id2]),

 timer:sleep(500),

% start loop for ticks
 spawn(fun()-> tick_loop() end).

tick(ID)->
    Pid=whereis(ID),
    gen_server:cast(Pid, tick).

tick_loop()->
 tick(id1),timer:sleep(500),
 tick(id2),timer:sleep(500),
 tick_loop().
     