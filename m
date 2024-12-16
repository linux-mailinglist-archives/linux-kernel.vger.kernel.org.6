Return-Path: <linux-kernel+bounces-448052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D589F3A75
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 21:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C9211888A8B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 20:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4250E1CEACD;
	Mon, 16 Dec 2024 20:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T7bxWYQR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0388339A8;
	Mon, 16 Dec 2024 20:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734379754; cv=none; b=ZhMxRVv7YZzE7EEIAE7gayIYUMtru2Whs1VlpnhMRSqYwrX3IyZFR3KF7kscpHVfhiza/+91BqcHtnwt32Sgr1SuMadEbcDx/e6RZWKKcmhrZE45B45d0k1Xd5XgUH6cduPc6fFS+tugj5htmNgi/a1Y6rOwXDCCCUQQjVwx/UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734379754; c=relaxed/simple;
	bh=Ajv+SLsg/GiAOURmWAmHL8wxGVRWma3tzp34DC7dGEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TpxEpJyyJg0HwgtVWsJjHL7BCas5abVjIoa6zVDzqEDT3MaeSUTS3b44rMfIXnMysRnhfxN1uREmCgbvCqrg2Vjubqh8T5gWeYM1nmHCqIbU8FDQjfWVbLIT77UmPwfhNJSZdLUCN4oyM+HYR+uNd/5mv3Ci8peCip/WG/r+zC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T7bxWYQR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57697C4CED0;
	Mon, 16 Dec 2024 20:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734379754;
	bh=Ajv+SLsg/GiAOURmWAmHL8wxGVRWma3tzp34DC7dGEc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T7bxWYQRt2nRAiP3KX4O/Wmpbcdn962UVtW4c5BVLQeAYnPksk2d5swqx5iiEPUpq
	 WEoRiJO0Idppg/6TvTM1mw05rUKVwjdEXuqIp0FWcFimvIZTWXmBHWc96MOHF+AFeB
	 FrpkyfXKq60blPQMSZoaEgCK6P9LrZ/GylbhNaNdfN5Gn94w63fmtcdp3Ke1xjE7Dk
	 CYFO0kCyILaKOzQ+ahwqqoEKRNwDS6KSQNF+pKj2EpOhEHKNhCNxphvU2JNSfRJF0x
	 HDkDSIbGVt5lc5DOVRrojG02MTaSiIo0qwqMXpXV90rnANrQTafK9Idi4f4bQU3LVn
	 eblfrdJwUfafg==
Date: Mon, 16 Dec 2024 20:09:09 +0000
From: Conor Dooley <conor@kernel.org>
To: E Shattow <e@freeshell.de>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Hal Feng <hal.feng@starfivetech.com>,
	Jianlong Huang <jianlong.huang@starfivetech.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: dts: starfive: Fix a typo in StarFive JH7110 pin
 function definitions
Message-ID: <20241216-nuttiness-arrogant-27063bd1c47b@spud>
References: <20241210042002.165297-1-e@freeshell.de>
 <oacmcw5yvdlsmvqbt4dbdmsx6rvd6x43qv2ejmypw57jgraqu7@txhhsxdg2agq>
 <e4e19875-c02c-4673-814b-86090223b55d@freeshell.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="N6lwbiqT70gdwRWZ"
Content-Disposition: inline
In-Reply-To: <e4e19875-c02c-4673-814b-86090223b55d@freeshell.de>


--N6lwbiqT70gdwRWZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 11:58:29AM -0800, E Shattow wrote:
> Hi Krzysztof,
>=20
> On 12/13/24 01:37, Krzysztof Kozlowski wrote:
> > On Mon, Dec 09, 2024 at 08:19:56PM -0800, E Shattow wrote:
> > > Fix a typo in StarFive JH7110 pin function definitions for GPOUT_SYS_=
SDIO1_DATA4
> > >=20
> > > Fixes: e22f09e598d12 ("riscv: dts: starfive: Add StarFive JH7110 pin =
function definitions")
> > > Signed-off-by: E Shattow <e@freeshell.de>
> > > Acked-by: Hal Feng <hal.feng@starfivetech.com>
> > > ---
> >=20
> > Why are you sending the same multiple times? Where is the changelog and
> > proper patch versioning?
> >=20
> > Best regards,
> > Krzysztof
> >=20
>=20
> I did respond to Hal's comment that the patch is missing a commit title
> description and that I would re-send. How instead should the message be
> formatted so the patch commit title description is changed but the patch =
is
> not the same being sent multiple times?  And now, again, based on your
> comment that this is not a typo I will again change the commit description
> but I don't know how to do that without sending again as a duplicate.
>=20
> Thank you for the review and for your patience with me when I am learning
> how to participate.

FWIW, this should be v2. Don't resend for that.

--N6lwbiqT70gdwRWZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ2CI5QAKCRB4tDGHoIJi
0h8XAQDfEK+StAVpeKk1JbjwhFO7IWDiTdyVJYwV3RBO+0EpTgEAnW4HWnSV4NCp
1mo5X7aeQN0fSR+A+l16E/NBUXLECAc=
=grkq
-----END PGP SIGNATURE-----

--N6lwbiqT70gdwRWZ--

