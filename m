Return-Path: <linux-kernel+bounces-256279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0019934BFB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 12:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17A16285440
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 10:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36EF139566;
	Thu, 18 Jul 2024 10:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="hCMeiDPf"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04F61B86FB;
	Thu, 18 Jul 2024 10:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721299994; cv=none; b=RgipHK920mK+LOEj0MUiyA8WmdElmjfIpHMjXx3oNbxNUb2atwhhPYKl0ylClGfnL9PZLLcx5qb5WGzzuX/0Q9HMhL/Jh7WTIuevkj/EnMLjWacXF7B+bXVTaXc2qodwefgfOh2MSiVySGYIUsEZgoToYCNJMqtvzphcIQhbV/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721299994; c=relaxed/simple;
	bh=MtuNKtElwbMYRL6eZCRLlxZgH0OR2KgTnilGOdo2dAc=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=QT126/ox7btpWcdJi1SVRK5eY6lJ33g8bRNXHymQ3U4hDEOzD4ztj79NZcJtnbzNwrPFGDQNc//mn2yG9ziDQ5zmPyuI/yAsjni/FYM+BcEI+n4/iB/5CIGASk6FCmP6cj/E9hXD+EgR+lAn9nDVxnDlF9o9FwKO3PK2OaA51vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=hCMeiDPf; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1721299988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V+1QsAqW2xA+qMzjOir7Wv2Xl2gPA1X/BCk3htAg/Zw=;
	b=hCMeiDPf1AmYQ4xI0ADfFBumTuV040UQDaZAuulhj39mAB4IVvS2/lypW/EBQUQgITjIBN
	olUGkYXNGmxCQFuAwPJ+b9D0A9eSslBWmH+ya8dYXXmR6ex4z3XCGcAqfUwmg783kDldYZ
	VnIXTFCdy2tJOYO93VFI10nsXEBNacGz1bJwiWuv2t5bTG8skPAbj5cq3HQUbv3EJo3+md
	vG7RAle5txFznmw0ez+c2rrn6LnXAHeSlpxXdcxGmm0Yt7alxasATIzZi93/3WZQOFKWVh
	QLvxBfyRbP7aBIfPscqJQd56Th1YAp6IjUucmf+iTKAKWC8kVcNdUlZHYCYCQA==
Date: Thu, 18 Jul 2024 12:53:07 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: Conor Dooley <conor@kernel.org>, mturquette@baylibre.com,
 sboyd@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 1/3] dt-bindings: clocks: add binding for
 voltage-controlled-oscillators
In-Reply-To: <3178118.zE8UqtGg2D@diego>
References: <20240715110251.261844-1-heiko@sntech.de>
 <20240715110251.261844-2-heiko@sntech.de>
 <20240716-deceiving-saucy-851fb2303c1f@spud> <3178118.zE8UqtGg2D@diego>
Message-ID: <c60c8c462c6df23c1f1625bce5516525@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello all,

On 2024-07-18 11:25, Heiko Stübner wrote:
> Am Dienstag, 16. Juli 2024, 18:15:08 CEST schrieb Conor Dooley:
>> On Mon, Jul 15, 2024 at 01:02:49PM +0200, Heiko Stuebner wrote:
>> > In contrast to fixed clocks that are described as ungateable, boards
>> > sometimes use additional oscillators for things like PCIe reference
>> > clocks, that need actual supplies to get enabled and enable-gpios to be
>> > toggled for them to work.
>> >
>> > This adds a binding for such oscillators that are not configurable
>> > themself, but need to handle supplies for them to work.
>> >
>> > In schematics they often can be seen as
>> >
>> >          ----------------
>> > Enable - | 100MHz,3.3V, | - VDD
>> >          |    3225      |
>> >    GND - |              | - OUT
>> >          ----------------
>> >
>> > or similar. The enable pin might be separate but can also just be tied
>> > to the vdd supply, hence it is optional in the binding.
>> >
>> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>> > ---
>> >  .../bindings/clock/voltage-oscillator.yaml    | 49 +++++++++++++++++++
>> >  1 file changed, 49 insertions(+)
>> >  create mode 100644 Documentation/devicetree/bindings/clock/voltage-oscillator.yaml
>> >
>> > diff --git a/Documentation/devicetree/bindings/clock/voltage-oscillator.yaml b/Documentation/devicetree/bindings/clock/voltage-oscillator.yaml
>> > new file mode 100644
>> > index 0000000000000..8bff6b0fd582e
>> > --- /dev/null
>> > +++ b/Documentation/devicetree/bindings/clock/voltage-oscillator.yaml
>> > @@ -0,0 +1,49 @@
>> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> > +%YAML 1.2
>> > +---
>> > +$id: http://devicetree.org/schemas/clock/voltage-oscillator.yaml#
>> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> > +
>> > +title: Voltage controlled oscillator
>> 
>> Voltage controlled oscillator? Really? That sounds far too similar to 
>> a
>> VCO to me, and the input voltage here (according to the description at
>> least) does not affect the frequency of oscillation.
> 
> That naming was suggested by Stephen in v1 [0] .
> 
> Of course the schematics for the board I have only describe it as
> "100MHz,3.3V,3225" , thumbing through some mouser parts matching that
> only mentions "supply voltage" in their datasheets but not a dependency
> between rate and voltage.
> 
> [0] 
> https://lore.kernel.org/linux-arm-kernel/b3c450a94bcb4ad0bc5b3c7ee8712cb8.sboyd@kernel.org/
> 
>> Why the dedicated binding, rather than adding a supply and enable-gpio
>> to the existing "fixed-clock" binding? I suspect that a large portion 
>> of
>> "fixed-clock"s actually require a supply that is (effectively)
>> always-on.
> 
> I guess there are three aspects:
> - I do remember discussions in the past about not extending generic
>   bindings with device-specific stuff. I think generic power-sequences
>   were the topic back then, though that might have changed over time?
> - There are places that describe "fixed-clock" as
>   "basic fixed-rate clock that cannot gate" [1]
> - Stephen also suggested a separate binding [2]
> 
> With the fixed-clock being sort of the root for everything else on most
> systems, I opted to leave it alone. I guess if the consenus really is 
> that
> this should go there, I can move it, but discussion in v1
> 
> Interestingly the fixed clock had a gpios property 10 years ago [3] :-) 
> .
> 
> [1] 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/clk/clk-fixed-rate.c#n18
> [2] 
> https://lore.kernel.org/linux-arm-kernel/68f6dc44a8202fd83792e58aea137632.sboyd@kernel.org/
> [3] 
> https://lore.kernel.org/linux-kernel//20140515064420.9521.47383@quantum/T/#t

After finally going through the v1 discussion [4] in detail,
here are my further thoughts:

- I agree with dropping the Diodes stuff, [5] because I see
   no need for that at this point;  though, am I missing
   something, where are they actually used?

- I agree that "enable-gpios" and "vdd-supply" should be
   required in the binding, [5] because that's the basis for
   something to be actually represented this way

- I agree that it should be better not to touch fixed-clock
   at this point, simply because it's used in very many places,
   and because in this case we need more than it requires (see
   the bullet point above)

- As I wrote already, [6] I highly disagree with this being
   called voltage-controlled oscillator (VCO), [7] simply
   because it isn't a VCO, but a clock that can be gated;
   though, looking forward to what the last bullet point
   asks to be clarified further

- I still think that gated-clock is the best choice for the
   name, because it uses "clock" that's used throughout the
   entire codebase, and uses "gated" to reflect the nature
   of the clock generator

- Maybe we could actually use fixed-gated-clock as the name,
   which would make more sense from the stanpoint of possibly
   merging it into fixed-clock at some point, but I'd like
   to hear first what's actually going on with the Diodes
   stuff that was deleted in v2, which I already asked about
   in the first bullet point

[4] 
https://lore.kernel.org/linux-rockchip/20240709123121.1452394-1-heiko@sntech.de/T/#u
[5] 
https://lore.kernel.org/linux-rockchip/2e5852b9e94b9a8d0261ce7ad79f4329.sboyd@kernel.org/
[6] 
https://lore.kernel.org/linux-rockchip/ec84dc37e2c421ee6d31294e08392d57@manjaro.org/
[7] 
https://lore.kernel.org/linux-rockchip/b3c450a94bcb4ad0bc5b3c7ee8712cb8.sboyd@kernel.org/

>> > +
>> > +maintainers:
>> > +  - Heiko Stuebner <heiko@sntech.de>
>> > +
>> > +properties:
>> > +  compatible:
>> > +    const: voltage-oscillator
>> > +
>> > +  "#clock-cells":
>> > +    const: 0
>> > +
>> > +  clock-frequency: true
>> > +
>> > +  clock-output-names:
>> > +    maxItems: 1
>> > +
>> > +  enable-gpios:
>> > +    description:
>> > +      Contains a single GPIO specifier for the GPIO that enables and disables
>> > +      the oscillator.
>> > +    maxItems: 1
>> > +
>> > +  vdd-supply:
>> > +    description: handle of the regulator that provides the supply voltage
>> > +
>> > +required:
>> > +  - compatible
>> > +  - "#clock-cells"
>> > +  - clock-frequency
>> > +  - vdd-supply
>> > +
>> > +additionalProperties: false
>> > +
>> > +examples:
>> > +  - |
>> > +    voltage-oscillator {
>> > +      compatible = "voltage-oscillator";
>> > +      #clock-cells = <0>;
>> > +      clock-frequency = <1000000000>;
>> > +      vdd-supply = <&reg_vdd>;
>> > +    };
>> > +...

