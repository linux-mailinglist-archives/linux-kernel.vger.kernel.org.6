Return-Path: <linux-kernel+bounces-251518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D97D49305C5
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 15:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93867281F37
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 13:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69D6137763;
	Sat, 13 Jul 2024 13:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="nPeMeDIA"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1963B13699F;
	Sat, 13 Jul 2024 13:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720877542; cv=none; b=nIuABID5pw6rEWfAqUaE+quYYj3R26xsfMd2Ql19RjS/luDvpd8g9vrIbuMDahBMTi8fAC7HvW4UPbsKzzBEQZKSzW7PUJfFYBTDry4apnXJT4RCI5hO1Tfzks0xZH3eRF2LP4JfUJAOISQ3owR55U7op+/8h2llnhoHZa7u7Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720877542; c=relaxed/simple;
	bh=7vJTLOSKsEXQcV+T2iHLq856lmYwkODA1Mmhnz5dkJ4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Rxvn7lJoIxyu7jUKYT4iMLf7pfmHZzni/VFCueJjdzwn/2qaJ+rLj/P4Jypzw8L7vgPiknW3GPyLewYZ8bGgOkZVTdoEv2+q/a/YB3AuTgyzd4HXYjIUusoMozdfEvlq+9PNW4WnIMvAOC9KJSgsB4vk0ui7s1XA76tPUh29ArY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=nPeMeDIA; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1720877530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gdsA/FWKhdawJ5GjAEMw4Scb4231JfvIGWeKzVvBLl0=;
	b=nPeMeDIAUE6dGEBgaCGnsMJooRVdoxUOL/1VdWuEZbO9L2D/GfinCwRWviD1f0wvImQ7JS
	HbPMVY1OXjAc6fImCZtxrGuFAzRj50Y2ywAGI8ZOYEJychIpRe5vW3P2zO9t59i0dNsxmH
	XZ978LBYKIHBQ9nWpE+R9DZHv4zPcjtHqD/OkMcGYTRw6Y+NucbB25PXFyXF4YdRtIE4au
	IWDASFLoBtBluKis5+Bt8N7ph0mytNMWD5iClw7hferXXA3p1Biwvw8ZfZVGptT/KlNjJK
	OYMGlUCP87MSnfT4x7JpTkzoU0wlcDxaXlnxuch/DuGDGVMHnYE/us0TdUVQQg==
Date: Sat, 13 Jul 2024 15:32:09 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Diederik de Haas <didi.debian@cknow.org>
Cc: Heiko Stuebner <heiko@sntech.de>, Alex Bee <knaerzche@gmail.com>,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Johan
 Jonker <jbx6244@gmail.com>, Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v3 2/2] arm64: dts: rockchip: Add sdmmc/sdio/emmc reset
 controls for RK3328
In-Reply-To: <20240710132830.14710-4-didi.debian@cknow.org>
References: <20240710132830.14710-1-didi.debian@cknow.org>
 <20240710132830.14710-4-didi.debian@cknow.org>
Message-ID: <2b8fc2a116900bae9b30fa3225235b3c@manjaro.org>
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
> The DW MCI controller driver will use them to reset the IP block before
> initialisation.
> 
> Fixes: d717f7352ec6 ("arm64: dts: rockchip: add sdmmc/sdio/emmc nodes
> for RK3328 SoCs")
> Signed-off-by: Alex Bee <knaerzche@gmail.com>
> Signed-off-by: Diederik de Haas <didi.debian@cknow.org>

Looking good to me, cross-referencing the RK3328 TRM checks out.

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

> ---
>  arch/arm64/boot/dts/rockchip/rk3328.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> index 95c3f1303544..16b4faa22e4f 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> @@ -910,6 +910,8 @@ sdmmc: mmc@ff500000 {
>  		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
>  		fifo-depth = <0x100>;
>  		max-frequency = <150000000>;
> +		resets = <&cru SRST_MMC0>;
> +		reset-names = "reset";
>  		status = "disabled";
>  	};
> 
> @@ -922,6 +924,8 @@ sdio: mmc@ff510000 {
>  		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
>  		fifo-depth = <0x100>;
>  		max-frequency = <150000000>;
> +		resets = <&cru SRST_SDIO>;
> +		reset-names = "reset";
>  		status = "disabled";
>  	};
> 
> @@ -934,6 +938,8 @@ emmc: mmc@ff520000 {
>  		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
>  		fifo-depth = <0x100>;
>  		max-frequency = <150000000>;
> +		resets = <&cru SRST_EMMC>;
> +		reset-names = "reset";
>  		status = "disabled";
>  	};

