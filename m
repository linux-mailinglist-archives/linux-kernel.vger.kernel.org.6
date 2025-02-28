Return-Path: <linux-kernel+bounces-538005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A53C2A49370
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A66C16DD9E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09D52459FD;
	Fri, 28 Feb 2025 08:26:54 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26833242907;
	Fri, 28 Feb 2025 08:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740731214; cv=none; b=ssk66NcSZVwZoKFiwD4U85rxA4r3NlLBNSraqSB965FpHK+tOU83ydsmuKaMMz1zNwuR0li4mCWaqRerjfIU37OPH8FVPRS9y3HpCb1ChuKmUtVsZjTNc/v+uPtER55Ru4gmDu3XOPH3WyGo4IwtxseS2HWE7sFdj0p+qlIZYNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740731214; c=relaxed/simple;
	bh=INDYRqaznExXcON0EmeAYMqpeJO2P/Kg/TwWdjLFR7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UUvPLOjIr725cGttZrk4gBUGDen9TSgR9yGIN04Gu4uG8z3tWt4XsNCtXkBZ/ubC2PwrBwn9bgFTNgmHdkJ+Vi2sNU2KJVtmy0qOpZEzT1A32d5PMUtxyMUf1xkmy38MCj2OkOa4J62Ed57VyqsVY01mw67ijHX+jv9AgDZDhSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Z41VN65W8zVmV0;
	Fri, 28 Feb 2025 16:25:16 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 7D03918010B;
	Fri, 28 Feb 2025 16:26:48 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 28 Feb 2025 16:26:48 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 28 Feb
 2025 16:26:47 +0800
Message-ID: <25baf5c2-9f79-9bcc-fdfb-8d36b8472d4c@huawei.com>
Date: Fri, 28 Feb 2025 16:26:46 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC] hwmon: (acpi_power_meter) Replace hwmon_device_register
To: Guenter Roeck <linux@roeck-us.net>
CC: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>,
	<liuyonglong@huawei.com>, <jdelvare@suse.com>
References: <20250225085158.6989-1-lihuisong@huawei.com>
 <8b59c8d0-4710-48ab-ad70-b2eddc74fa9e@roeck-us.net>
 <05bb1583-13c7-25f6-48fb-dc415b3206f9@huawei.com>
 <d765aeb3-3ca6-44a1-9337-2706621df903@roeck-us.net>
 <765d509f-112a-2173-43af-e657f59fddac@huawei.com>
 <7c8db8ba-19ad-417f-bacd-00e8e88eea25@roeck-us.net>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <7c8db8ba-19ad-417f-bacd-00e8e88eea25@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemn100009.china.huawei.com (7.202.194.112)


在 2025/2/27 20:31, Guenter Roeck 写道:
> On 2/27/25 00:21, lihuisong (C) wrote:
>>
>> 在 2025/2/26 21:26, Guenter Roeck 写道:
>>> On 2/26/25 02:19, lihuisong (C) wrote:
>>>> Hi Guenter,
>>>>
>>>> 在 2025/2/25 21:01, Guenter Roeck 写道:
>>>>> On 2/25/25 00:51, Huisong Li wrote:
>>>>>> When load this mode, we can see the following log:
>>>>>> "power_meter ACPI000D:00: hwmon_device_register() is deprecated. 
>>>>>> Please
>>>>>>   convert the driver to use hwmon_device_register_with_info()."
>>>>>>
>>>>>> So replace hwmon_device_register with 
>>>>>> hwmon_device_register_with_info.
>>>>>>
>>>>>> To avoid any changes in the display of some sysfs interfaces, 
>>>>>> some of
>>>>>> necessary changes in hwmon.c must be made:
>>>>>> 1> For 'power1_average_interval_max/min' interface, insert 
>>>>>> 'average' to the
>>>>>>     string corresponding to hwmon_power_average_interval_max/max in
>>>>>>     hwmon_power_attr_templates[]. I guess that is what's missing.
>>>>>> 2> Add some string attributes in power sensor type because of 
>>>>>> below items:
>>>>>>     a) power1_accuracy  --> display like '90.0%'
>>>>>>     b) power1_cap_hyst  --> display 'unknown' when its value is 
>>>>>> 0xFFFFFFFF
>>>>>>     c) power1_average_min/max --> display 'unknown' when its 
>>>>>> value is
>>>>>>                                   negative.
>>>>>> Note: All the attributes modified above in hwmon core are not 
>>>>>> used by other
>>>>>> drivers.
>>>>>>
>>>>>
>>>>> That is not a reason to change the ABI, much less so hiding the 
>>>>> change
>>>>> in a driver patch.
>>>>>
>>>>>
>>>> I am trying to replace the deprecated hwmon_device_register with 
>>>> hwmon_device_register_with_info for acpi power meter driver.
>>>>
>>>> To avoid any changes in the display of some sysfs interfaces, there 
>>>> are two modifications in hwmon core as follows:
>>>
>>> The only reason to change the hwmon core would be if it is wrong or 
>>> if it needs to
>>> be amended. Matching driver expectations is not a valid reason.
>> Got it.
>>>
>>>> (1) The first modification in hwmon is as follows:
>>>> -->
>>>> @@ -646,8 +653,8 @@ static const char * const 
>>>> hwmon_power_attr_templates[] = {
>>>>       [hwmon_power_enable] = "power%d_enable",
>>>>       [hwmon_power_average] = "power%d_average",
>>>>       [hwmon_power_average_interval] = "power%d_average_interval",
>>>> -    [hwmon_power_average_interval_max] = "power%d_interval_max",
>>>> -    [hwmon_power_average_interval_min] = "power%d_interval_min",
>>>> +    [hwmon_power_average_interval_max] = 
>>>> "power%d_average_interval_max",
>>>> +    [hwmon_power_average_interval_min] = 
>>>> "power%d_average_interval_min",
>>>>       [hwmon_power_average_highest] = "power%d_average_highest",
>>>>
>>> That is indeed a bug and should be fixed, but in a separate patch.
>> will do it.
>>>
>>>> The string names, "power%d_interval_max/min", are missing 'average'.
>>>> I think the meaning of these attributes are unclear If no this 
>>>> word. It can be regarded as a fault.
>>>> And power attribute name in acpi power meter is 
>>>> "power1_average_interval_min/max".
>>>>
>>>> (2)The second modification changes the attribute of 
>>>> 'power_accuracy', 'power_cap_hyst', 'power_average_min' and 
>>>> 'power_average_max' from data to string.
>>>> It is appropriate to assign 'power_accuracy' to string attribute.
>>>
>>> No. The ABI states that this is the accuracy in %. We don't append "mV"
>>> to voltages, or "mA" to currents either. The unit is determined by 
>>> the ABI,
>>> which states that the expected value is a number reflecting %. If a 
>>> driver
>>> adds "%", it is a driver oddity, but not a hwmon bug. The whole 
>>> point of
>>> providing numeric values is to simplify parsing from userspace. 
>>> Adding units
>>> to the displayed value would not only be pointless (since the unit 
>>> is defined
>>> by the ABI) but also make parsing more difficult.
>> Ack
>>>
>>>> Because it can be displayed as '%' and also include decimal point 
>>>> like acpi power meter driver, which is more in line with the 
>>>> meaning of this attribute.
>>>
>>> Why ? Are you suggesting that all other attributes should provide 
>>> units as well
>>> "to be more in line with the meaning of those attributes" ?
>>>
>>> It is absolutely not common to add units to sysfs attributes. We are 
>>> not going
>>> to do that, period.
>> ok.
>> What I mean is that is the display in power meter.
>
> Again, that is a problem in the power meter driver, not a problem
> in the hwmon core.
>
ok
>>>
>>>> It might be better to keep other attributes as data types. But it 
>>>> breaks the cornor display of these attributes in acpi power meter 
>>>> driver as said below.
>>>>     a) power1_cap_hyst  --> display 'unknown' when its value is 
>>>> 0xFFFFFFFF
>>>>     b) power1_average_min/max --> display 'unknown' when its value 
>>>> is negative.
>>>
>>> That is a driver problem, not a subsystem problem. If it is so 
>>> important to retain
>>> that (i.e., if for some reason some userspace program depends on 
>>> it), just
>>> implement the attributes in the driver.
>> Yes
>>>
>>> On a practical note, I do wonder what it means if ACPI reports those 
>>> values.
>>> It might simply mean that they are not supported. If so, the attributes
>>> should not be instantiated in the first place.
>> Agreed. But we still can't break ABI of this driver. will retain what 
>> it was.
>>>
>>>>
>>>> I want to say that all the attributes modified above in hwmon core 
>>>> are not used by other drivers, so don't break ABI of some driver.
>>>
>>> That is not a valid argument. Especially displaying values such as 
>>> "unknown" or
>>> starting to display units as part of an attributes _is_ an API break 
>>> since that
>>> is completely unexpected.
>> Ack
>>>
>>>> These can't be solved in this driver side.
>>>
>>> That is incorrect.
>>>
>>>>
>>>> AFAICS, acpi power meter driver can't replace the deprecated API 
>>>> because their sysfs interfaces will be broken if there's no any 
>>>> modification in hwmon core.
>>>>
>>>
>>> That is simply wrong. The _with_info API supports non-standard 
>>> attributes
>>> with the extra_groups parameter. Just use that and implement the 
>>> non-standard
>>> attributes in the driver and explain why you are doing it in a comment.
>>>
>>>
>> Ok, I will put these attributes above into extra_groups and add some 
>> comments for them.
>> Many thanks for your good suggestion.
>>
>>
>> Hi Guenter,
>>
>> BTW, I have another problem as commit log described:
>> -->
>> The path of these sysfs interfaces are modified accordingly if use 
>> hwmon_device_register_with_info():
>> Old: all sysfs interfaces are under acpi device, namely, path is 
>> "/sys/class/hwmon/hwmon1/device/" ('device' in the path is a soft 
>> link of acpi device)
>> Now: all sysfs interfaces are under hwmon device, namely, path is 
>> "/sys/class/hwmon/hwmon1/"
>> What do you think about this?
>>
>
> That is as intended. The ABI states that the attributes are under
> /sys/class/hwmon/hwmonX _or_ /sys/class/hwmon/hwmonX/device/.
> The ABI does not guarantee that the underlying path remains the same.
Yes
> libsensors handles this automatically, as should any userspace programs
> accessing the attributes directly.
>
>
So we don't need to care or handle this change of syfs path, right?

/Huisong

>
>
> .

