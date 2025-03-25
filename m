Return-Path: <linux-kernel+bounces-574630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 487FBA6E7CA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 01:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 691B53AF63A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 00:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE28D8635D;
	Tue, 25 Mar 2025 00:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AhM0ZPQr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FC4EAFA;
	Tue, 25 Mar 2025 00:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742864051; cv=none; b=mYRs9mnTLR4G+xWhWwgmg4qobGeH1zUiwrWanGEbiZ3eC+LWN8ZYYP3WzwzOgYn9J87Ym2wGbgYHbuLBfiPXHjPLENNDq7simFXo3Yi5dBNkDIsVX+lac1kYqcFsfcgRRtaD+XPAnOerNuJeu77zVMnLZ6eUKs/YTI8P3jTuzYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742864051; c=relaxed/simple;
	bh=19/+9+66+RjVQMX6jsfvVF3TmrlKGJn9JVjXXbspNis=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bWVpRWqnwlXcAe+uR/wfeJDWZZpn7en0kFOay7treHu2eWrqcebNvOw/KHoj2eICSJkXqQo838tb8pJ5AHIIGZ7vt5wlIyHzQUdERXDYe5ev7JbZZDMo4yG1/+9gZeBLoy5277GsSbtEsQlCAWN80B8GRgtNYy+ALsE8SvFh/v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AhM0ZPQr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD74EC4CEDD;
	Tue, 25 Mar 2025 00:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742864049;
	bh=19/+9+66+RjVQMX6jsfvVF3TmrlKGJn9JVjXXbspNis=;
	h=Date:From:To:Cc:Subject:From;
	b=AhM0ZPQr2Ztm+X5xRgoSkkEc9FXrGBkKVhFRSNJdO7oKg36YB1OQUrrq7GLdP9sL6
	 KQq2AhV/Kgz0bikdQCEu3u6K/Yi3bC1MSLP8j9KLNMHEmuTMJXUf6ixsMWwk143gy5
	 uMXZWE2sn4EniroMRbJYHkh/KYHfO5m6gqHwqfEX1sepAq4aVPY1aBzVQpzB+nhPWi
	 IgMxTXfNzKnLZUj6Wr1aLuECocAie5sSLZn492V62YVJwjxC0Fx4s5SecnYOenkllH
	 iBPBv/+BIis5IgBPZ3toCRYy07QcrEXYpHt6StsKnoD5UcOzfqtxzeYhFMw1fj0ZnD
	 35Lu4+6TeV+Gg==
Date: Tue, 25 Mar 2025 00:54:06 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: torvalds@linux-foundation.org
Cc: bleung@chromium.org, tzungbi@kernel.org, linux-kernel@vger.kernel.org,
	chrome-platform@lists.linux.dev
Subject: [GIT PULL] chrome-platform updates for v6.15
Message-ID: <Z-H-ruKeKIiX0CEk@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="e5SKASR1rfUXPxCM"
Content-Disposition: inline


--e5SKASR1rfUXPxCM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull chrome-platform updates for Linux v6.15.

Thanks,
Tzung-Bi
------

The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git tags/chrome-platform-v6.15

for you to fetch changes up to 9fc83373f0ffb8834da48b1446a5c2fef9525bb1:

  platform/chrome: cros_ec_typec: Add support for setting USB mode via sysfs (2025-02-21 01:42:22 +0000)

----------------------------------------------------------------
chrome-platform: Updates for v6.15

* New

  - Support ACPI match for Framework systems.
  - Expose new sysfs for:
    - PD mux status for each EC-managed Type-C port.
    - EC feature of AP mode entry.
    - Setting USB mode of EC Type-C.

----------------------------------------------------------------
Andrei Kuchynski (3):
      platform/chrome: cros_ec_sysfs: Expose PD mux status
      platform/chrome: cros_ec_sysfs: Expose AP_MODE_ENTRY feature state
      platform/chrome: cros_ec_typec: Add support for setting USB mode via sysfs

Benson Leung (1):
      MAINTAINERS: Update maintainers for ChromeOS USBC related drivers

Daniel Schaefer (1):
      platform/chrome: cros_ec_lpc: Match on Framework ACPI device

 Documentation/ABI/testing/sysfs-class-chromeos | 20 ++++++++
 MAINTAINERS                                    |  9 +++-
 drivers/platform/chrome/cros_ec_lpc.c          | 22 +++++---
 drivers/platform/chrome/cros_ec_sysfs.c        | 71 ++++++++++++++++++++++++++
 drivers/platform/chrome/cros_ec_typec.c        | 28 ++++++++++
 drivers/platform/chrome/cros_ec_typec.h        |  1 +
 6 files changed, 141 insertions(+), 10 deletions(-)

--e5SKASR1rfUXPxCM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQS0yQeDP3cjLyifNRUrxTEGBto89AUCZ+H+qwAKCRArxTEGBto8
9DbDAQChyFVtrsPR6N62RoMws1DE6pkNgIlviAVGfCA8+q6mDQEAvLyIG0HKYKnM
1LbPtAZwTh0Js6nIp8qAMb3KmtrsOQA=
=fAVN
-----END PGP SIGNATURE-----

--e5SKASR1rfUXPxCM--

