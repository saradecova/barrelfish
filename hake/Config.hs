--------------------------------------------------------------------------
-- Copyright (c) 2007-2010, 2012, 2013, 2015 ETH Zurich.
-- Copyright (c) 2014, HP Labs.
-- All rights reserved.
--
-- This file is distributed under the terms in the attached LICENSE file.
-- If you do not find this file, copies can be found by writing to:
-- ETH Zurich D-INFK, CAB F.78, Universitaetstr. 6, CH-8092 Zurich,
-- Attn: Systems Group.
--
-- Configuration options for Hake
-- 
--------------------------------------------------------------------------

module Config where

import HakeTypes
import Data.Char
import qualified Args
import Data.List
import Data.Maybe
import System.FilePath
import Tools (findTool, ToolDetails, toolPath, toolPrefix)
import qualified Tools

-- Set by hake.sh
toolroot         :: Maybe FilePath
arm_toolspec     :: Maybe (Maybe FilePath -> ToolDetails)
aarch64_toolspec :: Maybe (Maybe FilePath -> ToolDetails)
thumb_toolspec   :: Maybe (Maybe FilePath -> ToolDetails)
armeb_toolspec   :: Maybe (Maybe FilePath -> ToolDetails)
x86_toolspec     :: Maybe (Maybe FilePath -> ToolDetails)
k1om_toolspec    :: Maybe (Maybe FilePath -> ToolDetails)

-- Default toolchains
arm_tools     = fromMaybe Tools.arm_system
                          arm_toolspec
                toolroot
aarch64_tools = fromMaybe Tools.arm_netos_linaro_aarch64_2014_11
                          aarch64_toolspec
                toolroot
thumb_tools   = fromMaybe Tools.arm_netos_arm_2015q2
                          thumb_toolspec
                toolroot
armeb_tools   = fromMaybe Tools.arm_netos_linaro_be_2015_02
                          armeb_toolspec
                toolroot
x86_tools     = fromMaybe Tools.x86_system
                          x86_toolspec
                toolroot
k1om_tools    = fromMaybe Tools.k1om_netos_mpss_3_7_1
                          k1om_toolspec
                toolroot

-- ARM toolchain
arm_gnu_tool = findTool (toolPath arm_tools) (toolPrefix arm_tools)
arm_cc       = arm_gnu_tool "gcc"
arm_objcopy  = arm_gnu_tool "objcopy"
arm_objdump  = arm_gnu_tool "objdump"
arm_ar       = arm_gnu_tool "ar"
arm_ranlib   = arm_gnu_tool "ranlib"
arm_cxx      = arm_gnu_tool "g++"

-- ARM AArch64
aarch64_gnu_tool = findTool (toolPath aarch64_tools) (toolPrefix aarch64_tools)
aarch64_cc       = aarch64_gnu_tool "gcc"
aarch64_objcopy  = aarch64_gnu_tool "objcopy"
aarch64_objdump  = aarch64_gnu_tool "objdump"
aarch64_ar       = aarch64_gnu_tool "ar"
aarch64_ranlib   = aarch64_gnu_tool "ranlib"
aarch64_cxx      = aarch64_gnu_tool "g++"

-- ARM thumb (e.g. -M profile) toolchain
thumb_gnu_tool = findTool (toolPath thumb_tools) (toolPrefix thumb_tools)
thumb_cc       = thumb_gnu_tool "gcc"
thumb_objcopy  = thumb_gnu_tool "objcopy"
thumb_objdump  = thumb_gnu_tool "objdump"
thumb_ar       = thumb_gnu_tool "ar"
thumb_ranlib   = thumb_gnu_tool "ranlib"
thumb_cxx      = thumb_gnu_tool "g++"

-- ARM big-endian (e.g. XScale) toolchain
armeb_gnu_tool = findTool (toolPath armeb_tools) (toolPrefix armeb_tools)
armeb_cc       = armeb_gnu_tool "gcc"
armeb_objcopy  = armeb_gnu_tool "objcopy"
armeb_objdump  = armeb_gnu_tool "objdump"
armeb_ar       = armeb_gnu_tool "ar"
armeb_ranlib   = armeb_gnu_tool "ranlib"
armeb_cxx      = armeb_gnu_tool "g++"

-- X86 (32/64) toolchain
x86_gnu_tool = findTool (toolPath x86_tools) (toolPrefix x86_tools)
x86_cc       = x86_gnu_tool "gcc"
x86_objcopy  = x86_gnu_tool "objcopy"
x86_objdump  = x86_gnu_tool "objdump"
x86_ar       = x86_gnu_tool "ar"
x86_ranlib   = x86_gnu_tool "ranlib"
x86_cxx      = x86_gnu_tool "g++"

-- Xeon Phi toolchain
k1om_gnu_tool = findTool (toolPath k1om_tools) (toolPrefix k1om_tools)
k1om_cc      = k1om_gnu_tool "gcc"
k1om_objcopy = k1om_gnu_tool "objcopy"
k1om_objdump = k1om_gnu_tool "objdump"
k1om_ar      = k1om_gnu_tool "ar"
k1om_ranlib  = k1om_gnu_tool "ranlib"
k1om_cxx     = k1om_gnu_tool "g++"

-- Miscellaneous tools
gem5         = "gem5.fast"
runghc       = "runghc"    -- run GHC interactively
circo        = "circo"     -- from graphviz
dot          = "dot"       --   "    "
inkscape     = "inkscape"

-- path to source and install directories; these are automatically set by
-- hake.sh at setup time 
source_dir :: String
-- source_dir = undefined -- (set by hake.sh, see end of file)

install_dir :: String
-- install_dir = undefined -- (set by hake.sh, see end of file)

cache_dir :: String
-- cache_dir = undefined -- (set by hake.sh, see end of file)

-- Set of architectures for which to generate rules
architectures :: [String]
-- architectures = undefined -- (set by hake.sh, see end of file)

-- Libelf include path and linker options for building tools that need to
-- manipulate ELF files (arm_boot and usbboot).
-- (defaults for Ubuntu w/ libelf-freebsd and freebsd-glue)
libelf_include :: String
libelf_include = "/usr/include/freebsd"
libelf_link :: String
libelf_link = "-lelf-freebsd"

-- Libusb include path and linker options for building usbboot
libusb_include :: String
libusb_include = "/usr/include/libusb-1.0"
libusb_libdir :: String
libusb_libdir = "/usr/lib"

-- Optimisation flags (-Ox -g etc.) passed to compiler
cOptFlags :: [String]
cOptFlags = ["-g", "-O2"]

newlib_malloc :: String
--newlib_malloc = "sbrk"     -- use sbrk and newlib's malloc()
--newlib_malloc = "dlmalloc" -- use dlmalloc
newlib_malloc = "oldmalloc"

-- Configure pagesize for libbarrelfish's morecore implementation
-- x86_64 accepts "small", "large", and "huge" for 4kB, 2MB and 1GB pages
-- respectively. x86_32 accepts "small" and "large" for 4kB and 2MB/4MB pages
-- respectively. All other architectures default to their default page size.
morecore_pagesize :: String
morecore_pagesize = "small"

-- Use a frame pointer
use_fp :: Bool
use_fp = True

-- Default timeslice duration in milliseconds
timeslice :: Integer
timeslice = 80

-- Put kernel into microbenchmarks mode
microbenchmarks :: Bool
microbenchmarks = False

-- Enable tracing
trace :: Bool
trace = False

-- Enable QEMU networking. (ie. make network work in small memory)
support_qemu_networking :: Bool
support_qemu_networking  = False

-- enable network tracing
trace_network_subsystem :: Bool
trace_network_subsystem = False

-- May want to disable LRPC to improve trace visuals
trace_disable_lrpc :: Bool
trace_disable_lrpc = False

-- use Kaluga
use_kaluga_dvm :: Bool
use_kaluga_dvm = True

-- Domain and driver debugging
global_debug :: Bool
global_debug = False

e1000n_debug :: Bool
e1000n_debug = False

eMAC_debug :: Bool
eMAC_debug = False

rtl8029_debug :: Bool
rtl8029_debug = False

ahcid_debug :: Bool
ahcid_debug = False

libahci_debug :: Bool
libahci_debug = False

vfs_debug :: Bool
vfs_debug = False

ethersrv_debug :: Bool
ethersrv_debug = False

netd_debug :: Bool
netd_debug = False

libacpi_debug :: Bool 
libacpi_debug = False

acpi_interface_debug :: Bool
acpi_interface_debug = False

acpi_service_debug :: Bool
acpi_service_debug = False

acpi_server_debug :: Bool
acpi_server_debug = False

lpc_timer_debug :: Bool
lpc_timer_debug = False

lwip_debug :: Bool
lwip_debug = False

libpci_debug :: Bool
libpci_debug = False

usrpci_debug :: Bool
usrpci_debug = False

timer_debug :: Bool
timer_debug = False

eclipse_kernel_debug :: Bool
eclipse_kernel_debug = False

skb_debug :: Bool
skb_debug = False

skb_client_debug :: Bool
skb_client_debug = False

flounder_debug :: Bool
flounder_debug = False

flounder_failed_debug :: Bool
flounder_failed_debug = False

webserver_debug :: Bool
webserver_debug = False

sqlclient_debug :: Bool
sqlclient_debug = False

sqlite_debug :: Bool
sqlite_debug = False

sqlite_backend_debug :: Bool
sqlite_backend_debug = False

nfs_debug :: Bool
nfs_debug = False

rpc_debug :: Bool
rpc_debug = False

loopback_debug :: Bool
loopback_debug = False

octopus_debug :: Bool
octopus_debug = False

term_debug :: Bool
term_debug = False

serial_debug :: Bool
serial_debug = False

-- Deadlock debugging
debug_deadlocks :: Bool
debug_deadlocks = False

-- Partitioned memory server
memserv_percore :: Bool
memserv_percore = False

-- Enable capability tracing debug facility
caps_trace :: Bool
caps_trace = False

-- Mapping Database configuration options (this affects lib/mdb/)
-- enable extensive tracing of mapping db implementation
mdb_trace :: Bool
mdb_trace = False

-- enable tracing of top level mdb_insert, mdb_remove calls
mdb_trace_no_recursive :: Bool
mdb_trace_no_recursive = False

-- fail on invariant violations
mdb_fail_invariants :: Bool
mdb_fail_invariants = True

-- check invariants before/after mdb_insert/mdb_remove.
mdb_check_invariants :: Bool
mdb_check_invariants = False

-- recheck invariants at each tracing point
mdb_recheck_invariants :: Bool
mdb_recheck_invariants = False

-- enable extensive tracing of mapping db implementation (userspace version)
mdb_trace_user :: Bool
mdb_trace_user = False

-- fail on invariant violations
mdb_fail_invariants_user :: Bool
mdb_fail_invariants_user = True

-- recheck invariants at each tracing point
mdb_recheck_invariants_user :: Bool
mdb_recheck_invariants_user = True

-- check invariants before/after mdb_insert/mdb_remove.
mdb_check_invariants_user :: Bool
mdb_check_invariants_user = True

-- Select scheduler
data Scheduler = RBED | RR deriving (Show,Eq)
scheduler :: Scheduler
scheduler = RBED

-- Physical Address Extensions (PAE)-enabled paging on x86-32
pae_paging :: Bool
pae_paging = False

-- Page Size Extensions (PSE)-enabled paging on x86-32
-- Always enabled when pae_paging == True, regardless of value
pse_paging :: Bool
pse_paging = False

-- No Execute Extensions (NXE)-enabled paging on x86-32
-- May not be True when pae_paging == False
nxe_paging :: Bool
nxe_paging = False

oneshot_timer :: Bool
oneshot_timer = False

-- Enable hardware VM support for AMD's Secure Virtual Machine (SVM)
-- If disabled, Intel's VMX hardware is supported instead
config_svm :: Bool
config_svm = True

-- Enable the use of only Arrakis domains (with arrakismon)
-- If disabled, use normal VM-guests (with vmkitmon)
config_arrakismon :: Bool
config_arrakismon = False

defines :: [RuleToken]
defines = [ Str ("-D" ++ d) | d <- [
             if microbenchmarks then "CONFIG_MICROBENCHMARKS" else "",
             if trace then "CONFIG_TRACE" else "",
             if support_qemu_networking then "CONFIG_QEMU_NETWORK" else "",
             if trace_network_subsystem then "NETWORK_STACK_TRACE" else "",
             if trace_disable_lrpc then "TRACE_DISABLE_LRPC" else "",
             if global_debug then "GLOBAL_DEBUG" else "",
             if e1000n_debug then "E1000N_SERVICE_DEBUG" else "",
             if ahcid_debug then "AHCI_SERVICE_DEBUG" else "",
             if libahci_debug then "AHCI_LIB_DEBUG" else "",
             if vfs_debug then "VFS_DEBUG" else "",
             if eMAC_debug then "EMAC_SERVICE_DEBUG" else "",
             if rtl8029_debug then "RTL8029_SERVICE_DEBUG" else "",
             if ethersrv_debug then "ETHERSRV_SERVICE_DEBUG" else "",
             if netd_debug then "NETD_SERVICE_DEBUG" else "",
             if libacpi_debug then "ACPI_DEBUG_OUTPUT" else "",
             if acpi_interface_debug then "ACPI_BF_DEBUG" else "",
             if acpi_service_debug then "ACPI_SERVICE_DEBUG" else "",
             if lpc_timer_debug then "LPC_TIMER_DEBUG" else "",
             if lwip_debug then "LWIP_BARRELFISH_DEBUG" else "",
             if libpci_debug then "PCI_LIB_DEBUG" else "",
             if usrpci_debug then "PCI_SERVICE_DEBUG" else "",
             if timer_debug then "TIMER_CLIENT_DEBUG" else "",
             if eclipse_kernel_debug then "ECLIPSE_KERNEL_DEBUG" else "",
             if skb_debug then "SKB_SERVICE_DEBUG" else "",
             if skb_client_debug then "SKB_CLIENT_DEBUG" else "",
             if flounder_debug then "FLOUNDER_DEBUG" else "",
             if flounder_failed_debug then "FLOUNDER_FAILED_DEBUG" else "",
             if webserver_debug then "WEBSERVER_DEBUG" else "",
             if sqlclient_debug then "SQL_CLIENT_DEBUG" else "",
             if sqlite_debug then "SQL_SERVICE_DEBUG" else "",
             if sqlite_backend_debug then "SQL_BACKEND_DEBUG" else "",
             if nfs_debug then "NFS_CLIENT_DEBUG" else "",
             if rpc_debug then "RPC_DEBUG" else "",
             if loopback_debug then "LOOPBACK_DEBUG" else "",
             if octopus_debug then "DIST_SERVICE_DEBUG" else "",
             if term_debug then "TERMINAL_LIBRARY_DEBUG" else "",
             if serial_debug then "SERIAL_DRIVER_DEBUG" else "",
             if debug_deadlocks then "CONFIG_DEBUG_DEADLOCKS" else "",
             if memserv_percore then "CONFIG_MEMSERV_PERCORE" else "",
             if pae_paging then "CONFIG_PAE" else "",
             if pse_paging then "CONFIG_PSE" else "",
             if nxe_paging then "CONFIG_NXE" else "",
             if oneshot_timer then "CONFIG_ONESHOT_TIMER" else "",
             if config_svm then "CONFIG_SVM" else "",
             if config_arrakismon then "CONFIG_ARRAKISMON" else "",
             if use_kaluga_dvm then "USE_KALUGA_DVM" else "",
             if caps_trace then "TRACE_PMEM_CAPS" else ""
             ], d /= "" ]


-- Sets the include path for lwIP
lwipInc :: String
lwipInc = "/lib/lwip/src/include"
lwipxxxInc :: String
lwipxxxInc = "/lib/lwip/src/include/ipv4"

-- some defines depend on the architecture/compile options
arch_defines :: Options -> [RuleToken]
arch_defines opts
    -- enable config flags for interconnect drivers in use for this arch
    = [ Str ("-D" ++ d)
       | d <- ["CONFIG_INTERCONNECT_DRIVER_" ++ (map toUpper n)
               | n <- optInterconnectDrivers opts]
      ]
    -- enable config flags for flounder backends in use for this arch
    ++ [ Str ("-D" ++ d)
       | d <- ["CONFIG_FLOUNDER_BACKEND_" ++ (map toUpper n)
               | n <- optFlounderBackends opts]
      ]

-- newlib common compile flags (maybe put these in a config.h file?)
newlibAddCFlags :: [String]
newlibAddCFlags = [ "-DPACKAGE_NAME=\"newlib\"" ,
                    "-DPACKAGE_TARNAME=\"newlib\"",
                    "-DPACKAGE_VERSION=\"1.19.0\"",
                    "-DPACKAGE_BUGREPORT=\"\"",
                    "-DPACKAGE_URL=\"\"",
                    "-D_I386MACH_ALLOW_HW_INTERRUPTS",
                    "-DMISSING_SYSCALL_NAMES",
                    "-D_WANT_IO_C99_FORMATS",
                    "-D_COMPILING_NEWLIB",
                    "-D_WANT_IO_LONG_LONG",
                    "-D_WANT_IO_LONG_DOUBLE",
                    "-D_MB_CAPABLE",
                    "-D__BSD_VISIBLE"]

-- Automatically added by hake.sh. Do NOT copy these definitions to the defaults
source_dir       = "/home/manu/barrelfish/"
architectures    = [ "armv7" ]
install_dir      = "."
toolroot         = Nothing
arm_toolspec     = Nothing
aarch64_toolspec = Nothing
thumb_toolspec   = Nothing
armeb_toolspec   = Nothing
x86_toolspec     = Nothing
k1om_toolspec    = Nothing
cache_dir        = "/home/manu/.cache/barrelfish"
hagfish_location = "/home/netos/tftpboot/Hagfish.efi"
