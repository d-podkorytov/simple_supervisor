-module(ch1).

-behaviour(gen_server).
-compile(export_all).

start_link() ->
 gen_server:start_link(?MODULE, [], []).

start_link(ID) ->
 io:format("~p:~p has started ID=~p  ~n", [?MODULE,?LINE,ID]),
 gen_server:start_link({local,ID},?MODULE, [], []).

start_link(ID,MODULE,Arg,Opt) ->
 io:format("~p:~p has started arg=~p  ~n", [?MODULE,?LINE,{ID,MODULE,Arg,Opt}]),
 gen_server:start_link(ID,MODULE, Arg, Opt).

init(_Args) ->
io:format("~p:~p has started ~p ~p ~n", [?MODULE,?LINE,self(),_Args]),
% If the initialization is successful, the function
% should return {ok,State} or {ok,State,Timeout} 
 {ok, {started,{date(),time()}}}.
 
handle_cast(Subject, State) -> io:format("tick ~p ~p ~n",[self(),time()]), 
                               case random:uniform(4) of
                               1-> io:format("fail ~n",[]), 
                                   {fail_here,?MODULE,?LINE,A}=State;
                               _-> ok
                               end, 
                               {noreply, State}.

terminate(Reason, State)->
 io:format("~p:~p ~p has terminated by reason ~p ~p ~n", [?MODULE,?LINE,self(),Reason,State]),
 ok.                             

code_change(Vsn,State,Ext)->
 io:format("~p:~p code_change ~p ~p ~p ~n",[?MODULE,?LINE,Vsn,State,Ext]),{ok,State}.

handle_call(Request, From, State)->
 io:format("~p:~p handle_call ~p ~p ~p ~n",[?MODULE,?LINE,Request, From, State]),{noreply, State}.

handle_cast(Request, From, State)->
 io:format("~p:~p handle_cast ~p ~p ~p ~n",[?MODULE,?LINE,Request, From, State]),{noreply, State}.
 
handle_info(Info,State)->
 io:format("~p:~p handle_info ~p ~p  ~n",[?MODULE,?LINE,Info,State]),{noreply, State}. 

format_status(normal, [PDict, State]) -> {normal, [PDict, State]}.
 