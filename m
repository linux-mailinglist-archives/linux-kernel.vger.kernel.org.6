Return-Path: <linux-kernel+bounces-252924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1D39319F0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 20:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B2891C21CB6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 18:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A925589A;
	Mon, 15 Jul 2024 18:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="UbThJeP6"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894E373446;
	Mon, 15 Jul 2024 18:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721066502; cv=none; b=MahowsCBu7R1DWSG5jvAADPMOVrEttUylG6FffrSma1ukqwjbt0JdTsIUUK9BC5vGPLF4B/uQQibFP8dJ/GkAWf9ZuF2XutpzV7+6ZHosktHrOjqt3Vw579FqCTjipPMzDtd9l+H/TLxcJfVCMyvll/BD853eCurA7UMNTMwpA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721066502; c=relaxed/simple;
	bh=2y6Jp1rPf53DtC9wIknG4Z2HVl5H2BvZkwIS+gTvprI=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=h1/RtQTzwXJ9waNzPWoMr2Z8eQju19RbTAGMB/HP8spPWbv1PQgDubdmTlyM/XQi23Ff9urhVGuJF5zN2xZrIFSD+9Txy8+1VlQ85SEJdXNziy2rPtFGRSjGOdjwG+okfDYOoq22R0jzFuYtQ63un2IcPXWQfQreoHr2z/0Yvas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=UbThJeP6; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1721066495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yeO8aJl/IzUQi8xRcxq4p918nJT45vn5xNQbkPy3aAY=;
	b=UbThJeP6VidW1MFNuqSAV0zqSYP2j81Zj8faTffFzPVYMWh92MH0YsqWXggiXNaovhU7Ck
	8XNRTUywPPp6shDoExSB/o0OYowSbwYCu0laFqHnnnhcgTDEg3ZjVKlmxRPkGcrcrlNMQA
	ejnu8WA2fp5ZAorGvARIqlKiKNya1oqsRYeHSEo3xBGSTqPif22YWr8GrDug2MCMOTJCgf
	zlhtLEP7ylC7HdCofQntvYqSn6WYHT6svy1DZEs/GSo3xJa570SPrn7FclnS7fc2BdZIrB
	BSZ6SLJB8FIk/3EZVOGMN0q55vEnWc0MAzUGSkGZ+R6HrkIRDF00xv/lwRUHCA==
Date: Mon, 15 Jul 2024 20:01:35 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 1/3] dt-bindings: clocks: add binding for
 voltage-controlled-oscillators
In-Reply-To: <2832997.XrmoMso0CX@diego>
References: <20240715110251.261844-1-heiko@sntech.de>
 <20240715110251.261844-2-heiko@sntech.de>
 <ec84dc37e2c421ee6d31294e08392d57@manjaro.org> <2832997.XrmoMso0CX@diego>
Message-ID: <3f0c241d39c5fedb674d7f9808d0be8f@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-07-15 19:46, Heiko Stübner wrote:
> Am Montag, 15. Juli 2024, 17:15:45 CEST schrieb Dragan Simic:
>> On 2024-07-15 13:02, Heiko Stuebner wrote:
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
>> >  create mode 100644
>> > Documentation/devicetree/bindings/clock/voltage-oscillator.yaml
>> >
>> > diff --git
>> > a/Documentation/devicetree/bindings/clock/voltage-oscillator.yaml
>> > b/Documentation/devicetree/bindings/clock/voltage-oscillator.yaml
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
>> Frankly, I find the "voltage-oscillator" and "voltage controlled
>> oscillator" names awkward.  In general, "clock" is used throughout
>> the entire kernel, when it comes to naming files and defining
>> "compatible" strings.  Thus, I'd suggest that "clock" is used here
>> instead of "oscillator", because it's consistent and shorter.
>> 
>> How about using "gated-clock" for the "compatible" string, and
>> "Simple gated clock generator" instead of "voltage controlled
>> oscillator"?  Besides sounding awkward, "voltage controlled
>> oscillator" may suggest that the clock generator can be adjusted
>> or programmed somehow by applying the voltage, while it can only
>> be enabled or disabled that way, which is by definition clock
>> gating.  Thus, "gated-clock" and "Simple gated clock generator"
>> would fit very well.
> 
> The naming came from Stephen - one of the clock maintainers ;-)
> See discussion in v1. Who also described these things as
> "voltage-controlled-oscillators".
> 
> And from that discussion I also got the impression we should aim for
> more specific naming - especially when talking about dt-bindings, for 
> this
> "usage in the Linux kernel" actually isn't a suitable metric and
> "gated-clock" is probably way too generic I think.

I see, thanks for the clarification.  Though, the generic nature of
"gated-clock" as the name may actually make this driver a bit more
future-proof, by allowing some other features to be added to it at
some point in the future, avoiding that way the need for yet another
kernel driver.

> Though I'm not attached to any specific naming, so we'll simply
> wait for the clock- and dt-maintainers to weigh in ;-)

