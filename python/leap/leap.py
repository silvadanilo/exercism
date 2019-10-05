def is_leap_year(year):
    return (is_divisible_for(year, 4) & (not is_divisible_for(year, 100)) | is_divisible_for(year, 400))

def is_divisible_for(number, divisor):
    return number % divisor == 0