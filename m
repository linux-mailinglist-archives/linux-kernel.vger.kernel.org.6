Return-Path: <linux-kernel+bounces-264123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8269593DF25
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 13:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E441B22F30
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 11:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F04E6CDAB;
	Sat, 27 Jul 2024 11:25:39 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265BF41746;
	Sat, 27 Jul 2024 11:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722079538; cv=none; b=F0SwgH9z7FFt5P0gNaZ/c6pe+sg48J+enHkuwWJgIlXeSpIM021x6IrUVM4U10ne5xFgXPOwTrTDTcHHGse2+XFE49Ez8wH44CdOI09Ka9C67/bM/71xhhSrXo9zldcrIZg04ojh6Vygw1kS1tx7F+Rh2rbLN8Iw0gFUKnsYyrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722079538; c=relaxed/simple;
	bh=shcZgEGUYYMT+gcHW7Kj4tHAAku12N18LuY18LdFaxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=We/09GMIlW6aAmhgcwgpB7hmbiV0fUljShkWUMGgX/wHkf1ppfb5FyDAsKf4cXUrTFABFNu5GZCbIxfT04VZfaPON2z1QKps1PGVHrXHZU3zPVVELeccimRhj3CIPQlwc0t9OZ4HzHlU1D4AP6aFIwiwL91zaKoNdmR32yHJOZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e860cde.versanet.de ([94.134.12.222] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sXfYK-0005ZZ-6A; Sat, 27 Jul 2024 13:25:32 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Conor Dooley <conor@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc: mturquette@baylibre.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
Subject:
 Re: [PATCH v2 1/3] dt-bindings: clocks: add binding for
 voltage-controlled-oscillators
Date: Sat, 27 Jul 2024 13:25:31 +0200
Message-ID: <33119212.aRNtrjHk3s@diego>
In-Reply-To: <00f9f4b8722d97b1c6fcec27d53bc06d.sboyd@kernel.org>
References:
 <20240715110251.261844-1-heiko@sntech.de>
 <20240718-prozac-specks-6b5fd8b83e3e@spud>
 <00f9f4b8722d97b1c6fcec27d53bc06d.sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Samstag, 27. Juli 2024, 00:21:44 CEST schrieb Stephen Boyd:
> Quoting Conor Dooley (2024-07-18 08:59:50)
> > 
> > FWIW, I wouldn't classify this as device-specific. "enable-gpios" and
> > "vdd-supply" are pretty generic and I think the latter is missing from
> > the vast majority of real* "fixed-clocks". I would expect that devices
> > where the datasheet would call
> > 
> > * Real because there's plenty of "fixed-clocks" (both in and out of tree)
> > that are used to work around the lack of a clock-controller driver for an
> > SoC.
> 
> I agree!
> 
> > 
> > > I think generic power-sequences
> > >   were the topic back then, though that might have changed over time?
> > > - There are places that describe "fixed-clock" as
> > >   "basic fixed-rate clock that cannot gate" [1]
> > 
> > I think that that is something that could be changed, it's "just" a
> > comment in some code! Sounds like Stephen disagrees though :)
> 
> It's more about making a clear break from the fixed-clock binding so
> that the extra properties are required.
> 
> > 
> > > - Stephen also suggested a separate binding [2]
> > 
> > I liked your "gated-oscillator" suggestion in another reply, but
> > "gated-fixed-clock" might be a better "thematic" fit since this is a
> > special case of fixed-clocks?
> > 
> 
> It looks to me like we've arrived at the hardest problem in computer
> science, i.e. naming. Any of these names is fine. I'd look to see what
> those parts on mouser are called and use that to drive the compatible
> name decision if you can't decide. The description section in the
> binding could be verbose and link to some parts/pdfs if that helps too.
> In the past I've seen EEs call these things clock buffers. I'm not a
> classically trained EE myself but it usually helps to use similar names
> from the schematic in DT because DT authors are sorta translating
> schematics to DT.

TL;DR: I'm fine with both "gated-oscillator" or "gated-fixed-clock" .
Some tiny part in the back of my head wants to name things in the most
specific way aka "gated-oscillator", but I guess "gated-fixed-clock" will
possibly spare us the naming dance in the future :-)

So I guess if nobody objects anymore, I'll go with "gated-fixed-clock".

--------- 8< --------
Some background stuff for the oscillator / clock-buffer difference,
which are actually both used on the Rock 5 ITX in question:

[my ASCII-art may not survive mail readers]
                                        ------------
VCC3v3_PI6C (to both VDD + Enable) -----| VCC*     | - CLKoutA - to PCIe
  |                                     |          |
--------------------                    |          | - CLKoutB - to PCIe
| 100MHz,3.3V,3225 |-------XTAL_IN_OUT -| Au5426   |
--------------------                    |          | - REFout (unconnected)
                                        ------------

Just asking Google for that "100MHz,3.3V,3225" brings me to
"100 MHz Standard Clock Oscillators" on Mouser.

The Au5426 from Aurasemi is a "4 Differential and 1 LVCMOS Output Ultra
Low Jitter High Performance Buffer" - aka a clock-buffer.

In the Rock-5-ITX patch, I opted to ignore it, because on _that_ board
it is transparent to the system, enabled by the same sources as the
crystal and statically configured.

On the other hand, the Au5426 actually _has_ input pins to select
its working mode: 
- select between different clock sources
- enable/disable the output of the input clock as refclk
- configure the clock buffer type (lvpecl, lvds, hcsl, hiz)

So I didn't want to conjure a binding for that stuff out of thin air :-)


Heiko



