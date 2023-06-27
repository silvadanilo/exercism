defmodule DancingDots.Animation do
  @type dot :: DancingDots.Dot.t()
  @type opts :: keyword
  @type error :: any
  @type frame_number :: pos_integer

  @callback init(opts()) :: {:ok, opts()} | {:error, error()}
  @callback handle_frame(dot(), frame_number(), opts()) :: dot()

  defmacro __using__(_) do
    quote do
      @behaviour DancingDots.Animation

      alias DancingDots.Dot

      @impl true
      def init(opts), do: {:ok, opts}
      defoverridable init: 1
    end
  end
end

defmodule DancingDots.Flicker do
  use DancingDots.Animation

  @impl true
  def handle_frame(dot, frame_number, _opts) when rem(frame_number, 4) == 0 do
    Map.update!(dot, :opacity, &(&1 / 2))
  end

  def handle_frame(dot, _frame_number, _opts), do: dot
end

defmodule DancingDots.Zoom do
  use DancingDots.Animation

  @impl true
  def init(opts) do
    velocity = Keyword.get(opts, :velocity)

    if is_number(velocity) do
      {:ok, opts}
    else
      {:error,
       "The :velocity option is required, and its value must be a number. Got: #{inspect(velocity)}"}
    end
  end

  @impl true
  def handle_frame(dot, frame_number, opts) do
    velocity = opts[:velocity] * (frame_number - 1)
    Map.update!(dot, :radius, &(&1 + velocity))
  end
end
