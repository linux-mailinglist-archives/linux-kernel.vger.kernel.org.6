Return-Path: <linux-kernel+bounces-412300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D39399D0743
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 01:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D4DD1F21A73
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 00:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E227483;
	Mon, 18 Nov 2024 00:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZtZcX8Qw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED08438B;
	Mon, 18 Nov 2024 00:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731889934; cv=none; b=rfRtLqY74qWwzv70khgHhU89D736hhI18g+H5ntwQEMxHCOcYc+UQzwxmr/eiJ6KRUn5M+B2BNtulfy7DPnSEDbre69nayqjtS0CXKYRL0hVnRLXLhxOu4mBEcNz+0SzfYHgvUN9M4tSI52n4YU5joQB0zpQ7RRnW+XOeCF5mmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731889934; c=relaxed/simple;
	bh=L9eIWFqoXmiuRFw9RfTY4KAd+neuOLpgbIFwyjX1cHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jF99GjIMultdrYXxVqMzqY6wM2E5nMyt6cnYTaV8vxR8JyIOllbV5QbrisPkLgQ8HTr7vw13tGamBmLYV/SCZC/zO5KpKDAt+ozjVtHgEHH1Po8ZVylSR3aiO2p/KudElyDmaISegEqSxHfUJ5DLS22kd/35xMap9at27WxiEGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZtZcX8Qw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5105EC4CECD;
	Mon, 18 Nov 2024 00:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731889933;
	bh=L9eIWFqoXmiuRFw9RfTY4KAd+neuOLpgbIFwyjX1cHQ=;
	h=Date:From:To:Cc:Subject:From;
	b=ZtZcX8QwT94XIXkqP9yLTnzpiHivuXYQ8P7+SNL5OYzhLoDwWgLADb7YhvBc6vg4K
	 0tiV55/T8Zr57f1sWnZxjKqkJ3x1KFUWFPg8MXOtrf9222HLfyakq09ynALTjkd9d0
	 pRWb5VZ13O9se/mqkzkp2Ql6kNNQbxeUB3r7PkvxK25BjM5kvOwe8WuGFWgZvISUMq
	 l+8k1FJ/1NOx0FoEhjXEQCYSCqZ8YCsD3PVeTV4h5PPfstSN2Zy3B9ZSQC1hnsphPY
	 BDgJHSo4Jph/o4EOCT+McDNu+vSp8TY1zGHvbK3rgQ91lkm/vk6YWo9OlVTaHhl4z4
	 qJIXKYsWtAkxg==
Date: Mon, 18 Nov 2024 00:32:10 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: torvalds@linux-foundation.org
Cc: pmalani@chromium.org, bleung@chromium.org, groeck@chromium.org,
	tzungbi@kernel.org, linux-kernel@vger.kernel.org,
	chrome-platform@lists.linux.dev
Subject: [GIT PULL] chrome-platform changes for v6.13
Message-ID: <ZzqLCvx94JhkBmEP@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vc1NQ08x9iOiuR1K"
Content-Disposition: inline


--vc1NQ08x9iOiuR1K
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:

  Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git t=
ags/chrome-platform-for-6.13

for you to fetch changes up to ea45f3f46734a47bdbcfb31f41748484219d2ea6:

  platform/chrome: Switch back to struct platform_driver::remove() (2024-10=
-28 08:48:34 +0000)

----------------------------------------------------------------
chrome platform changes for 6.13

* Fixes

  - Fix a leak of fwnode refcount.

* Cleanups

  - Drop unused I2C driver data.
  - Move back from platform_driver::remove_new() to
    platform_driver::remove().

----------------------------------------------------------------
Javier Carrasco (1):
      platform/chrome: cros_ec_typec: fix missing fwnode reference decrement

Uwe Kleine-K=F6nig (2):
      platform/chrome: Drop explicit initialization of struct i2c_device_id=
::driver_data to 0
      platform/chrome: Switch back to struct platform_driver::remove()

 drivers/platform/chrome/cros_ec_chardev.c    | 2 +-
 drivers/platform/chrome/cros_ec_debugfs.c    | 2 +-
 drivers/platform/chrome/cros_ec_i2c.c        | 2 +-
 drivers/platform/chrome/cros_ec_lightbar.c   | 2 +-
 drivers/platform/chrome/cros_ec_lpc.c        | 2 +-
 drivers/platform/chrome/cros_ec_sysfs.c      | 2 +-
 drivers/platform/chrome/cros_ec_typec.c      | 3 ++-
 drivers/platform/chrome/cros_ec_vbc.c        | 2 +-
 drivers/platform/chrome/cros_hps_i2c.c       | 2 +-
 drivers/platform/chrome/cros_typec_switch.c  | 2 +-
 drivers/platform/chrome/cros_usbpd_logger.c  | 2 +-
 drivers/platform/chrome/cros_usbpd_notify.c  | 4 ++--
 drivers/platform/chrome/wilco_ec/core.c      | 2 +-
 drivers/platform/chrome/wilco_ec/debugfs.c   | 2 +-
 drivers/platform/chrome/wilco_ec/telemetry.c | 2 +-
 15 files changed, 17 insertions(+), 16 deletions(-)

--vc1NQ08x9iOiuR1K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQS0yQeDP3cjLyifNRUrxTEGBto89AUCZzqLCQAKCRArxTEGBto8
9ApLAP4qa6WjKDVBG2nSATTjSr4ZViW4HnQ/4Ew84WizjPfHKQEArxlOXIapg7rx
ejDb+N7T1Ng+4iZXyBrK186UHkIsNA8=
=tGCY
-----END PGP SIGNATURE-----

--vc1NQ08x9iOiuR1K--

