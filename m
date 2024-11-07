Return-Path: <linux-kernel+bounces-399159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E942C9BFBB3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 02:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADC36280CD9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 01:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F084911712;
	Thu,  7 Nov 2024 01:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="MuVWVh0B"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBBB17C96;
	Thu,  7 Nov 2024 01:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730943429; cv=none; b=SMT0N3Jsc05G8WxIKhRwtjifswXxCcCiSjF4nQNibLqMhJPtA5wo7it0PsPOt4marV7gCz1I45d27i9pZNDmlCLhI7p3B5Z5D/2VFW0/N+tMxz8WwU9Q0hHuOGnHv/gqoQd8CNRDkQOMcFRlAnNYUl+s5nRlPItudNOYzDdIFl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730943429; c=relaxed/simple;
	bh=imegmMz2YNkBLX+4qqdnSV30xWTOtj5TodoLpqR8cts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UUtt7+u2mUL+wXaw7Zk2X1cEoTurQfW9ywkpYopYud4hjttiJb4wRHRGOGJGmogo1Ykp8nmBR/mAtk5/8PXAkp7jqpJn8kgvlUa2qGF4/WFOIccZLwPl9keAGocE7sRyIXCRf37Z6DVh1MSk8I3qxxYUOm5o85/Vn6rGenxd0fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=MuVWVh0B; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730943422; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=fmnixL3RcmDVMH9diB+WJ+i2th3M/oRNlctOBDcUDeI=;
	b=MuVWVh0BEbVwiua3up+0JtXp7U6cxVX2FwMbLNpMgwBtnJwWOWcOe62100+KsHUcOeBj9Q8UKIUBcoIEPdP4Y9Pxw1Byrbe79r1H3cay1/j4rELneNsLA/5VWDyeMQUYPSQJHn9YCau2+V+LzTlAJL3Nhcc0eAd75JxkO4dy0zU=
Received: from 30.74.144.126(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WItbwvQ_1730943421 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 07 Nov 2024 09:37:02 +0800
Message-ID: <9f70dc40-2199-44c6-ac68-4d09074f9a72@linux.alibaba.com>
Date: Thu, 7 Nov 2024 09:37:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] arm64: dts: sprd: sp9860g-1h10: fix
 factory-internal-resistance-micro-ohms property
To: Stanislav Jakubek <stano.jakubek@gmail.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <cover.1730918663.git.stano.jakubek@gmail.com>
 <30d7ad167400764b6fe37f63276c07d3e30d931d.1730918663.git.stano.jakubek@gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <30d7ad167400764b6fe37f63276c07d3e30d931d.1730918663.git.stano.jakubek@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/11/7 03:05, Stanislav Jakubek wrote:
> As per DT bindings, this property was missing the "factory-" prefix.
> 
> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>

Thanks. LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
> Changes in V2:
> - new patch
> 
> I thought about squashing this with the 1st patch, but I wanted to keep
> Baolin's R-b, so I kept it separate.
> 
>   arch/arm64/boot/dts/sprd/sp9860g-1h10.dts | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts b/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts
> index cd8b1069e387..94af7700f3e2 100644
> --- a/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts
> +++ b/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts
> @@ -72,7 +72,7 @@ bat: battery {
>   		charge-full-design-microamp-hours = <1900000>;
>   		charge-term-current-microamp = <120000>;
>   		constant-charge-voltage-max-microvolt = <4350000>;
> -		internal-resistance-micro-ohms = <250000>;
> +		factory-internal-resistance-micro-ohms = <250000>;
>   		ocv-capacity-celsius = <20>;
>   		ocv-capacity-table-0 = <4185000 100>, <4113000 95>, <4066000 90>,
>   			<4022000 85>, <3983000 80>, <3949000 75>,

