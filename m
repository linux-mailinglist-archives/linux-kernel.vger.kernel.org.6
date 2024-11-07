Return-Path: <linux-kernel+bounces-399170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5F89BFBCC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 02:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 212BA283B5F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 01:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A3511712;
	Thu,  7 Nov 2024 01:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="v+LVVOWL"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B6A168BD;
	Thu,  7 Nov 2024 01:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730943765; cv=none; b=VoLeXj/iY5oZSfjDJ2wv0k+P+Q/XTZCMOFFLlgMAn0fKyUOmXamRIkwgL2PIk1pH1Zg6zXE6SR83QQXojsl9HMYI62Cz67vzmJWXora0aEnLoRBHv8zvabkXLMZmp22RxoRMtmAFpVw7+Df0hzNM9o2Lmx3QhbscbynH71UU5WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730943765; c=relaxed/simple;
	bh=rS5mIAW9zXMYkNUzSNcqwWdPlnH3xrdHBhLSEnks//M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xy2W3w+kcKKT0wy7Pqsp4O3jYUsFLlsuW5TzXrYBxhuJ3+yMxF+PWhcOB/Dju53UR22OHZNO50pIcYPKlJbksgHwBklirYLw3S1qQdL+PXmyI9ASrwOgMcS/DChxcZZ8OPsHdndt2HBRhDeHc4bTMjc3gwRugPPE7iwCeIi/BQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=v+LVVOWL; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730943754; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=1Kv0j8n6OgbyEtl8S2ISVzAkmC/lfSFUHPm7gO3mtUM=;
	b=v+LVVOWLqgMHXKZQk76OqcKALzr277MyVpkOfswcS55P+atfh12Eybks+cOWbNw13QZtjDm3tY9p6X6SRF0TL3qHYQzCDAmSZ5LmAQ97fILCY7UwIikakaB+BorFaaUacoZEw6Io4O/M/12G02aHcTLEY8+G6ucwSrYZnrBe9SM=
Received: from 30.74.144.126(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WItht-N_1730943752 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 07 Nov 2024 09:42:33 +0800
Message-ID: <d410c617-7917-4776-967b-058817f40022@linux.alibaba.com>
Date: Thu, 7 Nov 2024 09:42:32 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] arm64: dts: sprd: sc9863a: reorder clocks,
 clock-names per bindings
To: Stanislav Jakubek <stano.jakubek@gmail.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <cover.1730918663.git.stano.jakubek@gmail.com>
 <d235438fbbd53c28b63cada2cf7e1234c120355e.1730918663.git.stano.jakubek@gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <d235438fbbd53c28b63cada2cf7e1234c120355e.1730918663.git.stano.jakubek@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/11/7 03:05, Stanislav Jakubek wrote:
> DT bindings expect the SC9863A clock-controller clocks/clock-names to be
> in a specific order, reorder them.
> 
> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>

Thanks.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
> Changes in V2:
> - new patch
> 
>   arch/arm64/boot/dts/sprd/sc9863a.dtsi | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/sprd/sc9863a.dtsi b/arch/arm64/boot/dts/sprd/sc9863a.dtsi
> index 31172ac44adc..e97000e560e7 100644
> --- a/arch/arm64/boot/dts/sprd/sc9863a.dtsi
> +++ b/arch/arm64/boot/dts/sprd/sc9863a.dtsi
> @@ -163,18 +163,18 @@ gic: interrupt-controller@14000000 {
>   		ap_clk: clock-controller@21500000 {
>   			compatible = "sprd,sc9863a-ap-clk";
>   			reg = <0 0x21500000 0 0x1000>;
> -			clocks = <&ext_32k>, <&ext_26m>;
> -			clock-names = "ext-32k", "ext-26m";
> +			clocks = <&ext_26m>, <&ext_32k>;
> +			clock-names = "ext-26m", "ext-32k";
>   			#clock-cells = <1>;
>   		};
>   
>   		aon_clk: clock-controller@402d0000 {
>   			compatible = "sprd,sc9863a-aon-clk";
>   			reg = <0 0x402d0000 0 0x1000>;
> -			clocks = <&ext_26m>, <&rco_100m>,
> -				 <&ext_32k>, <&ext_4m>;
> -			clock-names = "ext-26m", "rco-100m",
> -				      "ext-32k", "ext-4m";
> +			clocks = <&ext_26m>, <&ext_32k>,
> +				 <&ext_4m>, <&rco_100m>;
> +			clock-names = "ext-26m", "ext-32k",
> +				      "ext-4m", "rco-100m";
>   			#clock-cells = <1>;
>   		};
>   

