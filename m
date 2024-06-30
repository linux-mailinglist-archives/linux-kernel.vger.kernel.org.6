Return-Path: <linux-kernel+bounces-235204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9191891D186
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 13:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 501A31F218FF
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 11:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B46213C685;
	Sun, 30 Jun 2024 11:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="hTn0AXCL"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A3039863
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 11:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719748435; cv=none; b=HHwm1w/iNEk6xDSmLZtX46YL7w70oTqAju91MTmg44WanRoOxSvfgRCvLaYSrHdf2kGLmhBuhTHD+lKjPJON1tU0y4CasSvWGdZCKBUcxdepj3h1xb3Hdi+b4xZSQrsBu8pykcxYi5sfXYU0tszvp5n72npctpEaCw/Uv958Xrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719748435; c=relaxed/simple;
	bh=Rc/rkJP79Bg+yJWN98zeLCeIPPgSRC0sq2d22DX92g8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B54kZxODBP6FI2P6xJKNYNG6GVTUAMcqBzX+P2Jzei6wecDf0YJDW7+MClw+19b82zdCj0PiDxBCizZB41QN1l5XjDwzU37YMwvJyQ2q9nTJvLycA1nt3VgHkhS8ZOTppG7JL84v6rGbFoIt+7SbLWz0z+5vTM4dAhXFaXWmr0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=hTn0AXCL; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
X-Envelope-To: linux-rockchip@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1719748430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y+fDDJqQ+osPbRhFMpBP9B/lzHqe+hkb/V0i04petRE=;
	b=hTn0AXCLVq+C4+llFVwC1ciz2avIme9mohkFaT7BpiOH20qYWq5jPWMIWO+P+hrMGga43i
	D5+bxDlZusjXBmjapgf66E30wMwfg7nPxeWDJeqd1vgjI5OVVew/IPDimCOgL9Fl+rZAIk
	KbHDOyJDw6JGiZeW55aLgnvztWzLvEC7zGSuPmpZ7n4TxD7QBfCJtLhGupkqRtY2r9LNq8
	tZq6fsL7lT8eZZ5ZBBBCcLKaogIyiqboW4zSHiXiZeh+HyOejDc70sLIwlC5VNRJZakWQR
	nVe6Kxb9XSmy7XPMAmV8qxkIv7725BvaobCaWE6sQTqmLk5ppvys7nGvj1nGMQ==
X-Envelope-To: heiko@sntech.de
X-Envelope-To: dsimic@manjaro.org
X-Envelope-To: linux-arm-kernel@lists.infradead.org
X-Envelope-To: devicetree@vger.kernel.org
X-Envelope-To: robh@kernel.org
X-Envelope-To: krzk+dt@kernel.org
X-Envelope-To: conor+dt@kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: jonas@kwiboo.se
X-Envelope-To: didi.debian@cknow.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Diederik de Haas <didi.debian@cknow.org>
To: linux-rockchip@lists.infradead.org,
 Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc: Dragan Simic <dsimic@manjaro.org>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-kernel@vger.kernel.org,
 Jonas Karlman <jonas@kwiboo.se>, Diederik de Haas <didi.debian@cknow.org>
Subject:
 Re: [PATCH v2] arm64: dts: rockchip: Add GPU OPP voltage ranges to RK356x SoC
 dtsi
Date: Sun, 30 Jun 2024 13:53:36 +0200
Message-ID: <2794811.2mGxvYehNa@bagend>
Organization: Connecting Knowledge
In-Reply-To: <1894199.CQOukoFCf9@diego>
References:
 <bdb60f1f793166cd65f58ab7aea025347076019c.1719679068.git.dsimic@manjaro.org>
 <2442162.AJoTavkB1d@bagend> <1894199.CQOukoFCf9@diego>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2147336.LgE2u5Xh1p";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Migadu-Flow: FLOW_OUT

--nextPart2147336.LgE2u5Xh1p
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; protected-headers="v1"
From: Diederik de Haas <didi.debian@cknow.org>
Date: Sun, 30 Jun 2024 13:53:36 +0200
Message-ID: <2794811.2mGxvYehNa@bagend>
Organization: Connecting Knowledge
In-Reply-To: <1894199.CQOukoFCf9@diego>
MIME-Version: 1.0

On Sunday, 30 June 2024 11:07:47 CEST Heiko St=FCbner wrote:
> Am Sonntag, 30. Juni 2024, 00:01:41 CEST schrieb Diederik de Haas:
> > On Saturday, 29 June 2024 18:39:02 CEST Dragan Simic wrote:
> > > Add support for voltage ranges to the GPU OPPs defined in the SoC
> > > dtsi for RK356x.  These voltage ranges are useful for RK356x-based
> > > boards that are designed to use the same power supply for the GPU
> > > and NPU portions of the SoC, which is described further in the
> > > following documents:
> > >   - Rockchip RK3566 Hardware Design Guide, version 1.1.0, page 37
> > >   - Rockchip RK3568 Hardware Design Guide, version 1.2, page 78
> >=20
> > That was interesting to read, thanks.
> > Now I understand the difference between rk809(-5) and rk817(-5).
> >=20
> > But AFAIUI the above description described why there were separate tabl=
es
> > for rk809 and rk817 in v1. But that was dropped in v2. So it seems to me
> > the (commit) message should be updated accordingly?
> >=20
> > I also expected that (for v1) there would be a similar construct as was
> > recently added for rk3588. But I should interpret Heiko's comments as t=
hat
> > strategy should not be applied to rk356x?
>=20
> The issue I had was more about the #ifdef'ery and then having a board def=
ine
> a constant to enable one or the other.

Yeah, I had some thoughts about that too, but by the time I was ready to=20
respond to that, there was v2, so that became irrelevant.

> As far as I understood the description, the OPP itself is the same in
> terms of frequency and voltage, just the regulator can't fully realize
> that target voltage, so the solution is to allow a voltage range, to
> also support the less-exact regulator.
>=20
> On the rk3588 on the other hand the soc variants have different OPP
> tables themselfs, because the soc itself only supports different
> frequencies+voltages. So the solution here is the split of the OPPs so
> that we don't mess around with /delete-node/ edits of one OPP table.
>=20
> So TL;DR separate OPP tables are the way to go if the user needs different
> freq+voltage values and voltage ranges allows boards to use less-adapted
> regulators.

Thanks for the explanation.

One of the things I researched was whether there was a different OPP table
in Rockchip's rk3566.dtsi (and then the assumption that RK817 =3D RK3566 and
RK809 =3D RK3568, which would be flawed/incorrect). But there wasn't.

Cheers,
  Diederik
--nextPart2147336.LgE2u5Xh1p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZoFHQAAKCRDXblvOeH7b
bgjgAP9vzAu7MpfS69xyFFLPIIGggmPUGMKxwsGTISYyDo1sHAD9HLwFVtMo7sv9
mQ/R7ZmppweghrcD2CYHYBSJEJVL1QI=
=AB/w
-----END PGP SIGNATURE-----

--nextPart2147336.LgE2u5Xh1p--




