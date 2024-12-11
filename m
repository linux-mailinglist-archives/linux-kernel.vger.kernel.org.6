Return-Path: <linux-kernel+bounces-440563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6599EC106
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 01:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F83028472A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 00:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6B63A8D2;
	Wed, 11 Dec 2024 00:41:47 +0000 (UTC)
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.62.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56293259C;
	Wed, 11 Dec 2024 00:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.62.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733877707; cv=none; b=K3PYdEAsUHaNOdhZ0fBx1mSWKdE17gtIRuCcAbqeThvV1xMyv2xAVor1QQkOBhtSJ8bIkgPB1/4vNhF4sE7llO87XJgEGsyj1298s16RBXtf4T5wU/LQgJoMaEBIjZL0wH8yGtnwdaJRsYeE8W9Iic+cDVbbIiTK3LjJxD11dFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733877707; c=relaxed/simple;
	bh=gMDurvn7HqoxdyWKlgRG8xpN2rAdJn3Ktdm0m0F8P/0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=FxpMKP2SlJ0kzgx4bUDJCy1V6LL5kEgtbIl4r8n8Fx4MK+KI0bK/MhUyT6qeG2oRm/niRFogf/3oImh29t2277j/Jzb/E9HtS4UquzUTMiK6lQ6hFIaqQ7B4gcx+CMLjNlqWLdB8qJjKpCJK0QQGbFt1UIa+/gLnheR2mOZdVDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=114.132.62.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: bizesmtpip4t1733877616ty8czwh
X-QQ-Originating-IP: YCAB/W5lc5XhIctXFs+ypJMkuS4H4EsdXpj2oghLazI=
Received: from [IPV6:240f:10b:7440:1:9e54:d32d ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 11 Dec 2024 08:40:13 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 306073378999332624
Message-ID: <3D830E407DCD15A2+de00ea1d-96d5-4766-9dc5-616fc76f404b@radxa.com>
Date: Wed, 11 Dec 2024 09:40:13 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] arm64: dts: rockchip: Add USB-C support to ROCK 5B
From: FUKAUMI Naoki <naoki@radxa.com>
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Heiko Stuebner <heiko@sntech.de>
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com
References: <20241210163615.120594-1-sebastian.reichel@collabora.com>
 <FFD6E87BED20DB1B+38b8064e-9945-4cd8-a30e-7800a8c6f37b@radxa.com>
Content-Language: en-US
In-Reply-To: <FFD6E87BED20DB1B+38b8064e-9945-4cd8-a30e-7800a8c6f37b@radxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:radxa.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OHcJgPpQFonKT4cjqi5uhJ+oDJt3cHW4mhpP6EN4oVPCgHnu+xKGTDnM
	CfTFPpH+bPn7Rvg8+hOLIN0KohfWYGJJ8zsPxZUvHwmh7A9kGYLUcZ4+j66wBLSE6HPDH2r
	uQTmLRe6qmygW+c1djF1K8CxJW9KdEj1xPTa0qqM6FnSnNXT+bx3AHcqyAS0J8xh/4Qexhy
	y2fyF7UXL+VkQogBlNf6VFCb1TUJa06zEHK8sCcI7FSxdO5ofj3NHlB4PN9mgPe68Hb0Yif
	0yznI7SJCN1rtw7l0hUkptVfY0uggWYZeDMXvkHCuj5Vk5J6jfZ9vrKl+FM2qRg6K/ZdKPX
	5+pIoNq9e8xhIPOBYx00wDpd5wyJ1IyarvT2ddsftwcljhQC8IlUGuSugsvRC4WBLHOs3Gc
	C9wZp7TBaAchbjxkGnSKGnC8//AudJysAXPISYZOAqhTgnLW8h61Otytm1vqLcKvz7bNWi1
	D40TJNTWAqZQB4d6RC8ICUHk9BHJ1Q7mp2ztpqoxriud9t2Vg6YK+kZ26VuPAEO40CxcKar
	SgD6myOPIFmYp9hMjyaVue+jPmK9ojZb4KAJqg1e/g3/EL5MfDZuyuqHLvBIwgXSdoQF13A
	hbN3eVxLw5z8HXkeYZ+ZPhr0QD+a05ZgDWlYdOFG8WP0yWbNmmN/IGQkRZNvsmhICKovK0f
	X3TE9CZkRfHKbAVo1DhglrzmQVhP+WNG7pOneMBxZ6441F/kg3gAGUOc1whIzOOIndk6rfw
	+Ga+yQXFY8CeaIxKzX8ARkCLopJQG8s467x5P0ZSsQ9scrZNJP1x7RGqlJc12IdKTT7AX8O
	zrv9BvQnaYRh/ZrcCThXqrGJ84vzPP6QxQgCjXt32KfLDdGF2reZTUImABA+b9wexIXlWnO
	M3xShQ5PDfXXA4eh4Hs5T+S+bW7YglMNP6pDcq4dXWHzxBRxukG74KDNHLJAnNh4jFBf9ck
	zOfiK6OsrKGgr0iJrk8UWZKCAkLbjktttvY0=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

Hi Sebastian,

Sorry for many emails...

I got random reboot during booting kernel/userland...

Best regards,

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

On 12/11/24 09:06, FUKAUMI Naoki wrote:
> Sorry, I forgot to write one thing...
> 
> On 12/11/24 01:36, Sebastian Reichel wrote:
>> Add hardware description for the USB-C port in the Radxa Rock 5 Model B.
>> This describes the OHCI, EHCI and XHCI USB parts, but not yet the
>> DisplayPort AltMode (bindings are not yet upstream).
>>
>> The fusb302 node is marked with status "fail", since the board is usually
>> powered through the USB-C port. Handling of errors can result in hard
>> resets, which removed the bus power for some time resulting in a board
>> reset.
>>
>> The main problem is that devices are supposed to interact with the
>> power-supply within 5 seconds after the plug event according to the
>> USB PD specification. This is more or less impossible to achieve when
>> the kernel is the first software communicating with the power-supply.
>>
>> Recent U-Boot (v2025.01) will start doing USB-PD communication, which
>> solves this issue. Upstream U-Boot doing USB-PD communication will also
>> set the fusb302 node status to "okay". That way booting a kernel with
>> the updated DT on an old U-Boot avoids a reset loop.
>>
>> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> 
> Tested-by: FUKAUMI Naoki <naoki@radxa.com>
> 
> -- 
> FUKAUMI Naoki
> Radxa Computer (Shenzhen) Co., Ltd.
> 
>> ---
>>   .../boot/dts/rockchip/rk3588-rock-5b.dts      | 121 ++++++++++++++++++
>>   1 file changed, 121 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/ 
>> arm64/boot/dts/rockchip/rk3588-rock-5b.dts
>> index d597112f1d5b..cb5990df6ccb 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
>> +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
>> @@ -5,6 +5,7 @@
>>   #include <dt-bindings/gpio/gpio.h>
>>   #include <dt-bindings/leds/common.h>
>>   #include <dt-bindings/soc/rockchip,vop2.h>
>> +#include <dt-bindings/usb/pd.h>
>>   #include "rk3588.dtsi"
>>   / {
>> @@ -84,6 +85,15 @@ rfkill-bt {
>>           shutdown-gpios = <&gpio3 RK_PD5 GPIO_ACTIVE_HIGH>;
>>       };
>> +    vcc12v_dcin: regulator-vcc12v-dcin {
>> +        compatible = "regulator-fixed";
>> +        regulator-name = "vcc12v_dcin";
>> +        regulator-always-on;
>> +        regulator-boot-on;
>> +        regulator-min-microvolt = <12000000>;
>> +        regulator-max-microvolt = <12000000>;
>> +    };
>> +
>>       vcc3v3_pcie2x1l0: regulator-vcc3v3-pcie2x1l0 {
>>           compatible = "regulator-fixed";
>>           enable-active-high;
>> @@ -142,6 +152,7 @@ vcc5v0_sys: regulator-vcc5v0-sys {
>>           regulator-boot-on;
>>           regulator-min-microvolt = <5000000>;
>>           regulator-max-microvolt = <5000000>;
>> +        vin-supply = <&vcc12v_dcin>;
>>       };
>>       vcc_1v1_nldo_s3: regulator-vcc-1v1-nldo-s3 {
>> @@ -264,6 +275,67 @@ regulator-state-mem {
>>       };
>>   };
>> +&i2c4 {
>> +    pinctrl-names = "default";
>> +    pinctrl-0 = <&i2c4m1_xfer>;
>> +    status = "okay";
>> +
>> +    usbc0: usb-typec@22 {
>> +        compatible = "fcs,fusb302";
>> +        reg = <0x22>;
>> +        interrupt-parent = <&gpio3>;
>> +        interrupts = <RK_PB4 IRQ_TYPE_LEVEL_LOW>;
>> +        pinctrl-names = "default";
>> +        pinctrl-0 = <&usbc0_int>;
>> +        vbus-supply = <&vcc12v_dcin>;
>> +        /*
>> +         * When the board is starting to send power-delivery messages
>> +         * too late (5 seconds according to the specification), the
>> +         * power-supply reacts with a hard-reset. That removes the
>> +         * power from VBUS for some time, which resets te whole board.
>> +         */
>> +        status = "fail";
>> +
>> +        usb_con: connector {
>> +            compatible = "usb-c-connector";
>> +            label = "USB-C";
>> +            data-role = "dual";
>> +            power-role = "sink";
>> +            try-power-role = "sink";
>> +            op-sink-microwatt = <1000000>;
>> +            sink-pdos =
>> +                <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>,
>> +                <PDO_VAR(5000, 20000, 5000)>;
>> +
>> +            ports {
>> +                #address-cells = <1>;
>> +                #size-cells = <0>;
>> +
>> +                port@0 {
>> +                    reg = <0>;
>> +                    usbc0_role_sw: endpoint {
>> +                        remote-endpoint = <&dwc3_0_role_switch>;
>> +                    };
>> +                };
>> +
>> +                port@1 {
>> +                    reg = <1>;
>> +                    usbc0_orien_sw: endpoint {
>> +                        remote-endpoint = 
>> <&usbdp_phy0_orientation_switch>;
>> +                    };
>> +                };
>> +
>> +                port@2 {
>> +                    reg = <2>;
>> +                    dp_altmode_mux: endpoint {
>> +                        remote-endpoint = <&usbdp_phy0_dp_altmode_mux>;
>> +                    };
>> +                };
>> +            };
>> +        };
>> +    };
>> +};
>> +
>>   &i2c6 {
>>       status = "okay";
>> @@ -423,6 +495,10 @@ usb {
>>           vcc5v0_host_en: vcc5v0-host-en {
>>               rockchip,pins = <4 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
>>           };
>> +
>> +        usbc0_int: usbc0-int {
>> +            rockchip,pins = <3 RK_PB4 RK_FUNC_GPIO &pcfg_pull_none>;
>> +        };
>>       };
>>   };
>> @@ -835,6 +911,14 @@ &uart2 {
>>       status = "okay";
>>   };
>> +&u2phy0 {
>> +    status = "okay";
>> +};
>> +
>> +&u2phy0_otg {
>> +    status = "okay";
>> +};
>> +
>>   &u2phy1 {
>>       status = "okay";
>>   };
>> @@ -866,6 +950,29 @@ &usbdp_phy1 {
>>       status = "okay";
>>   };
>> +&usbdp_phy0 {
>> +    mode-switch;
>> +    orientation-switch;
>> +    sbu1-dc-gpios = <&gpio4 RK_PA6 GPIO_ACTIVE_HIGH>;
>> +    sbu2-dc-gpios = <&gpio4 RK_PA7 GPIO_ACTIVE_HIGH>;
>> +    status = "okay";
>> +
>> +    port {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        usbdp_phy0_orientation_switch: endpoint@0 {
>> +            reg = <0>;
>> +            remote-endpoint = <&usbc0_orien_sw>;
>> +        };
>> +
>> +        usbdp_phy0_dp_altmode_mux: endpoint@1 {
>> +            reg = <1>;
>> +            remote-endpoint = <&dp_altmode_mux>;
>> +        };
>> +    };
>> +};
>> +
>>   &usb_host0_ehci {
>>       status = "okay";
>>   };
>> @@ -874,6 +981,20 @@ &usb_host0_ohci {
>>       status = "okay";
>>   };
>> +&usb_host0_xhci {
>> +    usb-role-switch;
>> +    status = "okay";
>> +
>> +    port {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        dwc3_0_role_switch: endpoint {
>> +            remote-endpoint = <&usbc0_role_sw>;
>> +        };
>> +    };
>> +};
>> +
>>   &usb_host1_ehci {
>>       status = "okay";
>>   };
> 


