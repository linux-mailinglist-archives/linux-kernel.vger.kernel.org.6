Return-Path: <linux-kernel+bounces-269587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E82394348B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 18:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A650285196
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 16:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9D51BD4E4;
	Wed, 31 Jul 2024 16:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dQCYv/UR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D99E1BD028;
	Wed, 31 Jul 2024 16:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722445052; cv=none; b=m2ONnnB5Kz+Ka0EcBWlXoJbKZ8wzEctZwPkr+u/iK7KByVm1TpgVW7OQQO07yc0vlXmhEo/bpwISUpdzV+sEmEHt5tEWKdWXTqEix8RvgcpreyqfAG+82B+ufYyAvrWddy2WKyds5N5lxH6VkdFKyg25brZ8J8r75JwRZjdkW7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722445052; c=relaxed/simple;
	bh=4JVBq4IUjQWBxC57gsXSdirCzZujW6Prh3HsrVDqnDg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=idgUfgap61oM/Dxqx7miENKypaEfHGPn4DaF5m76TMh9h2zdNoiKSWKhZ1pSWSQwvFJ4QsR3tWdMiLOKojyQ1tqaIGW9Urn0Om7VzrTHGnjAFs5bRDKETy9ftdkSQFjweBsxwCnwoU6rjTEka3clZjerPt4BNGjp3yUW3SxS0rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dQCYv/UR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9595CC4AF09;
	Wed, 31 Jul 2024 16:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722445052;
	bh=4JVBq4IUjQWBxC57gsXSdirCzZujW6Prh3HsrVDqnDg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dQCYv/UR9h2ihREXVp5qom4r5BCP8S1RW6MYZCzHEPSiqUgHp21oFv9Ml7DyHT2ts
	 Ewo0wM4nyFrKXgLnY08912FnuMwsE+Kc4NA/xcsA5S/DoVM2OAitq7gya8qTHaaCiH
	 aajsvHWZ9a+Wvs6KpTBjPB2Ht6M8UrESYIaX6FrSco0N+Q9gRx1ffjVJ7XoIxbQsJK
	 8eT/Ah/rJmqS6Vi3gKxS7JySozjmZR6RoCTvBWi0Vy5T3AhhmG2rM3L8ME4kUMillK
	 iD3pWXR4X5nh/UyL+Q7bTb05QotFajNk6kY3slgMxj79P3fktt2h0UAuwOObEpxCwh
	 ajhpUvlGCUWRA==
Message-ID: <f032dd83-8e5d-4062-b8a7-ef98924ac9b4@kernel.org>
Date: Wed, 31 Jul 2024 18:57:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 36/37] kvx: dts: DeviceTree for qemu emulated
 Coolidge SoC
To: Yann Sionneau <ysionneau@kalrayinc.com>, linux-kernel@vger.kernel.org,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Jonathan Borne <jborne@kalrayinc.com>,
 Julian Vetter <jvetter@kalrayinc.com>, devicetree@vger.kernel.org
References: <20240722094226.21602-1-ysionneau@kalrayinc.com>
 <20240722094226.21602-37-ysionneau@kalrayinc.com>
 <d93f93fa-bbc8-4b89-9abc-767486bc443c@kernel.org>
 <434c5199-613e-4765-af44-d7404a4554dc@kalrayinc.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <434c5199-613e-4765-af44-d7404a4554dc@kalrayinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 31/07/2024 17:38, Yann Sionneau wrote:

>>
>>> +	#size-cells = <0x02>;
>>> +
>>> +	chosen {
>>> +		stdout-path = "/axi/serial@20210000";
>> No, use phandle/label.
> Ack, I will fix this. However can you point me to where this is documented? In https://www.kernel.org/doc/Documentation/devicetree/bindings/chosen.txt I can see a path is used as example and not a phandle/label.

That's just sanity and common (maybe except Tegra) style... Almost every
source uses this, because it gives you code which is independent of node
ordering, node names and unit addresses.

What if I change in next patch axi->soc, how usually we code it?

Override by label/phandle was mentioned many times on mailing lists as
preferred.

>>
>>> +	};
>>> +
>>> +	memory@100000000 {
>>> +		phandle = <0x40>;
>>> +		reg = <0x01 0x00 0x00 0x8000000>;
>>> +		device_type = "memory";
>>> +	};
>>> +
>>> +	axi {
>>> +		compatible = "simple-bus";
>>> +		#address-cells = <0x02>;
>> Same problem.
> Ack.
>>
>>
>>> +		#size-cells = <0x02>;
>>> +		ranges;
>>> +
>>> +		virtio-mmio@30003c00 {
>> Node names should be generic. See also an explanation and list of
>> examples (not exhaustive) in DT specification:
>> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
> 
> I fail to understand what I should put even after reading the link above. This node is kind of "generic" and could be used either for a virtio-block device or a virtio-net device.
> 
> Could you elaborate on this please?

Just go with virtio.

> 
>>
>>
>>> +			compatible = "virtio,mmio";
>>> +			reg = <0x00 0x30003c00 0x00 0x200>;
>>> +			interrupt-parent = <&itgen0>;
>>> +			interrupts = <0x9e 0x04>;
>>> +		};
>>> +
>>> +		virtio-mmio@30003e00 {
>>> +			compatible = "virtio,mmio";
>>> +			reg = <0x00 0x30003e00 0x00 0x200>;
>>> +			interrupt-parent = <&itgen0>;
>>> +			interrupts = <0x9f 0x04>;
>>> +		};
>>> +
>>> +		itgen0: itgen_soc_periph0@27000000 {
>> Please follow DTS coding style.
> Oops, ack, I will fix this and replace "_" with "-" in node/property names.
>>
>>> +			compatible = "kalray,coolidge-itgen";
>>> +			reg = <0x00 0x27000000 0x00 0x1104>;
>>> +			msi-parent = <&apic_mailbox>;
>>> +			#interrupt-cells = <0x02>;
>>> +			interrupt-controller;
>>> +		};
>>> +
>>> +		serial@20210000 {
>>> +			reg-shift = <0x02>;
>>> +			reg-io-width = <0x04>;
>> Sorry, but width and shift are rarely hex values. Make your code
>> readable. Adhere to existing coding style.
> Ack, I will fix this.
>>
>>
>>> +			clocks = <&ref_clk>;
>>> +			interrupts = <0x29 0x04>;
>>> +			interrupt-parent = <&itgen0>;
>>> +			reg = <0x00 0x20210000 0x00 0x100>;
>>> +			compatible = "snps,dw-apb-uart";
>> Follow DTS coding style - order the properties correctly.
> Oops, ack, I will fix this.
>>
>>
>>> +		};
>>> +
>>> +		serial@20211000 {
>>> +			reg-shift = <0x02>;
>>> +			reg-io-width = <0x04>;
>>> +			phandle = <0x3c>;
>>> +			clocks = <&ref_clk>;
>>> +			interrupts = <0x2a 0x04>;
>>> +			interrupt-parent = <&itgen0>;
>>> +			reg = <0x00 0x20211000 0x00 0x100>;
>>> +			compatible = "snps,dw-apb-uart";
>>> +		};
>>> +
>>> +		serial@20212000 {
>>> +			reg-shift = <0x02>;
>>> +			reg-io-width = <0x04>;
>>> +			phandle = <0x3b>;
>>> +			clocks = <&ref_clk>;
>>> +			interrupts = <0x2b 0x04>;
>>> +			interrupt-parent = <&itgen0>;
>>> +			reg = <0x00 0x20212000 0x00 0x100>;
>>> +			compatible = "snps,dw-apb-uart";
>>> +		};
>>> +
>>> +		serial@20213000 {
>>> +			reg-shift = <0x02>;
>>> +			reg-io-width = <0x04>;
>>> +			phandle = <0x3a>;
>>> +			clocks = <&ref_clk>;
>>> +			interrupts = <0x2c 0x04>;
>>> +			interrupt-parent = <&itgen0>;
>>> +			reg = <0x00 0x20213000 0x00 0x100>;
>>> +			compatible = "snps,dw-apb-uart";
>>> +		};
>>> +
>>> +		serial@20214000 {
>>> +			reg-shift = <0x02>;
>>> +			reg-io-width = <0x04>;
>>> +			phandle = <0x39>;
>>> +			clocks = <&ref_clk>;
>>> +			interrupts = <0x2d 0x04>;
>>> +			interrupt-parent = <&itgen0>;
>>> +			reg = <0x00 0x20214000 0x00 0x100>;
>>> +			compatible = "snps,dw-apb-uart";
>>> +		};
>>> +
>>> +		serial@20215000 {
>>> +			reg-shift = <0x02>;
>>> +			reg-io-width = <0x04>;
>>> +			phandle = <0x38>;
>>> +			clocks = <&ref_clk>;
>>> +			interrupts = <0x2e 0x04>;
>>> +			interrupt-parent = <&itgen0>;
>>> +			reg = <0x00 0x20215000 0x00 0x100>;
>>> +			compatible = "snps,dw-apb-uart";
>>> +		};
>>> +	};
>>> +
>>> +	memory@0 {
>> Why memory is in multiple places?
> I should put all memory nodes one after another? Ok I will do this.
>>
>>> +		device_type = "memory";
>>> +		reg = <0x00 0x00 0x00 0x400000>;
>>> +	};
>>> +
>>> +	apic_mailbox: apic_mailbox@a00000 {
>> Why this is outside of SoC? Where is the SoC anyway?
> 
> Oops, I didn't know it was mandatory to put a soc { } in the DT, I've browsed the DT spec and the "soc" node is not formally described as something special. Maybe this needs to be documented somewhere?
> 
> I reckon it's a nice way to separate what's on the board (PCB) and what's in the SoC.
> 
> I'll add a `soc { [...] };` in the next patch iteration that will contain what's in the SoC.

Coding style, emails, all new DTS since some years or talks on numerous
conferences... All this code looks like you took some vendor downstream
code and sent it. That's not how it works. You take recent, reviewed DTS
and use it as template. Qualcomm sm8650 or x1e8010 are good examples.

> 
>>
>>> +		compatible = "kalray,coolidge-apic-mailbox";
>> Your compatibles are confusing. What is the soc name? In other binding
>> you entirely omitted coolidge. See writing bindings (or any other recent
>> DTS which passed review) - it has rationale behind it.
> 
> SoC name is "Coolidge" and the "APIC Mailbox" hw is in the SoC, it is memory mapped.
> 
> But I guess this point is now already more clear since my last emails answering the "core intc" reviews.
> 
>>


Best regards,
Krzysztof


