Return-Path: <linux-kernel+bounces-254148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 523EE932F82
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 19:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB128B233D6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 17:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07901A01AF;
	Tue, 16 Jul 2024 17:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="MCv6+3Go"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126D319FA94;
	Tue, 16 Jul 2024 17:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721152453; cv=none; b=P11RfoGwQlhisRDGlRWyiMsTkZrfJDq1HLIUtOo928e6Uzzo7U6NMXw2+VI8NMNMdWLURIyKrc/w0ruaUJ7LtX6wZSsw80vyAnUYpkpeX+4C6GKlMm0DEOKx3gT2stH/9tPgK2yu/6LpgvJAaiu28XvmNCog2dWrZl9AMYcZHhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721152453; c=relaxed/simple;
	bh=sZu03ID5UMJ8RypXcCc2NY0wgrCM6q0VgH1kVnDW2Xo=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=FRTmEi9b7M0hTmC/OqLbQOj1huAWC0QSVDlHH7n9IsLaCzGQhJuytg6RSqcpZ7p6yJGdawL/HLVt4/2VBGGOcFPlLggUUtrACsBoxdqDVQTF+va4Gjot4clLCAh56k7AWJ+gRjBbfLeflLCYb5vnUZtQnqtSjm9UMq3toPIrv8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=MCv6+3Go; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1721152447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tBaze88xDn3yKiej0Z29otCCIlY/u1pmqzk/0G8E5gA=;
	b=MCv6+3Go0FkYuSBtkw+8oFM7vnjW1gqfaH4mN3AZ1ackrOJBnvWXFIoOpenZ5Irkc7SovC
	yBB7KXWrN/eddOK97aIGILJLwMJjdvRhRbcviO7J3WUqPwrh0EPesVR8w323Pt3OQDjqHG
	avdmnyGZDaG+CAfvjJr1bEeAxmNxsekrzx1rjUlWkJ8TRE/AX9Knet50IVNV+08A1FoSar
	BHg0SD/CUrnfmRLOACCJOcCqivkulAn0SzsuQCLx7iKH99315HcSUc89xz5EIb+nb4SMrG
	e/FQgOUpTuaOqHBPzuQzAszsOhdRGWvw2yypKT+TpDPxsQCrkhCpDYD4ejdlIw==
Date: Tue, 16 Jul 2024 19:54:07 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Conor Dooley <conor@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>, mturquette@baylibre.com,
 sboyd@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 1/3] dt-bindings: clocks: add binding for
 voltage-controlled-oscillators
In-Reply-To: <20240716-deceiving-saucy-851fb2303c1f@spud>
References: <20240715110251.261844-1-heiko@sntech.de>
 <20240715110251.261844-2-heiko@sntech.de>
 <20240716-deceiving-saucy-851fb2303c1f@spud>
Message-ID: <30e4a6cb0ad489fa30efbfef2d6005d7@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Conor,

On 2024-07-16 18:15, Conor Dooley wrote:
> On Mon, Jul 15, 2024 at 01:02:49PM +0200, Heiko Stuebner wrote:
>> In contrast to fixed clocks that are described as ungateable, boards
>> sometimes use additional oscillators for things like PCIe reference
>> clocks, that need actual supplies to get enabled and enable-gpios to 
>> be
>> toggled for them to work.
>> 
>> This adds a binding for such oscillators that are not configurable
>> themself, but need to handle supplies for them to work.
>> 
>> In schematics they often can be seen as
>> 
>>          ----------------
>> Enable - | 100MHz,3.3V, | - VDD
>>          |    3225      |
>>    GND - |              | - OUT
>>          ----------------
>> 
>> or similar. The enable pin might be separate but can also just be tied
>> to the vdd supply, hence it is optional in the binding.
>> 
>> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>> ---
>>  .../bindings/clock/voltage-oscillator.yaml    | 49 
>> +++++++++++++++++++
>>  1 file changed, 49 insertions(+)
>>  create mode 100644 
>> Documentation/devicetree/bindings/clock/voltage-oscillator.yaml
>> 
>> diff --git 
>> a/Documentation/devicetree/bindings/clock/voltage-oscillator.yaml 
>> b/Documentation/devicetree/bindings/clock/voltage-oscillator.yaml
>> new file mode 100644
>> index 0000000000000..8bff6b0fd582e
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/voltage-oscillator.yaml
>> @@ -0,0 +1,49 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/clock/voltage-oscillator.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Voltage controlled oscillator
> 
> Voltage controlled oscillator? Really? That sounds far too similar to a
> VCO to me, and the input voltage here (according to the description at
> least) does not affect the frequency of oscillation.

Yup, "voltage controlled oscillator" really isn't the right choice for
the name, as I wrote about already. [1]

[1] 
https://lore.kernel.org/linux-rockchip/ec84dc37e2c421ee6d31294e08392d57@manjaro.org/

> Why the dedicated binding, rather than adding a supply and enable-gpio
> to the existing "fixed-clock" binding? I suspect that a large portion 
> of
> "fixed-clock"s actually require a supply that is (effectively)
> always-on.
> 
>> +
>> +maintainers:
>> +  - Heiko Stuebner <heiko@sntech.de>
>> +
>> +properties:
>> +  compatible:
>> +    const: voltage-oscillator
>> +
>> +  "#clock-cells":
>> +    const: 0
>> +
>> +  clock-frequency: true
>> +
>> +  clock-output-names:
>> +    maxItems: 1
>> +
>> +  enable-gpios:
>> +    description:
>> +      Contains a single GPIO specifier for the GPIO that enables and 
>> disables
>> +      the oscillator.
>> +    maxItems: 1
>> +
>> +  vdd-supply:
>> +    description: handle of the regulator that provides the supply 
>> voltage
>> +
>> +required:
>> +  - compatible
>> +  - "#clock-cells"
>> +  - clock-frequency
>> +  - vdd-supply
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    voltage-oscillator {
>> +      compatible = "voltage-oscillator";
>> +      #clock-cells = <0>;
>> +      clock-frequency = <1000000000>;
>> +      vdd-supply = <&reg_vdd>;
>> +    };
>> +...
>> --
>> 2.39.2
>> 
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip

