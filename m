Return-Path: <linux-kernel+bounces-563073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57449A636B0
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 18:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B09B188FAA9
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 17:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9201D79B3;
	Sun, 16 Mar 2025 17:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKO6/R2i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1021F1993B1;
	Sun, 16 Mar 2025 17:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742145105; cv=none; b=bgLoCPIDjKLLmvKxjRJqkUuhKr/EfQ6QN8T+HkPjwcLZA5VVljdBBjFwywEUYXOra0yRuR3+fC9A0njPFjNZPKm1ghjHcYsthEzRLVOp0KH6FTj+GjxM21m2HbFumU6WKDNe4C91i5Lv3LXnIh8AKRz3Q5A1etYB20Pu1cqIMP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742145105; c=relaxed/simple;
	bh=pBOXP9pYA3O6uFYcjDfSczaFkD/coBq7CLtlKYidPVw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oFWV0pdm6mxACrFBFVeuIkigiR/Z6VIHEDUcIpY87ZJi+gq+/pnhc97VZSwTm0HJYILZLGnKEREi/70ks5FP/htB2Nr3lk/luS4+k0WPmoRXdnBouttXrvXbji2//0XHHpE57LXuGLu+5enKe8Hb49L3p+2wejK1Z6nTyvdxBO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DKO6/R2i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2BEFC4CEDD;
	Sun, 16 Mar 2025 17:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742145104;
	bh=pBOXP9pYA3O6uFYcjDfSczaFkD/coBq7CLtlKYidPVw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DKO6/R2i+0uPxfrE0bC5bWtqlyhxbR8CXmymQuqkE792tEoYsvT3/txKv4yDFS+l2
	 qRoFSq5lxjfo2IVYtnfAh3l14MlZyzt01ezdsPYdsSB/dStA3PhtkiWZVHJT1iPlqr
	 fYWe/uM2E535lbqeyUSgaYPpCcg1YvK4affPjQWk23NBVc9fBfNAPdWGYnoKedzXYu
	 TQ9d2n19bhYsXsyZOA76xs7eIQLr6cFb38RtAL+V6f8qKeacwwx031y51H7n1sXyCd
	 OjXLawhoLJZrORq4wADwhuCu9OMLmQgIcMTB9ei5uoeUK15A6+ccy/8j2yhB2wO118
	 nysbjCSnqAB2w==
Message-ID: <2a5e25ad-92a6-4e25-a2b7-198b3ad84d2f@kernel.org>
Date: Sun, 16 Mar 2025 18:11:31 +0100
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
 <026296c8-a460-43ca-a423-0fa38269fbc2@kernel.org>
 <67d08a4f.7b0a0220.8fe9e.44fd@mx.google.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <67d08a4f.7b0a0220.8fe9e.44fd@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/03/2025 20:09, Christian Marangi wrote:
>>
>> This does not explain that binding said "This node defines the System
>> Control Unit".
>>
>> So what are you adding here if not SCU?
>>
> 
> With "This node defines the System Control Unit" I mean, the entire
> register space of the IP block is defined and each child specifically
> define each part of the IP block.

And the binding said - "this is the SCU". Now you claim that the binding
which said "this is the SCU" is not the SCU but a part of it.


> 
>>>
>>> The driver solution for this is syscon and the simple-mfd node
>>> structure.
>>
>> Let's keep driver entirely separate, we don't talk about them and mixing
>> arguments won't make it easier.
>>
> 
> Ok.
> 
>>>
>>> Now the main problem is how to modle this in DT. There are lots of case
>>> where the simple-mfd model is used (like the one proposed) but probably
>>> this is not accepted anymore. But again this should be clearly stated or
>>> we have a chicken-egg problem when other devs implement similar thing and
>>> have to implement simple MFD driver to handle this. (and driver
>>> maintainers say "Use the simple-mfd model like it was already done)
>>
>> simple-mfd has nothing to do here. Describe the hardware - what is the SCU?
>>
>>
> 
> As I said below, SCU is just the name used in Airoha Documentation for
> this IP block. In this register space there are multiple things so it's
> not strictly a clock-controller (as it's currently defined)
> 
> It was proposed as clock-controller previously as we weren't aware this
> IP block was used also for other usage that a strict clock controller.


I am pretty sure everyone was, just drivers were developed for current
needs and then binding was adjusted to match drivers.

> 
>>>
>>> For this specific case (and to give an answer to the clock patch after
>>> this) the problem is that this register space was originally used only
>>> to control the clock and I wasn't aware that it was also used to control
>>> USB. Now that I'm implementing support for it, the disaster happened.
>>>
>>> So In short SCU is lots of thing, both a system-controller, a
>>> clock-controller and even a reset-controller.
>>
>> And you have bindings for that already. Done.
>>
> 
> It's currently defined in DTS as clock-controller, should we change it
> to system-controller to make it more clear?

It does not matter for this discussion about bindings, it is just a
name. You can rename it, sure, although also a bit of a churn since this
device has a "clock controller" as one of its main features. And "system
controller" is also way generic.

BTW, it is frequent (e.g. all Qcom platforms, many Allwiner and
Mediatek) that clock controller is also reset or power domain controllers.


> 
>>>
>>> To make it short, 2 different solution:
>>> 1. We can keep the current node structure of the node-controller and add a
>>> child node for the SSR part (with a dedicated compatible).
>>
>> No, you do not add child nodes just because you want some drivers.
>>
>> What is SSR? How is it a device?
> 
> SSR is the name used in Documentation for the register used to configure
> the Serdes and PCIe port.

Register(s) for configuring something is not a device.

> 
>>
>>> 2. Those property need to be be defined in the clock-controller node?
>>
>> In the SCU node. Do you have only one SCU or more?
> 
> Strictly speaking it's one register space. One clock-controller, one
> reset-controller and one set of SSR registers, and from what I can
> understand it's ALWAYS "One device/compatible for Register space"

No, it's not the reason. You define children if they are distinctive. By
distinction I mean some sort of controllable resources which they need
independently of parent. No resources here, except address space, which
seems superficial choice.



> 
> The simple-mfd pattern can't really work for case like this where in one
> register space there are multiple stuff.

We agreed not to talk about simple-mfd, but answering this: yes, but
because your split is neither necessary nor really accurate.

> 
> Is everything clear now?
> 
> To summarize:
> - no child nodes
> - add additional property for SSR in the SCU .yaml

Yes.

Unless I made mistake here in the judgement, but that will be easier to
spot after seeing entire binding/DTS for this device.

Best regards,
Krzysztof

