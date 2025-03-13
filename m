Return-Path: <linux-kernel+bounces-559272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD12A5F19E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 11:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0970A3A34AD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 10:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1809A266567;
	Thu, 13 Mar 2025 10:54:48 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76A82661B1
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 10:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741863287; cv=none; b=Xd76luvDs8dcz/9Aoxt0E7U5u4s5zOHCR1Uk20jY02YrRG+ZSKDVDAJ+R/FREkrj4bebKEv/0TdXT3WpnCWj+fGOyfvPINaijsKHf5hxLa8EtcJ0+vOYOm7Lu50TXhzl+tIgQb3B2WucnU5GVimquoZa8deVHeRbjitCa9eZ7gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741863287; c=relaxed/simple;
	bh=Ml9jQYEbTME5Qq9lZTuJ/fc9iJdg/88w+/ERzDyfzww=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Lo2JlX79wBWEeJQu5xdJw3zy5f8soM/VBzE2HFzTDLtwdMfeW3eewIKshhYL6oZSi9JtTscAKPZJz9f9p6Zoew8rVSeFgAxuSTGnRJCoeLm9KX9zf3QYTbAZ337BcVy1M6/JOVkXiLBsoY3ltEZnzK8wbJ3pjLrBjZ8dBfLA6V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4ZD4766KKzzCtLd;
	Thu, 13 Mar 2025 18:51:30 +0800 (CST)
Received: from kwepemk500005.china.huawei.com (unknown [7.202.194.90])
	by mail.maildlp.com (Postfix) with ESMTPS id 5F8DC1402CC;
	Thu, 13 Mar 2025 18:54:42 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemk500005.china.huawei.com (7.202.194.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 13 Mar 2025 18:54:41 +0800
Subject: Re: [PATCH v1 1/1] mtd: mtdpart: Do not supply NULL to printf()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>, Miquel
 Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
References: <20250312201649.217555-1-andriy.shevchenko@linux.intel.com>
 <e6616c70-7579-6114-95b0-3c4a94f98aa0@huawei.com>
 <Z9KgxKocER3R1aPN@smile.fi.intel.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <a5d38df2-4679-9bb9-4b01-2cfa184cd1be@huawei.com>
Date: Thu, 13 Mar 2025 18:54:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Z9KgxKocER3R1aPN@smile.fi.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemk500005.china.huawei.com (7.202.194.90)

在 2025/3/13 17:09, Andy Shevchenko 写道:
> On Thu, Mar 13, 2025 at 09:24:21AM +0800, Zhihao Cheng wrote:
>> 在 2025/3/13 4:16, Andy Shevchenko 写道:
>>> Compiler is not happy about NULL being supplied as printf() parameter:
>>
>> printf -> printk? The title has the same issue.
>>>
>>> drivers/mtd/mtdpart.c:693:34: error: ‘%s’ directive argument is null [-Werror=format-overflow=]
>>>
>>> Replace that with "(null)" to fix compilation error.
> 
>> Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
> 
> Thank you!
> 
> But I think my approach is a hack, the best is to move this message to the
> after the follow up conditional and drop that ternary completely as we have
> already another debug message before that. So, the parser == NULL can be
> deducted from the appearance of the one and not the other one.
> 
> I'll send a v2.
> 
>>>    			if (!parser && !request_module("%s", *types))
>>>    				parser = mtd_part_parser_get(*types);
>>>    			pr_debug("%s: got parser %s\n", master->name,
>>> -				parser ? parser->name : NULL);
>>> +				parser ? parser->name : "(null)");
>>>    			if (!parser)
>>>    				continue;
> 
> (move it here)

After looking through 8e2c992b59fc("mtd: mtdpart: add debug prints to 
partition parser.") and 01f9c7240a90("mtd: partitions: factor out code 
calling parser"), I think we'd better keep the debug message before the 
condition 'if (!parser)', it is used to inform us whether we get a 
parser and which name it is. And the debug message in mtd_part_do_parse 
informs us the result of the 'parser->parse_fn'.
> 
>>>    			ret = mtd_part_do_parse(parser, master, &pparts, data);
> 


