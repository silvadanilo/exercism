defmodule BirdCount do
  def today([]), do: nil
  def today([today | _]), do: today

  def increment_day_count([]), do: [1]
  def increment_day_count([today | tail]), do: [today + 1 | tail]

  def has_day_without_birds?([]), do: false
  def has_day_without_birds?([0 | _tail]), do: true
  def has_day_without_birds?([_ | tail]), do: has_day_without_birds?(tail)

  def total([]), do: 0
  def total([today | tail]), do: today + total(tail)

  def busy_days([]), do: 0
  def busy_days([current_day | other_days]) when current_day >= 5, do: 1 + busy_days(other_days)
  def busy_days([_current_day | other_days]), do: busy_days(other_days)
end
