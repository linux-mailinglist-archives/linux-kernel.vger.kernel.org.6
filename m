Return-Path: <linux-kernel+bounces-513664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1BAA34D3E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 19:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0E543AA56C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 18:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8579B245AE6;
	Thu, 13 Feb 2025 18:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TMalfmVP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93952241693;
	Thu, 13 Feb 2025 18:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739470083; cv=none; b=WEsxWaFltSjeHPtg13/dx2pn3bxw9pGNPjezhvNszPkdCpONgjK8gRffewb7+Onq3AQYvNpz04pcMwxFVD6cfDt+iD5i1puoAhenjBprUgNb+4IOupYLlKkSAZUZGp896h1le8BTce0CT7YDXhiXtJCapn8rC7OUpAgP6+86L9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739470083; c=relaxed/simple;
	bh=7tg0eIMwaCCfvANdT4CCgQtB9sEZfYm55QeTSa/g4gs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bqo7WO81JfJ296v+pqmOEITvc/8rVIj9/tpYTJfjWrV2tD/feGl6BldvtymX2SDgfNdcHOXWuZn9/z1tmtpV5ZBr2B2sUVye5CsvJ5SSVxJKg5d6SPo1iLPeWVVJ2RqTgmZCmfk0WXIOn1ROATYT070GNvnXy+VCkzhmhcy/HXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TMalfmVP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72785C4CED1;
	Thu, 13 Feb 2025 18:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739470083;
	bh=7tg0eIMwaCCfvANdT4CCgQtB9sEZfYm55QeTSa/g4gs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TMalfmVPn8HL9xhS+oBHp05v2YTYoOBItw5mtGnZbBSAJvx0roBVXPsdyfUVpwTlj
	 y1QM5JhkXc+jdzzzqS34ODn16yAJS3YKA4S4cc1BUkY02IR/0l3TLCRgzxSqhtZcjf
	 n5X0StaEtW/+LVYfwEgKFz4HqNoJQ/gRtY3osVdoOE7E1L5+PLoVtsK4GWtlmu92Eb
	 fCRW1v0pt/K16fubpR6MZUJhrltRniIUJDl//O4b7XHyzaLbaCGkOvB4e3qFP3qz83
	 LpESj5d9vCIFTDkpakncFoFR4y07DpnUjj7xzWm2tTVc9jqJuODWDpQclg+TK5SJji
	 u/mtD2OUP5vFw==
Message-ID: <2ab715bd-e26c-41bb-ac64-baa864d90414@kernel.org>
Date: Thu, 13 Feb 2025 19:07:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] dt-bindings: soc: spacemit: Add spacemit,k1-syscon
To: Haylen Chu <heylenay@4d2.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Haylen Chu <heylenay@outlook.com>,
 Yixun Lan <dlan@gentoo.org>, linux-riscv@lists.infradead.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Inochi Amaoto <inochiama@outlook.com>,
 Chen Wang <unicornxdotw@foxmail.com>, Jisheng Zhang <jszhang@kernel.org>,
 Meng Zhang <zhangmeng.kevin@linux.spacemit.com>
References: <20250103215636.19967-2-heylenay@4d2.org>
 <20250103215636.19967-4-heylenay@4d2.org>
 <aw2vqnz5vcccqqvrrhz5tgawj7fnzzg3tds7nnepuorit37a7r@jcj3wrs7d73h>
 <Z6rdBhQ7s2ReOgBL@ketchup> <19e5129b-8423-4660-8e4f-8b898214d275@kernel.org>
 <Z63T_EDvXiuRQbvb@ketchup>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <Z63T_EDvXiuRQbvb@ketchup>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/02/2025 12:14, Haylen Chu wrote:
> On Tue, Feb 11, 2025 at 09:03:20AM +0100, Krzysztof Kozlowski wrote:
>> On 11/02/2025 06:15, Haylen Chu wrote:
>>> On Sat, Jan 04, 2025 at 11:07:58AM +0100, Krzysztof Kozlowski wrote:
>>>> On Fri, Jan 03, 2025 at 09:56:35PM +0000, Haylen Chu wrote:
>>>>> Add documentation to describe Spacemit K1 system controller registers.
>>>>>
>>>>> Signed-off-by: Haylen Chu <heylenay@4d2.org>
>>>>> ---
>>>>>  .../soc/spacemit/spacemit,k1-syscon.yaml      | 52 +++++++++++++++++++
>>>>>  1 file changed, 52 insertions(+)
>>>>>  create mode 100644 Documentation/devicetree/bindings/soc/spacemit/spacemit,k1-syscon.yaml
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/soc/spacemit/spacemit,k1-syscon.yaml b/Documentation/devicetree/bindings/soc/spacemit/spacemit,k1-syscon.yaml
>>>>> new file mode 100644
>>>>> index 000000000000..79c4a74ff30e
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/soc/spacemit/spacemit,k1-syscon.yaml
>>>>> @@ -0,0 +1,52 @@
>>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>>> +%YAML 1.2
>>>>> +---
>>>>> +$id: http://devicetree.org/schemas/soc/spacemit/spacemit,k1-syscon.yaml#
>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>> +
>>>>> +title: Spacemit K1 SoC System Controller
>>>>> +
>>>>> +maintainers:
>>>>> +  - Haylen Chu <heylenay@4d2.org>
>>>>> +
>>>>> +description:
>>>>> +  The Spacemit K1 SoC system controller provides access to shared register files
>>>>> +  for related SoC modules, such as clock controller and reset controller.
>>>>> +
>>>>> +properties:
>>>>> +  compatible:
>>>>> +    items:
>>>>> +      - enum:
>>>>> +          - spacemit,k1-apbc-syscon
>>>>> +          - spacemit,k1-apbs-syscon
>>>>> +          - spacemit,k1-apmu-syscon
>>>>> +          - spacemit,k1-mpmu-syscon
>>>>> +      - const: syscon
>>>>> +      - const: simple-mfd
>>>>> +
>>>>> +  reg:
>>>>> +    maxItems: 1
>>>>> +
>>>>> +  clock-controller:
>>>>> +    $ref: /schemas/clock/spacemit,k1-ccu.yaml#
>>>>> +    type: object
>>>>
>>>> So now we see the full picture and it leads to questions.
>>>>
>>>> 1. Why spacemit,k1-apbc-syscon with spacemit,k1-ccu-apmu child is a
>>>> correct combination?
>>>>
>>>> 2. Why having this split in the first place? Please confirm that clock
>>>> controller is really, really a separate device and its child in
>>>> datasheet. IOW, fake child for your Linux is a no-go. Fake child while
>>>> devices are independent is another no-go.
>>>
>>> These syscons are introduced because the clock controllers share
>>> registers with reset controllers. Folding them into the parents results
>>
>> So a fake split...
>>
>>> in devicetree nodes act as both reset and clock controllers, like what
>>
>> Which is correct hardware representation, isn't it?
>>
>>> has been done for Rockchip SoCs. Such folding isn't practical for the
>>> MPMU region either, since watchdog and other misc bits (e.g. PLL lock
>>> status) locates in it.
> 
> I have to correct that the watchdog doesn't stay in the MPMU region, I
> misremembered it.
> 
>> Hm? Why? You have a device which is reset and clock controller, so why
>> one device node is not practical? Other vendors do not have problem with
>> this.
> 
> Merging reset and clock controllers together is fine to me. What I want
> to mention is that APMU and MPMU, abbreviated from Application/Main Power
> Management Unit, contain not only clock/reset-related registers but also
> power management ones[1]. Additionally, the PLL lock status bits locate
> at MPMU, split from the PLL configuration registers as you've already
> seen in the binding of spacemit,k1-ccu-apbs where I refer to it with a
> phandle.

You need to define what is the device here. Don't create fake nodes just
for your drivers. If registers are interleaved and manual says "this is
block APMU/MPMU" then you have one device, so one node with 'reg'.

If subblocks are re-usable hardware (unlikely) or at least
separate/distinguishable, you could have children. If subblocks are
re-usable but addresses are interleaved, then children should not have
'reg'. If children do not have any resources as an effect, this is
strong indication these are not re-usable, separate subblocks.

> 
> Since reset/clock and power management registers interleave in the MMIO
> region, do you think syscons are acceptable in this situation or it
> should be handled in another way? The reset and clock controllers could
> still be folded together as they share the same registers. The device
> tree will look like,
> 
> 	syscon_mpmu: system-controller@d4050000 {
> 		compatible = "spacemit,mpmu-syscon", "syscon", "simple-mfd";
> 		reg = <0xd4050000 0x10000>;
> 
> 		cru_mpmu: clock-controller {
> 			compatible = "spacemit,k1-cru-mpmu";
> 			#clock-cells = <1>;
> 			#reset-cells = <1>;
> 		};
> 
> 		power_mpmu: power-controller {
> 			compatible = "spacemit,k1-powerdomain-mpmu";
> 			/* ... */
> 			#power-domain-cells = <0>;
> 		};

Based on above, I do not see any need for children device nodes. It's
fake split to match driver design.


> 	};
> 
> For the other two clock controllers (APBS and APBC), syscons are really
> unnecessary and it's simple to fold them.


I don't follow. Do we talk about children or syscon compatible?


Best regards,
Krzysztof

