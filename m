Return-Path: <linux-kernel+bounces-567190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 801C8A6831C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 03:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 192D63A8713
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 02:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99CCF20B7E2;
	Wed, 19 Mar 2025 02:17:52 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9335C2FA;
	Wed, 19 Mar 2025 02:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742350672; cv=none; b=XHKU0xRAObMpRH9Ct3wMI7Q+qRLt/eHorxaKipnABidaAmy66n2CObL9lvZAqJpDS+2qr8qh3tECwP5Y6d7d1hpSUpfmSF1LmuFi7N+wvUYjS14uDtPj+bFXx5wb8B08RIc98HzJyI4BRgCe/QLYr5qyrRwIvl8YIbO04xzRs7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742350672; c=relaxed/simple;
	bh=uxi2+LhbCN0nwz3kidd76MbjiQWudlle6NXAj6AQecs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Gsk95lMddf9DfCDr/ogEmCyqMl6wXxADDY8xidGTxAQBlJvH5nEHi/CEXDZt9P3P9DcsHycFvXzu3Tw3dSl0Yw3j3VajD2ZMIPd+z27aUn3mn9zeKNuTJvjdhrMmJNt+XeGTYhF4cBrrylZO8wBl0icUl7rpnyUZv1S0KUA6kDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4ZHXLM0GyRz1f1CX;
	Wed, 19 Mar 2025 10:13:15 +0800 (CST)
Received: from dggemv703-chm.china.huawei.com (unknown [10.3.19.46])
	by mail.maildlp.com (Postfix) with ESMTPS id AB6C7140294;
	Wed, 19 Mar 2025 10:17:45 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 19 Mar 2025 10:17:45 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 19 Mar
 2025 10:17:44 +0800
Message-ID: <8fe8b5a8-8339-23e9-0cb6-269cffd960ac@huawei.com>
Date: Wed, 19 Mar 2025 10:17:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2] hwmon: (acpi_power_meter) Replace the deprecated
 hwmon_device_register
To: Guenter Roeck <linux@roeck-us.net>
CC: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>,
	<liuyonglong@huawei.com>, <jdelvare@suse.com>
References: <20250314081834.3243243-1-lihuisong@huawei.com>
 <899edff7-eba1-49fb-9626-576798452f30@roeck-us.net>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <899edff7-eba1-49fb-9626-576798452f30@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemn100009.china.huawei.com (7.202.194.112)


在 2025/3/14 23:01, Guenter Roeck 写道:
> On 3/14/25 01:18, Huisong Li wrote:
>> When load this mode, we can see the following log:
>> "power_meter ACPI000D:00: hwmon_device_register() is deprecated. Please
>>   convert the driver to use hwmon_device_register_with_info()."
>>
>> So replace hwmon_device_register with hwmon_device_register_with_info.
>>
>> These attributes, 'power_accuracy', 'power_cap_hyst', 
>> 'power_average_min'
>> and 'power_average_max', should have been placed in hwmon_chip_info as
>> power data type. But these attributes are displayed as string format on
>> the following case:
>> a) power1_accuracy  --> display like '90.0%'
>> b) power1_cap_hyst  --> display 'unknown' when its value is 0xFFFFFFFF
>> c) power1_average_min/max --> display 'unknown' when its value is
>>                   negative.
>> To avoid any changes in the display of these sysfs interfaces, we can't
>> modifiy the type of these attributes in hwmon core and have to put them
>> to extra_groups.
>>
>> Please note that the path of these sysfs interfaces are modified
>> accordingly if use hwmon_device_register_with_info():
>> old: all sysfs interfaces are under acpi device, namely,
>>       /sys/class/hwmon/hwmonX/device/
>> now: all sysfs interfaces are under hwmon device, namely,
>>       /sys/class/hwmon/hwmonX/
>> The new ABI does not guarantee that the underlying path remains the 
>> same.
>> But we have to accept this change so as to replace the deprecated API.
>> Fortunately, some userspace application, like libsensors, would scan
>> the two path and handles this automatically. So to drop the deprecated
>> message, we can accept this change.
>>
>> Signed-off-by: Huisong Li <lihuisong@huawei.com>
>> ---
>>   drivers/hwmon/acpi_power_meter.c | 861 +++++++++++++++----------------
>>   1 file changed, 427 insertions(+), 434 deletions(-)
>>
>> diff --git a/drivers/hwmon/acpi_power_meter.c 
>> b/drivers/hwmon/acpi_power_meter.c
>> index f05986e4f379..46e8a0b6b210 100644
>> --- a/drivers/hwmon/acpi_power_meter.c
>> +++ b/drivers/hwmon/acpi_power_meter.c
> ...
>> +
>> +// depend on POWER_METER_CAN_TRIP
>
> Please di not intermix C++ comments with a driver using C comments.
Ack
>
>> +static DEVICE_ATTR_RW(power1_average_max);
>> +static DEVICE_ATTR_RW(power1_average_min);
>> +
>> +// depend on POWER_METER_CAN_CAP
>> +static DEVICE_ATTR_RO(power1_cap_hyst);
>> +
>> +// depend on POWER_METER_CAN_MEASURE
>> +static DEVICE_ATTR_RO(power1_accuracy);
>> +static DEVICE_ATTR_RO(power1_is_battery);
>> +
>> +static DEVICE_ATTR_RO(power1_model_number);
>> +static DEVICE_ATTR_RO(power1_oem_info);
>> +static DEVICE_ATTR_RO(power1_serial_number);
>> +
>> +#define EXTRA_FIRST_DYNAMIC_ATTR_ID    3
>> +#define EXTRA_ATTR_MAX    10
>> +
>> +static struct attribute *power_extra_attrs[EXTRA_ATTR_MAX] = {
>> +    &dev_attr_power1_model_number.attr,
>> +    &dev_attr_power1_oem_info.attr,
>> +    &dev_attr_power1_serial_number.attr,
>> +    NULL
>> +};
>> +
>> +ATTRIBUTE_GROUPS(power_extra);
>> +
>> +static void fill_extra_dynamic_attr(struct attribute *attr)
>> +{
>> +    int idx = EXTRA_FIRST_DYNAMIC_ATTR_ID;
>> +
>> +    for (idx = EXTRA_FIRST_DYNAMIC_ATTR_ID; idx < EXTRA_ATTR_MAX; 
>> idx++) {
>> +        if (!power_extra_attrs[idx])
>> +            break;
>> +    }
>> +
>> +    power_extra_attrs[idx] = attr;
>> +}
>> +
>
> Please use the .is_visible() callback in attribute_group to determine
> attribute visibility.
>
> That means you'll have to code attribute_group manually, but that is
> still better than re-implementing the is_visible() callback.
> Something like
>
> static const struct attribute_group power_extra_group = {
>     .attrs = power_extra_attrs,
>     .is_visible = power_extra_is_visible;
> };
>
> __ATTRIBUTE_GROUPS(power_extra);
>
> should do.
>
Hi Guenter,

Already modified it. Please review patch v3.
Thanks.

/Huisong
> .

