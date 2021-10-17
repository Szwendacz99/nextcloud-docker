#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>

int main() {
    setuid(geteuid());
    system("bash /usr/bin/start_script_root.sh");
    exit(0);
}
