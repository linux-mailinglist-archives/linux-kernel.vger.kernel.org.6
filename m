Return-Path: <linux-kernel+bounces-356117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 868C9995CA6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 03:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F391C1F25E07
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 01:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DFC17C61;
	Wed,  9 Oct 2024 01:07:17 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AF57462
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 01:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728436037; cv=none; b=sHHNIGGNGlVtPIQAFq10+56lNanMZNU3IkJUMJcgt1ot01utFmSRWIm3ZJRK3mXrekfxTQkAS7IUoFoE01z+4ICSDoo1Tp1TaI2vWTkG82zqSlUyFtUPKIQBv+h9/6q7jB/BK7URQsylMcoeOYALUMJo9tFcRlSf7YFBrd9cgCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728436037; c=relaxed/simple;
	bh=3ukVFd3nAWs1sXpEyUs9CJTi1uJG+eoxJEJuFM9WC3c=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=k3hBIgD1Ijx6vDgputZk9k5HZtgyEStzJRu9NRQseXQFBflKqaUlw9wJe7pgdYRkY3FYr1iQ5sqS26xjGVqalpnuL/44lX4o3iGiLdnT1f+aUNVpdlv7dJjBwhljgO3stiJRvHJUH/Xce8Jtl6lBDEb9fIIL0oxwBuhjLnZSoZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XNZSz3VR6zyScm;
	Wed,  9 Oct 2024 09:05:55 +0800 (CST)
Received: from kwepemk500005.china.huawei.com (unknown [7.202.194.90])
	by mail.maildlp.com (Postfix) with ESMTPS id 564A61800CF;
	Wed,  9 Oct 2024 09:07:11 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemk500005.china.huawei.com (7.202.194.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 9 Oct 2024 09:07:10 +0800
Subject: Re: [PATCH] fs: jffs2: Fix inconsistent indentation in
 jffs2_mark_node_obsolete
To: SurajSonawane2415 <surajsonawane0215@gmail.com>, <dwmw2@infradead.org>,
	<richard@nod.at>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20241008182411.30387-1-surajsonawane0215@gmail.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <442b62cc-a57d-04c4-0e25-07af7a0dad76@huawei.com>
Date: Wed, 9 Oct 2024 09:07:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241008182411.30387-1-surajsonawane0215@gmail.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemk500005.china.huawei.com (7.202.194.90)

ÔÚ 2024/10/9 2:24, SurajSonawane2415 Ð´µÀ:
> From: Suraj Sonawane <surajsonawane0215@gmail.com>
> 
> Fix the indentation to ensure consistent code style and improve
> readability, and to fix this warnings:
> fs/jffs2/nodemgmt.c:635 jffs2_mark_node_obsolete() warn: inconsistent
> indenting
> fs/jffs2/nodemgmt.c:646 jffs2_mark_node_obsolete() warn: inconsistent
> indenting
> 
> Signed-off-by: Suraj Sonawane <surajsonawane0215@gmail.com>
> ---
>   fs/jffs2/nodemgmt.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
> diff --git a/fs/jffs2/nodemgmt.c b/fs/jffs2/nodemgmt.c
> index bbab2bdc7..cc51c85ef 100644
> --- a/fs/jffs2/nodemgmt.c
> +++ b/fs/jffs2/nodemgmt.c
> @@ -630,8 +630,8 @@ void jffs2_mark_node_obsolete(struct jffs2_sb_info *c, struct jffs2_raw_node_ref
>   					  ref->flash_offset, jeb->used_size);
>   			BUG();
>   		})
> -			jffs2_dbg(1, "Obsoleting previously unchecked node at 0x%08x of len %x\n",
> -				  ref_offset(ref), freed_len);
> +		jffs2_dbg(1, "Obsoleting previously unchecked node at 0x%08x of len %x\n",
> +				ref_offset(ref), freed_len);
>   		jeb->unchecked_size -= freed_len;
>   		c->unchecked_size -= freed_len;
>   	} else {
> @@ -641,8 +641,8 @@ void jffs2_mark_node_obsolete(struct jffs2_sb_info *c, struct jffs2_raw_node_ref
>   					  ref->flash_offset, jeb->used_size);
>   			BUG();
>   		})
> -			jffs2_dbg(1, "Obsoleting node at 0x%08x of len %#x: ",
> -				  ref_offset(ref), freed_len);
> +		jffs2_dbg(1, "Obsoleting node at 0x%08x of len %#x: ",
> +				ref_offset(ref), freed_len);
>   		jeb->used_size -= freed_len;
>   		c->used_size -= freed_len;
>   	}
> 


