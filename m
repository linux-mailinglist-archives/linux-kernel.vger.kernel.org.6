Return-Path: <linux-kernel+bounces-260721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5ED93AD64
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 09:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F33B81F22B28
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 07:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1490367A0D;
	Wed, 24 Jul 2024 07:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n7i7gbCh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D9146B91
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 07:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721807282; cv=none; b=Qh6MMz0hjeldczC7MncQp+I1Fs68N6eyDVSHT0nPJuV7Kblzy2R6Dfpnqmm7PE0qHBiPbZLmmf8lLDStewtVdvJsS/jTLkdy50MlxqPQ3K/6zAjXVcdZ0dkWdTjlpH94ev9V6qxTljQamPAESWMhN7u29buicDKkCZe9N2YIN74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721807282; c=relaxed/simple;
	bh=NWk18YD1yHmT+BnSekISX+R8kie7bq0GHyfCDkXXFuk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=P+4sxQMgnPMs0YtkkBRDjtdosqBI/zj/LFcd9zQN36z7owGRe0lz4gZlW/shnP7zvJOtvwcBxTLeG39INFPZCHDxIFrg8RJnpDXzSDijRMexByYq4hoPXkUbCN7qDjejWHnyr5iE2/8OWDLFc7SoeS45ZfIsfWdtNutTVVHps9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n7i7gbCh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45D8EC32782;
	Wed, 24 Jul 2024 07:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721807282;
	bh=NWk18YD1yHmT+BnSekISX+R8kie7bq0GHyfCDkXXFuk=;
	h=Date:From:To:Cc:Subject:From;
	b=n7i7gbCh4T+LQITrlkIKDPiB4Pk2t5lovEfjZ1CeMVgfDVl6tsHILUt8+nZL0qBnM
	 hBLMcXPexo9Pd8n1/WKMbQfgowx0qyKKDG25rHyWw3I4vRYlV1bkyk+UaBp9AUcMYS
	 Pmz7A2COk7pw8T1G6Zm//BF8zDvqgGcTULWwqWcukw73XnnTf6lH6tj6X3JaLoW5RX
	 As3IYfdfTef2Tfj2q/3VbHxqZq5QDuFBksmdKranZwXP+DngPgaE2uffelBwHnSgOo
	 bPJnsbrtFvklBkyDmjB+cX5NGq01rzMYMfqTEUhlMjkuCMv2mlYgat9Hz8r/Aj8EsX
	 xzi+a7BLWe+OQ==
Date: Wed, 24 Jul 2024 13:17:57 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: Generic phy updates for v6.11
Message-ID: <ZqCxra3XNXK7WbOb@matsya>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="k1mDpk1/Cp1/jO8V"
Content-Disposition: inline


--k1mDpk1/Cp1/jO8V
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello again,

Second request for generic phy subsystem feature bunch of new driver and
device support and updates to few of the drivers

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-=
for-6.11

for you to fetch changes up to 2a011c3c12e8de461fb1fdce85fa38d308c4eb8b:

  phy: airoha: Add dtime and Rx AEQ IO registers (2024-07-02 18:54:28 +0530)

----------------------------------------------------------------
phy-for-6.11

- New Support
  - Samsung Exynos gs101 drd combo phy
  - Qualcomm SC8180x USB uniphy, IPQ9574 QMP PCIe phy
  - Airoha EN7581 PCIe phy
  - Freescale i.MX8Q HSIO SerDes phy
  - Starfive jh7110 dphy tx

- Updates
  - Resume support for j721e-wiz driver
  - Updates to Exynos usbdrd driver
  - Support for optional power domains in g12a usb2-phy driver
  - Debugfs support and updates to zynqmp driver

----------------------------------------------------------------
Andr=E9 Draszik (11):
      phy: exynos5-usbdrd: uniform order of register bit macros
      phy: exynos5-usbdrd: convert udelay() to fsleep()
      phy: exynos5-usbdrd: make phy_isol() take a bool for clarity
      phy: exynos5-usbdrd: fix definition of EXYNOS5_FSEL_26MHZ
      phy: exynos5-usbdrd: set ref clk freq in exynos850_usbdrd_utmi_init()
      dt-bindings: phy: samsung,usb3-drd-phy: add gs101 compatible
      phy: exynos5-usbdrd: support isolating HS and SS ports independently
      phy: exynos5-usbdrd: convert core clocks to clk_bulk
      phy: exynos5-usbdrd: convert (phy) register access clock to clk_bulk
      phy: exynos5-usbdrd: convert Vbus supplies to regulator_bulk
      phy: exynos5-usbdrd: support Exynos USBDRD 3.1 combo phy (HS & SS)

Bjorn Andersson (2):
      dt-bindings: phy: qcom,sc8280xp-qmp-usb3-uni: Add sc8180x USB3 compat=
ible
      phy: qcom-qmp-usb: Add sc8180x USB UNIPHY

Changhuang Liang (1):
      phy: starfive: Correct the dphy configure process

Cristian Ciocaltea (1):
      phy: phy-rockchip-samsung-hdptx: Select CONFIG_MFD_SYSCON

Dmitry Baryshkov (2):
      phy: qcom: qmp-pcie: restore compatibility with existing DTs
      dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: drop second output cloc=
k name

Dr. David Alan Gilbert (2):
      phy: starfive: remove unused struct 'regval'
      phy: miphy28lp: remove unused struct 'miphy_initval'

Herman van Hazendonk (1):
      dt-bindings: phy: qcom,usb-hs-phy: Add compatible

Jan Kiszka (1):
      phy: ti: am654-serdes: Remove duplicate define

Jeff Johnson (1):
      phy: broadcom: add missing MODULE_DESCRIPTION() macros

Josua Mayer (1):
      dt-bindings: phy: armada-cp110-utmi: add optional swap-dx-lanes prope=
rty

Liu Jing (1):
      phy: Fix the cacography in phy-exynos5250-usb2.c

Lorenzo Bianconi (4):
      dt-bindings: phy: airoha: Add PCIe PHY controller
      phy: airoha: Add PCIe PHY driver for EN7581 SoC.
      dt-bindings: phy: airoha: Add dtime and Rx AEQ IO registers
      phy: airoha: Add dtime and Rx AEQ IO registers

Ma Ke (1):
      phy: cadence-torrent: Check return value on register read

Miaoqian Lin (1):
      phy: core: Fix documentation of of_phy_get

Nathan Chancellor (1):
      phy: freescale: imx8qm-hsio: Include bitfield.h for FIELD_PREP

Neil Armstrong (1):
      dt-bindings: phy: g12a-usb2-phy: add optional power-domains

Richard Zhu (2):
      dt-bindings: phy: Add i.MX8Q HSIO SerDes PHY binding
      phy: freescale: imx8qm-hsio: Add i.MX8QM HSIO PHY driver support

Sean Anderson (5):
      phy: zynqmp: Enable reference clock correctly
      phy: zynqmp: Store instance instead of type
      phy: zynqmp: Only wait for PLL lock "primary" instances
      phy: zynqmp: Take the phy mutex in xlate
      phy: zynqmp: Add debugfs support

Shengyang Chen (2):
      dt-bindings: phy: Add starfive,jh7110-dphy-tx
      phy: starfive: Add mipi dphy tx support

Shresth Prasad (1):
      dt-bindings: phy: rockchip-emmc-phy: Convert to dtschema

Swapnil Jakhade (1):
      phy: cadence-torrent: Add SGMII + QSGMII multilink configuration for =
100MHz refclk

Thomas Richard (8):
      phy: ti: phy-j721e-wiz: use dev_err_probe() instead of dev_err()
      phy: ti: phy-j721e-wiz: split wiz_clock_init() function
      phy: ti: phy-j721e-wiz: add resume support
      phy: cadence-torrent: extract calls to clk_get from cdns_torrent_clk
      phy: cadence-torrent: register resets even if the phy is already conf=
igured
      phy: cadence-torrent: add already_configured to struct cdns_torrent_p=
hy
      phy: cadence-torrent: remove noop_ops phy operations
      phy: cadence-torrent: add suspend and resume support

Yijie Yang (1):
      dt-bindings: phy: qcom,qmp-usb: fix spelling error

devi priya (4):
      dt-bindings: phy: qcom,ipq8074-qmp-pcie: Document the IPQ9574 QMP PCI=
e PHYs
      phy: qcom-qmp: Add missing offsets for Qserdes PLL registers.
      phy: qcom-qmp: Add missing register definitions for PCS V5
      phy: qcom-qmp-pcie: Add support for IPQ9574 g3x1 and g3x2 PCIEs

 .../bindings/phy/airoha,en7581-pcie-phy.yaml       |   69 ++
 .../bindings/phy/amlogic,g12a-usb2-phy.yaml        |    3 +
 .../devicetree/bindings/phy/fsl,imx8qm-hsio.yaml   |  164 +++
 .../phy/marvell,armada-cp110-utmi-phy.yaml         |    6 +
 .../bindings/phy/qcom,ipq8074-qmp-pcie-phy.yaml    |    2 +
 .../bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml   |    7 +-
 .../phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml        |    5 +-
 .../devicetree/bindings/phy/qcom,usb-hs-phy.yaml   |    2 +
 .../bindings/phy/rockchip,rk3399-emmc-phy.yaml     |   64 +
 .../devicetree/bindings/phy/rockchip-emmc-phy.txt  |   43 -
 .../bindings/phy/samsung,usb3-drd-phy.yaml         |   77 +-
 .../bindings/phy/starfive,jh7110-dphy-tx.yaml      |   68 ++
 .../devicetree/bindings/soc/rockchip/grf.yaml      |   16 +-
 MAINTAINERS                                        |   15 +
 drivers/phy/Kconfig                                |   10 +
 drivers/phy/Makefile                               |    1 +
 drivers/phy/broadcom/phy-bcm-ns-usb2.c             |    1 +
 drivers/phy/broadcom/phy-bcm-ns-usb3.c             |    1 +
 drivers/phy/cadence/phy-cadence-torrent.c          |  207 +++-
 drivers/phy/freescale/Kconfig                      |    9 +-
 drivers/phy/freescale/Makefile                     |    1 +
 drivers/phy/freescale/phy-fsl-imx8qm-hsio.c        |  611 ++++++++++
 drivers/phy/phy-airoha-pcie-regs.h                 |  494 ++++++++
 drivers/phy/phy-airoha-pcie.c                      | 1286 ++++++++++++++++=
++++
 drivers/phy/phy-core.c                             |    2 +-
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c           |  318 ++++-
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5.h    |   14 +
 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-pll.h    |    3 +
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c            |    3 +
 drivers/phy/rockchip/Kconfig                       |    2 +
 drivers/phy/samsung/phy-exynos5-usbdrd.c           | 1053 +++++++++++++---
 drivers/phy/samsung/phy-exynos5250-usb2.c          |    2 +-
 drivers/phy/st/phy-miphy28lp.c                     |    5 -
 drivers/phy/starfive/Kconfig                       |   10 +
 drivers/phy/starfive/Makefile                      |    1 +
 drivers/phy/starfive/phy-jh7110-dphy-rx.c          |    5 -
 drivers/phy/starfive/phy-jh7110-dphy-tx.c          |  461 +++++++
 drivers/phy/ti/phy-am654-serdes.c                  |    1 -
 drivers/phy/ti/phy-j721e-wiz.c                     |  133 +-
 drivers/phy/xilinx/phy-zynqmp.c                    |  198 +--
 include/linux/soc/samsung/exynos-regs-pmu.h        |    4 +
 41 files changed, 4925 insertions(+), 452 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/airoha,en7581-pci=
e-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/fsl,imx8qm-hsio.y=
aml
 create mode 100644 Documentation/devicetree/bindings/phy/rockchip,rk3399-e=
mmc-phy.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/rockchip-emmc-phy=
=2Etxt
 create mode 100644 Documentation/devicetree/bindings/phy/starfive,jh7110-d=
phy-tx.yaml
 create mode 100644 drivers/phy/freescale/phy-fsl-imx8qm-hsio.c
 create mode 100644 drivers/phy/phy-airoha-pcie-regs.h
 create mode 100644 drivers/phy/phy-airoha-pcie.c
 create mode 100644 drivers/phy/starfive/phy-jh7110-dphy-tx.c
--=20
~Vinod

--k1mDpk1/Cp1/jO8V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmagsa0ACgkQfBQHDyUj
g0c6CRAAtQmq0V694Gjzep/QAJFiEUgi3z01ypJy0Tp6RYRQqRVZL38bURd/uF1I
NCnF4nEXv/N6tpbjNMesAtMc/CeKXPmB2JwvaMMfM69Nbj9jAaJCq0U7rpU5FA3y
e2YtrdT/vm4MFLYlTDqWkqnb5IsQe851nEq7ghxDKX4Ak36AyGRMlUmChIV1WudX
A/6QiZphunWgYdHtVRBAmRZnzWthQAgxPDUpybyMjPWQwx8NLt1tE2/mGfMvdZoJ
r++vykW4gm0/0VdTkZREop8CuD8azFVg8WoxbifSZ+tXbg5vrXNSA5fYRwLuhe1A
a+/5pNPtQYWGiDtIhj73+Xb2YsExUATPGNkutvNLNy3Lw2xZpN77fCJYO/KFERj7
QCo9FTG5YiMVQEPVawktdnad1Oyx4rsZwjLrXoD+yl1o9x/pUhGvC3Gz10yUHA5c
Cycvvbr54mUdWcTIbYmwAr0S2WS7xJCjjg2/AIgajv9pm+Ysn3URJy6mx15X2vh4
RQZdrEEGmbfY3XtNgLezZYfd2q0Sx8bVIJ5oTsZ/YG7oLektTfvPMMZlcQP8NhOj
asPE8eNU9tRJM5fmpwyPHqrLQMWri0sAOH9V9pg0RoVkHTR+dc4qF1du5//Kg/Sj
KNyP5KwiQ5hukIDbG8Cnqg58SRvKMunHsVLibkVoQqF79Jce3HI=
=30MT
-----END PGP SIGNATURE-----

--k1mDpk1/Cp1/jO8V--

