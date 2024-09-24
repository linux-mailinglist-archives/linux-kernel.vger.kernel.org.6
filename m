Return-Path: <linux-kernel+bounces-337282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C63984811
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 16:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D4B5B22CC2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 14:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE3D1AB504;
	Tue, 24 Sep 2024 14:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GOX8iNnX"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A524D1A7249;
	Tue, 24 Sep 2024 14:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727189634; cv=none; b=EO2cmKTmF++vv8urEvrYYsMGbWjh/nSbUur1JZen5fcm/P1qBHIJtaffhRtUmee5bZisyGW5XdR624Vwnzejocdg/Qps3Y1B/wvtJXQitRUFVuxOPRFPB5MQNedIBd4yYklsY4xw6n71h9drBXBmZvdBf94B1OeFL6XYCPT3G5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727189634; c=relaxed/simple;
	bh=TCJLDM7gCBvwoMwYfgBNZ+Z5C02vQHEWGskPMXyLimU=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=hysEjnT1FzAlrbkQpweOAPPW4IdAwXv0OJFjpvHCFq3/qHUC9pBwL2aiqhZwwtX2AxE7VkWsyUJYXXrWEPM0BQAqucTNskRG1YvtLTToNa35f+zj12HT1ibTZ7aSBEJjjD0tW+j8+9Y8NUOzS82ap3cYUC9EvKwwLfIOt+SxXLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GOX8iNnX; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1306AE0014;
	Tue, 24 Sep 2024 14:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727189624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wigSxOqNkKcKbc8lRP6tKsLp+aMKAD5JcJ5P3FL8EaI=;
	b=GOX8iNnXPdY5HXhMnvys4sJ200DTi2dA+V956WeoyIL0rlp7yMnV83Fy8ylPb9TJB1MgBL
	4XsVFT1++sB/rpdgGZFZIV1d7kAFYTcpbO+Jj5El4qizEigRgUVLqitjVES5t4kGvPX5yZ
	+yeo/IMK5hffqfqWZiGIWcgqqcbhnngjjIINGChwwDqVe3xpiNn8SqC+hCD3i8B/J/nbPU
	kfmWn5StScH1n7waqdK/3BE38XGng+FHEVgOUIfxJvVVxvyQ/AvKn5C/u11923BmGABmT7
	nImymXPXo7hTV9Z8v2ozEuMWOA3tLrNXPYZolWW9FrhQ5qBZtq0t+mO8EjAHGQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Sep 2024 16:53:43 +0200
Message-Id: <D4ELMFAUQYZ7.3LXGQZJSX68UF@bootlin.com>
To: "Stephen Boyd" <sboyd@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Michael Turquette"
 <mturquette@baylibre.com>, "Rob Herring" <robh@kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH RESEND v3 4/4] clk: eyeq: add driver
Cc: <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, =?utf-8?q?Gr=C3=A9gory_Clement?=
 <gregory.clement@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20240730-mbly-clk-v3-0-4f90fad2f203@bootlin.com>
 <20240730-mbly-clk-v3-4-4f90fad2f203@bootlin.com>
 <586966c515e15f455973e7c55bd3ac5e.sboyd@kernel.org>
In-Reply-To: <586966c515e15f455973e7c55bd3ac5e.sboyd@kernel.org>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello Stephen,

Only answering to questions to which I have answers.
The rest is addressed for next revision.

On Wed Sep 18, 2024 at 7:28 AM CEST, Stephen Boyd wrote:
> Quoting Th=C3=A9o Lebrun (2024-07-30 09:04:46)
> > diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> > index 3e9099504fad..31f48edf855c 100644
> > --- a/drivers/clk/Kconfig
> > +++ b/drivers/clk/Kconfig
> > @@ -218,6 +218,19 @@ config COMMON_CLK_EN7523
> >           This driver provides the fixed clocks and gates present on Ai=
roha
> >           ARM silicon.
> > =20
> > +config COMMON_CLK_EYEQ
> > +       bool "Clock driver for the Mobileye EyeQ platform"
> > +       depends on 64BIT # for readq()
> > +       depends on OF || COMPILE_TEST
>
> What's the OF build dependency? If there isn't one please remove this
> line.

There is none (at least we have a compat layer that means we can build
even with CONFIG_OF=3Dn). Removed in next revision.

>
> > +               *mult =3D *mult * 0x100000 + FIELD_GET(PCSR1_FRAC_IN, r=
1);
> > +       }
> > +
> > +       if (!*mult || !*div)
> > +               return -EINVAL;
> > +
> > +       /* Spread spectrum. */
> > +       if (!(r1 & (PCSR1_RESET | PCSR1_DIS_SSCG))) {
> > +               /*
> > +                * Spread is 1/1000 parts of frequency, accuracy is hal=
f of
> > +                * that. To get accuracy, convert to ppb (parts per bil=
lion).
> > +                */
> > +               u32 spread =3D FIELD_GET(PCSR1_SPREAD, r1);
> > +
> > +               *acc =3D spread * 500000;
>
> Where does 500000 come from? Half a billion?

In addition to the above comment, I added this to clarify:

	 * acc =3D spread * 1e6 / 2
	 *   with acc in parts per billion and,
	 *        spread in parts per thousand.

[...]

> > +
> > +static const struct eqc_early_match_data eqc_eyeq6h_central_early_matc=
h_data =3D {
> > +       .early_pll_count        =3D ARRAY_SIZE(eqc_eyeq6h_central_early=
_plls),
> > +       .early_plls             =3D eqc_eyeq6h_central_early_plls,
> > +       .nb_late_clks =3D 0,
> > +};
> > +
> > +/* Required early for UART. */
>
> Is this required for earlycon? Where is the UART not a device driver
> that needs to get clks early?

The UART is PL011. It is an AMBA device, those get probed before
platform devices by of_platform_bus_create(). "pll-per" must be
available at that time.

[...]

> > +static void __init eqc_init(struct device_node *np)
[...]
> > +       spin_lock(&eqc_list_slock);
>
> I don't see how the spinlock provides any value. This function will run
> before any struct devices have been created.

Indeed no clash can happen. Will remove.

>
> > +       list_add_tail(&priv->list, &eqc_list);
>
> The list is also kind of unnecessary. Set a bool in the match_data and
> move on? We could have some sort of static_assert() check to make sure
> if there's a CLK_OF_DECLARE_DRIVER() then the bool is set in the
> match_data for the driver. Such a design is cheaper than taking a lock,
> adding to a list.

This list's main goal is not to know what was early-inited. Its only
reason for existence is that we want to get, at eqc_probe(), the cells
pointer allocated at eqc_init().

struct eqc_priv {
	/* this field is why we store priv inside a linked list: */
	struct clk_hw_onecell_data	*cells;
	/* the rest, we don't care much: */
	const struct eqc_early_match_data *early_data;
	const struct eqc_match_data	*data;
	void __iomem			*base;
	struct device_node		*np;
	struct list_head		list;
};

I do not see how to do that with a bool. We could put the pointer into
the match data, but that would mean we'd have to make them writable
(currently static const data). We are talking about a linked list with
two items in the worst case (EyeQ6H), accessed twice.

The reason we store the whole of priv: simpler code and we avoid mapping
registers twice (once at eqc_init() and once at eqc_probe()).

Can you confirm the current static linked list approach (without any
spinlock) will be good for next revision?

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


