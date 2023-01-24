import board

from kb import KMKKeyboard
from kmk.keys import KC
from kmk.scanners import DiodeOrientation
from kmk.extensions.RGB import RGB
from kmk.modules.layers import Layers

keyboard = KMKKeyboard()
# RGB
rgb = RGB(pixel_pin=board.A0, num_pixels=62,
          sat_default=0,
          val_default=10)
keyboard.extensions.append(rgb)
keyboard.modules.append(Layers())

xxxx = KC.TRNS
oooo = KC.NO
RGB_BRE = KC.RGB_MODE_BREATHE
RGB_PLA = KC.RGB_MODE_PLAIN
RGB_RAN = KC.RGB_MODE_RAINBOW
RGB_KNI = KC.RGB_MODE_KNIGHT
RGB_SWI = KC.RGB_MODE_SWIRL

keyboard.keymap = [
    [  # qwerty
        KC.ESC,    KC.N1,     KC.N2,     KC.N3,     KC.N4,     KC.N5,  KC.N6,     KC.N7,     KC.N8,     KC.N9,     KC.N0,     KC.MINS,	   KC.EQUAL,    KC.BSPACE,
        KC.TAB,    KC.Q,      KC.W,      KC.E,      KC.R,      KC.T,   KC.Y,      KC.U,      KC.I,      KC.O,      KC.P,      KC.LBRACKET, KC.RBRACKET, KC.DELETE,
        KC.ESC,    KC.A,      KC.S,      KC.D,      KC.F,      KC.G,   KC.H,      KC.J,      KC.K,      KC.L,      KC.SCLN,   KC.QUOT, 	   KC.GRAVE,    KC.ENT,
        KC.LSHIFT, KC.BSLASH, KC.Z,      KC.X,      KC.C,      KC.V,   KC.B,      KC.N,      KC.M,      KC.COMM,   KC.DOT,    KC.SLSH,     KC.RGB_TOG,     KC.RSHIFT,
                   KC.LCTRL,  KC.LGUI,   KC.LALT,                                 KC.SPC,                                     KC.MO(1),    KC.RCTRL, 
    ],
    [  # mod layer
        xxxx,    RGB_PLA,    RGB_BRE,    RGB_RAN,RGB_KNI,    RGB_SWI,   xxxx,       xxxx,      xxxx,        xxxx,       xxxx,       xxxx,       KC.RGB_HUI,       KC.RGB_SAI,
        xxxx,       xxxx,      KC.UP,       xxxx,   xxxx,       xxxx,   xxxx,       xxxx,      xxxx,        xxxx,       xxxx,       xxxx,       KC.RGB_HUD,       KC.RGB_SAD,
        xxxx,    KC.LEFT,    KC.DOWN,   KC.RIGHT,   xxxx,       xxxx,   xxxx,       xxxx,      xxxx,        xxxx,       xxxx,       xxxx, 	    xxxx,       KC.RGB_VAI,
        xxxx,       xxxx,       xxxx,       xxxx,   xxxx,       xxxx,   xxxx,       xxxx,      xxxx,        xxxx,       xxxx,       xxxx,       xxxx,       KC.RGB_VAD,
                    xxxx,       xxxx,       xxxx,                                   xxxx,                                           xxxx,       xxxx, 
    ],
]

if __name__ == '__main__':
    keyboard.go()
