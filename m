Return-Path: <linux-kernel+bounces-254491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA249333CC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 23:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 945031F22A5E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 21:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2080913B5A0;
	Tue, 16 Jul 2024 21:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t4S6JUh0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62691DFF0;
	Tue, 16 Jul 2024 21:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721166310; cv=none; b=MG6ggHAbKpbT4Fb1mgo18Icaeva5NsGFS5JTDjgdGgBtrtWFjVISitoA/09dNTUSTs+Szj4o2Ar5HAJCmEsnhJ3PiccNXUlHs6rOqsayLRqmcPd5Ks/EB8OD8x7PM6B/giqjEHDwbaMABzI6b/lIJgu5/dPqC5plOpgBO/qEFkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721166310; c=relaxed/simple;
	bh=memjuKuVCHvr+Ly26PHUuKBGTRemTOpxIXrue2pWJ7A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=N+ItuvpskQfC+gx9fbrDGoW1q8ghq2BM5sqO6fiHffWD9qc8FzRM+J8/Qa8PU8qnTJgDXgQaqBayWofLNhitYxA0q1YJ1yAQ0l0YPR3CcEPG7VXk3QqrsJF6gtOQ19KuncGjYd6iidS6sgxVoU3AezgXXKz1TvaYrk6dvOjyl40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t4S6JUh0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F746C116B1;
	Tue, 16 Jul 2024 21:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721166310;
	bh=memjuKuVCHvr+Ly26PHUuKBGTRemTOpxIXrue2pWJ7A=;
	h=Date:From:To:Cc:Subject:From;
	b=t4S6JUh01xBKgTc0m18QKIRWrgfTOQm7PrvnOcWtJ4/FX+xHTEMoIgCHLKjT0qTVu
	 ez3fSYjlw8lnYoZgJ2RZ8otgsQDDNMHThu/jwINMdpmeV+cArILV3PUvHXlMP7gzx2
	 80ZPMtGVpUJA6mnUR/yZcwxaWFbI24+W9YU5X8UDNmxJlnOEtJ8ZKmzx1YKqbs/wvJ
	 UQLtv6uaNTpXgcsYna+NS7kJBgZ4b8CejbR0oSRiSixYqiejDMiRr+NClx2pzei/1J
	 5MdNw6jcU/PgLmEyyU72Yhbr0aEY8IEFTsb7+F9YO8rtHzxRIMvYG4nLNI6z/wt2NS
	 wSMPmxAUbi69A==
Date: Tue, 16 Jul 2024 15:45:08 -0600
From: Rob Herring <robh@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Saravana Kannan <saravanak@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [GIT PULL] Devicetree updates for v6.11
Message-ID: <20240716214508.GA436704-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull DT updates for 6.11. There's one conflict with the kbuild 
tree. The correct resolution is in linux-next.

Rob


The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-6.11

for you to fetch changes up to 76be2f9823b10c07daf814cb6c732eb1456a0b9e:

  dt-bindings: timer: sprd-timer: convert to YAML (2024-07-15 05:26:07 -0600)

----------------------------------------------------------------
Devicetree updates for v6.11:

DT Bindings:
- Convert and add a bunch of IBM FSI related bindings

- Add a new schema listing legacy compatibles which will (probably)
  never be documented. This will silence various checks warning about
  them.

- Add bindings for Sierra Wireless mangOH Green SPI IoT interface, new
  Arm 2024 Cortex and Neoverse CPUs, QCom sc8180x PDC, QCom SDX75 GPI
  DMA, imx8mp/imx8qxp fsl,irqsteer, and Renesas RZ/G2UL CRU and CSI-2
  blocks

- Convert Spreadtrum sprd-timer, FSL cpm_qe, FSL fsl,ls-scfg-msi, FSL
  q(b)man-*, FSL qoriq-mc, and img,pdc-wdt bindings to DT schema

- Drop obsolete stericsson,abx500.txt

DT core:
- Update dtc to upstream version v1.7.0-93-g1df7b047fe43

- Add support to run DT validation on DTs with applied overlays

- Add helper for creating boolean properties in dynamic nodes and use
  that for dynamic PCI nodes

- Clean-up early parsing of '#{address,size}-cells'

----------------------------------------------------------------
Alexander Stein (1):
      dt-bindings: interrupt-controller: fsl,irqsteer: Add imx8mp/imx8qxp support

Andre Przywara (1):
      dt-bindings: arm: cpus: Add new Cortex and Neoverse names

Biju Das (2):
      media: dt-bindings: renesas,rzg2l-csi2: Document Renesas RZ/G2UL CSI-2 block
      media: dt-bindings: renesas,rzg2l-cru: Document Renesas RZ/G2UL CRU block

Bjorn Andersson (1):
      dt-bindings: interrupt-controller: qcom,pdc: Add sc8180x PDC

Dmitry Baryshkov (2):
      dt-bindings: ufs: qcom,ufs: drop source clock entries
      kbuild: verify dtoverlay files against schema

Eddie James (10):
      dt-bindings: fsi: fsi2spi: Document SPI controller child nodes
      dt-bindings: fsi: Document the IBM SCOM engine
      dt-bindings: fsi: p9-occ: Convert to json-schema
      dt-bindings: fsi: Document the IBM SBEFIFO engine
      dt-bindings: fsi: Document the FSI controller common properties
      dt-bindings: fsi: ibm,i2cr-fsi-master: Reference common FSI controller
      dt-bindings: fsi: ast2600-fsi-master: Convert to json-schema
      dt-bindings: fsi: Document the AST2700 FSI controller
      dt-bindings: fsi: Document the FSI Hub Controller
      dt-bindings: i2c: i2c-fsi: Convert to json-schema

Frank Li (5):
      dt-bindings: misc: fsl,qoriq-mc: convert to yaml format
      dt-bindings: soc: fsl: Convert q(b)man-* to yaml format
      dt-bindings: interrupt-controller: convert fsl,ls-scfg-msi to yaml
      dt-bindings: soc: fsl: cpm_qe: convert to yaml format
      dt-bindings: soc: fsl: Add fsl,ls1028a-reset for reset syscon node

Geert Uytterhoeven (1):
      dt-bindings: timer: renesas,tmu: Make interrupt-names required

Herve Codina (5):
      of: dynamic: Constify parameter in of_changeset_add_prop_string_array()
      of: unittest: Add tests for changeset properties adding
      of: dynamic: Introduce of_changeset_add_prop_bool()
      of: unittest: Add a test case for of_changeset_add_prop_bool()
      PCI: of_property: Add interrupt-controller property in PCI device nodes

Krzysztof Kozlowski (3):
      dt-bindings: display: panel: constrain 'reg' in DSI panels (part two)
      dt-bindings: drop stale Anson Huang from maintainers
      dt-bindings: incomplete-devices: document devices without bindings

Neil Armstrong (1):
      dt-bindings: trivial-devices: document the Sierra Wireless mangOH Green SPI IoT interface

Rob Herring (2):
      of/fdt: Scan the root node properties earlier
      of/fdt: avoid re-parsing '#{address,size}-cells' in of_fdt_limit_memory

Rob Herring (Arm) (1):
      scripts/dtc: Update to upstream version v1.7.0-93-g1df7b047fe43

Rohit Agarwal (1):
      dt-bindings: dma: qcom,gpi: document the SDX75 GPI DMA Engine

Shresth Prasad (1):
      dt-bindings: watchdog: img,pdc-wdt: Convert to dtschema

Stanislav Jakubek (2):
      dt-bindings: clock: drop obsolete stericsson,abx500.txt
      dt-bindings: timer: sprd-timer: convert to YAML

 Documentation/devicetree/bindings/arm/cpus.yaml    |   6 +
 .../bindings/arm/freescale/fsl,imx7ulp-sim.yaml    |   4 +-
 .../devicetree/bindings/clock/imx6q-clock.yaml     |   3 +-
 .../devicetree/bindings/clock/imx6sl-clock.yaml    |   3 +-
 .../devicetree/bindings/clock/imx6sll-clock.yaml   |   3 +-
 .../devicetree/bindings/clock/imx6sx-clock.yaml    |   3 +-
 .../devicetree/bindings/clock/imx6ul-clock.yaml    |   3 +-
 .../devicetree/bindings/clock/imx7d-clock.yaml     |   1 -
 .../devicetree/bindings/clock/imx8m-clock.yaml     |   3 +-
 .../bindings/clock/stericsson,abx500.txt           |  20 --
 .../bindings/display/panel/lg,sw43408.yaml         |   4 +-
 .../bindings/display/panel/raydium,rm69380.yaml    |   5 +-
 .../devicetree/bindings/dma/qcom,gpi.yaml          |   1 +
 .../bindings/fsi/aspeed,ast2600-fsi-master.yaml    | 121 +++++++
 .../devicetree/bindings/fsi/fsi-controller.yaml    |  66 ++++
 .../devicetree/bindings/fsi/fsi-master-aspeed.txt  |  36 ---
 .../devicetree/bindings/fsi/ibm,fsi2spi.yaml       |  36 ++-
 .../bindings/fsi/ibm,i2cr-fsi-master.yaml          |   5 +-
 .../bindings/fsi/ibm,p9-fsi-controller.yaml        |  45 +++
 .../devicetree/bindings/fsi/ibm,p9-occ.txt         |  16 -
 .../devicetree/bindings/fsi/ibm,p9-occ.yaml        |  40 +++
 .../devicetree/bindings/fsi/ibm,p9-sbefifo.yaml    |  46 +++
 .../devicetree/bindings/fsi/ibm,p9-scom.yaml       |  37 +++
 .../devicetree/bindings/gpio/fsl-imx-gpio.yaml     |   4 +-
 .../devicetree/bindings/gpio/gpio-mxs.yaml         |   1 -
 Documentation/devicetree/bindings/i2c/i2c-fsi.txt  |  40 ---
 .../devicetree/bindings/i2c/i2c-imx-lpi2c.yaml     |   4 +-
 .../devicetree/bindings/i2c/ibm,i2c-fsi.yaml       |  76 +++++
 .../bindings/iio/magnetometer/fsl,mag3110.yaml     |   2 +-
 .../devicetree/bindings/incomplete-devices.yaml    | 137 ++++++++
 .../interrupt-controller/fsl,irqsteer.yaml         |  23 +-
 .../bindings/interrupt-controller/fsl,ls-msi.yaml  |  79 +++++
 .../interrupt-controller/fsl,ls-scfg-msi.txt       |  30 --
 .../bindings/interrupt-controller/qcom,pdc.yaml    |   1 +
 .../bindings/media/renesas,rzg2l-cru.yaml          |  35 ++-
 .../bindings/media/renesas,rzg2l-csi2.yaml         |   1 +
 .../bindings/memory-controllers/fsl/mmdc.yaml      |   4 +-
 .../devicetree/bindings/misc/fsl,qoriq-mc.txt      | 196 ------------
 .../devicetree/bindings/misc/fsl,qoriq-mc.yaml     | 187 +++++++++++
 .../devicetree/bindings/nvmem/imx-iim.yaml         |   4 +-
 .../devicetree/bindings/nvmem/imx-ocotp.yaml       |   4 +-
 .../devicetree/bindings/nvmem/mxs-ocotp.yaml       |   4 +-
 .../devicetree/bindings/pwm/imx-tpm-pwm.yaml       |   4 +-
 Documentation/devicetree/bindings/pwm/mxs-pwm.yaml |   1 -
 .../devicetree/bindings/soc/fsl/bman-portals.txt   |  56 ----
 Documentation/devicetree/bindings/soc/fsl/bman.txt | 137 --------
 .../bindings/soc/fsl/cpm_qe/fsl,qe-firmware.yaml   |  48 +++
 .../bindings/soc/fsl/cpm_qe/fsl,qe-ic.yaml         |  47 +++
 .../bindings/soc/fsl/cpm_qe/fsl,qe-muram.yaml      |  71 +++++
 .../bindings/soc/fsl/cpm_qe/fsl,qe-si.yaml         |  40 +++
 .../bindings/soc/fsl/cpm_qe/fsl,qe-siram.yaml      |  39 +++
 .../devicetree/bindings/soc/fsl/cpm_qe/fsl,qe.yaml | 148 +++++++++
 .../devicetree/bindings/soc/fsl/cpm_qe/qe.txt      | 178 -----------
 .../bindings/soc/fsl/fsl,bman-portal.yaml          |  52 +++
 .../devicetree/bindings/soc/fsl/fsl,bman.yaml      |  83 +++++
 .../bindings/soc/fsl/fsl,ls1028a-reset.yaml        |  56 ++++
 .../devicetree/bindings/soc/fsl/fsl,qman-fqd.yaml  |  69 ++++
 .../bindings/soc/fsl/fsl,qman-portal.yaml          | 110 +++++++
 .../devicetree/bindings/soc/fsl/fsl,qman.yaml      |  93 ++++++
 .../devicetree/bindings/soc/fsl/qman-portals.txt   | 134 --------
 Documentation/devicetree/bindings/soc/fsl/qman.txt | 187 -----------
 .../devicetree/bindings/spi/spi-fsl-lpspi.yaml     |   4 +-
 .../devicetree/bindings/thermal/imx-thermal.yaml   |   1 -
 .../bindings/thermal/imx8mm-thermal.yaml           |   4 +-
 .../devicetree/bindings/thermal/qoriq-thermal.yaml |   4 +-
 .../devicetree/bindings/timer/renesas,tmu.yaml     |   1 +
 .../bindings/timer/sprd,sc9860-timer.yaml          |  68 ++++
 .../bindings/timer/spreadtrum,sprd-timer.txt       |  20 --
 .../devicetree/bindings/trivial-devices.yaml       |   2 +
 .../devicetree/bindings/ufs/qcom,ufs.yaml          |  12 +-
 .../devicetree/bindings/watchdog/fsl-imx-wdt.yaml  |   4 +-
 .../bindings/watchdog/fsl-imx7ulp-wdt.yaml         |   4 +-
 .../devicetree/bindings/watchdog/img,pdc-wdt.yaml  |  55 ++++
 .../devicetree/bindings/watchdog/imgpdc-wdt.txt    |  19 --
 .../ethernet/freescale/dpaa2/overview.rst          |   2 +-
 MAINTAINERS                                        |   2 +-
 drivers/of/dynamic.c                               |  27 +-
 drivers/of/fdt.c                                   |  30 +-
 drivers/of/unittest.c                              | 166 ++++++++++
 drivers/pci/of_property.c                          |  24 ++
 include/linux/of.h                                 |   5 +-
 scripts/Makefile.lib                               |   9 +-
 scripts/dtc/checks.c                               |  85 ++---
 scripts/dtc/dtc-parser.y                           |   5 +
 scripts/dtc/dtc.c                                  |   9 +-
 scripts/dtc/dtc.h                                  |  12 +-
 scripts/dtc/fdtoverlay.c                           |   6 +-
 scripts/dtc/flattree.c                             |  21 +-
 scripts/dtc/fstree.c                               |   2 +-
 scripts/dtc/libfdt/fdt_overlay.c                   | 349 +++++++++++++++++----
 scripts/dtc/libfdt/fdt_ro.c                        |  37 ++-
 scripts/dtc/libfdt/libfdt.h                        |  67 +++-
 scripts/dtc/livetree.c                             |  56 ++--
 scripts/dtc/srcpos.c                               |  14 +-
 scripts/dtc/treesource.c                           |  26 ++
 scripts/dtc/util.h                                 |   6 +-
 scripts/dtc/version_gen.h                          |   2 +-
 97 files changed, 2751 insertions(+), 1301 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/stericsson,abx500.txt
 create mode 100644 Documentation/devicetree/bindings/fsi/aspeed,ast2600-fsi-master.yaml
 create mode 100644 Documentation/devicetree/bindings/fsi/fsi-controller.yaml
 delete mode 100644 Documentation/devicetree/bindings/fsi/fsi-master-aspeed.txt
 create mode 100644 Documentation/devicetree/bindings/fsi/ibm,p9-fsi-controller.yaml
 delete mode 100644 Documentation/devicetree/bindings/fsi/ibm,p9-occ.txt
 create mode 100644 Documentation/devicetree/bindings/fsi/ibm,p9-occ.yaml
 create mode 100644 Documentation/devicetree/bindings/fsi/ibm,p9-sbefifo.yaml
 create mode 100644 Documentation/devicetree/bindings/fsi/ibm,p9-scom.yaml
 delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-fsi.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/ibm,i2c-fsi.yaml
 create mode 100644 Documentation/devicetree/bindings/incomplete-devices.yaml
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,ls-msi.yaml
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,ls-scfg-msi.txt
 delete mode 100644 Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
 create mode 100644 Documentation/devicetree/bindings/misc/fsl,qoriq-mc.yaml
 delete mode 100644 Documentation/devicetree/bindings/soc/fsl/bman-portals.txt
 delete mode 100644 Documentation/devicetree/bindings/soc/fsl/bman.txt
 create mode 100644 Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,qe-firmware.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,qe-ic.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,qe-muram.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,qe-si.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,qe-siram.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,qe.yaml
 delete mode 100644 Documentation/devicetree/bindings/soc/fsl/cpm_qe/qe.txt
 create mode 100644 Documentation/devicetree/bindings/soc/fsl/fsl,bman-portal.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/fsl/fsl,bman.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/fsl/fsl,ls1028a-reset.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/fsl/fsl,qman-fqd.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/fsl/fsl,qman-portal.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/fsl/fsl,qman.yaml
 delete mode 100644 Documentation/devicetree/bindings/soc/fsl/qman-portals.txt
 delete mode 100644 Documentation/devicetree/bindings/soc/fsl/qman.txt
 create mode 100644 Documentation/devicetree/bindings/timer/sprd,sc9860-timer.yaml
 delete mode 100644 Documentation/devicetree/bindings/timer/spreadtrum,sprd-timer.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/img,pdc-wdt.yaml
 delete mode 100644 Documentation/devicetree/bindings/watchdog/imgpdc-wdt.txt

