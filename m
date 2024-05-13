Return-Path: <linux-kernel+bounces-177140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 453BF8C3AB2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 06:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31F6BB20D1C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 04:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E735145B10;
	Mon, 13 May 2024 04:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D1CsIzof"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB495282EB;
	Mon, 13 May 2024 04:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715574300; cv=none; b=Kz5hO55ggiPXYl3+cPGL3+kd3HFjT0cziTjrIrOw5R9EDHQdDGpC0/TeSWvG31wnNXoVL1MslzViW62o4hdCQoGuew4+YNZ/WmjxIT+0fjjEkv6WdtDdFoLZakqo8GytQGPo4CAFXTA0T4yfqS1xm0kCNxBvU7xtZtTZy++bRcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715574300; c=relaxed/simple;
	bh=HVa2ICxwgme79yx6fL24Vjxdi+QLhrLVxIjYjFyqGQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=B0rZ8o/sJORTPzDkG2h7+6YdIQg0338MUgcaZm9sU4iwmFt+rTZQuxZq1K77zPC4PZRXoBbDpNpVnjskkrLPHysqbc+1EXlyUxuy/vkhSz9f8K6PUwmfJft8D38a0fke+7rblw+g6fTTJoCUrgEVJtdIKcWvcSnckbS7QuCOZSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D1CsIzof; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09C38C113CC;
	Mon, 13 May 2024 04:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715574300;
	bh=HVa2ICxwgme79yx6fL24Vjxdi+QLhrLVxIjYjFyqGQ4=;
	h=Date:From:To:Cc:Subject:From;
	b=D1CsIzof780rZGAyJsrQvfhOas0cY9KWS/EWRUY0vIZaqEHDgC3xmwkcMAPGOBrHL
	 Og9SJwAj7A+5jg6j0wFyZa98/t/OROnTWW43ugBfnd8YANQzxuRkSLIoGmeK/bFj3/
	 IqO7VcFOkCThkOB1p+kzJ8u7DW6P7peloZ75O7Wz42NsfxiQTsAonRzZGVGhbp8ClV
	 DiONBWAQFyrQ+dxlFEKZdzQb2px8oRjXZCZpBvB2svlN2NbAcea6RUPsGjf8LuECE/
	 5kqgGTFgDnqZ2Zl+KhQYWWTC4Gr9rr1zRcJ1wABpAZWQnDcoQKsNPs5asZtxl67zo5
	 ctAzfs45DCKKQ==
Date: Mon, 13 May 2024 12:24:57 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: torvalds@linux-foundation.org
Cc: pmalani@chromium.org, bleung@chromium.org, groeck@chromium.org,
	tzungbi@kernel.org, linux-kernel@vger.kernel.org,
	chrome-platform@lists.linux.dev
Subject: [GIT PULL] chrome-platform changes for v6.10
Message-ID: <ZkGWGbzFu3rmDElk@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wgX0BMhip2wNAZfo"
Content-Disposition: inline


--wgX0BMhip2wNAZfo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull chrome-platform changes for v6.10.

Thanks,
TzungBi

The following changes since commit 0bbac3facb5d6cc0171c45c9873a2dc96bea9680:

  Linux 6.9-rc4 (2024-04-14 13:38:39 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git tags/tag-chrome-platform-for-v6.10

for you to fetch changes up to 2fbe479c0024e1c6b992184a799055e19932aa48:

  platform/chrome: cros_ec: Handle events during suspend after resume completion (2024-04-30 09:38:04 +0800)

----------------------------------------------------------------
chrome platform changes for 6.10

* New

  - Support Framework Laptop 13 and 16 (AMD Ryzen).

* Improvements

  - Use sysfs_emit() instead of sprintf() for sysfs' show().

* Fixes

  - Fix flex-array-member-not-at-end compiler warnings by using
    DEFINE_RAW_FLEX().
  - Add HAS_IOPORT dependencies.
  - Fix long pending events during suspend after resume.

* Misc cleanups

  - Provide ID tables for avoiding fallback match.
  - Replace deprecated UNIVERSAL_DEV_PM_OPS().

----------------------------------------------------------------
Ai Chao (1):
      platform/chrome: wilco_ec: use sysfs_emit() instead of sprintf()

Andy Shevchenko (1):
      platform/chrome: cros_hps_i2c: Replace deprecated UNIVERSAL_DEV_PM_OPS()

Dustin L. Howett (4):
      platform/chrome: cros_ec_lpc: introduce a priv struct for the lpc device
      platform/chrome: cros_ec_lpc: pass driver_data from DMI to the device
      platform/chrome: cros_ec_lpc: add a "quirks" system
      platform/chrome: cros_ec_lpc: add quirks for the Framework Laptop (AMD)

Gustavo A. R. Silva (1):
      platform/chrome: cros_ec_proto: avoid -Wflex-array-member-not-at-end warnings

Karthikeyan Ramasubramanian (1):
      platform/chrome: cros_ec: Handle events during suspend after resume completion

Niklas Schnelle (1):
      platform/chrome: add HAS_IOPORT dependencies

Tzung-Bi Shih (13):
      platform/chrome: cros_ec_sensorhub: provide ID table for avoiding fallback match
      platform/chrome: cros_usbpd_logger: provide ID table for avoiding fallback match
      platform/chrome: cros_usbpd_notify: provide ID table for avoiding fallback match
      platform/chrome: cros_ec_chardev: provide ID table for avoiding fallback match
      platform/chrome: cros_ec_debugfs: provide ID table for avoiding fallback match
      platform/chrome: cros_ec_sysfs: provide ID table for avoiding fallback match
      platform/chrome: cros_ec_lightbar: provide ID table for avoiding fallback match
      platform/chrome: cros_ec_vbc: provide ID table for avoiding fallback match
      platform/chrome: wilco_ec: telemetry: provide ID table for avoiding fallback match
      platform/chrome: wilco_ec: debugfs: provide ID table for avoiding fallback match
      platform/chrome: wilco_ec: event: remove redundant MODULE_ALIAS
      platform/chrome: wilco_ec: core: provide ID table for avoiding fallback match
      platform/chrome: cros_kbd_led_backlight: provide ID table for avoiding fallback match

 drivers/platform/chrome/Kconfig                  |  1 +
 drivers/platform/chrome/cros_ec.c                | 16 ++---
 drivers/platform/chrome/cros_ec_chardev.c        |  9 ++-
 drivers/platform/chrome/cros_ec_debugfs.c        |  9 ++-
 drivers/platform/chrome/cros_ec_lightbar.c       |  9 ++-
 drivers/platform/chrome/cros_ec_lpc.c            | 81 ++++++++++++++++++++++--
 drivers/platform/chrome/cros_ec_proto_test.c     | 72 +++++++++------------
 drivers/platform/chrome/cros_ec_sensorhub.c      |  9 ++-
 drivers/platform/chrome/cros_ec_sysfs.c          |  9 ++-
 drivers/platform/chrome/cros_ec_vbc.c            |  9 ++-
 drivers/platform/chrome/cros_hps_i2c.c           |  4 +-
 drivers/platform/chrome/cros_kbd_led_backlight.c | 11 +++-
 drivers/platform/chrome/cros_usbpd_logger.c      |  9 ++-
 drivers/platform/chrome/cros_usbpd_notify.c      |  9 ++-
 drivers/platform/chrome/wilco_ec/Kconfig         |  1 +
 drivers/platform/chrome/wilco_ec/core.c          |  9 ++-
 drivers/platform/chrome/wilco_ec/debugfs.c       |  9 ++-
 drivers/platform/chrome/wilco_ec/event.c         |  1 -
 drivers/platform/chrome/wilco_ec/sysfs.c         |  2 +-
 drivers/platform/chrome/wilco_ec/telemetry.c     |  9 ++-
 20 files changed, 214 insertions(+), 74 deletions(-)

--wgX0BMhip2wNAZfo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQS0yQeDP3cjLyifNRUrxTEGBto89AUCZkGWGAAKCRArxTEGBto8
9AaoAQDZaJusfd9JKGW1JbIsTLSKv75wpPgvB3KxJElZR9nW8gEAxN+RfUIVi8kG
6E4y8fp5Aylu520S4SR86mwPcEMzmQM=
=MOBo
-----END PGP SIGNATURE-----

--wgX0BMhip2wNAZfo--

