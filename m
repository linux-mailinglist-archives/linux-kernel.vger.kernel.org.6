Return-Path: <linux-kernel+bounces-308818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A46966222
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 14:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 009D0280C00
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 12:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE34C19ABC2;
	Fri, 30 Aug 2024 12:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eUgf3x3M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EFC19645C
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 12:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725022674; cv=none; b=QZRW87KcK6mdHma+xPUbNwWyjokqwX49y41Bt+kcRq7WxE8+dYBV2Clc1EYv1kBqi4MSog2mzY9xob6e7WyjNAd0xlLr2EJGyONVzRsKFbr/ejGAq5nau3B0eBlU1DE+kO9JTaaLbEjnCxT8AN5jmh+UtMv9wV1LjmXuNd6LkWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725022674; c=relaxed/simple;
	bh=pITWRVgmLjxu1KlpGQAOrookls8MbfzgD+BpU31jtU8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OlbP6gRm0fGeV5mcFyzedNEJ9JhjHAsEBs0Z0xGSXGVSqhNTntiordI7FuEBbOrXMQ/0fcdDJwv7cHCFQimh4xu51sVU8LBlnxY8ymw2KDM+ug5TPqN5hKaX5Ii8jJt3DPRfjLtRADEo4Gg4y+ncGXH0PI+X9Jk4HPEEW9uX3Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eUgf3x3M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DD39C4CEC2;
	Fri, 30 Aug 2024 12:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725022673;
	bh=pITWRVgmLjxu1KlpGQAOrookls8MbfzgD+BpU31jtU8=;
	h=Date:From:To:Cc:Subject:From;
	b=eUgf3x3MUj/U8evr04d18n3kQ0QtNCRbxJzq/vIYjHlkvbog1UbtPPrafXe9t0p9L
	 UphN/YpDL1ROFdAvG9Wr8rkuoFspEWlMBHdfywLR92DyJeVeHpY8rgFw+TQlVdwlI6
	 GShZIlTEtj4M/N3+jduKBKWN9K889Gm/7OpGlcRRgEvoN47irkEdnPpFrKcp+5cdwO
	 ImgkOl40JaUGf0Dw8QpGrO2yvu9mNVs3MBd5OseIdHZ+IOSdJ5ZvfKDxtm291eK+o9
	 /gff6C7KHu693sgOXj5Kc3pi8ZOi6AXIzgH85T9vVUcdLsaxBG3qpyzQIJXj3zmO/T
	 CBYARgTnDQX0Q==
Date: Fri, 30 Aug 2024 18:27:50 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: dmanegine fixes for v6.11
Message-ID: <ZtHBzmaZzRaluC74@vaman>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DjAHJzx7f1mTrGS6"
Content-Disposition: inline


--DjAHJzx7f1mTrGS6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Last one for the weekend, so please pull the dmaengine fixes which
contain the driver fixes for couple of them.

The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dm=
aengine-fix-6.11

for you to fetch changes up to 9f646ff25c09c52cebe726601db27a60f876f15e:

  dmaengine: dw-edma: Do not enable watermark interrupts for HDMA (2024-08-=
28 18:40:17 +0530)

----------------------------------------------------------------
dmaengine fixes for v6.11

Driver fixes for:
 - Bunch of dw driver changes to fix the src/dst addr width config
 - Omap driver fix for sglen initialization
 - stm32-dma3 driver lli_size init fix
 - dw edma driver fixes for watermark interrupts and unmasking STOP and
   ABORT interrupts

----------------------------------------------------------------
Kees Cook (2):
      dmaengine: ti: omap-dma: Initialize sglen after allocation
      dmaengine: stm32-dma3: Set lli_size after allocation

Mrinmay Sarkar (2):
      dmaengine: dw-edma: Fix unmasking STOP and ABORT interrupts for HDMA
      dmaengine: dw-edma: Do not enable watermark interrupts for HDMA

Serge Semin (6):
      dmaengine: dw: Add peripheral bus width verification
      dmaengine: dw: Add memory bus width verification
      dmaengine: dw: Simplify prepare CTL_LO methods
      dmaengine: dw: Define encode_maxburst() above prepare_ctllo() callbac=
ks
      dmaengine: dw: Simplify max-burst calculation procedure
      dmaengine: dw: Unify ret-val local variables naming

 drivers/dma/dw-edma/dw-hdma-v0-core.c |  26 +++----
 drivers/dma/dw/core.c                 | 131 ++++++++++++++++++++++++++++--=
----
 drivers/dma/dw/dw.c                   |  44 +++++++-----
 drivers/dma/dw/idma32.c               |  19 ++---
 drivers/dma/dw/platform.c             |  20 +++---
 drivers/dma/dw/regs.h                 |   1 -
 drivers/dma/stm32/stm32-dma3.c        |   2 +-
 drivers/dma/ti/omap-dma.c             |   6 +-
 8 files changed, 168 insertions(+), 81 deletions(-)

--=20
~Vinod

--DjAHJzx7f1mTrGS6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmbRwc0ACgkQfBQHDyUj
g0e9wQ/7BS1LSBL1EMldrFljS917fe4dGAGZFqO3Epz6JqNp3fyYclrkKECOYN23
xl1FQSZG5M8FMHTL7AthzeN9FbqtnGXjrs93OL/IX6VmL/RUVKyq8SHRo3XJ29uh
GobQLFPgN8y3Do5GcNwy5dlf6JakZDrG1jWjPvh8oTpT9oLExvOKDimZitjrCohx
OyUrBNNGUtMBmMgwmoIYk47GQ9wxocJBVbVqlzO5+CR8tewXkts0ffNjEa26PW4c
qfBt0uSgh2HgGLAF7+gszgEr1gTjWN+ntNi6oMJl+sexlGVv7RkBGP0IhnunfMZt
24HXH27a+cYR4pVw4Xhtrd1KRyBq8aYQhLT/i41xOtYH9BqPXilPNrh2TIjbRsnR
BoGeFrKU2rwi78p2sNLY7AkoL0CRVRMBS23YEFqg/4UViTYYY4Vk7eSP9lGDs9T0
stYWcjf518yKlLfj4Y1VVQdIUU3ZnTJAHJaAYaq1gd4/XQca9wMf8w20TzzMZvRS
xReo5bkzCZjaFWMpJdiLluvaEM4wOZcfWNG3oQNiP8KTa1vcm+ZS7Rcbjk+y841H
ybRcWrbB+e75zIvXURysXGtvKy961fVaykCyYLIa+WimP4Jcl90qnKjx7i/tjpIC
MFDDSn43R427ct8n2kBJMBob+Tl2j7FVofYu6a3fSWmxzMhCuTU=
=WLHT
-----END PGP SIGNATURE-----

--DjAHJzx7f1mTrGS6--

