Return-Path: <linux-kernel+bounces-351358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF8D990FFF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 22:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BAD91F26648
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 20:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8541E0DA5;
	Fri,  4 Oct 2024 19:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="BN88Dd13"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1431DE4FF
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 19:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728071055; cv=none; b=GeNOTs+eSiFrD7nGdFLpbvQ7aFu0dakw6CGZ8B6XNoKDHbHKjL96Jm8PO2uqsikWnkoPuPHqME/2xM/XRlDjGEYdBOTTiSfp67t3T6086SsfzZgA7xAbKcbg5GcqoSVqAOBaocOSFjQDULxXaf/fs1uyOEJSwCwQsvFZoHVQMGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728071055; c=relaxed/simple;
	bh=TrYVJfjyHQHRAQzKoL0ASI8joiGlm8dDP5uYge0bOwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hrH0VEvn0JtmhgSzVpTp9EdwwHTttNCii5Ovks6v8N//+uDUx0uwGaZQgh5VA4Nch1J6SQRZ98WHRhyFBPA1cmH7AwzHVqb/dGvZRGz1s0BWn1B1VmyMb2gSjJkqenoYz/kwhGiWQIirGAhaklNTQPx41amyhYLp51t/OEF11f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=BN88Dd13; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=EamE
	PJoZ9YuXjphhH8JC5qAA0fvN4OcCtfbUgSHwD1g=; b=BN88Dd13rdKlQ43saRv/
	m382/GoUYy6v4b6EYVVU3Zi6o26jx7o1+Fl13Mi77phyEF5pax1yQ2IM8esXKYC0
	SNaiAYRI7zVFzGZ87tZ8RoZx2m5SUoIiOeSdGA1oqJSF0306/06cYquuEAC8PCNq
	nJW/Agk9l/kX6BFJIRahhE80tCNrvryB5elYXRtI85XX3l30KFHz0SvbCc66/NcY
	cVJyNN9JxLiDGKeWQ1Nm8CsJDt6eWFjlL2zxtkj5c1GFiaFu1U2Qb+6pMu0mzhUk
	sVgOohXK72jJBBtqA4r8GEmTWQDFhYdJLR6cT8O4EBfOdJ+8y32fOUczEVzuDJce
	sQ==
Received: (qmail 3542989 invoked from network); 4 Oct 2024 21:44:06 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 4 Oct 2024 21:44:06 +0200
X-UD-Smtp-Session: l3s3148p1@9yzc5KsjAK5QvCeD
Date: Fri, 4 Oct 2024 21:44:05 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c <linux-i2c@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>, Marek Vasut <marex@denx.de>
Subject: Re: [GIT PULL] i2c-host-fixes for v6.12-rc2
Message-ID: <ZwBFhR9WVhuwhdM1@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	linux-i2c <linux-i2c@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>, Marek Vasut <marex@denx.de>
References: <jtzq4rriyqzerfbxcb2hojrrmdj3cenooijz37u7ejh7twawfo@zussiajim3rt>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xLGFq0V9Gp16vUw6"
Content-Disposition: inline
In-Reply-To: <jtzq4rriyqzerfbxcb2hojrrmdj3cenooijz37u7ejh7twawfo@zussiajim3rt>


--xLGFq0V9Gp16vUw6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758e=
dc:
>=20
>   Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)
>=20
> are available in the Git repository at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git tags=
/i2c-host-fixes-6.12-rc2
>=20
> for you to fetch changes up to 048bbbdbf85e5e00258dfb12f5e368f908801d7b:
>=20
>   i2c: stm32f7: Do not prepare/unprepare clock during runtime suspend/res=
ume (2024-10-01 16:39:00 +0200)

Thanks, pulled!


--xLGFq0V9Gp16vUw6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmcARYEACgkQFA3kzBSg
KbbIGBAAj9j3BvUz1RiiFa2MAwYpAdV1FgMH2KwCBn8kdF3n89ufb+JyEqQ1+BvI
NBYdbolAXqq9AqFyTSHrb/k1Y6IfW72vrsXmR6+0Tj9NWqLEaKh/TA1ybwLEC17j
knReybo57SJtdS6Uy6tNy7jcUgkW3tFJtSnOPGBG0LAiJOC4PNAqLna5pxGl5GXy
RV7J7+c5EaowncmVcE4ORJhOS8XVMQLTWUX3SlNWDRt+HiZ5P2xa199SvPZOF5P1
5rIgAFssMGLZRJ+4LVpJkTF0mr3aHhgitGaQDW1nJ4de0oYl+PMU0CYmLw9+bb1/
I9bmguwqizVHLHwkoPVsifUHBWWzOtMF8z0BVCuPWxGTLtz9BmNsVR/gA30trBBJ
8hk9miKpnloSmPO7D8Z80YrH/gjh0fUDJLOJQxOQkomDRoHBO6mhiIQpn1DkYWyP
ZmjbgEmtJAK4X7VNiAMdtOOYxcXU+RqD4ibIhN6KhRXS7dvgn5kJ//6R82vqJigz
AgpCtXvsPtyxEInBatXxdns03fQF/UhSBAr6rBUL91yx4ghISRnHqNMXHDDb24z6
MbIjEAC9oP9l0sUp5VOGCH9vkVijWkamD0ov8KlrtFXgf8u3XmOaz5oihIPeNQm6
qiNfrZp2vXdspuN5iqi7cnjnoVruVe8E+FVG6AjSWb7aGc5QwfI=
=gONl
-----END PGP SIGNATURE-----

--xLGFq0V9Gp16vUw6--

