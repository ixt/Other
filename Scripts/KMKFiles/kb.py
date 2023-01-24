import board

from kmk.kmk_keyboard import KMKKeyboard as _KMKKeyboard
from kmk.scanners import DiodeOrientation

# This is for a custom board made with Adafruit 5x6 NeoKey Snap apart plates
# and a Adafruit Feather Esp32-s3 4M Ram with the 2M PSRAM 
class KMKKeyboard(_KMKKeyboard):
    col_pins = (
    	    board.A5, # Esc
    	    board.A4, # 1
    	    board.A3, # 2
    	    board.A2, # 3
    	    board.RX, # 4
            board.TX, # 5
            board.D5, # 6
        	board.D6, # 7
    	    board.A1, # 8
    	    board.D9, # 9
    	    board.D10,# 0
    	    board.D11,# -
    	    board.D12,# =
    	    board.D13 # BS
    )
    row_pins = (board.SCK, board.MOSI, board.MISO, board.SCL, board.SDA)
    diode_orientation = DiodeOrientation.ROWS
    coord_mapping = [
     0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 
    14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 
    28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 
    42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55,
        57, 58, 59,             63,             67, 68,
    ]
