Return-Path: <linux-kernel+bounces-379877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFF09AE55F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 14:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 528172840C9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 12:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7421D63C0;
	Thu, 24 Oct 2024 12:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LqIszyJS"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561331B6CEE;
	Thu, 24 Oct 2024 12:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729774222; cv=none; b=Y62pCEVFP9O+Ohrwc7C+6RMICClcE6sN6+DXJjTXxX2Crfnpg/+ZAXz7K5Hpq5BFFaNLPqTe+cEh8hXUiT08aZ1p77lH6ALj5ApkM74FuOVg23r/t8tExVpeMnAo7ajapnfCcYHm9CTeuE0As0mPH/uYTEdg3MLpwxBbQ9sKW4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729774222; c=relaxed/simple;
	bh=avnNeoeIT8JpECkgYOeBGQu4w8Q/PrPpQiEZobjRdnI=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=FylnHlisGEog6F50/rEarAryvH9hdG8fC7PixZmKRpazpHOMFkaL8RY4htx7w3nBBCJ1fMpmpE1wTj2FoC2Ljn0NZJab589pX0UQLGS4wmPZig6hLG5Z4zSsm2BHyUbwwyyJvQerFeF9G29PpwyhLx86ZTwppA6Ayb7tPaMVi5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LqIszyJS; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D67A7C0004;
	Thu, 24 Oct 2024 12:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729774217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FGC5TIDFWHTEOzBsSk81jwrMpqimrnfQMOZKCKiznX0=;
	b=LqIszyJSBO0jIhBCI8z1vLKfO+/lMMshwNPPNXhRONN45/G5H9xvtR/B8g8RFBQ01zLu/j
	XyqkSlioPkpu0jqMvw2vncogxZuvL3tgN9W8oL1hCak3H7sSjfWm7tWZfU+vuUS8wVIYRL
	ZrzkDyJmpqDWRP7CaGHBPmeNolcFgWTm4GrnEmlnk+hp4blXYsIKI34SANbb5gcoP+zrD9
	7cwZfg5cPsGCgv9jA1dSEvBXZ66jqAYrv1otALE/hK813AWOgqtCpLYTl4bYqcHONfF2mu
	NQgTP124boEQO+9N6iN3dUjtOhmWnhXvT7Jzsz2k/UpynNxrPIsGzzeXIkNUww==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Oct 2024 14:50:16 +0200
Message-Id: <D541S8TMBS94.3AKP8ET4TID6Y@bootlin.com>
To: "Stephen Boyd" <sboyd@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Michael Turquette"
 <mturquette@baylibre.com>, "Rob Herring" <robh@kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH v5 4/4] clk: eyeq: add driver
Cc: <devicetree@vger.kernel.org>, <linux-clk@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, =?utf-8?q?Gr=C3=A9gory_Clement?=
 <gregory.clement@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20241007-mbly-clk-v5-0-e9d8994269cb@bootlin.com>
 <20241007-mbly-clk-v5-4-e9d8994269cb@bootlin.com>
 <b3f8bf0e933064a49d1a5e3527646200.sboyd@kernel.org>
 <D534ZSNLN6G0.3HSREQ803OFIQ@bootlin.com>
 <02cbfefaf7db9220652c2f9605838f96.sboyd@kernel.org>
In-Reply-To: <02cbfefaf7db9220652c2f9605838f96.sboyd@kernel.org>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello Stephen, Conor, Krzysztof, Michael, Rob,

On Thu Oct 24, 2024 at 12:12 AM CEST, Stephen Boyd wrote:
> Quoting Th=C3=A9o Lebrun (2024-10-23 04:08:31)
> > On Thu Oct 17, 2024 at 8:48 PM CEST, Stephen Boyd wrote:
> > > Quoting Th=C3=A9o Lebrun (2024-10-07 06:49:19)
> > > > +/* Required early for UART. */
> > >
> > > I still don't get this. UART isn't an early device. It's only the
> > > interrupt controller and the timer that matter. Does MIPS do somethin=
g
> > > special for UARTs?
> >=20
> > Our hardware has a PL011. That is AMBA stuff; they get probed before
> > platform devices by of_platform_bus_create(). "pll-per" on EyeQ5 must
> > be available at that time.
> >=20
> > In concrete terms, if we don't register pll-per on EyeQ5 at
> > of_clk_init(), we stare at void because the serial fails probing.
> > I haven't digged into why EPROBE_DEFER doesn't do its job. Anyway we
> > don't want our serial to stall for some time during our boot process.
> >=20
>
> Ok thanks for the details. It sounds like there's a bug in there
> somewhere. Eventually this should be removed.
>
> Can you dump_stack() in clk_get() when the "pll-per" clk is claimed?
>
> I suspect of_clk_get_hw_from_clkspec() is seeing NULL if
> of_clk_hw_onecell_get() is being used and the clk_hw pointer isn't set
> yet. NULL is a valid clk and it will be returned to the consumer. You'll
> want to write a custom 'get' function for of_clk_add_hw_provider() that
> returns -EPROBE_DEFER for any clk that isn't registered early. Then the
> AMBA stuff should defer probe until the "full" clk provider is
> registered.

You encouraged me to keep digging.

The bug is elsewhere: we do get valid clocks from PL011. Both clk_get()
calls give proper pointers.

The issue is that we are using `compatible =3D "fixed-factor-clock"`
clocks in the middle, and those don't wait for their parents to be
active.

Simplified clock graph is: pll-per -> occ-periph.
pll-per is register by our driver. occ-periph looks like:

	occ_periph: occ-periph {
		compatible =3D "fixed-factor-clock";
		clocks =3D <&olb EQ5C_PLL_PER>;
		#clock-cells =3D <0>;
		clock-div =3D <16>;
		clock-mult =3D <1>;
	};

Sequence is:
 - eqc_early_init(): it registers a clock provider that will return
   EPROBE_DEFER for our pll-per.
 - _of_fixed_factor_clk_setup(): it registers occ-periph, even though
   its parent is EPROBE_DEFER. clk_core_populate_parent_map() runs all
   fine without complaining; logical as it doesn't query the clk_hw for
   its parent, it only stores indexes.
 - amba_get_enable_pclk(): it does a clk_get() which works because
   occ-periph exists.

Maybe __clk_register() should check the clk_hw for each parent: if any
is an EPROBE_DEFER then it should EPROBE_DEFER itself? That looks like
a rather big behavioral change.

The other solution is to keep as-is: provide all clocks consumed by
fixed-factor-clocks at of_clk_init() stage.

Hoping I provided enough info,
Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


