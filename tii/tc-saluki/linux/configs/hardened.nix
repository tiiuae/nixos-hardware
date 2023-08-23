''
##
## kernsec.org / kernel self protection project (KSPP) - section
##

# Report BUG() conditions and kill the offending process.
BUG y

# Make sure kernel page tables have safe permissions.
DEBUG_KERNEL y
DEBUG_RODATA y
STRICT_KERNEL_RWX y

# Report any dangerous memory permissions (not available on all archs).
DEBUG_WX y

# Use -fstack-protector-strong (gcc 4.9+) for best stack canary coverage.
# Prior to v4.18, these are:
#  CC_STACKPROTECTOR y
#  CC_STACKPROTECTOR_STRONG y
STACKPROTECTOR y
STACKPROTECTOR_STRONG y

# Do not allow direct physical memory access (but if you must have it, at least enable STRICT mode...)
DEVMEM n
STRICT_DEVMEM y
IO_STRICT_DEVMEM y

# Provides some protections against SYN flooding.
SYN_COOKIES y

# Perform additional validation of various commonly targeted structures.
DEBUG_CREDENTIALS y
DEBUG_NOTIFIERS y
DEBUG_LIST y
DEBUG_SG y
BUG_ON_DATA_CORRUPTION y
SCHED_STACK_END_CHECK y

# Provide userspace with seccomp BPF API for syscall attack surface reduction.
SECCOMP y
SECCOMP_FILTER y

# Provide userspace with ptrace ancestry protections.
SECURITY y
SECURITY_YAMA y

# Perform usercopy bounds checking. (And disable fallback to gain full whitelist enforcement.)
HARDENED_USERCOPY y
# HARDENED_USERCOPY_FALLBACK is not set
# HARDENED_USERCOPY_PAGESPAN is not set

# Randomize allocator freelists, harden metadata.
SLAB_FREELIST_RANDOM y
SLAB_FREELIST_HARDENED y

# Randomize high-order page allocation freelist.
SHUFFLE_PAGE_ALLOCATOR y

# Allow allocator validation checking to be enabled (see "slub_debug P" below).
# SLUB_DEBUG is not set

# Enable SLUB dynamic memory allocator to catch various memory allocation
# and usage issues
# SLUB_DEBUG_ON is not set

# Wipe higher-level memory allocations when they are freed (needs "page_poison 1" command line below).
# (If you can afford even more performance penalty, leave PAGE_POISONING_NO_SANITY n)
PAGE_POISONING y
PAGE_POISONING_NO_SANITY y
PAGE_POISONING_ZERO y

# Wipe slab and page allocations (since v5.3)
# Instead of "slub_debug P" and "page_poison 1", a single place can control memory allocation wiping now.
# The init_on_free is only needed if there is concern about minimizing stale data lifetime.
INIT_ON_ALLOC_DEFAULT_ON y
INIT_ON_FREE_DEFAULT_ON y

# Initialize all stack variables on function entry. (Clang builds only. For GCC, see GCC_PLUGIN_STRUCTLEAK_BYREF_ALL y below)
INIT_STACK_ALL y

# Adds guard pages to kernel stacks (not all architectures support this yet).
VMAP_STACK y

# Perform extensive checks on reference counting.
REFCOUNT_FULL y

# Check for memory copies that might overflow a structure in str*() and mem*() functions both at build-time and run-time.
FORTIFY_SOURCE y

# Avoid kernel memory address exposures via dmesg (sets sysctl kernel.dmesg_restrict initial value to 1)
SECURITY_DMESG_RESTRICT y

# Dangerous; enabling this allows direct physical memory writing.
ACPI_CUSTOM_METHOD n

# Dangerous; enabling this disables brk ASLR.
COMPAT_BRK n

# Dangerous; enabling this allows direct kernel memory writing.
DEVKMEM n

# Dangerous; exposes kernel text image layout.
PROC_KCORE n

# Dangerous; enabling this disables VDSO ASLR.
COMPAT_VDSO n

# Dangerous; enabling this allows replacement of running kernel.
KEXEC n

# Dangerous; enabling this allows replacement of running kernel.
HIBERNATION n

# Prior to v4.1, assists heap memory attacks; best to keep interface disabled.
INET_DIAG n

# Easily confused by misconfigured userspace, keep off.
BINFMT_MISC n

# Use the modern PTY interface (devpts) only.
LEGACY_PTYS n

# If SELinux can be disabled at runtime, the LSM structures cannot be read-only; keep off.
SECURITY_SELINUX_DISABLE n

# Reboot devices immediately if kernel experiences an Oops.
PANIC_ON_OOPS y
PANIC_TIMEOUT -1

# Keep root from altering kernel memory via loadable modules.
MODULES n

# But if MODULE y is needed, at least they must be signed with a per-build key.
# DEBUG_SET_MODULE_RONX y (prior to v4.11)
STRICT_MODULE_RWX y
MODULE_SIG y
MODULE_SIG_FORCE y
MODULE_SIG_ALL y
MODULE_SIG_SHA512 y
MODULE_SIG_HASH "sha512"
## MODULE_SIG_KEY "certs/signing_key.pem"

##
## kernsec.org KSPP - GCC plugins section
##

# Enable GCC Plugins
GCC_PLUGINS y

# Gather additional entropy at boot time for systems that may not have appropriate entropy sources.
GCC_PLUGIN_LATENT_ENTROPY y

# Force all structures to be initialized before they are passed to other functions.
# When building with GCC:
GCC_PLUGIN_STRUCTLEAK y
GCC_PLUGIN_STRUCTLEAK_BYREF_ALL y

# Wipe stack contents on syscall exit (reduces stale data lifetime in stack)
GCC_PLUGIN_STACKLEAK y

# Randomize the layout of system structures. This may have dramatic performance impact, so
# use with caution or also use GCC_PLUGIN_RANDSTRUCT_PERFORMANCE y
GCC_PLUGIN_RANDSTRUCT y


##
## kconfig-hardened-check tool provided setups
## (https://github.com/a13xp0p0v/kconfig-hardened-check.git)
##

# Enable IOMMU support for hardware isolation
IOMMU_SUPPORT y

# Enable virtual memory translation debug, can be expensive
# DEBUG_VIRTUAL is not set

# Route all usermode helper kernel calls through single binary only
# STATIC_USERMODEHELPER y - helper does not exist yet

# Clear busmaster bit of all PCI bridges to avoid malicious PCI devices to
# attack OS via DMA
EFI_DISABLE_PCI_DMA y

# Deny merging of slab caches to prevent heap overflow attacks
SLAB_MERGE_DEFAULT n

# Enable detection of directly indexed out of bounds array accesses for
# compile time
UBSAN n
# UBSAN_TRAP is not set
UBSAN_BOUNDS n
# UBSAN_MISC is not set
#TODO: Misaligned address in kernel, temporarily disable address sanitization
UBSAN_ALIGNMENT n


# Request firmware to clear the contents of RAM after a reboot to avoid
# reading secret contents from memory after a reboot, by booting e.g.
# another OS
RESET_ATTACK_MITIGATION y

# Enable Clang's shadow call stack, which uses a shadow call stack to
# protect function return addresses from being overwritten by an attacker.
# Depends on Clang.
SHADOW_CALL_STACK y

# Enable security lockdown enforcement. This prevents number of potentially
# dangerous kernel features and restricts "root" user access to some
# functionality also
SECURITY_LOCKDOWN_LSM y
SECURITY_LOCKDOWN_LSM_EARLY y
LOCK_DOWN_KERNEL_FORCE_CONFIDENTIALITY y

# Enable integrity subsystem
INTEGRITY y
INTEGRITY_SIGNATURE y
INTEGRITY_ASYMMETRIC_KEYS y
IMA y
IMA_MEASURE_PCR_IDX 10
IMA_DEFAULT_TEMPLATE "ima-ng"
IMA_DEFAULT_HASH_SHA1 y
IMA_DEFAULT_HASH "sha1"
IMA_APPRAISE y
IMA_APPRAISE_BOOTPARAM y
IMA_MEASURE_ASYMMETRIC_KEYS y
EVM y
EVM_ATTR_FSUUID y
DEFAULT_SECURITY_DAC y
LSM "lockdown,yama,loadpin,safesetid,integrity,selinux,bpf"

# Restrict UID/GID transitions from given UID/GID to only those approved
# by a system-wide whitelist
SECURITY_SAFESETID y

# Allow loading of kernel files (modules, fw, etc.) from the first filesystem
# only used for loading. Any others are rejected.
SECURITY_LOADPIN y
SECURITY_LOADPIN_ENFORCE y
##############################
# Prevent Kprobes tracing, as this can be used to expose pretty much everything
# from kernel
KPROBES n

# Hide trace interfaces
GENERIC_TRACER n

# Hide process memory details
PROC_PAGE_MONITOR n

# Disable direct IO port access from /dev (similar to DEVKMEM)
DEVPORT n

##### BISECT
# Disable debugfs, this exposes wide range of debug data
DEBUG_FS n

# Disable framebuffer to prevent direct memory access to graphics devices
FB n

# Disable virtual terminal to cut access interfaces
# VT n

# Disable POSIX asynchronous I/O
AIO n

# Disable staging drivers, as these can be considered non-product quality
STAGING n
######################### OK FROM HERE ###########################
# Disable runtime kernel symbols generation
KALLSYMS n
LATENCYTOP n

# Trim unused exported kernel symbols, to reduce image size / attack surface
TRIM_UNUSED_KSYMS y

# Disable magic sysrq key sequences
MAGIC_SYSRQ n

# Disable user namespaces
USER_NS n

# Prevent IO uring sharing between userspace / kernel
IO_URING n

# Don't automatically load TTY line disciples, prevents some legacy code to be
# used
LDISC_AUTOLOAD n

# Disable BPF syscall that allows to manipulate eBPF programs and maps via
# file descriptors
BPF_SYSCALL n

# Disable Stream control transmission protocol to minimize attack surface
DLM n
IP_SCTP n

# Disable kernel tracing infrastructure
FTRACE n

# Disable virtual video test driver, nothing testing related should be in
# production kernel
VIDEO_VIVID n

# Enable expert mode to allow modification of some configs
EXPERT y

# Randomize base address for mmap allocations, should be set to max allowable
# for the arch
ARCH_MMAP_RND_BITS 24

# Protect lowest 64KB of memory from user allocation
DEFAULT_MMAP_MIN_ADDR 65536

# Enable Inter Process Communication
HWSPINLOCK y
SYSVIPC y

''
