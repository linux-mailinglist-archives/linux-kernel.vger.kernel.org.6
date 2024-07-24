Return-Path: <linux-kernel+bounces-260724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B6793AD6C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 09:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8460D1C20E62
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 07:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE527EF04;
	Wed, 24 Jul 2024 07:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hkBo8tFO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15D554670
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 07:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721807438; cv=none; b=p3e60pMtYvCYJiGTdoj3TxIKnJyiLYCakbsz9AdprK6Ia6b3Pmaql6j5L549FO4xaEcnRmmnoQsgTBOOa+gQYVb10TI2Rbqcz28tnrMvrgNKJpBZv2U8VcRQpMbow4Y+PUfe4rZBEqEElsFBj6ErgugjQHFyt5jKbk4iunMrpC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721807438; c=relaxed/simple;
	bh=RAmXQCw07fTbVpKuwEiTrLTTMqx6uK7j8eioR44GOSE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uUlbNU4inULeyc854jts8ZWiggs2oFCyamdCAyFZl41FV0iD4aoklL0A3+oR0aAnMgTLrYgGPUv1dKus7TRPhzq7SElZFySsiAZOZt6PhXiQtbg5p66Fr/ZNQm+us+NBhf5Rsloo/LfCfHDKTWOgT+EIl9+k8j6lHuiIzt0N2j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hkBo8tFO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C7CBC32782;
	Wed, 24 Jul 2024 07:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721807438;
	bh=RAmXQCw07fTbVpKuwEiTrLTTMqx6uK7j8eioR44GOSE=;
	h=Date:From:To:Cc:Subject:From;
	b=hkBo8tFOGpyPI9eWsHVL25y/EMPyg8WpPBY7B0evrDEBkRIyWEZsNx0YR2BViLNep
	 NiLzHavIeQdARQrspRdN3ceCzSkHkrXQHgEs9LE4h9qNVyEcdANKUTkt5tkANE4Uj8
	 IyNZj/bGKcVyNSuv1Jpc+AgrgA8h8qhiKJdBxy7hR8V/fgrgwNOHQCCxy7o2iBp4Em
	 L522fYcsLhg2CwKT7mhCkvDh0dfKT/iRomvHrTPVsEpIXc/G8T1dE2aAcLqWuDZzZQ
	 vfdgE3py+WsA3YrQw2yNJySX0KUlOYcIoSVrAOWt7WZd4ao8CY8QQVLbzazwMZySmj
	 vQ64NnQgByilw==
Date: Wed, 24 Jul 2024 13:20:33 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: Soundwire updates for v6.11
Message-ID: <ZqCySVLF6zqfnG_C@matsya>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XJG5oV6dLusnWwqG"
Content-Disposition: inline


--XJG5oV6dLusnWwqG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Last one in the lot for the soundwire subsystem updates. Fairly small
one with a cleanup pile, debugfs command support and typical updates
to drivers

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/so=
undwire-6.11-rc1

for you to fetch changes up to fdd3d14ca3c8c5269174f10d33d6181173cbd0b4:

  soundwire: debugfs: simplify with cleanup.h (2024-07-09 19:12:49 +0530)

----------------------------------------------------------------
soundwire updates for 6.11

 - Simplification across subsystem using cleanup.h
 - Support for debugfs to read/write commands
 - Few Intel and Qualcomm driver updates

----------------------------------------------------------------
Bard Liao (2):
      soundwire: generic_bandwidth_allocation: change port_bo parameter to =
pointer
      soundwire: intel_auxdevice: add cs42l43 codec to wake_capable_list

Krzysztof Kozlowski (10):
      soundwire: bus: simplify by using local slave->prop
      soundwire: amd: simplify return path in hw_params
      soundwire: amd: simplify with cleanup.h
      soundwire: amd_init: simplify with cleanup.h
      soundwire: intel: simplify return path in hw_params
      soundwire: intel: simplify with cleanup.h
      soundwire: intel_ace2x: simplify return path in hw_params
      soundwire: intel_ace2x: simplify with cleanup.h
      soundwire: cadence: simplify with cleanup.h
      soundwire: debugfs: simplify with cleanup.h

Pierre-Louis Bossart (5):
      soundwire: debugfs: add interface to read/write commands
      soundwire: bus: add stream refcount
      soundwire: intel_ace2.x: add AC timing extensions for PantherLake
      soundwire: Intel: clarify Copyright information
      soundwire: intel_auxdevice: start the bus at default frequency

Srinivas Kandagatla (1):
      drivers:soundwire: qcom: cleanup port maask calculations

 drivers/soundwire/amd_init.c                     |   7 +-
 drivers/soundwire/amd_manager.c                  |  13 +-
 drivers/soundwire/bus.c                          |   6 +-
 drivers/soundwire/cadence_master.c               |   5 +-
 drivers/soundwire/debugfs.c                      | 157 +++++++++++++++++++=
+++-
 drivers/soundwire/generic_bandwidth_allocation.c |  14 +-
 drivers/soundwire/intel.c                        |  25 ++--
 drivers/soundwire/intel.h                        |   5 +
 drivers/soundwire/intel_ace2x.c                  |  39 +++---
 drivers/soundwire/intel_ace2x_debugfs.c          |   2 +-
 drivers/soundwire/intel_auxdevice.c              |  42 ++++++
 drivers/soundwire/intel_bus_common.c             |   2 +-
 drivers/soundwire/qcom.c                         |  22 +---
 drivers/soundwire/stream.c                       |   5 +
 include/linux/soundwire/sdw.h                    |   2 +
 include/linux/soundwire/sdw_intel.h              |   5 +
 16 files changed, 271 insertions(+), 80 deletions(-)

--=20
~Vinod

--XJG5oV6dLusnWwqG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmagskkACgkQfBQHDyUj
g0dMzg//YwiKDDQR9qnvBLGv2ndhv/uX8eMVjOpPWqkRYlogKbqY3fUUYPy6Laze
V9bO3PLqwH8GmFrVzmwqjiwx2AOWOKGjDExOglEziztjH1mXSUvc8HaQbqhuudoq
bRPe0i7ImYDoy+Mit2S0FzouTGhPAOVUPYU29r6tekG7XgB2DXK6qngdJ45jcCcK
tTqKj8P1FgKJ2mK/0zSogY7kDmXp9XdOgpUrKZXA+GC0QpKzDl/HjNYOst4hYEan
FimSXEx6srpnVmI8qbnb2B6tCuJV7mM8D4Wapr9b6Aihrp1PBP8ocI9l3A8ANZwI
6cq3jfHQR79qBt6RCytzo7eR0BlgKalAQFVQ7W0VhdxDnwTV/jvTXC7Qnl7g5P+r
EyQ0EIRm0bHrUc/FFZnFskepe2XYrg0UDEaIad5z6qqfzjYPJYcaM1YOjWw25yUM
kUurC2xmkaFurS42gvUu8rritDICCNlsOtaQ6bvdTgToEwIocOodo5hPyUdqI6NO
fxMimmXQ7RMi4D87yCXKg4Wnd6PDlj4Bjxue/HLFqQuJXoZAeKGnqM801hdku6TV
TTFwoDBIuRTPwMDU1f4CXypd+fYh93fWgMqPGz2XfifAwS2DYsBQPpq3JUnQe8h2
W7EdrejTXc2VDux88A2jH1N2I/hOHnmwnPntJ42wwjDw5YaaQ+w=
=3m2l
-----END PGP SIGNATURE-----

--XJG5oV6dLusnWwqG--

