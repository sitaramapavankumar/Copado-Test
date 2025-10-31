import os
import requests
import subprocess
import zipfile
import sys
import io

# Ensure proper encoding for Windows console
if sys.platform == "win32":
    sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8')


def get_installed_chrome_version():
    """Get the installed Chrome version from the Windows registry."""
    try:
        version = subprocess.check_output(
            ['reg', 'query', r'HKEY_CURRENT_USER\Software\Google\Chrome\BLBeacon', '/v', 'version']
        ).decode().strip().split()[-1]
        return version
    except Exception as e:
        print(f"Error getting Chrome version: {e}")
        return None


def get_chromedriver_url(chrome_version):
    """Construct the ChromeDriver download URL based on the installed Chrome version."""
    major_version = chrome_version.split('.')[0]  # Get the major version (e.g., '141')

    # Construct the download URL for win32
    url = f"https://storage.googleapis.com/chrome-for-testing-public/{chrome_version}/win64/chromedriver-win64.zip"
    return major_version, url


def download_chromedriver(download_folder, url):
    """Download the ChromeDriver for Windows."""
    if not os.path.exists(download_folder):
        os.makedirs(download_folder)  # Create the folder if it doesn't exist

    print(f"Downloading ChromeDriver from {url}...")
    response = requests.get(url, verify=False)  # Disable SSL verification
    if response.status_code == 200:
        zip_path = os.path.join(download_folder, "chromedriver.zip")
        with open(zip_path, 'wb') as file:
            file.write(response.content)
        print("Downloaded ChromeDriver.")
        return zip_path
    else:
        print(f"Failed to download ChromeDriver. Status code: {response.status_code}")
        return None


def extract_chromedriver(zip_path, extract_to):
    """Extract the downloaded ChromeDriver."""
    with zipfile.ZipFile(zip_path, 'r') as zip_ref:
        zip_ref.extractall(extract_to)
    print("Extracted ChromeDriver.")
    os.remove(zip_path)  # Clean up the zip file


if __name__ == "__main__":
    download_folder = "drivers"  # Specify the folder where ChromeDriver will be downloaded
    chrome_version = get_installed_chrome_version()
    if chrome_version:
        print(f"Installed Chrome version: {chrome_version}")
        major_version, chromedriver_url = get_chromedriver_url(chrome_version)

        # Check if the major version matches
        if major_version in chromedriver_url:
            zip_path = download_chromedriver(download_folder, chromedriver_url)
            if zip_path:
                extract_chromedriver(zip_path, download_folder)
        else:
            print("The Chrome version does not match the available ChromeDriver version.")
    else:
        print("Could not retrieve the installed Chrome version.")
