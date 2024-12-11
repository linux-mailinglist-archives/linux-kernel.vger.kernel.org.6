Return-Path: <linux-kernel+bounces-440526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF309EBFCB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 01:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAC31168AC8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 00:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53C323BE;
	Wed, 11 Dec 2024 00:08:01 +0000 (UTC)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16971800;
	Wed, 11 Dec 2024 00:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733875681; cv=none; b=oY7GiLyqpsSrMtQtt4DIrIwtbmVJAX/udgp4n3TvlBxzy9EZLd1h7qCiNFo8nmgswIwJFzkmB+7U0NFM2stVSxpjwvdQffaYNK2TyZ/UL7UDyo2y3TDVThY6C7jaXr3Zkka9Axi5/Nxx3M0/USM+qwJmUeRbdKwKeshZLLjRVQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733875681; c=relaxed/simple;
	bh=qK41Zq0Ox31j32cDGZVsuLmEPodZPDuFp2kkgxjcMSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OAW0a2tCrRs0ZuOGvc6ZI5kAPAGoKisBAKm2zT6Lb1w0OKixCWwG0Ua/1hpSJiBi2APsAKNcE5TUxIJNtl/9ERbsES72awg4XnY8BSYNIkwGDC+J0FjxjWUAF5LeNh5yq+fpTzNabb/bg36+ByDZN/WOLC9FIz9z9chvCyDqHh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: bizesmtpip4t1733875606t5783zp
X-QQ-Originating-IP: +QpbvVfji3FgQlhoNaZ9PZUgVU6r82YCc3DKa8pNyw8=
Received: from [IPV6:240f:10b:7440:1:9e54:d32d ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 11 Dec 2024 08:06:40 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8105054081483660745
Message-ID: <FFD6E87BED20DB1B+38b8064e-9945-4cd8-a30e-7800a8c6f37b@radxa.com>
Date: Wed, 11 Dec 2024 09:06:40 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] arm64: dts: rockchip: Add USB-C support to ROCK 5B
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Heiko Stuebner <heiko@sntech.de>
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com
References: <20241210163615.120594-1-sebastian.reichel@collabora.com>
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
In-Reply-To: <20241210163615.120594-1-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:radxa.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NcmC868q55ANP+uVZNkM4pMFhRBlor2mlxbV8ObJX+7lHSYHJne0ObUx
	ekj4K3hwhdGQjed/nOw30TNneRm3xgju2neuzjBv55y0OQFnSYR3OVzlpC2n1ZPD04qtPT8
	92NSebK8f9nV/eS7D2F5smysS2xrhfr/II6LjfaiVCa2gFjLxNVv1eYAq2T+Jo58HUqDpCn
	Dt8/7U5UUcYIQof672lhI15VK0oEyeODpw0FXvKPyXzjGXWMiHVb7Al0HkWkun2sV3HUoIU
	ZMGCfhi5CHmaqFQbtcnT0KfzxasFxWfRTWG7S+k7b8EMwB8jvSN5Gl3419gxmggFYxiqTCg
	/Q38grkhqhTAb2RKhZFqNNHE35ivN7ewmdNAlTUoGrPaF/aKIvdunx4AkTh+CiEyzFoPhT8
	tWE6QSMVfNoGFDumsik0GdQm1iOfeu194dNf8yle8ocHjEqxRNRlOCQMsHY7H4XQ7QkhXYR
	RvFMaJ7YO7NW7UvvEE7fZrmN71Fmitc4FKrjOEea+mYB2OPnwitf02CBAEYT5zU+/NBuS9n
	O4TVx+n3XmGUw8vFpMhXL3NHylBM+ieNkUz0NrAE1RCgkawPGcMgmeNsCND997BIcvRCnfm
	z0MPJFBLgOEZRIzf1AATq/StNl5S4naoox/Ow9AtDarbU9b3xT5/pZkJtONnfLYkcKhnaY+
	fBH2JFkv9x8OJRrFXL1+2cDerJ2AzZNlLI+pe7Sb2rBOfgTRtUOfiKcxpdyagCuUN5S9rJo
	v7tHlPkWOnDRKVXG7eTmDEn715Zm18ErbJJEjxfGM5DEK2SHhseSIoASZyUvUjuuFsaaNQA
	lYF7uIqrQzMyhWxg/BaLeXtsA6U5Hf7Ets5/Gfc8+pLfYqdbX3zYm3ZV3SRR4vpHJlkmeYv
	7o/ItojUTH4z/j46dmbMilFPWY6WSBs2KYajHi6fNElWTHowIeSSiuP7gqO5s2Cd0Uldp7s
	mBpIouJY/kD+IfcxURXF656Ke7k9M3wSeDV8/NM0f9kcjDXPJjghT/M8bJcuLEot8r+Y=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

Sorry, I forgot to write one thing...

On 12/11/24 01:36, Sebastian Reichel wrote:
> Add hardware description for the USB-C port in the Radxa Rock 5 Model B.
> This describes the OHCI, EHCI and XHCI USB parts, but not yet the
> DisplayPort AltMode (bindings are not yet upstream).
> 
> The fusb302 node is marked with status "fail", since the board is usually
> powered through the USB-C port. Handling of errors can result in hard
> resets, which removed the bus power for some time resulting in a board
> reset.
> 
> The main problem is that devices are supposed to interact with the
> power-supply within 5 seconds after the plug event according to the
> USB PD specification. This is more or less impossible to achieve when
> the kernel is the first software communicating with the power-supply.
> 
> Recent U-Boot (v2025.01) will start doing USB-PD communication, which
> solves this issue. Upstream U-Boot doing USB-PD communication will also
> set the fusb302 node status to "okay". That way booting a kernel with
> the updated DT on an old U-Boot avoids a reset loop.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Tested-by: FUKAUMI Naoki <naoki@radxa.com>

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

> ---
>   .../boot/dts/rockchip/rk3588-rock-5b.dts      | 121 ++++++++++++++++++
>   1 file changed, 121 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> index d597112f1d5b..cb5990df6ccb 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> @@ -5,6 +5,7 @@
>   #include <dt-bindings/gpio/gpio.h>
>   #include <dt-bindings/leds/common.h>
>   #include <dt-bindings/soc/rockchip,vop2.h>
> +#include <dt-bindings/usb/pd.h>
>   #include "rk3588.dtsi"
>   
>   / {
> @@ -84,6 +85,15 @@ rfkill-bt {
>   		shutdown-gpios = <&gpio3 RK_PD5 GPIO_ACTIVE_HIGH>;
>   	};
>   
> +	vcc12v_dcin: regulator-vcc12v-dcin {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc12v_dcin";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <12000000>;
> +		regulator-max-microvolt = <12000000>;
> +	};
> +
>   	vcc3v3_pcie2x1l0: regulator-vcc3v3-pcie2x1l0 {
>   		compatible = "regulator-fixed";
>   		enable-active-high;
> @@ -142,6 +152,7 @@ vcc5v0_sys: regulator-vcc5v0-sys {
>   		regulator-boot-on;
>   		regulator-min-microvolt = <5000000>;
>   		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&vcc12v_dcin>;
>   	};
>   
>   	vcc_1v1_nldo_s3: regulator-vcc-1v1-nldo-s3 {
> @@ -264,6 +275,67 @@ regulator-state-mem {
>   	};
>   };
>   
> +&i2c4 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c4m1_xfer>;
> +	status = "okay";
> +
> +	usbc0: usb-typec@22 {
> +		compatible = "fcs,fusb302";
> +		reg = <0x22>;
> +		interrupt-parent = <&gpio3>;
> +		interrupts = <RK_PB4 IRQ_TYPE_LEVEL_LOW>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&usbc0_int>;
> +		vbus-supply = <&vcc12v_dcin>;
> +		/*
> +		 * When the board is starting to send power-delivery messages
> +		 * too late (5 seconds according to the specification), the
> +		 * power-supply reacts with a hard-reset. That removes the
> +		 * power from VBUS for some time, which resets te whole board.
> +		 */
> +		status = "fail";
> +
> +		usb_con: connector {
> +			compatible = "usb-c-connector";
> +			label = "USB-C";
> +			data-role = "dual";
> +			power-role = "sink";
> +			try-power-role = "sink";
> +			op-sink-microwatt = <1000000>;
> +			sink-pdos =
> +				<PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>,
> +				<PDO_VAR(5000, 20000, 5000)>;
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;
> +					usbc0_role_sw: endpoint {
> +						remote-endpoint = <&dwc3_0_role_switch>;
> +					};
> +				};
> +
> +				port@1 {
> +					reg = <1>;
> +					usbc0_orien_sw: endpoint {
> +						remote-endpoint = <&usbdp_phy0_orientation_switch>;
> +					};
> +				};
> +
> +				port@2 {
> +					reg = <2>;
> +					dp_altmode_mux: endpoint {
> +						remote-endpoint = <&usbdp_phy0_dp_altmode_mux>;
> +					};
> +				};
> +			};
> +		};
> +	};
> +};
> +
>   &i2c6 {
>   	status = "okay";
>   
> @@ -423,6 +495,10 @@ usb {
>   		vcc5v0_host_en: vcc5v0-host-en {
>   			rockchip,pins = <4 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
>   		};
> +
> +		usbc0_int: usbc0-int {
> +			rockchip,pins = <3 RK_PB4 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
>   	};
>   };
>   
> @@ -835,6 +911,14 @@ &uart2 {
>   	status = "okay";
>   };
>   
> +&u2phy0 {
> +	status = "okay";
> +};
> +
> +&u2phy0_otg {
> +	status = "okay";
> +};
> +
>   &u2phy1 {
>   	status = "okay";
>   };
> @@ -866,6 +950,29 @@ &usbdp_phy1 {
>   	status = "okay";
>   };
>   
> +&usbdp_phy0 {
> +	mode-switch;
> +	orientation-switch;
> +	sbu1-dc-gpios = <&gpio4 RK_PA6 GPIO_ACTIVE_HIGH>;
> +	sbu2-dc-gpios = <&gpio4 RK_PA7 GPIO_ACTIVE_HIGH>;
> +	status = "okay";
> +
> +	port {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		usbdp_phy0_orientation_switch: endpoint@0 {
> +			reg = <0>;
> +			remote-endpoint = <&usbc0_orien_sw>;
> +		};
> +
> +		usbdp_phy0_dp_altmode_mux: endpoint@1 {
> +			reg = <1>;
> +			remote-endpoint = <&dp_altmode_mux>;
> +		};
> +	};
> +};
> +
>   &usb_host0_ehci {
>   	status = "okay";
>   };
> @@ -874,6 +981,20 @@ &usb_host0_ohci {
>   	status = "okay";
>   };
>   
> +&usb_host0_xhci {
> +	usb-role-switch;
> +	status = "okay";
> +
> +	port {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		dwc3_0_role_switch: endpoint {
> +			remote-endpoint = <&usbc0_role_sw>;
> +		};
> +	};
> +};
> +
>   &usb_host1_ehci {
>   	status = "okay";
>   };


