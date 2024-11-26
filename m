Return-Path: <linux-kernel+bounces-421834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 288CB9D90B2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 04:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32ACFB28A54
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 03:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1067A61FFE;
	Tue, 26 Nov 2024 03:16:04 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA52313FFC;
	Tue, 26 Nov 2024 03:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732590963; cv=none; b=sGLm2tKAzegcWKKpXqlq3Px+L01WoPSXoFTooK8x32b6mdvz0E3q/Y6GOmrnP9v/9Uo8kTScwOb9sa+1w3B6Ub8FSpAAvo2yb9p+lwF/8EZK0HGYi40jHLumI+xYBWMY52G79i8FqUXAX4sYaGcbO8hb8HI8c7vfAMCG2YgU7vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732590963; c=relaxed/simple;
	bh=xcnPI9TUgTHcMBQHI2bOmcVwS+vUJr/MFNjNe43dVS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=V+Usl7hVsY2+wMj6GZZ3PuWDgL7UAJdJw49SPwjYkxZzR3qRRF8Bt0dEcD3ZnZU3bkhH30Dx/ZT72X91Dqc1x2w1GK7o3mQOps8/g/hESDYvNzFE5EMANdsuReekh5jjd+yj5J8hN8vEscFoqbAlaMj3mvmjmXAv6VFsMbVqdlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Xy6z84WLRz1JB6V;
	Tue, 26 Nov 2024 11:11:00 +0800 (CST)
Received: from dggemv703-chm.china.huawei.com (unknown [10.3.19.46])
	by mail.maildlp.com (Postfix) with ESMTPS id 24C771400D5;
	Tue, 26 Nov 2024 11:15:58 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 26 Nov 2024 11:15:57 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 26 Nov
 2024 11:15:57 +0800
Message-ID: <1e7e5737-8dd8-172f-f5f7-9cc7967e129e@huawei.com>
Date: Tue, 26 Nov 2024 11:15:56 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v1 4/4] hwmon: (acpi_power_meter) Add the print of no
 notification that hardware limit is enforced
To: Guenter Roeck <linux@roeck-us.net>, <linux-hwmon@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <jdelvare@suse.com>, <liuyonglong@huawei.com>, <zhanjie9@hisilicon.com>,
	<zhenglifeng1@huawei.com>
References: <20241125093415.21719-1-lihuisong@huawei.com>
 <20241125093415.21719-5-lihuisong@huawei.com>
 <f7274b8d-cb91-4975-be94-69f041e9c4ee@roeck-us.net>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <f7274b8d-cb91-4975-be94-69f041e9c4ee@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemn100009.china.huawei.com (7.202.194.112)


在 2024/11/26 0:13, Guenter Roeck 写道:
> On 11/25/24 01:34, Huisong Li wrote:
>> As ACPI spec said, the bit3 of the supported capabilities in _PMC 
>> indicates
>> that the power meter supports notifications when the hardware limit is
>> enforced. If one platform doesn't report this bit, but support hardware
>> forced limit through some out-of-band mechanism. Driver wouldn't receive
>> the related notifications to notify the OSPM to re-read the hardware 
>> limit.
>> So add the print of no notifcation that hardware limit is enforced.
>>
>> Signed-off-by: Huisong Li <lihuisong@huawei.com>
>> ---
>>   drivers/hwmon/acpi_power_meter.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/hwmon/acpi_power_meter.c 
>> b/drivers/hwmon/acpi_power_meter.c
>> index 3500859ff0bf..d3f144986fae 100644
>> --- a/drivers/hwmon/acpi_power_meter.c
>> +++ b/drivers/hwmon/acpi_power_meter.c
>> @@ -712,6 +712,10 @@ static int setup_attrs(struct 
>> acpi_power_meter_resource *resource)
>>               goto skip_unsafe_cap;
>>           }
>>   +        if (resource->caps.flags & POWER_METER_CAN_NOTIFY == 0)
>
> == has higher precedence than &, so this expression will never be true.
Indeed.
>
> And, indeed:
>
> drivers/hwmon/acpi_power_meter.c: In function ‘setup_attrs’:
> drivers/hwmon/acpi_power_meter.c:701:42: error: suggest parentheses 
> around comparison in operand of ‘&’
What compilation parameters did you use to intercept this?😁
>
>> + dev_info(&resource->acpi_dev->dev,
>> +                 "no notifcation when the hardware limit is 
>> enforced.\n");
>> +
>>           if (resource->caps.configurable_cap)
>>               res = register_attrs(resource, rw_cap_attrs);
>>           else
>
> On top of that, I don't see the value in this patch.
 From the current implement, the value of this patch is little. It's 
just telling the user that he won't be notified. Notifications are not 
available.

Actually, I'd like to add some necessary updates in the notification 
handler when OSPM receive some notifications, like 0x82, 0x83 event.
These updates are necessary for this driver, which more follow ACPI spec.
But I don't know how do handle the notify 0x81 to fix the trip points, 
so I don't modify it yet.
>
> Overall, really, this driver could benefit from a complete overhaul.
> Its use of the deprecated hwmon_device_register() should tell it all.
Yes, I also found it.
But I don't know how to handle struct hwmon_chip_info and if it is 
appropriate to this driver yet.
It will be a big modification if it is ok.
> There is lots of questionable code, such as the unprotected calls to
> remove_attrs() followed by setup_attrs() in the notification handler.
Agreed.
In addition, using struct sensor_template  to create sysfs interface is 
hard to maintain and not good to me.
The show_val and show_str are to display based on the index in struct 
sensor_template.
> Any updates should be limited to bug fixes and not try to make minor
> improvements for little if any gain.
>
Yes
>
> .

