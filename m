Return-Path: <linux-kernel+bounces-330469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A3C979EEE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 12:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF4921C2300D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 10:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A7B14B97D;
	Mon, 16 Sep 2024 10:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="JGUwL6xG"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F8414AD25
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 10:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726481277; cv=none; b=UZIo+6zbj+7mLtK7yo22nNqZdYsyepnfl0wrbJbjvNVWPI7+nXII5UF7ysFj6WGo55x6zsFXTzTHqReGFUgrsV3IwFKZ7ZXp99uBfvk7gjsxoFUlprrxnQs3bRzw/b9sW6qjAKHkThFQIsoXPYiS4jqzzjEsCYDy8gd2Vn+MSaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726481277; c=relaxed/simple;
	bh=XUufz/EGTz/ak13opRJLjwcPvJPBFSb4L67dqYi2UHs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ELqycLndxMpfzS8ph0YbXhShX3GIAAEojhGZ6dN7egrl4hRmJNHxb8l8fAdhA7k8Svasvj+cfI0OBt6f82IQKXrPsywzlFtxwzR9cF33bfq2cljg9NeRnZU9LYqomnU1kGTJUAOBblWP6k/4JhC5rK97Wx7IlNGxd0U7jI+vhDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=JGUwL6xG; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p549211fd.dip0.t-ipconnect.de [84.146.17.253])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 2B3AD2A4E87;
	Mon, 16 Sep 2024 12:07:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1726481268;
	bh=XUufz/EGTz/ak13opRJLjwcPvJPBFSb4L67dqYi2UHs=;
	h=Date:From:To:Cc:Subject:From;
	b=JGUwL6xG7Z7Em8ZEFiZHoOcUeNBTY7MNX4pPensoFrD6W1u2nosEdxTztwFnsuqx1
	 8VNElXqL5+chLr4PasEW3MLBoaxoQtpF0sfXTI83exsq0oKBooPK2lqVj930BNX5AS
	 KuX8xGczeS3a5D5Q9svQrJYVmbFZthbEU4g3kaecji4KucAYLU20jf/w6HYFwxEseJ
	 2ZxOiHV2pPUrLPy+A4QUAAwfEXtPBcGGaTIo/NI8xBlLX6ptBmbPc7QYamWGmHD1wv
	 iNW8K2Z8FFelWHzxDIDqUZbWIMhxZn1uepf+UZ/1eeACz0BbAI3FKOjdWP3kd3WeAF
	 KplCWO+bhKI+g==
Date: Mon, 16 Sep 2024 12:07:47 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: [git pull] IOMMU Updates for Linux v6.12
Message-ID: <ZugDc8ryLmadGXyp@8bytes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit da3ea35007d0af457a0afc87e84fddaebc4e0b63:

  Linux 6.11-rc7 (2024-09-08 14:50:28 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-updates-v6.12

for you to fetch changes up to 97162f6093d263aa1c2c7e883912f922ea633512:

  Merge branches 'fixes', 'arm/smmu', 'intel/vt-d', 'amd/amd-vi' and 'core' into next (2024-09-13 12:53:05 +0200)

----------------------------------------------------------------
IOMMU Updates for Linux v6.12

Including:

	- Core changes:
	  - Allow ATS on VF when parent device is identity mapped.
	  - Optimize unmap path on ARM io-pagetable implementation.
	  - Use of_property_present().

	- ARM-SMMU changes:
	  - SMMUv2:
	    - Devicetree binding updates for Qualcomm MMU-500 implementations.
	    - Extend workarounds for broken Qualcomm hypervisor to avoid
	      touching features that are not available (e.g. 16KiB page
	      support, reserved context banks).
	  - SMMUv3:
	    - Support for NVIDIA's custom virtual command queue hardware.
	    - Fix Stage-2 stall configuration and extend tests to cover this
	      area.
	    - A bunch of driver cleanups, including simplification of the
	      master rbtree code.
	  - Plus minor cleanups and fixes across both drivers.

	- Intel VT-d changes:
	  - Retire si_domain and convert to use static identity domain.
	  - Batched IOTLB/dev-IOTLB invalidation.
	  - Small code refactoring and cleanups.

	- AMD-Vi changes:
	  - Cleanup and refactoring of io-pagetable code.
	  - Add parameter to limit the used io-pagesizes.
	  - Other cleanups and fixes.

----------------------------------------------------------------
Ashish Mhetre (1):
      iommu/io-pgtable-arm: Optimise non-coherent unmap

Dan Carpenter (2):
      iommu/arm-smmu-v3: Fix a NULL vs IS_ERR() check
      iommu/tegra241-cmdqv: Fix ioremap() error handling in probe()

Dmitry Baryshkov (1):
      iommu/arm-smmu-qcom: apply num_context_bank fixes for SDM630 / SDM660

Eliav Bar-ilan (1):
      iommu/amd: Fix argument order in amd_iommu_dev_flush_pasid_all()

Jason Gunthorpe (26):
      iommu: Allow ATS to work on VFs when the PF uses IDENTITY
      iommu/arm-smmu-v3: Add struct arm_smmu_impl_ops
      iommu/amd: Move allocation of the top table into v1_alloc_pgtable
      iommu/amd: Allocate the page table root using GFP_KERNEL
      iommu/amd: Set the pgsize_bitmap correctly
      iommu/amd: Remove amd_iommu_domain_update() from page table freeing
      iommu/amd: Remove the amd_iommu_domain_set_pt_root() and related
      iommu/amd: Rename struct amd_io_pgtable iopt to pgtbl
      iommu/amd: Remove amd_io_pgtable::pgtbl_cfg
      iommu/amd: Store the nid in io_pgtable_cfg instead of the domain
      iommu/amd: Narrow the use of struct protection_domain to invalidation
      iommu/amd: Remove conditions from domain free paths
      iommu/amd: Fix typo of , instead of ;
      iommu/amd: Remove the confusing dummy iommu_flush_ops tlb ops
      iommu/amd: Correct the reported page sizes from the V1 table
      iommu/amd: Do not set the D bit on AMD v2 table entries
      iommu/arm-smmu-v3: Use the new rb tree helpers
      iommu/arm-smmu-v3: Add arm_smmu_strtab_l1/2_idx()
      iommu/arm-smmu-v3: Add types for each level of the 2 level stream table
      iommu/arm-smmu-v3: Reorganize struct arm_smmu_strtab_cfg
      iommu/arm-smmu-v3: Remove strtab_base/cfg
      iommu/arm-smmu-v3: Do not use devm for the cd table allocations
      iommu/arm-smmu-v3: Shrink the cdtab l1_desc array
      iommu/arm-smmu-v3: Add types for each level of the CD table
      iommu/arm-smmu-v3: Reorganize struct arm_smmu_ctx_desc_cfg
      iommu/amd: Test for PAGING domains before freeing a domain

Joerg Roedel (2):
      iommu/amd: Add kernel parameters to limit V1 page-sizes
      Merge branches 'fixes', 'arm/smmu', 'intel/vt-d', 'amd/amd-vi' and 'core' into next

Konrad Dybcio (1):
      iommu/arm-smmu-qcom: Work around SDM845 Adreno SMMU w/ 16K pages

Lu Baolu (10):
      iommu/vt-d: Require DMA domain if hardware not support passthrough
      iommu/vt-d: Remove identity mappings from si_domain
      iommu/vt-d: Always reserve a domain ID for identity setup
      iommu/vt-d: Remove has_iotlb_device flag
      iommu/vt-d: Factor out helpers from domain_context_mapping_one()
      iommu/vt-d: Add support for static identity domain
      iommu/vt-d: Cleanup si_domain
      iommu/vt-d: Move PCI PASID enablement to probe path
      iommu/vt-d: Unconditionally flush device TLB for pasid table updates
      iommu/vt-d: Add qi_batch for dmar_domain

Marc Gonzalez (1):
      iommu/arm-smmu-qcom: hide last LPASS SMMU context bank from linux

Mostafa Saleh (2):
      iommu/arm-smmu-v3: Match Stall behaviour for S2
      iommu/arm-smmu-v3-test: Test masters with stall enabled

Nate Watterson (1):
      iommu/arm-smmu-v3: Add in-kernel support for NVIDIA Tegra241 (Grace) CMDQV

Nicolin Chen (11):
      iommu/arm-smmu-v3: Issue a batch of commands to the same cmdq
      iommu/arm-smmu-v3: Pass in cmdq pointer to arm_smmu_cmdq_build_sync_cmd
      iommu/arm-smmu-v3: Pass in cmdq pointer to arm_smmu_cmdq_init
      iommu/arm-smmu-v3: Make symbols public for CONFIG_TEGRA241_CMDQV
      iommu/arm-smmu-v3: Add ARM_SMMU_OPT_TEGRA241_CMDQV
      iommu/arm-smmu-v3: Add acpi_smmu_iort_probe_model for impl
      iommu/arm-smmu-v3: Start a new batch if new command is not supported
      iommu/tegra241-cmdqv: Limit CMDs for VCMDQs of a guest owned VINTF
      iommu/tegra241-cmdqv: Fix -Wformat-truncation warnings in lvcmdq_error_header
      iommu/tegra241-cmdqv: Drop static at local variable
      iommu/tegra241-cmdqv: Do not allocate vcmdq until dma_set_mask_and_coherent

Nikunj Kela (1):
      dt-bindings: arm-smmu: document the support on SA8255p

Rob Clark (1):
      iommu/arm-smmu: Un-demote unhandled-fault msg

Rob Herring (Arm) (1):
      iommu: Use of_property_present()

Sanjay K Kumar (1):
      iommu/vt-d: Fix potential lockup if qi_submit_sync called with 0 count

Suravee Suthikulpanit (1):
      iommu/amd: Update PASID, GATS, GLX, SNPAVICSUP feature related macros

Tina Zhang (3):
      iommu/vt-d: Factor out invalidation descriptor composition
      iommu/vt-d: Refactor IOTLB and Dev-IOTLB flush for batching
      iommu/vt-d: Introduce batched cache invalidation

Vasant Hegde (9):
      iommu/amd: Add blocked domain support
      iommu/amd: Update event log pointer as soon as processing is complete
      iommu/amd: Make amd_iommu_is_attach_deferred() static
      iommu/amd: Remove unused DTE_GCR3_INDEX_* macros
      iommu/amd: Handle error path in amd_iommu_probe_device()
      iommu/amd: Make amd_iommu_dev_flush_pasid_all() static
      iommu/amd: Make amd_iommu_domain_flush_complete() static
      iommu/amd: Rework amd_iommu_update_and_flush_device_table()
      iommu/amd: Make amd_iommu_dev_update_dte() static

Will Deacon (1):
      Merge branch 'for-joerg/arm-smmu/bindings' into for-joerg/arm-smmu/updates

Zhang Zekun (1):
      iommu/arm-smmu-v3: Remove the unused empty definition

Zhenhua Huang (1):
      dt-bindings: arm-smmu: Add compatible for QCS8300 SoC

 Documentation/admin-guide/kernel-parameters.txt    |  17 +-
 .../devicetree/bindings/iommu/arm,smmu.yaml        |   5 +
 MAINTAINERS                                        |   1 +
 drivers/iommu/Kconfig                              |  11 +
 drivers/iommu/amd/amd_iommu.h                      |  26 +-
 drivers/iommu/amd/amd_iommu_types.h                |  35 +-
 drivers/iommu/amd/init.c                           |  16 +-
 drivers/iommu/amd/io_pgtable.c                     | 105 +--
 drivers/iommu/amd/io_pgtable_v2.c                  |  56 +-
 drivers/iommu/amd/iommu.c                          | 210 +++--
 drivers/iommu/amd/pasid.c                          |   2 +-
 drivers/iommu/arm/arm-smmu-v3/Makefile             |   1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c   |  83 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        | 578 +++++++------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h        | 135 ++-
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c     | 909 +++++++++++++++++++++
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c         |  28 +
 drivers/iommu/arm/arm-smmu/arm-smmu.c              |   2 +-
 drivers/iommu/fsl_pamu_domain.c                    |   4 +-
 drivers/iommu/intel/cache.c                        | 239 ++++--
 drivers/iommu/intel/dmar.c                         | 109 +--
 drivers/iommu/intel/iommu.c                        | 504 +++++-------
 drivers/iommu/intel/iommu.h                        | 128 ++-
 drivers/iommu/intel/nested.c                       |   3 +-
 drivers/iommu/intel/pasid.c                        |  12 +-
 drivers/iommu/intel/svm.c                          |   7 +-
 drivers/iommu/io-pgtable-arm.c                     |  31 +-
 drivers/iommu/of_iommu.c                           |   2 +-
 drivers/pci/ats.c                                  |  33 +
 include/linux/io-pgtable.h                         |   4 +
 include/linux/pci-ats.h                            |   3 +
 31 files changed, 2259 insertions(+), 1040 deletions(-)
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c

Please pull.

Thanks,

	Joerg

