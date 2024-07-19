Return-Path: <linux-kernel+bounces-257076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 799469374C5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 10:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 348FD2820C9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 08:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B69B7CF18;
	Fri, 19 Jul 2024 08:10:00 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB78F69D31
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 08:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721376599; cv=none; b=g/7fJ03wJq5brc3+TCVnipsQyxYdmjM7pFWPPVtwCoHyi05r77pYUdO+z2nRNc2Qt4jmn6ZesCZOfn2hVsqCw0exdQAks+9bD5YsHV9pw+QEFd+U4GlnCoIevzry1pGT3uGvVHek5fiCcpmjDhKI5HhxhXUBQ2drITLWt98lGdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721376599; c=relaxed/simple;
	bh=HSjCb87FYSLTdA8woQq22bDig16Cqq6RXBX+wQFgsJw=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=KOFTSeH1j4nkWO/yfWbOjW1N6loPP5cv3fKMcRP+K84L1I+dYPEj50h8vV9IA45kQUnLHjr/nZFzd2w37fIdFCRsHzuhxbh/+usFoS7syaPVThq84/J1dcI0ZL6U54s0VCQKqpkUIZn35TL0AqUl4WtMOaqdy/dcc4OZFErUo5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WQMfZ38yhzyN4B;
	Fri, 19 Jul 2024 16:05:10 +0800 (CST)
Received: from kwepemm000013.china.huawei.com (unknown [7.193.23.81])
	by mail.maildlp.com (Postfix) with ESMTPS id 646841800A5;
	Fri, 19 Jul 2024 16:09:55 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm000013.china.huawei.com (7.193.23.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 19 Jul 2024 16:09:54 +0800
Subject: Re: [PATCH] mtd: ubi: remove __exit annotation on ubiblock_exit
To: Arnd Bergmann <arnd@kernel.org>, Richard Weinberger <richard@nod.at>,
	Miquel Raynal <miquel.raynal@bootlin.com>, Vignesh Raghavendra
	<vigneshr@ti.com>, Ben Hutchings <ben.hutchings@mind.be>
CC: Arnd Bergmann <arnd@arndb.de>, Li Nan <linan122@huawei.com>, Daniel Golle
	<daniel@makrotopia.org>, Jens Axboe <axboe@kernel.dk>, ZhaoLong Wang
	<wangzhaolong1@huawei.com>, <linux-mtd@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20240719073912.2743171-1-arnd@kernel.org>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <92d8047d-1bee-d100-fd3f-ec27f030b1e5@huawei.com>
Date: Fri, 19 Jul 2024 16:09:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240719073912.2743171-1-arnd@kernel.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm000013.china.huawei.com (7.193.23.81)

ÔÚ 2024/7/19 15:39, Arnd Bergmann Ð´µÀ:
Hi, Arnd
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Calling an __exit function from an __init function leads to undefined behavior
> when the drier is built-in and the __exit functions are dropped from the
> object:
> 
> WARNING: modpost: drivers/mtd/ubi/ubi: section mismatch in reference: ubi_init+0xbe (section: .init.text) -> ubiblock_exit (section: .exit.text)
> ERROR: modpost: Section mismatches detected.
> Set CONFIG_SECTION_MISMATCH_WARN_ONLY=y to allow them.
> 
> Remove the now incorrect annotation.
> 
> Fixes: 72f3d3daddd7 ("mtd: ubi: Restore missing cleanup on ubi_init() failure path")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/mtd/ubi/block.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Richard has sent the same modification, see
https://lore.kernel.org/linux-mtd/9a210424-eac1-957e-dd6e-4290924216e3@huawei.com/T/#mdefbd793992635f6a236a626dd7d3a296fb9820e

> 
> diff --git a/drivers/mtd/ubi/block.c b/drivers/mtd/ubi/block.c
> index bf7308e8ec2f..60d0155be869 100644
> --- a/drivers/mtd/ubi/block.c
> +++ b/drivers/mtd/ubi/block.c
> @@ -670,7 +670,7 @@ int __init ubiblock_init(void)
>   	return ret;
>   }
>   
> -void __exit ubiblock_exit(void)
> +void ubiblock_exit(void)
>   {
>   	ubi_unregister_volume_notifier(&ubiblock_notifier);
>   	ubiblock_remove_all();
> 


