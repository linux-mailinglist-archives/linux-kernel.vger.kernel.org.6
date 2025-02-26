Return-Path: <linux-kernel+bounces-533520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0989EA45B9B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 11:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD65E3AB102
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 10:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9536723814F;
	Wed, 26 Feb 2025 10:20:06 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F01120E302;
	Wed, 26 Feb 2025 10:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740565206; cv=none; b=o0kwHEciU7OLL6kw67umOUwvYMc5QfY/nG+05lLf8wnBlc7RDarxO867MUuq2+vYGl22YjeWQduXLLykXdCEiwmaNjoxwE40nT3cSaXBQMLnFtz9KvVK9SlzuX9yGC3j6S0PusjVmFyfgANyUhSuEO0931ecsFRlaGAEzeObuIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740565206; c=relaxed/simple;
	bh=mN0lNSeBBhqB/5IZtFTHXKfDxy0YY26JEUmomHg9C1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Kf/3ncQi27kbOydoO5hXJ6lWjEP2wv5u3RU9fuijesZG3z8VMCOcPGDfh2xd3V2dGTFWybGTHcJkDj4qkL/JfaBZzhGbz6ceAkBQOgBcNfdJ1hGj/3vfBdFk2mos3bPC/Bm4N+oEpO0Qs7Z8zVVuZpJNIWu+C+2b7Jz2Rge6kzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Z2r3x2j7cz21nyr;
	Wed, 26 Feb 2025 18:16:45 +0800 (CST)
Received: from dggemv711-chm.china.huawei.com (unknown [10.1.198.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 0275B1A0188;
	Wed, 26 Feb 2025 18:19:50 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 26 Feb 2025 18:19:49 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 26 Feb
 2025 18:19:49 +0800
Message-ID: <05bb1583-13c7-25f6-48fb-dc415b3206f9@huawei.com>
Date: Wed, 26 Feb 2025 18:19:32 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC] hwmon: (acpi_power_meter) Replace hwmon_device_register
To: Guenter Roeck <linux@roeck-us.net>, <jdelvare@suse.com>
CC: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <liuyonglong@huawei.com>
References: <20250225085158.6989-1-lihuisong@huawei.com>
 <8b59c8d0-4710-48ab-ad70-b2eddc74fa9e@roeck-us.net>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <8b59c8d0-4710-48ab-ad70-b2eddc74fa9e@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemn100009.china.huawei.com (7.202.194.112)

Hi Guenter,

在 2025/2/25 21:01, Guenter Roeck 写道:
> On 2/25/25 00:51, Huisong Li wrote:
>> When load this mode, we can see the following log:
>> "power_meter ACPI000D:00: hwmon_device_register() is deprecated. Please
>>   convert the driver to use hwmon_device_register_with_info()."
>>
>> So replace hwmon_device_register with hwmon_device_register_with_info.
>>
>> To avoid any changes in the display of some sysfs interfaces, some of
>> necessary changes in hwmon.c must be made:
>> 1> For 'power1_average_interval_max/min' interface, insert 'average' 
>> to the
>>     string corresponding to hwmon_power_average_interval_max/max in
>>     hwmon_power_attr_templates[]. I guess that is what's missing.
>> 2> Add some string attributes in power sensor type because of below 
>> items:
>>     a) power1_accuracy  --> display like '90.0%'
>>     b) power1_cap_hyst  --> display 'unknown' when its value is 
>> 0xFFFFFFFF
>>     c) power1_average_min/max --> display 'unknown' when its value is
>>                                   negative.
>> Note: All the attributes modified above in hwmon core are not used by 
>> other
>> drivers.
>>
>
> That is not a reason to change the ABI, much less so hiding the change
> in a driver patch.
>
>
I am trying to replace the deprecated hwmon_device_register with 
hwmon_device_register_with_info for acpi power meter driver.

To avoid any changes in the display of some sysfs interfaces, there are 
two modifications in hwmon core as follows:
(1) The first modification in hwmon is as follows:
-->
@@ -646,8 +653,8 @@ static const char * const 
hwmon_power_attr_templates[] = {
      [hwmon_power_enable] = "power%d_enable",
      [hwmon_power_average] = "power%d_average",
      [hwmon_power_average_interval] = "power%d_average_interval",
-    [hwmon_power_average_interval_max] = "power%d_interval_max",
-    [hwmon_power_average_interval_min] = "power%d_interval_min",
+    [hwmon_power_average_interval_max] = "power%d_average_interval_max",
+    [hwmon_power_average_interval_min] = "power%d_average_interval_min",
      [hwmon_power_average_highest] = "power%d_average_highest",

The string names, "power%d_interval_max/min", are missing 'average'.
I think the meaning of these attributes are unclear If no this word. It 
can be regarded as a fault.
And power attribute name in acpi power meter is 
"power1_average_interval_min/max".

(2)The second modification changes the attribute of 'power_accuracy', 
'power_cap_hyst', 'power_average_min' and 'power_average_max' from data 
to string.
It is appropriate to assign 'power_accuracy' to string attribute.
Because it can be displayed as '%' and also include decimal point like 
acpi power meter driver, which is more in line with the meaning of this 
attribute.
It might be better to keep other attributes as data types. But it breaks 
the cornor display of these attributes in acpi power meter driver as 
said below.
    a) power1_cap_hyst  --> display 'unknown' when its value is 0xFFFFFFFF
    b) power1_average_min/max --> display 'unknown' when its value is 
negative.

I want to say that all the attributes modified above in hwmon core are 
not used by other drivers, so don't break ABI of some driver.
These can't be solved in this driver side.

AFAICS, acpi power meter driver can't replace the deprecated API because 
their sysfs interfaces will be broken if there's no any modification in 
hwmon core.


/Huisong
>
> .

