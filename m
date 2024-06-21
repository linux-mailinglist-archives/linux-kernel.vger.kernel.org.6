Return-Path: <linux-kernel+bounces-224354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2B891213B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 11:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8556F2898AB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 09:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6FF616F84C;
	Fri, 21 Jun 2024 09:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPM1/oYs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1910E16F82F
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 09:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718963471; cv=none; b=Rpltnjm7mCV6sqZt3ISZ9mnvuTty6mkOhL4AB5mt4G56+amS+MvQkEp0aRC4k/b/L2nS0xiJq5/piInQQctq+oEn5NgtvpHzHc3wB+Ip1xXIyM6EOtcatMFYUUZuBhjgtm4ym5oIT5UxaG7Tgf74TVS1ZIyiFuD+KRLKdeZSGvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718963471; c=relaxed/simple;
	bh=CYAZBMfO/SxuVQVR0C8wqHPGKi+7+MnhX7/PeYm5MIs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=m4QuEk2ZFIbjCuCVQmZ/9bdMviCURR3FKcFsLjhS2REHSHqiYmYz5k8qarLczCVFv+6zU0d00PdyKD9eCShtvMIx+OQM1tEeRnUtkdIRrfjRBOpuoYdo6kIEJkDStl6GfvwTmjMZD/0jKlVEB95CjHzdMHVn3mi2dV/J4rFkktc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPM1/oYs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20DCFC2BBFC;
	Fri, 21 Jun 2024 09:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718963470;
	bh=CYAZBMfO/SxuVQVR0C8wqHPGKi+7+MnhX7/PeYm5MIs=;
	h=Date:From:To:Cc:Subject:From;
	b=mPM1/oYsA1JzkH0lCtEGFC6lRYlJza/U3jtV0Ai65qi0zgn9A3PjHQtyXNrTtPmHT
	 jDheDQtXsSaNMMKGCU6WbjuUW46b4WMeSx91qFgPdr7I3/mWO2edgoUf2jetaThL2C
	 dZ8SD67K8tUGrDKHRW/HqSvCaqUBYm90wzY9X7kg/UtrfaG4wUXYmx/SJRNn8VErCV
	 ZVxhEybCWBgPW7QporCeWWY+8NFDtbkNrToCK1RbMdzjDCQQRc/J9o52yKgFUCjPI4
	 kqgAm3kStvY6G/nF5DFeen+gc7JOVVq8WMwNo5QD+81AkoE4YTbMLbyZhMP09bUV/u
	 SPQDgiqITf2uA==
Date: Fri, 21 Jun 2024 15:21:06 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: Generic phy fixes for v6.10
Message-ID: <ZnVNCogeCFcQH1jH@matsya>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gOAqRbwQ5riGMOZQ"
Content-Disposition: inline


--gOAqRbwQ5riGMOZQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull to receive couple of fixes in the Qualcomm qmp phy driver

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-=
fixes-6.10

for you to fetch changes up to 163c1a356a847ab4767200fd4a45b3f8e4ddc900:

  phy: qcom: qmp-combo: Switch from V6 to V6 N4 register offsets (2024-06-0=
3 19:30:47 +0530)

----------------------------------------------------------------
phy fixes for 6.10

 - Qualcomm QMP driver fixes for missing register offsets and correct N4
   offsets for registers

----------------------------------------------------------------
Abel Vesa (3):
      phy: qcom-qmp: qserdes-txrx: Add missing registers offsets
      phy: qcom-qmp: pcs: Add missing v6 N4 register offsets
      phy: qcom: qmp-combo: Switch from V6 to V6 N4 register offsets

 drivers/phy/qualcomm/phy-qcom-qmp-combo.c          | 189 +++++++++++++++++=
----
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6-n4.h      |  32 ++++
 .../phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6_n4.h |  13 ++
 drivers/phy/qualcomm/phy-qcom-qmp.h                |   2 +
 4 files changed, 207 insertions(+), 29 deletions(-)
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6-n4.h
--=20
~Vinod

--gOAqRbwQ5riGMOZQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmZ1TQoACgkQfBQHDyUj
g0cvVQ//SSft+fbuCJ0tEtW+O+IwaQ3dCpgo0R6WRMaHqWYjKJP3NiaSDvLJQjgK
X+x5wO210v+GPvsi69YAVDK5qW5i9PbSe4zSiTiee/CHSgTL1rEokRWZUkXOnXsu
LV4oT4MMcVm5u6DEaym0aAGoMti59XymeFY59hfbcjGJZl9r93p4JnOwfwsCdmjM
yVQCnyZeJz3Tjykppb9WM9SKIMcqB0Kf0ekTEKUb6r52GjAYtvjwhgSl+yPM02O5
MwaNja4uPf6Ot6B/k7QHskPLVHKm41Mllt3W3gvEGKYTs0xtoo9/Vynmf2wcrqhZ
BwzAGv3SFyGgKhXPsAsIVAEbZYU1vXMR7A8IezgYhPvlfuipOlcQ3SfOaTo+6OLh
9EjHKfjMtIkIddzAJBJR3GQW82w3u+NzC+VppN/AVRCmXDdgneFCoV/IAKvZwLbF
QTS8u7SOEg7+p3Ms9PehVJOSa9Sd9/f4YyLxXKD0mZ+3b3kgUwtrAipYYLOPxElH
79i+HNuunMLg52JfQ0O1ZIYoxkzP3dm0dTqylbKZZZq4yuOgESwgsIBzPB303774
msN/i4D2Hb94FFhH5Kt7dOLcCfVDPm0bfrU924EEXkpw+b07ZK2PgNrSoC1nWI5e
5UkmCI/oZVp9FZTPqbiBtpqGowbLN/abn/moWsK8LQdIZTPF4/Y=
=SkfY
-----END PGP SIGNATURE-----

--gOAqRbwQ5riGMOZQ--

