import difflib
import re
import time

import click
import requests


def get_url_content(url: str) -> str:
    """
    Fetch the content of a given URL.

    Parameters:
    - url (str): The URL whose content needs to be fetched.

    Returns:
    - str: The content of the URL if successful, None otherwise.
    """
    try:
        response = requests.get(url)
        response.raise_for_status()
        return response.text
    except requests.RequestException as e:
        click.echo(f"Error fetching URL content: {e}", err=True)
        return None


def display_diff(old_content: str, new_content: str) -> None:
    """
    Display the difference between the old and new content.

    Parameters:
    - old_content (str): The old content to compare.
    - new_content (str): The new content to compare.
    """
    diff = difflib.ndiff(old_content.splitlines(), new_content.splitlines())
    click.echo("\n".join(diff))


def find_regex_matches(content: str, regex: str) -> list:
    """
    Find lines in the content that match the provided regex.

    Parameters:
    - content (str): Content to search in.
    - regex (str): The regex pattern to search for.

    Returns:
    - list: A list of lines that match the regex.
    """
    return [line for line in content.splitlines() if re.search(regex, line)]


@click.command()
@click.argument("url")
@click.option(
    "--interval",
    default=5,
    help="Interval in seconds to check the URL for changes.",
    type=int,
)
@click.option(
    "--verbose",
    is_flag=True,
    default=False,
    help="Verbose mode. Print detailed error messages.",
)
@click.option(
    "--regex",
    default=None,
    help="Regex pattern to search in the content. If matches are found, they will be displayed and the program will exit.",
    type=str,
)
def monitor_url(url: str, interval: int, verbose: bool, regex: str) -> None:
    """
    Monitor the specified URL for content changes or for regex matches.

    Parameters:
    - url (str): The URL to be monitored.
    - interval (int): The time in seconds to wait between checks.
    - verbose (bool): Verbose flag to toggle detailed error messages.
    - regex (str): The regex pattern to search for.
    """
    initial_content = get_url_content(url)

    if initial_content is None:
        click.echo("Initial fetch failed. Exiting.", err=True)
        exit(1)

    click.echo(f"Monitoring {url} for changes every {interval} seconds...")

    while True:
        time.sleep(interval)
        current_content = get_url_content(url)

        if current_content is None:
            if verbose:
                click.echo("Error fetching URL content. Retrying...", err=True)
            else:
                click.echo(".", nl=False)
            continue

        if regex:
            matches = find_regex_matches(current_content, regex)
            if matches:
                click.echo("\nRegex matches found in the content:")
                for match in matches:
                    click.echo(match)
                exit(0)
        elif current_content != initial_content:
            click.echo("\nURL content has changed!")
            display_diff(initial_content, current_content)
            exit(0)


if __name__ == "__main__":
    monitor_url()
