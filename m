Return-Path: <linux-kernel+bounces-372837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8549A4E0A
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 15:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDE421F24977
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 13:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505B1224DC;
	Sat, 19 Oct 2024 13:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="uKTrbrDh"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F199421373
	for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 13:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.246.76.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729342966; cv=none; b=QjKY79ENSDN8Dde319uESTD5HK6SncMENcerYLtuzCz5bPNYdVvfYa+ZuopWb6jVdEbfRjIMOfqmdcFRNpwCa98RdYDDvOYNYvd0pIeuVe+6ponRBqaStbVEOKmP35+/TArArsEsl8DcW//phvbgwA+LsHk2jQ2NYrd2qW1352k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729342966; c=relaxed/simple;
	bh=cq8AxrWvNmYG9fbGB6CIB6T1zjisQZnjVBmChc7qe0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j9O614NZUU5vGzZZgD9uFoXBsKRlQWPwNCK+chbz0BjBnxy8BrASFavWK2uW0V+bRNzC2bmy4ucDmRPqwkWrOuNlCCGR2JfatxZa46Cg6lmAfqGF+NJIFpIpjx0QcubjSpkH80eUcA7pM8LpHP0bajSVr0IhHHK48vNUrxR8SyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=uKTrbrDh; arc=none smtp.client-ip=207.246.76.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1729342933;
 bh=lFVey/vmL79CFl6aqyjl9RKcgfPnkmjg2Z7v8kUFxG4=;
 b=uKTrbrDhgdsNw1cnm8/yhtZ0ZrQxa7nx0frcrCSfw6REiKPF8im/UR7G3ko2BqjgwNosruUFC
 7gzRqal/vpZRi4VDxXuHovVN8yS0pUnVRIIMU+My73o1f3L4lcmMncNHUTkCN0kf428I6NIxtia
 X9reEEFm9pRIXpk8M9J59IFCHu92KROH/8XtDDTaDjeQnx1uRJn8LDH+pVFV1fvOB/NYXOazn6I
 53YZaV9FoVee19i9fT9wkh/dyM6kAZ/FagAz2BKoUjrJt3qKVNql4Y7VZrPy5QIUL4A75NhYJoZ
 VLmUcDAoUAyYEXJuUbW05ANleav9Tx0uvplAmqSWWQuw==
Message-ID: <a90437be-eae6-4dc9-93fa-fd4af8ad9bed@kwiboo.se>
Date: Sat, 19 Oct 2024 15:02:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] arm64: dts: rockchip: Enable HDMI0 on rock-5a
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Luis de Arquer <ldearquer@gmail.com>, Alexandre ARNOUD <aarnoud@me.com>,
 kernel@collabora.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20241019-rk3588-hdmi0-dt-v2-0-466cd80e8ff9@collabora.com>
 <20241019-rk3588-hdmi0-dt-v2-5-466cd80e8ff9@collabora.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20241019-rk3588-hdmi0-dt-v2-5-466cd80e8ff9@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 207.246.76.47
X-ForwardEmail-ID: 6713add56ab72d6a578a01d7

Hi Cristian,

On 2024-10-19 12:12, Cristian Ciocaltea wrote:
> Add the necessary DT changes to enable HDMI0 on Radxa ROCK 5A.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts | 52 ++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts b/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
> index 87fce8d9a964cd53d179ce214ae1c0ff505a2dce..2b141af5e709b0bc2193dbfb2327e6bc1fdaa502 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
> @@ -5,6 +5,7 @@
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/leds/common.h>
>  #include <dt-bindings/pinctrl/rockchip.h>
> +#include <dt-bindings/soc/rockchip,vop2.h>
>  #include "rk3588s.dtsi"
>  
>  / {
> @@ -35,6 +36,17 @@ chosen {
>  		stdout-path = "serial2:1500000n8";
>  	};
>  
> +	hdmi0-con {
> +		compatible = "hdmi-connector";
> +		type = "a";

ROCK 5A use micro HDMI connector type, so this should be type = "d".

Regards,
Jonas

> +
> +		port {
> +			hdmi0_con_in: endpoint {
> +				remote-endpoint = <&hdmi0_out_con>;
> +			};
> +		};
> +	};
> +

[snip]


