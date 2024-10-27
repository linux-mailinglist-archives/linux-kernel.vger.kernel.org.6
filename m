Return-Path: <linux-kernel+bounces-383871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A59C69B2128
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 23:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EC822814C6
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 22:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818B4189F20;
	Sun, 27 Oct 2024 22:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="PcYLK+ty"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4C318871A;
	Sun, 27 Oct 2024 22:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730069569; cv=none; b=i31MFMgZLUqwbRkVNSjYffMtIxvRf2cic2IMBurYy7U3HyQqx3BF+4l6xi52XIAQD7qiOTM3Yy81S2UgBOQVMuUCe2VjY913/nL75jUkrGTybecoOPRSAlShrKb3vZGcKCuY8Jt76HXKUy5/fg0CAY8OKX12WQnscnBhLOCRvTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730069569; c=relaxed/simple;
	bh=8Zm5MjZ8zaSPXSP0fhK2I0ghqIIU2RPotYegaZLnZUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZR3xTeqZwuvxF96BVCxWVa5WGLCajnJugHbu9aONpV3PHs3h5xIuPKa8GZNh4QPxD5yQ8B2FKKFKUeGSn1cyo/pczv8nusmxd9dqirw87QhjaCJ0qNk6aQsAVqD4z3nwYaYmCPYMYum6TZK1CHJgaTJ0grCy8psgDq+dH8NvQ2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=PcYLK+ty; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1730069239; bh=8Zm5MjZ8zaSPXSP0fhK2I0ghqIIU2RPotYegaZLnZUw=;
	h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
	b=PcYLK+tykd5DXK6UAW1uAKNzSwdgN0bb20OIhaDMlm6umHy1gO0DAdPGBEV+dCbki
	 noVA/7EVjEXZkcOeJ38sCieKfrfUb/Nkg+RMKo0SacO7c4bgGcEcEP7c2GdsL/G/Eu
	 gXG+kdMN3iv0RW1ROMmu281Z3/iXv5Af/d3Obe7k=
Date: Sun, 27 Oct 2024 23:47:19 +0100
From: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>, Chen-Yu Tsai <wens@csie.org>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: orangepi-5-plus: Enable USB 3.0
 ports
Message-ID: <pe2ornjaqn24i7e3x64rfdtqbp2c347mc5okgj5y6bfvkwnv6z@jux5yei3vxxa>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, 
	Chen-Yu Tsai <wens@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Chen-Yu Tsai <wens@csie.org>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20241025175415.887368-1-wens@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025175415.887368-1-wens@kernel.org>

Hello Chen-Yu,

On Sat, Oct 26, 2024 at 01:54:15AM GMT, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
> 
> The Orange Pi 5 Plus has its first USB 3.0 interface on the SoC wired
> directly to the USB type C port next to the MASKROM button, and the
> second interface wired to a USB 3.0 hub which in turn is connected to
> the USB 3.0 host ports on the board, as well as the USB 2.0 connection
> on the M.2 E-key slot.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

CCing the DTS author would be nice. :)

Thanks for submitting this. I found a few issues. See below:

> ---
>  .../dts/rockchip/rk3588-orangepi-5-plus.dts   | 132 ++++++++++++++++++
>  1 file changed, 132 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts b/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
> index dd03c9db6953..b826c5e368aa 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
> @@ -177,6 +177,18 @@ daicodec: simple-audio-card,codec {
>  		};
>  	};
>  
> +	vbus_typec: vbus-typec-regulator {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpio = <&gpio4 RK_PB0 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&typec5v_pwren>;
> +		regulator-name = "vbus_typec";

This is named vbus5v0_typec in the schematic.

> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&vcc5v0_sys>;
> +	};
> +
>  	vcc3v3_pcie30: vcc3v3-pcie30-regulator {
>  		compatible = "regulator-fixed";
>  		enable-active-high;
> @@ -339,6 +351,56 @@ &i2c6 {
>  	clock-frequency = <400000>;
>  	status = "okay";
>  
> +	usbc0: usb-typec@22 {
> +		compatible = "fcs,fusb302";
> +		reg = <0x22>;
> +		interrupt-parent = <&gpio0>;
> +		interrupts = <RK_PD3 IRQ_TYPE_LEVEL_LOW>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&usbc0_int>;
> +		vbus-supply = <&vbus_typec>;
> +		status = "okay";
> +
> +		usb_con: connector {
> +			compatible = "usb-c-connector";
> +			label = "USB-C";
> +			data-role = "dual";
> +			op-sink-microwatt = <1000000>;
> +			power-role = "dual";
> +			sink-pdos =
> +				<PDO_FIXED(5000, 1000, PDO_FIXED_USB_COMM)>;

The board can't sink power from this port. It's a source only port. So sink-pdos
can be lower, so that if you plug this into type-c hub as a peripheral, the hub
doesn't need to reserve 5W for this port.

op-sink-microwat can also be lower. The port will not sink any power when
connected to 5V VBUS externally.

Otherwise you can probably keep power-role = "dual";

> +			source-pdos =
> +				<PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;

This port can't source 3A. U22 (SY6280AAC) is configured via Rset for 1.44A
limit. So let's say 1.5A.

> +			try-power-role = "source";
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;
> +					usbc0_hs: endpoint {
> +						remote-endpoint = <&usb_host0_xhci_drd_sw>;
> +					};
> +				};
> +
> +				port@1 {
> +					reg = <1>;
> +					usbc0_ss: endpoint {
> +						remote-endpoint = <&usbdp_phy0_typec_ss>;
> +					};
> +				};
> +
> +				port@2 {
> +					reg = <2>;
> +					usbc0_sbu: endpoint {
> +						remote-endpoint = <&usbdp_phy0_typec_sbu>;
> +					};
> +				};
> +			};
> +		};
> +	};
> +
>  	hym8563: rtc@51 {
>  		compatible = "haoyu,hym8563";
>  		reg = <0x51>;
> @@ -480,6 +542,16 @@ vcc5v0_usb20_en: vcc5v0-usb20-en {
>  			rockchip,pins = <3 RK_PB7 RK_FUNC_GPIO &pcfg_pull_none>;
>  		};
>  	};
> +
> +	usb-typec {
> +		usbc0_int: usbc0-int {
> +			rockchip,pins = <0 RK_PD3 RK_FUNC_GPIO &pcfg_pull_up>;
> +		};
> +
> +		typec5v_pwren: typec5v-pwren {
> +			rockchip,pins = <4 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
>  };
>  
>  &pwm2 {
> @@ -871,6 +943,22 @@ &tsadc {
>  	status = "okay";
>  };
>  
> +&u2phy0 {
> +	status = "okay";
> +};
> +
> +&u2phy0_otg {
> +	status = "okay";
> +};
> +
> +&u2phy1 {
> +	status = "okay";
> +};
> +
> +&u2phy1_otg {

Needs:
	phy-supply = <&vcc5v0_host>;

> +	status = "okay";
> +};
> +
>  &u2phy2 {
>  	status = "okay";
>  };
> @@ -899,6 +987,33 @@ &uart9 {
>  	status = "okay";
>  };
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
> +		usbdp_phy0_typec_ss: endpoint@0 {
> +			reg = <0>;
> +			remote-endpoint = <&usbc0_ss>;
> +		};
> +
> +		usbdp_phy0_typec_sbu: endpoint@1 {
> +			reg = <1>;
> +			remote-endpoint = <&usbc0_sbu>;
> +		};
> +	};
> +};
> +
> +&usbdp_phy1 {
> +	status = "okay";
> +};
> +
>  &usb_host0_ehci {
>  	status = "okay";
>  };
> @@ -907,6 +1022,18 @@ &usb_host0_ohci {
>  	status = "okay";
>  };
>  
> +&usb_host0_xhci {
> +	dr_mode = "otg";

This is the default. No need to have it here.

Kind regards,
	o.

> +	usb-role-switch;
> +	status = "okay";
> +
> +	port {
> +		usb_host0_xhci_drd_sw: endpoint {
> +			remote-endpoint = <&usbc0_hs>;
> +		};
> +	};
> +};
> +
>  &usb_host1_ehci {
>  	status = "okay";
>  };
> @@ -915,6 +1042,11 @@ &usb_host1_ohci {
>  	status = "okay";
>  };
>  
> +&usb_host1_xhci {
> +	dr_mode = "host";
> +	status = "okay";
> +};
> +
>  &vop_mmu {
>  	status = "okay";
>  };
> -- 
> 2.39.5
> 

