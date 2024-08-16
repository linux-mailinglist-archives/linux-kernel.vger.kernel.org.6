Return-Path: <linux-kernel+bounces-288816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 040C0953F14
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 03:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B701B2347B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 01:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CB547F4D;
	Fri, 16 Aug 2024 01:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fDmD3Ku+"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512541EB39;
	Fri, 16 Aug 2024 01:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723772800; cv=none; b=b49+Vzu1HXj+F5KX/kRWOJRQaLb7ttpf712YtBIynDNXW5LnPO4CoPJACly2jW8RtB9qGYgAFYsoEe2iMZXIsrJocBnfsvXN1gDxTJlrEJDrys7p5XZSiv2eMxgSfG/IqkFWnP0vYPHAwRVoICdd/lQw01+4kDfNaJq8gd2X0Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723772800; c=relaxed/simple;
	bh=Ru5iuNDTVif7wSYu2AzUGd6Bg0oLZK9k/q6uaa2VOy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZZS9vAYsFbiOZqOXm8MbfXJQJ62Oo+8qGigb9HtX4sSQUzlWhVuu8aWA45eycVL/9/lQa/D2DrYu5dBF3ZAtl/mODVTOsb1wgmI9JDAIzvNnM9nIVCXo82rdIBHg2UJDK9bXTRyr6dpWfclc0riU0OtP2XwfrUkDRrC4kG19hMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fDmD3Ku+; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723772789; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=bufOPjvqjiwGLr7KaLP+0J3WLdW8Uk9jXivVhZPs3dY=;
	b=fDmD3Ku+JLXnQYHfM+6oWEmIZBb5E9MyQPX35Vhw44ZC+q6ycteuzK0/p4tB1ZcR4AoVOQwXlcNPBj070Ubcvo6Vg/ze/5ngr2sWc6asHwjTmEdH/rWRQIJXnv88F6Di3wDXNCOrUpcOv4nvQDBDeCbrR7WqBDkF+CWm12Fo5JE=
Received: from 30.97.56.60(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WCyNzlF_1723772787)
          by smtp.aliyun-inc.com;
          Fri, 16 Aug 2024 09:46:28 +0800
Message-ID: <3030518f-7d67-4837-8640-ffc354551e87@linux.alibaba.com>
Date: Fri, 16 Aug 2024 09:46:27 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] arm64: dts: sprd: sc2731: fix bat-detect-gpios
 property
To: Stanislav Jakubek <stano.jakubek@gmail.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <cover.1723716331.git.stano.jakubek@gmail.com>
 <e57ee9b94f128753d156d77015f6cc3dc24fd9e8.1723716331.git.stano.jakubek@gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <e57ee9b94f128753d156d77015f6cc3dc24fd9e8.1723716331.git.stano.jakubek@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/8/15 18:13, Stanislav Jakubek wrote:
> According to DT bindings, the property is called bat-detect-gpios, not
> bat-detect-gpio. Update the property as such.
> 
> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>

Thanks.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
>   arch/arm64/boot/dts/sprd/sc2731.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/sprd/sc2731.dtsi b/arch/arm64/boot/dts/sprd/sc2731.dtsi
> index 12136e68dada..c8b30c0479fd 100644
> --- a/arch/arm64/boot/dts/sprd/sc2731.dtsi
> +++ b/arch/arm64/boot/dts/sprd/sc2731.dtsi
> @@ -97,7 +97,7 @@ pmic_adc: adc@480 {
>   		fuel-gauge@a00 {
>   			compatible = "sprd,sc2731-fgu";
>   			reg = <0xa00>;
> -			bat-detect-gpio = <&pmic_eic 9 GPIO_ACTIVE_HIGH>;
> +			bat-detect-gpios = <&pmic_eic 9 GPIO_ACTIVE_HIGH>;
>   			io-channels = <&pmic_adc 3>, <&pmic_adc 6>;
>   			io-channel-names = "bat-temp", "charge-vol";
>   			monitored-battery = <&bat>;

