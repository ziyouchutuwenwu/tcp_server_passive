%%%-------------------------------------------------------------------
%% @doc tcp_server_passive public API
%% @end
%%%-------------------------------------------------------------------

-module(tcp_server_passive_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    tcp_server_passive_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
