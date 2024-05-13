Return-Path: <linux-kernel+bounces-177336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5E08C3CFF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 10:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25C541F220E7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 08:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCAB9147C77;
	Mon, 13 May 2024 08:16:29 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF811474CB;
	Mon, 13 May 2024 08:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715588189; cv=none; b=WUz2Iz0l8L68UkrDk+ECOPHFfd/l/fIHO15zM1dvR4IKcgcDeK8tb7gbVn0MDJuISlR/bF0gRLWRBVhjMHFKFYIq3HgHXqYeBV+ts5sHkadj0YKM00ei1JhOHr2m2djuJXxzq+GzB+0eJmqpeBvG6jo1lpZyskQF7yxZu1o+xjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715588189; c=relaxed/simple;
	bh=NXBrLThuklWZqNs8w3b1pytZG5qciBgjefEGygakocs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PbQSfSV7t/17HC+vGhRJLLuGldcAr3ZBAmmCH/fkfVCqWloGmB4f67MZptmEqL4Pknc2IZ0HtMmdW7SLu9kb3L94oC3ApYtsF4a11Gsqxy6kKLmfsYSw3eZKv8l0j8GQ77s3/cNBjdbPzz2J0RIC/mBQFeQQa1ai7yOPrjaOV7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 5C9B41C0081; Mon, 13 May 2024 10:16:25 +0200 (CEST)
Date: Mon, 13 May 2024 10:16:24 +0200
From: Pavel Machek <pavel@denx.de>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Derek Fang <derek.fang@realtek.com>,
	Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.1 04/25] ASoC: dt-bindings: rt5645: add cbj
 sleeve gpio property
Message-ID: <ZkHMWILCOpWADFnp@duo.ucw.cz>
References: <20240507231231.394219-1-sashal@kernel.org>
 <20240507231231.394219-4-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cXmMi4BKc2kFXQpw"
Content-Disposition: inline
In-Reply-To: <20240507231231.394219-4-sashal@kernel.org>


--cXmMi4BKc2kFXQpw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Add an optional gpio property to control external CBJ circuits
> to avoid some electric noise caused by sleeve/ring2 contacts floating.
>=20
> Signed-off-by: Derek Fang <derek.fang@realtek.com>

AFAICT this is unused in -stable, as we don't have corresponding dts
change (this is just docs). Please drop.

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--cXmMi4BKc2kFXQpw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZkHMWAAKCRAw5/Bqldv6
8uwBAKCHr2eLLkLFaIhDwymnMh0rgp+XYwCePAWT8yOLWY0lJUG6NrBfw2hnCZA=
=B5AC
-----END PGP SIGNATURE-----

--cXmMi4BKc2kFXQpw--

