Return-Path: <linux-kernel+bounces-266637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E2B9403F3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 03:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D59E51F221FC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 01:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF22C8C0;
	Tue, 30 Jul 2024 01:44:00 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61148C1F
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 01:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722303840; cv=none; b=OHqSzekT0nH5E3mZMDtO6uEX36xKcvTLHdWnN6lK4rxypQVYPVFhfqfRC6ZIyGtLGIo2L14wVEpoAE6O9cQuAqGc3WU9UOJMTb9gCWqlbrttF78ISk6LESHUosTZqDU5ZD15Z2J6lxKpe8iwClAe0TLxadc1w5J5v7wKcc9Lk9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722303840; c=relaxed/simple;
	bh=QkxBfiQBHrGJ5wbeJUZYGiL5AclLsObk64i7QTwenno=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=phcf1lqY4ZJi5SwyGGBTVcPoJ+Kws4vhCtbDsZLkr7rgElSYAfJ7O7wD0FmmA/l8pnipNbdvxBdJmwOkNbaMCytc7FGFr2aSSeISQZaawfqJW0Il7mXgPKM3NwWksBslXSyx2MktSPOA+TgrqXYjyy0qNxFRVVo6fHzXZFCADts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WXyZf24M4zPtD4;
	Tue, 30 Jul 2024 09:39:38 +0800 (CST)
Received: from kwepemg200002.china.huawei.com (unknown [7.202.181.29])
	by mail.maildlp.com (Postfix) with ESMTPS id B580F14011A;
	Tue, 30 Jul 2024 09:43:55 +0800 (CST)
Received: from [10.67.111.115] (10.67.111.115) by
 kwepemg200002.china.huawei.com (7.202.181.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 30 Jul 2024 09:43:55 +0800
Message-ID: <cc65b43b-5e6a-4eaf-83cc-ee9e4bc57265@huawei.com>
Date: Tue, 30 Jul 2024 09:43:54 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] irqchip/mbigen: Fix mbigen node address layout
To: Thomas Gleixner <tglx@linutronix.de>, <maz@kernel.org>,
	<majun258@huawei.com>, <guohanjun@huawei.com>, <wangwudi@hisilicon.com>,
	<liaochang1@huawei.com>, <linux-kernel@vger.kernel.org>
References: <20240720013538.3251995-1-zouyipeng@huawei.com>
 <87r0bc8pxp.ffs@tglx>
Content-Language: en-US
From: Yipeng Zou <zouyipeng@huawei.com>
In-Reply-To: <87r0bc8pxp.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemg200002.china.huawei.com (7.202.181.29)

Hi Thomas:

     Reword it in v2.

https://lore.kernel.org/all/20240730014400.1751530-1-zouyipeng@huawei.com/T/#u

在 2024/7/29 18:15, Thomas Gleixner 写道:
> On Sat, Jul 20 2024 at 09:35, Yipeng Zou wrote:
>> Mbigen chip contains several mbigen nodes, and mapped address space per
>> nodes one by one.
>>
>>                      mbigen chip
>>         |-----------------|------------|--------------|
>>     mgn_node_0         mgn_node_1     ...         mgn_node_i
>> |--------------|   |--------------|       |----------------------|
>> [0x0000, 0x1000)   [0x1000, 0x2000)       [i*0x1000, (i+1)*0x1000)
>>
>> Mbigen also defined a clear register with all other mbigen nodes in
>> uniform address space.
>>
>>                           mbigen chip
>>      |-----------|--------|--------|---------------|--------|
>> mgn_node_0  mgn_node_1  ...  mgn_clear_register  ...   mgn_node_i
>>                              |-----------------|
>>                               [0xA000, 0xB000)
>>
>> Everything is OK for now, when the mbigen nodes number less than 10,
>> there is no conflict with clear register.
>>
>> Once we defined mbigen node more than 10, it's going to touch clear
>> register in unexpected way.
>>
>> There should have a gap of 0x1000 between mgn_node9 and mgn_node10.
>>
>> The simplest solution is directly skip clear register when access to
>> more than 10 mbigen nodes.
> I see what you are trying to tell. Something like this makes it more
> clear:
>
>     The mbigen interrupt chip has its per node registers located in a
>     contiguous region of page sized chunks. The code maps them into
>     virtual address space as a contiguous region and determines the
>     address of a node by using the node ID as index.
>
>     This works correctly up to 10 nodes, but then fails because the
>     11th's array slot is used for the MGN_CLEAR registers.
>
>     Skip the MGN_CLEAR register space when calculating the offset for
>     node IDs greater or equal ten.
>
> Hmm?
>
>> Fixes: a6c2f87b8820 ("irqchip/mbigen: Implement the mbigen irq chip operation functions")
>> Signed-off-by: Yipeng Zou <zouyipeng@huawei.com>
>> ---
>>   drivers/irqchip/irq-mbigen.c | 18 ++++++++++++++++--
>>   1 file changed, 16 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
>> index 58881d313979..b600637f5cd7 100644
>> --- a/drivers/irqchip/irq-mbigen.c
>> +++ b/drivers/irqchip/irq-mbigen.c
>> @@ -64,6 +64,20 @@ struct mbigen_device {
>>   	void __iomem		*base;
>>   };
>>   
>> +static inline unsigned int get_mbigen_node_offset(unsigned int nid)
>> +{
>> +	unsigned int offset = nid * MBIGEN_NODE_OFFSET;
>> +
>> +	/**
> This is not a kernel doc comment. Please use '/*'
>
>> +	 * To avoid touched clear register in unexpected way, we need to directly
>> +	 * skip clear register when access to more than 10 mbigen nodes.
>> +	 */
>> @@ -72,7 +86,7 @@ static inline unsigned int get_mbigen_vec_reg(irq_hw_number_t hwirq)
>>   	nid = hwirq / IRQS_PER_MBIGEN_NODE + 1;
>>   	pin = hwirq % IRQS_PER_MBIGEN_NODE;
>>   
>> -	return pin * 4 + nid * MBIGEN_NODE_OFFSET
>> +	return pin * 4 + get_mbigen_node_offset(nid)
>>   			+ REG_MBIGEN_VEC_OFFSET;
> Please get rid of these pointless line breaks.
>
> Thanks,
>
>          tglx

-- 
Regards,
Yipeng Zou


