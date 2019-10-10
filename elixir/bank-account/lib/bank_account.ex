defmodule BankAccount do
  use GenServer

  @moduledoc """
  A bank account that supports access from multiple processes.
  """

  @typedoc """
  An account handle.
  """
  @opaque account :: pid

  @doc """
  Open the bank. Makes the account available.
  """
  @spec open_bank() :: account
  def open_bank() do
    {:ok, account} = GenServer.start_link(__MODULE__, 0)
    account
  end

  @doc """
  Close the bank. Makes the account unavailable.
  """
  @spec close_bank(account) :: none
  def close_bank(account) do
    GenServer.stop(account)
  end

  @doc """
  Get the account's balance.
  """
  @spec balance(account) :: integer
  def balance(account) do
    case Process.alive?(account) do
      true -> GenServer.call(account, :balance)
      false -> {:error, :account_closed}
    end
  end

  @doc """
  Update the account's balance by adding the given amount which may be negative.
  """
  @spec update(account, integer) :: any
  def update(account, amount) when is_pid(account) do
    case Process.alive?(account) do
      true -> GenServer.cast(account, {:update, amount})
      false -> {:error, :account_closed}
    end
  end

  def init(state), do: {:ok, state}

  def handle_call(:balance, _from, state) do
    {:reply, state, state}
  end

  def handle_cast({:update, amount}, state) do
    {:noreply, state + amount}
  end
end
