import requests
import argparse
from bs4 import BeautifulSoup


def get_information(command:str):
    command = str(command)
    def format_arguments(_command:str) -> str:
        # get arguments we need
        args = []
        arg = ""
        for c in _command:
            if c == " ":
                args.append(arg)
                arg = ""
                continue
            arg += c
        args.append(arg)
        result_str = ""
        len_args = len(args)
        for i in range(len_args):
            if i == len_args - 1:
                result_str += f"{args[i]}"
                break
            result_str += f"{args[i]}+"
        # print(result_str)
        return result_str
    cmd = format_arguments(command)

    print(f"your searching command line is: {cmd}")
    cookies = {
        'theme': 'default',
    }
    headers = {
        'Referer': f'https://explainshell.com/explain?cmd={cmd}',
    }
    params = {
        'cmd': command,
    }

    response = requests.get('https://explainshell.com/explain', params=params, cookies=cookies, headers=headers)
    # print(response.text)
    return response.text

def main():
    parser = argparse.ArgumentParser(description="Process some parameters.")
    # Define the arguments that can be passed in the command line
    parser.add_argument("command", type=str, help="command line")
    # Parse the arguments from the command line
    args = parser.parse_args()
    # Pass the parsed arguments to the function
    html_content = get_information(args.command)
    soup = BeautifulSoup(html_content, 'html.parser')
    # Find tags with class
    help_boxes = soup.find_all('pre', class_='help-box')

    for box in help_boxes:
        text = box.get_text(separator="", strip=True)
        print(text)

if __name__=="__main__":
    main()
