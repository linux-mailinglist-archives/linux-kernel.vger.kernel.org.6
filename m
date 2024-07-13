Return-Path: <linux-kernel+bounces-251519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE5B9305C7
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 15:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCD932825AE
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 13:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C717913667E;
	Sat, 13 Jul 2024 13:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="kL6YdSii"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A601BC37;
	Sat, 13 Jul 2024 13:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720878317; cv=none; b=Gd6rEu9ouGN2j1MoRRweaqs3r9r7lNDAiV7XLk9R+bpRdbwi+faFfIiBLVsyHL5jxkoaa9HDdhQTCgmgYKmCSf8SSC+301+l5uJ9xCMLlHetocfcBnAGr81cvQPubWO6mP/p80ObKiqMAzHe8QRSrs+W3VHZddNLClwWH061pEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720878317; c=relaxed/simple;
	bh=wTmhANUTKxzbkRLAiD6EM9V2OmeRcKr+gS/IOh0rAh0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=InqbMzoL/ArVo208TlRrUCKtPEYPT0mntCwr/+EySL/rdiHSwTFAfMZHnmNlajX/7Z/lZK3CTCc5PRrqTjb0cyeySY7bSjxK9Irwraz3kRsQsgFvD5wotlfF4sqjsB8efjv595qYpEikrQdE0QrxcFRJi+9I4trlN/pcQ5bVve8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=kL6YdSii; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1720878312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zBlJCTyiZARSLO/el6PG9PRmgYzh8nmB0faef8GxGsQ=;
	b=kL6YdSiiOUK8/Fs6887upub56bEbhnnMWZV/yxGjSE7y6QOZNDdYHysKbyXBgnm2yK23pb
	REFRZMwWc0QpSLCbriwQwgpMJsUeHGh+boiw57Em2kgTKpz0mpRu7UDtY7nw7LUH4DquBL
	Ndf2wQn3sq5WrURmf1VVc4TvMjS/avBfv/fJJYejXLNmsLhyBDL0mD/VeRxqQrtFPKoFvs
	bmkjErXXLA4PBpe7shnfxfunmPgUXEMC2+F+r22C9aFJG7LzYukpME18XJZULUrVJC5vFT
	SyXgg/wqlnG9PRBklOUupGSOUhqa/qWkwkQsFlVjFwitboLYZZxt6vpEvVzgqg==
Date: Sat, 13 Jul 2024 15:45:12 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Diederik de Haas <didi.debian@cknow.org>
Cc: Heiko Stuebner <heiko@sntech.de>, Alex Bee <knaerzche@gmail.com>,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Johan
 Jonker <jbx6244@gmail.com>, Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v3 1/2] arm64: dts: rockchip: Add sdmmc_ext for RK3328
In-Reply-To: <20240710132830.14710-3-didi.debian@cknow.org>
References: <20240710132830.14710-1-didi.debian@cknow.org>
 <20240710132830.14710-3-didi.debian@cknow.org>
Message-ID: <72718d8d02c25993c138567c96340792@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Diederik,

On 2024-07-10 15:28, Diederik de Haas wrote:
> From: Alex Bee <knaerzche@gmail.com>
> 
> RK3328 SoC has a fourth mmc controller called SDMMC_EXT. Some
> boards have sdio wifi connected to it. In order to use it
> one would have to add the pinctrls from sdmmc0ext group which
> is done on board level.
> 
> Signed-off-by: Alex Bee <knaerzche@gmail.com>
> Signed-off-by: Diederik de Haas <didi.debian@cknow.org>

Looking good to me, cross-referencing the RK3328 TRM and the downstream
RK3328 SoC dtsi checks out.  Though, it will remain inert in our 
codebase,
because no supported boards use it, but that's fine, we're still 
improving
the correctness of the RK3328 SoC dtsi.

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

> ---
>  arch/arm64/boot/dts/rockchip/rk3328.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> index b01efd6d042c..95c3f1303544 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> @@ -1036,6 +1036,20 @@ usb_host0_ohci: usb@ff5d0000 {
>  		status = "disabled";
>  	};
> 
> +	sdmmc_ext: mmc@ff5f0000 {
> +		compatible = "rockchip,rk3328-dw-mshc", "rockchip,rk3288-dw-mshc";
> +		reg = <0x0 0xff5f0000 0x0 0x4000>;
> +		interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&cru HCLK_SDMMC_EXT>, <&cru SCLK_SDMMC_EXT>,
> +			 <&cru SCLK_SDMMC_EXT_DRV>, <&cru SCLK_SDMMC_EXT_SAMPLE>;
> +		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
> +		fifo-depth = <0x100>;
> +		max-frequency = <150000000>;
> +		resets = <&cru SRST_SDMMCEXT>;
> +		reset-names = "reset";
> +		status = "disabled";
> +	};
> +
>  	usbdrd3: usb@ff600000 {
>  		compatible = "rockchip,rk3328-dwc3", "snps,dwc3";
>  		reg = <0x0 0xff600000 0x0 0x100000>;

