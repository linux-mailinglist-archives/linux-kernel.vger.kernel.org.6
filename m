Return-Path: <linux-kernel+bounces-557716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F317A5DCD1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43A067A10FB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 12:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C38B243374;
	Wed, 12 Mar 2025 12:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Df38IDxa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71A924292E;
	Wed, 12 Mar 2025 12:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741783164; cv=none; b=Pyr4J8E/wdX7NiEUYg/WitUE3J1fq+FccvH0lr8/ayYtU1qElnkG1j86/t0wobWa/bBhh1Ga7gigWmThKU3pkIQeyM+hRVrcmLP6pOAfIJY7BaNafLp3TUqodINxxeOHC1ZyV27BmKQsdS4IkhGNW8UPypZoRXGL4YbsdjAJMNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741783164; c=relaxed/simple;
	bh=qXP7e9cKm6PJkk8q6/yjyEe53myvFFMcXHURqJ4AGdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GDj4UpAYYJ/Er7369o8DsHwoHo38lvQbR5TnirQVMY8o0yDRV+VhQ7NvqYKzXFxBhQw1zjFl7Fy8FI6I6yf2wJRp7YU4HAbQmcwSpgvrB1qXWyW7E5geeWP1lv76ZgWksK2s8aHctoELYCFCwo+9ixmlHSdx421DxLN+1CJhRQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Df38IDxa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 498D8C4CEEC;
	Wed, 12 Mar 2025 12:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741783164;
	bh=qXP7e9cKm6PJkk8q6/yjyEe53myvFFMcXHURqJ4AGdU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Df38IDxapPmYq0zj8nu7ZQSbnwY8pnZmSMx0hk57NPggET6m5SxqoxMxvXfCLiYbE
	 7hSCkbEnTKrJYxlafMpI/CqdqAJG0QsoOrfR7kyQa6ClWUpNPrklWixAZ2P5LAYAO2
	 f3O2VROq161I6dyFkTroLnTQIs5f2/G+PP6aH1JQ1WXw/b2t1QRqBT7pqoJtsAGakz
	 VQxCAqC6tamSVx7P7/huVu/RjNohRfFOjijFn/TbbO8L9X2DikiCEGls1om9xW8zP3
	 O2W7Y0MPNVHSxavqmiXHrAPqY9GFXEtQ8D/7/8bEpCjMkWaUEY0jDcBw0pwAl7Ixua
	 6j18oVK5zQZiw==
Date: Wed, 12 Mar 2025 14:39:17 +0200
From: Dmitry Baryshkov <lumag@kernel.org>
To: Andy Yan <andyshrk@163.com>
Cc: heiko@sntech.de, hjc@rock-chips.com, mripard@kernel.org, 
	cristian.ciocaltea@collabora.com, neil.armstrong@linaro.org, yubing.zhang@rock-chips.com, 
	krzk+dt@kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	robh@kernel.org, sebastian.reichel@collabora.com, 
	Andy Yan <andy.yan@rock-chips.com>
Subject: Re: [PATCH v2 7/7] arm64: dts: rockchip: Enable DP2HDMI for ROCK 5
 ITX
Message-ID: <q3y36jgswj4xa2g3hnptc6kgzphbqfg675r5paa2lwvdseytio@jysj4f2i6osu>
References: <20250312104214.525242-1-andyshrk@163.com>
 <20250312104214.525242-8-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312104214.525242-8-andyshrk@163.com>

On Wed, Mar 12, 2025 at 06:42:08PM +0800, Andy Yan wrote:
> From: Andy Yan <andy.yan@rock-chips.com>
> 
> The HDMI Port next to Headphone Jack is drived by
> DP1 on rk3588 via a dp2hdmi converter.
> 
> Add related dt nodes to enable it.
> 
> Note: ROCKCHIP_VOP2_EP_DP1 is defined as 11 in dt-binding header,
> but it will trigger a dtc warning like "graph node unit address
> error, expected "b"" if we use it directly after endpoint, so we
> use "b" instead here.
> 
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> ---
> 
> (no changes since v1)
> 
>  .../boot/dts/rockchip/rk3588-rock-5-itx.dts   | 37 +++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dts
> index 67b886329248..29f10ec9f0c1 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dts
> @@ -57,6 +57,18 @@ analog-sound {
>  			  "Headphone", "Headphones";
>  	};
>  
> +	dp-con {
> +		compatible = "dp-connector";

You've written that it is an HDMI connector. Could you possibly clarify,
why is it being registered as a DP connector? Is there any kind of
a bridge between the DP controller and the HDMI connector?

> +		label = "DP OUT";
> +		type = "full-size";
> +
> +		port {
> +			dp_con_in: endpoint {
> +				remote-endpoint = <&dp1_out_con>;
> +			};
> +		};
> +	};
> +
>  	gpio-leds {
>  		compatible = "gpio-leds";
>  		pinctrl-names = "default";
> @@ -268,6 +280,24 @@ &cpu_l3 {
>  	cpu-supply = <&vdd_cpu_lit_s0>;
>  };
>  
> +&dp1 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&dp1m0_pins>;
> +};
> +
> +&dp1_in {
> +	dp1_in_vp2: endpoint {
> +		remote-endpoint = <&vp2_out_dp1>;
> +	};
> +};
> +
> +&dp1_out {
> +	dp1_out_con: endpoint {
> +		remote-endpoint = <&dp_con_in>;
> +	};
> +};
> +
>  &gpu {
>  	mali-supply = <&vdd_gpu_s0>;
>  	status = "okay";
> @@ -1262,3 +1292,10 @@ vp1_out_hdmi1: endpoint@ROCKCHIP_VOP2_EP_HDMI1 {
>  		remote-endpoint = <&hdmi1_in_vp1>;
>  	};
>  };
> +
> +&vp2 {
> +	vp2_out_dp1: endpoint@b {
> +		reg = <ROCKCHIP_VOP2_EP_DP1>;
> +		remote-endpoint = <&dp1_in_vp2>;
> +	};
> +};
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

