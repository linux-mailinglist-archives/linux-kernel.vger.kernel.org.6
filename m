Return-Path: <linux-kernel+bounces-358165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61739997AEB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 05:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 275B2282224
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 03:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95CE918950A;
	Thu, 10 Oct 2024 03:00:18 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF542AF17
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 03:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728529218; cv=none; b=W8GdpMlN0XuHrYtijVapJFKhza24tzgAJm09EQFK23QCvzemJWCSceyIbnZZJUUrMA2UxZZCHPgMWS2aMRjZefMvtnAvFuWn8mWqjX6gGvXW4T9RcO60DhAnbXPX+fEPQCjayDSAlEjUGgzr9NfvAnFd8OmjrNTLghdinT9S/TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728529218; c=relaxed/simple;
	bh=JgV/McqiIe9MyEIAqvK3ilndnhZDEiJWvdkCI+P0y60=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=oCqyCplQ8w9HQqtm5Gee8tn5RSzJxrMeow6eVziqo4RX2KVlIcRmAzfYYluB6VhztgK9RZZIJ4xrlUABtwF1gvnm7r3D6BMd5zK31jxNEjz+zR3/tY1YMV6wQxoh6BWRIFNdzRyopoo4zqL5kivSiw3b/fK3Zy9JEbZQ4gf7lZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XPDwN0hQgz10N2n;
	Thu, 10 Oct 2024 10:58:28 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id 9431B180105;
	Thu, 10 Oct 2024 11:00:12 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 10 Oct 2024 11:00:12 +0800
Subject: Re: [patch 09/25] debugobjects: Make debug_objects_enabled bool
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
CC: Waiman Long <longman@redhat.com>
References: <20241007163507.647617031@linutronix.de>
 <20241007164913.518175013@linutronix.de>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <a10384fc-ad41-b8d5-1a13-d4ba13b24b91@huawei.com>
Date: Thu, 10 Oct 2024 11:00:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241007164913.518175013@linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf100006.china.huawei.com (7.185.36.228)



On 2024/10/8 0:50, Thomas Gleixner wrote:
> Make it what it is.

Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>

> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  lib/debugobjects.c |   17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> --- a/lib/debugobjects.c
> +++ b/lib/debugobjects.c
> @@ -82,7 +82,7 @@ static int __data_racy			debug_objects_m
>  static int __data_racy __maybe_unused	debug_objects_maxchecked __read_mostly;
>  static int __data_racy			debug_objects_fixups __read_mostly;
>  static int __data_racy			debug_objects_warnings __read_mostly;
> -static int __data_racy			debug_objects_enabled __read_mostly
> +static bool __data_racy			debug_objects_enabled __read_mostly
>  					= CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT;
>  static int				debug_objects_pool_size __ro_after_init
>  					= ODEBUG_POOL_SIZE;
> @@ -103,17 +103,16 @@ static DECLARE_DELAYED_WORK(debug_obj_wo
>  
>  static int __init enable_object_debug(char *str)
>  {
> -	debug_objects_enabled = 1;
> +	debug_objects_enabled = true;
>  	return 0;
>  }
> +early_param("debug_objects", enable_object_debug);
>  
>  static int __init disable_object_debug(char *str)
>  {
> -	debug_objects_enabled = 0;
> +	debug_objects_enabled = false;
>  	return 0;
>  }
> -
> -early_param("debug_objects", enable_object_debug);
>  early_param("no_debug_objects", disable_object_debug);
>  
>  static const char *obj_states[ODEBUG_STATE_MAX] = {
> @@ -592,7 +591,7 @@ static struct debug_obj *lookup_object_o
>  	}
>  
>  	/* Out of memory. Do the cleanup outside of the locked region */
> -	debug_objects_enabled = 0;
> +	debug_objects_enabled = false;
>  	return NULL;
>  }
>  
> @@ -1194,7 +1193,7 @@ check_results(void *addr, enum debug_obj
>  out:
>  	raw_spin_unlock_irqrestore(&db->lock, flags);
>  	if (res)
> -		debug_objects_enabled = 0;
> +		debug_objects_enabled = false;
>  	return res;
>  }
>  
> @@ -1278,7 +1277,7 @@ static bool __init debug_objects_selftes
>  	descr_test = NULL;
>  
>  	local_irq_restore(flags);
> -	return !!debug_objects_enabled;
> +	return debug_objects_enabled;
>  }
>  #else
>  static inline bool debug_objects_selftest(void) { return true; }
> @@ -1372,7 +1371,7 @@ void __init debug_objects_mem_init(void)
>  				  SLAB_DEBUG_OBJECTS | SLAB_NOLEAKTRACE, NULL);
>  
>  	if (!cache || !debug_objects_replace_static_objects(cache)) {
> -		debug_objects_enabled = 0;
> +		debug_objects_enabled = false;
>  		pr_warn("Out of memory.\n");
>  		return;
>  	}
> 
> .
> 

-- 
Regards,
  Zhen Lei

