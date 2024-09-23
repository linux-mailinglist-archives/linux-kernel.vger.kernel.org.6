Return-Path: <linux-kernel+bounces-335770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 869B097EA67
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 13:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B79DA1C21162
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 11:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32206197A92;
	Mon, 23 Sep 2024 11:02:05 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69947DA95
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 11:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727089324; cv=none; b=WNT4n5t+EgMjuhgugrn6lf4osVRLbFkE17wFPreiIXvzzxl5m6xAV79WPK3VUO6zMHM/xvghla/YGXyKnHCmnZIAJOVbJBYwbcBQtfS60xsdRcLlrwO/MOpwT++1/8/WkJSQEWdEYsvXbHy89JlReIac6uYYk0/bjtYZjfU8cwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727089324; c=relaxed/simple;
	bh=HHb/KxNxLPIpqB70CQcSiJsQIsXJlw6dXS3JHI6hr7E=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=pbid1fJkrvQxuGP6awCgxDQnuzh+WLPeHsNH3FmYYdnyWdXz9NpyMq5XnsGcDbpZ8IN6ydxxp4L0GUaATa7gSw+Eq1SnLcHrBCbLSgnuDqWbIsfFVZNAfS79I/JLjgJR2SYH6TmZO+F+6pfZWq5yGYvfX0HTnGEZ04AhWxjawIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XC0Mk3dKJz1HKWw;
	Mon, 23 Sep 2024 18:58:10 +0800 (CST)
Received: from kwepemm000013.china.huawei.com (unknown [7.193.23.81])
	by mail.maildlp.com (Postfix) with ESMTPS id C99C61A016C;
	Mon, 23 Sep 2024 19:01:58 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm000013.china.huawei.com (7.193.23.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 23 Sep 2024 19:01:58 +0800
Subject: Re: [PATCH v1] jffs2: Correct some typos in comments
To: Shen Lichuan <shenlichuan@vivo.com>, <dwmw2@infradead.org>,
	<richard@nod.at>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<opensource.kernel@vivo.com>
References: <20240923083322.13383-1-shenlichuan@vivo.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <ece4eab6-b8e6-603a-5c59-26c025d394bb@huawei.com>
Date: Mon, 23 Sep 2024 19:01:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240923083322.13383-1-shenlichuan@vivo.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm000013.china.huawei.com (7.193.23.81)

ÔÚ 2024/9/23 16:33, Shen Lichuan Ð´µÀ:
> Fixed some confusing spelling errors, the details are as follows:
> 
> -in the code comments:
> 	wating		-> waiting
> 	succefully	-> successfully
> 
> Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>
> ---
>   fs/jffs2/gc.c        | 2 +-
>   fs/jffs2/readinode.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
> diff --git a/fs/jffs2/gc.c b/fs/jffs2/gc.c
> index 822949d0eb00..1b833bbffcf5 100644
> --- a/fs/jffs2/gc.c
> +++ b/fs/jffs2/gc.c
> @@ -82,7 +82,7 @@ static struct jffs2_eraseblock *jffs2_find_gc_block(struct jffs2_sb_info *c)
>   
>   		nextlist = &c->erasable_list;
>   	} else if (!list_empty(&c->erasable_pending_wbuf_list)) {
> -		/* There are blocks are wating for the wbuf sync */
> +		/* There are blocks are waiting for the wbuf sync */
>   		jffs2_dbg(1, "Synching wbuf in order to reuse erasable_pending_wbuf_list blocks\n");
>   		spin_unlock(&c->erase_completion_lock);
>   		jffs2_flush_wbuf_pad(c);
> diff --git a/fs/jffs2/readinode.c b/fs/jffs2/readinode.c
> index 03b4f99614be..f987f78a894e 100644
> --- a/fs/jffs2/readinode.c
> +++ b/fs/jffs2/readinode.c
> @@ -72,7 +72,7 @@ static int check_node_data(struct jffs2_sb_info *c, struct jffs2_tmp_dnode_info
>   		if (err != -EOPNOTSUPP)
>   			JFFS2_WARNING("MTD point failed: error code %d.\n", err);
>   	} else
> -		pointed = 1; /* succefully pointed to device */
> +		pointed = 1; /* successfully pointed to device */
>   #endif
>   
>   	if (!pointed) {
> 


