Return-Path: <linux-kernel+bounces-383109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A70C9B176D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 13:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDCFA1F226B6
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 11:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2526A1D363D;
	Sat, 26 Oct 2024 11:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B55TDTMI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703FC1D3566;
	Sat, 26 Oct 2024 11:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729942017; cv=none; b=f9gdK9eHeg3rK5aLfHZnGvHofz959GGLbHNADaMUwL6ly4U4gn3EtfGD/YLJu7WmaTMnNuFfNZn562D5BcE7KDrdFzfGdKI7jLKPuosbacEDGxj96SJtucTB1yRZvVQgcI3B7oPdvlSWtaEiaqE+8C1a0iOGZ/qjZqryXpWXy3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729942017; c=relaxed/simple;
	bh=1aijchob2546XDzQr/sSoRHna2pm5upAiZBnO2Eq28k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GLJRIfYfKsyEER7oO+lBYPzfQrCjlBogF9tNd8qfcUmqlhtB2XsDHDeauFWakU6B43X8as7kvMP3OyMydcNGWgF9ezfAbAzKUwDTtbvGjz2lXOQIW1ybgge5ePMG6TfdThvnvYicxBt6CTnohkmHwua/HIkypcNVF1Z4A43sSXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B55TDTMI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6BB6C4CEC7;
	Sat, 26 Oct 2024 11:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729942017;
	bh=1aijchob2546XDzQr/sSoRHna2pm5upAiZBnO2Eq28k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=B55TDTMI/fKu5yUYgMltxk7cjFbChSOaSGJG45SZTU2N/Y0KccuxjFlPUdpFZsV20
	 /LjZ4pHdYznMgq/jx8M5/miAiKRooGWC514laJKhbXHzxIgjEBZpXlClDR3nIFzJZA
	 D82noSdJkzUTvCiX2N3WRAVguFaHrXhgIqiGq2wYxMvuZvV/XDuqcWjwcD0LR018gC
	 aB0QzSe34yg5jnSZP+2UyZPTlRQosjwAc/CNGjsduv4nMaXbv9pnDvEuM3QlYvOv9t
	 ZTMut3xdeY8bdyLcpvCOfZ2PKbyWA+ixXzFjDX/c8ukKn47llO2RuwyeNpFI6p1Kvu
	 DVjJyhbsvFQeQ==
Message-ID: <2d5f9959-17c9-4e61-a6df-ebd187f422e6@kernel.org>
Date: Sat, 26 Oct 2024 13:26:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: soc: bcm: Convert
 raspberrypi,bcm2835-power to Dt schema
To: Karan Sanghavi <karansanghvi98@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, devicetree@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>,
 Alexander Aring <alex.aring@gmail.com>, Eric Anholt <eric@anholt.net>
References: <20241022-raspberrypi-bcm2835-power-v2-1-1a4a8a8a5737@gmail.com>
 <lfzxcilud65ype66frb7eihq2hvranzxp6fomjvjyxvciiixlj@2efv5266wt5r>
 <zaqykppssizdpd2mynpoatp4smbzkr7atuurxkkegbegk5dw6s@a2daqovt2aod>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <zaqykppssizdpd2mynpoatp4smbzkr7atuurxkkegbegk5dw6s@a2daqovt2aod>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/10/2024 20:22, Karan Sanghavi wrote:
>>> +
>>> +examples:
>>> +  - |
>>> +    power: power {
>>
>> Drop label. Node name: power-controller
>>
>> I don't think this passes tests because of this. See power-domain.yaml
>> schema.
>>
> 
> Below code is from bcm2711-rpi-4-b.dts decompiled from the dtb file.

Uh? Why would we ever care about decompiling some DTBs?


> 
> firmware {
>          compatible = "raspberrypi,bcm2835-firmware\0simple-mfd";
>          mboxes = <0x1d>;
>          phandle = <0x1e>;
>         ...
> };
> 
> power {
>          compatible = "raspberrypi,bcm2835-power";
>          firmware = <0x1e>;
>          #power-domain-cells = <0x01>;
>          phandle = <0x0b>;
> };
> 
> I had a doubt that as above the raspberrypi,bcm2835-power compatible node
> is defined with power keyword, so should I still rename the node as
> power-controll or keep it has power?

I don't understand your arguments. Schema expects this to have proper
name (see bindings). DT spec as well.

> 
> Also it does passes the dt_binding_check and CHECK_DTBS=y broadcom/bcm2711-rpi-4-b.dtb
> but does gives the message as
> soc: power: 'ranges' is a required property
> so do I need to add the range property here?

I have no clue what you are testing here. We do not care about some out
of tree DTB. And if you ask about upstream, then take conversions tasks
after reading this:

https://social.kernel.org/notice/Ai9hYRUKo8suzX3zNY

BTW, your patch has patch errors which *have to be fixed* as well. Apply
your patch to see them. Run checkpatch.

Best regards,
Krzysztof


