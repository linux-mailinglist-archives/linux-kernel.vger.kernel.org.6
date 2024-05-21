Return-Path: <linux-kernel+bounces-184581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CF18CA91B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 09:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8E081C20E58
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 07:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC32953E36;
	Tue, 21 May 2024 07:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HUjJx1fz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD29953803
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 07:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716277155; cv=none; b=mL/zczqH1Qj6gaab26xDT6m5ybGobMY9uWBdq/ROl6s0Ibk/FFVegGEzr5GiuNJOxvLPw5d0qE2Vgud9fIPxkQ81WDY7H6AMJ9j90auHiDpKRIR+8TKpnjIfOJ+O6J+nNuJglWTfdWXL2vcagLcAawysc3m7FVKSH/+f7jxpTSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716277155; c=relaxed/simple;
	bh=BAvchBc11g9RHf4G55COUG3ktCoLqYPPemiriQJWUqc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZugSv5gx0Y9W9G8jqRxXaDY/QIPn+BmbT++JG5K85rnppJidkjL67hbyeQAJOw3WSrhWzcIJtaUGJIGJKYKpsgqbYz/0k1yk6wjMfPARIK084+PHiWKRR2zC76HCNdkzAO5MzEj0qI6Lr1jgtLAhuy6e5iuBNsNt5JHQi37gF18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HUjJx1fz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2901C2BD11;
	Tue, 21 May 2024 07:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716277155;
	bh=BAvchBc11g9RHf4G55COUG3ktCoLqYPPemiriQJWUqc=;
	h=Date:From:To:Cc:Subject:From;
	b=HUjJx1fzNOsLZA2p199QBBPr1HG63bGIalaraPYNe8dKv1SltjhlHNJKhyKpsRAy/
	 Xqb3MPk25UsOuPpPCnj8Kb+I39H9Nz3SL/j67bb8QBx5soQFvmxryA1QNJTAVY1IbL
	 JOa0ovVx0dzrsmW7qqwlj4dQZi6m3ftD42IMcAFrC5lpaxGLD7sk2s4YLnTd3gCLV6
	 xj3yDI+our7kV7zmOHO3YVZM2cqXU8YzmqYdCpIwfiqGAatYwpHrAXbOGDYa0UYxNz
	 hYzG4G7L7AAJ8WfqVe1oKhM4H20ToHHP0NmHi2+ikhrD0rYA+bK3rQRQ2byr+2GnCV
	 4kpeHNpBI/p/w==
Date: Tue, 21 May 2024 13:09:11 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: Generic phy updates for v6.10-rc1
Message-ID: <ZkxPn_tmkPzo_T5c@matsya>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rzQ1H1V9ZitWmQqM"
Content-Disposition: inline


--rzQ1H1V9ZitWmQqM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Linus,

Here is the set for Generic phy subsystem. This features new Embedded
DisplayPort and DisplayPort submodes support, along with bunch of
devices and a new driver along with updates to drivers.
I had to merge fixes branch into next to resolve dependencies for
incoming patches so this request is based on phy-fixes already merged by
you.

The following changes since commit 47b3e2f3914ae5e8d9025d65ae5cffcbb54bc9c3:

  phy: qcom: m31: match requested regulator name with dt schema (2024-04-07=
 12:49:42 +0530)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-=
for-6.10

for you to fetch changes up to 960b3f023d3bda0efd6e573a0647227d1115d266:

  dt-bindings: phy: qcom,usb-snps-femto-v2: use correct fallback for sc8180=
x (2024-05-04 17:48:05 +0530)

----------------------------------------------------------------
phy-for-6.10

- New Support
  - Support for Embedded DisplayPort and DisplayPort submodes and driver
    support on Qualcomm X1E80100 edp driver
  - Qualcomm QMP UFS PHY for SM8475, QMP USB phy for QDU1000/QRU1000 and
    eusb2-repeater for SMB2360
  - Samsung HDMI PHY for i.MX8MP, gs101 UFS phy
  - Mediatek XFI T-PHY support for mt7988
  - Rockchip usbdp combo phy driver

- Updates
  - Qualcomm x4 lane EP support for sa8775p, v4 ad v6 support for X1E80100,
    SM8650 tables for UFS Gear 4 & 5 and correct voltage swing tables
  - Freescale imx8m-pci pcie link-up updates
  - Rockchip rx-common-refclk-mode support
  - More platform remove callback returning void conversions

----------------------------------------------------------------
Abel Vesa (7):
      phy: Add Embedded DisplayPort and DisplayPort submodes
      phy: qcom: edp: Add set_mode op for configuring eDP/DP submode
      dt-bindings: phy: qcom,snps-eusb2-repeater: Add compatible for SMB2360
      phy: qualcomm: phy-qcom-eusb2-repeater: Add support for SMB2360
      dt-bindings: phy: qcom-edp: Add X1E80100 PHY compatibles
      phy: qcom: edp: Move v4 specific settings to version ops
      phy: qcom: edp: Add v6 specific ops and X1E80100 platform support

Arnd Bergmann (1):
      phy: rockchip: fix CONFIG_TYPEC dependency

Daniel Golle (2):
      dt-bindings: phy: mediatek,mt7988-xfi-tphy: add new bindings
      phy: add driver for MediaTek XFI T-PHY

Danila Tikhonov (3):
      dt-bindings: phy: Add QMP UFS PHY comptible for SM8475
      phy: qcom-qmp-ufs: Add SM8475 support
      dt-bindings: phy: qmp-ufs: Fix PHY clocks for SC7180

Dmitry Baryshkov (3):
      dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: fix x1e80100-gen3x2 sch=
ema
      dt-bindings: phy: qcom,sc8280xp-qmp-ufs-phy: fix msm899[68] power-dom=
ains
      dt-bindings: phy: qcom,usb-snps-femto-v2: use correct fallback for sc=
8180x

Komal Bajaj (3):
      dt-bindings: phy: qcom,usb-snps-femto-v2: Add bindings for QDU1000
      dt-bindings: phy: qcom,qmp-usb: Add QDU1000 USB3 PHY
      phy: qcpm-qmp-usb: Add support for QDU1000/QRU1000

Lucas Stach (2):
      dt-bindings: phy: add binding for the i.MX8MP HDMI PHY
      phy: freescale: add Samsung HDMI PHY

Mrinmay Sarkar (1):
      phy: qcom-qmp-pcie: add x4 lane EP support for sa8775p

Neil Armstrong (7):
      phy: qcom: qmp-combo: fix duplicate return in qmp_v4_configure_dp_phy
      phy: qcom: qmp-combo: fix sm8650 voltage swing table
      dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: document PHY AUX clock =
on SM8[456]50 SoCs
      phy: qcom: qmp-pcie: refactor clock register code
      phy: qcom: qmp-pcie: register second optional PHY AUX clock
      phy: qcom: qmp-pcie: register PHY AUX clock for SM8[456]50 4x2 PCIe P=
HY
      phy: qcom: qmp-ufs: update SM8650 tables for Gear 4 & 5

Niklas Cassel (2):
      dt-bindings: phy: rockchip,pcie3-phy: add rockchip,rx-common-refclk-m=
ode
      phy: rockchip-snps-pcie3: add support for rockchip,rx-common-refclk-m=
ode

Peter Griffin (7):
      dt-bindings: phy: samsung,ufs-phy: Add dedicated gs101-ufs-phy compat=
ible
      phy: samsung-ufs: use exynos_get_pmu_regmap_by_phandle() to obtain PM=
U regmap
      phy: samsung-ufs: ufs: Add SoC callbacks for calibration and clk data=
 recovery
      phy: samsung-ufs: ufs: Add support for gs101 UFS phy tuning
      MAINTAINERS: Add phy-gs101-ufs file to Tensor GS101.
      phy: samsung-ufs: ufs: remove superfluous mfd/syscon.h header
      phy: samsung-ufs: ufs: exit on first reported error

Ricardo B. Marliere (1):
      phy: core: make phy_class constant

Rick Wertenbroek (1):
      phy: rockchip: Fix typo in function names

Sebastian Reichel (3):
      dt-bindings: phy: add rockchip usbdp combo phy document
      phy: rockchip: add usbdp combo phy driver
      phy: rockchip: usbdp: fix uninitialized variable

Uwe Kleine-K=F6nig (2):
      phy: xilinx: Convert to platform remove callback returning void
      phy: freescale: fsl-samsung-hdmi: Convert to platform remove callback=
 returning void

Vinod Koul (2):
      Merge tag 'phy_dp_modes_6.10' into next
      Merge branch 'fixes' into next

 .../bindings/phy/fsl,imx8mp-hdmi-phy.yaml          |   62 +
 .../bindings/phy/mediatek,mt7988-xfi-tphy.yaml     |   80 +
 .../bindings/phy/phy-rockchip-usbdp.yaml           |  148 ++
 .../devicetree/bindings/phy/qcom,edp-phy.yaml      |    1 +
 .../bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml   |   28 +-
 .../bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml    |   19 +-
 .../phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml        |    2 +
 .../bindings/phy/qcom,snps-eusb2-repeater.yaml     |    4 +-
 .../bindings/phy/qcom,usb-snps-femto-v2.yaml       |    5 +-
 .../bindings/phy/rockchip,pcie3-phy.yaml           |   10 +
 .../devicetree/bindings/phy/samsung,ufs-phy.yaml   |    1 +
 MAINTAINERS                                        |    2 +
 drivers/phy/freescale/Kconfig                      |    6 +
 drivers/phy/freescale/Makefile                     |    1 +
 drivers/phy/freescale/phy-fsl-samsung-hdmi.c       |  718 +++++++++
 drivers/phy/mediatek/Kconfig                       |   11 +
 drivers/phy/mediatek/Makefile                      |    1 +
 drivers/phy/mediatek/phy-mtk-xfi-tphy.c            |  451 ++++++
 drivers/phy/phy-core.c                             |   26 +-
 drivers/phy/qualcomm/phy-qcom-edp.c                |  419 ++++-
 drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c     |   17 +
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c          |   56 +-
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c           |  109 +-
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h     |    4 +
 .../qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h    |    6 +
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c            |  144 +-
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c            |   47 +
 drivers/phy/rockchip/Kconfig                       |   12 +
 drivers/phy/rockchip/Makefile                      |    1 +
 drivers/phy/rockchip/phy-rockchip-naneng-combphy.c |    4 +-
 drivers/phy/rockchip/phy-rockchip-snps-pcie3.c     |   49 +-
 drivers/phy/rockchip/phy-rockchip-usbdp.c          | 1608 ++++++++++++++++=
++++
 drivers/phy/samsung/Makefile                       |    1 +
 drivers/phy/samsung/phy-exynos7-ufs.c              |    1 +
 drivers/phy/samsung/phy-exynosautov9-ufs.c         |    1 +
 drivers/phy/samsung/phy-fsd-ufs.c                  |    1 +
 drivers/phy/samsung/phy-gs101-ufs.c                |  182 +++
 drivers/phy/samsung/phy-samsung-ufs.c              |   28 +-
 drivers/phy/samsung/phy-samsung-ufs.h              |    6 +
 drivers/phy/xilinx/phy-zynqmp.c                    |    6 +-
 include/dt-bindings/phy/phy-qcom-qmp.h             |    4 +
 include/linux/phy/phy-dp.h                         |    3 +
 42 files changed, 4147 insertions(+), 138 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/fsl,imx8mp-hdmi-p=
hy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/mediatek,mt7988-x=
fi-tphy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/phy-rockchip-usbd=
p.yaml
 create mode 100644 drivers/phy/freescale/phy-fsl-samsung-hdmi.c
 create mode 100644 drivers/phy/mediatek/phy-mtk-xfi-tphy.c
 create mode 100644 drivers/phy/rockchip/phy-rockchip-usbdp.c
 create mode 100644 drivers/phy/samsung/phy-gs101-ufs.c


--=20
~Vinod

--rzQ1H1V9ZitWmQqM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmZMT54ACgkQfBQHDyUj
g0fhwBAAwo43xly+YLi9n8HJ8Y7rKItq0ppmTRU/SlIzsFrDseXiZdvfYU/BStLh
4SoOHM8UcOJwFzUIosOgtVQ/MWqm1Si4X0L/Ygn0SMpX1iD4umeYbT2dukfDTgWt
m8HspTc5DLHZNmlN3gOlZal5kYKIiBe4JL/0iugAViDiOSfcal84ky1oKDYaqU4T
UxqCXa6h0st2qZs4i1cKo8hCtdmUuRLpbG4hAbjFeztItI4bFvW8lQH4+GbtJI/M
wWfdXvTl7AQyu2DI0SkJAX8XCqySGjZhhRMRyDBEQktIoVYDZhUHugf3ltEDnxt+
juiyUGSfKVgLDqo8u9waS+yJwk+yQwb5TN5VJ6P+USqPdUP5aOdWALlMfL0lw2XJ
vS1LOYprIKB2lON59dO8Q9MldQ5UWx6xiruj8PYoXSD9p/MOlHMkOsiCMy6oO5Sg
9/y3fUFjZSaLtPS1htkkrFKylakFd9ZQwS2PRaM0afJzXuiM5ts7kJ3ZWx2tC3Wa
L0BpzaE6fT0Ndynyf8iGKZynIVQt+U9tcQGPcIxNMnQjownPgySgXndt82vQ4QxW
jOCYF/l6/2mjzkt6GQu5QGc+8GAAwv/1tusKPTyQ6E/wed+j59hp3/scw4JGko1o
zGEn97xzAU308m4H/c0fyb5o0co9QYV4mvnsiYIQ8as/++QKWMg=
=fTVU
-----END PGP SIGNATURE-----

--rzQ1H1V9ZitWmQqM--

