Return-Path: <linux-kernel+bounces-342734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF82989264
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 03:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6DEE1F23AAD
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 01:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318E5AD2F;
	Sun, 29 Sep 2024 01:16:22 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4A017C
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 01:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727572581; cv=none; b=Hv8AJzmnC5U7eKHtiYb3QMZ/sC33ZIxQPv+NUDW686XLWzHfhtca+l+/QJpZSzkH/dHkgGymgcDEJzztiR8Ym7Zt4jhoBe5sAQmFhviSmJOqMXq14eqU9Ej/SJk166+tI7b++syzr9LBpeyrSqG/uaCFP7t4eN88+0jbcbNzBh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727572581; c=relaxed/simple;
	bh=lBRNsGuhOo4TOee1NZmUbFYNejacWT3b5bQOh8WdNM8=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=RgJ5Ytl+TXxICZMrOdawFVFzBY5r8/PUHYunzF8pNmW6otTQcoY/sXxeGbe8qmo+NEOARXc6jsIjj1Nvyj8GgEWyXa8Oj4UsSUmArhOWcnEfwkFJw2A+YhT98JILQkhaoamZEkkK6Wy1JTyn8FPhshwqyoUjtOoi2wD57T8gWKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4XGR8w3rJ7zFqyP;
	Sun, 29 Sep 2024 09:15:44 +0800 (CST)
Received: from kwepemm000013.china.huawei.com (unknown [7.193.23.81])
	by mail.maildlp.com (Postfix) with ESMTPS id F3CBF140133;
	Sun, 29 Sep 2024 09:16:09 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm000013.china.huawei.com (7.193.23.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 29 Sep 2024 09:16:09 +0800
Subject: Re: [PATCH RESEND] ubifs: xattr: remove unused anonymous enum
To: <pascal.eberhard@gmail.com>, Richard Weinberger <richard@nod.at>
CC: <miquel.raynal@bootlin.com>, Pascal Eberhard <pascal.eberhard@se.com>,
	<linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240927145757.347630-1-pascal.eberhard@gmail.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <f6cbf88c-733d-95a1-c959-b2045b9edea8@huawei.com>
Date: Sun, 29 Sep 2024 09:16:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240927145757.347630-1-pascal.eberhard@gmail.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm000013.china.huawei.com (7.193.23.81)

ÔÚ 2024/9/27 22:57, pascal.eberhard@gmail.com Ð´µÀ:
> From: Pascal Eberhard <pascal.eberhard@se.com>
> 
> commit 2b88fc21cae9 ("ubifs: Switch to generic xattr handlers") removes
> usage of this anonymous enum. Delete the enum as well.
> 
> Signed-off-by: Pascal Eberhard <pascal.eberhard@se.com>
> ---
>   fs/ubifs/xattr.c | 13 -------------
>   1 file changed, 13 deletions(-)
> 

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
> diff --git a/fs/ubifs/xattr.c b/fs/ubifs/xattr.c
> index 3db8486e3725..32927bf98306 100644
> --- a/fs/ubifs/xattr.c
> +++ b/fs/ubifs/xattr.c
> @@ -48,19 +48,6 @@
>   #include <linux/slab.h>
>   #include <linux/xattr.h>
>   
> -/*
> - * Extended attribute type constants.
> - *
> - * USER_XATTR: user extended attribute ("user.*")
> - * TRUSTED_XATTR: trusted extended attribute ("trusted.*)
> - * SECURITY_XATTR: security extended attribute ("security.*")
> - */
> -enum {
> -	USER_XATTR,
> -	TRUSTED_XATTR,
> -	SECURITY_XATTR,
> -};
> -
>   static const struct inode_operations empty_iops;
>   static const struct file_operations empty_fops;
>   
> 


