# -*- coding: utf-8 -*-

def addIntro(f):
	txt = '''  
# pi-gen-expand

此工程用于自动生成适配多个设备的树莓派系统。可以在workflow中指定设备和配置，然后自动生成对应的树莓派系统。

## Further Reading
- raspbian: https://elinux.org/images/f/f9/Petazzoni-device-tree-dummies_0.pdf
- reTerminal: https://github.com/ddvk/remarkable2-framebuffer
- reTerminal-plus: https://github.com/ddvk/remarkable2-framebuffer
- reComputer-R100X: https://github.com/ddvk/remarkable2-framebuffer

''' 
	f.write(txt)




if __name__=='__main__':
	f = open('README.md', 'w+')
	addIntro(f)
	f.close 