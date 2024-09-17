import argparse
from pathlib import Path
output = "/home/berat/Desktop/Development/python-scripts/sourceCodeScanner/output.txt"
codeExecution = ["exec", "eval", "passthru", "system", "shel_exec", '`', "popen", "proc_open", "pcntl_exec"]
userInput = ["$_GET", "$_POST", "$_REQUEST"]
fileSystem = ["fopen", "tmpfile", "bzopen", "gzopen", "chgrp", "chmod", "chown", "copy", "file_put_contents", "mkdir", "move_uploaded_file", "touch", "readfile", "is_uploaded_file"]
## Verilen klasörü okuyor istenilen klasöre yazıyor ## 🙂
def searchFile(directory, words, output="/home/berat/Desktop/out.txt"):
    p = Path(directory)
    with open(output, "a+", encoding='utf-8') as result_file:
        for file in p.iterdir():
            if file.is_file():
                with file.open('r', encoding='utf-8') as current_file:
                    for line_number, line in enumerate(current_file, 1):
                        for word in words:
                            if word in line:
                                result = (f"{line_number} Satırda {file.name} dosyasında: "
                                          f"{word} kelime bulundu:\n{line.strip()}\n")
                                print(result)  
                                result_file.write(result)  
def main():
    parser = argparse.ArgumentParser(description="Komut satırı argümanları almak")
    parser.add_argument("-d", "--directory", type=str, help="Klasörün bulunduğu dizi")
    parser.add_argument("-c", "--codeExec", action="store_true", help="codeExecution taraması yapar")
    parser.add_argument("-u", "--userInput", action="store_true", help="Kullanıcı girdileri taraması yapar")
    parser.add_argument("-f", "--fileSystem", action="store_true", help="fileSystem taraması yapar")
    parser.add_argument("-a", "--all", action="store_true", help="Full tarama yapılır")
    args = parser.parse_args() 
    operation(args)

def operation(args):
    if args.directory:
        if args.codeExec:
            searchFile(str(args.directory), codeExecution)
        elif args.userInput:
            searchFile(str(args.directory), userInput)
        elif args.fileSystem:
            searchFile(str(args.directory), fileSystem)
        elif args.all:
          allPayload = fileSystem + codeExecution + userInput
          searchFile(str(args.directory), allPayload)          
    else:
        print("Directory yok")

if __name__ == "__main__":
    main()    
#searchFile(directory, codeExecution, output)

