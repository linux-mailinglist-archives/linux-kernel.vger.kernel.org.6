Return-Path: <linux-kernel+bounces-328091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C17EE977EC3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 13:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 075BA1C210C8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 11:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB05B1D9324;
	Fri, 13 Sep 2024 11:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mr2FwUx5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2777B1D88B4
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 11:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726227906; cv=none; b=sy+QkKhLGXIjJCiSiCMFfDA4zFB2KMKFoqRpK8YWyaxrOXk4rrRWNr4F2/0we3nORiaNH8RFtoskNcF0WgEikwdThuPDImZ2jLCvDQlRzcV8cMc1bIuGhvE0ZBGl7WPVes4hfeFyP63hRZzChnE4jAbQJ6Wq1qEvWhN4Il+Kc9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726227906; c=relaxed/simple;
	bh=yXTKYCNOcVwtrGMZWFicooDyHB/d1KS84GQAewmWoTU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dgxEaIRANLwxE/xMUVUm3G8lmIKdpiUe0Y8pbNDdVsMKjQkY9DKU5bV3tlycVyDvDmg2XQEs2SgyLjjXqXDHnep9cEI2qMkrHuW69rua/CkDzwXNb70aPpdWz+lVD3HZIuKsI8B+zk8vFxUOtxqZC7WeEL8pV9d3k39rjYaje8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mr2FwUx5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C3C8C4CEC0;
	Fri, 13 Sep 2024 11:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726227905;
	bh=yXTKYCNOcVwtrGMZWFicooDyHB/d1KS84GQAewmWoTU=;
	h=Date:From:To:Cc:Subject:From;
	b=Mr2FwUx5mCUmW7vC3TFFl9s6liKnIfOkjp8/rlV3VfhTks4LgYWeqBmyb4GGuSle0
	 LpUmNiiFY5X2Yk8ruzkMCxljTNn7NN0ZkgTGJOnmg1WnYgt/lKd/kv1ZEBRe0KiQqe
	 UQvqVpNbETCf1QHCaD9jPxF2Ovms0g4VoS6VuXHY/5rk5q2iQeb+Vs48EC0YXfTo4G
	 BQc0IQuenaMuvQCLCJBoOleAciNBZSjluXXSaUUkdV7Xrzs+zMwFB6mmb+7VYCfrYc
	 gBFGW0nBI6gaoQ3V2R0pFOtiviH5VTWOaTH14s5VzTLqBglmsOhzVryJMy23eNJyr5
	 eO+d+x2FuzA1A==
Date: Fri, 13 Sep 2024 17:15:00 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: Late fixes for soundwire subsystem for v6.11
Message-ID: <ZuQlvMewKJWzVVgP@vaman>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cDJdxvnMXDwbtM3g"
Content-Disposition: inline


--cDJdxvnMXDwbtM3g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

The earlier fix for non-continuous port map programming caused
regression to Intel platforms, so lets revert that change. Please pull
to receive the patch to revert the earlier fix.


The following changes since commit 431c1646e1f86b949fa3685efc50b660a364c2b6:

  Linux 6.11-rc6 (2024-09-01 19:46:02 +1200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/so=
undwire-6.11-fixes_2

for you to fetch changes up to 233a95fd574fde1c375c486540a90304a2d2d49f:

  soundwire: stream: Revert "soundwire: stream: fix programming slave ports=
 for non-continous port maps" (2024-09-11 13:05:43 +0530)

----------------------------------------------------------------
soundwire final fixes for 6.11

- Revert of earlier fix sent for non-continuous port map programming
  which caused regression on Intel platforms

----------------------------------------------------------------
Krzysztof Kozlowski (1):
      soundwire: stream: Revert "soundwire: stream: fix programming slave p=
orts for non-continous port maps"

 drivers/soundwire/stream.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--=20
~Vinod

--cDJdxvnMXDwbtM3g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmbkJbkACgkQfBQHDyUj
g0fqeBAAllBsy9jMAdYb95jzNlTJP/EQwsk1BuYDbGWJdvmHe/6v4hLKWaSIqwIJ
+oox7zjvswA5E0/zBGpYY0L9oAjfthvDc7WhidxCgTd4rR9Xe9WVtQ97NbdZgk/4
6RapkkIm1QO3jzwqRUIoGY07p5ss0wPDnG0e3uK/yzdVbz5aqHKj1UpCojvYuWy/
SjPWvN3vmhmsyeR2oja25arPT8RnlOQgnUKEWNzt9nzYiSHefPuTeeypxF16FyCf
9MWIjfr7/G+qby912udYmm2GnBjdu7xxfrh96dLjfeUV40cQ7/dpvSYLaoQBVB6u
vbOsMAWE5fFjJTsGFaO6+n/2vCdg24SS9bp5TkUSDLGl24fosVBeYaA3qidVnPa5
wt1jJ+SmSiM7Z0o5C/YH5vRVlp0X7Jz2Acaa07qeXzT9gliSQxUXrcak2VNhE8pn
JDizR//bNquPvryXQT4p385DxIBwWwhQhArMnjjRYkDlT08Tn50GWHZL6W5DH9us
ANAM/WrSfy3nDBqTdbiNdwrYmfoBlLwj4k0PhVfQ4ICraes3miVLc4r9903qoJNj
6IF2VqDTzf+a6+xfHc7mmprTGowPClLnMIPskeNRw4WDBwQm+pztA239Hki26B+Q
3z5YoHOdjFni/jWHo/hyXcF5S7yxBjJX3WJq5sT+UChQUf/inzA=
=C7Ss
-----END PGP SIGNATURE-----

--cDJdxvnMXDwbtM3g--

