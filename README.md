
# Custom System Call: Kernel 2D Memcpy

A new system call added to the Linux kernel (5.19.8), written in C, that copies a 2D floating-point matrix from one user-space buffer to another by going through kernel space. Built for an Operating Systems course.

## What it does

The system call (`hello_system_call`, number 451) works like `memcpy()` for a 2D matrix, except that the kernel does the copying:

1. It takes pointers to a source and a destination matrix, plus the number of rows and columns.
2. It reads the source matrix from user space into a kernel buffer with `copy_from_user()`.
3. It writes the buffer back out to the destination matrix with `copy_to_user()`.

`demo.c` is the test program. It hard-codes a 2x2 source matrix, calls the system call with `syscall(451, src, dest, 2, 2)` and prints the destination matrix to show that the copy worked.

## Deployment


1) Copy the linux kernel source (stock kernel with the custom config shared earlier) into  another directory (would be used later to generate **Diff** file).

2) In the copied linux kernel directory, open **syscall_64.tbl** under **arch/x86/entry/syscalls** & add this entry -
```bash
451 common hello_system_call sys_hello
```

3) I’ve named my system call as **hello_system_call**, which does the job of copying data from one 2D matrix to another.

4) Next, create another directory named **hello_syscall** in the copied kernel source directory, and add 2 files in it -
```bash
hello_syscall.c
Makefile
```

5) In the Makefile, add the code -
```bash
obj-y := hello_syscall.o
```

6) This will build the **hello_syscall.c** file. Here, **y** refers to **yes**.

7) Now, we’ll open the root of the kernel source (of the copy) and edit the Makefile using **vim** command.

8) At line **1103** add **hello_syscall/** at the end of the command. This builds our system call and gets it linked to the kernel.

9) Now Compilation & installation steps of the kernel -
```bash
make -j$(nproc)
sudo cp -v arch/x86_64/boot/bzImage /boot/vmlinuz-linux-5.19.8-special3
sudo make modules_install
sed s/linux/linux-5.19.8-special3/g </etc/mkinitcpio.d/linux.preset >/etc/mkinitcpio.d/linux-5.19.8-special3.preset
mkinitcpio -p linux-5.19.8-special3
grub-mkconfig -o /boot/grub/grub.cfg
```

10) Now we can boot into the new kernel & test the system call by compiling the **demo.c** program using the usual **gcc** command, and then running the generated executable file.


