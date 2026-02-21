package main

import "core:fmt"
import "core:os/os2"

import "core:unicode"
import "core:unicode/utf8"
import "core:unicode/utf16"
import "core:path/filepath"
import "core:sys/windows"
import "core:strings"

/*
	Features Legend:
	[ ] Not Done
	[-] W.I.P
	[x] Done
	Features to Add:
	[ ] Tabluar View (rows and columns) for just content
	[ ] All ls commands

*/

Views :: enum {
	TABLE,
	LIST,
}

TextStyle :: enum {
	RESET,
	BLACK,
	RED,
	GREEN,
	YELLOW,
	BLUE,
	MAGENTA,
	CYAN,
	WHITE,
}
text_style := [TextStyle]string{ .RESET = "\033[0m",
	.BLACK = "\033[30m",
	.RED = "\033[31m",
	.GREEN = "\033[32m",
	.YELLOW = "\033[33m",
	.BLUE = "\033[34m",
	.MAGENTA = "\033[35m",
	.CYAN = "\033[36m",
	.WHITE = "\033[37m"
}

// TextIcons & text_icons are not being used right now
// Terminal not displaying unicode characters correctly
TextIcons :: enum {
	FOLDER
}
text_icons := [TextIcons]rune{
	.FOLDER = '\U0001F5C0'
}

DEFUALT_VIEW :: Views.TABLE


get_files_tabular_view :: proc(directory: string = ".") {
	contents, err := os2.read_directory_by_path(path = directory, n = 0, allocator = context.allocator)
	if err != nil {
		fmt.eprintf("Could not read directory: %v", err)
		os2.exit(0)
	}

	min_content_len := 0
	max_content_len := 0
	for i in 0..<len(contents){

		if i == 1{
			min_content_len = len(contents[i].name)
			max_content_len = len(contents[i].name)
		}

		if len(contents[i].name) <= min_content_len {
			min_content_len = len(contents[i].name)
		}

		if len(contents[i].name) > max_content_len{
			max_content_len = len(contents[i].name)
		}
	}

	content_spacing:int
	row := 0
	fmt.printf("%s%s%s%s%s\n", text_style[.YELLOW], "[","Files", "]", text_style[.RESET])
	for content in contents {
		if content.type == .Regular {
			if row == 3 {
				row = 0
				fmt.printf("\n")
			}
			b := strings.builder_make()
			if len(content.name) == max_content_len {
				fmt.printf("%s ", content.name)
			}
			else {
				content_spacing = max_content_len - len(content.name) + 1
				for i in 0..<content_spacing {
					strings.write_string(&b, " ")
				}
				spacing := strings.to_string(b)
				fmt.printf("%s%s", content.name, spacing)
				// fmt.printf("%s%s ", content.name, spacing)
			}
			row += 1

		}
	}
	fmt.printf("\n")
	fmt.printf("\n")
}



get_folders_tabular_view :: proc(directory: string = ".") {

	contents, err := os2.read_directory_by_path(path = directory, n = 0, allocator = context.allocator)
	if err != nil {
		fmt.eprintf("Could not read directory: %v", err)
		os2.exit(0)
	}

	min_content_len := 0
	max_content_len := 0
	for i in 0..<len(contents){

		if i == 1{
			min_content_len = len(contents[i].name)
			max_content_len = len(contents[i].name)
		}

		if len(contents[i].name) <= min_content_len {
			min_content_len = len(contents[i].name)
		}

		if len(contents[i].name) > max_content_len{
			max_content_len = len(contents[i].name)
		}
	}

	content_spacing:int
	row := 0

 	fmt.printf("%s%s%s%s%s\n", text_style[.CYAN], "[","Folders", "]", text_style[.RESET])
	for content in contents {
		if content.type == .Directory {
			if row == 3 {
				row = 0
				fmt.printf("\n")
			}
			b := strings.builder_make()
			if len(content.name) == max_content_len {
				fmt.printf("%s ", content.name)
			}
			else {
				content_spacing = max_content_len - len(content.name) + 1
				for i in 0..<content_spacing {
					strings.write_string(&b, " ")
				}
				spacing := strings.to_string(b)
				// fmt.printf("%s   ", content.name)
				fmt.printf("%s%s", content.name, spacing)
			}
			row += 1
		}
	}
	fmt.printf("\n")
	fmt.printf("\n")
}


get_tabular_view :: proc(directory: string = "./") {

	contents, err := os2.read_directory_by_path(path = directory, n = 0, allocator = context.allocator)
	if err != nil {
		fmt.eprintf("Could not read directory: %v", err)
		os2.exit(0)
	}

	min_content_len := 0
	max_content_len := 0
	for i in 0..<len(contents){

		if i == 1{
			min_content_len = len(contents[i].name)
			max_content_len = len(contents[i].name)
		}

		if len(contents[i].name) <= min_content_len {
			min_content_len = len(contents[i].name)
		}

		if len(contents[i].name) > max_content_len{
			max_content_len = len(contents[i].name)
		}
	}

	content_spacing:int
	row := 0

 	fmt.printf("%s%s%s%s%s\n", text_style[.CYAN], "[","Folders", "]", text_style[.RESET])
	for content in contents {
		if content.type == .Directory {
			if row == 3 {
				row = 0
				fmt.printf("\n")
			}
			b := strings.builder_make()
			if len(content.name) == max_content_len {
				fmt.printf("%s ", content.name)
			}
			else {
				content_spacing = max_content_len - len(content.name) + 1
				for i in 0..<content_spacing {
					strings.write_string(&b, " ")
				}
				spacing := strings.to_string(b)
				// fmt.printf("%s   ", content.name)
				fmt.printf("%s%s", content.name, spacing)
			}
			row += 1
		}
	}
	fmt.printf("\n")
	fmt.printf("\n")

	row = 0

	fmt.printf("%s%s%s%s%s\n", text_style[.YELLOW], "[","Files", "]", text_style[.RESET])
	for content in contents {
		if content.type == .Regular {
			if row == 3 {
				row = 0
				fmt.printf("\n")
			}
			b := strings.builder_make()
			if len(content.name) == max_content_len {
				fmt.printf("%s ", content.name)
			}
			else {
				content_spacing = max_content_len - len(content.name) + 1
				for i in 0..<content_spacing {
					strings.write_string(&b, " ")
				}
				spacing := strings.to_string(b)
				fmt.printf("%s%s", content.name, spacing)
				// fmt.printf("%s%s ", content.name, spacing)
			}
			row += 1

		}
	}
	fmt.printf("\n")
	fmt.printf("\n")
}

get_folders_only :: proc(directory: string = "."){
	// This only returns the folders in the provided directory
	contents, err := os2.read_directory_by_path(path = directory, n = 0, allocator = context.allocator)
	if err != nil {
		fmt.eprintf("Could not read directory: %v", err)
		os2.exit(0)
	}

	for content in contents{
		if content.type == .Directory {

			fmt.printf("%s%s%s%s%s %s\n", text_style[.CYAN], "[","fldr", "]", text_style[.RESET], content.name )
		}
	}
}

get_files_only :: proc(directory: string = "."){
	// This only returns the files in the provided directory
	contents, err := os2.read_directory_by_path(path = directory, n = 0, allocator = context.allocator)
	if err != nil {
		fmt.eprintf("Could not read directory: %v", err)
		os2.exit(0)
	}


	for content in contents{
		if content.type == .Regular {
			fmt.printf("%s%s%s%s%s %s\n", text_style[.YELLOW], "[","file", "]", text_style[.RESET], content.name )
		}
	}

}

get_list_view :: proc(directory:string = "") {
	contents, err := os2.read_directory_by_path(path = directory, n = 0, allocator = context.allocator)
	if err != nil {
		fmt.eprintf("Could not read directory: %v", err)
		os2.exit(0)
	}


	for content in contents {
		if content.type == .Directory {
			fmt.printf("%s%s%s%s%s %s\n", text_style[.CYAN], "[","fldr", "]", text_style[.RESET], content.name)
		}
		if content.type == .Regular{
			fmt.printf("%s%s%s%s%s %s\n", text_style[.YELLOW], "[","file", "]", text_style[.RESET], content.name)
		}
	}
}

get_files_list_view :: proc(directory:string = "") {

	contents, err := os2.read_directory_by_path(path = directory, n = 0, allocator = context.allocator)
	if err != nil {
		fmt.eprintf("Could not read directory: %v", err)
		os2.exit(0)
	}

	for content in contents {
		if content.type == .Regular{
			fmt.printf("%s%s%s%s%s %s\n", text_style[.YELLOW], "[","file", "]", text_style[.RESET], content.name)
		}
	}
}

get_folders_list_view :: proc(directory:string = "") {

	contents, err := os2.read_directory_by_path(path = directory, n = 0, allocator = context.allocator)
	if err != nil {
		fmt.eprintf("Could not read directory: %v", err)
		os2.exit(0)
	}

	for content in contents {
		if content.type == .Directory {
			fmt.printf("%s%s%s%s%s %s\n", text_style[.CYAN], "[","fldr", "]", text_style[.RESET], content.name)
		}
	}
}

main :: proc() {
	args := os2.args
	fmt.println()
	fmt.println("Command Line Arguments: ", args)
	fmt.println()

	cwd, err := os2.getwd(allocator = context.allocator)
	if err != nil {
		fmt.eprintf("Could not read directory: %v", err)
		os2.exit(0)
	}

	// There are three functions to get directory contents:
	// get_folders_only | get_files_only | navi.get_dir_info
	// get_folders/files_only is navi.get_dir_info but results are filters for specific optins
	// navi.get_dir_info will return the all the directory contents (files & folders)

	contents, error := os2.read_directory_by_path(path = ".", n = 0, allocator = context.allocator)
	if error != nil {
		fmt.eprintf("Could not read directory: %v", err)
		os2.exit(0)
	}

	// // if 'lx' is run with no arguments
	// if len(args) == 0{

	// 	cwd, err = os2.getwd(allocator = context.allocator)
	// 	if err != nil {
	// 		fmt.eprintf("Could not read directory: %v", err)
	// 		os2.exit(0)
	// 	}
	// 	get_tabular_view(cwd)
	// } else if len(args) == 1{
	// 	if os2.is_dir(args[0]) == false {
	// 		fmt.println("Argument needs to be a directory.")
	// 		return
	// 	}

	// 	// temp_contents, temp_ok := navi.get_dir_info(args[0])
	// 	// if temp_ok == false{
	// 	// 	fmt.println("Could not get contetns of directory")
	// 	// 	return
	// 	// }

	// 	get_tabular_view(args[0])

	// 	// for dir in contents {
	// 	// 	if dir.is_dir == true{
	// 	// 		fmt.printf("%s%s%s%s%s %s\n", text_style[.CYAN], "[","fldr", "]", text_style[.RESET], dir.name )
	// 	// 	}
	// 	// 	if dir.is_dir == false{
	// 	// 		fmt.printf("%s%s%s%s%s %s\n", text_style[.YELLOW], "[","file", "]", text_style[.RESET], dir.name )
	// 	// 	}
	// 	// 	// fmt.println(dir.name)
	// 	// }

	// } else if len(args) == 2 {
	// 	if os2.is_dir(args[0]) == false {
	// 		fmt.println("First argument needs to be a filepath")
	// 		return
	// 	}
	// 	if args[1] == "-d"{
	// 		get_folders_tabular_view(args[0])
	// 		// get_folders_only(args[0])
	// 	}else if args[1] == "-f"{
	// 		get_files_tabular_view(args[0])
	// 		// get_files_only(args[0])
	// 	}  else if args[1] == "-l" {
	// 		get_list_view(args[0])
	// 	}
	// } else if len(args) == 3 {
	// 	if args[1] != "-l"{
	// 		fmt.println("Argument amount requires -l to be second arg.")
	// 		return
	// 	}

	// 	if args[2] == "-d"{
	// 		get_folders_list_view(args[0])
	// 	}
	// 	if args[2] == "-f"{
	// 		get_files_list_view(args[0])
	// 	}
	// }

	switch len(args) {
		case 1:
			get_list_view(".")
		case 2:
		case 3:
	}

}
