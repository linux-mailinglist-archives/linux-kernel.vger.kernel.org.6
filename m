Return-Path: <linux-kernel+bounces-221033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C03CC90EB08
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 14:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 695381F22095
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 12:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D3920B34;
	Wed, 19 Jun 2024 12:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="lrfv5qeW"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6347A79950
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 12:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.172.40.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718799821; cv=none; b=YQolm4O/fcl83l3ELi9cjifmBox2PUXY9XX26joNAyhEdybNY9qZmqg4igT+M3zuY5YzytugJ0BccuPTkwAUAIglxkURWkUR1g6PyeqUqeCIPoAJwMrWSE1nELQIlr36IGb96Z8Dky0UtBc5Omspq8h2KLnNRjlJ4+Is8PxFHGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718799821; c=relaxed/simple;
	bh=ECwtTKkG8N7tTK8m2s1f2Esiy24uhI/tGsBhH57UQZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ai9nkxRR9j/IS37CYDj2RP0KHVLy0QY/eBtMpp3LWqKxZTO52sUxfyZR1aNot37xlguS39WpLoeM6hu8+N7hmvBZlzehduQMcXCas6gJErDgB3lhE6IMoG8uQHExqrmaTKzFcHL9uhXEkKkeIlDhDQ3z3ki28+4MRb9itylR6vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=lrfv5qeW; arc=none smtp.client-ip=167.172.40.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1718799788;
 bh=lTFCC7hkkc+0C50PCDKrHMDGubmjU2AxMieUbdYQarc=;
 b=lrfv5qeWyP+BvF0pDksfgs8RhJdzrCTt0WvcqD+CnIZI/EyCIN6giHlf5Up9KK4mvGI3hiDod
 h8VgR/uua0gdxYadYy8tunC8Tj7vAahhrRTeIX4jZKlXmq8bQsVsYxrLZoMG7geC4WOsnh7BX7A
 lH7uVjtWQgkjNJs2z1LbdNDaXG96nGSQfdgkxd1iG+2huBqXkSl9ybKs313N/0WAIRgi6qqDC4M
 Vwiu5uIaGrv/Ynvv5iGwDzZUMsB3aHZY+o60hDlvMvs2UDYfRDArxXDaamV/yq3hryAcIhVIXb0
 K438OTMEgG/EDAj5C/OnGAG7bVHbPVq7YEwU2h9e6WEQ==
Message-ID: <c35b3e80-7889-473d-8365-88436c3cb9a9@kwiboo.se>
Date: Wed, 19 Jun 2024 14:22:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] arm64: dts: rockchip: Fix mic-in-differential usage
 on rk3568-rock-3a
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, Lee Jones
 <lee@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner
 <heiko@sntech.de>, Chris Zhong <zyw@rock-chips.com>, Zhang Qing
 <zhangqing@rock-chips.com>, Chris Morgan <macromorgan@hotmail.com>, Furkan
 Kardame <f.kardame@manjaro.org>, Michael Riesch
 <michael.riesch@wolfvision.net>
Cc: kernel@collabora.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240619-rk809-fixes-v1-0-fa93bc5313f4@collabora.com>
 <20240619-rk809-fixes-v1-3-fa93bc5313f4@collabora.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20240619-rk809-fixes-v1-3-fa93bc5313f4@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 6672cda75f5eef29994e8ae0

Hi Cristian,

On 2024-06-19 13:23, Cristian Ciocaltea wrote:
> The 'mic-in-differential' DT property supported by the RK809/RK817 audio
> codec driver is actually valid if prefixed with 'rockchip,':
> 
>   DTC_CHK arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dtb
>   rk3568-rock-3a.dtb: pmic@20: codec: 'mic-in-differential' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/mfd/rockchip,rk809.yaml#
> 
> Make use of the correct property name.
> 
> Fixes: a84ffd2ef1ff ("arm64: dts: rockchip: Fix mic-in-differential usage on rock-3a")
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
> index ebdedea15ad1..0b54dfe92d6e 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
> @@ -533,7 +533,7 @@ regulator-state-mem {
>  		};
>  
>  		codec {
> -			mic-in-differential;
> +			rockchip,mic-in-differential;

If I understand the schematics correctly, only one wire is connected so
this board cannot really use differential signaling, and this should
probably instead be dropped.

Regards,
Jonas

>  		};
>  	};
>  };
> 


