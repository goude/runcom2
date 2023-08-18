import time
import requests
import click
import difflib


def get_url_content(url):
    try:
        response = requests.get(url)
        response.raise_for_status()
        return response.text
    except requests.RequestException as e:
        click.echo(f"Error fetching URL content: {e}", err=True)
        return None


def display_diff(old_content, new_content):
    diff = difflib.ndiff(old_content.splitlines(), new_content.splitlines())
    click.echo("\n".join(diff))


@click.command()
@click.argument("url")
@click.option(
    "--interval",
    default=5,
    help="Interval in seconds to check the URL for changes.",
    type=int,
)
def main(url, interval):
    """
    Monitor the specified URL for content changes and exit when a change is detected.
    """
    initial_content = get_url_content(url)

    if initial_content is None:
        click.echo("Initial fetch failed. Exiting.", err=True)
        exit(1)

    click.echo(f"Monitoring {url} for changes every {interval} seconds...")

    while True:
        time.sleep(interval)  # Wait for specified interval before checking again
        current_content = get_url_content(url)

        if current_content is None:
            click.echo("Error fetching URL content. Retrying...", err=True)
            continue

        if current_content != initial_content:
            click.echo("URL content has changed!")
            display_diff(initial_content, current_content)
            exit(0)
    exit(0)


if __name__ == "__main__":
    main()
