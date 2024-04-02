import requests
import time
from datetime import datetime, timedelta

def get_binance_kline_data(symbol, interval):
    base_url = "https://api.binance.com/api/v3/klines"
    params = {
        'symbol': symbol,
        'interval': interval
    }
    response = requests.get(base_url, params=params)
    data = response.json()
    return data

def write_exchange_rate_to_file(symbol, rate, output_file):
    current_time = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    with open(output_file, 'a') as file:
        file.write(f'{current_time} - {symbol} rate: {rate}\n')

def main():
    symbol = 'BTCUSDT'
    interval = '5m'
    output_file = 'exchange_rates.txt'

    while True:
        try:
            start_time = datetime.now()
            kline_data = get_binance_kline_data(symbol, interval)
            current_rate = float(kline_data[-1][4])  # Closing price of the latest candlestick
            previous_rate = float(kline_data[-2][4])  # Closing price of the previous candlestick
            rate_change = current_rate - previous_rate
            direction = "increased" if rate_change > 0 else "decreased"
            write_exchange_rate_to_file(symbol, f'{current_rate} ({direction} by {abs(rate_change)})', output_file)

            # Calculate the remaining time until the next 5-minute interval
            elapsed_time = (datetime.now() - start_time).total_seconds()
            remaining_time = max(300 - elapsed_time, 0)
            time.sleep(remaining_time)
        except Exception as e:
            print(f"An error occurred: {e}")
            time.sleep(60)  # Wait for a minute before retrying

if __name__ == "__main__":
    main()
