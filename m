Return-Path: <linux-kernel+bounces-280345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6FF94C911
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 06:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A6371F2393F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 04:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2190D199B9;
	Fri,  9 Aug 2024 04:06:35 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3AD4C8E
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 04:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723176394; cv=none; b=ukVbOu4Pb7InUmYZkGzzhsUr7fKPe3W2E5flOH/WKo5/YYJgluiYR6OwHcade6P+gCjY7zZ5qi1WHd4FDHSNe19sN8x6lwyrgP/niFj4HnguLnQkh7Ln1JfBd0PiER+qW5vBVnp7yES0NcSnWUKZiYietZangbB/IEFy1zAgc10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723176394; c=relaxed/simple;
	bh=xFXvA8kdXDD+b1/G8d2aM7CiyidGoi6gzp9b/O5m27k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eAqFLmbRJRle7594FxZZVmIf5oGCXesskcHC2zjUflkLXoSDAKmt0igPuJ2hGNGisq7vHxn8tLz5zC/03n5h6v+IQ9GxAw3b42/eY5iOS+d5a0qH3IAKjztLfq2WEuIH5+nGcS/jujngRjS9fX6YQqL1FSuBiGiRKYWg12JJk8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Wg9Fw3nMMz1S7Rr;
	Fri,  9 Aug 2024 12:01:40 +0800 (CST)
Received: from kwepemm600004.china.huawei.com (unknown [7.193.23.242])
	by mail.maildlp.com (Postfix) with ESMTPS id CC2A0180042;
	Fri,  9 Aug 2024 12:06:25 +0800 (CST)
Received: from [10.67.121.59] (10.67.121.59) by kwepemm600004.china.huawei.com
 (7.193.23.242) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 9 Aug
 2024 12:06:25 +0800
Message-ID: <6a60c4ea-6113-e14f-5d3c-d90175a227cc@huawei.com>
Date: Fri, 9 Aug 2024 12:06:24 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 4/5] soc: hisilicon: kunpeng_hccs: support low power
 feature for specified HCCS
To: Krzysztof Kozlowski <krzk@kernel.org>, <xuwei5@hisilicon.com>
CC: <linux-kernel@vger.kernel.org>, <soc@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <Jonathan.Cameron@Huawei.com>,
	<liuyonglong@huawei.com>
References: <20240718071134.31155-1-lihuisong@huawei.com>
 <20240718071134.31155-5-lihuisong@huawei.com>
 <91308a58-f70c-4b28-95e5-d64a1f12f252@kernel.org>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <91308a58-f70c-4b28-95e5-d64a1f12f252@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600004.china.huawei.com (7.193.23.242)

Hi Krzyszto,

Thanks for your suggestion.

在 2024/7/28 19:55, Krzysztof Kozlowski 写道:
> On 18/07/2024 09:11, Huisong Li wrote:
>> This patch add the low power feature for specified HCCS by increasing
> Please do not use "This commit/patch/change", but imperative mood. See
> longer explanation here:
> https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95
got it. many thanks.
>
>> and decrasing the lane number of these HCCS ports on platform.
>>
>> Signed-off-by: Huisong Li <lihuisong@huawei.com>
>> ---
>>   drivers/soc/hisilicon/Kconfig        |   7 +-
>>   drivers/soc/hisilicon/kunpeng_hccs.c | 377 ++++++++++++++++++++++++++-
>>   drivers/soc/hisilicon/kunpeng_hccs.h |  14 +
>>   3 files changed, 394 insertions(+), 4 deletions(-)
> ...
>
>
>> +static struct kobj_attribute pm_types_attr =
>> +		__ATTR(support_pm_types, 0444, support_pm_types_show, NULL);
>>   
>>   static ssize_t used_types_show(struct kobject *kobj,
>>   			       struct kobj_attribute *attr, char *buf)
>> @@ -1213,11 +1551,46 @@ static struct kobj_attribute used_types_attr =
>>   static void hccs_remove_misc_sysfs(struct hccs_dev *hdev)
>>   {
>>   	sysfs_remove_file(&hdev->dev->kobj, &used_types_attr.attr);
>> +	sysfs_remove_file(&hdev->dev->kobj, &pm_types_attr.attr);
>> +
>> +	if (!(hdev->caps & HCCS_CAPS_HCCS_V2_PM))
>> +		return;
>> +
>> +	sysfs_remove_file(&hdev->dev->kobj, &dec_lane_attr.attr);
>> +	sysfs_remove_file(&hdev->dev->kobj, &inc_lane_attr.attr);
>>   }
>>   
>>   static int hccs_add_misc_sysfs(struct hccs_dev *hdev)
>>   {
>> -	return sysfs_create_file(&hdev->dev->kobj, &used_types_attr.attr);
>> +	int ret;
>> +
>> +	ret = sysfs_create_file(&hdev->dev->kobj, &used_types_attr.attr);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = sysfs_create_file(&hdev->dev->kobj, &pm_types_attr.attr);
> Where is the ABI documentation?
Ok, will split the doc patch and add doc with code patch.
>
> Best regards,
> Krzysztof
>
> .

