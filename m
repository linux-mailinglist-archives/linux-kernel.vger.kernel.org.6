Return-Path: <linux-kernel+bounces-256570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC052935059
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 18:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AFFB1C21524
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 16:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E220F144D1E;
	Thu, 18 Jul 2024 15:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H5vHfytm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167FA2AEE3;
	Thu, 18 Jul 2024 15:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721318395; cv=none; b=LEHKAyZt2o8QXZZccqkm4T3f4QjSG0C7n88EcI++sA1NwYmCb+K66f+I+ZtyMflXGLsGmy/XlAuPLIhTOStIw6gQUO1wJV2RJRIf6M23S9pgiuxUftc1466zCbtj3NVF65E5oy1QyRLhs8YEnwOddwglACXQsIeTjv5X05rYNtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721318395; c=relaxed/simple;
	bh=T4DfjvkHoIEyUPZXgAngg+UvPIuZJXu0JXGh6sWNt+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PFuGf+jQJyBMuhzl9f9r6JuNlWMI8/ollRxCYg/J9dE+FmbMA+znpVxm/9U+Ok/r+OABb4g0844Xwt9uuDO4tjH41g/zpBoFZLnw+F9CX6ewG66Dj0wbwvnUsL3D+yI6VrKcD3jBaeOE6VnA/0JWdrQlNEUlTIsSa+ntyHsjmMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H5vHfytm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74CC4C116B1;
	Thu, 18 Jul 2024 15:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721318394;
	bh=T4DfjvkHoIEyUPZXgAngg+UvPIuZJXu0JXGh6sWNt+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H5vHfytmqPrYO2pIj4jHkuG37Chv40x0l0h3Sl9muo3W743GzaXi685mZhYM0PxKX
	 qY1W1G26W7T74h+GzelvwecVAFTeTXk9rS8s0mQ2GKIYdDO42kuRxaqVqrh2TahtTQ
	 DeHvsXWD9ZivyLsPP2cPrfcRhHVGjhOpnAu6E2gVglYI8L5kBeOhdkdF7NyIHCE16+
	 a5zjypcBX6vE5qs/Lv0EYy6aFU/RvxcL/edVsn3r695CfrtVLzE5ZixZJ7yRSkCZZ3
	 xj91p5dsHYcjo2FApj2Eyy7dD3bzfk3avOiu1CvosShMilzoG3i6t+04/kuIvDFVu3
	 OJDGaKacKGgbw==
Date: Thu, 18 Jul 2024 16:59:50 +0100
From: Conor Dooley <conor@kernel.org>
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 1/3] dt-bindings: clocks: add binding for
 voltage-controlled-oscillators
Message-ID: <20240718-prozac-specks-6b5fd8b83e3e@spud>
References: <20240715110251.261844-1-heiko@sntech.de>
 <20240715110251.261844-2-heiko@sntech.de>
 <20240716-deceiving-saucy-851fb2303c1f@spud>
 <3178118.zE8UqtGg2D@diego>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TA6tyFoqBwcLvbVt"
Content-Disposition: inline
In-Reply-To: <3178118.zE8UqtGg2D@diego>


--TA6tyFoqBwcLvbVt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 11:25:28AM +0200, Heiko St=FCbner wrote:
> Hi Conor,
>=20
> Am Dienstag, 16. Juli 2024, 18:15:08 CEST schrieb Conor Dooley:
> > On Mon, Jul 15, 2024 at 01:02:49PM +0200, Heiko Stuebner wrote:
> > > In contrast to fixed clocks that are described as ungateable, boards
> > > sometimes use additional oscillators for things like PCIe reference
> > > clocks, that need actual supplies to get enabled and enable-gpios to =
be
> > > toggled for them to work.
> > >=20
> > > This adds a binding for such oscillators that are not configurable
> > > themself, but need to handle supplies for them to work.
> > >=20
> > > In schematics they often can be seen as
> > >=20
> > >          ----------------
> > > Enable - | 100MHz,3.3V, | - VDD
> > >          |    3225      |
> > >    GND - |              | - OUT
> > >          ----------------
> > >=20
> > > or similar. The enable pin might be separate but can also just be tied
> > > to the vdd supply, hence it is optional in the binding.
> > >=20
> > > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > > ---
> > >  .../bindings/clock/voltage-oscillator.yaml    | 49 +++++++++++++++++=
++
> > >  1 file changed, 49 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/clock/voltage-o=
scillator.yaml
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/clock/voltage-oscillat=
or.yaml b/Documentation/devicetree/bindings/clock/voltage-oscillator.yaml
> > > new file mode 100644
> > > index 0000000000000..8bff6b0fd582e
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/clock/voltage-oscillator.yaml
> > > @@ -0,0 +1,49 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/clock/voltage-oscillator.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Voltage controlled oscillator
> >=20
> > Voltage controlled oscillator? Really? That sounds far too similar to a
> > VCO to me, and the input voltage here (according to the description at
> > least) does not affect the frequency of oscillation.
>=20
> That naming was suggested by Stephen in v1 [0] .

I think "voltage-oscillator" is a confusing name, and having "voltage
controlled oscillator" in the title doubly so as this isn't a binding
for a VCO.
A VCO is a more general case of the sort of device that you're talking
about here, so a part of me can see it - but I think specific
compatibles would be required for actual VCOs, since the "transfer
function" would vary per device.

> Of course the schematics for the board I have only describe it as
> "100MHz,3.3V,3225" , thumbing through some mouser parts matching that
> only mentions "supply voltage" in their datasheets but not a dependency
> between rate and voltage.
>=20
> [0] https://lore.kernel.org/linux-arm-kernel/b3c450a94bcb4ad0bc5b3c7ee871=
2cb8.sboyd@kernel.org/
>=20
> > Why the dedicated binding, rather than adding a supply and enable-gpio
> > to the existing "fixed-clock" binding? I suspect that a large portion of
> > "fixed-clock"s actually require a supply that is (effectively)
> > always-on.
>=20
> I guess there are three aspects:
> - I do remember discussions in the past about not extending generic
>   bindings with device-specific stuff.

FWIW, I wouldn't classify this as device-specific. "enable-gpios" and
"vdd-supply" are pretty generic and I think the latter is missing from
the vast majority of real* "fixed-clocks". I would expect that devices
where the datasheet would call

* Real because there's plenty of "fixed-clocks" (both in and out of tree)
that are used to work around the lack of a clock-controller driver for an
SoC.

> I think generic power-sequences
>   were the topic back then, though that might have changed over time?
> - There are places that describe "fixed-clock" as
>   "basic fixed-rate clock that cannot gate" [1]

I think that that is something that could be changed, it's "just" a
comment in some code! Sounds like Stephen disagrees though :)

> - Stephen also suggested a separate binding [2]

I liked your "gated-oscillator" suggestion in another reply, but
"gated-fixed-clock" might be a better "thematic" fit since this is a
special case of fixed-clocks?

Cheers,
Conor.

> With the fixed-clock being sort of the root for everything else on most
> systems, I opted to leave it alone. I guess if the consenus really is that
> this should go there, I can move it, but discussion in v1=20
>=20
> Interestingly the fixed clock had a gpios property 10 years ago [3] :-) .

heh!

>=20
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/drivers/clk/clk-fixed-rate.c#n18
> [2] https://lore.kernel.org/linux-arm-kernel/68f6dc44a8202fd83792e58aea13=
7632.sboyd@kernel.org/
> [3] https://lore.kernel.org/linux-kernel//20140515064420.9521.47383@quant=
um/T/#t

--TA6tyFoqBwcLvbVt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZpk79gAKCRB4tDGHoIJi
0ocpAQDlY1WVEOAb/tAnKL+v/4KqvF6yQjSSOa/QJ9Xn/KwzwQEA6xZbMOFj+ofl
qMmgXTkeOunG/hACMIplnIyteyzFRwI=
=RPQe
-----END PGP SIGNATURE-----

--TA6tyFoqBwcLvbVt--

