Return-Path: <linux-kernel+bounces-335115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F80797E125
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 13:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52BE11C2087C
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 11:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF90193094;
	Sun, 22 Sep 2024 11:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HUwgncnf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EC461FCF
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 11:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727004488; cv=none; b=LgGKeKFG+zXIaosNuV7/5FXStiOqVy2/ZcEBCVSZVu5IPz+kiRk9elgbCW816e0ETDluW2qZ2v74x+ivkoXkPb7P+CHwnboOKBAAmpur7GBaTiXXbafk/qho8OxvnKe5eD8+uTKg7Y3rcm2HWh1ltpTD0p++RFISGpXXWZclSTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727004488; c=relaxed/simple;
	bh=fnmfCtJOa+dLKyUhUiAMRD/7Tu1Z2ytRhWNlEzmdR7g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DvyUwxP8tjjiJiXViIs7f0PsYX9RSJpy/0jhfSDGR7fUQJJm3WVAAoL7H4oAVqiWIaHWagHql21J4Ya++IMde7V4n8sF3Atd2afdmnOX224YEIhhdrCdp5CuqEw1b0Oot697MnjuYL+QKC4/ZlfaqK+B2uyUpZ4IQWNKJDHT0iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HUwgncnf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6762C4CEC3;
	Sun, 22 Sep 2024 11:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727004488;
	bh=fnmfCtJOa+dLKyUhUiAMRD/7Tu1Z2ytRhWNlEzmdR7g=;
	h=Date:From:To:Cc:Subject:From;
	b=HUwgncnfZLM1lCB4cb/Bdu6aIW0n85q5SDO+u7d6A1Ov8lTdUP5TuNzzpkIotC7r2
	 xd9AUdXPZXfOB+H9go3qU0npXXcuQwLaa3xJ/dGuDKF/ycSzqybpRAS1/R+i0/xhXb
	 2uxrfke+YeP3MA+sH9JHIHSWM0DYcyiq/ka16VW312XGTdBvCDS7JOxwOItriNF+ZX
	 BMgKDCgloH7L8AwYlS0jUCMlLXHw0Eh7F6f8T43Tp9e8+GaBO7vtf1WvoKxsmM2QGA
	 0WAoJrXuntNhrjmvXB1HXIXee8dl/Lp3GPWcrVkOM4rQNneJ+V4JWaeeYCx8Ar75Ii
	 wli+D5XtloKnA==
Date: Sun, 22 Sep 2024 12:28:04 +0100
From: Vinod Koul <vkoul@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: Dmaengine subsystem updates for v6.12
Message-ID: <Zu//RAyNOZP1Zs+2@vaman>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hIflacAybTVCYR77"
Content-Disposition: inline


--hIflacAybTVCYR77
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Here is the dmaengine subsystem update for v6.12. This is a unique PR
that it has more new driver and device support than updates. Couple of
new device support, AMD, Rcar, Intel and New drivers in Freescale,
Loonsoon, AMD and LPC32XX with DT conversion and mode updates etc.

The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dm=
aengine-6.12-rc1

for you to fetch changes up to e0bee4bcdc3238ebcae6e5960544b9e3d0a62abf:

  dmaengine: loongson1-apb-dma: Fix the build warning caused by the size of=
 pdev_irqname (2024-09-02 13:56:32 +0530)

----------------------------------------------------------------
dmaengine updates for v6.12

 New support:
  - Support for AMD Versal Gen 2 DMA IP
  - Rcar RZ/G3S SoC dma controller
  - Support for Intel Diamond Rapids and Granite Rapids-D dma controllers
  - Support for Freescale ls1021a-qdma controller
  - New driver for Loongson-1 APB DMA
  - New driver for AMD QDMA
  - Pl08x in LPC32XX router dma driver

 Updates:
  - Support for dpdma cyclic dma mode
  - XML conversion for marvell xor dma bindings
  - Dma clocks documentation for imx dma

----------------------------------------------------------------
Abin Joseph (2):
      dt-bindings: dmaengine: zynqmp_dma: Add a new compatible string
      dmaengine: zynqmp_dma: Add support for AMD Versal Gen 2 DMA IP

Amit Vadhavana (1):
      dmaengine: Fix spelling mistakes

Arnd Bergmann (1):
      dmaengine: avoid non-constant format string

Chen Ni (1):
      dmaengine: idxd: Convert comma to semicolon

Christophe JAILLET (1):
      dma: ipu: Remove include/linux/dma/ipu-dma.h

Claudiu Beznea (1):
      dt-bindings: dma: rz-dmac: Document RZ/G3S SoC

Fabio Estevam (2):
      dt-bindings: dma: fsl,imx-dma: Document the DMA clocks
      dmaengine: imx-dma: Remove i.MX21 support

Fenghua Yu (2):
      dmaengine: idxd: Add a new DSA device ID for Granite Rapids-D platform
      dmaengine: idxd: Add new DSA and IAA device IDs for Diamond Rapids pl=
atform

Frank Li (2):
      dt-bindings: fsl-qdma: allow compatible string fallback to fsl,ls1021=
a-qdma
      dt-bindings: dma: fsl-mxs-dma: Add compatible string "fsl,imx8qxp-dma=
-apbh"

Joy Zou (2):
      dmaengine: fsl-edma: change to guard(mutex) within fsl_edma3_xlate()
      dmaengine: fsl-edma: add edma src ID check at request channel

Keguang Zhang (3):
      dt-bindings: dma: Add Loongson-1 APB DMA
      dmaengine: Loongson1: Add Loongson-1 APB DMA driver
      dmaengine: loongson1-apb-dma: Fix the build warning caused by the siz=
e of pdev_irqname

Nishad Saraf (1):
      dmaengine: amd: qdma: Add AMD QDMA driver

Piotr Wojtaszczyk (1):
      dmaengine: Add dma router for pl08x in LPC32XX SoC

Rohit Visavalia (1):
      dmaengine: xilinx: dpdma: Add support for cyclic dma mode

Shresth Prasad (1):
      dt-bindings: dma: mv-xor-v2: Convert to dtschema

Thorsten Blum (1):
      dmaengine: dmatest: Explicitly cast divisor to u32

Yue Haibing (1):
      dmaengine: ti: k3-udma: Remove unused declarations

 .../devicetree/bindings/dma/fsl,imx-dma.yaml       |   14 +
 .../devicetree/bindings/dma/fsl,mxs-dma.yaml       |   15 +
 .../devicetree/bindings/dma/fsl-qdma.yaml          |   13 +-
 .../bindings/dma/loongson,ls1b-apbdma.yaml         |   65 ++
 .../devicetree/bindings/dma/marvell,xor-v2.yaml    |   61 ++
 .../devicetree/bindings/dma/mv-xor-v2.txt          |   28 -
 .../devicetree/bindings/dma/renesas,rz-dmac.yaml   |    1 +
 .../bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml   |    4 +-
 MAINTAINERS                                        |    9 +
 arch/arm/mach-lpc32xx/Kconfig                      |    1 +
 drivers/dma/Kconfig                                |   20 +
 drivers/dma/Makefile                               |    3 +
 drivers/dma/acpi-dma.c                             |    4 +-
 drivers/dma/altera-msgdma.c                        |    4 +-
 drivers/dma/amba-pl08x.c                           |    2 +-
 drivers/dma/amd/Kconfig                            |   14 +
 drivers/dma/amd/Makefile                           |    3 +
 drivers/dma/amd/qdma/Makefile                      |    5 +
 drivers/dma/amd/qdma/qdma-comm-regs.c              |   64 ++
 drivers/dma/amd/qdma/qdma.c                        | 1143 ++++++++++++++++=
++++
 drivers/dma/amd/qdma/qdma.h                        |  266 +++++
 drivers/dma/at_hdmac.c                             |    6 +-
 drivers/dma/bcm-sba-raid.c                         |    4 +-
 drivers/dma/bcm2835-dma.c                          |    2 +-
 drivers/dma/dmaengine.c                            |    2 +-
 drivers/dma/dmatest.c                              |    2 +-
 drivers/dma/ep93xx_dma.c                           |    4 +-
 drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.h            |    6 +-
 drivers/dma/fsl-edma-main.c                        |   27 +-
 drivers/dma/hisi_dma.c                             |    2 +-
 drivers/dma/idma64.c                               |    4 +-
 drivers/dma/idxd/init.c                            |    6 +
 drivers/dma/idxd/perfmon.c                         |    4 +-
 drivers/dma/idxd/submit.c                          |    2 +-
 drivers/dma/imx-dma.c                              |    3 -
 drivers/dma/ioat/init.c                            |    2 +-
 drivers/dma/lgm/lgm-dma.c                          |    2 +-
 drivers/dma/loongson1-apb-dma.c                    |  660 +++++++++++
 drivers/dma/lpc32xx-dmamux.c                       |  195 ++++
 drivers/dma/ls2x-apb-dma.c                         |    4 +-
 drivers/dma/mediatek/mtk-cqdma.c                   |    4 +-
 drivers/dma/mediatek/mtk-hsdma.c                   |    2 +-
 drivers/dma/mv_xor.c                               |    4 +-
 drivers/dma/mv_xor.h                               |    2 +-
 drivers/dma/mv_xor_v2.c                            |    2 +-
 drivers/dma/nbpfaxi.c                              |    2 +-
 drivers/dma/of-dma.c                               |    4 +-
 drivers/dma/owl-dma.c                              |    2 +-
 drivers/dma/ppc4xx/adma.c                          |    2 +-
 drivers/dma/ppc4xx/dma.h                           |    2 +-
 drivers/dma/ptdma/ptdma.h                          |    2 +-
 drivers/dma/qcom/bam_dma.c                         |    4 +-
 drivers/dma/qcom/gpi.c                             |    2 +-
 drivers/dma/qcom/qcom_adm.c                        |    2 +-
 drivers/dma/sh/shdmac.c                            |    2 +-
 drivers/dma/ste_dma40.h                            |    2 +-
 drivers/dma/ste_dma40_ll.h                         |    2 +-
 drivers/dma/tegra20-apb-dma.c                      |    2 +-
 drivers/dma/ti/k3-udma.h                           |    1 -
 drivers/dma/xgene-dma.c                            |    2 +-
 drivers/dma/xilinx/xilinx_dpdma.c                  |  101 +-
 drivers/dma/xilinx/zynqmp_dma.c                    |   27 +-
 include/linux/dma/ipu-dma.h                        |  174 ---
 include/linux/dma/k3-udma-glue.h                   |    2 -
 include/linux/pci_ids.h                            |    3 +
 include/linux/platform_data/amd_qdma.h             |   36 +
 66 files changed, 2791 insertions(+), 275 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/loongson,ls1b-apb=
dma.yaml
 create mode 100644 Documentation/devicetree/bindings/dma/marvell,xor-v2.ya=
ml
 delete mode 100644 Documentation/devicetree/bindings/dma/mv-xor-v2.txt
 create mode 100644 drivers/dma/amd/Kconfig
 create mode 100644 drivers/dma/amd/Makefile
 create mode 100644 drivers/dma/amd/qdma/Makefile
 create mode 100644 drivers/dma/amd/qdma/qdma-comm-regs.c
 create mode 100644 drivers/dma/amd/qdma/qdma.c
 create mode 100644 drivers/dma/amd/qdma/qdma.h
 create mode 100644 drivers/dma/loongson1-apb-dma.c
 create mode 100644 drivers/dma/lpc32xx-dmamux.c
 delete mode 100644 include/linux/dma/ipu-dma.h
 create mode 100644 include/linux/platform_data/amd_qdma.h

--=20
~Vinod

--hIflacAybTVCYR77
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmbv/0QACgkQfBQHDyUj
g0dxkQ/8C55V0KHLzDxmV0o0rPYOC8cDK853s9l7xoSvRxxntlF0yJ9ppZFC7HfV
rwDKUHM3HSoD1ezNG1GUP8DGLrnCELFBOLEOx/uOvF1ygYOXz3yw3f+JyfrBeLP3
Uyen8byXoSoVOYinbjCERJ48FsRqOp348CvwtaK85tb39jjh72w1AYliBV5T0fI2
MkQcAYtPzRGHfPX8VI/iMtF0SFcF9D+IwSBoG90bBfaXTGCPXZ6fmcGhnou0hPLC
JdtWYgz5mADMyFpD9OgoPXHZ4eFIEwGeZK0okrw26zDe4GgfkjgHS8MdUmsC4oC2
q3+voqx09ToEs5Gcpr+L9ZL2yFCAW1a2IPIw0Iqd8lM9hQxf9g5QXeJqQkCFdoqc
knNJ+63JEOCmcyKlLUC3kS0fTG9LXwauw5cyXqm2Lh+K8cCB7Xbqgo0DeqScx879
eR0k/qe+webCP1UY5iHih708aLaGokpfKbI+/NkvAcUzswQkr4vaJIDO2d/kh3/V
BT9OP+XRjkGX9/Rq5Kso+sz/5t5zduQqZDHu3LeFU4RRQqNOWMqhbuTZodhtZPi9
aKcnC2RvEQ00qUSVDczIRuSh2vCgmuJmQHp43/Zjgbr/fdVXZcLbdkQ1FQxcEa+k
FTN61T0SoHhTPLH3TnsaAEHTT52VF9w3RlbvfjaAAfuFJOe73Ys=
=Alzr
-----END PGP SIGNATURE-----

--hIflacAybTVCYR77--

