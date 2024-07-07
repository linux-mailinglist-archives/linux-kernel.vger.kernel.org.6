Return-Path: <linux-kernel+bounces-243736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB9A9299D0
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 23:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C66541F21525
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 21:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1436A6F2E0;
	Sun,  7 Jul 2024 21:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="AiZRnWd1"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CD41D52B;
	Sun,  7 Jul 2024 21:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720387423; cv=none; b=IW9v2MgRpUfPaewSj5QkESbswvMlmz9ZM6j+QjKiUBTU69G6M3OZ7VxFgsVPWXTzW2+NHTbVrd1s80GekshnlCkB/6iGFQbb9/lATfhlINq6DTHAdDCu5/0P259laRptuPYRHURwt/FGwbRPgBGJSLeRFtHMrcFs9Bg8LKXbfU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720387423; c=relaxed/simple;
	bh=iXENnuUzS4oyzom10Ti7DPkCgMhu/FRBNPg/lAqJRjk=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=JChuiFCnj9DD384ELLA2sJnm/YZNSlVVhYqxUDaZEHqLYFiAM9unmAGLfQ787S5RJcH33dPBCRQIbiK3Q2hucMcbId/2y96Sbxxmzlx/0Dw0YqxZj01+kp/3yvNgJ6UHhlIj8LHltRGts4Ep6r19ceff3u4YUyG+q81dFFO1rWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=AiZRnWd1; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1720387411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SbDqxtlfTjjwVsq4VbK1kprB7ccA8aGj5XdW5T2ZQN0=;
	b=AiZRnWd13UqUtBGbzOOOmxVrw18Du3ZsLIh18sIWWJ3dLfeQnYX/mSTxlB82iPD72aj13u
	ZRO1yTm2orjUxDMYs1SfVQkzR91lPZiwfa/WYmKVGBmV71PTBr43Ykr2YwHmfVqcD9j7Yv
	13gSdaPo3OsFbiWDs0BGnsvjPqMLWHI9pI59I5WJTweqXKxS+zV/SSX2X5NXBoiVPdbCF+
	Wiyw0x0TVddnoIQHDOCv1sTTUBtlA1w+7SO1xM59wtOpkMKcIwG94K+boZLmpJRFFoZiCW
	pyURBk+bxbHU/zFTpEI1KA5dzpIN25LI0lkhMMbkxWYrcyUxna5CA+ptF+Fmqw==
Date: Sun, 07 Jul 2024 23:23:30 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Diederik de Haas <didi.debian@cknow.org>
Cc: Heiko Stuebner <heiko@sntech.de>, Alex Bee <knaerzche@gmail.com>,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Add avdd supplies to hdmi on rock64
In-Reply-To: <20240704191919.38856-1-didi.debian@cknow.org>
References: <20240704191919.38856-1-didi.debian@cknow.org>
Message-ID: <31a86ec073e1de9e0241845f8783cd6b@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Diederik,

Please see some comments below.

On 2024-07-04 21:18, Diederik de Haas wrote:
> Pine64's Rock64 was missing the avdd supply properties on the hdmi 
> node,
> causing the following warnings:
> 
>   dwhdmi-rockchip ff3c0000.hdmi: supply avdd-0v9 not found, using
> dummy regulator
>   dwhdmi-rockchip ff3c0000.hdmi: supply avdd-1v8 not found, using
> dummy regulator
> 
> In the Rock64 Schematic document version 2.0 those supplies are marked
> as DVIDEO_AVDD_1V0 and DVIDEO_AVDD_1V8 respectively, but in version 3.0
> those are named HDMI_AVDD_1V0 and HDMI_AVDD_1V8, which is a bit 
> clearer.
> In both versions those are connected to LDO3 and LDO1 respectively.
> 
> While the DeviceTree property is named 'avdd-0v9-supply' the
> 'rockchip,dw-hdmi.yaml' binding document notes the following:
> 
>   A 0.9V supply that powers up the SoC internal circuitry. The actual
>   pin name varies between the different SoCs and is usually
>   HDMI_TX_AVDD_0V9 or sometimes HDMI_AVDD_1V0.
> 
> So the 'vdd_10' reference is not an error.
> 
> Signed-off-by: Diederik de Haas <didi.debian@cknow.org>

Already verified the above-quoted statement from the .yaml binding
in the RK3328 and RK3399 datasheets.  Thus, hoping that you agree
with the first line:

Helped-by: Dragan Simic <dsimic@manjaro.org>
Reviewed-by: Dragan Simic <dsimic@manjaro.org>

I'd also suggest that a brief comment is added to rk3328-rock64.dts,
right above the "avdd-0v9-supply = <&vdd_10>;" line.  Perhaps something
like this:

> +	/*
> +	 * RK3328 requires 1.0 V on HDMI_AVDD_1V0, which is HDMI_AVDD_0V9
> +	 * and requires 0.9 V on other Rockchip SoCs
> +	 */

> ---
>  arch/arm64/boot/dts/rockchip/rk3328-rock64.dts | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
> b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
> index 229fe9da9c2d..90fef766f3ae 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
> @@ -154,6 +154,8 @@ &gmac2io {
>  };
> 
>  &hdmi {
> +	avdd-0v9-supply = <&vdd_10>;
> +	avdd-1v8-supply = <&vcc_18>;
>  	status = "okay";
>  };

