Return-Path: <linux-kernel+bounces-254391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85BDE9332B0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 22:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4605B2833B1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 20:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC70C1A2560;
	Tue, 16 Jul 2024 20:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="nK0+7Ki2"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19E919F477;
	Tue, 16 Jul 2024 20:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721160669; cv=none; b=Mc2A9Fi2I887oeXFT8/6YHYzADykbP6Ge8jJGF9hk/q3YugSfHWvTdiszMqwXGeuVyGvdSZxEglzy5CQI6xwMeQdrEQSyp+6S8CFUEgHexfWr1Eo08MbZlpSsbgQ2mivr65BkuRBAA2KQyM3vKnfNChQM+YcIFemjwG3n5vKK5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721160669; c=relaxed/simple;
	bh=6pmHMEmUxMpbFQs48GQ6MskIRmBnGh3l7ycRIPEdiwQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=p5TIiPzqgh4wgRlY44ZJt/OYeGF4Q2nzVL8dV7WPUaZlj7XXLwoWVbWhQxn7dPIV/CjhcuKTIKxYHLztKDIzgLv3AveMdE3nwzhu2q9kg6Bn7J9JAR/JHXmES3yOsxYmOwBIHPPfWe5pE/f/tUygJM8XOT3jt7bf8XqxsbAsC5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=nK0+7Ki2; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1721160663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Gr4Tt/4RDJMqOyQSHRFnO0qkTxn2d0ynsCHySOLEAA=;
	b=nK0+7Ki2CZmmn09ZBJ7KVoICHInvS0VwzHqyUESuXBGnJpRj6Qp6y1LTMRW1JttVsSwuB/
	7LrvqJ3za/v+eAfs2exHrNOcv8v7sYfXDS9ay1wPimODWQUrBlrvUOurM8opXtfs7BVzEP
	ygGOSichUAbQYbPWZFcZCTWFYROAk4qg1XciUjYoHgCq3Hlt9ypfFwkRvUchCnVJQYrHO6
	/Sd+XdCcPTm1fEnMoJt9zRUkzBn6+SH5nUr7euH68ZNwPkiQCIAdsjM3/NitVcCnsjGIe8
	t9xOZ2qiHj/q/S8V2aGQuMsXcKp3CaCuJoTheGpHCIA3z18JFmjudO76OXqExg==
Date: Tue, 16 Jul 2024 22:11:02 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 1/3] dt-bindings: clocks: add binding for
 voltage-controlled-oscillators
In-Reply-To: <2186398.KiezcSG77Q@diego>
References: <20240715110251.261844-1-heiko@sntech.de>
 <2832997.XrmoMso0CX@diego> <3f0c241d39c5fedb674d7f9808d0be8f@manjaro.org>
 <2186398.KiezcSG77Q@diego>
Message-ID: <dca9e4c3e2ed61bf25a2d96a82a77e04@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Heiko,

On 2024-07-15 21:13, Heiko Stübner wrote:
> Am Montag, 15. Juli 2024, 20:01:35 CEST schrieb Dragan Simic:
>> On 2024-07-15 19:46, Heiko Stübner wrote:
>> > Am Montag, 15. Juli 2024, 17:15:45 CEST schrieb Dragan Simic:
>> >> On 2024-07-15 13:02, Heiko Stuebner wrote:
>> >> > In contrast to fixed clocks that are described as ungateable, boards
>> >> > sometimes use additional oscillators for things like PCIe reference
>> >> > clocks, that need actual supplies to get enabled and enable-gpios to be
>> >> > toggled for them to work.
>> >> >
>> >> > This adds a binding for such oscillators that are not configurable
>> >> > themself, but need to handle supplies for them to work.
>> >> >
>> >> > In schematics they often can be seen as
>> >> >
>> >> >          ----------------
>> >> > Enable - | 100MHz,3.3V, | - VDD
>> >> >          |    3225      |
>> >> >    GND - |              | - OUT
>> >> >          ----------------
>> >> >
>> >> > or similar. The enable pin might be separate but can also just be tied
>> >> > to the vdd supply, hence it is optional in the binding.
>> >> >
>> >> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>> >> > ---
>> >> >  .../bindings/clock/voltage-oscillator.yaml    | 49 +++++++++++++++++++
>> >> >  1 file changed, 49 insertions(+)
>> >> >  create mode 100644
>> >> > Documentation/devicetree/bindings/clock/voltage-oscillator.yaml
>> >> >
>> >> > diff --git
>> >> > a/Documentation/devicetree/bindings/clock/voltage-oscillator.yaml
>> >> > b/Documentation/devicetree/bindings/clock/voltage-oscillator.yaml
>> >> > new file mode 100644
>> >> > index 0000000000000..8bff6b0fd582e
>> >> > --- /dev/null
>> >> > +++ b/Documentation/devicetree/bindings/clock/voltage-oscillator.yaml
>> >> > @@ -0,0 +1,49 @@
>> >> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> >> > +%YAML 1.2
>> >> > +---
>> >> > +$id: http://devicetree.org/schemas/clock/voltage-oscillator.yaml#
>> >> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> >> > +
>> >> > +title: Voltage controlled oscillator
>> >>
>> >> Frankly, I find the "voltage-oscillator" and "voltage controlled
>> >> oscillator" names awkward.  In general, "clock" is used throughout
>> >> the entire kernel, when it comes to naming files and defining
>> >> "compatible" strings.  Thus, I'd suggest that "clock" is used here
>> >> instead of "oscillator", because it's consistent and shorter.
>> >>
>> >> How about using "gated-clock" for the "compatible" string, and
>> >> "Simple gated clock generator" instead of "voltage controlled
>> >> oscillator"?  Besides sounding awkward, "voltage controlled
>> >> oscillator" may suggest that the clock generator can be adjusted
>> >> or programmed somehow by applying the voltage, while it can only
>> >> be enabled or disabled that way, which is by definition clock
>> >> gating.  Thus, "gated-clock" and "Simple gated clock generator"
>> >> would fit very well.
>> >
>> > The naming came from Stephen - one of the clock maintainers ;-)
>> > See discussion in v1. Who also described these things as
>> > "voltage-controlled-oscillators".
>> >
>> > And from that discussion I also got the impression we should aim for
>> > more specific naming - especially when talking about dt-bindings, for
>> > this
>> > "usage in the Linux kernel" actually isn't a suitable metric and
>> > "gated-clock" is probably way too generic I think.
>> 
>> I see, thanks for the clarification.  Though, the generic nature of
>> "gated-clock" as the name may actually make this driver a bit more
>> future-proof, by allowing some other features to be added to it at
>> some point in the future, avoiding that way the need for yet another
>> kernel driver.
> 
> you're talking about the driver ... we're in the hardware-binding here.
> Those are two completely different topics ;-) .
> 
> Devicetree is always about describing the hardware as best as possible,
> so you don't want too many "generics" there, because we're always 
> talking
> about specific ICs soldered to some board.
> 
> I also "violated" that in my v1 by grouping in the the Diodes parts, 
> which
> as Stephen pointed out are quite different afterall.

I'll make sure to go through the v1 discussion in detail ASAP.  After
that, I'll come back with some more thoughts.

