Return-Path: <linux-kernel+bounces-311642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1C3968B7E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 18:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17879282B33
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 16:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914501A302E;
	Mon,  2 Sep 2024 16:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CRAXP0Ih"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D942A8D0;
	Mon,  2 Sep 2024 16:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725292952; cv=none; b=WuqvvmJCSw2CCjNS0lRgSoiKaogO7wwu/qiaHWPsAO/rpBYREc84q/N3+EwMp80o0iwvddZQTYDE+3QmKLabYosZf3+sYsfosF+QXxlcsO6yoJV8XZkaCoOsDJpaY3hzdyrqUgcoed/pvxc0ErF8ru53jun46S72LlEPbFONGmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725292952; c=relaxed/simple;
	bh=6LeCsdM8CqtOIi4hNTfkKo04Af3xwWWjHmr/+DqmEPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WQIxDB2TsYclJM5taWIO0vUnSucY6VFPwbCOAg05wDlb0n7k05cr5pxl4GfDUg1wGXjmvwqNiZvfe2ljkmbNir1eASJLAAK2HT8q9QymXPvZBo6Fc/FenxDoyf9MHEwPnJblJoHYA7T+eBhDUVKAYQy94ltweHJBGj/DQe+xwnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CRAXP0Ih; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC3D6C4CEC2;
	Mon,  2 Sep 2024 16:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725292951;
	bh=6LeCsdM8CqtOIi4hNTfkKo04Af3xwWWjHmr/+DqmEPo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CRAXP0IhQSi+6W2FU8hkG1UG9b9yeW0eF3Dd1kxh2x3nqJ4T/Y/34p1IBpSVix4MD
	 XS4/rjeoVnkI/VCPvk4xZvpqgsQDosxPhUeZaQVmRWJ81ZCgoFl8ysDcUwEWFoGwXv
	 psbdS3MPjdcC1BffysLVBd0t+mATAN6jYzv1uqRPI9OeqMpLQ8gE5mRWMOQHE9p0nc
	 x91ZGo+z/e1fubYOy2IhNmp1ISwnYMWuOXSZwYwA2U2W7dmFFxJIBMOaQwa3/+gOHw
	 HdCiVD/ckhhKfCvnffXUNO1dvIzWLRAWqaKtQNRWcnPDITAcO83tpWnyqBm9XUqnXO
	 DEoxU3PHv5eQw==
Message-ID: <45037518-41b7-4cc1-a7f4-c4a0c9873950@kernel.org>
Date: Mon, 2 Sep 2024 18:02:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: AW: [PATCH 1/2] dt-bindings: hwmon: Introduce ADS71x8
To: "Sperling, Tobias" <Tobias.Sperling@Softing.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "jdelvare@suse.com" <jdelvare@suse.com>,
 "linux@roeck-us.net" <linux@roeck-us.net>, "robh@kernel.org"
 <robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>, "corbet@lwn.net"
 <corbet@lwn.net>
References: <BE1P281MB24208CB90AF549578AA5C384EF972@BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM>
 <ypez4vjmasehqflgi4ylylpicldabf2dc6wwjco34qr2zmkdvx@enejrjjyaulf>
 <BE1P281MB24208DE67DB0B1E9A75823ECEF922@BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <BE1P281MB24208DE67DB0B1E9A75823ECEF922@BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/09/2024 15:48, Sperling, Tobias wrote:
>> On Fri, Aug 30, 2024 at 11:49:53AM +0000, Sperling, Tobias wrote:
>>> >From b2e04ce5500faf274654be5284be9db4f3abefce Mon Sep 17 00:00:00
>> 2001
>>
>> Some junk ^^^ above. Please investigate how you send patches.
> 
> Yeah also saw this line, but of course tried to apply the patch again after sending it
> as mail and that worked fine. But just checked again and seems like this line can be
> dropped.
> And yes, I sent the patches manually, as we likely have some restrictions for smtp,
> but as I was able to apply them again it's fine I guess.
> 
>>> From: Tobias Sperling <tobias.sperling@softing.com>
>>> Date: Fri, 23 Aug 2024 12:08:33 +0200
>>> Subject: [PATCH 1/2] dt-bindings: hwmon: Introduce ADS71x8
>>
>> And all this suggests malformed patch.
> 
> Why? If I drop this I'm not able to apply the patch, so I think this should be fine.

OK, it works with b4, but seeing duplicated subject is not expected and
might not work with all tools.

> 
>>>
>>> Add documentation for the driver of ADS7128 and ADS7138 12-bit, 8-channel
>>> analog-to-digital converters. These ADCs have a wide operating range and
>>> a wide feature set. Communication is based on an I2C interface.
>>> The driver provides the functionality of manually reading single channels
>>> or sequentially reading all channels automatically.
>>>
>>> Signed-off-by: Tobias Sperling <tobias.sperling@softing.com>
>>> ---
>>>  .../devicetree/bindings/hwmon/ti,ads71x8.yaml |  85 +++++++++++
>>>  Documentation/hwmon/ads71x8.rst               | 140 ++++++++++++++++++
>>>  Documentation/hwmon/index.rst                 |   1 +
>>
>> Please run scripts/checkpatch.pl and fix reported warnings. Then please
>> run  and (probably) fix more warnings.
>> Some warnings can be ignored, especially from --strict run, but the code
>> here looks like it needs a fix. Feel free to get in touch if the warning
>> is not clear.
> 
> Had done this already before submitting the patches (at least without --strict),
> but only reports a warning about splitting the patch (which I got wrong here)
> and updating the maintainers.
> I guess you were about suggesting a second script to run. Which one is that?

Please split the patches.

> 
>>> +$id:
>> https://deu01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicetree.
>> org%2Fschemas%2Fhwmon%2Fti%2Cads71x8.yaml%23&data=05%7C02%7C%7C
>> ff09fedbe2744394f78508dcc9881ee7%7Cfe3606fad3974238999768dcd7851f64
>> %7C1%7C0%7C638606833686313557%7CUnknown%7CTWFpbGZsb3d8eyJWIjoi
>> MC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C
>> %7C%7C&sdata=vZaCpdaNzELpNNnd6wp5P9MNLQTnAmWXYD%2BNKQYCJ78%
>> 3D&reserved=0
>>> +$schema:
>> https://deu01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicetree.
>> org%2Fmeta-
>> schemas%2Fcore.yaml%23&data=05%7C02%7C%7Cff09fedbe2744394f78508dcc
>> 9881ee7%7Cfe3606fad3974238999768dcd7851f64%7C1%7C0%7C63860683368
>> 6326954%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2lu
>> MzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=EJflznuTZYGR
>> BRjULwohiHk8gPF9iRusSbmF8CKkl5Q%3D&reserved=0
>>> +
>>> +title: Texas Instruments ADS7128/ADS7138 Analog to Digital Converter (ADC)
>>> +
>>> +maintainers:
>>> +  - None
>>
>> Fidn a person... otherwise why would we care?
> 
> I know it's not nice, but we are likely not implementing further features, but OK, will
> add myself then.
> 
>>> +    default: 1
>>> +
>>> +  interrupts:
>>> +    description: |
>>> +      Only considered in mode 1!
>>
>> What is "considered"? Driver considers? This does not matter. Describe
>> the hardware and if this is hardware related, you should have
>> allOf:if:then restricting this.
> 
> It's possible to define a mode, either manual sampling or autosampling. In the
> latter mode, also the hardware capabilities change, e.g. the driver is able to
> trigger an interrupt so defining the interrupt only makes sense in that mode.
> Will have a look to allOf:if:then then.
> 
>>> +            compatible = "ti,ads7138";
>>> +            reg = <0x10>;
>>> +            avdd-supply = <&reg_stb_3v3>;
>>> +            ti,mode = /bits/ 8 <1>;
>>> +            ti,interval = /bits/ 16 <1000>;
>>> +            interrupt-parent = <&gpio2>;
>>> +            interrupts = <12 IRQ_TYPE_LEVEL_LOW>;
>>> +            status = "okay";
>>
>> Drop
> 
> I guess, I shall only drop the "status" not the whole section?

Only status

Best regards,
Krzysztof


