-module(tcp_client_sup).

-behaviour(supervisor).

-export([start_link/0, start_child/2]).
-export([init/1]).

start_link() ->
  supervisor:start_link({local,?MODULE}, ?MODULE, []).

start_child(Sock, ConfigBehaviorImpl) ->
  supervisor:start_child(?MODULE, [Sock, ConfigBehaviorImpl]).

init([]) ->
  MaxRestarts = 5,
  MaxSecondsBetweenRestarts = 10,

  SupervisorFlags =
    #{strategy => simple_one_for_one,
      intensity => MaxRestarts,
      period => MaxSecondsBetweenRestarts},

  ChildSpecs =
    [
      #{
        id => client_handler,
        start => {client_handler, start_link, []},
        restart => transient,
        shutdown => brutal_kill,
        type => worker,
        modules => [client_handler]
      }
    ],

  {ok, {SupervisorFlags, ChildSpecs}}.