Return-Path: <linux-kernel+bounces-570602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FFEA6B25D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 01:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 994DC7AA2DA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 00:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D5F1EA84;
	Fri, 21 Mar 2025 00:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="fLl/ZWWt"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5063F2A1A4
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 00:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742517502; cv=none; b=lqLgGWrn/ERRg+jfYs3oZORZBNW6T2MgO3m7NjJVsnfOp/xc2o+a6Ri2uUgFVJ4ZcsH0nwZbnGKVMLRlTGDK1kmgsNsKY+MU2kpP/vZVqHiBhyNhECDTl6gyMQnPmp4DpeuQgvqtRDzDowhPLCdhrIYiFaMxyrDF/7aPcS8D/pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742517502; c=relaxed/simple;
	bh=QKt0cY+Zvq60xx1hE+ZOQIVIBfS1vWtHtndVif0lPJ4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=D81LRk2rjdq+TvtD3jCnhznvL3r50nb0OCv1g8aOOOUf3Ir33zugHiOv3AfFTF1feLRi5ZUIHQXisQcKZT/pqsjylYHqkqBfLTd7WnCARLm86Vt/cSLLvMShQbMKRkHyxA+w+lwII9mFzRSn0ZwKD05bdS3zTeAvD5yJwFus31E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=fLl/ZWWt; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1742517490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GMuBo8PBLUfzgvC250aHSwUK/V2T2NbkU69GBOnmW2k=;
	b=fLl/ZWWtMhHF3fP8xV9YZa93rMbwa0F4JQLtogL8oqHrMGi43rko/xOzhm0ZVHuuvWlH72
	lzZ1NFWA5Ghh4ZjpUL+xez9hLGhB3rVkMF4PjdiVGfumAV4g7TL4o9nvcPsa4QsDyQZfpH
	5YUvj79ZbvK+o3bbiyUhwC25tpR2ye2jtK6ZmRUEgSL8yl4FiLqfjpzSYR7CwUWc7sR9kS
	Rhh2Ngx/J5eGClE8/6j/HZIQJXQvO4p4UFD/NsF9d/nRDm+ihjwfCbmPRxElBXmRjp9+qX
	o57O6Frtcm9lx4Lm2kWc3fRj0gmgWb2aOwIFAGKa/W09P8/hnu8HThXh/stBsg==
Date: Fri, 21 Mar 2025 01:38:08 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Sam Edwards <cfsworks@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Daniel_Kukie=C5=82a?= <daniel@kukiela.pl>, Sven Rademakers
 <sven.rademakers@gmail.com>, Joshua Riek <jjriek@verizon.net>
Subject: Re: [PATCH] arm64: dts: rockchip: Allow Turing RK1 cooling fan to
 spin down
In-Reply-To: <20250315204852.1247992-1-CFSworks@gmail.com>
References: <20250315204852.1247992-1-CFSworks@gmail.com>
Message-ID: <e1cdc3a39b9201cb115b12b559899aee@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Sam,

On 2025-03-15 21:48, Sam Edwards wrote:
> The RK3588 thermal sensor driver only receives interrupts when a
> higher-temperature threshold is crossed; it cannot notify when the
> sensor cools back off. As a result, the driver must poll for 
> temperature
> changes to detect when the conditions for a thermal trip are no longer
> met. However, it only does so if the DT enables polling.
> 
> Before this patch, the RK1 DT did not enable polling, causing the fan 
> to
> continue running at the speed corresponding to the highest temperature
> reached.
> 
> Follow suit with similar RK3588 boards by setting a polling-delay of
> 1000ms, enabling the driver to detect when the sensor cools back off,
> allowing the fan speed to decrease as appropriate.
> 
> Fixes: 7c8ec5e6b9d6 ("arm64: dts: rockchip: Enable automatic fan
> control on Turing RK1")
> Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi
> b/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi
> index 6bc46734cc14..0270bffce195 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi
> @@ -214,6 +214,8 @@ rgmii_phy: ethernet-phy@1 {
>  };
> 
>  &package_thermal {
> +	polling-delay = <1000>;
> +
>  	trips {
>  		package_active1: trip-active1 {
>  			temperature = <45000>;

Thanks for the patch, it's looking good to me, with some related
thoughts below.  Please, feel free to include:

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

After a quick look at the RK3588 TRM Part 1, it seems possible
to actually generate additional interrupts when the TSADC channel
temperature readouts reach predefined low thresholds.  Moreover,
avoiding the polling would actually help the SoC cool down a tiny
bit faster, which makes it worth detailed investigation in my book,
despite not being used by the downstream kernel code.

