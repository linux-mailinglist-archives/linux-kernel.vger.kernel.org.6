Return-Path: <linux-kernel+bounces-186485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F70E8CC4CC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 18:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A02DDB21ED5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 16:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6B913D617;
	Wed, 22 May 2024 16:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p8E2te2n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAE942AB9
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 16:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716394740; cv=none; b=UdHbKMa3V5nhiASj0acuIbPjOYnBmXwxkuI8xzjFMGMBP4fKyl0RmM/JnwNLP2oousoukP4fx+KOKdT6ApU327G6a7VW6w0uDjeytb7TikJN6tBRoeQdbkXaQN9SpFIfi2kS7ArAAKc6TbyEMpfu9dMiYJYmc8RPg5MtH2wUtgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716394740; c=relaxed/simple;
	bh=FTTUmVBujcIjuBX9O9Z4Gfs4mxUrGuEVwLRPaL8l0BA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ov8kNt/ueZODAK/j+ekV4iyqmVC9rwt+sppRdg+KTzg4aYLb7+e2EbJ78cZccyZKQpOXQJYMeKCPBNXt6Skx7niIdOgaQummG2c7guIggxJ70z2UrUSpjJuwC/O0VJqblD9qpskUNo5HKq/NrHrZAXR8Y2CPpCOPboVVDjORIaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p8E2te2n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90569C2BD11;
	Wed, 22 May 2024 16:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716394739;
	bh=FTTUmVBujcIjuBX9O9Z4Gfs4mxUrGuEVwLRPaL8l0BA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p8E2te2n7/1lDHTo6LUKfBMqzSxeAQEXJbRNqTCYCHHsszaUFhKSz08eSXqmTr3Ue
	 OimAR6n5dAUeH4vrKMLOfcSGs7eBWO5U/zyJnYm+4odyS9tnMQrINQoBelF/ZiOwiA
	 5s5txba3Aglyjb5CSttKXG4Mw1PJItz4HPwt0mIdKX86WevQzXZu4LUNsoecjdoT+0
	 XnDESX7tQ7LAIh6xqul6EcLn+9ko6tANZuerVcDIxuAkd2dftNlhcmfPlfvV9cYxWU
	 VWfvabATTDU3rTnuYOpcdINh8s+I6DP3FZRwzax9TDJ86BTRcQwIk3fue9u4iWrEGm
	 13apFdU6mAJVQ==
Date: Wed, 22 May 2024 17:18:56 +0100
From: Conor Dooley <conor@kernel.org>
To: Palmer Dabbelt <palmer@rivosinc.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] RISC-V Patches for the 6.10 Merge Window, Part 1
Message-ID: <20240522-confused-epic-03a59031e645@spud>
References: <mhng-e73e59bf-92fc-4122-9f9e-a329d20eba55@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9mh636u/PTV1OGEX"
Content-Disposition: inline
In-Reply-To: <mhng-e73e59bf-92fc-4122-9f9e-a329d20eba55@palmer-ri-x1c9>


--9mh636u/PTV1OGEX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 09:13:28AM -0700, Palmer Dabbelt wrote:
> This first one isn't showing up in a in-flight merge `git diff`, but it l=
ooks
> pretty straight-forward
>=20
>     diff --git a/Documentation/rust/arch-support.rst b/Documentation/rust=
/arch-support.rst
>     index c9137710633a..4d1495ded2aa 100644
>     --- a/Documentation/rust/arch-support.rst
>     +++ b/Documentation/rust/arch-support.rst
>     @@ -16,7 +16,8 @@ support corresponds to ``S`` values in the ``MAINTA=
INERS`` file.
>      Architecture   Level of support  Constraints
>      =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>      ``arm64``      Maintained        Little Endian only.
>     -``loongarch``  Maintained        \-
>     +``loongarch``  Maintained        -

I think this is actually the wrong resolution, and the \ should be kept
as it was added as a fix in commit 01848eee20c6 ("docs: rust: fix improper
rendering in Arch Support page").

Cheers,
Conor.

>     +``riscv``      Maintained        ``riscv64`` only.
>      ``um``         Maintained        ``x86_64`` only.
>      ``x86``        Maintained        ``x86_64`` only.
>      =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D

--9mh636u/PTV1OGEX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZk4a8AAKCRB4tDGHoIJi
0mK1AP9Pxgv9bhp8dbNKAXiD5cCYopI1w29Rdtl2b0fCUCdXkwEAv41/xxjdQZEp
R78M3mmahMKQdBka2ZfnttLHkVKA3wA=
=Basl
-----END PGP SIGNATURE-----

--9mh636u/PTV1OGEX--

