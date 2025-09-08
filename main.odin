package main

import "core:fmt"
import "core:io"
import "core:os/os2"
import "core:time"
import "core:strings"
import "core:c/libc"
import "core:unicode/utf8"


FOLDER :: '📁'
DOCUMENT :: '📜'
PC :: '💻'


done:bool

view_directory :: proc() {

	file, open_err := os2.open(name = ".") //-> (^File, Error)

	n:int
	files, err := os2.read_directory(f = file, n = n, allocator = context.allocator)// -> (files: []File_Info, err: Error)

	if err != nil {
		fmt.eprintf("Error: %v: Could not read directory", err)
	}

	for f in files{

		if os2.is_file(f.fullpath) {

			if strings.contains(s = f.fullpath, substr = ".exe") {
				
				fmt.printf("%v %v\n",PC, f.fullpath)
			} else {
				fmt.printf("%v %v\n",DOCUMENT, f.fullpath)
			}
			
		} else if os2.is_directory(f.fullpath) {
			fmt.printf("%v %v\n",FOLDER, f.fullpath)
		}
		
	}
	
	close_err := os2.close(f = file) // -> Error {
}

main :: proc() {
	view_directory()
}


