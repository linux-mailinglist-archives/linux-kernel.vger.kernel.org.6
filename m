Return-Path: <linux-kernel+bounces-308808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A583C96620B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 14:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7BE81C22BDF
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 12:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A91119ABAC;
	Fri, 30 Aug 2024 12:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ar23//37"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C8117BB0C
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 12:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725022372; cv=none; b=PvW0csVCsY65aa6zJdY9VeyIpturZU6e0DZquPIX720zr/vst4ewRrwL6HF4SCevM4EU+DkwlIa/Z8CWjWINBLYaD7R4GbQy9E2lQuXH0MxbdvscE340FOvmE1lwyto/iH3n2/bUKsOD2TpwIJbbTr3ovAomWY4J3qKjV7cLou4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725022372; c=relaxed/simple;
	bh=Qt1RiBtTdVdiB/ANb1/1dwvF47zTvc92OD/tyhd5q+c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=B5cT1q/GRJV6dkHUlG+tmZxgdB+57LGv8njrBYw8TkFgf2eCKzCxT3BTkILNekb3VjnhQxY1zh4eMFxKW2Flf0r3oFQdk1im2+GgpVayGP4oQ6dmt1qpOIIxVLfJ1bifTtzZnWXBc/exho1eAZY1pHX9FUMHlfuEDVQltIXXmBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ar23//37; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FC52C4CEC2;
	Fri, 30 Aug 2024 12:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725022372;
	bh=Qt1RiBtTdVdiB/ANb1/1dwvF47zTvc92OD/tyhd5q+c=;
	h=Date:From:To:Cc:Subject:From;
	b=Ar23//37+aWR2m3TdK21hE5r2+iS52lV7kH0B64xteUFV4xGDjheCccPBKDT+S7Jk
	 QSWykFj2DrcRzof3YhjmTZ0iCty9ZUZCM5aXogLtZVYEbt7ZE/bFWQlXqc/w9D+4Dn
	 T3fW2znoL5bEl0yiuioltQR9q/TGUD+YQfpPgZATGB+fq7QcnrQ+TDNSadVY66PzPh
	 HEzqcTcAdtLJpMCQqclks2K3tgm29dryl4JLhPf+GevmBk5A38b73yQgbrcy4rV3ec
	 gHO98gtS3NnwOX7DB9qckM0m4jKfiltJiMO8WQJbT+LpHy8ebhXTzEcro5H02JXAmp
	 9bM+r5RkRvNsg==
Date: Fri, 30 Aug 2024 18:22:48 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: soundwire fixes for v6.11
Message-ID: <ZtHAoNLCzDeXh1z1@vaman>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t06nQat4wuDdFqww"
Content-Disposition: inline


--t06nQat4wuDdFqww
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Please pull to receive a single core fix for soundwire subsystem for
this cycle.

The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/so=
undwire-6.11-fixes

for you to fetch changes up to ab8d66d132bc8f1992d3eb6cab8d32dda6733c84:

  soundwire: stream: fix programming slave ports for non-continous port map=
s (2024-08-17 22:55:05 +0530)

----------------------------------------------------------------
soundwire fixes for 6.11

- Single fix for non-continous port map programming

----------------------------------------------------------------
Krzysztof Kozlowski (1):
      soundwire: stream: fix programming slave ports for non-continous port=
 maps

 drivers/soundwire/stream.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--=20
~Vinod

--t06nQat4wuDdFqww
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmbRwKAACgkQfBQHDyUj
g0fTxg/8DVwBa4vefmmBVFmrXqw+GZQxPoJOjC7winlLuXpRtar44kRd2YDknsC+
ZupWuqQojM2Ok3Qtr/OjV9mTINuJoYFxZ1e2dnOPxuQRyab8s2WtkqQ1Q39DbsIc
nGeYbeu/wTrv2vSYITGr0xfv8/WejBmMsozW42xzMIY6kpu6MmYppKCCGc1PDvly
2nlOjuc9yDgcFVH0m+LMZhJcbo4msgdVOgWXH6YYXlFzr5qWSs5tnNX/2a/bcvR3
vZ0m8jW8Op3k3hw8wZ0Op6smopdyWFR251BW05B43ZuegCnBKUVGi7H7y/FbNwv/
ItYMNBKhT4aH8AISh3UDIKncu4snrI95Yg4BOVtPtLooYGJWy/5Uj5ijkDEVS0k9
u+hWyAomxqt4RnKUqfOjtpX0fbxdq1WTtsy80dUTzJRCdxW8yF/EIInQxcFqisZa
Vk5yxdudGZXKDql4BC62k3Ii/bEdcY2u5qSKn5XMJiHdEBYiAFOucgVkUlQNiK/f
iudfLmAiNjBjmXiEnvBY26IZJNlA++NnNNmW34eLRAdu/w+/yUMK10ovXg0dkpHE
X1tifJINKpWYVz73yeLLee5106XDikUPAIc98QrqjkQ9szxJvYVp61UCm0l29rjr
EyM/p7B1+EY3nFauI/47vfecALk3uh98PUDjzvBwa25dbi+8I0A=
=Msn9
-----END PGP SIGNATURE-----

--t06nQat4wuDdFqww--

