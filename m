Return-Path: <linux-kernel+bounces-335106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE4397E117
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 13:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 665CF281469
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 11:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36341917CD;
	Sun, 22 Sep 2024 11:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ss0475Ax"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A4C3B7AC
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 11:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727004161; cv=none; b=X5Fh3A6GMQHWRuC55fC6e1RQyfNopwnp2zUZ5jL+cCQ3zB+4F/DsU/WJCeErZ8w8IMq9hUmFC+TfuOhJhfCs1sgilwfVpzRkEv4YSbxlHYjgAVHjrVqDBuLs8fcsIVAFvz1Lzy+xGEW71+yZQ+QrR/wXx22GzkK7nPsUWAngM4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727004161; c=relaxed/simple;
	bh=3k4vyPnKx1FPr/j7NGdo6pLAthqGawcNdhkS74XQGTI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BOyyixIfOlHYiVUsx9YB/c9nrPAv8H7740Inyj/SvoCaX3UhfSlDsOtdUA4LXkN7SwMDx/H3HDLsfZxv0cdfepNwwULY0FW0/0dO0dpLvF/sJCtpsKFk2rpSfZUjF20wluO8f8hd0FsB/OvRn9DCZDhF74HQscSyC/yM6/LmSJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ss0475Ax; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54842C4CEC3;
	Sun, 22 Sep 2024 11:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727004160;
	bh=3k4vyPnKx1FPr/j7NGdo6pLAthqGawcNdhkS74XQGTI=;
	h=Date:From:To:Cc:Subject:From;
	b=Ss0475AxaEq9GfnSsIxWf/w6NzU7v1QIBAHdmEV0QtzD6Z1ZoEiUwZDxTyxb7aOqz
	 2IaA9jCNGtaw5H5BsiQhAdoznogYAt5oniDdISdCq2YSQeA9URsDomtqPYMBoTexcj
	 IgoCszMGwMzwdMRjunZFuDT0nKNv+oFgbE3xzOYKGOYWl335Vk9ndsRvpeHTigj4Cn
	 mcw+AUKK/qJNRp6Lxm23XlXL2d/6TucnK9xYzYEJMj1gVuhDOKmEyCqBbh2u5qsaPb
	 4JQ+rbvpliypafsb+VRa/53Cx8yXwFCkepdq5icI95FmJP4otIjDcD9dcOOf0jzhSk
	 lRhQWlgn7F4dA==
Date: Sun, 22 Sep 2024 12:22:37 +0100
From: Vinod Koul <vkoul@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: soundwire subsystem updates for v6.12
Message-ID: <Zu/9/X5gRGMgbY+F@vaman>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lBeXOpK2lrUsLJzM"
Content-Disposition: inline


--lBeXOpK2lrUsLJzM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Please pull this short soundwire subsystem updates for v6.12 containing
few bus updates and couple of intel updates

The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/so=
undwire-6.12-rc1

for you to fetch changes up to 5aedb8d8336b0a0421b58ca27d1b572aa6695b5b:

  soundwire: intel_bus_common: enable interrupts before exiting reset (2024=
-08-18 12:14:53 +0530)

----------------------------------------------------------------
soundwire updates for 6.12

 - bus cleanup for warnings and probe deferral errors suppression
 - cadence recheck for status with a delayed work
 - intel interrupt rework on reset exit

----------------------------------------------------------------
Johan Hovold (3):
      soundwire: bus: suppress probe deferral errors
      soundwire: bus: drop unused driver name field
      soundwire: bus: clean up probe warnings

Pierre-Louis Bossart (2):
      soundwire: cadence: re-check Peripheral status with delayed_work
      soundwire: intel_bus_common: enable interrupts before exiting reset

 drivers/soundwire/bus_type.c         | 19 ++++--------------
 drivers/soundwire/cadence_master.c   | 39 ++++++++++++++++++++++++++++++++=
++--
 drivers/soundwire/cadence_master.h   |  5 +++++
 drivers/soundwire/intel.h            |  2 ++
 drivers/soundwire/intel_auxdevice.c  |  1 +
 drivers/soundwire/intel_bus_common.c | 35 +++++++++++++++++++++-----------
 include/linux/soundwire/sdw.h        |  2 --
 7 files changed, 72 insertions(+), 31 deletions(-)


Thanks
--=20
~Vinod

--lBeXOpK2lrUsLJzM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmbv/f0ACgkQfBQHDyUj
g0fEbw/+Id5r76zqj6gOZWtGd5jF3GWLkjY+yehgHjbS+kirRERv1s9acIfImTTD
Ur7pHKqBUw45OswGXPnd/ebJRX8Rvk9K+7g9qRXLkPASZFzCAjHC/Rug+FQu9PWx
wL66BeYRN7v1/SGvFlufLW5jA5YWT8yoCfn/GVXOMIcpId5NGS7k2Co6P3JG91Yh
IhSmgpSA/XLKNg/MEE9gnknPXRT7erLFT4bT3YYRAr75rfh2q+sxWNfeebMGwcFE
CeJIZIzaQIl2a28Hkgc76AGBcj2HrkEsAOdMONXR8PKimkDEYVwEoK51e4k2RaNR
sNlRsLiZAz/dJqFI/bS1ycwDC2DP1pGJJNy8AWYRVx8QF7ZAiW3xTNifnBXbaclC
/nNPF6UXRsBkD7B+UuwY22O/zT9dMkNDlxIacLNLMHNMMHy1d6H9PMV3KpKHrwlx
hW9yodOepdJZOVito3M3JVw1zSD1bmxU0o7+zUydCZ4X+Mr152JWp5fPBe8gUsAi
E4S/v4pgIpExNhteo9onxLzgGDvJWKC6tYNnuUf0X3PrAUMxE4Gi+sRBWXwhEM2M
6zFJjgSNnAHd/DnOwekluJoPNth2qrt4DLldltwiyHE2wZoqe86kPzD1n28sRMpE
bNE1giNxGby5rpZMg2OOhXQ0YljC8j1uueKCJKWlWb4fke9QAH0=
=ENJq
-----END PGP SIGNATURE-----

--lBeXOpK2lrUsLJzM--

