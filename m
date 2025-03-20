Return-Path: <linux-kernel+bounces-569216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C143FA6A013
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 08:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 264767B0EE6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 07:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE1D1E98FB;
	Thu, 20 Mar 2025 07:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="AvLuHofP"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F223819
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 07:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742454149; cv=none; b=FcdVNQjucSDrQJhQI9TaKXTHHwYi9LM526wmFdCvzzHZJBugHT5rA9tTRqzD0QZOyBKrEehc1M3gqCfv30unImMcMwoGHCF7Y6aW9khTv0LSyw8ZBd9Y/8F5D96Im1Xjky6wGEdXpY0lwmvGB1OHDgnWEVlUO0VCLzshayYh8RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742454149; c=relaxed/simple;
	bh=2WdLM05gwpdk6UOtmFVp57DPQ4H52niJP6KaxnhaTws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kEB40UNgV753VelgHk7lL8gnRXaYV3ARzXhkm/xk9XRueC0wNXQPAoBUMLjb+dM5iEqCkdSFCUxz2p2HLc5CiqXvxydf08OveU7HptOenZjFL1lRM1I7aCClU3HLYoavsBeowGWNn9L4TAu4u7CQXqndYLiNyWv9UR5nSLTNe/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=AvLuHofP; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1742454145;
 bh=jgNRTxN5DNgWvkI1l3S2gHA3Bcn02lDWsE+uKc1f9W8=;
 b=AvLuHofPGYJAk8/qfYsD5un/Cp8g+PJAT5YZOzaTxlyowTCLs75Bks0O2OfS8/nwnIVNpBOsw
 0FEJfZTZUlgBfiEn+yvGZRD+x8EtIqcXq7qj1lJASuynY6NN3ZNoIgoK/si3lNYZyYoVVqNv2oN
 mKQRsxreU+jUygq9/76mPWpD+z4idcPxQo3UUsIu+wYUV3CaNlW6Vh0VXTGa6fbZwVaBz2TLvJ/
 2p+96l6Prsa8VwdjnH2gf9uGlB+4PboK1LCtS4mAQcObaPQouSaYVrTCg4ULEC4S340xt71kMwc
 1qqRoJDCw3MKRSb+eZ2cnX4wjnQPeOEs6oMaU6qnWOjg==
X-Forward-Email-ID: 67dbbd7d5af7cf6d2bbfb7ee
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <0f0a35ba-d85d-49eb-92dd-7bc17358aeaf@kwiboo.se>
Date: Thu, 20 Mar 2025 08:02:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] arm64: dts: rockchip: Add pwm nodes for RK3528
To: Heiko Stuebner <heiko@sntech.de>, Chukun Pan <amadeus@jmu.edu.cn>
Cc: Yao Zi <ziyao@disroot.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20250318120003.2340652-1-amadeus@jmu.edu.cn>
 <20250318120003.2340652-2-amadeus@jmu.edu.cn>
 <0d638134-0c0d-4918-af47-e23d2ead3bf3@kwiboo.se> <2499436.jE0xQCEvom@phil>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <2499436.jE0xQCEvom@phil>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2025-03-20 00:47, Heiko Stuebner wrote:
> Am Donnerstag, 20. März 2025, 00:26:14 MEZ schrieb Jonas Karlman:
>> Hi Chukun,
>>
>> On 2025-03-18 13:00, Chukun Pan wrote:
>>> Add pwm nodes for RK3528. The PWM core on RK3528 is the same as
>>> RK3328, but the driver does not support interrupts yet.
>>
>> The device tree should describe the hardware, not what the driver
>> support, so interrupts should probably be included.
>>
>> However, looking closer at TRM for i.e. RK3328, RK3568 and RK3588 it
>> look like the following description is not a true description of the
>> hardware.
>>
>> Each PWM controller seem to support 4 channels, here (and for older RK
>> SoCs) we instead describe each channel and not the controller.
> 
> Yep, that is something that did go wrong in the very early days.
> And all other Rockchip socs also have the same issue - even back
> to the rk3066.

I see, look like the PWM has evolved something like following:

- The controller has always been 1 controller for 4 channels
- Initial versions only had 2 regs for interrupt outside of the 4x
  0x10 reg space, one for each channel
- FIFO was introduced for channel 3
- Interrupts for FIFO was introduced (in RK3399 or earlier)
- Additional features/regs was introduced (in PX30 or earlier)
- PWM_VERSION_ID = 0x02120b34 is used (in RK3308 and later)

> 
> So yes, at some point we should overhaul the thing.
> 
> But I think this is more involved, as right now everything is aimed
> at the current single-channel status quo.

I did a quick and dirty change in driver to use npwms = 4, and that was
a rather trivial change, see top commit at [1]. Minimum required change
in U-Boot also look to be very trivial.

  cat /sys/kernel/debug/pwm
  0: platform/ffa90000.pwm, 4 PWM devices
   pwm-0   ((null)              ): period: 0 ns duty: 0 ns polarity: normal
   pwm-1   (regulator-vdd-arm   ): requested enabled period: 5000 ns duty: 2250 ns polarity: inverse
   pwm-2   (regulator-vdd-logic ): requested enabled period: 5000 ns duty: 2800 ns polarity: inverse
   pwm-3   ((null)              ): period: 0 ns duty: 0 ns polarity: normal

Not really seeing any reason not to describe these PWM controllers more
correctly, we need to start somewhere.

However, I have no idea on how to deal with historic and wrong bindings.
Driver could possible check if resource space is above 0x10 size and state
of PWM_VERSION_ID.

  PWM_VERSION_ID  0x005c  W  0x02120b34  PWM Version ID Register  

[1] https://github.com/Kwiboo/linux-rockchip/commits/next-20250319-rk3528/

Regards,
Jonas

> 
> 
> Heiko
> 
> 
>> Maybe something like following would better represent the hardware:
>>
>> 	pwm0: pwm@ffa90000 {
>> 		compatible = "rockchip,rk3528-pwm";
>> 		reg = <0x0 0xffa90000 0x0 0x10000>;
>> 		clocks = <&cru CLK_PWM0>, <&cru PCLK_PWM0>;
>> 		clock-names = "pwm", "pclk";
>> 		interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>,
>> 			     <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
>> 	};
>>
>> 	pwm1: pwm@ffa98000 {
>> 		compatible = "rockchip,rk3528-pwm";
>> 		reg = <0x0 0xffa98000 0x0 0x10000>;
>> 		clocks = <&cru CLK_PWM1>, <&cru PCLK_PWM1>;
>> 		clock-names = "pwm", "pclk";
>> 		interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>,
>> 			     <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
>> 	};
>>
>> Regards,
>> Jonas
>>
>>>
>>> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
>>> ---
>>>  arch/arm64/boot/dts/rockchip/rk3528.dtsi | 80 ++++++++++++++++++++++++
>>>  1 file changed, 80 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3528.dtsi b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
>>> index 1af0d036cf32..621fc19ac0b3 100644
>>> --- a/arch/arm64/boot/dts/rockchip/rk3528.dtsi
>>> +++ b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
>>> @@ -465,6 +465,86 @@ uart7: serial@ffa28000 {
>>>  			status = "disabled";
>>>  		};
>>>  
>>> +		pwm0: pwm@ffa90000 {
>>> +			compatible = "rockchip,rk3528-pwm",
>>> +				     "rockchip,rk3328-pwm";
>>> +			reg = <0x0 0xffa90000 0x0 0x10>;
>>> +			clocks = <&cru CLK_PWM0>, <&cru PCLK_PWM0>;
>>> +			clock-names = "pwm", "pclk";
>>> +			#pwm-cells = <3>;
>>> +			status = "disabled";
>>> +		};
>>> +
>>> +		pwm1: pwm@ffa90010 {
>>> +			compatible = "rockchip,rk3528-pwm",
>>> +				     "rockchip,rk3328-pwm";
>>> +			reg = <0x0 0xffa90010 0x0 0x10>;
>>> +			clocks = <&cru CLK_PWM0>, <&cru PCLK_PWM0>;
>>> +			clock-names = "pwm", "pclk";
>>> +			#pwm-cells = <3>;
>>> +			status = "disabled";
>>> +		};
>>> +
>>> +		pwm2: pwm@ffa90020 {
>>> +			compatible = "rockchip,rk3528-pwm",
>>> +				     "rockchip,rk3328-pwm";
>>> +			reg = <0x0 0xffa90020 0x0 0x10>;
>>> +			clocks = <&cru CLK_PWM0>, <&cru PCLK_PWM0>;
>>> +			clock-names = "pwm", "pclk";
>>> +			#pwm-cells = <3>;
>>> +			status = "disabled";
>>> +		};
>>> +
>>> +		pwm3: pwm@ffa90030 {
>>> +			compatible = "rockchip,rk3528-pwm",
>>> +				     "rockchip,rk3328-pwm";
>>> +			reg = <0x0 0xffa90030 0x0 0x10>;
>>> +			clocks = <&cru CLK_PWM0>, <&cru PCLK_PWM0>;
>>> +			clock-names = "pwm", "pclk";
>>> +			#pwm-cells = <3>;
>>> +			status = "disabled";
>>> +		};
>>> +
>>> +		pwm4: pwm@ffa98000 {
>>> +			compatible = "rockchip,rk3528-pwm",
>>> +				     "rockchip,rk3328-pwm";
>>> +			reg = <0x0 0xffa98000 0x0 0x10>;
>>> +			clocks = <&cru CLK_PWM1>, <&cru PCLK_PWM1>;
>>> +			clock-names = "pwm", "pclk";
>>> +			#pwm-cells = <3>;
>>> +			status = "disabled";
>>> +		};
>>> +
>>> +		pwm5: pwm@ffa98010 {
>>> +			compatible = "rockchip,rk3528-pwm",
>>> +				     "rockchip,rk3328-pwm";
>>> +			reg = <0x0 0xffa98010 0x0 0x10>;
>>> +			clocks = <&cru CLK_PWM1>, <&cru PCLK_PWM1>;
>>> +			clock-names = "pwm", "pclk";
>>> +			#pwm-cells = <3>;
>>> +			status = "disabled";
>>> +		};
>>> +
>>> +		pwm6: pwm@ffa98020 {
>>> +			compatible = "rockchip,rk3528-pwm",
>>> +				     "rockchip,rk3328-pwm";
>>> +			reg = <0x0 0xffa98020 0x0 0x10>;
>>> +			clocks = <&cru CLK_PWM1>, <&cru PCLK_PWM1>;
>>> +			clock-names = "pwm", "pclk";
>>> +			#pwm-cells = <3>;
>>> +			status = "disabled";
>>> +		};
>>> +
>>> +		pwm7: pwm@ffa98030 {
>>> +			compatible = "rockchip,rk3528-pwm",
>>> +				     "rockchip,rk3328-pwm";
>>> +			reg = <0x0 0xffa98030 0x0 0x10>;
>>> +			clocks = <&cru CLK_PWM1>, <&cru PCLK_PWM1>;
>>> +			clock-names = "pwm", "pclk";
>>> +			#pwm-cells = <3>;
>>> +			status = "disabled";
>>> +		};
>>> +
>>>  		saradc: adc@ffae0000 {
>>>  			compatible = "rockchip,rk3528-saradc";
>>>  			reg = <0x0 0xffae0000 0x0 0x10000>;
>>
>>
> 
> 
> 
> 


