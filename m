Return-Path: <linux-kernel+bounces-440442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D379EBDF8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 23:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B01B9284185
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 22:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC141F1917;
	Tue, 10 Dec 2024 22:42:57 +0000 (UTC)
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.58.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50FE1D014E;
	Tue, 10 Dec 2024 22:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.58.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733870577; cv=none; b=l6vrO7ZdMDMM3uZJsJZQJvvTyKCbWxNXp8fV6WtO6pLlISzwyeluT/rTqvpR9JEwlVgR85SIMJlfO3OOtONcng23FXkDVuwtwuPut9zJ2IOERfNiHwTlzV27RbIf7GJPqFmDDwFwtysK6/oHQPzEGjA89JvNgj2rdG5YzHxDRsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733870577; c=relaxed/simple;
	bh=Bz++RuxbEkptmal2UHhRFRzIofv8dCRHhojRhD9OWas=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=I3kjDlbvv8cCUxtBZbymA03ZJgmguDZnNwOyKRqBLNYlfdnaizXJji1QZeHQW8+Lk27wYHlHhoS1xBwFOFQmBREVxrfq+rWMh0brf1/80VntZR30LcC3quRJjmTetCwxp/DtZCaVZR2REe0wOV2SRJhtIwJMXINfWLRMBW9mseE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=114.132.58.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: bizesmtpip3t1733870489tw0s2wi
X-QQ-Originating-IP: vIcIl1VTwBCeBy2FbdiZkt97uz/iQYtqRMaaTUIjrkU=
Received: from [IPV6:240f:10b:7440:1:9e54:d32d ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 11 Dec 2024 06:41:24 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16291552602694824972
Message-ID: <8ABA1DC12C12F3A8+89687fc8-25ed-4217-9df9-696c907b49b3@radxa.com>
Date: Wed, 11 Dec 2024 07:41:24 +0900
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
 <6A24DF29AE2F3CDC+70602cc7-2c03-470d-955f-06b2db116e20@radxa.com>
Content-Language: en-US
In-Reply-To: <6A24DF29AE2F3CDC+70602cc7-2c03-470d-955f-06b2db116e20@radxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:radxa.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NUbJ1FBQTTPugOujKzNnOMQ11qgp/STcOdNVnVRmNcoIjDRf7q14pMT7
	QOqndzbF40aFLnkxepCskJX40h9FGX+gqGgZIheBJM8r/KWtTaH9e0Eam1Bqx3Zd8oWRCur
	WNp0HVVaN5Ja+VLW4Ud8XAMQse/SWvNpx0ze2QpSajmxP9jq6YA7q3iQwSyVB4Fq2Oz6hIS
	qXoRFviRFdTIcWgbhfKaxAcntR1ahdtYtIFcGDDJnbP1s1S0g+78KsIjOYFu/y/QdyZVCsd
	/64TDGuM1PA4U+/D6GMOTUaFn9U4RgdlK6efduVSspX5zXAzCSqXvKUr5uWYqp+jYwmsRk0
	U9rPieJnCPvH2taOPuj1MSCm9/RSAo0hNR7pg09utGqUIA3ERzWQKpLBzHbhE8cTwF/AGBR
	rRzFVoQI2RPx6cpUcR4ZTh8w3IMZ1JhRnuZFPk5NOxUi5pXVaf5gSMJEaaifSTafRLVKXbm
	0qR2hvuVxhxKsj11Q6FfvW+s2r1KC4ZIDsSn5csP4npEbdf73XN8tzNan9lRrGL98K04Fw0
	8qLsyoFOISWSVyMfDh9OdeZraHmVnXbI+9bkAZxtuXMrpduK7IR7gQ24fLk6oZW/4ROBT+9
	LSASzVjEuPa+3VlVHsJVjw78CMFRI2efQFujxlSp6TsJp6NfPnSycA/+eYlY20uGY6KyVID
	jGeUtIvUdhFaUjYwnUrj1r34SDnv/0jrTOTBnjoXC5BrADeQEVTrAJSBKE7Gp4O/5MzlDwr
	xkpJqUPh1t822g3iRWTNYcXaltUNvIxTk5fCiGTkCy/kOw4y9LON2/xQ22C7vi7yScZHx6w
	s1MguiS8vwGPV6/urCgZzXbTnI/5CEfwef690PLVb5+MY00pcpzhMgN2RMIILYnxHz12cII
	ri2DTQaBHLrOa42juO4Fe1fPFURV3UbadlyV0Fadux2rfZTppOgZ/aSeiTdmuhJDkTswsS2
	d6K0ImI1kiCymG6hw8R7UPuDOGaENUPYbGEeoYeCoPOoFAoskLt+tXNTp
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

Hi,

two correction,

On 12/11/24 07:10, FUKAUMI Naoki wrote:
> Hi Sebastian,
> 
> Thank you very much for your work!
> 
> $ cat /sys/class/power_supply/tcpm-source-psy-4-0022/ 
> {current_max,current_now,online,type,usb_type,voltage_max,voltage_min,voltage_now}
> 1500000
> 1500000
> 1
> USB
> C [PD] PD_PPS
> 20000000
> 20000000
> 20000000
> 
> $ cat /sys/class/power_supply/tcpm-source-psy-4-0022/ 
> {current_max,current_now,online,type,usb_type,voltage_max,voltage_min,voltage_now}
> 5000000
> 5000000
> 1
> USB
> C PD [PD_PPS]
> 20000000
> 20000000
> 20000000
> 
> $ ls /sys/class/udc/
> fc000000.usb
> 
> I can configure it as CDC-NCM and host detects it.
> But I could not use it as a HOST port. How to use it?
> 
> some minor nitpick is below:
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
> 
> typec_vin by schematic.
> 
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
> 
> typec_vin.
> 
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
> 
> Is "usbc0" label necessary?

please ignore, I noticed it's necessary for my work ;)

> 
>> +        compatible = "fcs,fusb302";
>> +        reg = <0x22>;
>> +        interrupt-parent = <&gpio3>;
>> +        interrupts = <RK_PB4 IRQ_TYPE_LEVEL_LOW>;
>> +        pinctrl-names = "default";
>> +        pinctrl-0 = <&usbc0_int>;
> 
> cc_int_l by schematic.
> 
>> +        vbus-supply = <&vcc12v_dcin>;
> 
> typec_vin
> 
>> +        /*
>> +         * When the board is starting to send power-delivery messages
>> +         * too late (5 seconds according to the specification), the
>> +         * power-supply reacts with a hard-reset. That removes the
>> +         * power from VBUS for some time, which resets te whole board.
> 
> ... resets "the" whole board.
> 
>> +         */
>> +        status = "fail";
>> +
>> +        usb_con: connector {
> 
> Is "usb_con" label necessary?

it's necessary for my work, but I think "usbc0_con" is consistent with 
others.

Best regards,

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

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
> 
> cc_int_l
> 
> Best regards,
> 
> -- 
> FUKAUMI Naoki
> Radxa Computer (Shenzhen) Co., Ltd.
> 
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


