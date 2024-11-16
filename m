Return-Path: <linux-kernel+bounces-411595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 891399CFC9A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 04:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A6091F240C4
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 03:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B96518FDBA;
	Sat, 16 Nov 2024 03:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="LGv67E2y"
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975CF38382;
	Sat, 16 Nov 2024 03:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731728350; cv=none; b=WwoYwN3YX4y9E5FgBfSJWxUSQKLYMsU2WQj9Tp0elA08Q5JBxXwKjfliG96o1m7QU2VvUL82+io5Rl5Dol8BEqHegYlWOvrhT4F6LrGVdlQLaHBHOVdcss7lsN5F+24lTHD/r1box75rJPwi62P7vxyQ0KxQSVkEKIVsY0JEWds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731728350; c=relaxed/simple;
	bh=2WnIUhF4nF+5eiZ30FfIKwQDl93TFvg/qO/SRgQ2zzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dvqQk0E1zmuTYgMT/Hmqf2vIUQs1CjjpopqBTEXKwUQZrV7eeKK/ZuurvMUCQqtwuCOMZTvEeQTXw+ltzFXv0m6FjwfPHE3Ep2jwyDcyZ4T9sG8m5h0+H+r8kPDvYd6JoOTqwIsu7aCHcWWzcshRAOgRhR5nc3vnhwg/z8Js6Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=LGv67E2y; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731728338; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=YTBNWZgiiFjUFQseifv6NuUHrr3Tj7gRyILW+ozwUiQ=;
	b=LGv67E2yvjO1N3UKhe2M2nKsbax1XduL7o18pBwlIi1M9tlovJo/de/jijV4eQn+EXF/NSdj2KLOGAcG87iDZrhWbeimlxuk2c7r4eUxUlG8Uu8AVzwK4myjGBCvcKa+ZgCWnWMrT4bFQU3RqczFt2IM2psx2Hv8MBnmEq/nT4g=
Received: from 192.168.0.104(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WJVOyqZ_1731728336 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 16 Nov 2024 11:38:57 +0800
Message-ID: <af72a051-ee53-4050-a1c0-2a657e58cf03@linux.alibaba.com>
Date: Sat, 16 Nov 2024 11:38:56 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: sprd: Remove unused and undocumented
 "constant_charge_voltage_max_microvolt" property
To: "Rob Herring (Arm)" <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241115193409.3618257-1-robh@kernel.org>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20241115193409.3618257-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/11/16 03:34, Rob Herring (Arm) wrote:
> Remove "constant_charge_voltage_max_microvolt" property which is both
> unused in the kernel and undocumented. Most likely they are leftovers
> from downstream.

Yes. LGTM. Thanks.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>   arch/arm64/boot/dts/sprd/sp9860g-1h10.dts | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts b/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts
> index 095b24a31313..e60838695d0e 100644
> --- a/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts
> +++ b/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts
> @@ -71,7 +71,6 @@ bat: battery {
>   		compatible = "simple-battery";
>   		charge-full-design-microamp-hours = <1900000>;
>   		charge-term-current-microamp = <120000>;
> -		constant_charge_voltage_max_microvolt = <4350000>;
>   		internal-resistance-micro-ohms = <250000>;
>   		ocv-capacity-celsius = <20>;
>   		ocv-capacity-table-0 = <4185000 100>, <4113000 95>, <4066000 90>,

