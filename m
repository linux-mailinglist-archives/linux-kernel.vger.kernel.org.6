Return-Path: <linux-kernel+bounces-177141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D49908C3AB3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 06:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C946B20CC6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 04:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47904145FE4;
	Mon, 13 May 2024 04:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Twv9CMDc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820BA282EB;
	Mon, 13 May 2024 04:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715574346; cv=none; b=GIVXyIMJcuTYHSFw8cA5p0/j5EZRb3ZMzLI9UYF3lmBp+P6UukYP+bcXrxz9YK5ZypR9+FX/8UtM/JMi4570wb20Yps6VkYC4pqde1fBW7y40JJXk3uQF8VlggptNvZUF9lo7YQ+iDSsjs4VLgAbrZpF99OfAv+N+fxjMhY2smI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715574346; c=relaxed/simple;
	bh=GlVW6kGX/pBcIKTUM2dC5IbLDf5avJjScfNXfH6TRN8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=A5teUd3p0zJJ4316ARqOPWOEbGbvzzzyKIguGSUPw3tXSp6KWUHewu2Pjs4gcldTbJaFvHbh5aS/Zdyt6XnzqoWCPXJcVfsmnE05L7PyzKayuylz839Lf4JV5+a90qSjYRB14iZ2ERJsjjTTPZE8I8ajjXNVFdYl7FZXMVXX2s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Twv9CMDc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5775C113CC;
	Mon, 13 May 2024 04:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715574346;
	bh=GlVW6kGX/pBcIKTUM2dC5IbLDf5avJjScfNXfH6TRN8=;
	h=Date:From:To:Cc:Subject:From;
	b=Twv9CMDc/UagquAR7EAZ4a1X2P7H7/w42bweM2vdxvO/0dvj3Rb+XGpuLm9e2qngm
	 b6nprgr/RLaKD4hfrq3mCsgC8kCPMD4EsH9UDl6h7pHU3pylEuoagQssZfPb80FbZw
	 HX9Giiuz9wkMc2qfMFOk8Y4K8MTFXmRsdzElistX29CJLDGUWBxNSSUjzTf1Eok+YB
	 G389cSrTvBpx5m9niijn3MxyONb3n/+LujaIzse4GalCSe9aGGr6loVzTJbQCxaiAG
	 kOF3qhG3+JE6Gr9ocsKs7SigVzJnLxRbzBTfhphdn52jkMZoinhK1KWhVcXHeYKnJN
	 9whkcVJ6I8CDA==
Date: Mon, 13 May 2024 12:25:42 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: torvalds@linux-foundation.org
Cc: briannorris@chromium.org, jwerner@chromium.org, groeck@chromium.org,
	tzungbi@kernel.org, linux-kernel@vger.kernel.org,
	chrome-platform@lists.linux.dev
Subject: [GIT PULL] chrome-platform-firmware changes for v6.10
Message-ID: <ZkGWRmncTxuqnTon@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Vcw/DV1DV3jaC3eO"
Content-Disposition: inline


--Vcw/DV1DV3jaC3eO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull chrome-platform-firmware changes for v6.10.

Thanks,
TzungBi

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git tags/tag-chrome-platform-firmware-for-v6.10

for you to fetch changes up to 7f20f21c22aa22e488530f66bf4fc168e427f5bd:

  firmware: google: cbmem: drop driver owner initialization (2024-04-03 15:09:26 +0800)

----------------------------------------------------------------
chrome platform firmware changes for 6.10

* Improvements

  - Set driver owner in the core registration so that coreboot drivers
    don't need to set it individually.

----------------------------------------------------------------
Krzysztof Kozlowski (2):
      firmware: coreboot: store owner from modules with coreboot_driver_register()
      firmware: google: cbmem: drop driver owner initialization

 drivers/firmware/google/cbmem.c          | 1 -
 drivers/firmware/google/coreboot_table.c | 6 ++++--
 drivers/firmware/google/coreboot_table.h | 6 +++++-
 3 files changed, 9 insertions(+), 4 deletions(-)

--Vcw/DV1DV3jaC3eO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQS0yQeDP3cjLyifNRUrxTEGBto89AUCZkGWRgAKCRArxTEGBto8
9HNyAP4tkUyuq1PufFL1EUsBv7CBA3ptvQJVUGworpLsgZ/NJwD/SA3UWkZiVloj
Pt7UxXiUKPuBgR//ZeSf6nn5fuvf9Qw=
=NeHT
-----END PGP SIGNATURE-----

--Vcw/DV1DV3jaC3eO--

