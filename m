Return-Path: <linux-kernel+bounces-404612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E5E9C45BD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 20:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18BD0B29B23
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 19:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B2C1AB513;
	Mon, 11 Nov 2024 19:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="ES5D7iaJ"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A671AA1DE
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 19:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.246.76.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731352378; cv=none; b=SAwFVLcYwCHDVhqah94/UKtjSmcm/EK9GTijKhza394s9tqFAeMK3/hyZFPTdQmcx+jLRRjMmyL4TYfuXV8/jeLd3UDuNZXhOAYKr62O6vbdD9S1Yh4g5Qyr+RZpJob++YRbJq67nZJ5E2cLUjPPI2J+PtXU1xNrtX5XM2Gyv5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731352378; c=relaxed/simple;
	bh=UC8FylXasmQ/h9DEQIESvrU6CHINib7lDFqz/rQnwZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=dXbiMEbkxk5nsRkBGOz3+9gAnVakjCmehmAdnlpuVedr6bBVmx4xMf7DdQKT+xkkJRpK365yxLwUw9FuBW0W666b5IybrLZfOkS8qTwd2dc2M/EmbX9O/lQREpf6YmgtuRJ0cSi+1XniMd6ORzbJ2IobfrYCY80W+kMgZUE0Up0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=ES5D7iaJ; arc=none smtp.client-ip=207.246.76.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: Cc:
 References: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1731352364;
 bh=VoOvd60Z5sJEGwTfTCFOEcWAXUKH/B7ofE6eDnjYJDw=;
 b=ES5D7iaJBf3vI/JUt0lYxAsqV+V9Ppes5SXnaMMg76LS3frlUD+nJG5OQNLbT768lEwZoYDNl
 SFwkFnNX4TnGCBDIl5i7QVEJBrdbBTtsjGRAvpVhPDq5MnYD2RbsJTl7ZAlPrIMEIq7uiYYSqed
 CAYHUkDtRlTTj55mbTa0CWPjdCjKta+jVTjFZ8Omlef04wvPu8Mcg4PTcGUEwmk2VqFyXo7fkCH
 6OHfNsirVg1jYHgmbpnwuLFDagyYGgs5vDodOJZhGYhOyoKaTi5cRWnx7B+9IcWvOnpsMvvNJil
 PrMcTb8NVNMswWj5XRHuGZroubsRys+ILm9g9ATaorsQ==
Message-ID: <4ba81dfa-f276-4e05-b46b-92f50dbcfcc4@kwiboo.se>
Date: Mon, 11 Nov 2024 20:12:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: Enable UART8 on rock-3b
To: =?UTF-8?B?VGFtw6FzIFN6xbFjcw==?= <tszucs@linux.com>
References: <20241111181807.13211-1-tszucs@linux.com>
 <20241111181807.13211-4-tszucs@linux.com>
Content-Language: en-US
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 FUKAUMI Naoki <naoki@radxa.com>, Dragan Simic <dsimic@manjaro.org>,
 Chukun Pan <amadeus@jmu.edu.cn>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20241111181807.13211-4-tszucs@linux.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 207.246.76.47
X-ForwardEmail-ID: 673257291b4710f318d5f54d

Hi Tamás,

On 2024-11-11 19:17, Tamás Szűcs wrote:
> Enable UART lines on Radxa ROCK 3 Model B M.2 Key E.
> 
> Signed-off-by: Tamás Szűcs <tszucs@linux.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts b/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts
> index b7527ba418f7..61d4ba2d312a 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts
> @@ -732,7 +732,7 @@ &uart8 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&uart8m0_xfer &uart8m0_ctsn &uart8m0_rtsn>;
>  	uart-has-rtscts;
> -	status = "disabled";
> +	status = "okay";

This should probably be enabled using an dt-overlay, there is no UART
device embedded on the board and the reason I left it disabled in
original board DT submission.

On second thought maybe they should be enabled, think PCIe and USB lines
on the M.2 Key E is already enabled by default. I probably only tested
with a pcie/usb wifi/bt card and not a sido/uart wifi/bt card.

Regards,
Jonas

>  };
>  
>  &usb_host0_ehci {


