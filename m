Return-Path: <linux-kernel+bounces-549134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09AC5A54DE9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 15:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43195168B49
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 14:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A4A16D9AA;
	Thu,  6 Mar 2025 14:35:57 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCCF70838
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 14:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741271757; cv=none; b=jcbAF8McypfwdciA9xPjwmgYHn83XYS9q98CEcH+3e1SJf2PZxVGLFr48VLxuNyXCozcPm46umXwvg7vNFdlPv6sYIjfJM1gKd8qbANHtbk0my1WDFQ5LMpAl6MlwAIzvWwUB2E6vE/FwBu2cbU/L16B/FTPOj/fvc9me6IMyPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741271757; c=relaxed/simple;
	bh=wtFFuTxcfMslv6SxPuzbH2ohFV+Ccz/6dlOARsPXUCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YPFDUPI3jicT5Njk9R07VxJBgknWgPx/YGcmh4YmzoSxEYxH49L94wvdqyWgtKc/oQINdVPvGs2b7nR4AEyDharE96tfBFZpHBjvte6kmrGRWyqX+OyxIlfQ85rbYJ0kKlhJPqZOV38UBaWhUCGQADrxFbwy5lA/6PPMk/SUA4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Z7sLJ6ZQcz1f08P;
	Thu,  6 Mar 2025 22:31:36 +0800 (CST)
Received: from kwepemd500013.china.huawei.com (unknown [7.221.188.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 9C90F1402C1;
	Thu,  6 Mar 2025 22:35:51 +0800 (CST)
Received: from [10.159.166.136] (10.159.166.136) by
 kwepemd500013.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 6 Mar 2025 22:35:50 +0800
Message-ID: <14555bcf-933d-4322-b1a6-d33e37c55500@huawei.com>
Date: Thu, 6 Mar 2025 22:35:49 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 drm-dp 3/8] drm/hisilicon/hibmc: Add dp serdes cfg in
 dp process
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <xinliang.liu@linaro.org>, <tiantao6@hisilicon.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<kong.kongxinwei@hisilicon.com>, <liangjian010@huawei.com>,
	<chenjianmin@huawei.com>, <lidongming5@huawei.com>, <libaihan@huawei.com>,
	<shenjian15@huawei.com>, <shaojijie@huawei.com>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
	<shiyongbang@huawei.com>
References: <20250305112647.2344438-1-shiyongbang@huawei.com>
 <20250305112647.2344438-4-shiyongbang@huawei.com>
 <bg5yiyru6fqnm73qctgullgsdnywdnv2zbcy72mvglxf2uttp4@v2cmuekciqgm>
From: Yongbang Shi <shiyongbang@huawei.com>
In-Reply-To: <bg5yiyru6fqnm73qctgullgsdnywdnv2zbcy72mvglxf2uttp4@v2cmuekciqgm>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd500013.china.huawei.com (7.221.188.12)

> On Wed, Mar 05, 2025 at 07:26:42PM +0800, Yongbang Shi wrote:
>> From: Baihan Li <libaihan@huawei.com>
>>
>> Add dp serdes cfg in link training process, and related adapting
>> and modificating. Change some init values about training,
>> because we want completely to negotiation process, so we start with
>> the maximum rate and the electrical characteristic level is 0.
> In the commit message there should be a mention, why are you also
> changing hibmc_kms_init().
>
>> Signed-off-by: Baihan Li <libaihan@huawei.com>
>> Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
>> ---
>> ChangeLog:
>> v3 -> v4:
>>    - add comments for if-statement of dp_init(), suggested by Dmitry Baryshkov.
>> v2 -> v3:
>>    - change commit to an imperative sentence, suggested by Dmitry Baryshkov.
>>    - put HIBMC_DP_HOST_SERDES_CTRL in dp_serdes.h, suggested by Dmitry Baryshkov.
>> v1 -> v2:
>>    - splittting the patch and add more detailed the changes in the commit message, suggested by Dmitry Baryshkov.
>> ---
>>   1                                             |  0
>>   .../gpu/drm/hisilicon/hibmc/dp/dp_config.h    |  1 +
>>   drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c    |  5 ++-
>>   drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c  | 32 ++++++++++++++++---
>>   drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h   |  5 +++
>>   .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c   | 12 +++----
>>   6 files changed, 43 insertions(+), 12 deletions(-)
>>   create mode 100644 1
>>
> [...]
>
>> @@ -121,9 +119,11 @@ static int hibmc_kms_init(struct hibmc_drm_private *priv)
>>   		return ret;
>>   	}
>>   
>> -	/* if DP existed, init DP */
>> -	if ((readl(priv->mmio + HIBMC_DP_HOST_SERDES_CTRL) &
>> -	     HIBMC_DP_HOST_SERDES_CTRL_MASK) == HIBMC_DP_HOST_SERDES_CTRL_VAL) {
>> +	/* if the serdes reg is readable and is not equal to 0,
>> +	 * DP existed, and init DP.
>> +	 */
> Nit: A typical format for block comments is:
>
>    /*
>     * Something Something Something
>     */
>
> Please follow it.

Ok, got it.


>> +	ret = readl(priv->mmio + HIBMC_DP_HOST_SERDES_CTRL);
>> +	if (ret) {
>>   		ret = hibmc_dp_init(priv);
>>   		if (ret)
>>   			drm_err(dev, "failed to init dp: %d\n", ret);
>> -- 
>> 2.33.0
>>

