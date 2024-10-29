Return-Path: <linux-kernel+bounces-386512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A93F9B4467
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 09:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 389F1B21ADE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 08:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9111D2038D3;
	Tue, 29 Oct 2024 08:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="C8PH7V93"
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91ABA1F7565;
	Tue, 29 Oct 2024 08:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730191309; cv=none; b=VD0smTqhTZowXvmZrl5HgNDrzM90ouQuTvaYzjeIKcBKwT9A5p8sGH1WUtOr/6brqnY1BERaOp7p/c5M2qm7LPg8nZRyudNhlMFR0yULsN6AELOuYLv3kOWFgcQICF1G3bl4Qhkv4C86D1rxfQ0Y4ysx6SCjNU0UEyG+OM8Ekl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730191309; c=relaxed/simple;
	bh=29GtuOb78Tq1qYNR/nE/cnVHgRQpd26VnE8XbAtvsAY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tF0pMoApkcDqha2aVz01BtkD/VmWTmPWBynFXmLpybp7BSY9LwS+fdf8bFBnkfBmVmLMa9l5UmZSqRRaJw/svtbUDmtSAn2Iocj0N0+tAUYu3As1FKOW8qE0xZiLbhY/h/NOc27/pBNm4WweXv8L00Va/XXhV+24SlJ+IKtUi9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=C8PH7V93; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=q9tbeX7y+zJgZuAb/cGAaZ6MuCs4CQFq8FQvgssvj5E=; b=C8PH7V936k7jSRlqWNh/9IP9kq
	2lMBc9oVA6BILyiZI4TvY/qs23GQNfOWpQipGokmPTcvgTR+8AsdYx/mQol5PQ4B9Q3BXKcA5vwL0
	qaWWQBolR7aLKV1lPlDpe5qo7inNYIGy9fBvYgJYW28sCoV0QHkz/H9sBYaDd6geVj06rE866fs0k
	9UGEXv8I8JgXoDP8Bf/Zrom5MoisZ/iRJSIfZoFwauhEu2WhjwMcdPpDRhJu/D0pWBQAcH+Kqw8RX
	8FaYwoKRFjv4uv4cIaJd4NoZ2rZD6+W6BKaJdpB5qf6LUGoYxilHQ2YT+yj+/Ga7ZYy4IJ77fJWEx
	lRU3k4KQ==;
Date: Tue, 29 Oct 2024 09:41:41 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 linux-kernel@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
 devicetree@vger.kernel.org, Pengutronix Kernel Team
 <kernel@pengutronix.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, Sascha Hauer
 <s.hauer@pengutronix.de>, Alexander Stein
 <alexander.stein@ew.tq-group.com>, imx@lists.linux.dev, sre@kernel.org
Subject: Re: [PATCH v2 2/3] ARM: dts: imx: Add devicetree for Kobo Clara 2E
Message-ID: <20241029094141.04540d91@akair>
In-Reply-To: <f2bb661d-8ef5-43d4-aece-c7fec01ff9fe@gmail.com>
References: <20241024142206.411336-1-andreas@kemnade.info>
	<20241024142206.411336-3-andreas@kemnade.info>
	<f2bb661d-8ef5-43d4-aece-c7fec01ff9fe@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Am Tue, 29 Oct 2024 09:53:33 +0200
schrieb Matti Vaittinen <mazziesaccount@gmail.com>:

> On 24/10/2024 17:22, Andreas Kemnade wrote:
> > Adds a devicetree for the Kobo Clara 2E Ebook reader. It is based
> > on boards marked with "37NB-E60K2M+4A2" or "37NB-E60K2M+4B0". It is
> > equipped with an i.MX6SLL SoC.
> > 
> > Expected to work:
> >    - Buttons
> >    - Wifi
> >    - Bluetooth
> >      (if Wifi is initialized first, driver does not handle
> > regulators yet)
> >    - LED
> >    - uSD
> >    - USB
> >    - RTC
> >    - Touchscreen
> > 
> > Add human-readable comments for devices without mainlined driver and
> > binding. Such comments can e.g. be help to find testers if someone
> > starts to work on the missing drivers.
> > 
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>  
> 
> ...
> 
> > +
> > +	pmic@4b {
> > +		compatible = "rohm,bd71879", "rohm,bd71828";
> > +		reg = <0x4b>;
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&pinctrl_bd71828>;
> > +
> > +		interrupt-parent = <&gpio4>;
> > +		interrupts = <19 IRQ_TYPE_LEVEL_LOW>;
> > +		system-power-controller;
> > +
> > +		clocks = <&clks 0>;
> > +		#clock-cells = <0>;
> > +		clock-output-names = "bd71828-32k-out";
> > +
> > +		gpio-controller;
> > +		#gpio-cells = <2>;
> > +		gpio-reserved-ranges = <0 1>, <2 1>;
> > +
> > +		rohm,charger-sense-resistor-ohms = <30000000>;  
> 
> I am afraid that this one is _my_ very much terrible brainfart. Yeah, 
> pile up the stones and start casting ;)
>
... at everyone who had looked at this and did not question it ;-)
 
> I am fairly sure the sense resistor is 30 mOhm (0,030 Ohm), not 30
> MOhm (30 000 000 Ohm). (And I am the one who misinterpreted the M in
> some email/data-sheet in the past - and never questioned the sanity).
> 
Well, I did question it, but then thought, ok there might be some
current mirror to scale things down so that the massive rsense might
make sense. Well, no schematics here.

> In short, AFAICS the sense resistor is added "in series" to the
> system load. Eg:
> 
>            --------
>        ---| Rsense |-----
>       |    --------      |
>   ---------           -------
> | VSupply |         | Rload |
>   ---------           -------
>       |                  |
>        ------------------
> 
> Hence, by measuring the voltage drop on the Rsense gives us the
> current flowing through the system ( good old U = RI ).
> 
Yes, that is the way I did know how these things are usually done.
So I am still on track.

> I believe having 30 Mohm (30 000 000 Ohm) resistor there would not
> make much of sense... With a Fermi estimate that the system works
> with voltage magnitude of 1V and current magnitude of 1A and then
> applying good old P = UI and U = RI would give us wonderful results
> :) Quite a battery on poor Kobo, right? You'd better to not touch the
> battery termninals ;) Oh, and looking the driver code I've written
> for handling this property... Sometimes I really don't like mirrors :)
> 

> Well, now that I got this out - I suppose this could be
> rohm,charger-sense-resistor-milli-ohms = <30>;
> or
> rohm,charger-sense-resistor-micro-ohms = <30000>;
> 
> I further guess there is no upstreamn binding doc for this property.

The binding doc is upstream. So an impressive amount of maintainers
had a look at it...

Well, everyone seem to entrust Rohm Semiconductors to do magic...
wonderful reputation.

So how to proceed? As this property is not required, I can simply
remove it and add a comment.

> I think there is also no upstream charger driver for the
> BD71828/BD71879 - only an early RFC and some downstream mess - but
> stil it'd be nice to have the property in place as the size of the
> sense resistor is needed when converting coulomb counter register
> values to current.
> 
What are you upstreaming plans here? For all:
I rebased the charger stuff to v6.11 on
https://github.com/akemnade/linux branch kobo/power-6.11

Regards,
Andreas

