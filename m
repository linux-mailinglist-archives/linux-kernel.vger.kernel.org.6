Return-Path: <linux-kernel+bounces-389269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 048029B6AC5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 18:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEA831F23458
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 17:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F406212F1D;
	Wed, 30 Oct 2024 17:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s1lhCbCt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853921BD9F7;
	Wed, 30 Oct 2024 17:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730308493; cv=none; b=Mn7J/iLM0fTw2DfGoa16b/RwBT2PiBtuiPgVjZFO8VhsQVSNds2zSksyrCdGEcsZWS7O6xSVI6rjgP7hOzpzucFbeFMzzDJRE9In/YaxLWcGrBDPlbjeHav/vAPRPAaifh6vi7HgcbT1wB835qlWvqE7fOwKmrAoL6LhRSoqlm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730308493; c=relaxed/simple;
	bh=u+UIzsE2LAWlfcNx/d9eBpjzeP5vEFMjHlcbR8gn1LQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BH3EdS7rbKuLFpQFNZ+iWEUKj8xCeT+l1anvpA3GImG0LqCiI00aQEKFtZPSalAMHWlaZSyM57eHiuC6vSzTv6AqMFIsnljm5Yuh6xPvpka4HrZGRzSImaIMblHAjU8D1zkV/8xZ9RYpixEa6kPh+wNvOdADnmxP1eKi2Bxl1I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s1lhCbCt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA3CFC4CECE;
	Wed, 30 Oct 2024 17:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730308493;
	bh=u+UIzsE2LAWlfcNx/d9eBpjzeP5vEFMjHlcbR8gn1LQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s1lhCbCtrulrKBX3bgLiC9qOLS9kzPc4e1HFBFJpRXJCOdHswYlDpbZFWn21SnXif
	 ahzA/MLaKt/wjWXPO6leBwahWvelCqhCccCpkMmyZtI+wwOZsfkKbCL7s79w3reBLb
	 E1G/4rLMpVGVojOUscwUvTvoqq5UlW1lIgcS6EujkXeHZms7kuOBQ6LdjMwBAlfWNx
	 l4XpGJPrzTqcwjb6A16j53uIJX8PGobSDQGz29+7Ktzu1gWQ8mOiCj0BcqIITapoWb
	 YI2FA6C9vg6ozegrWqXHGo1PgVT1u4+NxfshFr017AyP4eAht1EzSSE8EvGRqypmiP
	 OJjsHiDKm0zow==
Date: Wed, 30 Oct 2024 17:14:48 +0000
From: Mark Brown <broonie@kernel.org>
To: Suraj Sonawane <surajsonawane0215@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sound: fix uninit-value in i2s_dma_isr
Message-ID: <635f1691-74e9-4e48-8ebf-8e7ce0c6d1e3@sirena.org.uk>
References: <20241030170829.36161-1-surajsonawane0215@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MQdPN2PYzhrYRi+s"
Content-Disposition: inline
In-Reply-To: <20241030170829.36161-1-surajsonawane0215@gmail.com>
X-Cookie: I feel partially hydrogenated!


--MQdPN2PYzhrYRi+s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 10:38:29PM +0530, Suraj Sonawane wrote:
> Fix an issue detected by the Smatch tool:
>=20
> sound/soc/bcm/bcm63xx-pcm-whistler.c:264 i2s_dma_isr()
> error: uninitialized symbol 'val_1'.
> sound/soc/bcm/bcm63xx-pcm-whistler.c:264 i2s_dma_isr()
> error: uninitialized symbol 'val_2'.
>=20
> These errors occurred because the variables 'val_1' and 'val_2' are
> declared but may not be assigned a value before they are used.
> Specifically, if the loop that assigns values to 'val_1' and 'val_2'
> does not execute (for example, when 'offlevel' is zero), these
> variables remain uninitialized, leading to potential undefined
> behavior.
>=20
> To resolve this issue, initialize 'val_1' and 'val_2' to 0 at the
> point of declaration. This ensures that 'val_1' and 'val_2' have
> defined values before they are used in subsequent calculations,
> preventing any warnings or undefined behavior in cases where the
> loop does not run.

This will shut the warning up, but why are these values valid?  Are we
handling the cases where the loops do not execute properly?

--MQdPN2PYzhrYRi+s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmciaYgACgkQJNaLcl1U
h9C3dwf+JZ315ez2ikVHreXBKQBRZVx0IZE8f7hZigdeRuM0J0jpU8645q/YSReP
T2hZeIFihq0odYaL+d4wzO/7MFLuUD49dsRDmvFAMP3Bc+MMHo98GAcXqRT+5yhT
xMhdu0+DAuFLeYP+IUpfXuv9p2FLIt/f/7maH9Rbtz5vmZ4y21VwNlWgafMMen/w
RP9FDB/Va+YuVMGIqYYXWSWjSVKPvFkj5vGWoiwKPF8OEFrurUJUwDqqkrsNTGg1
Rhp15h2F4MdU+FAaB+pocSsJkFYS9rH7FYarBDMkv259YHVtvLon/6SErT3tzxXx
v1q3nuMqKYU/kcUD+KFg1PSstpxpJg==
=FU6s
-----END PGP SIGNATURE-----

--MQdPN2PYzhrYRi+s--

