Return-Path: <linux-kernel+bounces-399354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5F09BFDD4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 06:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5C941F23727
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 05:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBBE192B69;
	Thu,  7 Nov 2024 05:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="X+qVOYhv"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D36D18D64B;
	Thu,  7 Nov 2024 05:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730958488; cv=none; b=VdYL1nO/Fhz4Qt7MvWLFd9yDRZGhYW6B9lJ2/CcukeQKD8dV5DRxvt/zy93tzFPqtpGB6OWBn/eOjCZTE9v4ZMfhdQDyKsHPlFtvbJQ36Ro4c+Wlhb4Kbr1EvxqVPL1k6GnU2/+moOHd2xa/kNobWqn3Zrv4mrKvgQpJ0aRGCQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730958488; c=relaxed/simple;
	bh=8CtVzpUjntLwX6z1W5SrsEEHrN/osdJMIYHEsHmGjPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LPI5BO3LSvJI8j7k2DzW6W24XxfcTZ7ZzxZYF9JZdNeTkiCTwfTSORPQbYUt8qs6MTC9vAeMMjOClnIZICEOP1tg6tjX5x6bVcVRIY58dMhNCcM6Pgq9QkvzvKQJP4jDlVTGIToMVM15khSJ83ftxHoaZi5mDJy9XB0t/KzMCgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=X+qVOYhv; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730958477; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=6tz/6yZdJc48Ct5wSNXHHSWeXsH6J5tpfO//kmdJIYY=;
	b=X+qVOYhvJu52/0DV6BJWmdvBYUugTWHTyS1ZFfs+J+I1ncTbsIYo7xd6DmA1fOvZGuhhOHd9y088/mnKpOb0dIs3M/w5I0RZ1HdVpXbOe4t+ZX+LbQxEjsWKKRYLUxse5LaxZGAcAxNtve/6gH/gJ+uVeUn1p6uTVXUr/Q7NY0c=
Received: from 30.74.144.126(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WIuSc0b_1730958161 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 07 Nov 2024 13:42:42 +0800
Message-ID: <a2f244a8-cbac-4482-902d-fedcc461a417@linux.alibaba.com>
Date: Thu, 7 Nov 2024 13:42:40 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] arm64: dts: sprd: sc2731: move fuel-gauge
 monitored-battery to device DTS
To: Stanislav Jakubek <stano.jakubek@gmail.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <cover.1730918663.git.stano.jakubek@gmail.com>
 <2959aa8567afbef17337829072adce01158f00bb.1730918663.git.stano.jakubek@gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <2959aa8567afbef17337829072adce01158f00bb.1730918663.git.stano.jakubek@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/11/7 03:05, Stanislav Jakubek wrote:
> The monitored-battery property is a property of the board, not the PMIC.
> Move this property to the DTS of its only user, sp9860g-1h10.
> While at it, disable the fuel-gauge node by default and enable it only
> for its users, as it requires board-specific properties to work correctly.
> 
> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>

Looks reasonable to me. Thanks.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
> Changes in V2:
> - none
> 
> Note that the 'sprd,calib-resistance-micro-ohms' property isn't specified
> as I do not have the board or any other source of information about it.
> 
> If the SPRD folks could chime in here, that'd be great.
> 
>   arch/arm64/boot/dts/sprd/sc2731.dtsi      | 4 ++--
>   arch/arm64/boot/dts/sprd/sp9860g-1h10.dts | 5 +++++
>   2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/sprd/sc2731.dtsi b/arch/arm64/boot/dts/sprd/sc2731.dtsi
> index 12136e68dada..2d27427c41a2 100644
> --- a/arch/arm64/boot/dts/sprd/sc2731.dtsi
> +++ b/arch/arm64/boot/dts/sprd/sc2731.dtsi
> @@ -94,17 +94,17 @@ pmic_adc: adc@480 {
>   			nvmem-cells = <&adc_big_scale>, <&adc_small_scale>;
>   		};
>   
> -		fuel-gauge@a00 {
> +		pmic_fgu: fuel-gauge@a00 {
>   			compatible = "sprd,sc2731-fgu";
>   			reg = <0xa00>;
>   			bat-detect-gpio = <&pmic_eic 9 GPIO_ACTIVE_HIGH>;
>   			io-channels = <&pmic_adc 3>, <&pmic_adc 6>;
>   			io-channel-names = "bat-temp", "charge-vol";
> -			monitored-battery = <&bat>;
>   			nvmem-cell-names = "fgu_calib";
>   			nvmem-cells = <&fgu_calib>;
>   			interrupt-parent = <&sc2731_pmic>;
>   			interrupts = <4>;
> +			status = "disabled";
>   		};
>   
>   		vibrator@ec8 {
> diff --git a/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts b/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts
> index 94af7700f3e2..b1fa817ece1e 100644
> --- a/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts
> +++ b/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts
> @@ -84,6 +84,11 @@ bat: battery {
>   	};
>   };
>   
> +&pmic_fgu {
> +	monitored-battery = <&bat>;
> +	status = "okay";
> +};
> +
>   &uart0 {
>   	status = "okay";
>   };

