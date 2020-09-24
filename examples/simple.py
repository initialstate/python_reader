import time
from ISReader.Reader import Reader

reader = Reader(debug_level=3, ini_file_location="./isreader.ini")

def test_loop(i):
    while i > 0:
        events = reader.get_latest()
        print(events)
        time.sleep(1)
        i -= 1

test_loop(3)
