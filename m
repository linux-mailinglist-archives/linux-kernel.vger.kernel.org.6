Return-Path: <linux-kernel+bounces-557800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D01A5DDF5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27B467A4E9C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1D724502D;
	Wed, 12 Mar 2025 13:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="UMtPK/Nm"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF8A22ACD1;
	Wed, 12 Mar 2025 13:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741786017; cv=none; b=qXMA/zoGWDvY651AvoQCA1nesQ6TqBrRjFJfrfgBxbJe369q8YEaDFVr/30c+uXOqJ0HoXLd1NXl2cj0fLL7XaOdjJPWyJ3jTYCCWDhBmIBhClZdqeeBrLJcP489d0haQuKQW43aRPX6lV2bFaCj+4LsmjXIlL6dJlCBLbUMwPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741786017; c=relaxed/simple;
	bh=04VAAeSwjXcfBUMDh42tZ20tmePx9f2blizdfSnhlLI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ta4CQGlIDudp1Z6ODXsUT/V7qrwiQk31HnhpTdzAQ9NM89i0KH1zoLitZdELFE9453IYj83HgLOokpVIzfLFLbTa+5TT95u+YcVLUizQDmjSA12wSdf1IvPrZhBiVByMiFqSni84E9mg9aP6n3adjPl4S5cr/OWhOvtTG3HCMAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=UMtPK/Nm; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1741786011;
	bh=o20Kk0VX24F8Ev2apUOrtsLmnistmPmD8mKjvrZ6Eeg=;
	h=Date:From:To:Cc:Subject:From;
	b=UMtPK/NmNbgBiuy9yUIBSSeA/fjsBAIyRDOi/pPBgvaKXXtnBrpwVszbkX4Eh8sV0
	 3XOP+KzImuBg4ke6q0PKOtajq+Jf+xYjY//UMk6xGavQIgZ1Qj3X43i08klbv0Ntmg
	 pxRFotD7TtCWocg4QqshQHFBjxwJkCvHqfl3li8IjuG5GN+oQZBmBa7XNhNIRcjPWo
	 Ehz+WgI5aHX7FSdLjTMmz4/VQuHbNz69Pmk7zWOe/9+R/4DXfXiwM4J7j/4rM6tEFR
	 BrvvniI7uRTMRfGJvjABwEPiA1NGpSt+P8CkXvfbja1mMPnG8VkaCSRyTl2lxiTqj2
	 RqgBMnHLnF/8w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4ZCWcq3jHmz4x04;
	Thu, 13 Mar 2025 00:26:51 +1100 (AEDT)
Date: Thu, 13 Mar 2025 00:26:50 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the kbuild tree
Message-ID: <20250313002650.135e6383@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ky/34S.Ly3T1wIcFlcGnT9x";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/ky/34S.Ly3T1wIcFlcGnT9x
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  bc5431693696 ("kbuild: exclude .rodata.(cst|str)* when building ranges")
  dafbec3f520b ("docs: kconfig: Mention IS_REACHABLE as way for optional de=
pendency")
  8ee44bd75bce ("scripts: make python shebangs specific about desired versi=
on")
  e6a2507c8d3c ("kbuild: rust: add rustc-min-version support function")
  73d602eb38c3 ("gendwarfksyms: Add a separate pass to resolve FQNs")

are missing a Signed-off-by from their committers.

--=20
Cheers,
Stephen Rothwell

--Sig_/ky/34S.Ly3T1wIcFlcGnT9x
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmfRi5oACgkQAVBC80lX
0GwLRgf/VMrNPtWJDzIC+Wd+aq7OOp8xx23vkXdQgr1AoCtlYJbfTwKZym5qjpcK
0wJT7lOeKTZ8SBJN0V9b72mkxGJ5OhCXg0LyxF9PMQG0ArhGahBcXovBDO1f90wM
+OdBZeQzE8K/6hAQR0TXj4jDazOXh2DLU01wJKKkC6wFnlxtw081Q40jSKaYCK4R
l8JcqiOMaDqzJevVjYey4A0coJnbSM7mMj7W2xAqU7+A5BPBW+zMb2ZK3KCBteAM
+qZndwfnQS1hHWvVv+tRQMN/lvz327yZW12xjnjRjENSR/jpNYU7g46XaVR4jGoS
I+LZyN9xcHBtqiqodKzGjrlUcuhTjg==
=wY/b
-----END PGP SIGNATURE-----

--Sig_/ky/34S.Ly3T1wIcFlcGnT9x--

