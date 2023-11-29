import math
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from scipy.signal import find_peaks  # Import the find_peaks function

def calculate_dft(data, num_frequencies):
    num_data = len(data)
    n2 = num_data / 2
    ret = {'frequency': [], 'ai': [], 'bi': [], 'power': []}
    
    for i in range(num_frequencies):
        s1 = 0
        s2 = 0
        s0 = sum(data)
        
        for j in range(1, num_data):
            angle = math.pi * i / n2 * (j + 1)
            cit = math.cos(angle)
            sit = math.sin(angle)
            s1 += cit * data[j]
            s2 += sit * data[j]
        
        s1 /= n2
        s2 /= n2
        
        ret['frequency'].append(i)
        ret['ai'].append(s1)
        ret['bi'].append(s2)
        ret['power'].append(s1 ** 2 + s2 ** 2)
    
    ret['ai'][0] = sum(data) / len(data)
    return pd.DataFrame(ret)

def main():
    solar_radia2017 = pd.read_excel('HalfHourSolarRadiation2017.xlsx')
    
    # Convert half-hourly data to daily data
    solar_radia2017['group'] = np.floor(solar_radia2017.index / 48)
    daily_data = solar_radia2017.groupby('group').sum()
    
    num_frequencies = 100
    daily_power_spectrum = calculate_dft(daily_data.GHI, num_frequencies)
    
    peaks, _ = find_peaks(daily_power_spectrum['power'][1:], height=0)
    important_frequencies = daily_power_spectrum['frequency'][peaks + 1]
    
    print("Important Frequencies:")
    for freq in important_frequencies:
        print(f"Frequency: {freq}, Power: {daily_power_spectrum['power'][freq + 1]}")
    
    plt.bar(daily_power_spectrum['frequency'][1:], daily_power_spectrum['power'][1:])
    plt.plot(important_frequencies, daily_power_spectrum['power'][peaks + 1], 'ro', label='Important Frequencies')
    plt.title('Daily Power Spectrum with Important Frequencies', fontsize=14)
    plt.xlabel('Frequency', fontsize=14)
    plt.ylabel('Amplitude', fontsize=14)
    plt.grid(True)
    plt.legend()
    plt.show()

if __name__ == "__main__":
    main()
