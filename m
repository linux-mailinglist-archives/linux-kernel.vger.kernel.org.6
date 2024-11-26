Return-Path: <linux-kernel+bounces-421805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C69509D9063
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 03:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C98D169CD6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 02:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC74224D7;
	Tue, 26 Nov 2024 02:26:02 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A27C1773A;
	Tue, 26 Nov 2024 02:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732587962; cv=none; b=ISQRYrEGORy43rSnp3Wg4kb3MTkzs8WWUSGQNlKL3DiPKhNrbpCDJ3Co2/gIVxuk85oCvK4gx/PsmFpDH2jSHsNjuaTDlAc1iBVQRNBsmnZpK8/gURZWnhzx+5L+9szup+8yXCn3f1JTglXK/CqavodgY6hSGMnY4Rz19BJHV8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732587962; c=relaxed/simple;
	bh=y71PfbdHf9VG3+O7mJckbxQrN+JhRuRc57A5Q4HwMac=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=G+PNLrMiLgxeLJAMnkDNxbKJE4oaOOXx4fS+5tWNAchPs2llhLMNYAl7AQgpQf4GbU9GYoT5DAHjg8woN9SghFyF9IK/PKURdmNgjotp4rdB8LMVDWRHueo4nKQtvzs7S2CxsWSUKxTsWNi9DCBa1NAGnXqUhFgN+rKndORohk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Xy5wk0gvhz2Gbqp;
	Tue, 26 Nov 2024 10:23:50 +0800 (CST)
Received: from dggemv704-chm.china.huawei.com (unknown [10.3.19.47])
	by mail.maildlp.com (Postfix) with ESMTPS id 50B621402CC;
	Tue, 26 Nov 2024 10:25:56 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 26 Nov 2024 10:25:56 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 26 Nov
 2024 10:25:55 +0800
Message-ID: <56a54d22-8248-b115-2781-de74e3e8692c@huawei.com>
Date: Tue, 26 Nov 2024 10:25:54 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v1 3/4] hwmon: (acpi_power_meter) Remove redundant
 'sensors_valid' variable
To: Guenter Roeck <linux@roeck-us.net>, <linux-hwmon@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <jdelvare@suse.com>, <liuyonglong@huawei.com>, <zhanjie9@hisilicon.com>,
	<zhenglifeng1@huawei.com>
References: <20241125093415.21719-1-lihuisong@huawei.com>
 <20241125093415.21719-4-lihuisong@huawei.com>
 <370185ed-4418-4c84-a7dc-3faa56edade2@roeck-us.net>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <370185ed-4418-4c84-a7dc-3faa56edade2@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemn100009.china.huawei.com (7.202.194.112)

Hi Guenter,

在 2024/11/25 23:38, Guenter Roeck 写道:
> On 11/25/24 01:34, Huisong Li wrote:
>> The 'sensors_valid' in acpi_power_meter_resource structure is always one
>> after querying power once. The default value of this variable is zero 
>> which
>> just ensure user can query power successfully without any time 
>> requirement
>> at first time. We can get power and fill the 'sensors_last_updated' 
>> field
>> at probing phase to make sure that a valid value is returned to user at
>> first query within the sampling interval. Then this redundant 
>> variable can
>> be safely removed.
>>
>> Signed-off-by: Huisong Li <lihuisong@huawei.com>
>> ---
>>   drivers/hwmon/acpi_power_meter.c | 18 +++++++++---------
>>   1 file changed, 9 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/hwmon/acpi_power_meter.c 
>> b/drivers/hwmon/acpi_power_meter.c
>> index 95da73858a0b..3500859ff0bf 100644
>> --- a/drivers/hwmon/acpi_power_meter.c
>> +++ b/drivers/hwmon/acpi_power_meter.c
>> @@ -84,7 +84,6 @@ struct acpi_power_meter_resource {
>>       u64        power;
>>       u64        cap;
>>       u64        avg_interval;
>> -    int            sensors_valid;
>>       unsigned long        sensors_last_updated;
>>       struct sensor_device_attribute    sensors[NUM_SENSORS];
>>       int            num_sensors;
>> @@ -316,15 +315,14 @@ static ssize_t set_trip(struct device *dev, 
>> struct device_attribute *devattr,
>>   }
>>     /* Power meter */
>> -static int update_meter(struct acpi_power_meter_resource *resource)
>> +static int update_meter(struct acpi_power_meter_resource *resource, 
>> bool check)
>>   {
>>       unsigned long long data;
>>       acpi_status status;
>>       unsigned long local_jiffies = jiffies;
>>   -    if (time_before(local_jiffies, resource->sensors_last_updated +
>> -            msecs_to_jiffies(resource->caps.sampling_time)) &&
>> -            resource->sensors_valid)
>> +    if (check && time_before(local_jiffies, 
>> resource->sensors_last_updated +
>> +            msecs_to_jiffies(resource->caps.sampling_time)))
>>           return 0;
>>         status = acpi_evaluate_integer(resource->acpi_dev->handle, 
>> "_PMM",
>> @@ -336,7 +334,6 @@ static int update_meter(struct 
>> acpi_power_meter_resource *resource)
>>       }
>>         resource->power = data;
>> -    resource->sensors_valid = 1;
>>       resource->sensors_last_updated = jiffies;
>>       return 0;
>>   }
>> @@ -349,7 +346,7 @@ static ssize_t show_power(struct device *dev,
>>       struct acpi_power_meter_resource *resource = 
>> acpi_dev->driver_data;
>>         mutex_lock(&resource->lock);
>> -    update_meter(resource);
>> +    update_meter(resource, true);
>>       mutex_unlock(&resource->lock);
>>         if (resource->power == UNKNOWN_POWER)
>> @@ -429,7 +426,7 @@ static ssize_t show_val(struct device *dev,
>>               val = 0;
>>           break;
>>       case 6:
>> -        ret = update_meter(resource);
>> +        ret = update_meter(resource, true);
>>           if (ret)
>>               return ret;
>>           ret = update_cap(resource);
>> @@ -699,6 +696,10 @@ static int setup_attrs(struct 
>> acpi_power_meter_resource *resource)
>>           return res;
>>         if (resource->caps.flags & POWER_METER_CAN_MEASURE) {
>> +        res = update_meter(resource, false);
>> +        if (res)
>> +            goto error;
>> +
>
> This forces an update of the meter attribute even if no one reads it
> subsequently for a long period of time. Avoiding that is the whole point
> of the flag. Otherwise every driver using the flag could just read its
> entire set of attributes to avoid it. I don't see the value of this 
> patch,
> sorry. You'd have to explain why it is better to do the unnecessary read
> to avoid the flag.
It's just to make sure that the first query after driver is initialized 
can return a valid value when user echo the sysfs
within the sampling time(namely, jiffies < sensors_last_updated + 
caps.sampling_time).
The default value of the 'sensors_valid' in resource is zero, which just 
ensure user can query power successfully without any time requirement at 
first query.
This read without check during probing phase is just for not to change 
the original behavior of the first query.
Maybe my commit log didn't make it clear. Please take a look at the 
commit log of this patch again. Thanks.
>
>
>
> .

