Return-Path: <linux-kernel+bounces-412301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 331B59D0744
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 01:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02094281712
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 00:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA8314263;
	Mon, 18 Nov 2024 00:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k2miiFM1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F285DDDC1;
	Mon, 18 Nov 2024 00:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731889962; cv=none; b=H/F0lv/FcOD+0A1AykZ9Bwjrw1B0xnKhzwQK9xfX0QuVsLBJScZTvegMHGAhuHcBTtZDhlYhM7R2FbA8io3j8q533eqdRU0d3JSj/WQNfKMT782JsTEH39JXIy61KPP42DLTS1///l2kKgrQzF+dpmEhRuOIYnK93Fe04AHkmJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731889962; c=relaxed/simple;
	bh=06Zg9OIOwoNlFsoMh9KXLw3IyEprhjKSf0bd75tcf24=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=M/21dXwbnKv2VHXo+H/7OXHzO0Pc/GlY/bzPH2n0H7C3iHcr4dG4sjbh8F4f5kf4nGO0dyFTDuSzxOGm/48mN97Ohg3aAdyTcSTHWTdzpGI3Y9RPtFG20WYpKBQjb25Z5TTHkxACyuIH/vHAlBePnitVBq4PzN68v4DMMHT1Lxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k2miiFM1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8202CC4CECD;
	Mon, 18 Nov 2024 00:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731889961;
	bh=06Zg9OIOwoNlFsoMh9KXLw3IyEprhjKSf0bd75tcf24=;
	h=Date:From:To:Cc:Subject:From;
	b=k2miiFM1QpxPuKo8ujlW1Ys8r+dmPQpkdUz/0uf+jIiy5vvLrm+798C8YJDm737HZ
	 MO/Ffl+GYCgvKS4qZ+CRg3SpOzjRhCVBaoESU9+f9labosgjGcSnF4Xl8gbbbShZg8
	 XkRooeDnOYhikzpJ5XSDMbznoJqlq3H5iM/jLSbMAg97hO7yfA7xYtnBcOWDL9bLGw
	 h558Jv+whiH4La4a9wJNB8btaz0x48OWizOx3zggrngs2gu8BI4SY7d3iPC/LLuK0K
	 T2uhqFOeFUVWdLf1g6uBbRF+VPCloypbGw94pn0vyerNdRlvjsB6Jk5uR/wWM7bCej
	 Nq7MMXK/rcUHg==
Date: Mon, 18 Nov 2024 00:32:38 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: torvalds@linux-foundation.org
Cc: briannorris@chromium.org, jwerner@chromium.org, tzungbi@kernel.org,
	linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
Subject: [GIT PULL] chrome-platform-firmware changes for v6.13
Message-ID: <ZzqLJjQwz0adE120@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2vTng0Lkhdjc+j2z"
Content-Disposition: inline


--2vTng0Lkhdjc+j2z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:

  Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git tags/chrome-platform-firmware-for-6.13

for you to fetch changes up to 32b0901e141f6d4cf49d820b53eb09b88b1f72f7:

  firmware: google: Unregister driver_info on failure (2024-10-15 22:51:24 +0000)

----------------------------------------------------------------
chrome platform firmware changes for 6.13

* Fixes

  - Do not double register "simple-framebuffer" platform device if
    Generic System Framebuffers (sysfb) already did that.
  - Fix a missing of unregistering platform driver in error handling
    path.

----------------------------------------------------------------
Javier Martinez Canillas (2):
      firmware: sysfb: Add a sysfb_handles_screen_info() helper function
      firmware: coreboot: Don't register a pdev if screen_info data is present

Yuan Can (1):
      firmware: google: Unregister driver_info on failure

 drivers/firmware/google/framebuffer-coreboot.c | 14 ++++++++++++++
 drivers/firmware/google/gsmi.c                 |  6 ++++--
 drivers/firmware/sysfb.c                       | 19 +++++++++++++++++++
 include/linux/sysfb.h                          |  7 +++++++
 4 files changed, 44 insertions(+), 2 deletions(-)

--2vTng0Lkhdjc+j2z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQS0yQeDP3cjLyifNRUrxTEGBto89AUCZzqLJgAKCRArxTEGBto8
9Bc7AP4qSLGHwc+uR0kF+Z7OGGNeeZiZ40+2EC5cUfTRbQgc/gEAh+yK72dfH5RN
/A4T73K6g/GzxCZLROe3jCx4AqtfQwE=
=y9/A
-----END PGP SIGNATURE-----

--2vTng0Lkhdjc+j2z--

