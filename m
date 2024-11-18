Return-Path: <linux-kernel+bounces-413513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9549D1A1F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 22:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B9AF1F220FE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 21:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104FC1E7C01;
	Mon, 18 Nov 2024 21:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kkV5qwUY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374881E5739;
	Mon, 18 Nov 2024 21:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731964053; cv=none; b=Sm3Wh9lRsKvc7Ym77vyAEPUVXzVovicY8SjfRTzPkXQlCufJZzMxRukL+8aoKGulPwl2BYR2xHkAFJmW9lygBUJQIhr2g5LzYGO5IZ3aMDClxAgnWSYvqL1Sa289kYKerFrOn30GWhH9dW1ax1pnsiXKsOZ+nE1e2jxnSkK1bS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731964053; c=relaxed/simple;
	bh=PNGqCUtLrSG7PQUFdFoSmmrygM0XN81SnyyLbCFTNDE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ipBczM9gow2SchRVgIfT1bGRu3cEvXnSldl19dPBb4d3ygH4kFxLJEPrae0LVfOHTa3l7a20ASKzLrm+TSp4vLB33k+7C4faxsfzMVZBA7XdtpFNfCjCMK2bClF2xBBuiBD0Jszrh8hHZywboFWX6bolC+FyccW78yJXOcpTD6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kkV5qwUY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B042C4CECC;
	Mon, 18 Nov 2024 21:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731964052;
	bh=PNGqCUtLrSG7PQUFdFoSmmrygM0XN81SnyyLbCFTNDE=;
	h=Date:From:To:Cc:Subject:From;
	b=kkV5qwUY5VMVVEAVqtI6DVP6jIB/WQlNZIP8s6hQSTQKycS28pO1HIq+FtQBK4zsN
	 zc2oGH0/50i2BlyGVZSx0fQv0G2c6LWFFNdqX9DQUDoyHLrqGzX6xDlCSeY89Gecwy
	 AmBnHkFFgZjWRQ3EhrLGCDdVKHmRCDhKjRF3PR6b8vFbdfs91z/g0uFE320e5ZxdFx
	 r1qFyOBo/oymXFapziak26yfNr3ITg9SGfkGicUSLRQfK0Fa58EoQr2wydK89bdxC4
	 A93u5d6ppcfhlXd/8XYvSyo91hxFCzhuwmohI/fMa/oCJnMmbNFb1+o07Nz9aaytgQ
	 +goqPy/pr8Krg==
Date: Mon, 18 Nov 2024 15:07:30 -0600
From: Rob Herring <robh@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Saravana Kannan <saravanak@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [GIT PULL] Devicetree updates for v6.13
Message-ID: <20241118210730.GA3331421-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull DT updates for 6.13. There's a few things out of the 
normal spots in arch/ and sound/ which are some updates to callers of DT 
functions.

Rob


The following changes since commit 6e0391e48cf9fb8b1b5e27c0cbbaf2e4639f2c33:

  of: Skip kunit tests when arm64+ACPI doesn't populate root node (2024-10-10 12:43:01 -0500)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-6.13

for you to fetch changes up to 28b513b5a683cf1e7125ba54ffe7ecb206ef4984:

  Merge branch 'dt/linus' into dt/next (2024-11-15 14:03:59 -0600)

----------------------------------------------------------------
Devicetree updates for v6.13:

Bindings:

- Enable dtc "interrupt_provider" warnings for binding examples.
  Fix the warnings in fsl,mu-msi and ti,sci-inta due to this.

- Convert zii,rave-sp-wdt, zii,rave-sp-pwrbutton,  and
  altr,fpga-passive-serial to DT schema format

- Add some documentation on the different forms of YAML text blocks
  which are a constant source of review comments

- Fix some schema errors in constraints for arrays

- Add compatibles for qcom,sar2130p-pdc and onnn,adt7462

DT core:

- Allow overlay kunit tests to run CONFIG_OF_OVERLAY=n

- Add some warnings on deprecated address handling

- Rework early_init_dt_scan() so the arch can pass in the phys address
  of the DTB as __pa() is not always valid to use. This fixes a warning
  for arm64 with kexec.

- Add and use some new DT graph iterators for iterating over ports and
  endpoints

- Rework reserved-memory handling to be sized dynamically for fixed
  regions

- Optimize of_modalias() to avoid a strlen() call

- Constify struct device_node and property pointers where ever possible

----------------------------------------------------------------
Abel Vesa (1):
      dt-bindings: cache: qcom,llcc: Fix X1E80100 reg entries

Ba Jing (1):
      of:of_numa: remove unused macro

Chanh Nguyen (1):
      dt-bindings: trivial-devices: add onnn,adt7462

Dmitry Baryshkov (1):
      dt-bindings: interrupt-controller: qcom,pdc: Add SAR2130P compatible

Fabio Estevam (1):
      dt-bindings: fpga: altr,fpga-passive-serial: Convert to yaml

Frank Li (2):
      dt-bindings: input: convert zii,rave-sp-pwrbutton.txt to yaml
      dt-bindings: watchdog: convert zii,rave-sp-wdt.txt to yaml format

Kuninori Morimoto (9):
      of: property: add of_graph_get_next_port()
      of: property: add of_graph_get_next_port_endpoint()
      of: property: use new of_graph functions
      ASoC: test-component: use new of_graph functions
      ASoC: audio-graph-card: use new of_graph functions
      ASoC: audio-graph-card2: use new of_graph functions
      gpu: drm: omapdrm: use new of_graph functions
      fbdev: omapfb: use new of_graph functions
      media: xilinx-tpg: use new of_graph functions

Oreoluwa Babatunde (2):
      of: reserved_mem: Restructure how the reserved memory regions are processed
      of: reserved_mem: Add code to dynamically allocate reserved_mem array

Rob Herring (Arm) (16):
      dt-bindings: interrupt-controller: ti,sci-inta: Add missing "#interrupt-cells" to example
      dt-bindings: interrupt-controller: fsl,mu-msi: Drop "interrupt-controller" property
      dt-bindings: Fix array property constraints
      dt-bindings: writing-schema: Add details on YAML text blocks
      logic_pio: Constify fwnode_handle
      PCI: Constify pci_register_io_range() fwnode_handle
      of: Constify struct device_node function arguments
      of: Constify struct property pointers
      of: Constify of_changeset_entry function arguments
      of: Constify safe_name() kobject arg
      of/address: Constify of_busses[] array and pointers
      dt-bindings: Enable dtc "interrupt_provider" warnings
      of/fdt: Don't use default address cell sizes for address translation
      of: WARN on deprecated #address-cells/#size-cells handling
      of/address: Rework bus matching to avoid warnings
      Merge branch 'dt/linus' into dt/next

Sergey Shtylyov (1):
      of: module: remove strlen() call in of_modalias()

Stephen Boyd (1):
      of: Allow overlay kunit tests to run CONFIG_OF_OVERLAY=n

Usama Arif (1):
      of/fdt: add dt_phys arg to early_init_dt_scan and early_init_dt_verify

 Documentation/devicetree/bindings/Makefile         |   1 -
 .../devicetree/bindings/cache/l2c2x0.yaml          |   5 +-
 .../devicetree/bindings/cache/qcom,llcc.yaml       |  36 +++-
 .../devicetree/bindings/dma/dma-common.yaml        |   7 +-
 .../devicetree/bindings/example-schema.yaml        |   1 +
 .../bindings/fpga/altera-passive-serial.txt        |  29 ---
 .../bindings/fpga/altr,fpga-passive-serial.yaml    |  74 +++++++
 .../bindings/input/zii,rave-sp-pwrbutton.txt       |  22 --
 .../bindings/input/zii,rave-sp-pwrbutton.yaml      |  36 ++++
 .../bindings/interrupt-controller/arm,gic-v3.yaml  |  12 +-
 .../bindings/interrupt-controller/fsl,mu-msi.yaml  |   4 -
 .../bindings/interrupt-controller/qcom,pdc.yaml    |   1 +
 .../bindings/interrupt-controller/ti,sci-inta.yaml |   1 +
 .../bindings/media/i2c/thine,thp7312.yaml          |   3 +-
 .../bindings/memory-controllers/exynos-srom.yaml   |   5 +-
 .../devicetree/bindings/pci/brcm,stb-pcie.yaml     |   5 +-
 .../devicetree/bindings/soc/qcom/qcom,smp2p.yaml   |   3 +-
 .../devicetree/bindings/trivial-devices.yaml       |   2 +
 .../bindings/watchdog/zii,rave-sp-wdt.txt          |  39 ----
 .../bindings/watchdog/zii,rave-sp-wdt.yaml         |  47 +++++
 .../devicetree/bindings/writing-schema.rst         |  30 +++
 arch/arc/kernel/devtree.c                          |   2 +-
 arch/arm/kernel/devtree.c                          |   2 +-
 arch/arm64/kernel/setup.c                          |   6 +-
 arch/csky/kernel/setup.c                           |   4 +-
 arch/loongarch/kernel/setup.c                      |   2 +-
 arch/microblaze/kernel/prom.c                      |   2 +-
 arch/mips/kernel/prom.c                            |   2 +-
 arch/mips/kernel/relocate.c                        |   2 +-
 arch/nios2/kernel/prom.c                           |   4 +-
 arch/openrisc/kernel/prom.c                        |   2 +-
 arch/powerpc/kernel/dt_cpu_ftrs.c                  |   2 +-
 arch/powerpc/kernel/prom.c                         |   2 +-
 arch/powerpc/platforms/pseries/plpks.c             |   2 +-
 arch/riscv/kernel/setup.c                          |   2 +-
 arch/sh/kernel/setup.c                             |   2 +-
 arch/um/kernel/dtb.c                               |   2 +-
 arch/x86/kernel/devicetree.c                       |   2 +-
 arch/xtensa/kernel/setup.c                         |   2 +-
 drivers/gpu/drm/omapdrm/dss/dpi.c                  |   3 +-
 drivers/gpu/drm/omapdrm/dss/sdi.c                  |   3 +-
 drivers/media/platform/xilinx/xilinx-tpg.c         |  14 +-
 drivers/of/.kunitconfig                            |   1 +
 drivers/of/Kconfig                                 |   2 +-
 drivers/of/address.c                               |  36 ++--
 drivers/of/base.c                                  |  48 +++--
 drivers/of/cpu.c                                   |   2 +-
 drivers/of/dynamic.c                               |   4 +-
 drivers/of/fdt.c                                   |  23 ++-
 drivers/of/fdt_address.c                           |   4 +-
 drivers/of/irq.c                                   |   4 +-
 drivers/of/kexec.c                                 |   2 +-
 drivers/of/kobj.c                                  |   8 +-
 drivers/of/module.c                                |   4 +-
 drivers/of/of_numa.c                               |   3 -
 drivers/of/of_private.h                            |  15 +-
 drivers/of/of_reserved_mem.c                       | 227 ++++++++++++++++-----
 drivers/of/overlay.c                               |  19 +-
 drivers/of/overlay_test.c                          |   2 +
 drivers/of/property.c                              | 109 ++++++++--
 drivers/of/resolver.c                              |  12 +-
 drivers/pci/pci.c                                  |   2 +-
 drivers/video/fbdev/omap2/omapfb/dss/dpi.c         |   3 +-
 drivers/video/fbdev/omap2/omapfb/dss/dss-of.c      |  66 ------
 drivers/video/fbdev/omap2/omapfb/dss/dss.c         |  20 +-
 drivers/video/fbdev/omap2/omapfb/dss/sdi.c         |   3 +-
 include/linux/logic_pio.h                          |   6 +-
 include/linux/of.h                                 |  28 +--
 include/linux/of_address.h                         |   6 +-
 include/linux/of_fdt.h                             |   5 +-
 include/linux/of_graph.h                           |  49 +++++
 include/linux/of_irq.h                             |   4 +-
 include/linux/pci.h                                |   4 +-
 include/video/omapfb_dss.h                         |   8 -
 lib/logic_pio.c                                    |   4 +-
 sound/soc/generic/audio-graph-card.c               |   2 +-
 sound/soc/generic/audio-graph-card2.c              | 104 +++++-----
 sound/soc/generic/test-component.c                 |   3 +-
 78 files changed, 786 insertions(+), 483 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/fpga/altera-passive-serial.txt
 create mode 100644 Documentation/devicetree/bindings/fpga/altr,fpga-passive-serial.yaml
 delete mode 100644 Documentation/devicetree/bindings/input/zii,rave-sp-pwrbutton.txt
 create mode 100644 Documentation/devicetree/bindings/input/zii,rave-sp-pwrbutton.yaml
 delete mode 100644 Documentation/devicetree/bindings/watchdog/zii,rave-sp-wdt.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/zii,rave-sp-wdt.yaml

