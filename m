Return-Path: <linux-kernel+bounces-393879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A5F9BA6A7
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 17:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D9201F22219
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 16:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCEC16EB5D;
	Sun,  3 Nov 2024 16:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ls14aPKP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698C7AD2D
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 16:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730651553; cv=none; b=HMCflgli+fertTYNjK860mpUpdbXUGicg7EzVZZK3SQ1lsiJvvJUUump7GM57xr9qm9DIhnrwZsOtJaC/RIH4a8ajq0q73vUuBmDnEdalTujOC0PCAfP0v6M5Wd2e5qBFT2NpEb7Dj1D9Bzd6JnwEVuTDPuKLF/8o+KidnbFv60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730651553; c=relaxed/simple;
	bh=WN7YLD1Pc0M5cBEh5p18cCSGivKhJ6YjLZ9tg6VwmwY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UrDXVmiWrCaHlll63L3Smg6SABbSOORBEyQfFNdEAjs0IOmu20oNUNTzCgIDRG7RT0JEQ8JD+EG1WZc1DcFT620ON7Ji3BNmxOFgsshD8aMMSb3l2azZk8pn3FncPlkv21heMdLnRLxlkySkTcE2xn7PlJN97Pz6J8qcZe03qYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ls14aPKP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A432C4CECD;
	Sun,  3 Nov 2024 16:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730651552;
	bh=WN7YLD1Pc0M5cBEh5p18cCSGivKhJ6YjLZ9tg6VwmwY=;
	h=Date:From:To:Cc:Subject:From;
	b=Ls14aPKPTchX14dr4+4StM+nnT0JwIF5ii2doOu5p62kNWdkpZoi4l8CJkpwAB/di
	 JWVfdNzWDcjlEiZdEfaup/2tB+kZfR5a6y8gQ4uS0fjM2ShIgt4rd/GMnNBvcyCagd
	 fS4AbL4SOJbevV64X0gJXwnAFB59iDL8ANqsmC5nd8VctzS97rWc6WsE8t+hMSVYeJ
	 AAkaR0YIweKI3bB6DjrGtGm+ilGuGVYiLD8d6TdLqey5tIExKXw7rTnbFL11wzBE9U
	 KuEY5xgYRTfWoCX5YnGq6cuQdewQCVkysYa4uYyt3hSTgDOiiiiecFIdU3hU8mAbSS
	 PoLPLzTs2UGQQ==
Date: Sun, 3 Nov 2024 22:02:28 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: dmaengine fixes for v6.12
Message-ID: <ZyelnAdQbssRy9zg@vaman>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Wy1kuxinFQk1ksvH"
Content-Disposition: inline


--Wy1kuxinFQk1ksvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Here is the pull request for fixes for v6.12. Sorry Diwali festivities
kept me bit tied up to send this earlier. Just couple of driver fixes
for this one.

The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:

  Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dm=
aengine-fix-6.12

for you to fetch changes up to d35f40642904b017d1301340734b91aef69d1c0c:

  dmaengine: ti: k3-udma: Set EOP for all TRs in cyclic BCDMA transfer (202=
4-10-14 23:41:05 +0530)

----------------------------------------------------------------
dmaengine fixes for v6.12

Driver fixes for:
 - TI driver fix to set EOP for cyclic BCDMA transfers
 - sh rz-dmac driver fix for handling config with zero address

----------------------------------------------------------------
Jai Luthra (1):
      dmaengine: ti: k3-udma: Set EOP for all TRs in cyclic BCDMA transfer

Wolfram Sang (1):
      dmaengine: sh: rz-dmac: handle configs where one address is zero

 drivers/dma/sh/rz-dmac.c | 25 ++++++++++---------
 drivers/dma/ti/k3-udma.c | 62 ++++++++++++++++++++++++++++++++++++--------=
----
 2 files changed, 61 insertions(+), 26 deletions(-)

--=20
~Vinod

--Wy1kuxinFQk1ksvH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmcnpZwACgkQfBQHDyUj
g0ehoQ//atPMPwbRjYpHLYH0jygO1ofsgjAyaIIX5MXlEPUj+5EtiKy3p5EMj3Vc
Zgy1uUuFENesv+v28q6XkgdpdE/mWI6b4feAFPK82ZO+XhTI31VWGMWaAbA6FdSw
jS3bWheltyAOTCjgQ1/waT9lIa/C1u2zUTthheUovoQeDT9twfTxJCXYoVFJQn33
yGwxSOBQQhGJPRRIM85NraMxEnim33k0/51UqfoiyAy5Ul8emisj3yLxp3Qep8zp
j/GpUHUVAW2wN29hWUwKzQrRjkssDLHIbbD7rpFwtnqmDrRMHFv7PCyM1iArs4pq
o4Pkp/4qKA7WZxdf48tSuFiX89L/Yd4hHyXsV3A390ziqtDszHteLRjwRSqViIxz
MzSI7iHhMXB647BdPvb+lggL0WGatLavN7WAUYW2KawNvA0sN6crgQGxpNqzYRUs
X9GLgmcZI3qXMMjq9natoccD3brOylUQ3HfLJC1e6KmosHFweU3uuHB4xG4NlhSa
t1UbEDVcVvDGIYOnkYd4dbf4J+7V2HoN0icsMQo3wWb+7eiDGxUUlE2tLMGkMrWG
xSCezFSPY+XmNjJ9wUYMTEVbdnR9sgDY6kLVh6rkbMQQ0BhtqAWvgIhRGDPhyOR4
btIEbyMcwzpj6UcUUK9cztaGTJroPN9mZiCKCDmmHj0jv9EP0mk=
=Xkw4
-----END PGP SIGNATURE-----

--Wy1kuxinFQk1ksvH--

