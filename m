Return-Path: <linux-kernel+bounces-554096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F367AA592E6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 12:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 606AC7A23E1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 11:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB007221719;
	Mon, 10 Mar 2025 11:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bb1rVcHO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA9F21E092;
	Mon, 10 Mar 2025 11:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741606881; cv=none; b=nfO7m8IQRYBHOqsTaSkqrAjUQFTUfnyMNV/+ti2H3q//3oMqbqxXAUyoVvj6/vUeXlBfqvUtVpTsPbEOqsZVJdM0IIEZplfT5rA+2cFax8hvVzDpiWdWwzet+bPohagS1vRSfcY5h+yE/LY4gdvGfNLuw/R6bPjTQ1MwIBuzdFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741606881; c=relaxed/simple;
	bh=baohKrHUnm8F0gCGlhMlMZHHLAAXGDAnlAu9F2b27x0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JOAChOjVev1Z+t95tjSqTddfZKWyvwELrpvs6ElV0tqKQjIVOU3SsNwrjfXxh/ZP/f+XfgiSehe0lVQ3XSVu/bYKw90qcCJOLzh7PoS+zCrs1z7k6Yof0RFUUoUJ93t9OUefsJz4NMJydLO/8d0tFiCjhMlnjS6IBqcFv4h60Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bb1rVcHO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B986C4CEE5;
	Mon, 10 Mar 2025 11:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741606880;
	bh=baohKrHUnm8F0gCGlhMlMZHHLAAXGDAnlAu9F2b27x0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Bb1rVcHODTTepAe2xtV9cg9zhjo7Gtb/OcDWaMECFAMc2aU2bzCWklhW4EP1LEM4k
	 fHAFRnpxf/EImdd5ML0W3fZkubfXqUJOHGc9SJ2ve+HKdyEKdFKS79qOfE8X+KPoxP
	 zheGIkLwsrYx5pGIR3G3Eu31Ts1u2dbgGGwn8Oh1y28V99CexsPZW9NVEt0XC6pngk
	 z0kIXD5pFZd2Up8z14U5doOmKsuUeVxXjibhUnVGGb6ekcYBrFbeKnTdMHfgahfC2J
	 4++nwajOCndh9jhY9XmjDx9bYZaHPd/zH+/3+yPlS6IXvd0xK73hAmNIhvoX/jnBoA
	 iZxnW8rp0BSgg==
Message-ID: <026296c8-a460-43ca-a423-0fa38269fbc2@kernel.org>
Date: Mon, 10 Mar 2025 12:41:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/13] dt-bindings: mfd: add Documentation for Airoha
 EN7581 SCU
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Daniel Danzberger <dd@embedd.com>,
 Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>,
 Nikita Shubin <nikita.shubin@maquefel.me>, Guo Ren <guoren@kernel.org>,
 Yangyu Chen <cyy@cyyself.name>, Ben Hutchings <ben@decadent.org.uk>,
 Felix Fietkau <nbd@nbd.name>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-usb@vger.kernel.org,
 upstream@airoha.com
References: <20250309132959.19045-1-ansuelsmth@gmail.com>
 <20250309132959.19045-6-ansuelsmth@gmail.com>
 <c1227083-a4ea-4dac-a9db-d6a5386c0437@kernel.org>
 <67cec328.170a0220.27ecbc.9c6e@mx.google.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <67cec328.170a0220.27ecbc.9c6e@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/03/2025 11:47, Christian Marangi wrote:
> On Mon, Mar 10, 2025 at 10:21:45AM +0100, Krzysztof Kozlowski wrote:
>> On 09/03/2025 14:29, Christian Marangi wrote:
>>> Add Documentation for Airoha EN7581 SCU.
>>>
>>> Airoha EN7581 SoC expose registers to control miscellaneous pheriperals
>>> via the SCU (System Controller Unit).
>>>
>>> Example of these pheriperals are reset-controller, clock-controller,
>>> PCIe line speed controller and bits to configure different Serdes ports
>>> for USB or Ethernet usage.
>>>
>>> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
>>> ---
>>>  .../mfd/airoha,en7581-scu-sysctl.yaml         | 68 +++++++++++++++++++
>>>  1 file changed, 68 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/mfd/airoha,en7581-scu-sysctl.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/mfd/airoha,en7581-scu-sysctl.yaml b/Documentation/devicetree/bindings/mfd/airoha,en7581-scu-sysctl.yaml
>>> new file mode 100644
>>> index 000000000000..d7dc66f912c1
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/mfd/airoha,en7581-scu-sysctl.yaml
>>> @@ -0,0 +1,68 @@
>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/mfd/airoha,en7581-scu-sysctl.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Airoha EN7581 SCU (System Controller Unit)
>>> +
>>> +maintainers:
>>> +  - Christian Marangi <ansuelsmth@gmail.com>
>>> +
>>> +description:
>>> +  Airoha EN7581 SoC expose registers to control miscellaneous
>>> +  pheriperals via the SCU (System Controller Unit).
>>> +
>> One more comment - there is no such thing as "sysctl" in your hardware.
>> Look at the SCU binding which clearly says that it is the hardware you
>> are duplicating here, so the "System Control Unit".
>>
>> So you have existing "This node defines the System Control Unit of the
>> EN7523 SoC" and you add one more node which defines the "System Control
>> Unit", so you have two "System Control Unit" device nodes?
>>
>> Look also what Stephen asked for:
>>
>> https://lore.kernel.org/all/20220106013100.842FCC36AEB@smtp.kernel.org/
>>
>> so how system-controller can now became clock-controller? Now, it was
>> the system controller since the beginning.
>>
> 
> The main problem here (and we had a similar problem with GPIO and PWM)
> is that the Vendor (Airoha) wasn't so bright in placing the different
> registers for the SoC so we have case where everything is mixed and not
> one after another... 
> 
> Example we have 
> - CLK register part 1
> - Some bits that configure PCIe
> - CLK register part 2
> - GPIO
> - CLK register part 3
> - ...

This does not explain that binding said "This node defines the System
Control Unit".

So what are you adding here if not SCU?

> 
> The driver solution for this is syscon and the simple-mfd node
> structure.

Let's keep driver entirely separate, we don't talk about them and mixing
arguments won't make it easier.

> 
> Now the main problem is how to modle this in DT. There are lots of case
> where the simple-mfd model is used (like the one proposed) but probably
> this is not accepted anymore. But again this should be clearly stated or
> we have a chicken-egg problem when other devs implement similar thing and
> have to implement simple MFD driver to handle this. (and driver
> maintainers say "Use the simple-mfd model like it was already done)

simple-mfd has nothing to do here. Describe the hardware - what is the SCU?


> 
> For this specific case (and to give an answer to the clock patch after
> this) the problem is that this register space was originally used only
> to control the clock and I wasn't aware that it was also used to control
> USB. Now that I'm implementing support for it, the disaster happened.
> 
> So In short SCU is lots of thing, both a system-controller, a
> clock-controller and even a reset-controller.

And you have bindings for that already. Done.

> 
> To make it short, 2 different solution:
> 1. We can keep the current node structure of the node-controller and add a
> child node for the SSR part (with a dedicated compatible).

No, you do not add child nodes just because you want some drivers.

What is SSR? How is it a device?

> 2. Those property need to be be defined in the clock-controller node?

In the SCU node. Do you have only one SCU or more?

> 
> The ideal solution is 1. Does it work for you?
> 
> Sorry for the long post and hope you understand why this mess of
> reworking the binding.
> 


Best regards,
Krzysztof

