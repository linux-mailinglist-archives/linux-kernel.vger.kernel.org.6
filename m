Return-Path: <linux-kernel+bounces-216916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BF190A881
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 10:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3359A1C23077
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 08:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0EF19049B;
	Mon, 17 Jun 2024 08:33:38 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8463717F5;
	Mon, 17 Jun 2024 08:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718613218; cv=none; b=UGIhxLg/O9LIYQa9JHrvuprcx85uukv7F5rqMFo/koVjJy9UVr4iGnWdFFJv6SO//9KEb1KKjdQ4gCUmqKbuHYaIUP1oJ7aaeGOmB7181DGjDc3A32Aft59qB9x/V3CbG1Lt48HIUDpZrKdeCcKUToy3LyCOMcwDCbyP0m415PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718613218; c=relaxed/simple;
	bh=0/BABGy6hfYi/7BxxqO+erOXltp4K2v4Qmh0ZemLHEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sInFxyoBbMtSFktRQmgAvwR6gJKZa3ZGoH9lALVys/O6rSmFR0HRNV5l0tSZphbx6WULTgxy0z+HzyMX8LlA1li0+kEmF38eq+euOVZmXWbFDoZOLgSooaC8P0qF0PEHnKI+nDfZLZ7Rvyqfh5f9sYo3jxSvGqJz/tM6vq08KFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e8616c2.versanet.de ([94.134.22.194] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sJ7nY-0007XR-Me; Mon, 17 Jun 2024 10:33:08 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 Jacobe Zang <jacobe.zang@wesion.com>
Cc: nick@khadas.com, efectn@protonmail.com, jagan@edgeble.ai,
 dsimic@manjaro.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Jacobe Zang <jacobe.zang@wesion.com>
Subject:
 Re: [PATCH v2 5/5] arm64: dts: rockchip: Add cpufreq support to Khadas Edge2
Date: Mon, 17 Jun 2024 10:33:07 +0200
Message-ID: <5475817.tWeucmBOSa@diego>
In-Reply-To: <20240617071112.3133101-6-jacobe.zang@wesion.com>
References:
 <20240617071112.3133101-1-jacobe.zang@wesion.com>
 <20240617071112.3133101-6-jacobe.zang@wesion.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Jacobe Zang,

Am Montag, 17. Juni 2024, 09:11:12 CEST schrieb Jacobe Zang:
> This adjust CPU nodes on Khadas Edge2.
> 
> Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
> ---
>  .../arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts b/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
> index 7d7cc3e76838c..5fb15d3dc23e9 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
> @@ -160,34 +160,42 @@ vdd_3v3_sd: vdd-3v3-sd-regulator {
>  
>  &cpu_b0 {
>  	cpu-supply = <&vdd_cpu_big0_s0>;
> +	mem-supply = <&vdd_cpu_big0_mem_s0>;

as far as I remember there has not been any binding merged that declares
this supply. Thankfully following the double phandle below, the Edge2 is
designed to use the same regulator for the mem-supply, so special handling
isn't even needed.


Heiko


>  };
>  
>  &cpu_b1 {
>  	cpu-supply = <&vdd_cpu_big0_s0>;
> +	mem-supply = <&vdd_cpu_big0_mem_s0>;
>  };
>  
>  &cpu_b2 {
>  	cpu-supply = <&vdd_cpu_big1_s0>;
> +	mem-supply = <&vdd_cpu_big1_mem_s0>;
>  };
>  
>  &cpu_b3 {
>  	cpu-supply = <&vdd_cpu_big1_s0>;
> +	mem-supply = <&vdd_cpu_big1_mem_s0>;
>  };
>  
>  &cpu_l0 {
>  	cpu-supply = <&vdd_cpu_lit_s0>;
> +	mem-supply = <&vdd_cpu_lit_mem_s0>;
>  };
>  
>  &cpu_l1 {
>  	cpu-supply = <&vdd_cpu_lit_s0>;
> +	mem-supply = <&vdd_cpu_lit_mem_s0>;
>  };
>  
>  &cpu_l2 {
>  	cpu-supply = <&vdd_cpu_lit_s0>;
> +	mem-supply = <&vdd_cpu_lit_mem_s0>;
>  };
>  
>  &cpu_l3 {
>  	cpu-supply = <&vdd_cpu_lit_s0>;
> +	mem-supply = <&vdd_cpu_lit_mem_s0>;
>  };
>  
>  &combphy0_ps {
> @@ -208,7 +216,7 @@ &i2c0 {
>  	pinctrl-0 = <&i2c0m2_xfer>;
>  	status = "okay";
>  
> -	vdd_cpu_big0_s0: regulator@42 {
> +	vdd_cpu_big0_s0: vdd_cpu_big0_mem_s0: regulator@42 {
>  		compatible = "rockchip,rk8602";
>  		reg = <0x42>;
>  		fcs,suspend-voltage-selector = <1>;
> @@ -225,7 +233,7 @@ regulator-state-mem {
>  		};
>  	};
>  
> -	vdd_cpu_big1_s0: regulator@43 {
> +	vdd_cpu_big1_s0: vdd_cpu_big1_mem_s0: regulator@43 {
>  		compatible = "rockchip,rk8603", "rockchip,rk8602";
>  		reg = <0x43>;
>  		fcs,suspend-voltage-selector = <1>;
> 





