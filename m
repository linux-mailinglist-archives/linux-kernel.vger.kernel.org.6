Return-Path: <linux-kernel+bounces-184584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 961C38CA92B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 09:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8D081C217C1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 07:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F4B524D6;
	Tue, 21 May 2024 07:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NPrvlaAW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374C251C49
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 07:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716277310; cv=none; b=SKb1XHLJWIEHu9lCrUAk1fNsWYILjD94ilo2Y3o58xnupdhP0+q+umCgEu/51am6gnknFxORHTMokCOXGQ4WEn5WdWzC9ZTcyRb8p7RvYQXl+sIPrp4u9gv+COT1oywgUEkz4yMl3YSdBtaFv1nlS1/4/wpwz2mOA11QDsAARKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716277310; c=relaxed/simple;
	bh=fFHb4IvKsJ/FJ57OiQUokeqzIuDvktQiCaQrNEdks/k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Gj6YeAV3sKNde3HonZOokra2JTnKFp6Fay2h6hHa4KdPFtaSVWH3kbXbYxoMfVA+nRPGe4EQW+hIFoa/GGfTwIJIgeJlrOiaDevfj8n+imeMXv7xhOv4Eub8aNY/BjMACNh0ib3VPVefgAUYzL9QjVKt3XUQnqGhRdf6VfG6TN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NPrvlaAW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43C9AC2BD11;
	Tue, 21 May 2024 07:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716277309;
	bh=fFHb4IvKsJ/FJ57OiQUokeqzIuDvktQiCaQrNEdks/k=;
	h=Date:From:To:Cc:Subject:From;
	b=NPrvlaAWBZ+8J4vSsNvNqOnKrYlbQbbqe0BKziBQuLD3LxBjeJ4tlMNam6omPGd5d
	 pw77rQfMsCaL+c1uKxGz0kIupmmnQ1ObCqfzQhAAtBcmyQgyJtPvIw45/ZBphAoxlb
	 olaOjJxHq+wbzsgPGTbycJEDSQs2bKtY0XlAw45Q3a16XR1CPkh4BqPhfg9/2bEhvI
	 CHXaplEmxJnG5wVeJ9tWPyg4Lz3ftojee13kqOIuqnqRBb4Gkb06Fnq0QrMg0UrlQ6
	 btRDaPRE2wOYkdn/V4XuHl5XkTzwvPLK55rUSHdClMooado3cZ/pkyFMfQObxzjABr
	 KNn3bSwnlSyRg==
Date: Tue, 21 May 2024 13:11:45 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: soundwire updates for v6.10
Message-ID: <ZkxQObZQUTGealkZ@matsya>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bwx0dWf4wvOwxB+n"
Content-Disposition: inline


--bwx0dWf4wvOwxB+n
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi again,

This is last pull request for today. Please pull to receive soundwire
subsystem updates features Greg's sysfs group cleanup, Intel ace2x and pm
improvements and qcom multi link device support.

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/so=
undwire-6.10-rc1

for you to fetch changes up to a0df7e04eab07cb2c08517209f792a8070504f0d:

  soundwire: intel_ace2.x: add support for DOAISE property (2024-05-04 18:2=
6:50 +0530)

----------------------------------------------------------------
soundwire updates for 6.10

 - cleanup and conversion for soundwire sysfs groups
 - intel support for ace2x bits, auxdevice pm improvements
 - qcom multi link device support

----------------------------------------------------------------
Bard Liao (3):
      soundwire: intel_auxdevice: use pm_runtime_resume() instead of pm_req=
uest_resume()
      soundwire: intel: export intel_resume_child_device
      soundwire: intel_init: resume all devices on exit.

Greg Kroah-Hartman (5):
      soundwire: sysfs: move sdw_slave_dev_attr_group into the existing lis=
t of groups
      soundwire: sysfs: cleanup the logic for creating the dp0 sysfs attrib=
utes
      soundwire: sysfs: have the driver core handle the creation of the dev=
ice groups
      soundwire: sysfs: remove sdw_slave_sysfs_init()
      soundwire: sysfs: remove unneeded ATTRIBUTE_GROUPS() comments

Krzysztof Kozlowski (1):
      soundwire: qcom: allow multi-link on newer devices

Pierre-Louis Bossart (21):
      soundwire: bus: don't clear SDCA_CASCADE bit
      soundwire: cadence: fix invalid PDI offset
      soundwire: cadence: remove PDI offset completely
      soundwire: remove unused sdw_bus_conf structure
      soundwire: clarify maximum allowed address
      soundwire: cadence: show the bus frequency and frame shape
      soundwire: bus: extend base clock checks to 96 MHz
      soundwire: intel: add more values for SYNCPRD
      soundwire: intel: add support for MeteorLake additional clocks
      soundwire: intel_ace2x: move and extend clock selection
      soundwire: intel_ace2.x: power-up first before setting SYNCPRD
      soundwire: intel_ace2x: set the clock source
      soundwire: reconcile dp0_prop and dpn_prop
      soundwire: intel_ace2x: use legacy formula for intel_alh_id
      ASoC: SOF: Intel: hda: disable SoundWire interrupt later
      soundwire: intel_ace2x: fix wakeup handling
      soundwire: intel_ace2x: simplify check_wake()
      soundwire: intel_ace2x: cleanup DOAIS/DODS settings
      soundwire: intel_ace2x: use DOAIS and DODS settings from firmware
      soundwire: intel_ace2.x: add support for DODSE property
      soundwire: intel_ace2.x: add support for DOAISE property

Ranjani Sridharan (1):
      soundwire: intel: add intel_free_stream() back

Uwe Kleine-K=F6nig (1):
      soundwire: qcom: Convert to platform remove callback returning void

Vijendar Mukunda (1):
      soundwire: amd: use inline function for register update

 drivers/soundwire/amd_init.c            |  36 +++++-----
 drivers/soundwire/amd_init.h            |   8 +++
 drivers/soundwire/amd_manager.c         |  13 ++--
 drivers/soundwire/bus.c                 |  14 ++--
 drivers/soundwire/bus_type.c            |   5 +-
 drivers/soundwire/cadence_master.c      |  36 ++++------
 drivers/soundwire/intel.c               |  68 ++++++++++++++++--
 drivers/soundwire/intel.h               |   7 ++
 drivers/soundwire/intel_ace2x.c         | 119 +++++++++++++++++++++++-----=
----
 drivers/soundwire/intel_auxdevice.c     |  41 +++++++++--
 drivers/soundwire/intel_auxdevice.h     |   1 +
 drivers/soundwire/intel_init.c          |  14 ++++
 drivers/soundwire/qcom.c                |  28 ++++++--
 drivers/soundwire/sysfs_local.h         |   4 +-
 drivers/soundwire/sysfs_slave.c         |  66 +++++++++---------
 drivers/soundwire/sysfs_slave_dpn.c     |   3 +
 include/linux/soundwire/sdw.h           |  19 ++---
 include/linux/soundwire/sdw_intel.h     |  11 ++-
 include/linux/soundwire/sdw_registers.h |   2 +-
 sound/soc/sof/intel/hda.c               |   4 +-
 20 files changed, 338 insertions(+), 161 deletions(-)

--=20
~Vinod

--bwx0dWf4wvOwxB+n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmZMUDkACgkQfBQHDyUj
g0dHfw/+OqCuwNkLnrCaFx2DuaNzV+5HoWl9t8wgbzXxvYzklyCvXWlFlWGV5+LZ
EFghhNlBEKUATbK4xkH8p1SGbByeF2PKjXd2P7Uu60wZ2Rd6ix1gKfZZXmK349/p
AKTitMatekUiKVDd1KIBoPGUIn9PIRblYJK9oGb4iD+c/FE/p+koSCrmEcWczZS+
9HCJSARKF6E/g/QWGxsyo06DxLAMI+p4Hbjiy+KbWmTpisSvP8QB7f8/FIAk43qC
gO3rDpA3dEH62BsU9kM+dclD8Rxf0CI8HbTs3NXQduHK9AIQTtIf1JzlRsBUZtGq
gBjkSWF55Vii5uyMPQJ/NPBzaUw0Ybkz+djHbevCqcf/P9Bde69NlQc2tMpwpzyC
0C1IkcOLmn+mpGwJyKindjugKnfogclAnZby/LSdReE/pxh/UiY2ieAKQjo/hzDU
WZxFhWDla1b2FaDTSSyi6S/lioHdbIBxh+cMQUYpUlsxL+KK7g2c59HBKtGQ9bSp
WmE3eddh8REAegFr/Ic6g9auWBcqi8SWoryvOCSqc8jcwhpsGpeHS7ZkdjRnNWpy
LJYHLJ+2+UcuJC/2SlTuC3roWI2m7yWRv2LUipIUnGI5YmDNnQfdk/QAw+od8chc
Za/MGg8kgOErrOYiWEssRJ/aZnGidO7b/jXRN/hjVsCjWmb1fZs=
=OaIO
-----END PGP SIGNATURE-----

--bwx0dWf4wvOwxB+n--

