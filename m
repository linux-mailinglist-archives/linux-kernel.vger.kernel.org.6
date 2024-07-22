Return-Path: <linux-kernel+bounces-258413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 351A69387A3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 05:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0F70281520
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 03:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E027A13FFC;
	Mon, 22 Jul 2024 03:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="SN2mZNkP"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD388F54;
	Mon, 22 Jul 2024 03:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721618050; cv=none; b=mTd6b/5WL1+njkzVNdr1EqiZNrgeUu8bs8jW2qQfpdCx2sUTqYzEmjwDV156qQPyzVHLIVAlev0EK37SEczT3BPjDhFjMtO6hNdt9OqVm6pJwDNl9+HSH4a/R/CMm0jsvLDSfAmoS7k5ycFlarLhX7MhYUrDEovY96htplfJc68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721618050; c=relaxed/simple;
	bh=uWJg+Ba6JgW+IqSJbryw5SeG2J1lfqdjgAD3ulfVbHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HESQA3cHxV0Y3uJb/vZ0kPLEkPYssMrgKct6eVei/YE9Hwdb2fl9qg0lqvhflvgfvTEmqMiW6cAlorMtgC/udTsJG+N7zf5/8Li7Do7zCUGf0ITRvO9lzllECv+0Xe7V+PKF+UTB9Qgy6i2GMCJK9ZP4tTXvJF3BPK43JKIyIDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=SN2mZNkP; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1721618044; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=vvJ86MdlmCmjVRCGh33sMSMQJMbaqK+m69weMIl6ecc=;
	b=SN2mZNkPitgt4kwC783v6L0JOvCaHj1gO2FRJlcHVbBUS6jTs0r9a01KATT4B1xRyf75cKhLdqLFzhHiSKpAMRrjhnFXkinEooHtmkQXfRxi3Se3/IqrMSNhs6I7xd8t3pyYnT9CzFv3ubQdJZFEIAVHyMlG4uVYxpr694t1bgg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R361e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0WAyLppw_1721618043;
Received: from 30.97.56.74(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WAyLppw_1721618043)
          by smtp.aliyun-inc.com;
          Mon, 22 Jul 2024 11:14:04 +0800
Message-ID: <68b1509f-97f4-4a2c-9b50-c9f1eca5e638@linux.alibaba.com>
Date: Mon, 22 Jul 2024 11:14:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: sprd: sc2731: rename fuel gauge node to
 be generic
To: Stanislav Jakubek <stano.jakubek@gmail.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
 Baolin Wang <baolin.wang7@gmail.com>, Chunyan Zhang <zhang.lyra@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <cover.1720957783.git.stano.jakubek@gmail.com>
 <246c0c7763a432d4bebcb0e99b90dcf4cded333d.1720957783.git.stano.jakubek@gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <246c0c7763a432d4bebcb0e99b90dcf4cded333d.1720957783.git.stano.jakubek@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/7/14 19:57, Stanislav Jakubek wrote:
> According to DT spec, node names should be generic. Rename the
> sprd,sc2731-fgu node to a more generic "fuel-gauge".
> 
> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>

LGTM. Thanks.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
>   arch/arm64/boot/dts/sprd/sc2731.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/sprd/sc2731.dtsi b/arch/arm64/boot/dts/sprd/sc2731.dtsi
> index 7e55b2b31c84..48b681768f6e 100644
> --- a/arch/arm64/boot/dts/sprd/sc2731.dtsi
> +++ b/arch/arm64/boot/dts/sprd/sc2731.dtsi
> @@ -95,7 +95,7 @@ pmic_adc: adc@480 {
>   			nvmem-cells = <&adc_big_scale>, <&adc_small_scale>;
>   		};
>   
> -		fgu@a00 {
> +		fuel-gauge@a00 {
>   			compatible = "sprd,sc2731-fgu";
>   			reg = <0xa00>;
>   			bat-detect-gpio = <&pmic_eic 9 GPIO_ACTIVE_HIGH>;

