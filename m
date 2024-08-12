Return-Path: <linux-kernel+bounces-282488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F5B94E4A5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 04:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF7E62820BB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 02:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543B454759;
	Mon, 12 Aug 2024 02:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="Ye5qpq/7"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD2923B1;
	Mon, 12 Aug 2024 02:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723428504; cv=none; b=S4KNlCW0iFIfrgNocI7gLu63fQj7vX95+cgFm/b9CHY9bJ4mX4JUkIYyLI3bB6kbS6veqakITgB/E2hHhMcwKzfJEsLvLp1VgPlePzfjWkrCX2hPlztKYoNwW3LgZFcPobB+TM6mxC9P5JgadSOVPaahLANEGyGwjRG6cZ0/oSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723428504; c=relaxed/simple;
	bh=YAsrXW5d3SIYsLSaM+FJjDPo7GYyx7b2NG7kyLX0PoA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Sb07dTcnfTbnterxbh8hGjYLPXl/OWTQHKavQdKU7MGWnp5v7oRB2JBPlV4kGmw07NVMauC45Sg8rnvINAyqBeAXR3MWNh9pLa+2GzzMqObPz4WpIwhZ3E6qSu2FvXuRYzfGr1TBqXBtIggcXoSOeMI27Vw0oMe/23WKJ5k4sWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=Ye5qpq/7; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1723428494;
	bh=JTT/61+iAaL3ekZ/bVEpRb8HtfF2o4NXHxGC5uHvBs4=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=Ye5qpq/7TST1h2y4P4d4+VKoZjLzGvE6I0IoHD/4yoltNCDnlsKwmT4U0D6iPAytt
	 Myu6aKDL35RUn+iQNRBRPWYi+fkxkVSO3HvgL9CBrQQ3/B/Cs0racAr2vOKqqlgA41
	 vM+Azdc7FBnPQJ/ol3GLCdqCNjcueVgSEGXnBB1IHBH2MB0/myXzemOyPAn9TtcZuy
	 L9X6ClcE9iFsbvH5DJNLVNuq05yjLQXnx+Cp2m8YGN2qSQS0lhmUz98ln0apJWpk0x
	 s+rsqCIqINwFOMWMZyyFuLOrDtiC62en8eG/TCE1pzPwqB9Ot18KXWbKfE4STbrYT9
	 i+L3KXt+KlkBg==
Received: from [192.168.68.112] (203-57-213-111.dyn.iinet.net.au [203.57.213.111])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 2CF1566AB4;
	Mon, 12 Aug 2024 10:08:12 +0800 (AWST)
Message-ID: <799dbd97b09693fba6f837e73d4ef3421d604a8a.camel@codeconstruct.com.au>
Subject: Re: [PATCH v3 02/11] ARM: dts: aspeed: Harma: add VR device
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Peter Yin <peteryin.openbmc@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	 <joel@jms.id.au>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 12 Aug 2024 11:38:11 +0930
In-Reply-To: <7bf4cb57f2b0b41c79f2efea3e0b0211988c0896.camel@codeconstruct.com.au>
References: <20240801160136.1281291-1-peteryin.openbmc@gmail.com>
	 <20240801160136.1281291-3-peteryin.openbmc@gmail.com>
	 <7bf4cb57f2b0b41c79f2efea3e0b0211988c0896.camel@codeconstruct.com.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-08-02 at 16:06 +0930, Andrew Jeffery wrote:
> On Fri, 2024-08-02 at 00:01 +0800, Peter Yin wrote:
> > Add isl69260, xdpe152c4 device
> >=20
> > Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
> > ---
> >  .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 24 +++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> >=20
> > diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/a=
rch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
> > index d99fba321379..8fb30029e46c 100644
> > --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
> > +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
> > @@ -398,6 +398,30 @@ imux28: i2c@0 {
> >  			#address-cells =3D <1>;
> >  			#size-cells =3D <0>;
> >  			reg =3D <0>;
> > +			power-monitor@61 {
> > +				compatible =3D "isil,isl69260";
> > +				reg =3D <0x61>;
> > +			};
> > +			power-monitor@62 {
> > +				compatible =3D "isil,isl69260";
> > +				reg =3D <0x62>;
> > +			};
> > +			power-monitor@63 {
> > +				compatible =3D "isil,isl69260";
> > +				reg =3D <0x63>;
> > +			};
>=20
> As of v6.11-rc1 this gives me:
>=20
> ```
> $ ./scripts/checkpatch.pl --strict -g HEAD
> ...
> WARNING: DT compatible string "isil,isl69260" appears un-documented -- ch=
eck ./Documentation/devicetree/bindings/
> #24: FILE: arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts:402:
> +                               compatible =3D "isil,isl69260";
>=20
> WARNING: DT compatible string "isil,isl69260" appears un-documented -- ch=
eck ./Documentation/devicetree/bindings/
> #28: FILE: arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts:406:
> +                               compatible =3D "isil,isl69260";
>=20
> WARNING: DT compatible string "isil,isl69260" appears un-documented -- ch=
eck ./Documentation/devicetree/bindings/
> #32: FILE: arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts:410:
> +                               compatible =3D "isil,isl69260";
>=20
> total: 0 errors, 3 warnings, 0 checks, 30 lines checked
> ```
>=20
> and
>=20
> ```
> $ make CHECK_DTBS=3Dy aspeed/aspeed-bmc-facebook-harma.dtb 2>&1 | grep is=
il
> ...
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: /ahb/apb/bus@1e78=
a000/i2c@700/i2c-mux@70/i2c@0/power-monitor@61: failed to match any schema =
with compatible: ['isil,isl69260']
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: /ahb/apb/bus@1e78=
a000/i2c@700/i2c-mux@70/i2c@0/power-monitor@62: failed to match any schema =
with compatible: ['isil,isl69260']
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: /ahb/apb/bus@1e78=
a000/i2c@700/i2c-mux@70/i2c@0/power-monitor@63: failed to match any schema =
with compatible: ['isil,isl69260']
> ```
>=20
> While there's already an Aspeed-based Quanta platform that also
> specifies this device, let's not add to the problems of the Aspeed
> devicetrees.
>=20
> Please make sure to run `make dtbs_check ...` and checkpatch on your
> changes. Regarding `make dtbs_check` and related tests, this blog post
> is helpful:
>=20
> https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sou=
rces-with-the-devicetree-schema/

On the basis of the reviews on [1] and Rob stating he's applied the
binding patch, I've applied this series to be picked up through the BMC
tree.

[1]: https://lore.kernel.org/all/20240809070056.3588694-1-peteryin.openbmc@=
gmail.com/

Thanks,

Andrew

