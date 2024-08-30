Return-Path: <linux-kernel+bounces-308813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEE9966216
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 14:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E48851F24CB3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 12:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24DA19995B;
	Fri, 30 Aug 2024 12:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JxbYVh6O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3216312F59C
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 12:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725022537; cv=none; b=ctKzo9HcBgv8IYL93x943oA8+JUBOtBkVQvx5Xt0CBzdVAKWPX7bFlISccUn7BOv0I+VEkfOITiaop4qyWNhVgEiePpLRlsWTuU+rkLSaGkWshLdww9u3oO/BWFKKtAbeZq+ewQgHxz7CnX9Els39vkUgBTGJ8X7T9qt8I0lANM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725022537; c=relaxed/simple;
	bh=D8fj5tYcuhTn43Bgmhsg1l+CgGyqJD3ygW88NFNqy4I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Uz7trRBuZQl7EQRQAn0VVxl/W3HzIuKhqPGQGZ9z3qGtu19/Dv/54sYw4ZKItpJEctKOGStVFd9/7Ks+E44V/e8MoU6RcpNUzuhNBpVNaplz+PftSubrCdYlMWecvNaqMjJAK2rIww1L+XL7UYgGEs6dsnwEPmuDDsapeAabrKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JxbYVh6O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EC2FC4CEC2;
	Fri, 30 Aug 2024 12:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725022536;
	bh=D8fj5tYcuhTn43Bgmhsg1l+CgGyqJD3ygW88NFNqy4I=;
	h=Date:From:To:Cc:Subject:From;
	b=JxbYVh6OtKW3fSNHc3fG9OlAkF3E7mdsdIK7rSGmzy3YAWm6mfooFZxOVq2jnbpp/
	 9YwUiA3EX8akD18R1r7I5VfVGsavfzlHtTu0y5zbaPVhQgoMUsZzy8lO6iRvqcbuBZ
	 kDv+84mcAZCFYEInmW8yWIn2fQitgrSOm/iRQDRjpoM3LTKMNa3ThKuI/GnfptMHrY
	 jYTO49/wZ6B8N/kqOQK5/UDcROF4MZAq+lavmBp0WWIG0DzUu1kiLZcsp2f/ERbO4w
	 lWSCGBCKxQIs55xDMRCSRVzVN5MfuKktGpIKONCnLOlg/c6R1N6E/ZSe2P9Jv5mvN8
	 7hWZ3PJ4Yd4ag==
Date: Fri, 30 Aug 2024 18:25:33 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: Generic phy fixes for v6.11
Message-ID: <ZtHBRVSH6wyIvU+b@vaman>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/xZ6BnYIQSePr9QK"
Content-Disposition: inline


--/xZ6BnYIQSePr9QK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Please pull to receive couple of phy driver fixes.

The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-=
fixes-6.11

for you to fetch changes up to 5af9b304bc6010723c02f74de0bfd24ff19b1a10:

  phy: xilinx: phy-zynqmp: Fix SGMII linkup failure on resume (2024-08-05 2=
1:46:58 +0530)

----------------------------------------------------------------
phy fixes for 6.11

 - Qualcomm QMP X1E80100 PCIe Gen4 PHY initialisation fix
 - Freescale imx8mq tuning parameter name fix
 - Samsung exynos5 fir for error code in probe()
 - Xilinx Zynqmp SGMII linkup failure fix

----------------------------------------------------------------
Abel Vesa (1):
      phy: qcom: qmp-pcie: Fix X1E80100 PCIe Gen4 PHY initialisation

Dan Carpenter (1):
      phy: exynos5-usbdrd: fix error code in probe()

Piyush Mehta (1):
      phy: xilinx: phy-zynqmp: Fix SGMII linkup failure on resume

Xu Yang (1):
      phy: fsl-imx8mq-usb: fix tuning parameter name

 drivers/phy/freescale/phy-fsl-imx8mq-usb.c |  2 +-
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c   | 23 ++++++++----
 drivers/phy/samsung/phy-exynos5-usbdrd.c   |  2 +-
 drivers/phy/xilinx/phy-zynqmp.c            | 56 ++++++++++++++++++++++++++=
++++
 4 files changed, 74 insertions(+), 9 deletions(-)

--=20
~Vinod

--/xZ6BnYIQSePr9QK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmbRwUUACgkQfBQHDyUj
g0eX9RAAuLy+uikE8cyzIoyViytHWRFT0ngvDVxU32H3u5QMaIqYQlh4xOG6AzTu
uDNZXDfv+m9DjOvALNaUfrMmsx3teckvjUT8RJvWFWHV3EJfNH5xZV/+tpu++Xv2
BCXEi/WSkY6Nnd4C3ah/818+Mw8/Pv8gMptatqN/a45wXzBggAGpUd92O28z61/v
YI5oYmNLqnKGWePFYqDAxfFj3q8P2PsBR2SLFXlfx8f9yVr76MvylQofzakPsO+6
EEWb0/YCJlyfX8tpw/GZqF/fTHFuCGQU852rseyoR88ONNpQBA0W/5Z4OeogIFAA
OHq6ejYYbI6x4tzJUNArzCQ5wzSpRcWArLrFEgW7D4Xt6k7ZVwu79IWg8i9wfS2c
cDNR20+0qhXRB85M7Rl3TYSFbOpYVi39K5wngNVCMM2rnZWTZ2Mo98RrVW+gTFGZ
jCRbUGp7HmAUyk9fjLWlQHHo6k+huXBkczzqXxzMwMlNL6uHpRcL87pgRecS99AM
wmEwd2gXeQ6BAP9EgmJ9kdqVxK0U/doWELHgccKy6wuRRkioIPslUH4XwbB7884Z
uaYwVOb9iW/Kch3ncD794COyExWDePnlDoUOZ9nzaa4NKP/9LBsL34Yb0yB/ouXG
qrSb3DsZsZigF2vMW2pHxm90Io/OQocAnNynw4NFV/udWiTTpOg=
=/PBy
-----END PGP SIGNATURE-----

--/xZ6BnYIQSePr9QK--

