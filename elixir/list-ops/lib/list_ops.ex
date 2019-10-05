defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  # @spec count(list) :: non_neg_integer
  # def count([]) do
  #   0
  # end

  # def count([_h | t]) do
  #   1 + count(t)
  # end

  # def reverse(l) do
  #   do_reverse([], l)
  # end

  # defp do_reverse(acc, []) do
  #   acc
  # end

  # defp do_reverse(acc, [h | t]) do
  #   do_reverse([h | acc], t)
  # end

  # @spec map(list, (any -> any)) :: list
  # def map([], _f) do
  #   []
  # end

  # def map([h | t], f) do
  #   [f.(h) | map(t, f)]
  # end

  # @spec filter(list, (any -> as_boolean(term))) :: list
  # def filter([], _f) do
  #   []
  # end

  # def filter([h | t], f) do
  #   if f.(h) do
  #     [h | filter(t, f)]
  #   else
  #     filter(t, f)
  #   end
  # end

  # @type acc :: any
  # @spec reduce(list, acc, (any, acc -> acc)) :: acc
  # def reduce([], acc, _f) do
  #   acc
  # end

  # def reduce([h | t], acc, f) do
  #   reduce(t, f.(h, acc), f)
  # end

  # @spec append(list, list) :: list
  # def append([], []) do
  #   []
  # end

  # def append([], b) do
  #   b
  # end

  # def append(a, []) do
  #   a
  # end

  # def append([h | t], b) do
  #   [h | append(t, b)]
  # end

  # # ALTERNATIVE VERSION
  # # def append(a, b) do
  # #   a
  # #   |> reverse()
  # #   |> reduce(b, &([&1 | &2]))
  # # end

  # @spec concat([[any]]) :: [any]
  # def concat([]) do
  #   []
  # end

  # def concat([single]) do
  #   single
  # end

  # def concat(ll) do
  #   ll
  #   |> reverse()
  #   |> reduce([], &append(&1, &2))
  # end

  # ALTERNATIVE VERSION USING OUR REDUCE
  @type acc :: any
  @spec reduce(list, acc, (any, acc -> acc)) :: acc
  def reduce([], acc, _f) do
    acc
  end

  def reduce([h | t], acc, f) do
    reduce(t, f.(h, acc), f)
  end

  @spec count(list) :: non_neg_integer
  def count(list) do
    list
    |> reduce(0, fn _e, acc -> acc + 1 end)
  end

  def reverse(l) do
    reduce(l, [], fn e, acc -> [e | acc] end)
  end

  @spec map(list, (any -> any)) :: list
  def map(l, f) do
    reduce(reverse(l), [], fn e, acc -> [f.(e) | acc] end)
  end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f) do
    reduce(reverse(l), [], fn e, acc ->
      if f.(e) do
        [e | acc]
      else
        acc
      end
    end)
  end

  def append(a, b) do
    a
    |> reverse()
    |> reduce(b, &[&1 | &2])
  end

  @spec concat([[any]]) :: [any]
  def concat([]) do
    []
  end

  def concat([single]) do
    single
  end

  def concat(ll) do
    ll
    |> reverse()
    |> reduce([], &append(&1, &2))
  end
end
