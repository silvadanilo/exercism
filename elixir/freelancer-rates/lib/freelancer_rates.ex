defmodule FreelancerRates do

  @hours_per_day 8.0
  @monthly_billable_days 22

  def daily_rate(hourly_rate) do
    hourly_rate * @hours_per_day
  end

  def daily_rate(hourly_rate, discount) do
    hourly_rate
    |> daily_rate()
    |> apply_discount(discount)
  end

  def monthly_rate(hourly_rate, discount) do
    hourly_rate
    |> daily_rate(discount)
    |> Kernel.*(@monthly_billable_days)
    |> ceil()
  end

  def days_in_budget(budget, hourly_rate, discount) do
    hourly_rate
    |> daily_rate(discount)
    |> then(& budget / &1)
    |> Float.floor(1)
  end

  def apply_discount(before_discount, discount) do
    before_discount - (before_discount / 100 * discount)
  end
end
