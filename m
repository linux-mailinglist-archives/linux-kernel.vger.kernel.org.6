Return-Path: <linux-kernel+bounces-252024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24841930D25
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 06:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD9961F21372
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 04:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D65157A42;
	Mon, 15 Jul 2024 04:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJpLSrFw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A67CC8F6;
	Mon, 15 Jul 2024 04:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721016949; cv=none; b=gBuN3PPFQAEbZaqi1Yz2XLDf7SBZnC6tzekns0hOKRiaSflHNS1Fc1fwMbQYFZU/+1u7aQiLi+cCUPHQ7C1qZ6uQrnbq+bBxhjBjUCPDkf6vSRuF082nHERNvHvDcoHttGH2Ae13y0k3zWJeIGXbHgFPLGR6ddvy1LiZjlrfDUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721016949; c=relaxed/simple;
	bh=m7cRVEiy0w0PxLyJMh9RYlXBFq9JJo3gs5kdmHF0Bpo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GwklinNoI0gfkTTdRLVoaF4nxrpfT5DR6ahQo9Ywv0HU1J6qInbnGRUnS2YNyo76OoD/l3ddOnoufsiW0DO0YqB/2xcymS0wgKbUJMCsoOc1H+HL5iqetop9mB4BguRrYyMH7EWhBvz67LubGqERVkb8s43Sfyi/Ce40iT9X9pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJpLSrFw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63CD6C4AF0A;
	Mon, 15 Jul 2024 04:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721016949;
	bh=m7cRVEiy0w0PxLyJMh9RYlXBFq9JJo3gs5kdmHF0Bpo=;
	h=Date:From:To:Cc:Subject:From;
	b=YJpLSrFwPsfNXMwH1MMuwIFLQIUWAOyZmLjxPNFqf6WFC/LX4edaXdTeItzN9wLVz
	 FyQNR253uMlb9Lvo/S7pkxWOvoO7xnliTJohr9CkFMEEN2NN+HllVZGeXwtjxLIATw
	 wnwMdnWmqkabSufq8TWcMiCRIP71+QNfUlFTN6Hj3dsAs0ID8Lcm/N9IX2u/i+8y2i
	 POZW6cstJG2InUhQpL8uxbWcD8NxX6g3VxgmpU2YakqsTxudv3t86BGNL1DPGTNiU/
	 MqQ7Av1TJ8XtGNoyWgMZe9HDuligaadlo+sM5b4Oiie9LToluGJPEpZDqe2MNSORAb
	 J4hVKOAt+Andg==
Date: Mon, 15 Jul 2024 12:15:45 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: torvalds@linux-foundation.org
Cc: briannorris@chromium.org, jwerner@chromium.org, groeck@chromium.org,
	tzungbi@kernel.org, linux-kernel@vger.kernel.org,
	chrome-platform@lists.linux.dev
Subject: [GIT PULL] chrome-platform-firmware changes for v6.11
Message-ID: <ZpSicQDtkyR5r4vF@tzungbi-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PWpL0YzOyfPR8cB0"
Content-Disposition: inline


--PWpL0YzOyfPR8cB0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull chrome-platform-firmware changes for v6.11.

Thanks,
TzungBi
------

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git tags/tag-chrome-platform-firmware-for-v6.11

for you to fetch changes up to fc2c1d716d4a879dd52c612ea19a7f994f08748d:

  firmware: google: add missing MODULE_DESCRIPTION() macros (2024-06-11 03:34:05 +0000)

----------------------------------------------------------------
chrome platform firmware changes for 6.11

* Minor cleanups.

----------------------------------------------------------------
Jeff Johnson (1):
      firmware: google: add missing MODULE_DESCRIPTION() macros

 drivers/firmware/google/cbmem.c                 | 1 +
 drivers/firmware/google/coreboot_table.c        | 1 +
 drivers/firmware/google/framebuffer-coreboot.c  | 1 +
 drivers/firmware/google/gsmi.c                  | 1 +
 drivers/firmware/google/memconsole-coreboot.c   | 1 +
 drivers/firmware/google/memconsole-x86-legacy.c | 1 +
 drivers/firmware/google/memconsole.c            | 1 +
 drivers/firmware/google/vpd.c                   | 1 +
 8 files changed, 8 insertions(+)

--PWpL0YzOyfPR8cB0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS0yQeDP3cjLyifNRUrxTEGBto89AUCZpSicAAKCRArxTEGBto8
9HOfAQD4Z/iQMhXUpsPTJtUB1BIfP9QDTI+k35lIC3MemOsAWQD9HYsxHH582Xsq
pd5B4/OKoaOhVm/EQcuDDoIcap1ovA8=
=9znZ
-----END PGP SIGNATURE-----

--PWpL0YzOyfPR8cB0--

