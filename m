Return-Path: <linux-kernel+bounces-262769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1714893CC76
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 03:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EB5EB210DB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 01:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B05AD59;
	Fri, 26 Jul 2024 01:36:53 +0000 (UTC)
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net (zg8tmja5ljk3lje4ms43mwaa.icoremail.net [209.97.181.73])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7E236D;
	Fri, 26 Jul 2024 01:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.181.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721957813; cv=none; b=cYJgFTleEqr0Q3rWsAXstXV0R+9i0gZrPCZb076HoREhpVf9SYsAUad5mlbDctnjuCXP4kdgy12JO6PHp5aYnJJXO0SA1Py2QqHYp/1gAI0cNx10kLl0nQLUrRl0467Yw9cPB+L6gCoeerkQF9BIx4YB/Wd9oRLF+5UrvgB4JTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721957813; c=relaxed/simple;
	bh=Dt8GeyTHB0Gd2wAoEHAkZWzMmKfjvqv+qcJa/zmfBx8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X0YTokQ9gBXwckuNBSpHp8L/bvO3PACfZgSdwLj/4RmLwIWTGA0zWd8EwPxZ7keRL6CKabtg7kwvFsXmiIHiE0wbNxW369NnNH46vQPxZ4VrmksBIvsf4c1XjJ+Cex8KmfkC62dIkn+Gqmmath2LqeRQVbqF8NvY7pKFS1XI9tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=209.97.181.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.50])
	by app2 (Coremail) with SMTP id HwEQrADXfxSZ_aJm+w5TAA--.27671S2;
	Fri, 26 Jul 2024 09:36:25 +0800 (CST)
Received: from [10.12.168.59] (unknown [10.12.168.59])
	by gateway (Coremail) with SMTP id _____wAnJ3mW_aJmNApyAA--.5651S2;
	Fri, 26 Jul 2024 09:36:24 +0800 (CST)
Message-ID: <a6285062-4e36-431e-b902-48f4bee620e0@hust.edu.cn>
Date: Fri, 26 Jul 2024 09:36:22 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: update dev-tools/kcsan.rst url about KTSAN
To: Haoyang Liu <tttturtleruss@hust.edu.cn>, Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>, Jonathan Corbet <corbet@lwn.net>
Cc: hust-os-kernel-patches@googlegroups.com, kasan-dev@googlegroups.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240725174632.23803-1-tttturtleruss@hust.edu.cn>
From: Dongliang Mu <dzm91@hust.edu.cn>
In-Reply-To: <20240725174632.23803-1-tttturtleruss@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:HwEQrADXfxSZ_aJm+w5TAA--.27671S2
Authentication-Results: app2; spf=neutral smtp.mail=dzm91@hust.edu.cn;
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr4rJF4DJr1DZF1kGF13twb_yoW8GrWxpa
	yfuFyI9rn0gr17K3yjgw40krW8AFZ7Xr4UG3W8Ja1FqrsI9F9IqrWagw1rXFyUZFWrAFW2
	vF48Za4Fv3WDAaUanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQYb7Iv0xC_Cr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vE
	x4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAaw2AFwI0_Jr
	v_JF1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF
	0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0EF7xvrVAajcxG14v26r
	4UJVWxJr1lYx0E74AGY7Cv6cx26r4fZr1UJr1lYx0Ec7CjxVAajcxG14v26r4UJVWxJr1l
	Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw2
	8IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_GFW3Jr1UJwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU0EksPUUUUU==
X-CM-SenderInfo: asqsiiirqrkko6kx23oohg3hdfq/


On 2024/7/26 01:46, Haoyang Liu wrote:
> The KTSAN doc has moved to
> https://github.com/google/kernel-sanitizers/blob/master/KTSAN.md.
> Update the url in kcsan.rst accordingly.
>
> Signed-off-by: Haoyang Liu <tttturtleruss@hust.edu.cn>

Although the old link is still accessible, I agree to use the newer one.

If this patch is merged, you need to change your Chinese version to 
catch up.

Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>

> ---
>   Documentation/dev-tools/kcsan.rst | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/dev-tools/kcsan.rst b/Documentation/dev-tools/kcsan.rst
> index 02143f060b22..d81c42d1063e 100644
> --- a/Documentation/dev-tools/kcsan.rst
> +++ b/Documentation/dev-tools/kcsan.rst
> @@ -361,7 +361,8 @@ Alternatives Considered
>   -----------------------
>   
>   An alternative data race detection approach for the kernel can be found in the
> -`Kernel Thread Sanitizer (KTSAN) <https://github.com/google/ktsan/wiki>`_.
> +`Kernel Thread Sanitizer (KTSAN)
> +<https://github.com/google/kernel-sanitizers/blob/master/KTSAN.md>`_.
>   KTSAN is a happens-before data race detector, which explicitly establishes the
>   happens-before order between memory operations, which can then be used to
>   determine data races as defined in `Data Races`_.


