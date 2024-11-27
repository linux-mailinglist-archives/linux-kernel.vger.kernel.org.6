Return-Path: <linux-kernel+bounces-423431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E3B9DA795
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 13:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46E01B26841
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 12:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E021F9F61;
	Wed, 27 Nov 2024 12:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oT7YzdLK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92351F7574
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 12:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732708862; cv=none; b=uVVF5Ta6QGqC3LoSUw2WGKLMIOVz15fjFhJsfn9JyHdW8L8mWMLeTABy56/4tmMg8OTOzspu7K9+qojqmOtqF5ZiiZKvXUNkeUQtkttuOS2JzRSKlAmjMPpu8RtetWyPim9y4aFAlKTwnVWE4bJ0r+bHIC6R+jmUoevtLOfv3N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732708862; c=relaxed/simple;
	bh=QgTKIAqViHE740Lf3Y3MqKvVBW1/N5ycfzY/xlxCf1c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DBCxeOf9AV8QjtaVvKWbGN+8BqaUi1hOaDDza2Jh5n9tIRzvoOSwT8LIUAJqROMHZzD3mkbKlHmm9eVyDU2fneNVN5AAf22aNzev/V3/nowz0eF0FDteEMeXnBhkMDS1gs+1xl3DT5Bh+pl6SUevFhg59nUfYYTTkNbEDEaF4kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oT7YzdLK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 102A8C4CECC;
	Wed, 27 Nov 2024 12:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732708861;
	bh=QgTKIAqViHE740Lf3Y3MqKvVBW1/N5ycfzY/xlxCf1c=;
	h=Date:From:To:Cc:Subject:From;
	b=oT7YzdLKiBCmcq44isSRSMKc5Uz1Hd7uw6Rg5vj7WvClxoVJYeRoFCm2axFTT2o3X
	 6903xnjLMB7JONzLiWwpiNpyc655og6t1OYL8ocAERtSkQsX1VNt3CSJxMkGC3/lR/
	 L9yofk4a+mMIQX8+K/K2k9Jsg939Q8Zj4IZknuQacqBwOQ9MjPZY/Z55U71xX6D6u4
	 Yw/hWY5p+wz7rCRXRV+82KL8AIFBwUd7BdnkJ3Kt3eaUBSgPRG/vD7EPtfeO3SfeAa
	 MB0DPd0YsOD+lbbNaQCVc5DTkZnyBt62YJ783JYL14b1lfXWnJi2sqGSmqfWdwPlEH
	 DB+OcfBdu5X5g==
Date: Wed, 27 Nov 2024 17:30:57 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: dmaengine subsystem updates for v6.13
Message-ID: <Z0cJ+c0vvFZIu7I4@vaman>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4DyqYUULOFqIf2SU"
Content-Disposition: inline


--4DyqYUULOFqIf2SU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Linus,

Please pull to receive the dmaengine subsystem updates for v6.13. This
includes couple of new device support and updates to bunch of drivers
including the platform_driver remove update.


The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:

  Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dm=
aengine-6.13-rc1

for you to fetch changes up to 8974f34de2ef173470a596a4dee22f4922583d1b:

  dmaengine: loongson2-apb: Rename the prefix ls2x to loongson2 (2024-10-23=
 11:05:45 +0530)

----------------------------------------------------------------
dmaengine updates for v6.13

 New support:
  - Qualcomm SAR2130P GPI dma support
  - Sifive PIC64GX pdma support
  - Rcar r7s72100 support and associated updates

 Updates:
  - STM32 DMA3 updates for packing/unpacking mode and prevention of
    additional xfers
  - Simplification of devm_acpi_dma_controller_register() and associate
    cleanup including headers
  - loongson prefix renames
  - Switch back to platform_driver::remove() subsystem update

----------------------------------------------------------------
Advait Dhamorikar (1):
      dmaengine: ep93xx: Fix unsigned compared against 0

Amelie Delaunay (6):
      dt-bindings: dma: stm32-dma3: prevent packing/unpacking mode
      dmaengine: stm32-dma3: prevent pack/unpack thanks to DT configuration
      dmaengine: stm32-dma3: refactor HW linked-list to optimize memory acc=
esses
      dt-bindings: dma: stm32-dma3: prevent additional transfers
      dmaengine: stm32-dma3: prevent LL refactoring thanks to DT configurat=
ion
      dmaengine: stm32-dma3: clamp AXI burst using match data

Andy Shevchenko (3):
      dmaengine: acpi: Drop unused devm_acpi_dma_controller_free()
      dmaengine: acpi: Simplify devm_acpi_dma_controller_register()
      dmaengine: acpi: Clean up headers

Binbin Zhou (1):
      dmaengine: loongson2-apb: Rename the prefix ls2x to loongson2

Dmitry Baryshkov (1):
      dt-bindings: dma: qcom,gpi: Add SAR2130P compatible

Fenghua Yu (1):
      dmaengine: idxd: Move DSA/IAA device IDs to IDXD driver

Pierre-Henry Moussay (1):
      dt-bindings: dma: sifive pdma: Add PIC64GX to compatibles

Uwe Kleine-K=F6nig (1):
      dmaengine: Switch back to struct platform_driver::remove()

Wolfram Sang (3):
      dmaengine: sh: rz-dmac: handle configs where one address is zero
      dt-bindings: dma: rz-dmac: Document RZ/A1H SoC
      dmaengine: sh: rz-dmac: add r7s72100 support

Yan Zhen (1):
      dmaengine: fix typo in the comment

 .../devicetree/bindings/dma/qcom,gpi.yaml          |   1 +
 .../devicetree/bindings/dma/renesas,rz-dmac.yaml   |  29 +++--
 .../bindings/dma/sifive,fu540-c000-pdma.yaml       |  15 ++-
 .../bindings/dma/stm32/st,stm32-dma3.yaml          |   6 +
 Documentation/driver-api/driver-model/devres.rst   |   1 -
 MAINTAINERS                                        |   4 +-
 arch/loongarch/configs/loongson3_defconfig         |   2 +-
 drivers/dma/Kconfig                                |  28 ++---
 drivers/dma/Makefile                               |   2 +-
 drivers/dma/acpi-dma.c                             |  43 ++------
 drivers/dma/altera-msgdma.c                        |   2 +-
 drivers/dma/amd/qdma/qdma.c                        |   2 +-
 drivers/dma/apple-admac.c                          |   2 +-
 drivers/dma/at_hdmac.c                             |   2 +-
 drivers/dma/at_xdmac.c                             |   2 +-
 drivers/dma/bcm-sba-raid.c                         |   2 +-
 drivers/dma/bcm2835-dma.c                          |   2 +-
 drivers/dma/bestcomm/bestcomm.c                    |   2 +-
 drivers/dma/dma-jz4780.c                           |   2 +-
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c     |   2 +-
 drivers/dma/dw/platform.c                          |   2 +-
 drivers/dma/ep93xx_dma.c                           |   3 +-
 drivers/dma/fsl-edma-main.c                        |   2 +-
 drivers/dma/fsl-qdma.c                             |   2 +-
 drivers/dma/fsl_raid.c                             |   2 +-
 drivers/dma/fsldma.c                               |   2 +-
 drivers/dma/idma64.c                               |   2 +-
 drivers/dma/idxd/registers.h                       |   4 +
 drivers/dma/img-mdc-dma.c                          |   2 +-
 drivers/dma/imx-dma.c                              |   2 +-
 drivers/dma/imx-sdma.c                             |   2 +-
 drivers/dma/k3dma.c                                |   2 +-
 .../dma/{ls2x-apb-dma.c =3D> loongson2-apb-dma.c}    |   6 +-
 drivers/dma/mcf-edma-main.c                        |   2 +-
 drivers/dma/mediatek/mtk-cqdma.c                   |   2 +-
 drivers/dma/mediatek/mtk-hsdma.c                   |   2 +-
 drivers/dma/mediatek/mtk-uart-apdma.c              |   2 +-
 drivers/dma/milbeaut-hdmac.c                       |   2 +-
 drivers/dma/milbeaut-xdmac.c                       |   2 +-
 drivers/dma/mmp_pdma.c                             |   2 +-
 drivers/dma/mmp_tdma.c                             |   2 +-
 drivers/dma/moxart-dma.c                           |   2 +-
 drivers/dma/mpc512x_dma.c                          |   2 +-
 drivers/dma/mv_xor_v2.c                            |   4 +-
 drivers/dma/nbpfaxi.c                              |   2 +-
 drivers/dma/owl-dma.c                              |   2 +-
 drivers/dma/ppc4xx/adma.c                          |   2 +-
 drivers/dma/pxa_dma.c                              |   2 +-
 drivers/dma/qcom/bam_dma.c                         |   2 +-
 drivers/dma/qcom/hidma.c                           |   2 +-
 drivers/dma/qcom/qcom_adm.c                        |   2 +-
 drivers/dma/sa11x0-dma.c                           |   2 +-
 drivers/dma/sf-pdma/sf-pdma.c                      |   4 +-
 drivers/dma/sh/Kconfig                             |   8 +-
 drivers/dma/sh/rcar-dmac.c                         |   2 +-
 drivers/dma/sh/rz-dmac.c                           |  29 ++---
 drivers/dma/sh/shdma-base.c                        |   2 +-
 drivers/dma/sh/shdmac.c                            |   2 +-
 drivers/dma/sh/usb-dmac.c                          |   4 +-
 drivers/dma/sprd-dma.c                             |   2 +-
 drivers/dma/st_fdma.c                              |   2 +-
 drivers/dma/stm32/stm32-dma3.c                     | 121 +++++++++++++++++=
----
 drivers/dma/sun4i-dma.c                            |   2 +-
 drivers/dma/sun6i-dma.c                            |   2 +-
 drivers/dma/tegra186-gpc-dma.c                     |   2 +-
 drivers/dma/tegra20-apb-dma.c                      |   2 +-
 drivers/dma/tegra210-adma.c                        |   2 +-
 drivers/dma/ti/cppi41.c                            |   2 +-
 drivers/dma/ti/edma.c                              |   2 +-
 drivers/dma/ti/omap-dma.c                          |   2 +-
 drivers/dma/timb_dma.c                             |   2 +-
 drivers/dma/txx9dmac.c                             |   4 +-
 drivers/dma/uniphier-mdmac.c                       |   2 +-
 drivers/dma/uniphier-xdmac.c                       |   2 +-
 drivers/dma/xgene-dma.c                            |   2 +-
 drivers/dma/xilinx/xdma.c                          |   2 +-
 drivers/dma/xilinx/xilinx_dma.c                    |   2 +-
 drivers/dma/xilinx/xilinx_dpdma.c                  |   2 +-
 drivers/dma/xilinx/zynqmp_dma.c                    |   4 +-
 include/linux/acpi_dma.h                           |   9 +-
 include/linux/pci_ids.h                            |   3 -
 81 files changed, 266 insertions(+), 184 deletions(-)
 rename drivers/dma/{ls2x-apb-dma.c =3D> loongson2-apb-dma.c} (99%)


--=20
~Vinod

--4DyqYUULOFqIf2SU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmdHCfYACgkQfBQHDyUj
g0frNBAAxEJd6NQcxht93fyO67HQKEFCA3jmGtGw2Lc52PG41ksFKbXfmAJ8REXP
/u/9c6XDr7Nk7Q3EBP4QnZ8WXsmxeI9X/t1vRJhB6hKxqQpQgEuq/o/QiTO97Odx
iKDjX7PcdsOHm8aN5Nj4GSoucmHOPU0OnLTsaGPP0L1aVykbb9xfB3rBG7aCmdII
+ZhsBzghsXRpu3ywBuEOVK6b6faozcoCIpyQiSHHLUYF4oxXh4e7eXAlCOVlzBF5
sW1WGFoAm8JP4YelrYqqHdcxd6+xL+A15YubcbE/esZELHj1vjA1i2I6gQXzfByc
pThdELEF80fcKxM2QtJ7EHC5LRB9ujNr7JANjfiDWqJL5NlxvzjFwqTotuopvlpX
bghKPU90ubOYCQ3DRdk24DTYtuVVql0SalwPEX5PpfNh74N3maUAErxl6T0CcYjW
rtVisHHRu+SuMi/M4CcRPzNvTQvd3bAL3E02BS6Wbf3I5KpZ/+swyLu6EMAmvGDr
CRJKghLSWwIkvksancIvKgS7fLmfdMllstvPQkN6lTzwK5nTWo9njzE36j7RZoBB
yI2E/uvlIlzFwW7COOb2K78A7HnypFhX/Fwgy6S0y//Y1BvtWw0BpBpyb0OL+yCJ
ELmLpOiik2FJjUNJDFdAGxTlgm1OQAJ3C48eQpMrZgprP6wn7xI=
=8ChM
-----END PGP SIGNATURE-----

--4DyqYUULOFqIf2SU--

