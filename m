Return-Path: <linux-kernel+bounces-394779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B559BB3CC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 12:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77AF11F20FD9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 11:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDDE1B5EBC;
	Mon,  4 Nov 2024 11:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mmB1wf01"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA6F1B4F29;
	Mon,  4 Nov 2024 11:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730720842; cv=none; b=cEmeC3aPe2f84WQlAd2jLK7GZxmE8OIPF1pSs+r1jQ+Fx22vVSR4deIIu7Zo3D5mfecqBJpTgdRuVpF2K4K9JEVYHz10uv4FjLMVDREuinmneUYSxgbVUoq5gP5Qvn61z0G1oMUla8vjvPZUFeWD/OkHjCj8JSHlO2Nf8eaPnq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730720842; c=relaxed/simple;
	bh=e1nzHk0cpcCIC/llfwkEOi5lrvUtOPMV7NJH5JG9+0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eoRNnIYCRS6Vu40tz017rdLEBsm5l+vM/ESjzFmJbH65fPwq1q43gs7QZwJ9JhdBnlJ2hKlcPXeC8GpXEcjBFZP/KXToLIWEgD2a//6PsSee4hGNGvkJPBh+zPiBXwO0qLF1FyfQ+YvcRDliva/qFU2a+W8g5WnqPGh91HferPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mmB1wf01; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7683CC4CECE;
	Mon,  4 Nov 2024 11:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730720842;
	bh=e1nzHk0cpcCIC/llfwkEOi5lrvUtOPMV7NJH5JG9+0k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mmB1wf01Pp6MR+T1Qs6Fb2/RhTQSvLDCOVKV9u+3AzczWUn7PpPA3NXh4IEnpFc4q
	 mWH758J4t0LsSS0P2evQFY5lWwnpnH5z15/D9u1u5kIUlsWaQ+mtqY9w7AqZ1z9b0N
	 Oel+V21OuqdUt5OWfWmp9YgffnXG6We0wFcTfEZ4Zvd/Wb/EkEli+NLuU67VfVo+CY
	 jY+YHwpJimq/AXWBa5YCZh2oH3y24qFYfnKMGHPhDYv8WVRc/CWgOXcTDp2tGjDrjZ
	 NMVLxEKZ7mAqG82nIEyXjaucK6osBJsk7gAzOC5UL43ctJrf3Y0brQx6OPX4PtYNuZ
	 spq3GGEnX40Eg==
Message-ID: <62e24ed4-3579-46ff-a77a-c5733125012c@kernel.org>
Date: Mon, 4 Nov 2024 12:47:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] dt-bindings: hwmon: pwm-fan: add
 retain-state-shutdown property
To: Billy Tsai <billy_tsai@aspeedtech.com>,
 Akinobu Mita <akinobu.mita@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
References: <20241026080535.444903-1-akinobu.mita@gmail.com>
 <20241026080535.444903-3-akinobu.mita@gmail.com>
 <ijdk5uuurnfd2shnwwj2nm64bno6lmrhdyqp42pzjc3i2e5cyh@v5ljkrsgo6ac>
 <CAC5umyitFp7oGR-eYXMVaS8bY1AGe3QwEuSPoEz3DxWwH=dUsA@mail.gmail.com>
 <e29e2c9e-60c1-4f32-ab71-e74f331e1921@kernel.org>
 <CAC5umyhCw+62Y+h3Jvh3=0Ocs8XJsSu_vaiPpO_g=65Jo4vUFg@mail.gmail.com>
 <e4985609-0642-4ff4-b074-8c5a34f88a24@kernel.org>
 <CAC5umyhrNCA4BHqC_k_tSaSOANcvP_vt485650xtFTPwJ+6snQ@mail.gmail.com>
 <OSQPR06MB72525057883A59578441E0988B512@OSQPR06MB7252.apcprd06.prod.outlook.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <OSQPR06MB72525057883A59578441E0988B512@OSQPR06MB7252.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/11/2024 08:45, Billy Tsai wrote:
>>>
>>> On 28/10/2024 15:57, Akinobu Mita wrote:
>>>>>>>
>>>>>>> You described the desired Linux feature or behavior, not the actual
>>>>>>> hardware. The bindings are about the latter, so instead you need to
>>>>>>> rephrase the property and its description to match actual hardware
>>>>>>> capabilities/features/configuration etc.
>>>>>>
>>>>>> Is this description okay?
>>>>>> (Reused the description of retain-state-shutdown in leds-gpio.yaml)
>>>>>>
>>>>>> description:
>>>>>>   Retain the state of the PWM on shutdown. Useful in BMC systems, for
>>>>>>   example, when the BMC is rebooted while the host remains up, the fan
>>>>>>   will not stop.
>>>>>
>>>>> Nothing improved in the property. You still say what the system should
>>>>> do. This is user-space choice, not DT.
>>>>
>>>> It seems better to implement it as a device attribute.
>>>
>>> I don't know about that. To repeat: if you say what system is supposed
>>> to be doing, it is a policy. Describe the hardware and its configuration
>>> and maybe this would be suitable for DT.
> 
>> Billy, could you please write a proper description for this property?
>> I'm not the right person for this.
> 
> In our hardware, if the system reboots and power remains on the PWM controller
> will retain its original settings. However, the pwm-fan.c driver currently disables
> the PWM controller during a system reboot. I need this property to prevent pwm-fan.c

If we change the PWM core not to disable it, then we have to change
bindings?

How is this binding applicable on system (e.g. on *BSD) which does not
disable PWM on reboot?

> from disabling the PWM when the system reboots.
> In my point of view, the description can be:
> Retain the state of the PWM on shutdown. Some platforms (e.g., BMC) will maintain
> the PWM status after the system reboot. Add this property to prevent the PWM from being
> disabled during the system reboot.

You again describe what OS should do. First and last sentences are the same.

Probably what you want to say is that fan is some critical component
which should not be turned off or left unattended. Or that this hardware
keeps last state of register on reset, so some boards might want to use
it? If the first, then probably different property name. If the second,
current seems fine, just choose some description describing actual hardware.

Best regards,
Krzysztof


