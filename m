Return-Path: <linux-kernel+bounces-309283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8145C96687D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 19:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FAF7285592
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 17:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0541BBBD1;
	Fri, 30 Aug 2024 17:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=timsurber.de header.i=@timsurber.de header.b="MgYECC4u"
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31291BB6AA;
	Fri, 30 Aug 2024 17:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725040672; cv=none; b=UITnVCsRN4aG6LNsGQKJmZM3xl4B2JFmJaU1ZbDU7pRsqCZseLFHhaJvDbTZpZfPptOk6CKw4jsLIaPr9OZvq943VWREHAHoKLYwlg3dOgieA6NTaDAkNrK80mnveG/XeVun35/NCWpwkwdjqwOvNtO8RDaA/mJW0C/Bw6z9Ujc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725040672; c=relaxed/simple;
	bh=5vQbUdosrU/yTRdTrAox/PElYAJjmCmVJzOlgIjGJTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l99f3GWYfthduGiL5DVjbUMQ+HpFXKo/J8y2cHTU88yIx3P1xO7v9nV+ZvIdlnlrEYPGwvoOkvbVG4zcLtejCwHhrfFzUFRbIifL+f+MOxtVXM8kIOm56LaFFjyewWuckCEVfu3TN7bD8HMMW/j+Mho8yB4jSidNTX6DAqOQgVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=timsurber.de; spf=pass smtp.mailfrom=timsurber.de; dkim=pass (2048-bit key) header.d=timsurber.de header.i=@timsurber.de header.b=MgYECC4u; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=timsurber.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=timsurber.de
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4WwQpq3GlZz9spR;
	Fri, 30 Aug 2024 19:57:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=timsurber.de;
	s=MBO0001; t=1725040659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rcXqt0dYIT9vRx69oGyb9WwTkuVz/EwOMSocKSZQGlM=;
	b=MgYECC4utjEgVJSCS+UumB4MPCY/YW4L6q4p0FNVeCzidHhxVjefQlEqGGykmcVMMnbeAU
	81IDHm16l3ILUnbwxFRh6SbePow2F2JwmwX7XDu0uPRP2MoM9BJKTnjenpWQg1pyKlr7SU
	s2HmeXXoD2UWMzXru/bOiJZOiFszPcUKPL4dyt+iWg91apiCgZJU+Y1NE4/2ATEcUCtPr4
	yt5AZi7NiZFeaYyvt4IFjfCMVEU4j1N4oynnnxCvYOWuGjN/e0wkjWAPNr71Ud2fA5OLSx
	Vn1h29Q8rxzAm2rWkWRwYYS9iKR6YEoRFpDQohhdGhq9pOFRQZbiwsROf47cAw==
Message-ID: <f7f30cbc-1bae-440e-b6e5-d50f2deb8847@timsurber.de>
Date: Fri, 30 Aug 2024 19:57:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/2] arm64: dts: rockchip: Add RGA2 support to rk3588
To: Jianfeng Liu <liujianfeng1994@gmail.com>,
 linux-rockchip@lists.infradead.org
Cc: Diederik de Haas <didi.debian@cknow.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240604163408.1863080-1-liujianfeng1994@gmail.com>
 <20240604163408.1863080-3-liujianfeng1994@gmail.com>
Content-Language: en-US
From: Tim Surber <me@timsurber.de>
In-Reply-To: <20240604163408.1863080-3-liujianfeng1994@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4WwQpq3GlZz9spR

Hi Jianfeng,

I've tested RGA2 now for a while on a RK3588 board and it works correctly.

Of course it has to be updated and moved to probably rk3588-base.dtsi now.

With this done:

Tested-by: Tim Surber <me@timsurber.de>

Best regards,

Tim Surber

On 04.06.24 18:34, Jianfeng Liu wrote:
> RK3588 also features a RGA2 block. Add the necessary device tree
> node.
>
> Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
>
> ---
>
> Changes in v2:
> - Sort node by bus-address based on next-20240604
>
>   arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 11 +++++++++++
>   1 file changed, 11 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> index 6ac5ac8b48a..beebc4dc0e7 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> @@ -1159,6 +1159,17 @@ power-domain@RK3588_PD_SDMMC {
>   		};
>   	};
>   
> +	rga: rga@fdb80000 {
> +		compatible = "rockchip,rk3588-rga", "rockchip,rk3288-rga";
> +		reg = <0x0 0xfdb80000 0x0 0x180>;
> +		interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH 0>;
> +		clocks = <&cru ACLK_RGA2>, <&cru HCLK_RGA2>, <&cru CLK_RGA2_CORE>;
> +		clock-names = "aclk", "hclk", "sclk";
> +		resets = <&cru SRST_RGA2_CORE>, <&cru SRST_A_RGA2>, <&cru SRST_H_RGA2>;
> +		reset-names = "core", "axi", "ahb";
> +		power-domains = <&power RK3588_PD_VDPU>;
> +	};
> +
>   	av1d: video-codec@fdc70000 {
>   		compatible = "rockchip,rk3588-av1-vpu";
>   		reg = <0x0 0xfdc70000 0x0 0x800>;

