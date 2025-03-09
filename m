Return-Path: <linux-kernel+bounces-553306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAE8A58737
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 19:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC2A6188C9A4
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 18:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158FE1EF398;
	Sun,  9 Mar 2025 18:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="GcNwFK5o"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8C11F4CBF
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 18:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741544629; cv=none; b=NpvwmaPGwFqbTbZ2Q59Fwk+L3ceref6q5Ra1HVpW1Wb78RFnwTja8liCoLpuPhELcPyc0Yh0s3XlQdHZ2bm2AY6+H62FTT1pFQ/iQsG+9O3QHM2Qde5RYaXyR9GGKlCfgvhHBOONi+/350UPtVGnPkRK+W//fcFnUENxkLCcsYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741544629; c=relaxed/simple;
	bh=8Q7sl7SWDPeMdadS7RKEQ5Zh375kbNERL8UHvLuI61o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NSOWhc31rgEI5zMOH/1VPr/lC+LAYAWNH+PCOw5mPv/vrCgHL1j6e3b4FPteAasWVsoBiYzXI56DuzKRhie0V0h8d2KeQl1TZE2BF0RebwUxMuvNodgtiO5fivPs+5tX090stvC0iRNu7TbUsVXvmmKjLXa6WF2inTmPyn1kojo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=GcNwFK5o; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1741544621;
 bh=QvnfGlC40UQmnKcl5OF0pRINHPgf7NC49WGBsWl3pAM=;
 b=GcNwFK5oDUTLQbqhDrBhp/jcrTvPnBR4Yk33fBepAsFAyid+Fiqk3dGstQoCHfP/OKUoLtIxP
 QZroDQLPMywbiLwLQFiE+d8W1rY2IEYnkprSf7bpnwIGYrp0P4hvfUEGHep/plXa3quZ2X1WMMp
 RNcm1f+DBOkzvpo7Vx/jjJLGF1Lqs3uzHJNQcS7wduHOmnnVaSx1iEbJHKZ7XLgvQMeWgY1XTo7
 JLt+omXpyBjmi4gqrcPkNRYoeK98wqU8CG26SzmfUqpC2BMWNlpCYRMsyk0Uy9h2gSZrI0EhRTP
 FJNYICbwg7e3qjm+p0yheJHIgf1B0S3wthUQVJNjgMVA==
X-Forward-Email-ID: 67cddc968d04fc44bbac47b6
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <0b679284-d427-4229-b008-e3e466f66a0f@kwiboo.se>
Date: Sun, 9 Mar 2025 19:23:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] arm64: dts: rockchip: Add I2C controllers for RK3528
To: Yao Zi <ziyao@disroot.org>
Cc: Heiko Stuebner <heiko@sntech.de>, Andi Shyti <andi.shyti@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250309070603.35254-1-ziyao@disroot.org>
 <20250309070603.35254-3-ziyao@disroot.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250309070603.35254-3-ziyao@disroot.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Yao Zi,

On 2025-03-09 08:06, Yao Zi wrote:
> Describe I2C controllers shipped by RK3528 in devicetree.
> 
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---
>  arch/arm64/boot/dts/rockchip/rk3528.dtsi | 104 +++++++++++++++++++++++
>  1 file changed, 104 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3528.dtsi b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
> index 04ca2e2b3e9b..860b6057e5c2 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3528.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
> @@ -19,6 +19,14 @@ / {
>  	#size-cells = <2>;
>  
>  	aliases {
> +		i2c0 = &i2c0;
> +		i2c1 = &i2c1;
> +		i2c2 = &i2c2;
> +		i2c3 = &i2c3;
> +		i2c4 = &i2c4;
> +		i2c5 = &i2c5;
> +		i2c6 = &i2c6;
> +		i2c7 = &i2c7;

nitpick: These should be ordered after the gpioX aliases.

Regards,
Jonas

>  		gpio0 = &gpio0;
>  		gpio1 = &gpio1;
>  		gpio2 = &gpio2;

[snip]

