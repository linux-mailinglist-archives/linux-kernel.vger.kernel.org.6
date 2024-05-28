Return-Path: <linux-kernel+bounces-193153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDE18D27DB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 00:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 403AC1C24266
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 22:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F5D13E3E4;
	Tue, 28 May 2024 22:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="g1I50eiD"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEA813E041;
	Tue, 28 May 2024 22:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716934781; cv=none; b=gsscZDuOod2zGVreaw92DXOB/Dmnc0Mck59QW6HlfGQP2TpBFtUX8qQiSaidlYx3HRS8EEkUZvR5tGhdeFoEtlh1gmS5eR9x4VmQBJvqYpwUDnsKWCCRxC9Qgo8i6LxmvEz5TZcvrolgSe8aMWv23CWLDEAlhtHG0aDkkfo5ZPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716934781; c=relaxed/simple;
	bh=lYPnDtug50F8QASrDPJzWb+QIrScHIMC+Trew3ug4IY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=kYZUeJ4t61IaX2TxJL734VqmIRY2KoS86SMNKA4hFvWpMg2y8r2koqrh8HIQmAgxK5FgJaR3+MqBxofT7kqgN7dxja2MTNh6cH4eNdl2S/S2fDKE/Q+xauqMwvLHqLTFVS+yDVTlPswVwCnDFd1QEVBRlJITVfhk/w8s3pO+Ap0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=g1I50eiD; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1716934771;
	bh=d+GlOgAKL4NNoPih8NFaDHSXIOlkAQvMbfW9zUY/L6o=;
	h=Date:From:To:Cc:Subject:From;
	b=g1I50eiD9TKpWOJBSyhBTO1kpL8n/sIQef4CBdhPQtuM1ubL3l5JoYjvb++kND+rw
	 Vap9DSXiHgCR8ZrLEJ07/nGZNUFZluIJgSrr5NfAH7DNLbxd9G8Uic7W+bMyIAlQq6
	 lpZbgnzZxZxiDoM0CcOzwCOQec3xeanSxqkIS2U4S0D1Pr79wKDe7PLsyhZV4XY7rO
	 obEFhtXIznmSp89ioXhB5Aj5S4kA2IGo3+hNSvoiS3KP2F09x0NyN0GpXtlFwigOeK
	 xjniaVoyytVfqrlTnX0BYXFjS5j7QOlJtmagWkvOAaGDZSGiodPWPDQ5envKMGdIAp
	 jxqox09g3zBfQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Vpn4M4XW8z4x2J;
	Wed, 29 May 2024 08:19:31 +1000 (AEST)
Date: Wed, 29 May 2024 08:19:30 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the tpmdd tree
Message-ID: <20240529081930.487f7290@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/LJgjHhHwl5pVvvsSHm6=HFz";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/LJgjHhHwl5pVvvsSHm6=HFz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in Linus Torvalds' tree as a different
commit (but the same patch):

  7df9ef4f7b1e ("tpm_tis_spi: Account for SPI header when allocating TPM SP=
I xfer buffer")

--=20
Cheers,
Stephen Rothwell

--Sig_/LJgjHhHwl5pVvvsSHm6=HFz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmZWWHIACgkQAVBC80lX
0GyFMAf/dnNg4Iig+09v7opTjl4EXIX9SVEGUBl94gOq4QCF91F5mOralyEbhUzE
5mP272mwV7HNJdBcRLErauoQ8g9aBQ7tVAyxRsI8B4EiNIhlYDXA1mu74R/86dkS
lK9I2+HZtO51B5fGvBalYlm8m/OrbYy82S8Y8x6C/x/22bzCvmOeKqn8/oTWHo5W
CVC4k2WK0R31tJb4ztCZ7rwoGsYo0MR7Ehhvtt5cSlpB6FGjdH7mKvBa5EmvlewD
QD9o5OGJze9ZlBMA7uH6sSf/gV4JoBzi4IGIR7/jrfukAzh7gY2PJ9a4Si85WS1j
YzEGPGT8PcYxmYEnkWvfQqtBo5qweA==
=zBTB
-----END PGP SIGNATURE-----

--Sig_/LJgjHhHwl5pVvvsSHm6=HFz--

