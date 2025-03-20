import requests
import pandas as pd
from datetime import datetime, timedelta
import os


def process_earthquake_data():
    today_date = datetime.now()

    date_15_days_ago = today_date - timedelta(days=15)
    start_time = date_15_days_ago.strftime("%Y-%m-%d")
    end_time = today_date.strftime("%Y-%m-%d")

    #  define the API endpoint
    url = f"https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&starttime={start_time}&endtime={end_time}"

    # send a GET request to the API endpoint
    response = requests.get(url)
    # print(response.json())
    # print(response.status_code)

    # check if the request was successful
    if response.status_code == 200:
        # parse the response content as JSON
        data = response.json()

        # extract earthquake features
        features = data['features']

        # create a list of dictionaries containing relevan data
        earthquakes = []

        date = today_date.strftime("%Y_%m_%d")

        filename = f"/Users/new/Downloads/Tutorials/Data_Engineering/DE_Roadmap/Analyst_Builder/Foundation_of_Data_Pipelines/data/earthquake_{date}.csv"

        for feature in features:
            properties = feature['properties']
            geometry = feature['geometry']
            earthquake = {
                'time': properties['time'],
                'place': properties['place'],
                'magnitude': properties['mag'],
                'longitude': geometry['coordinates'][0],
                'latitude': geometry['coordinates'][1],
                'depth': geometry['coordinates'][2],
                'file_name': filename
            }
            earthquakes.append(earthquake)
        # print(earthquakes)

        # convert the list of dictionaries to a DataFrame
        df = pd.DataFrame(earthquakes)

        # use today's date variable to create a file name

        # check if the file exists
        if os.path.exists(filename):
            # if it exists, remove it
            os.remove(filename)
            print(f"File {filename} removed.")

        # create a new file
        df.to_csv(filename, index=False)
        print(f"File {filename} created and written to.")
    else:
        print(f"Failed to retrieve data: {response.status_code}")

def main():
    process_earthquake_data()


if __name__ == "__main__":
    main()