Return-Path: <linux-kernel+bounces-393880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF8E9BA6A8
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 17:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FF752814F7
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 16:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3F5171088;
	Sun,  3 Nov 2024 16:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nV2oc7nx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EE4AD2D
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 16:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730651780; cv=none; b=UNUnaFCu2ANQy+77ji71Hs/CZfzrz83O/H2qEVkKtaj++p+YK10QN/RGLLmGqm7FFyoLWr5zfWaNiOI64ZndlKmgddfQvwc80CKH491cfiGU0lY0FX0BY853KNCqyUqq5Sp9GxG3hcO1Fjd8zzx4USWMWTvKy99uSyfS1FTcvQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730651780; c=relaxed/simple;
	bh=pkrvlZNuIfGVO2+sT7oIj+yIVci+tgs+U3VeLQAP8T0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Yaes+7H5WoTjOr7zh8kZWSYm5uLDs9hW0qC9oo//+GoY0MhQ+mEkPq2vykoyaPrZ37B7hWxvxmFYSELD/IiH7QgDUAJZa/9QkMTnrGyFQJDpKKkwl4xUWV7baZc7jMZKHv3agsHCzLK7mjUEruxHmbU22qoulScZ3FMtuTRmuio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nV2oc7nx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E01EC4CED3;
	Sun,  3 Nov 2024 16:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730651776;
	bh=pkrvlZNuIfGVO2+sT7oIj+yIVci+tgs+U3VeLQAP8T0=;
	h=Date:From:To:Cc:Subject:From;
	b=nV2oc7nxq0o7G4HNOvXmD8BUZ/za6S3/fXxJMNNS2xOtlHZ9xOzL0CRjDH8WTu+9a
	 l1NpYnMRr7EIFSyhlsughgtjRMxDsu5xUfeCzs8ebZtcPz249CMrxD9+QKt9OxA9MQ
	 rqsximSm0q7FZv8CnjhvIeeK0xfZ82mxGrDiXiF4QUKP6h2wMYmRHgiRrh/B73XA12
	 ZgeJVeafFlgHOLZQzGdycwxWE+Q9oAVCvP8U2Ob8zvrizZLaxn+25oB2OZqPWLsDGW
	 xTV4gc3EXdTtsMfHXIqd3WS2Wf+qG4q94Z6fJ/I79HguGJKbK3exyrYI6zhBzazJ0y
	 1vdVRStipds1A==
Date: Sun, 3 Nov 2024 22:06:12 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: Generic phy subsystem fixes for v6.12
Message-ID: <ZyemfNqanr4J/kd1@vaman>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aecsP4KyPr1TaTxP"
Content-Disposition: inline


--aecsP4KyPr1TaTxP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Here is the request for phy subsystem fixes. Bunch of qcom driver fixes
for same patter over different drivers along with other driver fixes in
the subsystem. Though patches are bit more, but diffstat is small.

The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:

  Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-=
fixes-6.12

for you to fetch changes up to e70d2677ef4088d59158739d72b67ac36d1b132b:

  phy: tegra: xusb: Add error pointer check in xusb.c (2024-10-21 23:34:42 =
+0530)

----------------------------------------------------------------
phy fixes for 6.12

 - Bunch of Qualcomm QMP driver fixes for null deref on suspend, bogus
   supplies fix and reset entries fix
 - BCM usb driver init array fix
 - cadence array offset fix
 - starfive link configuration fix
 - config dependency fix for rockchip driver
 - freescale reset signal fix before pll lock
 - tegra driver fix for error pointer check

----------------------------------------------------------------
Abel Vesa (1):
      dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Fix X1E80100 resets ent=
ries

Bartosz Wawrzyniak (1):
      phy: cadence: Sierra: Fix offset of DEQ open eye algorithm control re=
gister

Cristian Ciocaltea (1):
      phy: phy-rockchip-samsung-hdptx: Depend on CONFIG_COMMON_CLK

Dipendra Khadka (1):
      phy: tegra: xusb: Add error pointer check in xusb.c

Jan Kiszka (1):
      phy: starfive: jh7110-usb: Fix link configuration to controller

Johan Hovold (6):
      dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: add missing x1e80100 pi=
pediv2 clocks
      phy: qcom: qmp-usb: fix NULL-deref on runtime suspend
      phy: qcom: qmp-usb-legacy: fix NULL-deref on runtime suspend
      phy: qcom: qmp-usbc: fix NULL-deref on runtime suspend
      phy: qcom: qmp-combo: move driver data initialisation earlier
      phy: qcom: qmp-pcie: drop bogus x1e80100 qref supplies

Justin Chen (1):
      phy: usb: disable COMMONONN for dual mode

Richard Zhu (1):
      phy: freescale: imx8m-pcie: Do CMN_RST just before PHY PLL lock check

Sam Edwards (1):
      phy: usb: Fix missing elements in BCM4908 USB init array

Siddharth Vadapalli (1):
      phy: ti: phy-j721e-wiz: fix usxgmii configuration

 .../bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml    |  5 +++--
 drivers/phy/broadcom/phy-brcm-usb-init-synopsys.c   | 12 +++++++++---
 drivers/phy/broadcom/phy-brcm-usb-init.c            |  2 ++
 drivers/phy/cadence/phy-cadence-sierra.c            | 21 +++++++++++------=
----
 drivers/phy/freescale/phy-fsl-imx8m-pcie.c          | 10 +++++-----
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c           |  3 +--
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c            |  8 ++++----
 drivers/phy/qualcomm/phy-qcom-qmp-usb-legacy.c      |  1 +
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c             |  1 +
 drivers/phy/qualcomm/phy-qcom-qmp-usbc.c            |  1 +
 drivers/phy/rockchip/Kconfig                        |  1 +
 drivers/phy/starfive/phy-jh7110-usb.c               | 16 ++++++++++++++++
 drivers/phy/tegra/xusb.c                            |  2 ++
 drivers/phy/ti/phy-j721e-wiz.c                      |  4 ++--
 14 files changed, 59 insertions(+), 28 deletions(-)

--=20
~Vinod

--aecsP4KyPr1TaTxP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmcnpnwACgkQfBQHDyUj
g0eTyQ//dQcr+EhrBl75uoa/UjtjXGGBd9pUI+qb7ZophjudpCbocaQ7qAhkQQ0g
BlmuQxU9mymaGDg312EnSOhAE4M0hLSwt801NAcMWMYgh4T4VfKjstWH8Rj6iJX+
A7bqjtW6nXBCQhLzcWOgWfPiM1qX7WA7lieLaCU0EaxmnKU1yKzuoFtF/UXLOle4
DB4Am6nR/ayDA2t1UvoLqJsQsFg11J3Slg+jzU0igP2hP0PyQ7antGSqz5OyKh/U
7HBfaTheHSRK5Wi8iFDEqZz8X1VJxSLTdtoZ4qtuJVFjZcbysqX/4lRYwJAuUDOv
GvEYAQrl5HeorecwP5FrWKmbkJzAnvu84NfHmPQ2igppmkhXsYPn2W/fIljy7Vtl
V1LuMA9KOaIF02qJnubExmZStTe5hB5DnhT9xHcNvkws7GsrAMstjT0VB/+c8s0r
KvGApkWmHsMSYj+i/E3QNB0Bl4+yjtBXBf+gs7kMqfDIyLh6qaxQqgkmwgfE70Bw
AHtO/NghAci0Cy8DsQen6XEPym9Mgn/Hp05e0BpCcuz68jw1beP26TvUJnqa3tuw
5KFrZN5EC4zlKUn8BeTy9WKKIXn4yt6REPr6KZCDnca6KuX3aywCGI3DftrP/I0W
G3yPQ29YmrelK48fRoPyneorDXvHfaFSFj/eOAZBv86GXi4Wb8I=
=cad6
-----END PGP SIGNATURE-----

--aecsP4KyPr1TaTxP--

