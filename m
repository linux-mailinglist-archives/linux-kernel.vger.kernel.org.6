Return-Path: <linux-kernel+bounces-423443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B31B9DA76F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 13:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2B7D281D20
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 12:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242EB1FAC57;
	Wed, 27 Nov 2024 12:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YL6IOam4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD3D1FA82C
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 12:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732709338; cv=none; b=G1KhZXULX6ei+fXFW+wz2I4Uuz1uGyT6cTEdxJFERlr9XqZy/V5ANXDBD2ym0885xq2G5WwEmbTSOD5zSuHyznSuhE69Plxiqoetd1PO8J5YQp9DmtAcyCQl7c/4BRjkqxdIcog9pYpQK/M+fa0MdMLulAxx2S0bHC6sLYzsdfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732709338; c=relaxed/simple;
	bh=n6DGudNCBoY+bcOrb2hxuJ9p0HgAI3GgEdvR/GeFnvE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uCBdGiyskOCLfXiuqFWX8AaKAMhcPgLCr+vRrDNoqjyaGAno/HYc4mU+dtRW9+6nqi/AdLJkvbriPNltTobl/87c3vWtJElGKEWD4o7Ijif0oJvQEKoRBSLPihAottSDEXbYIgy1iLLTzmlRrc0SUF7lDAPO7lzYjTC9FRhLQDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YL6IOam4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8932AC4CECC;
	Wed, 27 Nov 2024 12:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732709338;
	bh=n6DGudNCBoY+bcOrb2hxuJ9p0HgAI3GgEdvR/GeFnvE=;
	h=Date:From:To:Cc:Subject:From;
	b=YL6IOam4HN92yXFTNIzB2Sf3bAQFnpXW+Zp03iLy21AM2uAhjALozJvRZmzlkZRzC
	 fiIA+m/d96y2t8/mNo+W3L74UnOD/r5oBEtgZU9WPjRqV4VpPP5jEgiqrogwk256UJ
	 zP0qG8hgKoxyu0V9S2FgMlruDA6vEsFIfk16eJKdswF5CgQPKjeXrBQX9ByO26LKFi
	 UqIyt8qP75iVQgHQIYUDHJuBRtL/pbZUxbcAArHlfWLbYxv8RB2Wrnek1ZMCyThsoC
	 nAsQyx1GxcPxfgUtkdGUnUKpVBxxhdNmYrI0moWp2ZhIDIB+f8VUYQSAvGbFdUCZ4+
	 fx/f7gcoFazqg==
Date: Wed, 27 Nov 2024 17:38:54 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: Generic phy subsystem updates for v6.13
Message-ID: <Z0cL1hAJ0BivGXQh@vaman>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nJmt4jaZky3TBQ5o"
Content-Disposition: inline


--nJmt4jaZky3TBQ5o
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Here is the second request this evening to receive the generic phy
subsystem updates which as usual contains bunch on new phy driver and
device support along with bunch of updates and the platform_driver
remove subsystem update.

You might get a merge conflict when you merge, it is fairly simple one
and the next also contains a resolution.

The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:

  Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-=
for-6.13

for you to fetch changes up to 32f4a76b8e7cedec9f9aedbfc43626536bba8350:

  phy: qcom: qmp: Fix lecacy-legacy typo (2024-10-22 00:09:03 +0530)

----------------------------------------------------------------
phy-for-6.13

- New Support
  - ST STM32MP25 combophy support
  - Sparx5 support for lan969x serdes and updates to driver to support this
  - NXP PTN3222 eUSB2 to USB2 redriver
  - Qualcomm SAR2130P eusb2 support, QCS8300 USB DW3 and QMP USB2 support,
    X1E80100 QMP PCIe PHY Gen4 support, QCS615 and QCS8300 QMP UFS PHY
    support and SA8775P eDP PHY support
  - Rockchip rk3576 usbdp and rk3576 usb2 phy support
  - Binding for Microchip ATA6561 can phy

- Updates
  - Freescale driver updates from hdmi support
  - Conversion of rockchip rk3228 hdmi phy binding to yaml
  - Broadcom usb2-phy deprecated support dropped and USB init array update
    for BCM4908
  - TI USXGMII mode support in J7200
  - Switch back to platform_driver::remove() subsystem update

----------------------------------------------------------------
Adam Ford (5):
      phy: freescale: fsl-samsung-hdmi: Replace register defines with macro
      phy: freescale: fsl-samsung-hdmi: Simplify REG21_PMS_S_MASK lookup
      phy: freescale: fsl-samsung-hdmi: Support dynamic integer
      phy: freescale: fsl-samsung-hdmi: Use closest divider
      phy: freescale: fsl-samsung-hdmi: Remove unnecessary LUT entries

Andrew Kreimer (1):
      phy: sun4i-usb: Fix a typo

Andy Yan (1):
      phy: phy-rockchip-samsung-hdptx: Don't request RST_PHY/RST_ROPLL/RST_=
LCPLL

Christian Bruel (3):
      dt-bindings: phy: Add STM32MP25 COMBOPHY bindings
      phy: stm32: Add support for STM32MP25 COMBOPHY.
      MAINTAINERS: add entry for ST STM32MP25 COMBOPHY driver

Daniel Machon (9):
      phy: sparx5-serdes: add support for private match data
      phy: sparx5-serdes: add constants to match data
      phy: sparx5-serdes: add constant for the number of CMU's
      phy: sparx5-serdes: add ops to match data
      phy: sparx5-serdes: add function for getting the CMU index
      phy: sparx5-serdes: add indirection layer to register macros
      phy: sparx5-serdes: add support for branching on chip type
      dt-bindings: phy: sparx5: document lan969x
      phy: lan969x-serdes: add support for lan969x serdes driver

Dmitry Baryshkov (3):
      dt-bindings: phy: add NXP PTN3222 eUSB2 to USB2 redriver
      phy: add NXP PTN3222 eUSB2 to USB2 redriver
      dt-bindings: phy: qcom: snps-eusb2: Add SAR2130P compatible

Dragan Simic (3):
      phy: phy-rockchip-inno-usb2: Perform trivial code cleanups
      phy: phy-rockchip-inno-usb2: Handle failed extcon allocation better
      phy: phy-rockchip-inno-usb2: Use dev_err_probe() in the probe path

Frank Wang (4):
      phy: rockchip: inno-usb2: convert clock management to bulk
      dt-bindings: phy: rockchip,inno-usb2phy: add rk3576
      dt-bindings: phy: rockchip-usbdp: add rk3576
      phy: rockchip: usbdp: add rk3576 device match data

Heiko Stuebner (1):
      dt-bindings: phy: rk3228-hdmi-phy: convert to yaml

Ilya Orazov (1):
      dt-bindings: phy: ti,tcan104x-can: Document Microchip ATA6561

Josua Mayer (1):
      phy: mvebu-cp110-utmi: support swapping d+/d- lanes by dts property

Konrad Dybcio (1):
      phy: qcom: qmp: Fix lecacy-legacy typo

Krishna Kurapati (4):
      dt-bindings: usb: qcom,dwc3: Add QCS8300 to USB DWC3 bindings
      dt-bindings: phy: qcom,usb-snps-femto-v2: Add bindings for QCS8300
      dt-bindings: phy: qcom,sc8280xp-qmp-usb3-uni: Add QCS8300 compatible
      phy: qcom: qmp: Add qmp configuration for QCS8300

Lorenzo Bianconi (4):
      phy: airoha: Fix REG_CSR_2L_PLL_CMN_RESERVE0 config in airoha_pcie_ph=
y_init_clk_out()
      phy: airoha: Fix REG_PCIE_PMA_TX_RESET config in airoha_pcie_phy_init=
_csr_2l()
      phy: airoha: Fix REG_CSR_2L_JCPLL_SDM_HREN config in airoha_pcie_phy_=
init_ssc_jcpll()
      phy: airoha: Fix REG_CSR_2L_RX{0,1}_REV0 definitions

Macpaul Lin (1):
      dt-bindings: phy: mediatek: tphy: add a property for power-domains

Qiang Yu (2):
      dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Document the X1E80100 Q=
MP PCIe PHY Gen4 x8
      phy: qcom: qmp: Add phy register and clk setting for x1e80100 PCIe3

Rafa=C5=82 Mi=C5=82ecki (2):
      dt-bindings: phy: bcm-ns-usb2-phy: drop deprecated variant
      phy: bcm-ns-usb2: drop support for old binding variant

Sam Edwards (2):
      phy: usb: Fix missing elements in BCM4908 USB init array
      phy: usb: update Broadcom driver table to use designated initializers

Sayali Lokhande (1):
      dt-bindings: phy: Add QMP UFS PHY comptible for QCS615

Siddharth Vadapalli (2):
      dt-bindings: phy: cadence-sierra: Allow PHY types QSGMII and SGMII
      phy: ti: gmii-sel: Enable USXGMII mode for J7200

Soutrik Mukhopadhyay (3):
      dt-bindings: phy: Add eDP PHY compatible for sa8775p
      phy: qcom: edp: Introduce aux_cfg array for version specific aux sett=
ings
      phy: qcom: edp: Add support for eDP PHY on SA8775P

Uwe Kleine-K=C3=B6nig (1):
      phy: Switch back to struct platform_driver::remove()

William Wu (1):
      phy: rockchip: inno-usb2: Add usb2 phys support for rk3576

Xin Liu (1):
      dt-bindings: phy: Add QMP UFS PHY compatible for QCS8300

Xu Yang (1):
      dt-bindings: phy: mxs-usb-phy: add imx8qxp compatible

Yang Li (1):
      phy: stm32: Remove unneeded semicolon

Yijie Yang (1):
      dt-bindings: phy: describe the Qualcomm SGMII PHY

 .../devicetree/bindings/phy/bcm-ns-usb2-phy.yaml   |  19 +-
 .../devicetree/bindings/phy/fsl,mxs-usbphy.yaml    |   1 +
 .../devicetree/bindings/phy/mediatek,tphy.yaml     |  10 +
 .../bindings/phy/microchip,sparx5-serdes.yaml      |  17 +-
 .../devicetree/bindings/phy/nxp,ptn3222.yaml       |  55 ++
 .../bindings/phy/phy-cadence-sierra.yaml           |   2 +-
 .../bindings/phy/phy-rockchip-inno-hdmi.txt        |  43 --
 .../bindings/phy/phy-rockchip-usbdp.yaml           |   1 +
 .../devicetree/bindings/phy/qcom,edp-phy.yaml      |   1 +
 .../bindings/phy/qcom,sa8775p-dwmac-sgmii-phy.yaml |   7 +-
 .../bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml   |   3 +
 .../bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml    |  49 +-
 .../phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml        |   2 +
 .../bindings/phy/qcom,snps-eusb2-phy.yaml          |   1 +
 .../bindings/phy/qcom,usb-snps-femto-v2.yaml       |   1 +
 .../bindings/phy/rockchip,inno-usb2phy.yaml        |  45 +-
 .../bindings/phy/rockchip,rk3228-hdmi-phy.yaml     |  97 +++
 .../bindings/phy/st,stm32mp25-combophy.yaml        | 119 ++++
 .../devicetree/bindings/phy/ti,tcan104x-can.yaml   |  13 +-
 .../devicetree/bindings/usb/qcom,dwc3.yaml         |   4 +
 MAINTAINERS                                        |   6 +
 drivers/phy/Kconfig                                |  11 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/allwinner/phy-sun4i-usb.c              |   8 +-
 drivers/phy/broadcom/phy-bcm-ns-usb2.c             |  54 +-
 drivers/phy/broadcom/phy-brcm-usb-init.c           | 433 ++++++------
 drivers/phy/broadcom/phy-brcm-usb.c                |   2 +-
 drivers/phy/cadence/cdns-dphy.c                    |   2 +-
 drivers/phy/cadence/phy-cadence-sierra.c           |   2 +-
 drivers/phy/cadence/phy-cadence-torrent.c          |   4 +-
 drivers/phy/freescale/phy-fsl-imx8qm-lvds-phy.c    |   6 +-
 drivers/phy/freescale/phy-fsl-lynx-28g.c           |   6 +-
 drivers/phy/freescale/phy-fsl-samsung-hdmi.c       | 598 +++++++++--------
 drivers/phy/intel/phy-intel-lgm-combo.c            |   2 +-
 drivers/phy/marvell/phy-mvebu-cp110-utmi.c         |  16 +
 drivers/phy/microchip/sparx5_serdes.c              | 195 +++++-
 drivers/phy/microchip/sparx5_serdes.h              |  44 +-
 drivers/phy/microchip/sparx5_serdes_regs.h         | 746 ++++++++++++++---=
----
 drivers/phy/motorola/phy-cpcap-usb.c               |   2 +-
 drivers/phy/motorola/phy-mapphone-mdm6600.c        |   2 +-
 drivers/phy/phy-airoha-pcie-regs.h                 |   6 +-
 drivers/phy/phy-airoha-pcie.c                      |   8 +-
 drivers/phy/phy-lgm-usb.c                          |   2 +-
 drivers/phy/phy-nxp-ptn3222.c                      | 123 ++++
 drivers/phy/qualcomm/phy-qcom-apq8064-sata.c       |  10 +-
 drivers/phy/qualcomm/phy-qcom-edp.c                |  74 +-
 drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c     |   2 +-
 drivers/phy/qualcomm/phy-qcom-ipq806x-sata.c       |   8 +-
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c          |   8 +-
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c           | 214 ++++++
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6_30.h |  25 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_30.h      |  19 +
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c            |  65 ++
 drivers/phy/realtek/phy-rtk-usb2.c                 |   2 +-
 drivers/phy/realtek/phy-rtk-usb3.c                 |   2 +-
 drivers/phy/renesas/phy-rcar-gen3-pcie.c           |   8 +-
 drivers/phy/renesas/phy-rcar-gen3-usb2.c           |   2 +-
 drivers/phy/renesas/phy-rcar-gen3-usb3.c           |   8 +-
 drivers/phy/renesas/r8a779f0-ether-serdes.c        |   2 +-
 drivers/phy/rockchip/phy-rockchip-inno-csidphy.c   |   2 +-
 drivers/phy/rockchip/phy-rockchip-inno-dsidphy.c   |   2 +-
 drivers/phy/rockchip/phy-rockchip-inno-hdmi.c      |   4 +-
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c      | 200 ++++--
 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c  |  17 +-
 drivers/phy/rockchip/phy-rockchip-typec.c          |   2 +-
 drivers/phy/rockchip/phy-rockchip-usbdp.c          |  41 ++
 drivers/phy/st/Kconfig                             |  11 +
 drivers/phy/st/Makefile                            |   1 +
 drivers/phy/st/phy-stm32-combophy.c                | 598 +++++++++++++++++
 drivers/phy/st/phy-stm32-usbphyc.c                 |   2 +-
 drivers/phy/tegra/xusb.c                           |   2 +-
 drivers/phy/ti/phy-am654-serdes.c                  |   2 +-
 drivers/phy/ti/phy-da8xx-usb.c                     |   4 +-
 drivers/phy/ti/phy-dm816x-usb.c                    |   2 +-
 drivers/phy/ti/phy-gmii-sel.c                      |   3 +-
 drivers/phy/ti/phy-j721e-wiz.c                     |   2 +-
 drivers/phy/ti/phy-omap-usb2.c                     |   2 +-
 drivers/phy/ti/phy-ti-pipe3.c                      |   2 +-
 drivers/phy/ti/phy-twl4030-usb.c                   |   2 +-
 drivers/phy/xilinx/phy-zynqmp.c                    |   2 +-
 include/linux/phy/phy-sun4i-usb.h                  |   2 +-
 81 files changed, 3056 insertions(+), 1067 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/nxp,ptn3222.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/phy-rockchip-inno=
-hdmi.txt
 create mode 100644 Documentation/devicetree/bindings/phy/rockchip,rk3228-h=
dmi-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/st,stm32mp25-comb=
ophy.yaml
 create mode 100644 drivers/phy/phy-nxp-ptn3222.c
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6_30.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_30.h
 create mode 100644 drivers/phy/st/phy-stm32-combophy.c
--=20
~Vinod

--nJmt4jaZky3TBQ5o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmdHC9YACgkQfBQHDyUj
g0ctMA//Zma9a9IY6tr3fqxuRfX9AOdln81HYUlZOws7jZfZPBYXKrZlOkSjwe+K
CMfV5VQNcHSI7IYrRFhcE8yeSAy3wzDNVL0kurrH6IaFCj+4u1O7JHspjHEAnXB6
53HUaThaErxt6zD/y/caA4yCxZXcqVSoVWjZCe2MNhA+xCk/tYb2p0vh1LxmZlOp
moGHcW7VPmSHVaLxNRe3uhy6+LPLAYK6OxE4Zh4ksTdenbVTsG6rXHsmY63ZGOLe
StL+VqCeElPx1fhhK5YhYIuouIRq4g7D40bHdMWheTYzvn7kxswoWsoQ1w+a9VRX
r7uDG9guvEqtFOUNMS4lAV+sFJWBJDeJ6hLDCS1gbWiCcZJyymI/1J3QmvbSbfuu
nojmi6YdqjJUzoznT6kzI6frnCkCdbpLRI9jYX3Q47zstelnErhU8CJL8bnCnMh/
W1/Yj+D6I50YjuEXpEmDWVjMbSFwItJrgPUlGlU6rnGgUJI9tA/Ov+NB/P3RWODn
GoENdNzj6aLvbtiIQZ8jlWCQe3q884DWXXF83RKieyZtqTccqxK8DfU+rX2KBxOo
7xnpyQTFwQ+PJ9supihZJpq5tKGdI6j/KB7lMOMjSKRks3sxe/UDCzZq/X+rVOqs
xNeJ2JFYAVAKgoV97qlI47yybOkBccuXnq4dThIRJXm0aqk8r8o=
=W8Q4
-----END PGP SIGNATURE-----

--nJmt4jaZky3TBQ5o--

