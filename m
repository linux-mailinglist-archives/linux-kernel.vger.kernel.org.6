Return-Path: <linux-kernel+bounces-335111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D40B597E11F
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 13:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92FA3280FD9
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 11:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54FC193406;
	Sun, 22 Sep 2024 11:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpjFI76P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6CC3B7AC
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 11:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727004298; cv=none; b=b8DV7OaZMzwy6yDjAItk4OMD6u6T8Eausw8R+p1ohtgGzdw1oV/DYcafR8k5VHPiczCOnw+rSK9jabjPAzsGLAMHbeOnnQBtdiK1vwR2sYOD9LWPXO/HUeb1ypj06myHghEewuKLyfvHxob6EifgwTnSI2kc5aVAU+ahN/XL01I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727004298; c=relaxed/simple;
	bh=RXXBe3tojMptUTvPCvgBInSTUAyo7mAMUkWvXYruN5c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kig3yNIaHCJ9VLApaoyyvp7Z44D2XLLsH0biaBNXBVZg+2FLmZonY4IdBWzXDFY8wgEXN398zijwxXgExfRl+ZKBR1zboZ1bq74CMKiHMzKWT3FENVAZlwfErZRzLfhC3///lnk83BhaLyFXaW+lrWftVCa6pH3lVQIB6hAiwEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpjFI76P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB233C4CEC3;
	Sun, 22 Sep 2024 11:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727004298;
	bh=RXXBe3tojMptUTvPCvgBInSTUAyo7mAMUkWvXYruN5c=;
	h=Date:From:To:Cc:Subject:From;
	b=fpjFI76PIroyfYGepfdPcZxBfv55eMaE7FS19R0+/KsXNfAMeGAsB1OcXP4WR04KS
	 E5qDgVVB6bbL2qFM+OdNDCjyltTZ0AuDifHOjziitTTm7exr+YMInbPueIJm4eKBTn
	 dwsZJZQi5whfLTE4WKi12CUHq04dUN1J/CTo8svHJUrgTjd3MFs5aS8cUqwv3zsGWk
	 KN6KhbO5OHO+gdtuhHoqRkMCYiL3OJT108f0sdlXTGaua5jBaWcM4ucIzGh7F443dE
	 G0HhjEZ4IB5fWkG+u/sVaOJZX2eQ/exYa1Vo0efa4H3I4XMJ+LVjEhZ3VXeP0od2ao
	 616cEfGVHJorQ==
Date: Sun, 22 Sep 2024 12:24:54 +0100
From: Vinod Koul <vkoul@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: Generic phy subsystem updates for v6.12
Message-ID: <Zu/+ht+m/BeAh17u@vaman>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KieMfyFo6wVilUZP"
Content-Disposition: inline


--KieMfyFo6wVilUZP
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Here is the Generic phy update for this cycle. Please pull to receive
the updates with couple of new device/driver support, one removal and
bunch of updates to various driver

The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-=
for-6.12

for you to fetch changes up to 3c2ea12a625dbf5a864f4920235fa1c739d06e7d:

  phy: renesas: rcar-gen3-usb2: Add support for the RZ/G3S SoC (2024-08-30 =
13:33:44 +0530)

----------------------------------------------------------------
phy-for-6.12

- New Support
  - Rcar usb2 support for RZ/G3S SoC
  - Nuvoton MA35 SoC USB 2.0 PHY driver

- Removal
  - obsolete qcom,usb-8x16-phy bindings

- Updates
  - 4 lane PCIe support for Qualcomm X1E80100
  - Constify structure in subsystem update
  - Subsystem simplification with scoped for each OF child loop update
  - Yaml conversion for Qualcomm sata phy, Hiilicon hi3798cv200-combphy
    bindings

----------------------------------------------------------------
Abel Vesa (2):
      dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Document the X1E80100 Q=
MP PCIe PHY Gen4 x4
      phy: qcom: qmp-pcie: Add Gen4 4-lanes mode for X1E80100

Andr=E9 Draszik (1):
      phy: exynos5-usbdrd: convert some FIELD_PREP_CONST() to FIELD_PREP()

Chen Ni (1):
      phy: ti: phy-j721e-wiz: convert comma to semicolon

Christophe JAILLET (7):
      phy: cadence-torrent: Constify struct cdns_reg_pairs
      phy: cadence-torrent: Constify struct cdns_torrent_vals_entry
      phy: cadence-torrent: Constify struct cdns_torrent_vals
      phy: cadence-torrent: Constify a u32[]
      phy: cadence: Sierra: Constify struct cdns_reg_pairs
      phy: cadence: Sierra: Constify struct cdns_sierra_vals
      phy: cadence: Sierra: Constify a u32[]

Claudiu Beznea (3):
      phy: renesas: rcar-gen3-usb2: Add support to initialize the bus
      dt-bindings: phy: renesas,usb2-phy: Document RZ/G3S phy bindings
      phy: renesas: rcar-gen3-usb2: Add support for the RZ/G3S SoC

Cristian Ciocaltea (4):
      phy: phy-rockchip-samsung-hdptx: Explicitly include pm_runtime.h
      phy: phy-rockchip-samsung-hdptx: Enable runtime PM at PHY core level
      dt-bindings: phy: rockchip,rk3588-hdptx-phy: Add #clock-cells
      phy: phy-rockchip-samsung-hdptx: Add clock provider support

Hui-Ping Chen (2):
      dt-bindings: phy: nuvoton,ma35-usb2-phy: add new bindings
      phy: nuvoton: add new driver for the Nuvoton MA35 SoC USB 2.0 PHY

Krzysztof Kozlowski (12):
      dt-bindings: phy: socionext,uniphier: add top-level constraints
      phy: broadcom: bcm-cygnus-pcie: Simplify with scoped for each OF chil=
d loop
      phy: broadcom: brcm-sata: Simplify with scoped for each OF child loop
      phy: cadence: sierra: Simplify with scoped for each OF child loop
      phy: hisilicon: usb2: Simplify with scoped for each OF child loop
      phy: mediatek: tphy: Simplify with scoped for each OF child loop
      phy: mediatek: xsphy: Simplify with scoped for each OF child loop
      phy: qcom: qmp-pcie-msm8996: Simplify with scoped for each OF child l=
oop
      phy: ti: am654-serdes: Use scoped device node handling to simplify er=
ror paths
      phy: ti: gmii-sel: Simplify with dev_err_probe()
      phy: ti: j721e-wiz: Drop OF node reference earlier for simpler code
      phy: ti: j721e-wiz: Simplify with scoped for each OF child loop

Lorenzo Bianconi (1):
      phy: airoha: adjust initialization delay in airoha_pcie_phy_init()

Manivannan Sadhasivam (1):
      phy: qcom: qmp: Add debug prints for register writes

Qiang Yu (1):
      phy: qcom: qmp-pcie: Configure all tables on port B PHY

Rayyan Ansari (2):
      dt-bindings: phy: qcom,sata-phy: convert to dtschema
      dt-bindings: phy: drop obsolete qcom,usb-8x16-phy bindings

Rob Herring (Arm) (1):
      dt-bindings: phy: hisilicon,hi3798cv200-combphy: Convert to DT schema

Siddharth Vadapalli (1):
      phy: cadence-torrent: add support for three or more links using 2 pro=
tocols

Stefan Eichenberger (1):
      phy: marvell: phy-mvebu-cp110-comphy: improve eth_port1 on comphy4

 .../phy/hisilicon,hi3798cv200-combphy.yaml         |  56 ++
 .../bindings/phy/nuvoton,ma35d1-usb2-phy.yaml      |  45 ++
 .../bindings/phy/phy-hi3798cv200-combphy.txt       |  59 --
 .../devicetree/bindings/phy/qcom,sata-phy.yaml     |  55 ++
 .../bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml   |   3 +
 .../devicetree/bindings/phy/qcom,usb-8x16-phy.txt  |  76 ---
 .../bindings/phy/qcom-apq8064-sata-phy.txt         |  24 -
 .../bindings/phy/qcom-ipq806x-sata-phy.txt         |  23 -
 .../devicetree/bindings/phy/renesas,usb2-phy.yaml  |   4 +-
 .../bindings/phy/rockchip,rk3588-hdptx-phy.yaml    |   3 +
 .../bindings/phy/socionext,uniphier-ahci-phy.yaml  |   8 +-
 .../bindings/phy/socionext,uniphier-pcie-phy.yaml  |   8 +-
 .../phy/socionext,uniphier-usb3hs-phy.yaml         |   7 +-
 .../phy/socionext,uniphier-usb3ss-phy.yaml         |   7 +-
 drivers/phy/Kconfig                                |   1 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/broadcom/phy-bcm-cygnus-pcie.c         |  20 +-
 drivers/phy/broadcom/phy-brcm-sata.c               |  21 +-
 drivers/phy/cadence/phy-cadence-sierra.c           |  95 ++-
 drivers/phy/cadence/phy-cadence-torrent.c          | 683 +++++++++++------=
----
 drivers/phy/hisilicon/phy-hisi-inno-usb2.c         |  12 +-
 drivers/phy/marvell/phy-mvebu-cp110-comphy.c       |   4 +-
 drivers/phy/mediatek/phy-mtk-tphy.c                |  30 +-
 drivers/phy/mediatek/phy-mtk-xsphy.c               |  27 +-
 drivers/phy/nuvoton/Kconfig                        |  12 +
 drivers/phy/nuvoton/Makefile                       |   3 +
 drivers/phy/nuvoton/phy-ma35d1-usb2.c              | 143 +++++
 drivers/phy/phy-airoha-pcie.c                      |   6 +-
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c          |  38 +-
 drivers/phy/qualcomm/phy-qcom-qmp-common.h         |  19 +-
 drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c   |  19 +-
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c           |  83 ++-
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c            |  12 +-
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c            |  10 +-
 drivers/phy/qualcomm/phy-qcom-qmp-usbc.c           |  13 +-
 drivers/phy/renesas/phy-rcar-gen3-usb2.c           |  60 +-
 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c  | 206 ++++++-
 drivers/phy/samsung/phy-exynos5-usbdrd.c           |  12 +-
 drivers/phy/ti/phy-am654-serdes.c                  |  50 +-
 drivers/phy/ti/phy-gmii-sel.c                      |  16 +-
 drivers/phy/ti/phy-j721e-wiz.c                     |  16 +-
 41 files changed, 1194 insertions(+), 796 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/hisilicon,hi3798c=
v200-combphy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/nuvoton,ma35d1-us=
b2-phy.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/phy-hi3798cv200-c=
ombphy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,sata-phy.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/qcom,usb-8x16-phy=
=2Etxt
 delete mode 100644 Documentation/devicetree/bindings/phy/qcom-apq8064-sata=
-phy.txt
 delete mode 100644 Documentation/devicetree/bindings/phy/qcom-ipq806x-sata=
-phy.txt
 create mode 100644 drivers/phy/nuvoton/Kconfig
 create mode 100644 drivers/phy/nuvoton/Makefile
 create mode 100644 drivers/phy/nuvoton/phy-ma35d1-usb2.c

--=20
~Vinod

--KieMfyFo6wVilUZP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAABCgAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmbv/oYACgkQfBQHDyUj
g0cN4g/3Zinf/r3Wihg2Zd23ZeWVHmEVZ3x8OIhAxgQBRJmZIp5vaxg8Jrlo9Wdd
NPoPgxBy1tGynkFILONCkrvGzP6IwGwashv9s3jaHpMId4WOsunqtxi6PBKIvwFG
O48DzQih1geTfATHyK0Wl7U+S5A/5VZpik4mPLizAcBqjDDW+86+y1qlFF1Oms08
YjOn8Q5miH+kihzfOuwrf0Rq2CIz/CJvDzo6OFYX4ijIiyLqJauFjsu8OHPbiOqi
k9jXwsY+wyn0miexCSs2KpQoNls7TdwiseosggrCQkqZH6600vcm39aTtJF2ewOj
E2OZhZHqS0GMSlAB8fbb4c7R4YBT5und1PG9iNaxmsrO3IYcKFwcNLuyXOO0WrSC
C3idkrtDjEEaBDcfa9wcrW/puPCLA9APzS4TgojpGftBIIjXQG5y6pB7n/KeV4Qk
tnvK3kxNI6jzi4rvuy9Aj8OdF1IHC2awdFpOl2B4Vsw5CKSVTISkZJabHmbo2/yg
famcGvS2GHPcAOe58f53F7Jm7TLBuOo/RVShAcrMDBwYWZAoyG6rzmi1lJoawtds
8J+citBYfJud2bckS1YBRVfQAlyLObDrZidkq1amxPazvAqivfW+fQHTVHu6Cpen
iA6QzKTJGsVcVsXDFPB3hDacTROVsrTgAUuS+tMdiB7lmXMVfw==
=xkmD
-----END PGP SIGNATURE-----

--KieMfyFo6wVilUZP--

