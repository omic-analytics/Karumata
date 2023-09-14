#!/usr/bin/env python3

import csv
import sys
import os

# Check if at least one input file is provided
if len(sys.argv) < 2:
    print("Usage: python combine_csv.py <input_file1.csv> <input_file2.csv> ...")
    sys.exit(1)

# Extract the input file names from command-line arguments
input_files = sys.argv[1:]

# Automatically generate the output file name
output_file = "combined.csv"

# Initialize an empty list to store combined data
combined_data = []

# Loop through each input file
for file_name in input_files:
    with open(file_name, 'r', newline='') as csvfile:
        reader = csv.DictReader(csvfile)
        
        # Read the first row (header)
        headers = reader.fieldnames
        
        # Read the second row (entries)
        row = next(reader)
        
        # Combine the headers and entries as a dictionary
        combined_entry = {header: row[header] for header in headers}
        
        # Append the combined entry to the list
        combined_data.append(combined_entry)

# Write the combined data to the output CSV file
with open(output_file, 'w', newline='') as csvfile:
    writer = csv.DictWriter(csvfile, fieldnames=headers)
    
    # Write the header row
    writer.writeheader()
    
    # Write the combined entries
    writer.writerows(combined_data)

print(f'Combined data written to {output_file}')

