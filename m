Return-Path: <linux-kernel+bounces-243469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC349296A9
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 06:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8511A1C21637
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 04:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8ACA79F2;
	Sun,  7 Jul 2024 04:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HU9U8xM4"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9B56FBE;
	Sun,  7 Jul 2024 04:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720327787; cv=none; b=UVdxOLtrCBhBjfHgdJDWe63u4RMxhcxeuk/IKMB1H19fO/azvJG4KUH5vDBAj4c7l2I9P+ENb6269LQUYS6kAeOAKvxVTQYL2qTN4ZSMr3IMpo5f1rCmL2fI4GjMOHJZwmKyykjt1ipHcgFTXnrjtGTYh93rl2wzVGrMHkZRSr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720327787; c=relaxed/simple;
	bh=3yQUOdWGGlite3PmIN2JR0q4wtiJMITI/xawb/GHj+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=c0raDyT4a9Hhc494tnGRxvh8zMz5ot6sUPLvB1VhYVTqdpX4zD1EXDaHiROV5YOuyo7fIArE3jDzcvUMDOcKMkLoo9IjjNEMPHI2FV8UeXUi1L/9JHa455FEkPFkxVbf3yE1x6Tf5XJUPXT6ram/Bste0Yctj9PvUN/WEG8sd4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HU9U8xM4; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
	bh=/iRYTj6Ia6uJVeiNwGIPPaaRMWCATY1s2l3SF0l4Yy8=; b=HU9U8xM4Y/CWzcFTvG6MH+LRYV
	GmCj86ScoaeiYV6av0DyuIL5ocCJxTNrdTUVbYIcsHvPx9mD3KBMsqJAS7fKoKbz7mhoe8H1dqsa1
	7RpPXC4iG33SEOcSIsM+JMmcSY+4UK5FMz0G8uHl9Zs1cf7ZMkA40E7MbUUd8YXUNgAJEqLcyh0FP
	c/SSnMiQEly8qWw053UKS5nsrEhgQIlAQ0pv+HGTIrDBenlQk4qaYDnkPrwtcRwF7zhbh4sLE3v6r
	xARyGacOe3zCqQG3YovUIbCjrv1dTmYD2FBQxApDNoSD+lbA0GyY1oiFP45lCt31EFpQiZHyL22di
	MIW8oqlA==;
Received: from [50.53.4.147] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQJqK-00000001LWd-2zL2;
	Sun, 07 Jul 2024 04:49:44 +0000
Message-ID: <fe856e10-f7b1-49a4-a01e-d1a9188aac63@infradead.org>
Date: Sat, 6 Jul 2024 21:49:44 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] Removed extra asterisks from comment beginnings, and
 removed unnecessary comment end
To: Gold Side <goldside000@outlook.com>, "krzk@kernel.org" <krzk@kernel.org>,
 "perex@perex.cz" <perex@perex.cz>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
 "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>
References: <DM4P223MB0541357D7B105C83EF9FCFD5F7D92@DM4P223MB0541.NAMP223.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <DM4P223MB0541357D7B105C83EF9FCFD5F7D92@DM4P223MB0541.NAMP223.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 7/6/24 9:14 PM, Gold Side wrote:
> From 3574f0514207f9610a69d82d3dd0d018d6dce5dd Mon Sep 17 00:00:00 2001
> From: Steven Davis <goldside000@outlook.com>
> Date: Tue, 2 Jul 2024 22:57:24 -0400
> Subject: [PATCH 1/3] Removed extra asterisk from comment beginning
> 
> It saves a byte. I'd imagine bytes are valuable in a project like this.

Don't think so.

> PS: Please forgive my previous patch email, I didn't know the guidelines well.
> Signed-off-by: Steven Davis <goldside000@outlook.com
> ---
>  kernel/module/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index d18a94b973e102..25e456f4381c71 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -450,7 +450,7 @@ bool __is_module_percpu_address(unsigned long addr, unsigned long *can_addr)
>       return false;
>  }
>  
> -/**
> +/*
>   * is_module_percpu_address() - test whether address is from module static percpu
>   * @addr: address to test
>   *

"/**" means "begin kernel-doc comment." Documentation is important.

Also, why drop one asterisk for this function and not for the other 5 functions in this source
file that use "/**" to begin a kernel-doc comment block?


-- 
~Randy

