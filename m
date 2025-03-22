Return-Path: <linux-kernel+bounces-572391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2EFA6C9E8
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 12:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC6484661E8
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 11:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A88C1FAC5A;
	Sat, 22 Mar 2025 11:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UD+CvYSp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCF11DBB2E
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 11:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742643191; cv=none; b=R+qqQ5lDuP/YBBLSwvi9AR3PUZHf/aty/A1GyvN9gFLVTo3EyXBZlVt3WQnD416TWoSOrmMjZ3+1SnorQ+oqhZpjJ2/crRdqSoPuAfxsO48wXZx5DdII2Q8+VjyqbmquYAiOyK605sFRUGcBdgnj/t82N0EyOMK53C6w0ASK2Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742643191; c=relaxed/simple;
	bh=Cp0nkJpDlAHabbgzbroiGBCDXTPTMhaECZ5yI8ZlHi0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=B9PzjctnzIchtj1yPsHVjat8kE1XFZpkWvX5OtIF0/YEOz9NUkZ/FrrO9D+7iBlEa3RwTu97yJMeryKqOeD9MSQJYfAr246JfKC3KZi0IDv5KGWKUI+8/pjWMJyiDrWvUuuqOe9UMWeXLNJ8EhLi7v7ddhQQz2wG7jmXmaKfbZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UD+CvYSp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9D23C4CEDD;
	Sat, 22 Mar 2025 11:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742643191;
	bh=Cp0nkJpDlAHabbgzbroiGBCDXTPTMhaECZ5yI8ZlHi0=;
	h=Date:From:To:Cc:Subject:From;
	b=UD+CvYSpTqy6nJsz9ZD+Apdh5o4Le6lj9sKhV0NUERnluBtHoxD+IPxZ1qfOxP0lK
	 Qvp3Gzu689tah5YZC0RemDeE9rlET0eZ/4sESFMeXbMSi6ygirhujR92Z/Mm7+Sm2v
	 NdLKF8nJIsyp01kvugRSKvlMIkLstZGoqvPKnY+PvFdmWSjzJ3xHZ2DVWCHGyKX9FL
	 XVveXx1/cWXg/NKJhWkoUfeZ2o450z3Iq5jF62p/mH0MHiOEJ6xMo2KKmHY0WDO3zO
	 gO0y9o6ODP2fhBO1LtxOxVTZ4BxSA5eBlSdpjkUhS+0K4JClPZRIoKr/i1cV/R8/H5
	 6fZTZwBhti96g==
Date: Sat, 22 Mar 2025 12:33:06 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave@sr71.net>
Subject: [GIT PULL] x86 core updates for v6.15
Message-ID: <Z96f8i3nJgdV4O9g@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest x86/core Git tree for v6.15 from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-core-2025-03-22

   # HEAD: 1400c87e6cac47eb243f260352c854474d9a9073 zstd: Increase DYNAMIC_BMI2 GCC version cutoff from 4.8 to 11.0 to work around compiler segfault

[ Merge note: this pull request depends on you having merged
              two locking commits in the locking tree,
	      part of the locking-core-2025-03-22 pull request. ]

x86 CPU features support:
  - Generate the <asm/cpufeaturemasks.h> header based on build config
    (H. Peter Anvin, Xin Li)
  - x86 CPUID parsing updates and fixes (Ahmed S. Darwish)
  - Introduce the 'setcpuid=' boot parameter (Brendan Jackman)
  - Enable modifying CPU bug flags with '{clear,set}puid='
    (Brendan Jackman)
  - Utilize CPU-type for CPU matching (Pawan Gupta)
  - Warn about unmet CPU feature dependencies (Sohil Mehta)
  - Prepare for new Intel Family numbers (Sohil Mehta)

Percpu code:
  - Standardize & reorganize the x86 percpu layout and
    related cleanups (Brian Gerst)
  - Convert the stackprotector canary to a regular percpu
    variable (Brian Gerst)
  - Add a percpu subsection for cache hot data (Brian Gerst)
  - Unify __pcpu_op{1,2}_N() macros to __pcpu_op_N() (Uros Bizjak)
  - Construct __percpu_seg_override from __percpu_seg (Uros Bizjak)

MM:
  - Add support for broadcast TLB invalidation using AMD's INVLPGB instruction
    (Rik van Riel)
  - Rework ROX cache to avoid writable copy (Mike Rapoport)
  - PAT: restore large ROX pages after fragmentation
    (Kirill A. Shutemov, Mike Rapoport)
  - Make memremap(MEMREMAP_WB) map memory as encrypted by default
    (Kirill A. Shutemov)
  - Robustify page table initialization (Kirill A. Shutemov)
  - Fix flush_tlb_range() when used for zapping normal PMDs (Jann Horn)
  - Clear _PAGE_DIRTY for kernel mappings when we clear _PAGE_RW
    (Matthew Wilcox)

KASLR:
  - x86/kaslr: Reduce KASLR entropy on most x86 systems,
    to support PCI BAR space beyond the 10TiB region
    (CONFIG_PCI_P2PDMA=y) (Balbir Singh)

CPU bugs:
  - Implement FineIBT-BHI mitigation (Peter Zijlstra)
  - speculation: Simplify and make CALL_NOSPEC consistent (Pawan Gupta)
  - speculation: Add a conditional CS prefix to CALL_NOSPEC (Pawan Gupta)
  - RFDS: Exclude P-only parts from the RFDS affected list (Pawan Gupta)

System calls:
  - Break up entry/common.c (Brian Gerst)
  - Move sysctls into arch/x86 (Joel Granados)

Intel LAM support updates: (Maciej Wieczor-Retman)
  - selftests/lam: Move cpu_has_la57() to use cpuinfo flag
  - selftests/lam: Skip test if LAM is disabled
  - selftests/lam: Test get_user() LAM pointer handling

AMD SMN access updates:
  - Add SMN offsets to exclusive region access (Mario Limonciello)
  - Add support for debugfs access to SMN registers (Mario Limonciello)
  - Have HSMP use SMN through AMD_NODE (Yazen Ghannam)

Power management updates: (Patryk Wlazlyn)
  - Allow calling mwait_play_dead with an arbitrary hint
  - ACPI/processor_idle: Add FFH state handling
  - intel_idle: Provide the default enter_dead() handler
  - Eliminate mwait_play_dead_cpuid_hint()

Bootup:

Build system:
  - Raise the minimum GCC version to 8.1 (Brian Gerst)
  - Raise the minimum LLVM version to 15.0.0
    (Nathan Chancellor)

Kconfig: (Arnd Bergmann)
  - Add cmpxchg8b support back to Geode CPUs
  - Drop 32-bit "bigsmp" machine support
  - Rework CONFIG_GENERIC_CPU compiler flags
  - Drop configuration options for early 64-bit CPUs
  - Remove CONFIG_HIGHMEM64G support
  - Drop CONFIG_SWIOTLB for PAE
  - Drop support for CONFIG_HIGHPTE
  - Document CONFIG_X86_INTEL_MID as 64-bit-only
  - Remove old STA2x11 support
  - Only allow CONFIG_EISA for 32-bit

Headers:
  - Replace __ASSEMBLY__ with __ASSEMBLER__ in UAPI and non-UAPI headers
    (Thomas Huth)

Assembly code & machine code patching:
  - x86/alternatives: Simplify alternative_call() interface (Josh Poimboeuf)
  - x86/alternatives: Simplify callthunk patching (Peter Zijlstra)
  - KVM: VMX: Use named operands in inline asm (Josh Poimboeuf)
  - x86/hyperv: Use named operands in inline asm (Josh Poimboeuf)
  - x86/traps: Cleanup and robustify decode_bug() (Peter Zijlstra)
  - x86/kexec: Merge x86_32 and x86_64 code using macros from <asm/asm.h>
    (Uros Bizjak)
  - Use named operands in inline asm (Uros Bizjak)
  - Improve performance by using asm_inline() for atomic locking instructions
    (Uros Bizjak)

Earlyprintk:
  - Harden early_serial (Peter Zijlstra)

NMI handler:
  - Add an emergency handler in nmi_desc & use it in nmi_shootdown_cpus()
    (Waiman Long)

Miscellaneous fixes and cleanups:

  - by Ahmed S. Darwish, Andy Shevchenko, Ard Biesheuvel,
    Artem Bityutskiy, Borislav Petkov, Brendan Jackman, Brian Gerst,
    Dan Carpenter, Dr. David Alan Gilbert, H. Peter Anvin,
    Ingo Molnar, Josh Poimboeuf, Kevin Brodsky, Mike Rapoport,
    Lukas Bulwahn, Maciej Wieczor-Retman, Max Grobecker,
    Patryk Wlazlyn, Pawan Gupta, Peter Zijlstra,
    Philip Redkin, Qasim Ijaz, Rik van Riel, Thomas Gleixner,
    Thorsten Blum, Tom Lendacky, Tony Luck, Uros Bizjak,
    Vitaly Kuznetsov, Xin Li, liuye.

 Thanks,

	Ingo

------------------>


Ahmed S. Darwish (7):
      x86/cpuid: Include <linux/build_bug.h> in <asm/cpuid.h>
      x86/cpu: Remove unnecessary headers and reorder the rest
      x86/cpu: Use max() for CPUID leaf 0x2 TLB descriptors parsing
      x86/cpu: Simplify TLB entry count storage
      x86/cacheinfo: Remove unnecessary headers and reorder the rest
      <linux/sizes.h>: Cover all possible x86 CPU cache sizes
      x86/cpuid: Refactor <asm/cpuid.h>

Andy Shevchenko (1):
      x86/pat: Fix W=1 build warning when the within_inclusive() function is unused

Ard Biesheuvel (3):
      x86/module: Deal with GOT based stack cookie load on Clang < 17
      x86/head/64: Avoid Clang < 17 stack protector in startup code
      x86/asm: Make asm export of __ref_stack_chk_guard unconditional

Arnd Bergmann (10):
      x86/Kconfig: Add cmpxchg8b support back to Geode CPUs
      x86/smp: Drop 32-bit "bigsmp" machine support
      x86/build: Rework CONFIG_GENERIC_CPU compiler flags
      x86/cpu: Drop configuration options for early 64-bit CPUs
      x86/mm: Remove CONFIG_HIGHMEM64G support
      x86/mm: Drop CONFIG_SWIOTLB for PAE
      x86/mm: Drop support for CONFIG_HIGHPTE
      x86/cpu: Document CONFIG_X86_INTEL_MID as 64-bit-only
      x86/pci: Remove old STA2x11 support
      x86/platform: Only allow CONFIG_EISA for 32-bit

Artem Bityutskiy (1):
      ACPI/processor_idle: Export acpi_processor_ffh_play_dead()

Balbir Singh (1):
      x86/kaslr: Reduce KASLR entropy on most x86 systems

Brendan Jackman (6):
      x86/cpu: Create helper function to parse the 'clearcpuid=' boot parameter
      x86/cpu: Add the 'setcpuid=' boot parameter
      x86/cpu: Enable modifying CPU bug flags with '{clear,set}puid='
      x86/cpu: Remove unnecessary macro indirection related to CPU feature names
      x86/cpu: Warn louder about the {set,clear}cpuid boot parameters
      x86/cpu: Log CPU flag cmdline hacks more verbosely

Brian Gerst (37):
      x86/build: Raise the minimum GCC version to 8.1
      x86/stackprotector: Remove stack protector test scripts
      x86/boot: Disable stack protector for early boot code
      x86/pvh: Use fixed_percpu_data for early boot GSBASE
      x86/relocs: Handle R_X86_64_REX_GOTPCRELX relocations
      x86/stackprotector/64: Convert to normal per-CPU variable
      x86/percpu/64: Use relative percpu offsets
      x86/percpu/64: Remove fixed_percpu_data
      x86/boot/64: Remove inverse relocations
      x86/percpu/64: Remove INIT_PER_CPU macros
      percpu: Remove PER_CPU_FIRST_SECTION
      percpu: Remove PERCPU_VADDR()
      percpu: Remove __per_cpu_load
      kallsyms: Remove KALLSYMS_ABSOLUTE_PERCPU
      x86/arch_prctl: Simplify sys_arch_prctl()
      x86/arch_prctl/64: Clean up ARCH_MAP_VDSO_32
      x86/bpf: Fix BPF percpu accesses
      x86/asm: Merge KSTK_ESP() implementations
      x86/smp/32: Remove safe_smp_processor_id()
      percpu: Introduce percpu hot section
      x86/percpu: Move pcpu_hot to percpu hot section
      x86/preempt: Move preempt count to percpu hot section
      x86/smp: Move cpu number to percpu hot section
      x86/retbleed: Move call depth to percpu hot section
      x86/softirq: Move softirq_pending to percpu hot section
      x86/irq: Move irq stacks to percpu hot section
      x86/percpu: Move top_of_stack to percpu hot section
      x86/percpu: Move current_task to percpu hot section
      x86/stackprotector: Move __stack_chk_guard to percpu hot section
      x86/smp: Move this_cpu_off to percpu hot section
      x86/xen: Move Xen upcall handler
      x86/syscall/32: Move 32-bit syscall dispatch code
      x86/syscall/64: Move 64-bit syscall dispatch code
      x86/syscall/x32: Move x32 syscall table
      x86/syscall: Move sys_ni_syscall()
      x86/syscall: Remove stray semicolons
      x86/syscall/32: Add comment to conditional

Dan Carpenter (1):
      x86/module: Remove unnecessary check in module_finalize()

Dr. David Alan Gilbert (1):
      x86/paravirt: Remove unused paravirt_disable_iospace()

H. Peter Anvin (Intel) (3):
      x86/cpufeatures: Rename X86_CMPXCHG64 to X86_CX8
      x86/cpufeatures: Add {REQUIRED,DISABLED} feature configs
      x86/cpufeatures: Generate the <asm/cpufeaturemasks.h> header based on build config

Ingo Molnar (17):
      Merge tag 'v6.14-rc3' into x86/core, to pick up fixes
      Merge tag 'v6.14-rc3' into x86/mm, to pick up fixes before merging new changes
      x86/alternatives: Clean up preprocessor conditional block comments
      Merge branch 'x86/mm' into x86/cpu, to avoid conflicts
      Merge tag 'v6.14-rc5' into x86/core, to pick up fixes
      Merge branch 'x86/urgent' into x86/cpu, to pick up dependent commits
      Merge branch 'x86/cpu' into x86/asm, to pick up dependent commits
      Merge branch 'x86/locking' into x86/asm, to simplify dependencies
      Merge branch 'x86/asm' into x86/core, to pick up dependent commits
      Merge branch 'x86/headers' into x86/core, to pick up dependent commits
      Merge tag 'v6.14-rc7' into x86/core, to pick up fixes
      x86/cpuid: Clean up <asm/cpuid/types.h>
      x86/cpuid: Clean up <asm/cpuid/api.h>
      x86/cpuid: Standardize on u32 in <asm/cpuid/api.h>
      x86/cpuid: Use u32 in instead of uint32_t in <asm/cpuid/api.h>
      x86/stackprotector/64: Only export __ref_stack_chk_guard on CONFIG_SMP
      zstd: Increase DYNAMIC_BMI2 GCC version cutoff from 4.8 to 11.0 to work around compiler segfault

Jann Horn (1):
      x86/mm: Fix flush_tlb_range() when used for zapping normal PMDs

Joel Granados (1):
      x86: Move sysctls into arch/x86

Josh Poimboeuf (4):
      x86/smp: Fix mwait_play_dead() and acpi_processor_ffh_play_dead() noreturn behavior
      KVM: VMX: Use named operands in inline asm
      x86/hyperv: Use named operands in inline asm
      x86/alternatives: Simplify alternative_call() interface

Kevin Brodsky (2):
      x86/mm: Remove unused __set_memory_prot()
      x86/mm: Reduce header dependencies in <asm/set_memory.h>

Kirill A. Shutemov (6):
      x86/mm/pat: restore large ROX pages after fragmentation
      mm/memremap: Pass down MEMREMAP_* flags to arch_memremap_wb()
      x86/mm: Make memremap(MEMREMAP_WB) map memory as encrypted by default
      x86/acpi: Replace manual page table initialization with kernel_ident_mapping_init()
      x86/mm/ident_map: Fix theoretical virtual address overflow to zero
      x86/runtime-const: Add the RUNTIME_CONST_PTR assembly macro

Lukas Bulwahn (1):
      xen: Kconfig: Drop reference to obsolete configs MCORE2 and MK8

Maciej Wieczor-Retman (4):
      x86: Compare physical instead of virtual PGD addresses
      selftests/lam: Move cpu_has_la57() to use cpuinfo flag
      selftests/lam: Skip test if LAM is disabled
      selftests/lam: Test get_user() LAM pointer handling

Mario Limonciello (3):
      x86/amd_node: Add SMN offsets to exclusive region access
      x86/amd_node: Add support for debugfs access to SMN registers
      x86/amd_node: Add a smn_read_register() helper

Matthew Wilcox (Oracle) (1):
      x86/mm: Clear _PAGE_DIRTY for kernel mappings when we clear _PAGE_RW

Max Grobecker (1):
      x86/cpu: Don't clear X86_FEATURE_LAHF_LM flag in init_amd_k8() on AMD when running in a virtual machine

Mike Rapoport (Microsoft) (9):
      x86/mm/pat: cpa-test: fix length for CPA_ARRAY test
      x86/mm/pat: drop duplicate variable in cpa_flush()
      execmem: don't remove ROX cache from the direct map
      execmem: add API for temporal remapping as RW and restoring ROX afterwards
      module: switch to execmem API for remapping as RW and restoring ROX
      Revert "x86/module: prepare module loading for ROX allocations of text"
      module: drop unused module_writable_address()
      x86: re-enable EXECMEM_ROX support
      module: don't annotate ROX memory as kmemleak_not_leak()

Nathan Chancellor (1):
      x86/build: Raise the minimum LLVM version to 15.0.0

Patryk Wlazlyn (4):
      x86/smp: Allow calling mwait_play_dead with an arbitrary hint
      ACPI/processor_idle: Add FFH state handling
      intel_idle: Provide the default enter_dead() handler
      x86/smp: Eliminate mwait_play_dead_cpuid_hint()

Pawan Gupta (11):
      x86/cpu: Prefix hexadecimal values with 0x in cpu_debug_show()
      cpufreq: intel_pstate: Avoid SMP calls to get cpu-type
      perf/x86/intel: Use cache cpu-type for hybrid PMU selection
      x86/cpu: Remove get_this_hybrid_cpu_*()
      x86/speculation: Simplify and make CALL_NOSPEC consistent
      x86/speculation: Add a conditional CS prefix to CALL_NOSPEC
      x86/cpu: Fix the description of X86_MATCH_VFM_STEPS()
      x86/cpu: Shorten CPU matching macro
      x86/cpu: Add cpu_type to struct x86_cpu_id
      x86/cpu: Update x86_match_cpu() to also use cpu-type
      x86/rfds: Exclude P-only parts from the RFDS affected list

Peter Zijlstra (22):
      Merge branch 'x86/mm'
      x86/ibt: Clean up is_endbr()
      x86,kcfi: Fix EXPORT_SYMBOL vs kCFI
      x86/cfi: Clean up linkage
      x86/boot: Mark start_secondary() with __noendbr
      x86/alternative: Simplify callthunk patching
      x86/traps: Cleanup and robustify decode_bug()
      x86/ibt: Clean up poison_endbr()
      x86/early_printk: Harden early_serial
      x86/ibt: Handle FineIBT in handle_cfi_failure()
      x86/cpu: Update Intel Family comments
      x86/cfi: Add 'cfi=warn' boot option
      x86/ibt: Add exact_endbr() helper
      x86/traps: Decode 0xEA instructions as #UD
      x86/traps: Allow custom fixups in handle_bug()
      x86/ibt: Optimize the FineIBT instruction sequence
      x86/traps: Decode LOCK Jcc.d8 as #UD
      x86/ibt: Add paranoid FineIBT mode
      x86/bhi: Add BHI stubs
      x86/ibt: Implement FineIBT-BHI mitigation
      x86/ibt: Optimize the fineibt-bhi arity 1 case
      x86/ibt: Make cfi_bhi a constant for FINEIBT_BHI=n

Philip Redkin (1):
      x86/mm: Check return value from memblock_phys_alloc_range()

Qasim Ijaz (1):
      x86/mm: Replace open-coded gap bounding with clamp()

Rik van Riel (13):
      x86/mm: Make MMU_GATHER_RCU_TABLE_FREE unconditional
      x86/mm: Remove pv_ops.mmu.tlb_remove_table call
      x86/mm: Consolidate full flush threshold decision
      x86/mm: Add INVLPGB feature and Kconfig entry
      x86/mm: Add INVLPGB support code
      x86/mm: Use INVLPGB for kernel TLB flushes
      x86/mm: Use broadcast TLB flushing in page reclaim
      x86/mm: Add global ASID allocation helper functions
      x86/mm: Handle global ASID context switch and TLB flush
      x86/mm: Add global ASID process exit helpers
      x86/mm: Enable broadcast TLB invalidation for multi-threaded processes
      x86/mm: Enable AMD translation cache extensions
      x86/mm: Only do broadcast flush from reclaim if pages were unmapped

Sohil Mehta (16):
      x86/cpufeatures: Warn about unmet CPU feature dependencies
      x86/apic: Fix 32-bit APIC initialization for extended Intel Families
      x86/cpu/intel: Fix the MOVSL alignment preference for extended Families
      x86/microcode: Update the Intel processor flag scan check
      x86/mtrr: Modify a x86_model check to an Intel VFM check
      x86/cpu/intel: Replace early Family 6 checks with VFM ones
      x86/cpu/intel: Replace Family 15 checks with VFM ones
      x86/cpu/intel: Replace Family 5 model checks with VFM ones
      x86/acpi/cstate: Improve Intel Family model checks
      x86/smpboot: Remove confusing quirk usage in INIT delay
      x86/smpboot: Fix INIT delay assignment for extended Intel Families
      x86/cpu/intel: Fix fast string initialization for extended Families
      x86/mm/pat: Replace Intel x86_model checks with VFM ones
      x86/cpu/intel: Limit the non-architectural constant_tsc model checks
      perf/x86/intel, x86/cpu: Simplify Intel PMU initialization
      perf/x86/intel, x86/cpu: Replace Pentium 4 model checks with VFM ones

Thomas Gleixner (3):
      x86/cpu: Get rid of the smp_store_cpu_info() indirection
      x86/cpu: Remove unused TLB strings
      x86/cacheinfo: Remove the P4 trace leftovers for real

Thomas Huth (2):
      x86/headers: Replace __ASSEMBLY__ with __ASSEMBLER__ in UAPI headers
      x86/headers: Replace __ASSEMBLY__ with __ASSEMBLER__ in non-UAPI headers

Thorsten Blum (2):
      x86/mtrr: Remove unnecessary strlen() in mtrr_write()
      x86/mtrr: Use str_enabled_disabled() helper in print_mtrr_state()

Tom Lendacky (1):
      x86/mm: Always set the ASID valid bit for the INVLPGB instruction

Tony Luck (1):
      x86/cpu: Fix #define name for Intel CPU model 0x5A

Uros Bizjak (16):
      x86/ioperm: Use atomic64_inc_return() in ksys_ioperm()
      x86/percpu: Unify __pcpu_op{1,2}_N() macros to __pcpu_op_N()
      x86/percpu: Construct __percpu_seg_override from __percpu_seg
      x86/percpu: Disable named address spaces for UBSAN_BOOL with KASAN for GCC < 14.2
      x86/irq/32: Use named operands in inline asm
      x86/irq/32: Add missing clobber to inline asm
      x86/irq/32: Use current_stack_pointer to avoid asm() in check_stack_overflow()
      x86/irq/32: Change some static functions to bool
      x86/percpu: Fix __per_cpu_hot_end marker
      x86/kexec: Merge x86_32 and x86_64 code using macros from <asm/asm.h>
      x86/hweight: Use named operands in inline asm()
      x86/hweight: Use ASM_CALL_CONSTRAINT in inline asm()
      x86/hweight: Use asm_inline() instead of asm()
      x86/asm: Use CLFLUSHOPT and CLWB mnemonics in <asm/special_insns.h>
      x86/asm: Use asm_inline() instead of asm() in clwb()
      x86/locking/atomic: Improve performance by using asm_inline() for atomic locking instructions

Vitaly Kuznetsov (1):
      x86/entry: Add __init to ia32_emulation_override_cmdline()

Waiman Long (1):
      x86/nmi: Add an emergency handler in nmi_desc & use it in nmi_shootdown_cpus()

Xin Li (Intel) (3):
      x86/ia32: Leave NULL selector values 0~3 unchanged
      x86/cpufeatures: Remove {disabled,required}-features.h
      x86/cpufeatures: Use AWK to generate {REQUIRED|DISABLED}_MASK_BIT_SET in <asm/cpufeaturemasks.h>

Yazen Ghannam (1):
      x86/amd_node, platform/x86/amd/hsmp: Have HSMP use SMN through AMD_NODE

liuye (1):
      selftests/x86/lam: Fix minor memory in do_uring()


 .../admin-guide/hw-vuln/reg-file-data-sampling.rst |   8 -
 Documentation/admin-guide/kdump/kdump.rst          |   4 -
 Documentation/admin-guide/kernel-parameters.txt    |  11 -
 Documentation/arch/x86/usb-legacy-support.rst      |  11 +-
 Makefile                                           |   3 +
 arch/arm/include/asm/io.h                          |   2 +-
 arch/arm/mm/ioremap.c                              |   2 +-
 arch/arm/mm/nommu.c                                |   2 +-
 arch/riscv/include/asm/io.h                        |   2 +-
 arch/um/kernel/um_arch.c                           |  11 +-
 arch/x86/Kconfig                                   | 202 +++----
 arch/x86/Kconfig.cpu                               | 105 +---
 arch/x86/Kconfig.cpufeatures                       | 201 +++++++
 arch/x86/Makefile                                  |  51 +-
 arch/x86/Makefile_32.cpu                           |   5 +-
 arch/x86/boot/boot.h                               |   4 +-
 arch/x86/boot/compressed/misc.c                    |  14 +-
 arch/x86/boot/cpucheck.c                           |   3 +-
 arch/x86/boot/cpuflags.c                           |   1 -
 arch/x86/boot/mkcpustr.c                           |   3 +-
 arch/x86/configs/xen.config                        |   2 -
 arch/x86/crypto/aesni-intel_asm.S                  |   2 +
 arch/x86/crypto/camellia-aesni-avx-asm_64.S        |   7 +-
 arch/x86/crypto/camellia-aesni-avx2-asm_64.S       |   1 +
 arch/x86/crypto/camellia-x86_64-asm_64.S           |   9 +-
 arch/x86/crypto/serpent-avx-x86_64-asm_64.S        |   7 +-
 arch/x86/crypto/twofish-x86_64-asm_64-3way.S       |   5 +-
 arch/x86/crypto/twofish-x86_64-asm_64.S            |   5 +-
 arch/x86/entry/Makefile                            |   8 +-
 arch/x86/entry/calling.h                           |   1 +
 arch/x86/entry/common.c                            | 524 -----------------
 arch/x86/entry/entry.S                             |   6 +-
 arch/x86/entry/entry_32.S                          |   4 +-
 arch/x86/entry/entry_64.S                          |  11 +-
 arch/x86/entry/entry_64_compat.S                   |   4 +-
 arch/x86/entry/entry_64_fred.S                     |   1 +
 arch/x86/entry/syscall_32.c                        | 332 ++++++++++-
 arch/x86/entry/syscall_64.c                        | 111 +++-
 arch/x86/entry/syscall_x32.c                       |  25 -
 arch/x86/entry/syscalls/syscall_32.tbl             |   2 +-
 arch/x86/entry/vdso/Makefile                       |   1 +
 arch/x86/entry/vdso/extable.h                      |   2 +-
 arch/x86/entry/vdso/vma.c                          |   3 +-
 arch/x86/events/core.c                             |   2 +-
 arch/x86/events/intel/core.c                       |  35 +-
 arch/x86/events/intel/p4.c                         |   7 +-
 arch/x86/events/intel/p6.c                         |  26 +-
 arch/x86/events/perf_event.h                       |  19 +-
 arch/x86/hyperv/mmu.c                              |   1 -
 arch/x86/include/asm/Kbuild                        |   1 +
 arch/x86/include/asm/alternative.h                 |  45 +-
 arch/x86/include/asm/amd_nb.h                      |   1 -
 arch/x86/include/asm/amd_node.h                    |  24 +
 arch/x86/include/asm/apic.h                        |   4 +-
 arch/x86/include/asm/arch_hweight.h                |  14 +-
 arch/x86/include/asm/asm-prototypes.h              |   4 +-
 arch/x86/include/asm/asm.h                         |  21 +-
 arch/x86/include/asm/atomic.h                      |  14 +-
 arch/x86/include/asm/atomic64_32.h                 |  98 ++--
 arch/x86/include/asm/atomic64_64.h                 |  14 +-
 arch/x86/include/asm/bitops.h                      |  14 +-
 arch/x86/include/asm/boot.h                        |   2 +-
 arch/x86/include/asm/bug.h                         |   8 +-
 arch/x86/include/asm/cfi.h                         |  26 +
 arch/x86/include/asm/cmpxchg.h                     |  24 +-
 arch/x86/include/asm/cmpxchg_32.h                  |   6 +-
 arch/x86/include/asm/cmpxchg_64.h                  |   4 +-
 arch/x86/include/asm/cpu.h                         |  15 -
 arch/x86/include/asm/cpu_device_id.h               | 130 ++---
 arch/x86/include/asm/cpufeature.h                  |  81 +--
 arch/x86/include/asm/cpufeatures.h                 |   9 +-
 arch/x86/include/asm/cpuid.h                       | 216 +------
 arch/x86/include/asm/cpuid/api.h                   | 210 +++++++
 arch/x86/include/asm/cpuid/types.h                 |  32 +
 arch/x86/include/asm/cpumask.h                     |   4 +-
 arch/x86/include/asm/current.h                     |  40 +-
 arch/x86/include/asm/desc.h                        |   1 -
 arch/x86/include/asm/desc_defs.h                   |   4 +-
 arch/x86/include/asm/disabled-features.h           | 161 -----
 arch/x86/include/asm/dwarf2.h                      |   2 +-
 arch/x86/include/asm/elf.h                         |   5 +-
 arch/x86/include/asm/fixmap.h                      |   4 +-
 arch/x86/include/asm/frame.h                       |  10 +-
 arch/x86/include/asm/fred.h                        |   4 +-
 arch/x86/include/asm/fsgsbase.h                    |   4 +-
 arch/x86/include/asm/ftrace.h                      |  24 +-
 arch/x86/include/asm/hardirq.h                     |   4 +-
 arch/x86/include/asm/hw_irq.h                      |   4 +-
 arch/x86/include/asm/ibt.h                         |  25 +-
 arch/x86/include/asm/idtentry.h                    |   6 +-
 arch/x86/include/asm/init.h                        |   4 +
 arch/x86/include/asm/inst.h                        |   2 +-
 arch/x86/include/asm/intel-family.h                |  50 +-
 arch/x86/include/asm/io.h                          |   3 +
 arch/x86/include/asm/irq_stack.h                   |  12 +-
 arch/x86/include/asm/irqflags.h                    |  10 +-
 arch/x86/include/asm/jump_label.h                  |   4 +-
 arch/x86/include/asm/kasan.h                       |   2 +-
 arch/x86/include/asm/kexec.h                       |  62 +-
 arch/x86/include/asm/linkage.h                     |  24 +-
 arch/x86/include/asm/mem_encrypt.h                 |   4 +-
 arch/x86/include/asm/mmu.h                         |  12 +
 arch/x86/include/asm/mmu_context.h                 |  10 +-
 arch/x86/include/asm/mshyperv.h                    |  18 +-
 arch/x86/include/asm/msr-index.h                   |   2 +
 arch/x86/include/asm/msr.h                         |   4 +-
 arch/x86/include/asm/nmi.h                         |   2 +
 arch/x86/include/asm/nops.h                        |   2 +-
 arch/x86/include/asm/nospec-branch.h               |  17 +-
 arch/x86/include/asm/orc_types.h                   |   4 +-
 arch/x86/include/asm/page.h                        |   4 +-
 arch/x86/include/asm/page_32.h                     |   4 +-
 arch/x86/include/asm/page_32_types.h               |   8 +-
 arch/x86/include/asm/page_64.h                     |   9 +-
 arch/x86/include/asm/page_64_types.h               |   2 +-
 arch/x86/include/asm/page_types.h                  |   4 +-
 arch/x86/include/asm/paravirt.h                    |  19 +-
 arch/x86/include/asm/paravirt_types.h              |  20 +-
 arch/x86/include/asm/percpu.h                      |  76 +--
 arch/x86/include/asm/pgalloc.h                     |   5 -
 arch/x86/include/asm/pgtable-2level_types.h        |   4 +-
 arch/x86/include/asm/pgtable-3level_types.h        |   4 +-
 arch/x86/include/asm/pgtable-invert.h              |   4 +-
 arch/x86/include/asm/pgtable.h                     |  12 +-
 arch/x86/include/asm/pgtable_32.h                  |   4 +-
 arch/x86/include/asm/pgtable_32_areas.h            |   2 +-
 arch/x86/include/asm/pgtable_64.h                  |   6 +-
 arch/x86/include/asm/pgtable_64_types.h            |   4 +-
 arch/x86/include/asm/pgtable_types.h               |  12 +-
 arch/x86/include/asm/preempt.h                     |  25 +-
 arch/x86/include/asm/processor.h                   |  66 +--
 arch/x86/include/asm/prom.h                        |   4 +-
 arch/x86/include/asm/proto.h                       |   3 +-
 arch/x86/include/asm/pti.h                         |   4 +-
 arch/x86/include/asm/ptrace.h                      |   4 +-
 arch/x86/include/asm/purgatory.h                   |   4 +-
 arch/x86/include/asm/pvclock-abi.h                 |   4 +-
 arch/x86/include/asm/realmode.h                    |   4 +-
 arch/x86/include/asm/required-features.h           | 105 ----
 arch/x86/include/asm/rmwcc.h                       |   2 +-
 arch/x86/include/asm/runtime-const.h               |  13 +
 arch/x86/include/asm/segment.h                     |   8 +-
 arch/x86/include/asm/set_memory.h                  |   2 -
 arch/x86/include/asm/setup.h                       |   7 +-
 arch/x86/include/asm/setup_data.h                  |   4 +-
 arch/x86/include/asm/shared/tdx.h                  |   4 +-
 arch/x86/include/asm/shstk.h                       |   4 +-
 arch/x86/include/asm/signal.h                      |   8 +-
 arch/x86/include/asm/smap.h                        |   6 +-
 arch/x86/include/asm/smp.h                         |  24 +-
 arch/x86/include/asm/special_insns.h               |  22 +-
 arch/x86/include/asm/sta2x11.h                     |  13 -
 arch/x86/include/asm/stackprotector.h              |  36 +-
 arch/x86/include/asm/string_64.h                   |   2 +
 arch/x86/include/asm/tdx.h                         |   4 +-
 arch/x86/include/asm/thread_info.h                 |  12 +-
 arch/x86/include/asm/tlb.h                         | 138 +++++
 arch/x86/include/asm/tlbbatch.h                    |   5 +
 arch/x86/include/asm/tlbflush.h                    |  72 ++-
 arch/x86/include/asm/traps.h                       |   2 -
 arch/x86/include/asm/unwind_hints.h                |   4 +-
 arch/x86/include/asm/vdso/getrandom.h              |   4 +-
 arch/x86/include/asm/vdso/gettimeofday.h           |   4 +-
 arch/x86/include/asm/vdso/processor.h              |   4 +-
 arch/x86/include/asm/vdso/vsyscall.h               |   4 +-
 arch/x86/include/asm/vermagic.h                    |   4 -
 arch/x86/include/asm/xen/interface.h               |  10 +-
 arch/x86/include/asm/xen/interface_32.h            |   4 +-
 arch/x86/include/asm/xen/interface_64.h            |   4 +-
 arch/x86/include/uapi/asm/bootparam.h              |   4 +-
 arch/x86/include/uapi/asm/e820.h                   |   4 +-
 arch/x86/include/uapi/asm/ldt.h                    |   4 +-
 arch/x86/include/uapi/asm/msr.h                    |   4 +-
 arch/x86/include/uapi/asm/ptrace-abi.h             |   6 +-
 arch/x86/include/uapi/asm/ptrace.h                 |   4 +-
 arch/x86/include/uapi/asm/setup_data.h             |   4 +-
 arch/x86/include/uapi/asm/signal.h                 |   8 +-
 arch/x86/kernel/Makefile                           |   2 +
 arch/x86/kernel/acpi/cstate.c                      |  19 +-
 arch/x86/kernel/acpi/madt_playdead.S               |   1 +
 arch/x86/kernel/acpi/madt_wakeup.c                 |  73 +--
 arch/x86/kernel/acpi/wakeup_64.S                   |   1 +
 arch/x86/kernel/alternative.c                      | 645 ++++++++++++++++-----
 arch/x86/kernel/amd_nb.c                           |   1 -
 arch/x86/kernel/amd_node.c                         | 149 +++++
 arch/x86/kernel/apic/Makefile                      |   3 -
 arch/x86/kernel/apic/apic.c                        |   7 +-
 arch/x86/kernel/apic/bigsmp_32.c                   | 105 ----
 arch/x86/kernel/apic/ipi.c                         |  30 -
 arch/x86/kernel/apic/local.h                       |  13 -
 arch/x86/kernel/apic/probe_32.c                    |  29 -
 arch/x86/kernel/asm-offsets.c                      |   5 -
 arch/x86/kernel/asm-offsets_64.c                   |   6 -
 arch/x86/kernel/callthunks.c                       |  13 -
 arch/x86/kernel/cfi.c                              |  26 +-
 arch/x86/kernel/cpu/amd.c                          |  30 +-
 arch/x86/kernel/cpu/cacheinfo.c                    |  31 +-
 arch/x86/kernel/cpu/common.c                       | 237 +++++---
 arch/x86/kernel/cpu/cpu.h                          |   8 -
 arch/x86/kernel/cpu/cpuid-deps.c                   |  35 ++
 arch/x86/kernel/cpu/debugfs.c                      |   4 +-
 arch/x86/kernel/cpu/hygon.c                        |  16 +-
 arch/x86/kernel/cpu/intel.c                        | 297 ++++------
 arch/x86/kernel/cpu/match.c                        |  30 +
 arch/x86/kernel/cpu/microcode/intel.c              |   2 +-
 arch/x86/kernel/cpu/mtrr/generic.c                 |  17 +-
 arch/x86/kernel/cpu/mtrr/if.c                      |   6 +-
 arch/x86/kernel/crash.c                            |   2 +-
 arch/x86/kernel/dumpstack_32.c                     |   4 +-
 arch/x86/kernel/dumpstack_64.c                     |   2 +-
 arch/x86/kernel/early_printk.c                     |  49 +-
 arch/x86/kernel/ftrace.c                           |  30 +-
 arch/x86/kernel/ftrace_64.S                        |   5 +
 arch/x86/kernel/head64.c                           |   2 +-
 arch/x86/kernel/head_64.S                          |  24 +-
 arch/x86/kernel/ioport.c                           |   2 +-
 arch/x86/kernel/irq.c                              |   5 +
 arch/x86/kernel/irq_32.c                           |  51 +-
 arch/x86/kernel/irq_64.c                           |   8 +-
 arch/x86/kernel/irqflags.S                         |   1 +
 arch/x86/kernel/kprobes/core.c                     |  11 +-
 arch/x86/kernel/kvm.c                              |   1 -
 arch/x86/kernel/module.c                           |  81 ++-
 arch/x86/kernel/nmi.c                              |  42 ++
 arch/x86/kernel/paravirt.c                         |  48 +-
 arch/x86/kernel/process.c                          |  10 +-
 arch/x86/kernel/process_32.c                       |  11 +-
 arch/x86/kernel/process_64.c                       |  31 +-
 arch/x86/kernel/reboot.c                           |  12 +-
 arch/x86/kernel/setup.c                            |  66 +++
 arch/x86/kernel/setup_percpu.c                     |  15 +-
 arch/x86/kernel/signal_32.c                        |  62 +-
 arch/x86/kernel/smpboot.c                          |  92 +--
 arch/x86/kernel/traps.c                            | 132 ++++-
 arch/x86/kernel/tsc_msr.c                          |   2 +-
 arch/x86/kernel/verify_cpu.S                       |   4 +
 arch/x86/kernel/vmlinux.lds.S                      |  43 +-
 arch/x86/kvm/vmx/vmx_ops.h                         |  18 +-
 arch/x86/lib/Makefile                              |   5 +-
 arch/x86/lib/bhi.S                                 | 147 +++++
 arch/x86/lib/clear_page_64.S                       |   9 +-
 arch/x86/lib/cmpxchg8b_emu.S                       |   2 +-
 arch/x86/lib/copy_page_64.S                        |   3 +-
 arch/x86/lib/copy_user_64.S                        |   3 +
 arch/x86/lib/copy_user_uncached_64.S               |   2 +
 arch/x86/lib/getuser.S                             |  16 +-
 arch/x86/lib/hweight.S                             |   3 +
 arch/x86/lib/memmove_64.S                          |   3 +-
 arch/x86/lib/memset_64.S                           |   3 +-
 arch/x86/lib/msr-reg.S                             |   3 +-
 arch/x86/lib/putuser.S                             |   9 +
 arch/x86/lib/retpoline.S                           |   3 +-
 arch/x86/math-emu/control_w.h                      |   2 +-
 arch/x86/math-emu/exception.h                      |   6 +-
 arch/x86/math-emu/fpu_emu.h                        |   6 +-
 arch/x86/math-emu/status_w.h                       |   6 +-
 arch/x86/mm/ident_map.c                            |  14 +-
 arch/x86/mm/init.c                                 |   9 +-
 arch/x86/mm/init_32.c                              |   9 +-
 arch/x86/mm/ioremap.c                              |   8 +
 arch/x86/mm/kaslr.c                                |  10 +-
 arch/x86/mm/mem_encrypt_boot.S                     |   1 +
 arch/x86/mm/mmap.c                                 |   9 +-
 arch/x86/mm/pat/cpa-test.c                         |   2 +-
 arch/x86/mm/pat/memtype.c                          |   6 +-
 arch/x86/mm/pat/set_memory.c                       | 243 +++++++-
 arch/x86/mm/pgtable.c                              |  54 +-
 arch/x86/mm/tlb.c                                  | 429 ++++++++++++--
 arch/x86/net/bpf_jit_comp.c                        |  34 +-
 arch/x86/pci/Makefile                              |   2 -
 arch/x86/pci/sta2x11-fixup.c                       | 233 --------
 arch/x86/platform/pvh/head.S                       |  14 +-
 arch/x86/power/hibernate_asm_64.S                  |   2 +
 arch/x86/realmode/rm/realmode.h                    |   4 +-
 arch/x86/realmode/rm/wakeup.h                      |   2 +-
 arch/x86/tools/cpufeaturemasks.awk                 |  88 +++
 arch/x86/tools/relocs.c                            | 147 +----
 arch/x86/xen/Kconfig                               |   2 +-
 arch/x86/xen/enlighten_pv.c                        |  69 +++
 arch/x86/xen/mmu_pv.c                              |   1 -
 arch/x86/xen/smp_pv.c                              |   2 +-
 arch/x86/xen/xen-asm.S                             |   5 +
 arch/x86/xen/xen-head.S                            |  12 +-
 drivers/acpi/processor_idle.c                      |   2 +
 drivers/cpufreq/intel_pstate.c                     |  16 +-
 drivers/idle/intel_idle.c                          |  14 +
 drivers/misc/mei/Kconfig                           |   2 +-
 drivers/pci/Kconfig                                |   6 +
 drivers/platform/x86/amd/hsmp/Kconfig              |   2 +-
 drivers/platform/x86/amd/hsmp/acpi.c               |   7 +-
 drivers/platform/x86/amd/hsmp/hsmp.c               |   1 -
 drivers/platform/x86/amd/hsmp/hsmp.h               |   3 -
 drivers/platform/x86/amd/hsmp/plat.c               |  36 +-
 drivers/powercap/intel_rapl_common.c               |   2 +-
 .../media/atomisp/include/linux/atomisp_platform.h |   4 +-
 drivers/thermal/intel/intel_tcc.c                  |   2 +-
 drivers/virt/coco/sev-guest/sev-guest.c            |   1 +
 include/acpi/processor.h                           |   5 +
 include/asm-generic/sections.h                     |   2 +-
 include/asm-generic/vmlinux.lds.h                  |  48 +-
 include/linux/acpi.h                               |   1 -
 include/linux/cfi.h                                |   2 +
 include/linux/compiler.h                           |  10 +
 include/linux/execmem.h                            |  31 +
 include/linux/mod_devicetable.h                    |   2 +
 include/linux/module.h                             |  16 -
 include/linux/moduleloader.h                       |   4 -
 include/linux/objtool.h                            |   4 +-
 include/linux/percpu-defs.h                        |  17 +-
 include/linux/preempt.h                            |   1 +
 include/linux/sizes.h                              |   8 +
 include/linux/vm_event_item.h                      |   2 +
 init/Kconfig                                       |   5 -
 kernel/bpf/verifier.c                              |   4 +-
 kernel/cfi.c                                       |   4 +-
 kernel/iomem.c                                     |   5 +-
 kernel/kallsyms.c                                  |  12 +-
 kernel/module/main.c                               |  81 +--
 kernel/module/strict_rwx.c                         |   9 +-
 kernel/sysctl.c                                    |  56 --
 kernel/trace/bpf_trace.c                           |  21 +-
 lib/atomic64_test.c                                |   2 +-
 lib/zstd/common/portability_macros.h               |   2 +-
 mm/execmem.c                                       |  39 +-
 mm/percpu.c                                        |   4 +-
 mm/vmstat.c                                        |   2 +
 scripts/gcc-x86_32-has-stack-protector.sh          |   8 -
 scripts/gcc-x86_64-has-stack-protector.sh          |   4 -
 scripts/gdb/linux/cpus.py                          |   2 +-
 scripts/kallsyms.c                                 |  72 +--
 scripts/link-vmlinux.sh                            |   4 -
 scripts/min-tool-version.sh                        |   4 +-
 tools/arch/x86/include/asm/asm.h                   |   8 +-
 tools/arch/x86/include/asm/cpufeatures.h           |   8 -
 tools/arch/x86/include/asm/disabled-features.h     | 161 -----
 tools/arch/x86/include/asm/msr-index.h             |   2 +
 tools/arch/x86/include/asm/nops.h                  |   2 +-
 tools/arch/x86/include/asm/orc_types.h             |   4 +-
 tools/arch/x86/include/asm/pvclock-abi.h           |   4 +-
 tools/arch/x86/include/asm/required-features.h     | 105 ----
 tools/objtool/arch/x86/decode.c                    |   1 +
 tools/objtool/check.c                              |  12 +-
 tools/objtool/noreturns.h                          |   2 +
 tools/perf/check-headers.sh                        |   2 -
 tools/power/x86/turbostat/turbostat.c              |   2 +-
 tools/testing/selftests/x86/lam.c                  | 151 ++++-
 346 files changed, 5002 insertions(+), 4671 deletions(-)
 create mode 100644 arch/x86/Kconfig.cpufeatures
 delete mode 100644 arch/x86/entry/common.c
 delete mode 100644 arch/x86/entry/syscall_x32.c
 create mode 100644 arch/x86/include/asm/cpuid/api.h
 create mode 100644 arch/x86/include/asm/cpuid/types.h
 delete mode 100644 arch/x86/include/asm/disabled-features.h
 delete mode 100644 arch/x86/include/asm/required-features.h
 delete mode 100644 arch/x86/include/asm/sta2x11.h
 delete mode 100644 arch/x86/kernel/apic/bigsmp_32.c
 create mode 100644 arch/x86/lib/bhi.S
 delete mode 100644 arch/x86/pci/sta2x11-fixup.c
 create mode 100755 arch/x86/tools/cpufeaturemasks.awk
 delete mode 100755 scripts/gcc-x86_32-has-stack-protector.sh
 delete mode 100755 scripts/gcc-x86_64-has-stack-protector.sh
 delete mode 100644 tools/arch/x86/include/asm/disabled-features.h
 delete mode 100644 tools/arch/x86/include/asm/required-features.h

