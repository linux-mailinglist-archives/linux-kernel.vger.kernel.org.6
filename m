Return-Path: <linux-kernel+bounces-559559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA7EA5F57D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44C187AE2FC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D136B267720;
	Thu, 13 Mar 2025 13:09:21 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BA2263F2F
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 13:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741871361; cv=none; b=VtxRut4GKyyWWVlVJWKQVqktbXuQLyzQNey6pwd51s6W8hI5t3Gm5ksfKarLT7ngOoQmN8Pp20AC9zOw4w1pBMb7gzEG3zyES1O44kGQSXOFfuuJ5HBLs842XzSqjqgmk/jWrtyzj5bEEiYdar5zy7sl6mT3eP+v2hmUSYaDcXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741871361; c=relaxed/simple;
	bh=8JHjtSoOIu0jVaLxOXIaTWk5AVwnRQ9BqhKHUcJKRMA=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=NmqO8oaiP+vbhDeJH40fByEFYp4R5pPO4j7rz7KxZkYQCNCS3taeJ0uehlOJTtLPBbakZ4bNNEzFifIp6cHz6kH7jNL2OsJaUJ4NQROlyWD+hwczmWBDBKVzof4j2GtuCr6LBfpm2ubm9pI/BlkO9tbEZxUE79j2MUgUJ/uWulI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4ZD79s16TTz1cyt7;
	Thu, 13 Mar 2025 21:09:05 +0800 (CST)
Received: from kwepemk500005.china.huawei.com (unknown [7.202.194.90])
	by mail.maildlp.com (Postfix) with ESMTPS id 126CB180102;
	Thu, 13 Mar 2025 21:09:11 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemk500005.china.huawei.com (7.202.194.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 13 Mar 2025 21:09:10 +0800
Subject: Re: [PATCH v2 1/1] mtd: mtdpart: Do not supply NULL to printf()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	<linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger
	<richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
References: <20250313091631.243346-1-andriy.shevchenko@linux.intel.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <f17a1851-7360-3f18-4e89-dbf6948eeaff@huawei.com>
Date: Thu, 13 Mar 2025 21:09:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250313091631.243346-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemk500005.china.huawei.com (7.202.194.90)

在 2025/3/13 17:15, Andy Shevchenko 写道:
> GCC compiler is not happy about NULL being supplied as printf() parameter:
> 
> drivers/mtd/mtdpart.c:693:34: error: ‘%s’ directive argument is null [-Werror=format-overflow=]
> 
> Move the code after the parser test for NULL, and drop the ternary completely.
> The user can deduct this since when it's not NULL two messages will be printed.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> 
> v2: changed approach to remove that ternary completely, seems less hackish
> 
>   drivers/mtd/mtdpart.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
> 
> diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
> index 6811a714349d..994e8c51e674 100644
> --- a/drivers/mtd/mtdpart.c
> +++ b/drivers/mtd/mtdpart.c
> @@ -690,10 +690,9 @@ int parse_mtd_partitions(struct mtd_info *master, const char *const *types,
>   			parser = mtd_part_parser_get(*types);
>   			if (!parser && !request_module("%s", *types))
>   				parser = mtd_part_parser_get(*types);
> -			pr_debug("%s: got parser %s\n", master->name,
> -				parser ? parser->name : NULL);
>   			if (!parser)
>   				continue;
> +			pr_debug("%s: got parser %s\n", master->name, parser->name);
>   			ret = mtd_part_do_parse(parser, master, &pparts, data);
>   			if (ret <= 0)
>   				mtd_part_parser_put(parser);
> 


