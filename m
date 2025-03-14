Return-Path: <linux-kernel+bounces-561166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C375FA60E3A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A2CA17C9DF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC1C1F30C3;
	Fri, 14 Mar 2025 10:08:22 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C7A1EBA07
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 10:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741946902; cv=none; b=PbpSW3ueS2Bu0xMZ6aPehkh1pvdx/wKUD4SJMkH9zycX5BdO3cc1PylMR31PocGmfyAIkQFKTdfxj1qNgPhsZSJ1tOZNluqNtZ36P5AZxJ0meTc5Z+gD3J4JP1q3KktEI+h06ov31izffX43xkETKOwmFHN1pDiDyI3oxRjYPXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741946902; c=relaxed/simple;
	bh=RMih/HcYSOexgEnx7WMII9r6Tptz6ObevW7PZ3gwI98=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ks0+eMzgjM7fTjNmnKydP/bfXqVnSnOh9X+tf3pY1wTiGlIJRicnVryOKCsrcPVrEZ3xm07IqGAEUu/tFSjaO7/QcgMW5YUXSfJHrt2f0JLfaX7ePLP7Z/EQO4XsaDHhyxT1wyTu1l/Dcx3RaQbsebtb4jwc4jqVy8KUPonnT34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4ZDg6d5BCHz1d08f;
	Fri, 14 Mar 2025 18:08:09 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id C6C291800E4;
	Fri, 14 Mar 2025 18:08:16 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 14 Mar 2025 18:08:16 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 14 Mar
 2025 18:08:15 +0800
Message-ID: <40b9c172-2bbb-a048-643b-1493aa874b65@huawei.com>
Date: Fri, 14 Mar 2025 18:08:15 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] soc: hisilicon: kunpeng_hccs: Fix incorrect string
 assembly
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: <xuwei5@hisilicon.com>, <linux-kernel@vger.kernel.org>, <soc@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <liuyonglong@huawei.com>
References: <20250314082856.3257783-1-lihuisong@huawei.com>
 <20250314100136.0000416f@huawei.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20250314100136.0000416f@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemn100009.china.huawei.com (7.202.194.112)


在 2025/3/14 18:01, Jonathan Cameron 写道:
> On Fri, 14 Mar 2025 16:28:56 +0800
> Huisong Li <lihuisong@huawei.com> wrote:
>
>> String assembly should use sysfs_emit_at() instead of sysfs_emit().
>>
>> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> Fixes tag?
ok, will add it.
>
> Otherwise looks good to me.
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
>> ---
>>   drivers/soc/hisilicon/kunpeng_hccs.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/soc/hisilicon/kunpeng_hccs.c b/drivers/soc/hisilicon/kunpeng_hccs.c
>> index 8aa8dec14911..444a8f59b7da 100644
>> --- a/drivers/soc/hisilicon/kunpeng_hccs.c
>> +++ b/drivers/soc/hisilicon/kunpeng_hccs.c
>> @@ -1539,8 +1539,8 @@ static ssize_t used_types_show(struct kobject *kobj,
>>   	u16 i;
>>   
>>   	for (i = 0; i < hdev->used_type_num - 1; i++)
>> -		len += sysfs_emit(&buf[len], "%s ", hdev->type_name_maps[i].name);
>> -	len += sysfs_emit(&buf[len], "%s\n", hdev->type_name_maps[i].name);
>> +		len += sysfs_emit_at(buf, len, "%s ", hdev->type_name_maps[i].name);
>> +	len += sysfs_emit_at(buf, len, "%s\n", hdev->type_name_maps[i].name);
>>   
>>   	return len;
>>   }
> .

