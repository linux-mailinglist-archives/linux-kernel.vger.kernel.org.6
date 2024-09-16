Return-Path: <linux-kernel+bounces-331090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E68E97A84A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 22:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5D25B2A81C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 20:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8EA15DBC1;
	Mon, 16 Sep 2024 20:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pdFWBWb2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751714174A;
	Mon, 16 Sep 2024 20:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726518203; cv=none; b=WVpntj6l2RIU/fabvwVpXHA07Ohx/9AMDyPOXK1tewOnR9gu2csyKmx15mkGstKNTvld12HXDWVCGAr8pUovgDN/VnRZ2mOFIpsg4IwyHt33YgWqM7a51ILNl8RLYR/C7suG664QuOgZ9tdrpfyvOnYVTcbSnqLE0ZMTfNB/SZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726518203; c=relaxed/simple;
	bh=I+eYB9/iGpjy2fwoJ4YmiqEzyB8jdfZHLMIS00A1aRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s8miRLaHykjUfoPUcT/bVyZ4/Knt+Aid5/EwoYot5bujAgfo4r+kj3vxbymVywhPKi6a5Jft1g63f3klk9PC0GcdesagwSCU0xqDMd8AEE6Jixr3iOAh+mJwnMc1Avo1MmhNFSS8nKLT62vz0g/qgLTGPgcEgsd9l3YlT7cHs94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pdFWBWb2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFDC5C4CEC4;
	Mon, 16 Sep 2024 20:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726518202;
	bh=I+eYB9/iGpjy2fwoJ4YmiqEzyB8jdfZHLMIS00A1aRQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pdFWBWb20FdS4V997/xrw9O1dpeTWn7iVg3EaG0bBJlp641TvOOE9FodW2tSb2kNn
	 5WWRTQJqDGEWmzDb7/v5CWX79JqENsMOi5bgzGebQHgAr6OlSnjWpYIgjKKn2rs5OK
	 /emFMkVJBR8sZjQLDOvnRks5qvU7TSsh0SQLY1fZHkRDmLBB9pnLgxMy2FAwuvbW/F
	 +YBPZA1Lk5tcRx+W/q2nRtpx7aqvX+1hRfeqWlYDt3AaFXc+AegdozvcOnolpc4iE/
	 iTCeU/fAYiC5OUYeOzUetev+mLlykWKN/MGBYDs/cnPzRqFRHcTLZ5ecWi2Bz2BeTT
	 Q+C9zLXgUfTgQ==
Message-ID: <eb3ec7f1-388c-4613-b995-69b8ad6ef2c0@kernel.org>
Date: Mon, 16 Sep 2024 22:23:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: imx8: Fix lvds0 device tree
To: Diogo Silva <diogompaissilva@gmail.com>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
 aisheng.dong@nxp.com, Frank.Li@nxp.com
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240916200255.2566209-1-diogo.pais@ttcontrol.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240916200255.2566209-1-diogo.pais@ttcontrol.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/09/2024 22:02, Diogo Silva wrote:
> From: Diogo Silva <diogompaissilva@gmail.com>
> 
> Some clock output names on lvds0 device tree were duplicated from mipi1,
> which caused an -EEXIST when registering these clocks during probe.
> Also fixed the device naming to be consistent with lvds1.
> 
> Fixes: 0fba24b3b956 ("arm64: dts: imx8: add basic lvds0 and lvds1 subsystem")
> subsystem")

Broken tags. They do not line-brake, BTW.

> Signed-off-by: Diogo Silva <diogompaissilva@gmail.com>
> ---
>  .../boot/dts/freescale/imx8-ss-lvds0.dtsi     | 22 +++++++++----------
>  arch/arm64/boot/dts/freescale/imx8qm-mek.dts  |  4 ++--
>  .../boot/dts/freescale/imx8qm-ss-lvds.dtsi    | 20 ++++++++---------
>  3 files changed, 23 insertions(+), 23 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-lvds0.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-lvds0.dtsi
> index d00036204a8c..a4d94467039f 100644
> --- a/arch/arm64/boot/dts/freescale/imx8-ss-lvds0.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8-ss-lvds0.dtsi
> @@ -10,34 +10,34 @@ lvds0_subsys: bus@56240000 {
>  	#size-cells = <1>;
>  	ranges = <0x56240000 0x0 0x56240000 0x10000>;
>  
> -	qm_lvds0_lis_lpcg: qxp_mipi1_lis_lpcg: clock-controller@56243000 {
> +	lvds0_lis_lpcg: clock-controller@56243000 {
>  		compatible = "fsl,imx8qxp-lpcg";
>  		reg = <0x56243000 0x4>;
>  		#clock-cells = <1>;
> -		clock-output-names = "mipi1_lis_lpcg_ipg_clk";
> +		clock-output-names = "lvds0_lis_lpcg_ipg_clk";
>  		power-domains = <&pd IMX_SC_R_MIPI_1>;
>  	};
>  
> -	qm_lvds0_pwm_lpcg: qxp_mipi1_pwm_lpcg: clock-controller@5624300c {
> +	lvds0_pwm_lpcg: clock-controller@5624300c {
>  		compatible = "fsl,imx8qxp-lpcg";
>  		reg = <0x5624300c 0x4>;
>  		#clock-cells = <1>;
> -		clock-output-names = "mipi1_pwm_lpcg_clk",
> -				     "mipi1_pwm_lpcg_ipg_clk",
> -				     "mipi1_pwm_lpcg_32k_clk";
> +		clock-output-names = "lvds0_pwm_lpcg_clk",
> +				     "lvds0_pwm_lpcg_ipg_clk",
> +				     "lvds0_pwm_lpcg_32k_clk";
>  		power-domains = <&pd IMX_SC_R_MIPI_1_PWM_0>;
>  	};
>  
> -	qm_lvds0_i2c0_lpcg: qxp_mipi1_i2c0_lpcg: clock-controller@56243010 {
> +	lvds0_i2c0_lpcg: clock-controller@56243010 {
>  		compatible = "fsl,imx8qxp-lpcg";
>  		reg = <0x56243010 0x4>;
>  		#clock-cells = <1>;
> -		clock-output-names = "mipi1_i2c0_lpcg_clk",
> -				     "mipi1_i2c0_lpcg_ipg_clk";
> +		clock-output-names = "lvds0_i2c0_lpcg_clk",
> +				     "lvds0_i2c0_lpcg_ipg_clk";
>  		power-domains = <&pd IMX_SC_R_MIPI_1_I2C_0>;
>  	};
>  
> -	qm_pwm_lvds0: qxp_pwm_mipi_lvds1: pwm@56244000 {
> +	pwm_lvds0: pwm@56244000 {
>  		compatible = "fsl,imx8qxp-pwm", "fsl,imx27-pwm";
>  		reg = <0x56244000 0x1000>;
>  		clock-names = "ipg", "per";
> @@ -48,7 +48,7 @@ qm_pwm_lvds0: qxp_pwm_mipi_lvds1: pwm@56244000 {
>  		status = "disabled";
>  	};
>  
> -	qm_i2c0_lvds0: qxp_i2c0_mipi_lvds1: i2c@56246000 {
> +	i2c0_lvds0: i2c@56246000 {
>  		compatible = "fsl,imx8qxp-lpi2c", "fsl,imx7ulp-lpi2c";
>  		reg = <0x56246000 0x1000>;
>  		#address-cells = <1>;
> diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
> index 62203eed6a6c..f7b9b319a58a 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
> @@ -96,7 +96,7 @@ vdevbuffer: memory@90400000 {
>  
>  	lvds_backlight0: backlight-lvds0 {
>  		compatible = "pwm-backlight";
> -		pwms = <&qm_pwm_lvds0 0 100000 0>;
> +		pwms = <&pwm_lvds0 0 100000 0>;
>  		brightness-levels = <0 100>;
>  		num-interpolated-steps = <100>;
>  		default-brightness-level = <80>;
> @@ -541,7 +541,7 @@ &fec2 {
>  	status = "okay";
>  };
>  
> -&qm_pwm_lvds0 {
> +&pwm_lvds0 {

Why this cannot stay qm_pwm_lvds0? Are you sure nodes now have correct
order?



Best regards,
Krzysztof


