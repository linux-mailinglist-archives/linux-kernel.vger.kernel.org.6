Return-Path: <linux-kernel+bounces-294108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B4395893C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 16:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05E8B2834C5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 14:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333D219068E;
	Tue, 20 Aug 2024 14:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="ZkmOkAzx"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C60383AB;
	Tue, 20 Aug 2024 14:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724164094; cv=none; b=DgkbIHblEqIY1j2DRnnyfGacChd+adBsTAM5/s6fDXkBnsEBLNjSbXkQ4Zb3TU+LFbEdhTdyLHg8iwpcjfKth/Xp1HTdlD+hyqtTRb8EXWIAyml0YE+5xw9zFiCqIu31CzMRk9uXiY277keLK9LfuZlFt/ThLVQlnp6VfKKmHm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724164094; c=relaxed/simple;
	bh=ukMPiHOl7oYGp2sbGZsrdLagBKSNnlfQb6DxRCNG0EI=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=HP2Cm/y5cwcorMeyakUY5sMx5QudhoQXLCarWgyQZ4xMeMGuz7S8i+bFnsHBkuaUWcZYDej8Qr46545LbJhPJwbXDzopAblYHSIeZaypaTGVxRp2jnUYcVbgkRauBKDz3eoluJTZEhFa9huYVn61wgdzJsnR9oF/UD0IPbJso60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=ZkmOkAzx; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1724164088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9lfYG8mLMZ0ToEvfuDohOV6aiGyWEujUFWVDSC8D4ic=;
	b=ZkmOkAzx5YgLBlN0MF2JuKRo4gFfSBd7vX2rvvXuZL42jDBVELJnS9jK0H+Y8dduyFGbJy
	iK7fGLYfh41uP/+Xu8HeVbszC/OW+ROrVDC0vSGHFGls2LUgnYXe95ImNBKXIhPh/CZKhX
	IO3u0N7QbRf7+sdw5gBWqFVfkagCqT8gSXY39Yn/cn/fCwpVJSBpNdzR1NkNyPyEpmylnM
	ppZYZvTHcNI49BZez2pJpNYBwt9eMHE73rTKY+MIcaa3WXPzTAXCpFb61M/+qozADXgZ9g
	S85XQMEcoNzU/ClrIs+4nJ2LCRo0LpuVQcCvZmzOG/Fvl76pdMHx25SxgXWiIQ==
Date: Tue, 20 Aug 2024 16:28:07 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: Heiko Stuebner <heiko@sntech.de>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] arm64: dts: rockchip: disable display subsystem only
 for Radxa E25
In-Reply-To: <20240820120020.469375-1-amadeus@jmu.edu.cn>
References: <20240820120020.469375-1-amadeus@jmu.edu.cn>
Message-ID: <16c70a037d912ec88eb9c082f35100c6@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Chukun,

On 2024-08-20 14:00, Chukun Pan wrote:
> The SoM board has reserved HDMI output, while the Radxa E25
> is not connected. So disable the display subsystem only for
> Radxa E25.
> 
> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>

Looking good to me, thanks for the patch.  The carrier board is what's
responsible for exposing the actual HDMI port from the SoM.

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

> ---
>  arch/arm64/boot/dts/rockchip/rk3568-radxa-cm3i.dtsi | 4 ----
>  arch/arm64/boot/dts/rockchip/rk3568-radxa-e25.dts   | 4 ++++
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-radxa-cm3i.dtsi
> b/arch/arm64/boot/dts/rockchip/rk3568-radxa-cm3i.dtsi
> index 45b03dcbbad4..19d309654bdb 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3568-radxa-cm3i.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3568-radxa-cm3i.dtsi
> @@ -108,10 +108,6 @@ &cpu3 {
>  	cpu-supply = <&vdd_cpu>;
>  };
> 
> -&display_subsystem {
> -	status = "disabled";
> -};
> -
>  &gpu {
>  	mali-supply = <&vdd_gpu>;
>  	status = "okay";
> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-radxa-e25.dts
> b/arch/arm64/boot/dts/rockchip/rk3568-radxa-e25.dts
> index 72ad74c38a2b..84a0789fad96 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3568-radxa-e25.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3568-radxa-e25.dts
> @@ -103,6 +103,10 @@ &combphy1 {
>  	phy-supply = <&vcc3v3_pcie30x1>;
>  };
> 
> +&display_subsystem {
> +	status = "disabled";
> +};
> +
>  &pcie2x1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pcie20_reset_h>;

