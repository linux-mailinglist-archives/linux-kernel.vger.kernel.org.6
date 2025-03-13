Return-Path: <linux-kernel+bounces-558685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA96A5E967
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 02:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FD3E1794C8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 01:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F6422612;
	Thu, 13 Mar 2025 01:24:28 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5DF6FC5
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 01:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741829068; cv=none; b=eA07tXOd4YAHwF1MiEl5t8oUc6wUusLuhKk51kQWldPPb72ZI7pIXh115RCCYDjBjPg2cFz/mLtoQ2jVDGnnXTCEZ6pGg6iBJw2FOXVogzHrCX0FtnDNkzvMUnIbF3N07mio9hjlsN1ns1f2u9UPvOuGv4/1gWOAaH0riJUr4y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741829068; c=relaxed/simple;
	bh=5gWzzDmdRIXhRby/tb2xw0gaynMvN0po91zTqtzGZ7g=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=cYanNXkm+wxsLNpoN3PZeTqWw0/4NzVhoJuofyCq7K/6jZoRncb7BGvo0s8WUAPPo4QmiG3INKKoYv3B9jc5DXNoh+SGOyN7ZBAwOkpAyYRhAfbKwFOB1KfR8gs569Sm4L875BC46uLpMKPtrttrzm6msXhmNgkpAKzIci89eds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4ZCqSd62pfzCs76;
	Thu, 13 Mar 2025 09:20:49 +0800 (CST)
Received: from kwepemk500005.china.huawei.com (unknown [7.202.194.90])
	by mail.maildlp.com (Postfix) with ESMTPS id E0A421402DB;
	Thu, 13 Mar 2025 09:24:22 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemk500005.china.huawei.com (7.202.194.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 13 Mar 2025 09:24:22 +0800
Subject: Re: [PATCH v1 1/1] mtd: mtdpart: Do not supply NULL to printf()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	<linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger
	<richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
References: <20250312201649.217555-1-andriy.shevchenko@linux.intel.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <e6616c70-7579-6114-95b0-3c4a94f98aa0@huawei.com>
Date: Thu, 13 Mar 2025 09:24:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250312201649.217555-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemk500005.china.huawei.com (7.202.194.90)

在 2025/3/13 4:16, Andy Shevchenko 写道:
> Compiler is not happy about NULL being supplied as printf() parameter:

printf -> printk? The title has the same issue.
> 
> drivers/mtd/mtdpart.c:693:34: error: ‘%s’ directive argument is null [-Werror=format-overflow=]
> 
> Replace that with "(null)" to fix compilation error.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/mtd/mtdpart.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
> diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
> index 6811a714349d..6f7e250ef710 100644
> --- a/drivers/mtd/mtdpart.c
> +++ b/drivers/mtd/mtdpart.c
> @@ -691,7 +691,7 @@ int parse_mtd_partitions(struct mtd_info *master, const char *const *types,
>   			if (!parser && !request_module("%s", *types))
>   				parser = mtd_part_parser_get(*types);
>   			pr_debug("%s: got parser %s\n", master->name,
> -				parser ? parser->name : NULL);
> +				parser ? parser->name : "(null)");
>   			if (!parser)
>   				continue;
>   			ret = mtd_part_do_parse(parser, master, &pparts, data);
> 


