Return-Path: <linux-kernel+bounces-178285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D588C4B6A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 05:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EA8CB21CE3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 03:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E177BB657;
	Tue, 14 May 2024 03:14:15 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED05E79D2
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 03:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715656455; cv=none; b=LABcT5L2pyw0qVcKqP4ELiKt9rlpwsrOh+9dncHtXOwt8qKbfW9a2d9hNqO+3mWo7frO8efUg0RQTiaIJ+Y7eaQ1Q5z2LKS+QxEISQEyzXS6ptxb65OGQvbKPyAHhr4M5ZPP7whiQc9vcPGVJpmrKWnoVcH83smiL0U0hYfMb2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715656455; c=relaxed/simple;
	bh=4AD7x5fMXjedf/K0GTbHw8hQYBWkqfrwNjuZyrk4AJs=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=vFxUVkupMjL+lv/38l4kyKyPdBxFg70QOd9rfocKAgMy6u8vXiRvCAutyYwQRD/KtaedTrRLktHL+8tC9MmSfd1ZCC345/ZbfUweack3SZPW+dGTVUBGEhqgD4aW3jthXYqIs9oYUkLJNsoYR+DDd3RDS3xI0HleBd+32jzU1po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VdhFG4HLpzvYT1;
	Tue, 14 May 2024 11:10:42 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id F2CD014038F;
	Tue, 14 May 2024 11:14:09 +0800 (CST)
Received: from [10.173.135.154] (10.173.135.154) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 14 May 2024 11:14:09 +0800
Subject: Re: [PATCH 1/4] mm/hwpoison: add MODULE_DESCRIPTION()
To: Jeff Johnson <quic_jjohnson@quicinc.com>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<kasan-dev@googlegroups.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>, Alexander Potapenko
	<glider@google.com>, Marco Elver <elver@google.com>, Dmitry Vyukov
	<dvyukov@google.com>, Minchan Kim <minchan@kernel.org>, Sergey Senozhatsky
	<senozhatsky@chromium.org>
References: <20240513-mm-md-v1-0-8c20e7d26842@quicinc.com>
 <20240513-mm-md-v1-1-8c20e7d26842@quicinc.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <27d7476f-f0c4-b8be-0b62-b1740be5dbe9@huawei.com>
Date: Tue, 14 May 2024 11:14:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240513-mm-md-v1-1-8c20e7d26842@quicinc.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)

On 2024/5/14 3:37, Jeff Johnson wrote:
> Fix the 'make W=1' warning:
> WARNING: modpost: missing MODULE_DESCRIPTION() in mm/hwpoison-inject.o
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>  mm/hwpoison-inject.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/hwpoison-inject.c b/mm/hwpoison-inject.c
> index d0548e382b6b..7e45440aa19c 100644
> --- a/mm/hwpoison-inject.c
> +++ b/mm/hwpoison-inject.c
> @@ -109,4 +109,5 @@ static int __init pfn_inject_init(void)
>  
>  module_init(pfn_inject_init);
>  module_exit(pfn_inject_exit);
> +MODULE_DESCRIPTION("HWPoison pages injector");
>  MODULE_LICENSE("GPL");
> 

Acked-by: Miaohe Lin <linmiaohe@huawei.com>
Thanks.
.

