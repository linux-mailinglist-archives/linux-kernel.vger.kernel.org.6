Return-Path: <linux-kernel+bounces-531609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1820DA442BF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D834A189267D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846C126A0A4;
	Tue, 25 Feb 2025 14:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="Z1X26bi7"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB1A126C18;
	Tue, 25 Feb 2025 14:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740493565; cv=none; b=mOGDfmiMAa0jrFSORDM4Glp584scycujEsIrlfz6LZFZYB26S5JXbIPGw22ok1wWTA0zVheZHoj87lHJ75xsgbJjPAW0+eaXZr4/FztIUYeQyCaRtVZwNvTR73sqFdh7vK5NDTysSI2ZEFshs2ae/6xTWudTunCOuZf4pCfMGm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740493565; c=relaxed/simple;
	bh=362uBNCJSL6/D4zf+C/aqFC5d3W5hFLgF8NaryGLpW4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=a272LvG0xyLMzt4f4cT/vmpZ0EDKdsZZeWNpNXoPXIquGjKRw6w7IufFAQp54OmsRqxSWLnAMaYdRgO4V7UPz/LVTgaxfxCGLL1YKkrNc+bS5+sgYSnrliY0W7/cWto83KlmILfSKNfXGwtiMJLtuAGLwm4maWhQBfZZzvrDEtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=Z1X26bi7; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1740493553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WyyxfZ8er5WqZOvIZ6mxo74JK7+5Nk5jVOc6g/QyEzY=;
	b=Z1X26bi7ygLBS3+YP89D2JR7/QWR7eXXN3q1RGtCQ3+EEEyHxoYQpXbp52wPDrgNXaWacW
	Ounh1eXsGBBwxBLd/7Di5n93VbT9HhQvf9jl6Vim2qNKGD88nD/ML295fQfTRkhorE6Uh1
	y9/DreYBRT9Ekl/916EWFharGXpsOWZAg8lKC7+bIk95ZpLm9A2QquEqUmFbsIvtuqNN1C
	4ZcGeWx8hn/TuKWiLzmG9cjzglaqrwc+FI0Mp947mgR3+gwUWye4wIzhBT3xLoaC/9pm3l
	jLiZSSPJRpbr5cs+7oCYYjNE6rHgNRvYE+JeSFarEusZ3TABB7gKfJhq1GWuSg==
Date: Tue, 25 Feb 2025 15:25:52 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Justin Klaassen <justin@tidylabs.net>
Cc: Tianling Shen <cnsztl@gmail.com>, Kever Yang
 <kever.yang@rock-chips.com>, Johan Jonker <jbx6244@gmail.com>, Heiko
 Stuebner <heiko@sntech.de>, Conor Dooley <conor+dt@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: fix u2phy1_host status for NanoPi
 R4S
In-Reply-To: <20250224170925.39126-1-justin@tidylabs.net>
References: <20250224170925.39126-1-justin@tidylabs.net>
Message-ID: <48c705e65cc8e8d4716b41a4a87170e3@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Justin,

Thanks for the patch!  Please, see a few comments below.

On 2025-02-24 18:09, Justin Klaassen wrote:
> The u2phy1_host should always have the same status as usb_host1_ehci,
> otherwise the ehci driver may be initialized for a disabled usb port.
> 
> Signed-off-by: Justin Klaassen <justin@tidylabs.net>
> ---
>  arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dtsi
> b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dtsi
> index b1c9bd0e63ef..8d94d9f91a5c 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dtsi
> @@ -115,7 +115,7 @@ &u2phy0_host {
>  };
> 
>  &u2phy1_host {
> -	status = "disabled";
> +	phy-supply = <&vdd_5v>;
>  };
> 
>  &uart0 {

Indeed, the rk3399-nanopi4.dtsi file, which rk3399-nanopi-r4s.dtsi
extends, enables u2phy1_host, usb_host1_ehci and usb_host1_ohci,
so disabling u2phy1_host in rk3399-nanopi-r4s.dtsi makes no sense.

After checking the NanoPi R4S schematic, I can confirm that the
phy-supply references the right regulator.  There are some strange
things in the schematic, but they're unrelated to this patch.

However, there should be a v2 of this patch with the proper Fixes
and CC: stable tags, so this bugfix also gets propagated into the
long-term kernels.  Please, feel free to also include

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

