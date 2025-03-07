Return-Path: <linux-kernel+bounces-552120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E350AA575FA
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 00:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDEE37A7F69
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 23:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C9825A326;
	Fri,  7 Mar 2025 23:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="Bi5LUqWl"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914E1258CF7
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 23:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741389789; cv=none; b=ccfJTcGJ0sFxjAOoHzWoRaSWuHqxHt1oI3csTMihz1bTbfcyBPMqSzcq514BdH8qyBwhjI4aVxL6xn5jbl0kH+QIc6ncEzUCMijVBRoIH8ZkKhXHBie9GgaDlH1iHsRCWSx6zTcPL8tpE0Hx0MwLPzduHQcl1m4P4kNGJdXgr5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741389789; c=relaxed/simple;
	bh=G7ePHamfmNO0BgmpReDWmfPU5PII/oFI2xQp7oy/HtM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=okEMuucNrt9rhfYKwSdyo6PyCHYsVIUqCMKdURQP8YumJpZ2B4iO5lEn+w38lR9HqO/7aHy+6ReTfqV1+vf1CHRnSzLEolNocu9iNSdH0CL+uCh21YOeeC6F/SQZ5/cncoqMPd9gCmFVK4NDNQE49TX6UjYUaaAVRwySLRCeHrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=Bi5LUqWl; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1741389780;
 bh=Fhjx6pxvag6i+ct5LgrY68O1Q0Fj9xs6220lz64mf6E=;
 b=Bi5LUqWlzHT22EkHM7b0GggX1/NAB2T0lSgvTCrf/3Xbi2rA7pfjh0yRb/dGoxAxH9hVv5+AU
 xzdDPfk9q7exBwV7fD1qLuZL/7zjBNvUo7HuvlodhO8a2EG5Y+8Iv9pgUNmsVdl5F32UcyjwzhM
 K/myxKA2ijF4GtMCY8g8hLPge8yXzMAjJmEShHVfLrSME+FfYp2YgDI4kF755d8381m+QZ+drO9
 FBFpRmfTk7OtAAWfeXy0TzDMPGDga9AYVZ9UArsp+Dic4CeZpO6SqezGcDIW8l+PVu94547oN8/
 hD+RkDrcxhqdDYq7yxpqJPxLt4f2wKwIdZ/8ayN46cJw==
X-Forward-Email-ID: 67cb7fcd789af4fdcbb0e87f
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <56181131-3e48-4c76-87c7-2388a9964727@kwiboo.se>
Date: Sat, 8 Mar 2025 00:22:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] arm64: dts: rockchip: Add SDMMC/SDIO controllers
 for RK3528
To: Yao Zi <ziyao@disroot.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Shresth Prasad <shresthprasad7@gmail.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Detlev Casanova <detlev.casanova@collabora.com>,
 Chukun Pan <amadeus@jmu.edu.cn>, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org
References: <20250305194217.47052-1-ziyao@disroot.org>
 <20250305194612.47171-1-ziyao@disroot.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250305194612.47171-1-ziyao@disroot.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Yao Zi,

On 2025-03-05 20:46, Yao Zi wrote:
> RK3528 features two SDIO controllers and one SD/MMC controller, describe
> them in devicetree. Since their sample and drive clocks are located in
> the VO and VPU GRFs, corresponding syscons are added to make these
> clocks available.
> 
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---
>  arch/arm64/boot/dts/rockchip/rk3528.dtsi | 70 ++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3528.dtsi b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
> index d3e2a64ff2d5..363023314e9c 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3528.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
> @@ -130,6 +130,16 @@ gic: interrupt-controller@fed01000 {
>  			#interrupt-cells = <3>;
>  		};
>  
> +		vpu_grf: syscon@ff340000 {
> +			compatible = "rockchip,rk3528-vpu-grf", "syscon";
> +			reg = <0x0 0xff340000 0x0 0x8000>;
> +		};
> +
> +		vo_grf: syscon@ff360000 {
> +			compatible = "rockchip,rk3528-vo-grf", "syscon";
> +			reg = <0x0 0xff360000 0x0 0x10000>;
> +		};
> +
>  		cru: clock-controller@ff4a0000 {
>  			compatible = "rockchip,rk3528-cru";
>  			reg = <0x0 0xff4a0000 0x0 0x30000>;
> @@ -274,6 +284,66 @@ saradc: adc@ffae0000 {
>  			resets = <&cru SRST_P_SARADC>;
>  			reset-names = "saradc-apb";
>  			#io-channel-cells = <1>;
> +		};

Look like this patch accidentally drops status = "disabled" from the
adc@ffae0000 node.

Regards,
Jonas

> +
> +		sdio0: mmc@ffc10000 {
> +			compatible = "rockchip,rk3528-dw-mshc",
> +				     "rockchip,rk3288-dw-mshc";
> +			reg = <0x0 0xffc10000 0x0 0x4000>;
> +			clocks = <&cru HCLK_SDIO0>,
> +				 <&cru CCLK_SRC_SDIO0>,
> +				 <&cru SCLK_SDIO0_DRV>,
> +				 <&cru SCLK_SDIO0_SAMPLE>;
> +			clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
> +			fifo-depth = <0x100>;
> +			interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
> +			max-frequency = <150000000>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&sdio0_bus4>, <&sdio0_clk>, <&sdio0_cmd>,
> +				    <&sdio0_det>, <&sdio0_pwren>;
> +			resets = <&cru SRST_H_SDIO0>;
> +			reset-names = "reset";
> +			status = "disabled";
> +		};
> +
> +		sdio1: mmc@ffc20000 {
> +			compatible = "rockchip,rk3528-dw-mshc",
> +				     "rockchip,rk3288-dw-mshc";
> +			reg = <0x0 0xffc20000 0x0 0x4000>;
> +			clocks = <&cru HCLK_SDIO1>,
> +				 <&cru CCLK_SRC_SDIO1>,
> +				 <&cru SCLK_SDIO1_DRV>,
> +				 <&cru SCLK_SDIO1_SAMPLE>;
> +			clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
> +			fifo-depth = <0x100>;
> +			interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
> +			max-frequency = <150000000>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&sdio1_bus4>, <&sdio1_clk>, <&sdio1_cmd>,
> +				    <&sdio1_det>, <&sdio1_pwren>;
> +			resets = <&cru SRST_H_SDIO1>;
> +			reset-names = "reset";
> +			status = "disabled";
> +		};
> +
> +		sdmmc: mmc@ffc30000 {
> +			compatible = "rockchip,rk3528-dw-mshc",
> +				     "rockchip,rk3288-dw-mshc";
> +			reg = <0x0 0xffc30000 0x0 0x4000>;
> +			clocks = <&cru HCLK_SDMMC0>,
> +				 <&cru CCLK_SRC_SDMMC0>,
> +				 <&cru SCLK_SDMMC_DRV>,
> +				 <&cru SCLK_SDMMC_SAMPLE>;
> +			clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
> +			fifo-depth = <0x100>;
> +			interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
> +			max-frequency = <150000000>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&sdmmc_bus4>, <&sdmmc_clk>, <&sdmmc_cmd>,
> +				    <&sdmmc_det>;
> +			resets = <&cru SRST_H_SDMMC0>;
> +			reset-names = "reset";
> +			rockchip,default-sample-phase = <90>;
>  			status = "disabled";
>  		};
>  


