Return-Path: <linux-kernel+bounces-358144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D83997AA8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 04:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4985D1F23ED4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 02:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F38F17BEC5;
	Thu, 10 Oct 2024 02:44:37 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07FE6BB5B
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 02:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728528277; cv=none; b=fjhRNkI8ggSCS2xnOpuY0RX/+Z7mBE8K7cn+9DljXPK/dc8s43a/D20Rao8gSZny6JdoL0BV1PUWnr65SSo/P2pOaZ0yR0VVbzJSM9wENPnH1QSBL62VJiYakjJ6dkfmD6NhFEraj5OSyR1J93nCtRY+M4B1/jyP2iH5ZPnaONk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728528277; c=relaxed/simple;
	bh=KbeMLDT+ohFiaGGCHH+fKWYl0ycZ5R2cZMVKUMWxUH4=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Ow5up7eDUj6JzOE2kcm6mMBzx56iJp6RpnbIYfExr4KEQbolkdSUiqp6aQIDfz8iZvV97AQFEFb8YEUKyppGJMR5pYNX6v+AqhuhracL/bbaR4B3gLvt1IgSDOaoVn3scxSBHzbaEefm+E232Mov6kPPUSRlBwpelgsOnh5PjEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XPDZ02pP7zpWZb;
	Thu, 10 Oct 2024 10:42:32 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id 12F4F18010F;
	Thu, 10 Oct 2024 10:44:32 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 10 Oct 2024 10:44:31 +0800
Subject: Re: [patch 07/25] debugobjects: Remove pointless debug printk
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
CC: Waiman Long <longman@redhat.com>
References: <20241007163507.647617031@linutronix.de>
 <20241007164913.390511021@linutronix.de>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <13ecf970-6a0a-544c-6528-78a0ceedc2d3@huawei.com>
Date: Thu, 10 Oct 2024 10:44:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241007164913.390511021@linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemf100006.china.huawei.com (7.185.36.228)



On 2024/10/8 0:49, Thomas Gleixner wrote:
> It has zero value.

Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>

> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  lib/debugobjects.c |    5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> --- a/lib/debugobjects.c
> +++ b/lib/debugobjects.c
> @@ -1303,7 +1303,7 @@ static bool __init debug_objects_replace
>  	struct debug_obj *obj, *new;
>  	struct hlist_node *tmp;
>  	HLIST_HEAD(objects);
> -	int i, cnt = 0;
> +	int i;
>  
>  	for (i = 0; i < ODEBUG_POOL_SIZE; i++) {
>  		obj = kmem_cache_zalloc(cache, GFP_KERNEL);
> @@ -1330,11 +1330,8 @@ static bool __init debug_objects_replace
>  			/* copy object data */
>  			*new = *obj;
>  			hlist_add_head(&new->node, &db->list);
> -			cnt++;
>  		}
>  	}
> -
> -	pr_debug("%d of %d active objects replaced\n", cnt, obj_pool_used);
>  	return true;
>  free:
>  	hlist_for_each_entry_safe(obj, tmp, &objects, node) {
> 
> .
> 

-- 
Regards,
  Zhen Lei

