Return-Path: <linux-kernel+bounces-332968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C0397C19E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 23:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3478F283875
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 21:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25C91CB328;
	Wed, 18 Sep 2024 21:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SPvlIGgp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B761494B1;
	Wed, 18 Sep 2024 21:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726696656; cv=none; b=U34hyRSm9Xe+RdCYJ/WnKZtcOtUDi6rsiy2ei7ksakAFe3PpSavaBiJZX9l8ysQnWumfJ/9+1WVYg0r6wYyuVU1+Du0yNF83BQif2lUZSEko+yUyLjsrAEqxsDoG3/0ikyxjsTZDawZVSyx44x7SiWjC3zhA6R4zgoxJ1HHnKz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726696656; c=relaxed/simple;
	bh=i32wingcT1vcOFx8q0BZDhsALOpyo+P7xNjWlD0c6u4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=o+qKKNn318Qoh2PEUjyjSRWriaiqUHwWRsh74X8E+kpAA0TWGFiPwgOO0Ld6RhjPm/I59EREAplzoRQi+ujjouiJQUS2K5jfCUUuvzt4UxaYvgRE+LNqFdhYyaSB85N/3gS5Txgch8aJ3np4VeabZKXiF+X4F1LpwH32SjrY0WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SPvlIGgp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 332FCC4CEC2;
	Wed, 18 Sep 2024 21:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726696656;
	bh=i32wingcT1vcOFx8q0BZDhsALOpyo+P7xNjWlD0c6u4=;
	h=Date:From:To:Cc:Subject:From;
	b=SPvlIGgp5OoYJ7NEVx3XLnJHhMD8x2dafwywjipBYp/jbfPJ72E3qirBSDAyn4p0M
	 1JQA3ml/ijtxxP4t8Ldpj0Vi+m9ETQgxJBI4epGyzBle2bvoyRYKjy9hUpRKtZJI9+
	 fWmrrN4piezowT2n6DAAZfNpD2S8xL6Tf9WZMVo35TXmVwPSVbsPuFZ5Ojpd4Kul7y
	 H2g+uWwATs7xcL7axfNpBL7R0EdORFCIHm5ytgmJmWpyAQD8mKPDYcqR5qJn5mwH/c
	 fZbyWOKqYbCoUzA7uW4mBLLxl/ibDZbgd25ko6VwceLWCzZHS9mz7roKshV1evlW33
	 ZXCuLWSpws9AQ==
Date: Wed, 18 Sep 2024 16:57:35 -0500
From: Rob Herring <robh@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Saravana Kannan <saravanak@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [GIT PULL] Devicetree updates for v6.12
Message-ID: <20240918215735.GA2208101-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Linus,

Please pull DT updates for 6.12.

There's one trivial context conflict in wakeup-source.txt with the input 
tree.

Rob


The following changes since commit b739dffa5d570b411d4bdf4bb9b8dfd6b7d72305:

  of/irq: Prevent device address out-of-bounds read in interrupt map walk (2024-08-13 15:17:24 -0600)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-6.12

for you to fetch changes up to 0c36680c0e2d959cc264a1e65628c825f7f87add:

  dt-bindings: watchdog: Add rockchip,rk3576-wdt compatible (2024-09-18 15:38:24 -0500)

----------------------------------------------------------------
Devicetree updates for v6.12:

DT Bindings:
- Drop duplicate devices in trivial-devices.yaml

- Add a common serial peripheral device schema and reference it in
  serial device schemas.

- Convert nxp,lpc1850-wdt, zii,rave-wdt, ti,davinci-wdt,
  snps,archs-pct, fsl,bcsr, fsl,fpga-qixis-i2c, fsl,fpga-qixis,
  fsl,cpm-enet, fsl,cpm-mdio, fsl,ucc-hdlc, maxim,ds26522,
  aspeed,ast2400-cvic, aspeed,ast2400-vic, fsl,ftm-timer,
  ti,davinci-timer, fsl,rcpm, and qcom,ebi2 to DT schema

- Add support for rockchip,rk3576-wdt, qcom,apss-wdt-sa8255p,
  fsl,imx8qm-irqsteer, qcom,pm6150-vib, qcom,sa8255p-pdc, isil,isl69260,
  ti,tps546d24, and lpc32xx DMA mux

- Drop duplicate nvidia,tegra186-ccplex-cluster.yaml and
  mediatek,mt6795-sys-clock.yaml

- Add arm,gic ESPI and EPPI interrupt type specifiers

- Add another batch of legacy compatible strings which we have no
  intention of documenting

- Add dmas/dma-names properties to FSL lcdif

- Fix wakeup-source reference to m8921-keypad.yaml

- Treewide fixes of typos in bindings

DT Core:
- Update dtc/libfdt to upstream version v1.7.0-95-gbcd02b523429

- More conversions to scoped iterators and __free() initializer

- Handle overflows in address resources on 32-bit systems

- Extend extracting compatible strings in sources from function
  parameters

- Use of_property_present() in DT unittest

- Clean-up of_irq_to_resource() to use helpers

- Support #msi-cells=<0> in of_msi_get_domain()

- Improve the kerneldoc for of_property_match_string()

- kselftest: Ignore nodes that have ancestors disabled

----------------------------------------------------------------
Andrew Jeffery (2):
      dt-bindings: interrupt-controller: aspeed,ast2400-vic: Convert to DT schema
      dt-bindings: misc: aspeed,ast2400-cvic: Convert to DT schema

Andrew Jones (1):
      of/irq: Support #msi-cells=<0> in of_msi_get_domain

Animesh Agarwal (3):
      dt-bindings: timer: fsl,ftm-timer: Convert to dtschema
      dt-bindings: timer: nxp,lpc3220-timer: Convert to dtschema
      dt-bindings: watchdog: nxp,lpc1850-wdt: Convert bindings to dtschema

Aryabhatta Dey (1):
      dt-bindings: arc: convert archs-pct.txt to yaml

Detlev Casanova (1):
      dt-bindings: watchdog: Add rockchip,rk3576-wdt compatible

Fabio Estevam (2):
      dt-bindings: lcdif: Document the dmas/dma-names properties
      dt-bindings: interrupt-controller: fsl,irqsteer: Document fsl,imx8qm-irqsteer

Frank Li (7):
      dt-bindings: soc: fsl: Convert rcpm to yaml format
      dt-bindings: soc: fsl: add missed compatible string fsl,ls*-isc
      dt-bindings: net: convert maxim,ds26522.txt to yaml format
      dt-bindings: soc: fsl: cpm_qe: convert network.txt to yaml
      dt-bindings: board: convert fsl-board.txt to yaml
      dt-bindings: display: panel-simple-lvds-dual-ports: use unevaluatedProperties
      dt-bindings: watchdog: convert ziirave-wdt.txt to yaml

Geert Uytterhoeven (2):
      of/irq: Refer to actual buffer size in of_irq_parse_one()
      dt-bindings: clk: vc5: Make SD/OE pin configuration properties not required

Hugues KAMBA MPIANA (1):
      dt-bindings: arm: Update Corstone-1000 maintainers

Jens Reidel (1):
      dt-bindings: input: qcom,pm8xxx-vib: Document PM6150 compatible

Jinjie Ruan (3):
      of: overlay: Simplify with scoped for each OF child loop
      of/platform: Simplify with scoped for each OF child
      of: resolver: Simplify with scoped for each OF child loop

Kousik Sanagavarapu (2):
      dt-bindings: timer: ti,davinci-timer: convert to dtschema
      dt-bindings: watchdog: ti,davinci-wdt: convert to dtschema

Krzysztof Kozlowski (7):
      dt-bindings: fsl: fsl,rcpm: fix unevaluated fsl,rcpm-wakeup property
      dt-bindings: serial: add missing "additionalProperties" on child nodes
      dt-bindings: serial: add common properties schema for UART children
      dt-bindings: bluetooth: move Bluetooth bindings to dedicated directory
      dt-bindings: gnss: reference serial-peripheral-props.yaml
      dt-bindings: bluetooth: reference serial-peripheral-props.yaml
      ASoC: dt-bindings: serial-midi: reference serial-peripheral-props.yaml

Marek Vasut (1):
      dt-bindings: hwmon: Document TI TPS546D24

Miquel Sabaté Solà (1):
      drivers/of: Improve documentation for match_string

Nikunj Kela (3):
      dt-bindings: interrupt-controller: qcom-pdc: document support for SA8255p
      dt-bindings: interrupt-controller: arm,gic: add ESPI and EPPI specifiers
      dt-bindings: watchdog: qcom-wdt: document support on SA8255p

Nícolas F. R. A. Prado (1):
      kselftest: dt: Ignore nodes that have ancestors disabled

Peter Yin (1):
      dt-bindings: trivial-devices: add isil,isl69260

Piotr Wojtaszczyk (1):
      dt-bindings: dma: Add lpc32xx DMA mux binding

Rayyan Ansari (1):
      dt-bindings: bus: qcom,ebi2: convert to dtschema

Rob Herring (Arm) (11):
      of: unittest: Use of_property_present()
      scripts/dtc: Update to upstream version v1.7.0-95-gbcd02b523429
      Merge branch 'dt/linus' into dt/next
      dt: dt-extract-compatibles: Extract compatibles from function parameters
      dt-bindings: incomplete-devices: And another batch of compatibles
      dt-bindings: trivial-devices: Drop incorrect and duplicate at24 compatibles
      dt-bindings: trivial-devices: Deprecate "ad,ad7414"
      dt-bindings: trivial-devices: Drop duplicate LM75 compatible devices
      dt-bindings: trivial-devices: Drop duplicate "maxim,max1237"
      dt-bindings: clock: mediatek: Drop duplicate mediatek,mt6795-sys-clock.yaml
      dt-bindings: cpu: Drop duplicate nvidia,tegra186-ccplex-cluster.yaml

Simon Horman (1):
      dt-bindings: wakeup-source: update reference to m8921-keypad.yaml

Thomas Weißschuh (2):
      of: address: Report error on resource bounds overflow
      of: address: Unify resource bounds overflow checking

Vasileios Amoiridis (2):
      of/irq: Make use of irq_get_trigger_type()
      of/irq: Use helper to define resources

Yu-Chun Lin (1):
      dt-bindings: Fix various typos

Zhang Zekun (1):
      of: property: Do some clean up with use of __free()

 .../devicetree/bindings/arc/archs-pct.txt          |  17 --
 .../devicetree/bindings/arc/snps,archs-pct.yaml    |  33 +++
 .../bindings/arm/arm,coresight-dummy-source.yaml   |   2 +-
 .../devicetree/bindings/arm/arm,corstone1000.yaml  |   4 +-
 .../devicetree/bindings/board/fsl,bcsr.yaml        |  32 +++
 .../bindings/board/fsl,fpga-qixis-i2c.yaml         |  70 ++++++
 .../devicetree/bindings/board/fsl,fpga-qixis.yaml  |  81 +++++++
 .../devicetree/bindings/board/fsl-board.txt        |  81 -------
 .../devicetree/bindings/bus/qcom,ebi2.txt          | 138 ------------
 .../devicetree/bindings/bus/qcom,ebi2.yaml         | 239 +++++++++++++++++++++
 .../devicetree/bindings/clock/idt,versaclock5.yaml |   2 -
 .../bindings/clock/mediatek,mt6795-sys-clock.yaml  |  54 -----
 .../devicetree/bindings/cpu/idle-states.yaml       |   2 +-
 .../cpu/nvidia,tegra186-ccplex-cluster.yaml        |  37 ----
 .../devicetree/bindings/display/fsl,lcdif.yaml     |  20 ++
 .../devicetree/bindings/display/lvds.yaml          |   2 +-
 .../panel/panel-simple-lvds-dual-ports.yaml        |   6 +-
 .../bindings/dma/nxp,lpc3220-dmamux.yaml           |  49 +++++
 .../devicetree/bindings/dma/ti-dma-crossbar.txt    |   2 +-
 .../devicetree/bindings/gnss/brcm,bcm4751.yaml     |   1 +
 .../devicetree/bindings/gnss/gnss-common.yaml      |   5 -
 .../devicetree/bindings/gnss/mediatek.yaml         |   1 +
 .../devicetree/bindings/gnss/sirfstar.yaml         |   1 +
 .../devicetree/bindings/gnss/u-blox,neo-6m.yaml    |   1 +
 .../devicetree/bindings/iio/accel/lis302.txt       |   2 +-
 .../devicetree/bindings/incomplete-devices.yaml    | 148 +++++++++++++
 .../devicetree/bindings/input/qcom,pm8xxx-vib.yaml |   1 +
 .../bindings/interrupt-controller/arm,gic-v3.yaml  |   2 +-
 .../interrupt-controller/aspeed,ast2400-vic.txt    |  23 --
 .../interrupt-controller/aspeed,ast2400-vic.yaml   |  62 ++++++
 .../interrupt-controller/fsl,irqsteer.yaml         |   2 +
 .../bindings/interrupt-controller/qcom,pdc.yaml    |   1 +
 .../devicetree/bindings/leds/awinic,aw200xx.yaml   |   2 +-
 .../bindings/mailbox/brcm,iproc-flexrm-mbox.txt    |   2 +-
 .../bindings/media/i2c/thine,thp7312.yaml          |   2 +-
 .../bindings/media/samsung,exynos4210-fimc.yaml    |   2 +-
 .../devicetree/bindings/mfd/rohm,bd96801-pmic.yaml |   2 +-
 .../devicetree/bindings/mfd/samsung,s2mps11.yaml   |   2 +-
 Documentation/devicetree/bindings/mfd/twl6040.txt  |   2 +-
 .../bindings/misc/aspeed,ast2400-cvic.yaml         |  60 ++++++
 .../devicetree/bindings/misc/aspeed,cvic.txt       |  35 ---
 .../brcm,bluetooth.yaml}                           |  35 ++-
 .../marvell,88w8897.yaml}                          |   6 +-
 .../mediatek,bluetooth.txt}                        |   0
 .../nokia,h4p-bluetooth.txt}                       |   0
 .../bindings/net/bluetooth/qualcomm-bluetooth.yaml |   6 +-
 .../realtek,bluetooth.yaml}                        |   5 +-
 .../bindings/net/{ => bluetooth}/ti,bluetooth.yaml |   5 +-
 .../devicetree/bindings/net/fsl,cpm-enet.yaml      |  59 +++++
 .../devicetree/bindings/net/fsl,cpm-mdio.yaml      |  55 +++++
 .../devicetree/bindings/net/maxim,ds26522.txt      |  13 --
 .../devicetree/bindings/net/maxim,ds26522.yaml     |  40 ++++
 .../devicetree/bindings/phy/apm-xgene-phy.txt      |   2 +-
 .../bindings/phy/mediatek,mt7988-xfi-tphy.yaml     |   2 +-
 .../devicetree/bindings/phy/mediatek,tphy.yaml     |   2 +-
 .../bindings/phy/qcom,snps-eusb2-repeater.yaml     |   2 +-
 .../bindings/pinctrl/st,stm32-pinctrl.yaml         |   4 +-
 .../devicetree/bindings/power/wakeup-source.txt    |   2 +-
 .../devicetree/bindings/remoteproc/mtk,scp.yaml    |   2 +-
 .../devicetree/bindings/rtc/fsl,ls-ftm-alarm.yaml  |   2 +-
 .../bindings/serial/nvidia,tegra20-hsuart.yaml     |   2 +-
 .../bindings/serial/serial-peripheral-props.yaml   |  41 ++++
 .../devicetree/bindings/serial/serial.yaml         |  24 +--
 .../bindings/soc/fsl/cpm_qe/fsl,ucc-hdlc.yaml      | 140 ++++++++++++
 .../devicetree/bindings/soc/fsl/cpm_qe/network.txt | 130 -----------
 .../bindings/soc/fsl/fsl,layerscape-scfg.yaml      |   3 +
 .../devicetree/bindings/soc/fsl/fsl,rcpm.yaml      |  87 ++++++++
 Documentation/devicetree/bindings/soc/fsl/rcpm.txt |  69 ------
 .../devicetree/bindings/sound/everest,es8326.yaml  |   2 +-
 .../devicetree/bindings/sound/serial-midi.yaml     |   3 +
 .../devicetree/bindings/sound/st,sta350.txt        |   2 +-
 .../devicetree/bindings/thermal/qcom-tsens.yaml    |   2 +-
 .../devicetree/bindings/timer/fsl,ftm-timer.txt    |  31 ---
 .../devicetree/bindings/timer/fsl,ftm-timer.yaml   |  59 +++++
 .../bindings/timer/nxp,lpc3220-timer.txt           |  26 ---
 .../bindings/timer/nxp,lpc3220-timer.yaml          |  55 +++++
 .../devicetree/bindings/timer/ti,da830-timer.yaml  |  68 ++++++
 .../devicetree/bindings/timer/ti,davinci-timer.txt |  37 ----
 .../devicetree/bindings/trivial-devices.yaml       |  20 +-
 .../devicetree/bindings/watchdog/davinci-wdt.txt   |  24 ---
 .../devicetree/bindings/watchdog/lpc18xx-wdt.txt   |  19 --
 .../bindings/watchdog/nxp,lpc1850-wwdt.yaml        |  52 +++++
 .../devicetree/bindings/watchdog/qcom-wdt.yaml     |   1 +
 .../devicetree/bindings/watchdog/snps,dw-wdt.yaml  |   1 +
 .../bindings/watchdog/ti,davinci-wdt.yaml          |  55 +++++
 .../devicetree/bindings/watchdog/zii,rave-wdt.yaml |  49 +++++
 .../devicetree/bindings/watchdog/ziirave-wdt.txt   |  19 --
 MAINTAINERS                                        |  11 +-
 drivers/of/address.c                               |  40 ++--
 drivers/of/irq.c                                   |  43 +---
 drivers/of/overlay.c                               |  12 +-
 drivers/of/platform.c                              |  14 +-
 drivers/of/property.c                              |  41 ++--
 drivers/of/resolver.c                              |  12 +-
 drivers/of/unittest.c                              |   4 +-
 include/dt-bindings/interrupt-controller/arm-gic.h |   2 +
 scripts/dtc/checks.c                               |  16 +-
 scripts/dtc/dt-extract-compatibles                 |  13 ++
 scripts/dtc/fdtoverlay.c                           |   2 +-
 scripts/dtc/version_gen.h                          |   2 +-
 .../testing/selftests/dt/test_unprobed_devices.sh  |  15 +-
 101 files changed, 1756 insertions(+), 964 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arc/archs-pct.txt
 create mode 100644 Documentation/devicetree/bindings/arc/snps,archs-pct.yaml
 create mode 100644 Documentation/devicetree/bindings/board/fsl,bcsr.yaml
 create mode 100644 Documentation/devicetree/bindings/board/fsl,fpga-qixis-i2c.yaml
 create mode 100644 Documentation/devicetree/bindings/board/fsl,fpga-qixis.yaml
 delete mode 100644 Documentation/devicetree/bindings/board/fsl-board.txt
 delete mode 100644 Documentation/devicetree/bindings/bus/qcom,ebi2.txt
 create mode 100644 Documentation/devicetree/bindings/bus/qcom,ebi2.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt6795-sys-clock.yaml
 delete mode 100644 Documentation/devicetree/bindings/cpu/nvidia,tegra186-ccplex-cluster.yaml
 create mode 100644 Documentation/devicetree/bindings/dma/nxp,lpc3220-dmamux.yaml
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2400-vic.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2400-vic.yaml
 create mode 100644 Documentation/devicetree/bindings/misc/aspeed,ast2400-cvic.yaml
 delete mode 100644 Documentation/devicetree/bindings/misc/aspeed,cvic.txt
 rename Documentation/devicetree/bindings/net/{broadcom-bluetooth.yaml => bluetooth/brcm,bluetooth.yaml} (90%)
 rename Documentation/devicetree/bindings/net/{marvell-bluetooth.yaml => bluetooth/marvell,88w8897.yaml} (83%)
 rename Documentation/devicetree/bindings/net/{mediatek-bluetooth.txt => bluetooth/mediatek,bluetooth.txt} (100%)
 rename Documentation/devicetree/bindings/net/{nokia-bluetooth.txt => bluetooth/nokia,h4p-bluetooth.txt} (100%)
 rename Documentation/devicetree/bindings/net/{realtek-bluetooth.yaml => bluetooth/realtek,bluetooth.yaml} (92%)
 rename Documentation/devicetree/bindings/net/{ => bluetooth}/ti,bluetooth.yaml (94%)
 create mode 100644 Documentation/devicetree/bindings/net/fsl,cpm-enet.yaml
 create mode 100644 Documentation/devicetree/bindings/net/fsl,cpm-mdio.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/maxim,ds26522.txt
 create mode 100644 Documentation/devicetree/bindings/net/maxim,ds26522.yaml
 create mode 100644 Documentation/devicetree/bindings/serial/serial-peripheral-props.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,ucc-hdlc.yaml
 delete mode 100644 Documentation/devicetree/bindings/soc/fsl/cpm_qe/network.txt
 create mode 100644 Documentation/devicetree/bindings/soc/fsl/fsl,rcpm.yaml
 delete mode 100644 Documentation/devicetree/bindings/soc/fsl/rcpm.txt
 delete mode 100644 Documentation/devicetree/bindings/timer/fsl,ftm-timer.txt
 create mode 100644 Documentation/devicetree/bindings/timer/fsl,ftm-timer.yaml
 delete mode 100644 Documentation/devicetree/bindings/timer/nxp,lpc3220-timer.txt
 create mode 100644 Documentation/devicetree/bindings/timer/nxp,lpc3220-timer.yaml
 create mode 100644 Documentation/devicetree/bindings/timer/ti,da830-timer.yaml
 delete mode 100644 Documentation/devicetree/bindings/timer/ti,davinci-timer.txt
 delete mode 100644 Documentation/devicetree/bindings/watchdog/davinci-wdt.txt
 delete mode 100644 Documentation/devicetree/bindings/watchdog/lpc18xx-wdt.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/nxp,lpc1850-wwdt.yaml
 create mode 100644 Documentation/devicetree/bindings/watchdog/ti,davinci-wdt.yaml
 create mode 100644 Documentation/devicetree/bindings/watchdog/zii,rave-wdt.yaml
 delete mode 100644 Documentation/devicetree/bindings/watchdog/ziirave-wdt.txt

