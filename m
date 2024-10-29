Return-Path: <linux-kernel+bounces-386570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF4C9B453C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 10:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19C7B1C20FBD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 09:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6E2204034;
	Tue, 29 Oct 2024 09:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VjmnSwTT"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40390201013;
	Tue, 29 Oct 2024 09:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730192699; cv=none; b=sU4uX2XZUn66W2wU7kBUfvFXXgk6rv5OMPcVwv5WgmHWwX+wbwtcny8VzpQLXxiRGkZMsXTCDsDKduJISsrWmtbAgoyxYMNZVmu993LSquWxbl0n4V+KIUmhVBUEj0DiS58zQajOP2HJQZrKDKMlO9bC8yiCbR+m+aVRQLGkyOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730192699; c=relaxed/simple;
	bh=6jaDgZ3DNkahwBNCukCudBZoY/QkHxpPgLi5XLIbEOM=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=Ym2j2VxYFQEBuIYEHOHogDBviSjFdxjJscy4AfpmvYpunTrDbSKcsbW9I6ir3E9WrPbd843wHfaqR5krenKPNAjHqqqs91l4WOjimXoCb4mOcImgwKUoxv0BuGx++n5LhgtMmdcpwGM47Q3XUvF4lhmy6zKMt3wxQ43A5nGSkBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VjmnSwTT; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6981D40008;
	Tue, 29 Oct 2024 09:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730192688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0KD2jpCw1JGfugQWWsRB3ODTkIZm9Svp5uxhwbyJ8ms=;
	b=VjmnSwTTunC2i2wYT8UKn9bcnk4dlPuLlhpNpvBLsmwYcnCYgha5P/sjjkbWxhSIDnov7t
	2Udy/oCcPYGTcS9p6OVTmMnmISnnzwR7f1OZWPc5B+he78GvIEBldjMG1A9EYMVnrA0PEp
	IDorzjxPSGEdPZxuuAqlo9BIhhk3qWyPAPvnvDpeu7hLtt4sUwnrQAdD9M2Mq46PlTTSVg
	h2Z/YveGJtigEm3JbdF9BAL500LJFQaJRmCdu5Twh4HptF7Kx/Q4LkR7zcuI2D5AMA90Ys
	QqJ5XcjY/xaJN0XR0OHFKCpNiq7W6vdC+ZyxHBKXnrXOHLyW1+dUby/P7mWXTA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 29 Oct 2024 10:04:48 +0100
Message-Id: <D5864C0GXLOD.2R2G7Y8CA3T6B@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH v5 4/4] clk: eyeq: add driver
Cc: <devicetree@vger.kernel.org>, <linux-clk@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, =?utf-8?q?Gr=C3=A9gory_Clement?=
 <gregory.clement@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>
To: "Stephen Boyd" <sboyd@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Michael Turquette"
 <mturquette@baylibre.com>, "Rob Herring" <robh@kernel.org>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20241007-mbly-clk-v5-0-e9d8994269cb@bootlin.com>
 <20241007-mbly-clk-v5-4-e9d8994269cb@bootlin.com>
 <b3f8bf0e933064a49d1a5e3527646200.sboyd@kernel.org>
 <D534ZSNLN6G0.3HSREQ803OFIQ@bootlin.com>
 <02cbfefaf7db9220652c2f9605838f96.sboyd@kernel.org>
 <D541S8TMBS94.3AKP8ET4TID6Y@bootlin.com>
 <39b99c310a307d97955ec6f9335c0439.sboyd@kernel.org>
In-Reply-To: <39b99c310a307d97955ec6f9335c0439.sboyd@kernel.org>
X-GND-Sasl: theo.lebrun@bootlin.com

On Mon Oct 28, 2024 at 11:52 PM CET, Stephen Boyd wrote:
> Quoting Th=C3=A9o Lebrun (2024-10-24 05:50:16)
> > The bug is elsewhere: we do get valid clocks from PL011. Both clk_get()
> > calls give proper pointers.
> >=20
> > The issue is that we are using `compatible =3D "fixed-factor-clock"`
> > clocks in the middle, and those don't wait for their parents to be
> > active.
> >=20
> > Simplified clock graph is: pll-per -> occ-periph.
> > pll-per is register by our driver. occ-periph looks like:
> >=20
> >         occ_periph: occ-periph {
> >                 compatible =3D "fixed-factor-clock";
> >                 clocks =3D <&olb EQ5C_PLL_PER>;
> >                 #clock-cells =3D <0>;
> >                 clock-div =3D <16>;
> >                 clock-mult =3D <1>;
> >         };
>
> Why is this fixed factor clk registered from DT vs. from the driver that
> registers pll-per? Is it useful to describe it in DT because the factor
> can change? Where does it physically exist? In the SoC?

Those are internal SoC clocks, yes. No reason for them to change from
one board to another. Adding them from the driver makes the most sense,
I'll patch that up.

> > Sequence is:
> >  - eqc_early_init(): it registers a clock provider that will return
> >    EPROBE_DEFER for our pll-per.
> >  - _of_fixed_factor_clk_setup(): it registers occ-periph, even though
> >    its parent is EPROBE_DEFER. clk_core_populate_parent_map() runs all
> >    fine without complaining; logical as it doesn't query the clk_hw for
> >    its parent, it only stores indexes.
> >  - amba_get_enable_pclk(): it does a clk_get() which works because
> >    occ-periph exists.
> >=20
> > Maybe __clk_register() should check the clk_hw for each parent: if any
> > is an EPROBE_DEFER then it should EPROBE_DEFER itself? That looks like
> > a rather big behavioral change.
> >=20
> > The other solution is to keep as-is: provide all clocks consumed by
> > fixed-factor-clocks at of_clk_init() stage.
>
> Another solution is to register the fixed factor clk from the pll-per
> clk provider.
>
> And yet another solution is to return EPROBE_DEFER for orphaned clks. We
> have everything in place for that but we ran into trouble with consumers
> wanting to get orphaned clks in their probe or during assigned-clocks
> handling.

No suprise this kind of edge-case behavior can cause trouble.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


