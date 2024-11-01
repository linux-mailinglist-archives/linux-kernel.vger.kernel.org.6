Return-Path: <linux-kernel+bounces-391709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E80999B8A9F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 06:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A783B2825DA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 05:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9851494BB;
	Fri,  1 Nov 2024 05:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linumiz.com header.i=@linumiz.com header.b="ZZ4my0jo"
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F85B14885D
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 05:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730439202; cv=none; b=jqvJsLHv4Nk82fEgN843bAV76exkrdUgTSX7RJep6wM9D8FH4M/cx/B5q7UmkjQDg8U1owH/2NHGNasGQAgoEniua8H96TkZ1TesO7J4qy0wMYTqsj/2fQxCYte/8X4rIQ3/LiDt4AB7IzyW9FYYJBJGpEhyvFrCUqh11VKFlXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730439202; c=relaxed/simple;
	bh=D4TJEIOyYSwiDdug5OMtrVlk3hwp/FEe6gmeAbaC37c=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fGo10bbJBfl7kwUgGr4XdHE5kdl46bAYvs6qyJj1Z2oXxQGejBJBfzJrFLZHpXrwlw4fuygWPGh45qgOig/6d+rUXGD9u3aX8tH2akIbipSXcfkhCOaLXSek1A9DJocEM4I0SB2PVP3rFOJ0R7AB4PT1uYeHXfiL3NCI7b+u1NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linumiz.com; spf=pass smtp.mailfrom=linumiz.com; dkim=pass (2048-bit key) header.d=linumiz.com header.i=@linumiz.com header.b=ZZ4my0jo; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linumiz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linumiz.com
Received: from eig-obgw-5005a.ext.cloudfilter.net ([10.0.29.234])
	by cmsmtp with ESMTPS
	id 6YFDtBfAnqvuo6kHdtXfcz; Fri, 01 Nov 2024 05:33:18 +0000
Received: from md-in-79.webhostbox.net ([43.225.55.182])
	by cmsmtp with ESMTPS
	id 6kHbttlWcjcdm6kHctul16; Fri, 01 Nov 2024 05:33:17 +0000
X-Authority-Analysis: v=2.4 cv=DrWd+3/+ c=1 sm=1 tr=0 ts=6724681d
 a=LfuyaZh/8e9VOkaVZk0aRw==:117 a=kofhyyBXuK/oEhdxNjf66Q==:17
 a=IkcTkHD0fZMA:10 a=VlfZXiiP6vEA:10 a=-pn6D5nKLtMA:10 a=6Ujbnq6iAAAA:8
 a=vU9dKmh3AAAA:8 a=uXP6E58horQQbnEz6SkA:9 a=QEXdDO2ut3YA:10
 a=-sNzveBoo8RYOSiOai2t:22 a=rsP06fVo5MYu2ilr0aT5:22 a=ZCPYImcxYIQFgLOT52_G:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=linumiz.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KsIO27gsMFDVvdSYn96XeM2cN2MZTMmCMSsPkFkYeNg=; b=ZZ4my0joR3FM9GiojirEbvrQMi
	kacs17UJsIZgN7r0skFbn6kKVskk8xzdoj1k+crQIMRt8lsStrGfey27QnS35DwsBn9zNJfGRP1X5
	P+D2d044aw5ZSYYALvJwfRZy+NyXZvHWXqFhZMsnfKqVxBDDKExElwDuyuxnqyZIcIoP7q+Ihfe39
	+ow3nZKgE4/yk3an+6nxEG7NOsi0nrWAKNQ3R9k5b2b1SIpnu9A5EJaKylN71msYHzO5zIkkbvHHF
	Kfyn8lFW0LRQI7r7n5AbDVONZxL+C72WTCnbGqYPSm5wOPv1nWYYYIXain+H+yT1jyiYxHuI/z0A5
	/rRVTnew==;
Received: from [122.165.245.213] (port=35224 helo=[192.168.1.5])
	by md-in-79.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <parthiban@linumiz.com>)
	id 1t6kHS-002KJ3-32;
	Fri, 01 Nov 2024 11:03:06 +0530
Message-ID: <d38ff4ee-27a6-48ef-8429-15f59230de46@linumiz.com>
Date: Fri, 1 Nov 2024 11:03:02 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: parthiban@linumiz.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Maxime Ripard <mripard@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Nishanth Menon <nm@ti.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Vinod Koul <vkoul@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Yangtao Li <tiny.windzz@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/13] arm64: dts: allwinner: a100: add usb related
 nodes
To: Cody Eksal <masterr3c0rd@epochal.quest>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>
References: <20241031070232.1793078-1-masterr3c0rd@epochal.quest>
 <20241031070232.1793078-7-masterr3c0rd@epochal.quest>
Content-Language: en-US
From: Parthiban <parthiban@linumiz.com>
Organization: Linumiz
In-Reply-To: <20241031070232.1793078-7-masterr3c0rd@epochal.quest>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - md-in-79.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linumiz.com
X-BWhitelist: no
X-Source-IP: 122.165.245.213
X-Source-L: No
X-Exim-ID: 1t6kHS-002KJ3-32
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.5]) [122.165.245.213]:35224
X-Source-Auth: parthiban@linumiz.com
X-Email-Count: 1
X-Org: HG=dishared_whb_net_legacy;ORG=directi;
X-Source-Cap: bGludW1jbWM7aG9zdGdhdG9yO21kLWluLTc5LndlYmhvc3Rib3gubmV0
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfP5XstjljNPBArJUEmwxYodrJLna8UqlV1OUfZ//3OO1eSPuteisZAmbfCRQRwQxjiggUkf4btCiUyM+dI6frS1JojNFCloavFHEu5lUEgpqLgX6aX0A
 xpq1HJo2+Mj2b3q02Ty7Xz/HmZ7EtH6ePDM9nDnmFoLo+9s4LxLbHdfFtRruMEM9nGeVJoNTbSQM0nqVX4m5b+rMvBwBUSM6d5w=

On 10/31/24 12:32 PM, Cody Eksal wrote:
> From: Yangtao Li <frank@allwinnertech.com>
> 
> The Allwinner A100 has two HCI USB controllers, a OTG controller and a
> USB PHY. The PHY is compatible with that used by the D1, while the OTG
> controller is compatible with the A33. Add nodes for these to the base
> DTSI.
> 
> Signed-off-by: Yangtao Li <frank@allwinnertech.com>
> [masterr3c0rd@epochal.quest: fallback to a33-musb and d1-usb-phy, edited message]
> Signed-off-by: Cody Eksal <masterr3c0rd@epochal.quest>
Peripheral mode works after disabling ehci0 and ohci0. Otherwise,

Tested-by: Parthiban Nallathambi <parthiban@linumiz.com>

Thanks,
Parthiban
> ---
> Changes in V2:
>  - Fix sizes of reg definitions in usbphy
>  - Move #phy-cells to the end of usbphy
>  - Order nodes by MMIO address
>  - Remove dr_mode
> 
>  .../arm64/boot/dts/allwinner/sun50i-a100.dtsi | 91 +++++++++++++++++++
>  1 file changed, 91 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
> index adb11b26045f..f6162a107641 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
> @@ -302,6 +302,97 @@ ths: thermal-sensor@5070400 {
>  			#thermal-sensor-cells = <1>;
>  		};
>  
> +		usb_otg: usb@5100000 {
> +			compatible = "allwinner,sun50i-a100-musb",
> +				     "allwinner,sun8i-a33-musb";
> +			reg = <0x05100000 0x0400>;
> +			clocks = <&ccu CLK_BUS_OTG>;
> +			resets = <&ccu RST_BUS_OTG>;
> +			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "mc";
> +			phys = <&usbphy 0>;
> +			phy-names = "usb";
> +			extcon = <&usbphy 0>;
> +			status = "disabled";
> +		};
> +
> +		usbphy: phy@5100400 {
> +			compatible = "allwinner,sun50i-a100-usb-phy",
> +				     "allwinner,sun20i-d1-usb-phy";
> +			reg = <0x05100400 0x100>,
> +			      <0x05101800 0x100>,
> +			      <0x05200800 0x100>;
> +			reg-names = "phy_ctrl",
> +				    "pmu0",
> +				    "pmu1";
> +			clocks = <&ccu CLK_USB_PHY0>,
> +				 <&ccu CLK_USB_PHY1>;
> +			clock-names = "usb0_phy",
> +				      "usb1_phy";
> +			resets = <&ccu RST_USB_PHY0>,
> +				 <&ccu RST_USB_PHY1>;
> +			reset-names = "usb0_reset",
> +				      "usb1_reset";
> +			status = "disabled";
> +			#phy-cells = <1>;
> +		};
> +
> +		ehci0: usb@5101000 {
> +			compatible = "allwinner,sun50i-a100-ehci",
> +				     "generic-ehci";
> +			reg = <0x05101000 0x100>;
> +			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&ccu CLK_BUS_OHCI0>,
> +				 <&ccu CLK_BUS_EHCI0>,
> +				 <&ccu CLK_USB_OHCI0>;
> +			resets = <&ccu RST_BUS_OHCI0>,
> +				 <&ccu RST_BUS_EHCI0>;
> +			phys = <&usbphy 0>;
> +			phy-names = "usb";
> +			status = "disabled";
> +		};
> +
> +		ohci0: usb@5101400 {
> +			compatible = "allwinner,sun50i-a100-ohci",
> +				     "generic-ohci";
> +			reg = <0x05101400 0x100>;
> +			interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&ccu CLK_BUS_OHCI0>,
> +				 <&ccu CLK_USB_OHCI0>;
> +			resets = <&ccu RST_BUS_OHCI0>;
> +			phys = <&usbphy 0>;
> +			phy-names = "usb";
> +			status = "disabled";
> +		};
> +
> +		ehci1: usb@5200000 {
> +			compatible = "allwinner,sun50i-a100-ehci",
> +				     "generic-ehci";
> +			reg = <0x05200000 0x100>;
> +			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&ccu CLK_BUS_OHCI1>,
> +				 <&ccu CLK_BUS_EHCI1>,
> +				 <&ccu CLK_USB_OHCI1>;
> +			resets = <&ccu RST_BUS_OHCI1>,
> +				 <&ccu RST_BUS_EHCI1>;
> +			phys = <&usbphy 1>;
> +			phy-names = "usb";
> +			status = "disabled";
> +		};
> +
> +		ohci1: usb@5200400 {
> +			compatible = "allwinner,sun50i-a100-ohci",
> +				     "generic-ohci";
> +			reg = <0x05200400 0x100>;
> +			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&ccu CLK_BUS_OHCI1>,
> +				 <&ccu CLK_USB_OHCI1>;
> +			resets = <&ccu RST_BUS_OHCI1>;
> +			phys = <&usbphy 1>;
> +			phy-names = "usb";
> +			status = "disabled";
> +		};
> +
>  		r_ccu: clock@7010000 {
>  			compatible = "allwinner,sun50i-a100-r-ccu";
>  			reg = <0x07010000 0x300>;


