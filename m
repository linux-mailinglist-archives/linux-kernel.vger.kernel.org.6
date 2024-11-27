Return-Path: <linux-kernel+bounces-423448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5619DA778
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 13:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F4812823E5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 12:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF83A1FBC92;
	Wed, 27 Nov 2024 12:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rpr2eo4z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2586A1F9EBB
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 12:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732709506; cv=none; b=F8aAXUMaPAGBWHaoaNpTgxGzokduqHGYFBvsoje4tYImmjeKB3LiYdejJWX4WkL36ZnnftE9fI75uSJg1RsR0A4BM4PTfUgHEhuHmCe815ibqBG6vHtEN7fPRUgmpA/81jUY5RkkX/HSYHKPQNoWpl9f7IVT6scWuCwl4tNbcxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732709506; c=relaxed/simple;
	bh=JN2wPJZx2zdhQFaSk5PktlR218KRyw8uJMfJmU+wUIU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fQeK63zMywZaaQToikATDsKPKq277GlwT6FS9t8juFpVYzZVCn5gJDj1mGVhchQJiktYsHdOUku28DbBFBTFYI6KOoYdQGHoKUlKkdSZhb0IGD4D8MC/2relVZrUfNLB2ODOiBNJABEAFK565vzwlbrn6TZFQkbGEinHh+B0HHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rpr2eo4z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24DCFC4CECC;
	Wed, 27 Nov 2024 12:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732709505;
	bh=JN2wPJZx2zdhQFaSk5PktlR218KRyw8uJMfJmU+wUIU=;
	h=Date:From:To:Cc:Subject:From;
	b=Rpr2eo4zYJMkSvFKp4oNu2T/cXGWG1Lj+0GaZHbW/CI+eOgaDH6ri8wmOMiYYdFhd
	 dOYwOwXe2NjieUmBbu8bEHm7tNpozNCh61ZpquyMyLwdb0L4XsZ4zbdaxON9Fla5JK
	 vgpb6STbGI20uUY3lblC1o3DsI5ogPbBNu14vJvpZsJY127aTkVVhozaFYyY5tVfsw
	 zZJgh4/gXInuk+i0bYMRFVWZ2mQBE/GGKu/dfIKaInJo1hTCqUaZGz8UaSyxXOSdoA
	 mxOIEF/PDq4mr4oafB1EivymJ7vsOhLRRq8/LyciBY/3l4H3iTWBYwtMTPqqotjggO
	 bmMJQbON601/w==
Date: Wed, 27 Nov 2024 17:41:41 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: Soundwire subsystem updates for v6.13
Message-ID: <Z0cMfSejvRoYihYJ@vaman>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8LSQKTx+M1qPNAWY"
Content-Disposition: inline


--8LSQKTx+M1qPNAWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Please pull to receive the last request for the evening to get soundwire
subsystem updates which include bus structure optimization, support for
soundwire 2.0 disco spec and updates to amd and cadence drivers.

With this also, you might see a merge conflict with sound tree. Again,
the resolution should be simple and one exists in the next tree as well.

The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:

  Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/so=
undwire-6.13-rc1

for you to fetch changes up to dd690b31de0ed46adc5856698880560b900386ba:

  soundwire: Minor formatting fixups in sdw.h header (2024-11-14 12:11:17 +=
0530)

----------------------------------------------------------------
soundwire updates for 6.13

 - structure optimization of few bus structures and header updates
 - support for 2.0 disco spec
 - amd driver updates for acp revision, refactoring code and support for
   acp6.3
 - soft reset support for cadence driver

----------------------------------------------------------------
Charles Keepax (2):
      soundwire: Update the includes on the sdw.h header
      soundwire: Minor formatting fixups in sdw.h header

Pierre-Louis Bossart (17):
      soundwire: mipi_disco: add MIPI-specific property_read_bool() helpers
      soundwire: optimize sdw_stream_runtime memory layout
      soundwire: optimize sdw_master_prop
      soundwire: optimize sdw_bus structure
      soundwire: optimize sdw_slave_prop
      soundwire: optimize sdw_dp0_prop
      soundwire: optimize sdw_dpn_prop
      soundwire: mipi-disco: remove DPn audio-modes
      soundwire: mipi-disco: add error handling for property array read
      soundwire: mipi_disco: add support for clock-scales property
      soundwire: mipi-disco: add support for peripheral channelprepare time=
out
      soundwire: mipi-disco: add comment on DP0-supported property
      soundwire: mipi-disco: add new properties from 2.0 spec
      soundwire: mipi-disco: add support for DP0/DPn 'lane-list' property
      soundwire: intel_auxdevice: add kernel parameter for mclk divider
      soundwire: cadence: add soft-reset on startup
      soundwire: cadence: clear MCP BLOCK_WAKEUP in init

Shen Lichuan (1):
      soundwire: Correct some typos in comments

Vijendar Mukunda (4):
      soundwire: amd: pass acp pci revision id as resource data
      soundwire: amd: refactor existing code for acp 6.3 platform
      ASoC: SOF: amd: pass acp_rev as soundwire resource data
      ASoC: amd: ps: pass acp pci revision id as soundwire resource data

 Documentation/admin-guide/kernel-parameters.rst |   1 +
 Documentation/admin-guide/kernel-parameters.txt |   4 +
 drivers/soundwire/amd_init.c                    |   1 +
 drivers/soundwire/amd_manager.c                 |  99 ++++++----
 drivers/soundwire/amd_manager.h                 |  16 +-
 drivers/soundwire/bus.c                         |   2 +-
 drivers/soundwire/cadence_master.c              |  30 +++
 drivers/soundwire/cadence_master.h              |   1 +
 drivers/soundwire/intel_auxdevice.c             |  12 +-
 drivers/soundwire/intel_bus_common.c            |   6 +
 drivers/soundwire/mipi_disco.c                  | 144 +++++++++++---
 drivers/soundwire/qcom.c                        |   2 +-
 drivers/soundwire/sysfs_slave.c                 |   2 +-
 include/linux/soundwire/sdw.h                   | 245 +++++++++++---------=
----
 include/linux/soundwire/sdw_amd.h               |   6 +
 sound/soc/amd/ps/acp63.h                        |   2 +
 sound/soc/amd/ps/pci-ps.c                       |   2 +
 sound/soc/sof/amd/acp.c                         |   1 +
 18 files changed, 368 insertions(+), 208 deletions(-)

--=20
~Vinod

--8LSQKTx+M1qPNAWY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmdHDH0ACgkQfBQHDyUj
g0dEOA/+LmZutrFaozY/OonmP97ThjdksqdULamh3ZcJ61lrKoKM6Dg2ygRg8xw0
ZTGXUXWywl0FWptsXlx/PehyJoaEcNFgyPM16D/gqFl3RdLXqsw8j/9Wh/y21YIt
66lQsa2AVtv5NuRt7xmlglO3kD5jsPMcyvpjC6xb/XIZ3GmL5wSVZvYpMiEDmtYA
MYTMdkV4WGmApS9+c0GoqBRqlaoeOcWJuhlTGilCQbmusQZnefrFngApTBEHvg2R
gTzN8wGid0QAmusVl+2zQd8/Gkv6kmxyUYoLn+I3e8BxG4JhNDmFjvVJ8JPi8kYK
lbyzBkw/k02MJMw5b+EYOv+L4ZksDFGQoxx8Ecu9OGm7A98GaPMfL7RepBLB5VKL
TsCDy7Ogof7mgzKmXeKVeZvoEe8h7eDFY6p7vZLegAMTJh8JQumgrLRvR3f8Au2t
e413tDHYwYYptd3Dj2v6h6cQE7Hp+dvYPqM4tHZJgZp8Rm5xjNpVp+BSPOQsxB5r
I62QX+zwf2goKY0I2MavMImupqHmpKv2kmfZJVeFojwcyuzlcAb9UrS/hUnXbN58
1Dh5F1jZzn6Ilts3qy3Gy+stv3d/Ect+tfapRaLGybvjZmYF3YLicMwXkpwZy63Y
YULjEDFFN5vguTl87geW2K0CmsXcBGEc5LBewemwYmDHzJ9KUls=
=qjnC
-----END PGP SIGNATURE-----

--8LSQKTx+M1qPNAWY--

