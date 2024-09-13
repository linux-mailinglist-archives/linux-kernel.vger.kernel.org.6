Return-Path: <linux-kernel+bounces-328572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6839785F2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 18:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AFA6282C44
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 16:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F4F768E7;
	Fri, 13 Sep 2024 16:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UaJHAJXb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6F42D052
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 16:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726245606; cv=none; b=qYceZXl5CVmTiHhhkuznNH4fuFG56TgihsW/Ht82wXRa5Y2ps7qjZoOiGNWHV0WovyyHk5XXFYwXRDhkFGh47PUT5CTJxNN2Rk+fC35HSwP0IElbMiyrn1ht0tUqOXMTymXylKv+aEsIOtu8KBNvD0b0H4blOCK4CocZH9h9Zcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726245606; c=relaxed/simple;
	bh=SmvYvzK+0EZmlz0OIAhyDIuIEXEnfTA7juf8NTzuzKo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=S9KhVCDR0qmxMTYPWFG75qK+wn+mY/7sjxmOTdEZZP0b9/NnZ+pmPuuHGgkh8Nn1Q5U8otTgysdpEYq9xtfR97CVx/AbaMYjEC8hF7/lk69G0FuM3CH74hxOngSUAlSNDoYaTAY0ng8r/W7jlyJ6y67BPD4c9j+ait/JTMBTxH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UaJHAJXb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0038CC4CEC0;
	Fri, 13 Sep 2024 16:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726245606;
	bh=SmvYvzK+0EZmlz0OIAhyDIuIEXEnfTA7juf8NTzuzKo=;
	h=Date:From:To:Cc:Subject:From;
	b=UaJHAJXb5ms8R/9DrKoXzs9mklFeaTsxLFBNPE4HocO133tFKmqrPtFJiH/oBuNoH
	 ZX/m8xhpCGptfN65MWaHupEQkOhISIAt3etx+k5IOTVybW9/aNGF0enepR5Un/q5Mx
	 WvbHFzPFyh3+0HPeeP1kg9GDZOVc2D+WY2ksfe1gucCi3+JFUp8frSLSd/IcZHfIdi
	 eCIHzr21T9Pe+an86Qzw/aOsC2hCIp4FQ6zWDCtvZgGj8VFKGq5K45UFSFnsYmn///
	 jsd+1PLQqCE1Byuw5V2Uq3D+ppWjsPa75oPCddNAINDImx/2MQ0jhbGrdX4H9qrbjd
	 DprpKt9/hJSoQ==
Date: Fri, 13 Sep 2024 17:40:01 +0100
From: Will Deacon <will@kernel.org>
To: torvalds@linux-foundation.org
Cc: catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: [GIT PULL] arm64 updates for 6.12
Message-ID: <20240913164001.GA24426@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Linus,

Like a bunch of folks, I'll be living off conference coffee and canapes
for the next week or so, so here's the arm64 pull request for 6.12
before the chaos descends and the malnutrition sets in.

There's the usual summary in the tag, but the highlights are support for
Arm's "Permission Overlay Extension" using memory protection keys,
support for running as a protected guest on Android as well as perf
support for a bunch of new interconnect PMUs.

There's a trivial conflict with the kvmarm tree which was resolved in
linux-next as per [1]. Any issues, just yell.

Please pull,

Will

[1] https://lore.kernel.org/r/20240905160856.14e95d14@canb.auug.org.au

--->8

The following changes since commit 7c626ce4bae1ac14f60076d00eafe71af30450ba:

  Linux 6.11-rc3 (2024-08-11 14:27:14 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-upstream

for you to fetch changes up to 75078ba2b38a38d94017bd334f71aaed205e30a4:

  Merge branch 'for-next/timers' into for-next/core (2024-09-12 13:44:03 +0100)

----------------------------------------------------------------
arm64 updates for 6.12

ACPI:
* Enable PMCG erratum workaround for HiSilicon HIP10 and 11 platforms.
* Ensure arm64-specific IORT header is covered by MAINTAINERS.

CPU Errata:
* Enable workaround for hardware access/dirty issue on Ampere-1A cores.

Memory management:
* Define PHYSMEM_END to fix a crash in the amdgpu driver.
* Avoid tripping over invalid kernel mappings on the kexec() path.
* Userspace support for the Permission Overlay Extension (POE) using
  protection keys.

Perf and PMUs:
* Add support for the "fixed instruction counter" extension in the CPU
  PMU architecture.
* Extend and fix the event encodings for Apple's M1 CPU PMU.
* Allow LSM hooks to decide on SPE permissions for physical profiling.
* Add support for the CMN S3 and NI-700 PMUs.

Confidential Computing:
* Add support for booting an arm64 kernel as a protected guest under
  Android's "Protected KVM" (pKVM) hypervisor.

Selftests:
* Fix vector length issues in the SVE/SME sigreturn tests
* Fix build warning in the ptrace tests.

Timers:
* Add support for PR_{G,S}ET_TSC so that 'rr' can deal with
  non-determinism arising from the architected counter.

Miscellaneous:
* Rework our IPI-based CPU stopping code to try NMIs if regular IPIs
  don't succeed.
* Minor fixes and cleanups.

----------------------------------------------------------------
Anastasia Belova (1):
      arm64: esr: Define ESR_ELx_EC_* constants as UL

Andre Przywara (1):
      kselftest/arm64: signal: fix/refactor SVE vector length enumeration

Andy Shevchenko (1):
      ACPI/IORT: Switch to use kmemdup_array()

Anshuman Khandual (2):
      arm64/mm: Drop PMD_SECT_VALID
      arm64/mm: Drop TCR_SMP_FLAGS

Barry Song (1):
      mm: arm64: document why pte is not advanced in contpte_ptep_set_access_flags()

D Scott Phillips (2):
      arm64: errata: Enable the AC03_CPU_38 workaround for ampere1a
      arm64: Expose the end of the linear map in PHYSMEM_END

Dan Carpenter (1):
      perf: arm-ni: Fix an NULL vs IS_ERR() bug

Dave Martin (2):
      arm64: signal: Fix some under-bracketed UAPI macros
      arm64: el2_setup.h: Rename some labels to be more diff-friendly

Dev Jain (1):
      kselftest/arm64: Fix build warnings for ptrace

Douglas Anderson (1):
      arm64: smp: smp_send_stop() and crash_smp_send_stop() should try non-NMI first

Fares Mehanna (1):
      arm64: trans_pgd: mark PTEs entries as valid to avoid dead kexec()

Hanjun Guo (1):
      ACPI: ARM64: add acpi_iort.h to MAINTAINERS

Huang Xiaojia (1):
      arm64: Constify struct kobj_type

Ilkka Koskinen (1):
      perf: arm_pmuv3: Use BR_RETIRED for HW branch event if enabled

James Clark (1):
      drivers/perf: arm_spe: Use perf_allow_kernel() for permissions

Jing Zhang (1):
      drivers/perf: Fix ali_drw_pmu driver interrupt status clearing

Joey Gouly (32):
      KVM: arm64: Make kvm_at() take an OP_AT_*
      arm64: disable trapping of POR_EL0 to EL2
      arm64: cpufeature: add Permission Overlay Extension cpucap
      arm64: context switch POR_EL0 register
      KVM: arm64: Save/restore POE registers
      KVM: arm64: use `at s1e1a` for POE
      KVM: arm64: Sanitise ID_AA64MMFR3_EL1
      KVM: selftests: get-reg-list: add Permission Overlay registers
      powerpc/mm: add ARCH_PKEY_BITS to Kconfig
      x86/mm: add ARCH_PKEY_BITS to Kconfig
      mm: use ARCH_PKEY_BITS to define VM_PKEY_BITN
      arm64: enable the Permission Overlay Extension for EL0
      arm64: re-order MTE VM_ flags
      arm64: add POIndex defines
      arm64: convert protection key into vm_flags and pgprot values
      arm64: mask out POIndex when modifying a PTE
      arm64: handle PKEY/POE faults
      arm64: add pte_access_permitted_no_overlay()
      arm64: implement PKEYS support
      arm64: add POE signal support
      arm64/ptrace: add support for FEAT_POE
      arm64: enable POE and PIE to coexist
      arm64: enable PKEY support for CPUs with S1POE
      arm64: add Permission Overlay Extension Kconfig
      kselftest/arm64: move get_header()
      selftests: mm: move fpregs printing
      selftests: mm: make protection_keys test work on arm64
      kselftest/arm64: add HWCAP test for FEAT_S1POE
      kselftest/arm64: parse POE_MAGIC in a signal frame
      kselftest/arm64: Add test case for POR_EL0 signal frame records
      arm64/mm: use lm_alias() with addresses passed to memblock_free()
      arm64: pkeys: remove redundant WARN

Krishna chaitanya chundru (4):
      perf/dwc_pcie: Fix registration issue in multi PCIe controller instances
      Documentation: dwc_pcie_pmu: Update bdf to sbdf
      perf/dwc_pcie: Always register for PCIe bus notifier
      perf/dwc_pcie: Add support for QCOM vendor devices

Marc Zyngier (1):
      firmware/smccc: Call arch-specific hook on discovering KVM services

Mark Brown (1):
      kselftest/arm64: Actually test SME vector length changes via sigreturn

Min-Hua Chen (1):
      arm64: hibernate: Fix warning for cast from restricted gfp_t

Peter Collingbourne (1):
      arm64: Implement prctl(PR_{G,S}ET_TSC)

Rob Herring (Arm) (8):
      perf: arm_pmu: Use of_property_present()
      perf: arm_pmu: Remove event index to counter remapping
      perf: arm_pmuv3: Prepare for more than 32 counters
      KVM: arm64: pmu: Use arm_pmuv3.h register accessors
      KVM: arm64: pmu: Use generated define for PMSELR_EL0.SEL access
      arm64: perf/kvm: Use a common PMU cycle counter define
      KVM: arm64: Refine PMU defines for number of counters
      perf: arm_pmuv3: Add support for Armv9.4 PMU instruction counter

Robin Murphy (13):
      perf/arm-cmn: Refactor node ID handling. Again.
      perf/arm-cmn: Fix CCLA register offset
      perf/arm-cmn: Ensure dtm_idx is big enough
      perf/arm-cmn: Improve build-time assertion
      perf/arm-cmn: Make cycle counts less surprising
      perf/arm-cmn: Refactor DTC PMU register access
      dt-bindings: perf: arm-cmn: Add CMN S3
      perf/arm-cmn: Support CMN S3
      perf/arm-cmn: Clean up unnecessary NUMA_NO_NODE check
      perf/arm-cmn: Improve format attr printing
      dt-bindings/perf: Add Arm NI-700 PMU
      perf: Add driver for Arm NI-700 interconnect PMU
      MAINTAINERS: List Arm interconnect PMUs as supported

Rong Qianfeng (1):
      arm64/mm: Delete __init region from memblock.reserved

Will Deacon (16):
      drivers/virt: pkvm: Add initial support for running as a protected guest
      arm64: mm: Add top-level dispatcher for internal mem_encrypt API
      drivers/virt: pkvm: Hook up mem_encrypt API using pKVM hypercalls
      arm64: mm: Add confidential computing hook to ioremap_prot()
      drivers/virt: pkvm: Intercept ioremap using pKVM MMIO_GUARD hypercall
      arm64: smccc: Reserve block of KVM "vendor" services for pKVM hypercalls
      Merge remote-tracking branch 'kvmarm/arm64-shared-6.12' into for-next/poe
      Merge branch 'for-next/acpi' into for-next/core
      Merge branch 'for-next/errata' into for-next/core
      Merge branch 'for-next/misc' into for-next/core
      Merge branch 'for-next/mm' into for-next/core
      Merge branch 'for-next/perf' into for-next/core
      Merge branch 'for-next/pkvm-guest' into for-next/core
      Merge branch 'for-next/poe' into for-next/core
      Merge branch 'for-next/selftests' into for-next/core
      Merge branch 'for-next/timers' into for-next/core

Yangyu Chen (1):
      drivers/perf: apple_m1: add known PMU events

Yicong Yang (4):
      ACPI/IORT: Add PMCG platform information for HiSilicon HIP10/11
      drivers/perf: hisi_pcie: Record hardware counts correctly
      drivers/perf: hisi_pcie: Fix TLP headers bandwidth counting
      drivers/perf: hisi_pcie: Export supported Root Ports [bdf_min, bdf_max]

Yue Haibing (2):
      arm64: mm: Remove unused declaration early_io_map()
      arm64/sve: Remove unused declaration read_smcr_features()

 Documentation/admin-guide/perf/arm-ni.rst          |  17 +
 Documentation/admin-guide/perf/dwc_pcie_pmu.rst    |  16 +-
 Documentation/admin-guide/perf/hisi-pcie-pmu.rst   |   4 +-
 Documentation/admin-guide/perf/index.rst           |   1 +
 Documentation/arch/arm64/elf_hwcaps.rst            |   2 +
 Documentation/arch/arm64/silicon-errata.rst        |   6 +-
 .../devicetree/bindings/perf/arm,cmn.yaml          |   1 +
 Documentation/devicetree/bindings/perf/arm,ni.yaml |  30 +
 Documentation/virt/kvm/arm/hypercalls.rst          |  98 +++
 MAINTAINERS                                        |  12 +
 arch/arm/include/asm/arm_pmuv3.h                   |  20 +
 arch/arm/include/asm/hypervisor.h                  |   2 +
 arch/arm64/Kconfig                                 |  26 +-
 arch/arm64/include/asm/arm_pmuv3.h                 |  53 +-
 arch/arm64/include/asm/cpufeature.h                |   6 +
 arch/arm64/include/asm/cputype.h                   |   2 +
 arch/arm64/include/asm/el2_setup.h                 |  25 +-
 arch/arm64/include/asm/esr.h                       |  88 +--
 arch/arm64/include/asm/fpsimd.h                    |   2 -
 arch/arm64/include/asm/hwcap.h                     |   1 +
 arch/arm64/include/asm/hypervisor.h                |  11 +
 arch/arm64/include/asm/io.h                        |   4 +
 arch/arm64/include/asm/kvm_asm.h                   |   3 +-
 arch/arm64/include/asm/kvm_host.h                  |  12 +-
 arch/arm64/include/asm/mem_encrypt.h               |  15 +
 arch/arm64/include/asm/memory.h                    |   2 +
 arch/arm64/include/asm/mman.h                      |  10 +-
 arch/arm64/include/asm/mmu.h                       |   2 +-
 arch/arm64/include/asm/mmu_context.h               |  46 +-
 arch/arm64/include/asm/pgtable-hwdef.h             |  11 +-
 arch/arm64/include/asm/pgtable-prot.h              |   8 +-
 arch/arm64/include/asm/pgtable.h                   |  34 +-
 arch/arm64/include/asm/pkeys.h                     | 106 +++
 arch/arm64/include/asm/por.h                       |  33 +
 arch/arm64/include/asm/processor.h                 |   6 +
 arch/arm64/include/asm/set_memory.h                |   1 +
 arch/arm64/include/asm/sysreg.h                    |   4 +-
 arch/arm64/include/asm/thread_info.h               |   2 +
 arch/arm64/include/asm/traps.h                     |   1 +
 arch/arm64/include/asm/vncr_mapping.h              |   1 +
 arch/arm64/include/uapi/asm/hwcap.h                |   1 +
 arch/arm64/include/uapi/asm/mman.h                 |   9 +
 arch/arm64/include/uapi/asm/sigcontext.h           |  13 +-
 arch/arm64/kernel/cpu_errata.c                     |  10 +-
 arch/arm64/kernel/cpufeature.c                     |  23 +
 arch/arm64/kernel/cpuinfo.c                        |   3 +-
 arch/arm64/kernel/hibernate.c                      |   2 +-
 arch/arm64/kernel/process.c                        |  97 ++-
 arch/arm64/kernel/ptrace.c                         |  46 ++
 arch/arm64/kernel/signal.c                         |  62 ++
 arch/arm64/kernel/smp.c                            | 164 +++--
 arch/arm64/kernel/traps.c                          |  26 +-
 arch/arm64/kvm/hyp/include/hyp/fault.h             |   5 +-
 arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h         |  27 +
 arch/arm64/kvm/pmu-emul.c                          |  14 +-
 arch/arm64/kvm/pmu.c                               |  87 +--
 arch/arm64/kvm/sys_regs.c                          |  36 +-
 arch/arm64/mm/Makefile                             |   2 +-
 arch/arm64/mm/contpte.c                            |   6 +
 arch/arm64/mm/fault.c                              |  55 +-
 arch/arm64/mm/init.c                               |  12 +-
 arch/arm64/mm/ioremap.c                            |  23 +-
 arch/arm64/mm/mem_encrypt.c                        |  50 ++
 arch/arm64/mm/mmap.c                               |  11 +
 arch/arm64/mm/mmu.c                                |  45 ++
 arch/arm64/mm/proc.S                               |   4 +-
 arch/arm64/mm/trans_pgd.c                          |   6 +-
 arch/arm64/tools/cpucaps                           |   1 +
 arch/arm64/tools/sysreg                            |  30 +
 arch/powerpc/Kconfig                               |   4 +
 arch/x86/Kconfig                                   |   4 +
 drivers/acpi/arm64/iort.c                          |   9 +-
 drivers/firmware/smccc/kvm_guest.c                 |   2 +
 drivers/perf/Kconfig                               |   7 +
 drivers/perf/Makefile                              |   1 +
 drivers/perf/alibaba_uncore_drw_pmu.c              |   2 +-
 drivers/perf/apple_m1_cpu_pmu.c                    | 182 +++--
 drivers/perf/arm-cmn.c                             | 318 +++++----
 drivers/perf/arm-ni.c                              | 781 +++++++++++++++++++++
 drivers/perf/arm_pmu.c                             |  11 +-
 drivers/perf/arm_pmu_platform.c                    |   2 +-
 drivers/perf/arm_pmuv3.c                           | 148 ++--
 drivers/perf/arm_spe_pmu.c                         |   9 +-
 drivers/perf/arm_v6_pmu.c                          |   6 +-
 drivers/perf/arm_v7_pmu.c                          |  77 +-
 drivers/perf/arm_xscale_pmu.c                      |  12 +-
 drivers/perf/dwc_pcie_pmu.c                        |  22 +-
 drivers/perf/hisilicon/hisi_pcie_pmu.c             |  34 +-
 drivers/virt/coco/Kconfig                          |   2 +
 drivers/virt/coco/Makefile                         |   1 +
 drivers/virt/coco/pkvm-guest/Kconfig               |  10 +
 drivers/virt/coco/pkvm-guest/Makefile              |   2 +
 drivers/virt/coco/pkvm-guest/arm-pkvm-guest.c      | 127 ++++
 fs/proc/task_mmu.c                                 |   2 +
 include/kvm/arm_pmu.h                              |   8 +-
 include/linux/arm-smccc.h                          |  88 +++
 include/linux/mm.h                                 |  20 +-
 include/linux/perf/arm_pmu.h                       |  10 +-
 include/linux/perf/arm_pmuv3.h                     |   9 +-
 include/linux/perf_event.h                         |   8 +-
 include/uapi/linux/elf.h                           |   1 +
 kernel/events/core.c                               |   9 +
 tools/testing/selftests/arm64/abi/hwcap.c          |  14 +
 tools/testing/selftests/arm64/abi/ptrace.c         |   4 +-
 tools/testing/selftests/arm64/signal/.gitignore    |   1 +
 tools/testing/selftests/arm64/signal/Makefile      |   2 +-
 tools/testing/selftests/arm64/signal/sve_helpers.c |  56 ++
 tools/testing/selftests/arm64/signal/sve_helpers.h |  21 +
 .../testcases/fake_sigreturn_sme_change_vl.c       |  46 +-
 .../testcases/fake_sigreturn_sve_change_vl.c       |  30 +-
 .../selftests/arm64/signal/testcases/poe_siginfo.c |  86 +++
 .../selftests/arm64/signal/testcases/ssve_regs.c   |  36 +-
 .../arm64/signal/testcases/ssve_za_regs.c          |  36 +-
 .../selftests/arm64/signal/testcases/sve_regs.c    |  32 +-
 .../selftests/arm64/signal/testcases/testcases.c   |  27 +-
 .../selftests/arm64/signal/testcases/testcases.h   |  28 +-
 .../selftests/arm64/signal/testcases/za_no_regs.c  |  32 +-
 .../selftests/arm64/signal/testcases/za_regs.c     |  36 +-
 tools/testing/selftests/kvm/aarch64/get-reg-list.c |  14 +
 tools/testing/selftests/mm/Makefile                |   2 +-
 tools/testing/selftests/mm/pkey-arm64.h            | 139 ++++
 tools/testing/selftests/mm/pkey-helpers.h          |   8 +
 tools/testing/selftests/mm/pkey-powerpc.h          |   3 +
 tools/testing/selftests/mm/pkey-x86.h              |   4 +
 tools/testing/selftests/mm/protection_keys.c       | 109 ++-
 125 files changed, 3395 insertions(+), 893 deletions(-)
 create mode 100644 Documentation/admin-guide/perf/arm-ni.rst
 create mode 100644 Documentation/devicetree/bindings/perf/arm,ni.yaml
 create mode 100644 arch/arm64/include/asm/mem_encrypt.h
 create mode 100644 arch/arm64/include/asm/pkeys.h
 create mode 100644 arch/arm64/include/asm/por.h
 create mode 100644 arch/arm64/mm/mem_encrypt.c
 create mode 100644 drivers/perf/arm-ni.c
 create mode 100644 drivers/virt/coco/pkvm-guest/Kconfig
 create mode 100644 drivers/virt/coco/pkvm-guest/Makefile
 create mode 100644 drivers/virt/coco/pkvm-guest/arm-pkvm-guest.c
 create mode 100644 tools/testing/selftests/arm64/signal/sve_helpers.c
 create mode 100644 tools/testing/selftests/arm64/signal/sve_helpers.h
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/poe_siginfo.c
 create mode 100644 tools/testing/selftests/mm/pkey-arm64.h

