Return-Path: <linux-kernel+bounces-540689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A03A4B3C1
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 18:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6D641891F50
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 17:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32C51EB182;
	Sun,  2 Mar 2025 17:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZEoIfIkA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40658322E
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 17:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740936510; cv=none; b=iXkkqtZCyl+05USgSoqTjS6tuiB0l4fCgHufzWRkiSrZLrQVQjFEH66LJLjOM9AOQb/XPyTQz4031v9/hlXecjorcpJvaAmjUBIPLWScvbf1jSwcDBOg7AGB3Z2xLFrbzcUzdANBcNPHi7/6/mt9AZ2od5xlhHiltcuW1ArSeRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740936510; c=relaxed/simple;
	bh=344tpUiQBJ45K7bj51oZkk3raMe3/Q1YpUVApGBC8Lo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cmxPWwMBaXoT5Th8z7kuX6IT7e2oXvXWaDUvl81Aqd7K4DM832dhdyS6K78Umikn8XR6Whz3STyB8HKucOS34HePLUU4LvF5lR6OOxUMXTTlXl/lArRBNmk4qa9RaZhjZGmgVSlyfs0a+r/VO05EW+4eDYihq7maIPClodpuPO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZEoIfIkA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22D18C4CED6;
	Sun,  2 Mar 2025 17:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740936509;
	bh=344tpUiQBJ45K7bj51oZkk3raMe3/Q1YpUVApGBC8Lo=;
	h=Date:From:To:Cc:Subject:From;
	b=ZEoIfIkAFrmbG1HlpUYEnvnd8NDTyDhDl3doLut03zGhZXvH89x0N54l0CyqTgLLx
	 22oY2a4cw2jCoyXYtYinybkgbhfeSkho+SQfp2d6VaqmGjaidx2P8xUyVmoUHvTJBY
	 VrUbYlwVAt+NEkbgOHMX/MMxRN2qQ3JwCL3MzpQeKUvvqCp9JMtK47OStFTBgcrUAN
	 tZ2D1SKymW+ZmFFlPUESQej/p6Ck1jL3aqOmukJTWG8J51mf4inafIWf+YKkMmT8ty
	 ACDB+hPqJq8I19SOV/HEELHrkg6YgGnPQztzO+qqRa39O5O2xHAZ89arGzeY3chcJk
	 c5flbAK5D869A==
Date: Sun, 2 Mar 2025 22:58:25 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: Generic phy subsytem fixes for v6.14
Message-ID: <Z8SVOYTISnuFWxKF@vaman>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/rmDJrnBT5Z+hM73"
Content-Disposition: inline


--/rmDJrnBT5Z+hM73
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Linus,

Please pull to receive a bunch of small fixes for Generic phy
subsystem. Small driver fixes in bunch of drivers for this cycle.

The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-=
fixes-6.14

for you to fetch changes up to 55f1a5f7c97c3c92ba469e16991a09274410ceb7:

  phy: tegra: xusb: reset VBUS & ID OVERRIDE (2025-02-14 18:03:05 +0530)

----------------------------------------------------------------
phy fixes for 6.14

 - rockchip phy kconfig dependency fix with USB_COMMON and regression fix
   for old DT
 - stm32 phy overflow assertion fix
 - exonysfs phy refclk masks fix and power gate on exit fix
 - freescale fix for clock dividor valid range
 - TI regmap syscon register fix
 - tegra reset registers on init fix

----------------------------------------------------------------
Andrew Davis (1):
      phy: ti: gmii-sel: Do not use syscon helper to build regmap

Andr=E9 Draszik (1):
      phy: exynos5-usbdrd: gs101: ensure power is gated to SS phy in phy_ex=
it()

Arnd Bergmann (1):
      phy: rockchip: fix Kconfig dependency more

BH Hsieh (1):
      phy: tegra: xusb: reset VBUS & ID OVERRIDE

Christian Bruel (1):
      phy: stm32: Fix constant-value overflow assertion

Chukun Pan (1):
      phy: rockchip: naneng-combphy: compatible reset with old DT

Kaustabh Chakraborty (1):
      phy: exynos5-usbdrd: fix MPLL_MULTIPLIER and SSC_REFCLKSEL masks in r=
efclk

Pei Xiao (1):
      phy: freescale: fsl-samsung-hdmi: Limit PLL lock detection clock divi=
der to valid range

 drivers/phy/freescale/phy-fsl-samsung-hdmi.c       | 13 ++++++--
 drivers/phy/rockchip/Kconfig                       |  1 +
 drivers/phy/rockchip/phy-rockchip-naneng-combphy.c |  5 ++-
 drivers/phy/samsung/phy-exynos5-usbdrd.c           | 25 +++++++-------
 drivers/phy/st/phy-stm32-combophy.c                | 38 ++++++++++--------=
----
 drivers/phy/tegra/xusb-tegra186.c                  | 11 +++++++
 drivers/phy/ti/phy-gmii-sel.c                      | 15 ++++++++-
 7 files changed, 73 insertions(+), 35 deletions(-)

--=20
~Vinod

--/rmDJrnBT5Z+hM73
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmfElTkACgkQfBQHDyUj
g0djYhAAuVrff46p3VLXRVt67YyTU3oQ1L+NFp/4W/ItdLBxeynya9X5seavgltP
fZFiEbXQ2dmUixBV9KpPwvSatW0qkOK4QnZbfs67qYAtriu4FFbp012NKmxdLIQh
uuNS3V6o4VayVBRbgWh9wUROclClX8KIpx0Pka5YB8HAufYJ+9mnzpav62fWaE77
LoG3vWwa3GbNC5IhlLGORr8NfwNIHjHOWzOyNwEuVgRour/d9FQUfQabGh2RM5EV
uuFdphV459+86kezvRzMTCsGmkXNkqLGv+jwt6Kdk1xW19zLFZbrjHEhuX1TkTGf
PId4v6HW6jHH+3ybTdvVudmRiIu+ktbynO0oS8DtuMJDACy+lg0wWziqdrK2Wxtn
DctiDYRzq+6mxNw/+qT6jQND4TadAL9XqkUhSeZEyKXojcOWpB5FXM/nz5aNuBam
+Xx8dKA7KE1+vP1c+wu1PTtGmZy49lbpBq+YYELPLG/UmWbS9domENW0DBa8+ssa
5kn5Q0vlPCH7YTNpRCvvvYzlKWlDXDQjsnUkaG+Q/LVEpr9L61YiHu+zKgsmeRfh
JNQbjIGKKYdAGVoSmSF4Fymh8V8+wXMfO9gGblsmR7VMT79Ntog/zkaltG/fLz3O
Pyiz71C+4gJWz+mLzp5spAl3iKyG5unJ/l3ENlbHMKsY4WN9DeQ=
=9fSI
-----END PGP SIGNATURE-----

--/rmDJrnBT5Z+hM73--

