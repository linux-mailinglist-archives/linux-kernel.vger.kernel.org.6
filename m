Return-Path: <linux-kernel+bounces-563250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EFCEA63B46
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 03:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3098D3A83C2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 02:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91D486331;
	Mon, 17 Mar 2025 02:17:16 +0000 (UTC)
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1097A944E;
	Mon, 17 Mar 2025 02:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742177836; cv=none; b=p3ifsKfMUV4udcu99jzRDCAEzvvj4nEYU7d6MSQEfEWJjH/6WXJjuumnHL9XitO+tSFp/nHfHr3SlrxvRx7OsnAQTg/nFVnzBGGmwZ1WysRzXxRdddLAe9c50Qb74gMxsBaytj2CozW0Rw6TLkKTMU593YASiiKpUsS9dZvoz98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742177836; c=relaxed/simple;
	bh=YZQuLQtMYmXionMuEBA3APkexYfQmtmnhGlIcMLnNRk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j/+tq8SF0Hep5u2eD0JPkFVaCIKR8SwBmamR8IXBWJ1oE3z6uDYDOvDVGIjD8h2ZHbJ6bnFvHi1TMR1eM2x2VbAGOBYii+B6/5bbo68k95nscDKzYTYytwK9gHBq1JyQb4rkimXSywenZdSsIYAHuxsICmlnrUt+kw06DiNMdYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.52])
	by app2 (Coremail) with SMTP id HwEQrACn7OzohddnP0HGAA--.64350S2;
	Mon, 17 Mar 2025 10:16:08 +0800 (CST)
Received: from [10.12.169.48] (unknown [10.12.169.48])
	by gateway (Coremail) with SMTP id _____wAHIQHkhddnGv+QAA--.57472S2;
	Mon, 17 Mar 2025 10:16:05 +0800 (CST)
Message-ID: <f11afa64-1629-4005-8cb4-723d9b6ce6cb@hust.edu.cn>
Date: Mon, 17 Mar 2025 10:16:04 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/zh_CN: fix spelling mistake
To: jiang.peng9@zte.com.cn, si.yanteng@linux.dev
Cc: alexs@kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250317100811126QvOaWRPxSgm2ttU5faitl@zte.com.cn>
From: Dongliang Mu <dzm91@hust.edu.cn>
In-Reply-To: <20250317100811126QvOaWRPxSgm2ttU5faitl@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:HwEQrACn7OzohddnP0HGAA--.64350S2
Authentication-Results: app2; spf=neutral smtp.mail=dzm91@hust.edu.cn;
X-Coremail-Antispam: 1UD129KBjvJXoW7WFWruFyDJF4DKw4rKFyDZFb_yoW8Aryfp3
	4jkr1xJ3Z7tFn8CrWfKr48Za4xWw17GayxW34jy3Waqrnrt3y0vrZxKw4jgayfZry8AFWU
	ZF4fK3s5W34FvrUanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm0b7Iv0xC_Ar1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK
	6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1ln4kS14v26r
	1Y6r17M2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI
	12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj64x0Y40En7xvr7AKxV
	W8Jr0_Cr1UMcIj6x8ErcxFaVAv8VW8uFyUJr1UMcIj6xkF7I0En7xvr7AKxVW8Jr0_Cr1U
	McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrwCF04k20x
	vE74AGY7Cv6cx26r4fZr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_
	Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVj
	vjDU0xZFpf9x0zRuMKAUUUUU=
X-CM-SenderInfo: asqsiiirqrkko6kx23oohg3hdfq/


On 2025/3/17 10:08, jiang.peng9@zte.com.cn wrote:
> From: Peng Jiang <jiang.peng9@zte.com.cn>
>
> The word watermark was misspelled as "watemark".
>
> Signed-off-by: Peng Jiang <jiang.peng9@zte.com.cn>

One suggestion: the original English(Documentation/mm/balance.rst) 
version also has this typo. Submit a v2 patch to fix both?

Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>

> ---
>   Documentation/translations/zh_CN/mm/balance.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/translations/zh_CN/mm/balance.rst b/Documentation/translations/zh_CN/mm/balance.rst
> index 6fd79209c307..f877c0cfa39a 100644
> --- a/Documentation/translations/zh_CN/mm/balance.rst
> +++ b/Documentation/translations/zh_CN/mm/balance.rst
> @@ -64,7 +64,7 @@ kswapd并不真正需要平衡高内存区，因为中断上下文并不请求
>   如果从进程内存和shm中偷取页面可以减轻该页面节点中任何区的内存压力，而该区的内存压力
>   已经低于其水位，则会进行偷取。
>
> -watemark[WMARK_MIN/WMARK_LOW/WMARK_HIGH]/low_on_memory/zone_wake_kswapd：
> +watermark[WMARK_MIN/WMARK_LOW/WMARK_HIGH]/low_on_memory/zone_wake_kswapd：
>   这些是每个区的字段，用于确定一个区何时需要平衡。当页面数低于水位[WMARK_MIN]时，
>   hysteric 的字段low_on_memory被设置。这个字段会一直被设置，直到空闲页数变成水位
>   [WMARK_HIGH]。当low_on_memory被设置时，页面分配请求将尝试释放该区域的一些页面（如果


