Return-Path: <linux-kernel+bounces-440525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 287AC9EBFC4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 01:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F4921696A6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 00:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA4623BE;
	Wed, 11 Dec 2024 00:06:03 +0000 (UTC)
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB947195;
	Wed, 11 Dec 2024 00:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733875563; cv=none; b=rJ6W4hU6tkKU5OYdWiCG+wEmvCi1H1p2d8jGR7NNibrz7HbY4Wa4H4akG/U7CVjPunh7XNoLSOVKVzhURsOtXorg28clHfMwdD7oeJc972ZmlhFB9lXBhu8mFr5KkiMwzIkP0RurunjL39UQoIJRP2yAaLpW8dkoUAOXkfoo2fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733875563; c=relaxed/simple;
	bh=tBmyAuBLUvOwUitPp8RIqkk9PVktXln9z/N53lWXphA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S7BjOsDXB7wwfI+k+UHW4N5Cecx/qttsJgQa3Nje1GRPvbyFTqm+kRtAU7MQGqKQTjNrfKKo2WQ6s+Cd0UlSUC273+3/URq8oxKZU4kPl69+hqfrB+rQtpgVJWvrFcrMpE7Yh63mShntR+am19XaqY58j1AAFucWAVWVa2Y6aJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: bizesmtpip3t1733875482tvnnehp
X-QQ-Originating-IP: 9w0YsQyOzfYyv8jIOHcfcYv+uIOEJ3ywmzn/lfvK4dU=
Received: from [IPV6:240f:10b:7440:1:9e54:d32d ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 11 Dec 2024 08:04:37 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3498700866088995308
Message-ID: <9087FE0C88CD8335+4505c82a-33dd-45cf-941d-aa818068f19c@radxa.com>
Date: Wed, 11 Dec 2024 09:04:37 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] arm64: dts: rockchip: Add USB-C support to ROCK 5B
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com
References: <20241210163615.120594-1-sebastian.reichel@collabora.com>
 <6A24DF29AE2F3CDC+70602cc7-2c03-470d-955f-06b2db116e20@radxa.com>
 <5mjjq3f3tqu4h2f7wbdcfon6csfsuxge5skr6mmgozvq65uods@66yx7yuefzqn>
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
In-Reply-To: <5mjjq3f3tqu4h2f7wbdcfon6csfsuxge5skr6mmgozvq65uods@66yx7yuefzqn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:radxa.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: M59Ywtx0bkALHUBhJP6GADzbbAX/vjeWKDMfpS8plQnztzewlm8lLg+N
	0946THzsHA3pS/e03oOeKZ74Hn9hMWITt1lVx6uea5y4zFM9jQpVWigNUMwRjqrczyK/yeV
	JmU2TZgF2z9araFIttiLY3q7HdqQ9z02F/12kL82XvnjN5Fa+PztxAWzyHEKbVLkahEAYTl
	VCQ+Huft+lbIXf9JUgcdO4RBZGny9lWKlsyHkMgPAc9W1FVcjBx0GEJIQrJmyMz+4DJJNe0
	eExGZD5iaoa/pRqNhwd4EGTiI8Noi8o3p5qP7PT4cS0eJXPHrqPYJHt3sQxFzTz4cU731/T
	R/LouMnjjvt/8D6fcdSW5mERWl39/qKAPiV4IXs7pq/twlJa/kMxqjMC0a3UWui+/Rg63rF
	yOJQlfV4vYkF7xmk4hvIr4YlWTRonRLDjDDGKQMNjimOa8W7EfmSXgcu4KbBWD710lzhTX/
	8ySMbedfDtNeMDX8mvKDbDDmVSir+x0vYaHPNCM0NSdcZ/bIUDevIyqPAbR+AsqNxbf2adD
	dYLNGND0MoO7k1z8IQG/2gjq1MeJ/WO+3BXpGcpmDttOOSuMLQJorsBT1iJMTi0cTupW7eb
	x6RFDpB9G6zphnRouiDVEMZJ/AJd0A6uqi1Mf8y6IjWZUyHaa269EJv9s4wYsNzio30Ggfo
	QdRubl2x4k49sd1tCtBIL1rRuMpyQRfh+dAwv94zPDzgqLRJRk0CDW7UQ2uJ4n6E16gXg+b
	8FmmTigG5S/YtDghWKHUDaAziYh827kpgwwybBq88ABzrH4ua6SgxWBNn/hr25Ce1NUAGy9
	maJjjcRdd1QvuJ0YgS++L5hs3q1xLDaowDb3aJ9doTxn9KYj/oVYXeZkHevNO1+xcDH4s3t
	56L/yZ2JXVfhcDFWtnqkzjQqXchVw1GjAyFNP4VC8xlr+sDTDSmy3u8NKFqr5lVuNQTNOJ9
	+tZowKW0N6hZlDr93kd95FD5q
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

Hi Sebastian,

On 12/11/24 08:08, Sebastian Reichel wrote:
> Hello Naoki,
> 
> On Wed, Dec 11, 2024 at 07:10:55AM +0900, FUKAUMI Naoki wrote:
>> Hi Sebastian,
>>
>> Thank you very much for your work!
>>
>> $ cat /sys/class/power_supply/tcpm-source-psy-4-0022/{current_max,current_now,online,type,usb_type,voltage_max,voltage_min,voltage_now}
>> 1500000
>> 1500000
>> 1
>> USB
>> C [PD] PD_PPS
>> 20000000
>> 20000000
>> 20000000
>>
>> $ cat /sys/class/power_supply/tcpm-source-psy-4-0022/{current_max,current_now,online,type,usb_type,voltage_max,voltage_min,voltage_now}
>> 5000000
>> 5000000
>> 1
>> USB
>> C PD [PD_PPS]
>> 20000000
>> 20000000
>> 20000000
>>
>> $ ls /sys/class/udc/
>> fc000000.usb
>>
>> I can configure it as CDC-NCM and host detects it.
>> But I could not use it as a HOST port. How to use it?
> 
> You can switch between host and peripheral for Type-C ports like
> this depending on the remote sides capabilities:
> 
>   * echo host > /sys/class/typec/<port>/data_role
>   * echo device > /sys/class/typec/<port>/data_role

thanks!

I tested both data_role and both orientation. all works.

> I tested this with a USB-C hub connected to the port, which works
> in host mode.
> 
>> some minor nitpick is below:
>>
>> On 12/11/24 01:36, Sebastian Reichel wrote:
>>> Add hardware description for the USB-C port in the Radxa Rock 5 Model B.
>>> This describes the OHCI, EHCI and XHCI USB parts, but not yet the
>>> DisplayPort AltMode (bindings are not yet upstream).
>>>
>>> The fusb302 node is marked with status "fail", since the board is usually
>>> powered through the USB-C port. Handling of errors can result in hard
>>> resets, which removed the bus power for some time resulting in a board
>>> reset.
>>>
>>> The main problem is that devices are supposed to interact with the
>>> power-supply within 5 seconds after the plug event according to the
>>> USB PD specification. This is more or less impossible to achieve when
>>> the kernel is the first software communicating with the power-supply.
>>>
>>> Recent U-Boot (v2025.01) will start doing USB-PD communication, which
>>> solves this issue. Upstream U-Boot doing USB-PD communication will also
>>> set the fusb302 node status to "okay". That way booting a kernel with
>>> the updated DT on an old U-Boot avoids a reset loop.
>>>
>>> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
>>> ---
>>>    .../boot/dts/rockchip/rk3588-rock-5b.dts      | 121 ++++++++++++++++++
>>>    1 file changed, 121 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
>>> index d597112f1d5b..cb5990df6ccb 100644
>>> --- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
>>> +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
>>> @@ -5,6 +5,7 @@
>>>    #include <dt-bindings/gpio/gpio.h>
>>>    #include <dt-bindings/leds/common.h>
>>>    #include <dt-bindings/soc/rockchip,vop2.h>
>>> +#include <dt-bindings/usb/pd.h>
>>>    #include "rk3588.dtsi"
>>>    / {
>>> @@ -84,6 +85,15 @@ rfkill-bt {
>>>    		shutdown-gpios = <&gpio3 RK_PD5 GPIO_ACTIVE_HIGH>;
>>>    	};
>>> +	vcc12v_dcin: regulator-vcc12v-dcin {
>>> +		compatible = "regulator-fixed";
>>> +		regulator-name = "vcc12v_dcin";
>>
>> typec_vin by schematic.
> 
> Ack. Will update in v2.
> 
>>> +		regulator-always-on;
>>> +		regulator-boot-on;
>>> +		regulator-min-microvolt = <12000000>;
>>> +		regulator-max-microvolt = <12000000>;

both microvolt line can be removed.

>>> +	};
>>> +
>>>    	vcc3v3_pcie2x1l0: regulator-vcc3v3-pcie2x1l0 {
>>>    		compatible = "regulator-fixed";
>>>    		enable-active-high;
>>> @@ -142,6 +152,7 @@ vcc5v0_sys: regulator-vcc5v0-sys {
>>>    		regulator-boot-on;
>>>    		regulator-min-microvolt = <5000000>;
>>>    		regulator-max-microvolt = <5000000>;
>>> +		vin-supply = <&vcc12v_dcin>;
>>
>> typec_vin.
>>
>>>    	};
>>>    	vcc_1v1_nldo_s3: regulator-vcc-1v1-nldo-s3 {
>>> @@ -264,6 +275,67 @@ regulator-state-mem {
>>>    	};
>>>    };
>>> +&i2c4 {
>>> +	pinctrl-names = "default";
>>> +	pinctrl-0 = <&i2c4m1_xfer>;
>>> +	status = "okay";
>>> +
>>> +	usbc0: usb-typec@22 {
>>
>> Is "usbc0" label necessary?
> 
> no, but does it hurt?

sorry, please keep it.

>>> +		compatible = "fcs,fusb302";
>>> +		reg = <0x22>;
>>> +		interrupt-parent = <&gpio3>;
>>> +		interrupts = <RK_PB4 IRQ_TYPE_LEVEL_LOW>;
>>> +		pinctrl-names = "default";
>>> +		pinctrl-0 = <&usbc0_int>;
>>
>> cc_int_l by schematic.
> 
> Ack. I intentionally switched away from this naming, since cc prefix
> is imho a way worse prefix than usbc0. The _l suffix just means
> active low, which is already encoded in DT.
> 
> But I don't have a strong opinion and can fix this in v2.
> 
>>> +		vbus-supply = <&vcc12v_dcin>;
>>
>> typec_vin
>>
>>> +		/*
>>> +		 * When the board is starting to send power-delivery messages
>>> +		 * too late (5 seconds according to the specification), the
>>> +		 * power-supply reacts with a hard-reset. That removes the
>>> +		 * power from VBUS for some time, which resets te whole board.
>>
>> ... resets "the" whole board.
> 
> Ack.
> 
>>
>>> +		 */
>>> +		status = "fail";
>>> +
>>> +		usb_con: connector {
>>
>> Is "usb_con" label necessary?
> 
> No. It should either be changed to "usbc0_con" or removed. In
> general I tend to add some labels when they might be needed by
> something in the future. They are more or less free anyways.

+1 for "usbc0_con".

Best regards,

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

> -- Sebastian


