Return-Path: <linux-kernel+bounces-519889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BDAA3A330
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8873A188E468
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A1026F452;
	Tue, 18 Feb 2025 16:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qDqc9Ukk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3567322A80F;
	Tue, 18 Feb 2025 16:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739897435; cv=none; b=AYa9BHUXzaaZGrhBk7kTFVebiYeHaUYPykb2BuivW9ovDv8oVN3PV56lRCq4u4wo362nH/fAHpgcb2mXSCZ9cLyAQZth+8sFip/urz9wVlZWMWtjCuFeVV7sAHnfmy7yT1+T5rAW3x4J4VwGok+MqCokEpswoy4ySTQUWivpxPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739897435; c=relaxed/simple;
	bh=/YVHQ+p5V3VCdn+u9aKhlu71S03saM0vo09sgG79sWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y7x5Q5fayr5u26qdMsAsNXGZVqccfXWQhU5wtx3Cs0V6nHE412vaiyQ7vel7XkOqcvrDbmBzJB1imoKCqe6IDQ9UyYyYuftTK6CSIkJ4YQVnSkwSL+gfKTmcd9pPAM2U8sdqPwF3ADBY3lLZMkRndS9WA154/tAQRFrjYOYCc60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qDqc9Ukk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61C74C4CEE2;
	Tue, 18 Feb 2025 16:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739897434;
	bh=/YVHQ+p5V3VCdn+u9aKhlu71S03saM0vo09sgG79sWU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qDqc9UkkxW2nMEk503wToA7FM1ONqMLx5RxYYa0YBCAQy+2Uxgtk2qJ7veH03JWTM
	 JeNXodB/0x36gmhoNiS5jDt0pUodg8nlD+P0K9gzwp5hOdld34yotKzi8cPR5acJem
	 /gWw33X4Fzt1czqg5v5AJOcXhNlkRAb+1ZqgAaC+RqhiXAaz1Iiuv0XHfJcAMxlinS
	 8esBOwlcuxaK2Jd5ctgNIS6QT0TwCGIgXUfECcMSodmFqesrREcU8ExwGw4ENrgVHn
	 ePwfCtEVUozIlhZQN4+liIK+LbtQJjQl3N/acjqWIpXbu2RRZ6xr1Ca82dFEudnGxH
	 I9irZQomDOdqg==
Date: Tue, 18 Feb 2025 16:50:29 +0000
From: Conor Dooley <conor@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: sboyd@kernel.org, mturquette@baylibre.com, matthias.bgg@gmail.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	geert+renesas@glider.be, u.kleine-koenig@baylibre.com,
	amergnat@baylibre.com, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	kernel@collabora.com, macpaul.lin@mediatek.com,
	pablo.sun@mediatek.com
Subject: Re: [PATCH v2 1/2] dt-bindings: clock: mediatek,mt8188: Add
 VDO1_DPI1_HDMI clock
Message-ID: <20250218-ferry-glorifier-e10b0ae13371@spud>
References: <20250212100342.33618-1-angelogioacchino.delregno@collabora.com>
 <20250212-arming-gyration-103e42b94ed6@spud>
 <906ed1df-3c63-4028-ae7d-97e086acca32@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="koIZKDiabKMrvHLl"
Content-Disposition: inline
In-Reply-To: <906ed1df-3c63-4028-ae7d-97e086acca32@collabora.com>


--koIZKDiabKMrvHLl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 02:22:25PM +0100, AngeloGioacchino Del Regno wrote:
> Il 12/02/25 20:17, Conor Dooley ha scritto:
> > On Wed, Feb 12, 2025 at 11:03:41AM +0100, AngeloGioacchino Del Regno wr=
ote:
> > > Add binding for the HDMI TX clock found in the VDO1 controller.
> > > While at it, also remove the unused CLK_VDO1_NR_CLK.
> > >=20
> > > Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@=
collabora.com>
> > > ---
> > >   include/dt-bindings/clock/mediatek,mt8188-clk.h | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/include/dt-bindings/clock/mediatek,mt8188-clk.h b/includ=
e/dt-bindings/clock/mediatek,mt8188-clk.h
> > > index bd5cd100b796..0e87f61c90f4 100644
> > > --- a/include/dt-bindings/clock/mediatek,mt8188-clk.h
> > > +++ b/include/dt-bindings/clock/mediatek,mt8188-clk.h
> > > @@ -721,6 +721,6 @@
> > >   #define CLK_VDO1_DPINTF				58
> > >   #define CLK_VDO1_DISP_MONITOR_DPINTF		59
> > >   #define CLK_VDO1_26M_SLOW			60
> > > -#define CLK_VDO1_NR_CLK				61
> > > +#define CLK_VDO1_DPI1_HDMI			61
> >=20
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> >=20
> > btw, I see the mt8195 has this same CLK_VDO1_NR_CLK define in it, if you
> > fancy getting rid of that too.
>=20
> Thanks Conor, yeah I'll do that asap... one commit for each NR_CLK is a b=
it
> too much... I should just clean them all up :-)
>=20
> That requires a bit of work though, so it's not something that I can do in
> a few minutes; let's see if I can make it for this cycle, but no promises.

Yah, no worries. Was just pointing it out, don't need to let this
particular patch wait around for it by any means.

--koIZKDiabKMrvHLl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ7S6VAAKCRB4tDGHoIJi
0menAPwMIMl/Yz8zjCE/wgQtTGuMlk04Porrv7GFsIP8l1gNMQEArAqwMMdmP2j1
yXgjRkIPaKsOrL54hlT7KowOxubhEAo=
=hGQS
-----END PGP SIGNATURE-----

--koIZKDiabKMrvHLl--

