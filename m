Return-Path: <linux-kernel+bounces-181375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 652DE8C7B6C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 19:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8959B1C210EA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 17:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1ED156871;
	Thu, 16 May 2024 17:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E3SXXPQ4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3438F143C4A;
	Thu, 16 May 2024 17:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715880987; cv=none; b=oeCLtHl6SS3u+PqP8z4Omio4Q/AwN0txr+YZu0/ea8Sv3CrHYH/HxO2WkeuM997q6I7q6UZGIYxAKodbqdasHnaKfaOZQus5Ltc2M3SfYUKHDOeIo5FB7CWkkJIYuDyx63V4s9tnBUUdEYWqHDSernJm0BR8M0itD02invYV6Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715880987; c=relaxed/simple;
	bh=nutT63GwRuDLDHZtr97oZnDiU7m1cCydN+Qvlq72fWI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fFX+GwvMm1S4dSsgJCUyzHiW4080HnY3nJzE39gjlwKeXqdUhw5x6yzQXsUfqq/6/STYjZ4YqYJvPnhtEZP6eHalIIOrcB8oiEorObOiaKhpx8k5OEqVxldcMVpUliTy00of1kFck89gy3LneZrYZZuE3rvJh42Ri8nutrvW7Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E3SXXPQ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89352C113CC;
	Thu, 16 May 2024 17:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715880986;
	bh=nutT63GwRuDLDHZtr97oZnDiU7m1cCydN+Qvlq72fWI=;
	h=Date:From:To:Cc:Subject:From;
	b=E3SXXPQ4b5n8D4VAD1artIMDGwaEM9SvqRIFnQ0ZSqUmzxgV1StFk5zKT/P1VhklZ
	 Xi5CaZNYdz2yiLLS8GrWUVrNcNJwJbbLdhF0kYh5fXa9FwEsnzUBDI6BVPRxIkaXzl
	 EimvWCeHna5XUMj6nJ/5AoF7j3En2o2tqRmoCuLAfiEB/CoBEGsOUWhJZZrA4qH27l
	 2hP7a2gsaDF5gP6qoMy/InPHqE5O7zapPlZBNJBmPCTEho0NDvkLf3CJ+Y6y+CfALh
	 dsFIVzMDjnfZ7UK7mQbkv4WOxjtm0+93gUhEIjfbfM/K3lp8nd91nppj6GwFjdH+g8
	 Ko6PZniNFAQ3g==
Date: Thu, 16 May 2024 12:36:25 -0500
From: Rob Herring <robh@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Saravana Kannan <saravanak@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [GIT PULL] Devicetree updates for v6.10
Message-ID: <20240516173625.GA3518068-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Linus,

Please pull DT updates for 6.10. There's a few conflicts which are 
all in your tree now. All just context conflicts and you should take 
both sides. linux-next has the correct resolutions.

Rob


The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-6.10

for you to fetch changes up to d976c6f4b32c2d273d44ff9ad7099efe16279a39:

  of: property: Add fw_devlink support for interrupt-map property (2024-05-13 09:57:35 -0500)

----------------------------------------------------------------
Devicetree for v6.10:

DT Bindings:
- Convert samsung,exynos5-dp, atmel,lcdc, aspeed,ast2400-wdt bindings to
  schemas

- Add bindings for Allwinner H616 NMI controller, Renesas r8a779g0 irqc,
  Renesas R-Car V4M TMU and CMT timers, Freescale S32G3 linflexuart, and
  Mediatek MT7988 XHCI

- Add 'reg' constraints on DSI and SPI display panels

- More dropping of unnecessary quotes in schemas

- Use full paths rather than relative paths in schema $refs

- Drop redundant storing of phandle for reserved memory

DT Core:
- Use scope based cleanups for kfree() and of_node_put()

- Track interrupt-map and power-supplies for fw_devlink

- Add buffer overflow check in of_modalias()

- Add and use __of_prop_free() helper for freeing struct property

----------------------------------------------------------------
Andrew Jeffery (1):
      dt-bindings: watchdog: aspeed,ast2400-wdt: Convert to DT schema

Anup Patel (1):
      of: property: Add fw_devlink support for interrupt-map property

Chris Morgan (1):
      dt-bindings: irq: sun7i-nmi: Add binding for the H616 NMI controller

Dharma Balasubiramani (1):
      dt-bindings: display: atmel,lcdc: convert to dtschema

Geert Uytterhoeven (3):
      dt-bindings: timer: renesas,cmt: Add R-Car V4M support
      dt-bindings: timer: renesas,tmu: Add R-Car V4M support
      dt-bindings: interrupt-controller: renesas,irqc: Add r8a779g0 support

Krzysztof Kozlowski (5):
      dt-bindings: display: samsung,exynos5-dp: convert to DT Schema
      dt-bindings: Use full path to other schemas
      dt-bindings: display: samsung,ams495qa01: add missing SPI properties ref
      dt-bindings: display: panel: constrain 'reg' in SPI panels
      dt-bindings: display: panel: constrain 'reg' in DSI panels

Oreoluwa Babatunde (1):
      of: reserved_mem: Remove the use of phandle from the reserved_mem APIs

Rafał Miłecki (1):
      dt-bindings: usb: mtk-xhci: add compatible for MT7988

Rob Herring (3):
      of: Add a helper to free property struct
      of: Use scope based kfree() cleanups
      of: Use scope based of_node_put() cleanups

Rob Herring (Arm) (3):
      dt-bindings: interrupt-controller: mediatek,mt6577-sysirq: Drop unnecessary quotes
      dt-bindings: Drop unnecessary quotes on keys
      dt-bindings: PCI: qcom,pcie-sm8350: Drop redundant 'oneOf' sub-schema

Saravana Kannan (1):
      of: property: fw_devlink: Add support for "power-supplies" binding

Sergey Shtylyov (1):
      of: module: add buffer overflow check in of_modalias()

Shresth Prasad (1):
      of: property: Use scope based cleanup on port_node

Valentina Fernandez (1):
      dt-bindings: PCI: microchip: increase number of items in ranges property

Wadim Mueller (1):
      dt-bindings: serial: fsl-linflexuart: add compatible for S32G3

 .../bindings/display/atmel,lcdc-display.yaml       | 103 +++++++++++++
 .../devicetree/bindings/display/atmel,lcdc.txt     |  87 -----------
 .../devicetree/bindings/display/atmel,lcdc.yaml    |  70 +++++++++
 .../bindings/display/exynos/exynos_dp.txt          | 112 --------------
 .../bindings/display/panel/abt,y030xx067a.yaml     |   4 +-
 .../display/panel/asus,z00t-tm5p5-nt35596.yaml     |   5 +-
 .../bindings/display/panel/boe,bf060y8m-aj0.yaml   |   4 +-
 .../bindings/display/panel/boe,himax8279d.yaml     |   4 +-
 .../display/panel/boe,th101mb31ig002-28a.yaml      |   4 +-
 .../bindings/display/panel/boe,tv101wum-nl6.yaml   |   2 +-
 .../bindings/display/panel/elida,kd35t133.yaml     |   5 +-
 .../display/panel/fascontek,fs035vg158.yaml        |   3 +
 .../display/panel/feixin,k101-im2ba02.yaml         |   5 +-
 .../bindings/display/panel/himax,hx83112a.yaml     |   4 +-
 .../bindings/display/panel/himax,hx8394.yaml       |   3 +-
 .../bindings/display/panel/ilitek,ili9163.yaml     |   4 +-
 .../bindings/display/panel/ilitek,ili9322.yaml     |   3 +
 .../bindings/display/panel/ilitek,ili9341.yaml     |   3 +-
 .../bindings/display/panel/ilitek,ili9805.yaml     |   4 +-
 .../bindings/display/panel/ilitek,ili9881c.yaml    |   4 +-
 .../bindings/display/panel/innolux,ej030na.yaml    |   4 +-
 .../bindings/display/panel/innolux,p097pfg.yaml    |   4 +-
 .../bindings/display/panel/jadard,jd9365da-h3.yaml |   3 +-
 .../bindings/display/panel/jdi,lpm102a188a.yaml    |   4 +-
 .../bindings/display/panel/jdi,lt070me05000.yaml   |   4 +-
 .../display/panel/kingdisplay,kd035g6-54nt.yaml    |   4 +-
 .../display/panel/leadtek,ltk035c5444t.yaml        |   3 +
 .../display/panel/leadtek,ltk050h3146w.yaml        |   5 +-
 .../display/panel/leadtek,ltk500hd1829.yaml        |   5 +-
 .../bindings/display/panel/lg,lg4573.yaml          |   3 +-
 .../bindings/display/panel/lgphilips,lb035q02.yaml |   3 +
 .../bindings/display/panel/nec,nl8048hl11.yaml     |   4 +-
 .../bindings/display/panel/newvision,nv3051d.yaml  |   4 +-
 .../bindings/display/panel/novatek,nt35510.yaml    |   5 +-
 .../bindings/display/panel/novatek,nt35950.yaml    |   4 +-
 .../bindings/display/panel/novatek,nt36523.yaml    |   4 +-
 .../bindings/display/panel/novatek,nt36672a.yaml   |   4 +-
 .../display/panel/olimex,lcd-olinuxino.yaml        |   4 +-
 .../bindings/display/panel/panel-mipi-dbi-spi.yaml |   3 +
 .../bindings/display/panel/raydium,rm67191.yaml    |   4 +-
 .../bindings/display/panel/raydium,rm692e5.yaml    |   4 +-
 .../bindings/display/panel/ronbo,rb070d30.yaml     |   2 +-
 .../display/panel/samsung,amoled-mipi-dsi.yaml     |   4 +-
 .../bindings/display/panel/samsung,ams495qa01.yaml |   5 +-
 .../bindings/display/panel/samsung,ld9040.yaml     |   4 +-
 .../bindings/display/panel/samsung,lms380kf01.yaml |   3 +-
 .../bindings/display/panel/samsung,lms397kf04.yaml |   3 +-
 .../bindings/display/panel/samsung,s6d16d0.yaml    |   4 +-
 .../bindings/display/panel/samsung,s6d27a1.yaml    |   3 +-
 .../bindings/display/panel/samsung,s6d7aa0.yaml    |   3 +-
 .../bindings/display/panel/samsung,s6e63m0.yaml    |   4 +-
 .../display/panel/samsung,s6e88a0-ams452ef01.yaml  |   5 +-
 .../bindings/display/panel/samsung,s6e8aa0.yaml    |   4 +-
 .../bindings/display/panel/sharp,lq101r1sx01.yaml  |   4 +-
 .../bindings/display/panel/sharp,ls043t1le01.yaml  |   4 +-
 .../bindings/display/panel/sharp,ls060t1sx01.yaml  |   4 +-
 .../bindings/display/panel/sitronix,st7789v.yaml   |   4 +-
 .../bindings/display/panel/sony,acx424akp.yaml     |   5 +-
 .../bindings/display/panel/sony,acx565akm.yaml     |   3 +
 .../bindings/display/panel/sony,td4353-jdi.yaml    |   3 +-
 .../display/panel/sony,tulip-truly-nt35521.yaml    |   3 +-
 .../bindings/display/panel/synaptics,r63353.yaml   |   6 +-
 .../devicetree/bindings/display/panel/tpo,td.yaml  |   4 +-
 .../bindings/display/panel/tpo,tpg110.yaml         |   3 +-
 .../bindings/display/panel/visionox,rm69299.yaml   |   3 +-
 .../bindings/display/panel/xinpeng,xpp055c272.yaml |   5 +-
 .../display/samsung/samsung,exynos5-dp.yaml        | 163 +++++++++++++++++++++
 .../devicetree/bindings/input/azoteq,iqs7222.yaml  |   2 +-
 .../allwinner,sun7i-a20-sc-nmi.yaml                |   8 +-
 .../mediatek,mt6577-sysirq.yaml                    |   2 +-
 .../interrupt-controller/renesas,irqc.yaml         |   1 +
 .../devicetree/bindings/media/amphion,vpu.yaml     |   2 +-
 Documentation/devicetree/bindings/mtd/mtd.yaml     |   4 +-
 Documentation/devicetree/bindings/net/sff,sfp.yaml |  12 +-
 .../bindings/pci/microchip,pcie-host.yaml          |   3 +-
 .../devicetree/bindings/pci/qcom,pcie-sm8350.yaml  |  22 ---
 .../devicetree/bindings/pci/xilinx-versal-cpm.yaml |   7 +-
 .../devicetree/bindings/pci/xlnx,nwl-pcie.yaml     |   2 +-
 .../devicetree/bindings/phy/brcm,sata-phy.yaml     |   8 +-
 .../devicetree/bindings/regulator/ti,tps62864.yaml |   2 +-
 .../bindings/serial/fsl,s32-linflexuart.yaml       |   4 +-
 .../bindings/soc/tegra/nvidia,tegra20-pmc.yaml     |   6 +-
 .../devicetree/bindings/timer/renesas,cmt.yaml     |   2 +
 .../devicetree/bindings/timer/renesas,tmu.yaml     |   1 +
 .../devicetree/bindings/tpm/ibm,vtpm.yaml          |   4 +-
 .../devicetree/bindings/usb/mediatek,mtk-xhci.yaml |   1 +
 .../bindings/watchdog/aspeed,ast2400-wdt.yaml      | 142 ++++++++++++++++++
 .../devicetree/bindings/watchdog/aspeed-wdt.txt    |  73 ---------
 drivers/of/address.c                               | 113 +++++---------
 drivers/of/base.c                                  |  34 +----
 drivers/of/dynamic.c                               |  37 ++---
 drivers/of/module.c                                |   7 +-
 drivers/of/of_private.h                            |   1 +
 drivers/of/of_reserved_mem.c                       |  22 +--
 drivers/of/overlay.c                               |  11 +-
 drivers/of/property.c                              |  87 ++++++++---
 drivers/of/resolver.c                              |  35 ++---
 drivers/of/unittest.c                              |  12 +-
 include/linux/of_reserved_mem.h                    |   1 -
 99 files changed, 853 insertions(+), 588 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/atmel,lcdc-display.yaml
 delete mode 100644 Documentation/devicetree/bindings/display/atmel,lcdc.txt
 create mode 100644 Documentation/devicetree/bindings/display/atmel,lcdc.yaml
 delete mode 100644 Documentation/devicetree/bindings/display/exynos/exynos_dp.txt
 create mode 100644 Documentation/devicetree/bindings/display/samsung/samsung,exynos5-dp.yaml
 create mode 100644 Documentation/devicetree/bindings/watchdog/aspeed,ast2400-wdt.yaml
 delete mode 100644 Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt

