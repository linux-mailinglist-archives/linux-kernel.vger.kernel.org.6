Return-Path: <linux-kernel+bounces-182331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67EFF8C89C3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 18:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2295028201F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 16:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E37D12FB28;
	Fri, 17 May 2024 16:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKLuk4up"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FBB12FB08
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 16:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715961905; cv=none; b=eLLe//Opmtqt2+3RTiuZTs8gm/ghuZKgBQ9GqIrHp5E4jmeDqTJ6pGV09MJhXI3E5C9Tvw1y3ELHtciZvBvyYjJcs803IslzGA+GB1bb7jwBGVPrvJz1GnioSEaku8x05Qwy3XyBn9BCK78DgzIhVRzEzJWJbkkA4sCEF69c3Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715961905; c=relaxed/simple;
	bh=yC1lmuk37LOv31iQJsiv/SBdk1LxyX4F4jiZs8+YE7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=riA+QJwhNf5Pbts6hn3JqG5nmK1Wd0XTyXT//PuLuWIs7maDF44ql82mVxVXt2VSLAx/KPrnUxLUuslamY44lCjfwsy5nJZfqqhBtuNS/VChlkQS75ver7IuENNKzpOpKq7BdZhHEqX5sAmyjY1G9JIfEA+3vBYT0+comJEG8o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jKLuk4up; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E70EC32781;
	Fri, 17 May 2024 16:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715961904;
	bh=yC1lmuk37LOv31iQJsiv/SBdk1LxyX4F4jiZs8+YE7Q=;
	h=Date:From:To:Cc:Subject:From;
	b=jKLuk4upx4JsoDgUpN8bjH1uIBYYV0pHz3XlopoGxUR51ZZUxcPO4hVKJbMdFQztW
	 WcgB9/kVpOgBVrAbn7R/lkarXlSDjNkCpuuK19JR0YUso+aXa6t4/1BHG1iFRy0qTH
	 zhB7o5hjEgpxLCwL5tjdDJZSHlqQ72ESA8mnzZUZVi7YZmw/pLCV8LP7DB22I9rtdY
	 B94hU6mJRIXg0j6bptpgo1+f9n9Mxx7al8MV/XD09zoeOFzJSbmfhlO067N1EImlb3
	 gQT8V3DKGFFBDxxCuFA7TxxVftGSMY5AevNkBR5JBG+LXfjVPRzPK/Qjr2glKC8QoD
	 kzh0dMH0JR0vw==
Received: by mercury (Postfix, from userid 1000)
	id 2ADFB1060620; Fri, 17 May 2024 18:05:02 +0200 (CEST)
Date: Fri, 17 May 2024 18:05:02 +0200
From: Sebastian Reichel <sre@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PULL] hsi changes for hsi-6.10
Message-ID: <zbfu5mueaarwfwj437ephli77aozmahezg7nao5z5bjmoj6fqt@4lqbou74u64i>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ithzs5nsufamidqw"
Content-Disposition: inline


--ithzs5nsufamidqw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-hsi.git tags/hs=
i-for-6.10

for you to fetch changes up to c076486b6a28aa584b3e86312442bac09279a015:

  HSI: omap_ssi_port: Convert to platform remove callback returning void (2=
024-04-16 11:31:09 +0200)

----------------------------------------------------------------
HSI changes for the 6.10 series

 * convert to platform remove callback returning void

----------------------------------------------------------------
Uwe Kleine-K=F6nig (2):
      HSI: omap_ssi_core: Convert to platform remove callback returning void
      HSI: omap_ssi_port: Convert to platform remove callback returning void

 drivers/hsi/controllers/omap_ssi_core.c | 6 ++----
 drivers/hsi/controllers/omap_ssi_port.c | 6 ++----
 2 files changed, 4 insertions(+), 8 deletions(-)

--ithzs5nsufamidqw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmZHgC0ACgkQ2O7X88g7
+przVw/+LvNenh+mXHM0PwgXLRoOj0I7BcFjpECE1JrHee6VIUtXkhAwxEKoe0B2
VQIRk8trNMVVdYq7I1UNJZBbrKPJNgkUSKZhWYuXjS4KPekAV2c5JNBHcDhZfvnC
cqsABwLJEoJTfwS/8iRPsDLiLCkBF6GtQIEm1+SAvXp2PToLaSH/8lrzXogYkmTd
4x1kd3aBRNOhxa0fGpPDomGACZ34KcR0h/2gYoMeXvYRY7ULU0ZKW7ysb3o/JdNL
dHIR516ZO7VQNoPE37s8wpQsUmz6aeGYbKolTPMgG571hPun8JoL2507LyNd7TSx
JH4RKevee1VfpcL4puw3G+wiZAp2JL8+x91rqP/RDwvrky6SsLRY+m/ASPsnq9kD
jNuPdvvJYJ55d3RVa/zRlT0eYTPubprJ99sH7tUz3TG1IYvwSqS9prK1GgQsBm9P
TQIF9o9Xu7LTH5urJCynTHODX35jIu4h6fvsTTPDvkLIaaYVWatO2LY/wo0NgYFl
pIm8nyCewbeOMDNKVLrLYrlpxyFZxTMgGWoAAqsm3u7/JRvX6/J2mc0bGgYmHv5L
CaWgW64JyITA6DhAPdCejMit3xuFC7A/P30J0fu5axph4PnJQJdMSGjXWSLWHzEd
RjBtc8TJxpL5V7Xg1L/P9laEvJwq2zhevAaEn20KiBMPZLpa+Vg=
=ZoYM
-----END PGP SIGNATURE-----

--ithzs5nsufamidqw--

