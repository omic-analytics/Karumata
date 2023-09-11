#!/usr/bin/env python3

import json
import argparse

def check_aligned_gene_sequences(input_file):
    try:
        # Load JSON data from the input file
        with open(input_file, 'r') as file:
            data = json.load(file)

        # Check if the 'alignedGeneSequences' array is empty for the first item in the JSON data
        if not data[0]["alignedGeneSequences"]:
            print("The 'alignedGeneSequences' array is empty.")
            # Create an empty JSON file named 'noAlignment.json'
            with open('noAlignment.json', 'w') as output_file:
                json.dump([], output_file)
        else:
            print("The 'alignedGeneSequences' array is not empty.")
            # Use the input JSON file as the output file
            with open(input_file, 'w') as output_file:
                json.dump(data, output_file, indent=4)

    except FileNotFoundError:
        print(f"Error: The JSON file '{input_file}' does not exist.")
    except (json.JSONDecodeError, IndexError):
        print(f"Error: Invalid JSON data or missing 'alignedGeneSequences' array.")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Check if the 'alignedGeneSequences' array is empty in a JSON file.")
    parser.add_argument("--json", required=True, help="Path to the input JSON file")

    args = parser.parse_args()
    json_file = args.json

    check_aligned_gene_sequences(json_file)

