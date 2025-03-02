Return-Path: <linux-kernel+bounces-540414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89395A4B055
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 08:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE9A37A35C4
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906F21C5F14;
	Sun,  2 Mar 2025 07:43:47 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFAB17C210;
	Sun,  2 Mar 2025 07:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740901427; cv=none; b=hSGb349xA1zapR5UrWRmss31eGQqJ+dBll+5E48+MAWCeCytJNFGRYZsF1UNG+5UqW/EPTd9RCE163Jf+NMUjrCnLkWAGzuQY2aIMoxjsEhBfLS6zoJRT6uo1XG4pqEVJDrf000Nf93++LjfGe/rtkV8z0wO3O9K9O3U9XW4hFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740901427; c=relaxed/simple;
	bh=K65kWY5B+4YWKjER7mJsaaAx6Aw3pEYu/hpj4JmFhkg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aybIJNvIZL2vVp6EFEqEOWPdZo2QO/qHWYxL2tsoJlmljNQk7PNQiVGoaeuvTzKKKkoRNiU3K3ES0ttafjsInjKKyWVv9WCLY8n4cY0gFVPjJ3IW9tOfkOIQye3dDiTDjTvWRzEeZUD+ecoDfqs5Dw/6nVfSoZauY3IBm7UDKi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Z5DRT418mz1R5sx;
	Sun,  2 Mar 2025 15:41:57 +0800 (CST)
Received: from dggemv704-chm.china.huawei.com (unknown [10.3.19.47])
	by mail.maildlp.com (Postfix) with ESMTPS id 4032914034E;
	Sun,  2 Mar 2025 15:43:34 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 2 Mar 2025 15:43:34 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sun, 2 Mar
 2025 15:43:33 +0800
Message-ID: <ab93d716-f38c-8e34-cd41-0a35b7db4e43@huawei.com>
Date: Sun, 2 Mar 2025 15:43:32 +0800
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
 <25baf5c2-9f79-9bcc-fdfb-8d36b8472d4c@huawei.com>
 <ce3866a2-d264-4da9-9411-8427fc1c8f46@roeck-us.net>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <ce3866a2-d264-4da9-9411-8427fc1c8f46@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemn100009.china.huawei.com (7.202.194.112)


在 2025/2/28 22:47, Guenter Roeck 写道:
> On 2/28/25 00:26, lihuisong (C) wrote:
> ...
>>>> BTW, I have another problem as commit log described:
>>>> -->
>>>> The path of these sysfs interfaces are modified accordingly if use 
>>>> hwmon_device_register_with_info():
>>>> Old: all sysfs interfaces are under acpi device, namely, path is 
>>>> "/sys/class/hwmon/hwmon1/device/" ('device' in the path is a soft 
>>>> link of acpi device)
>>>> Now: all sysfs interfaces are under hwmon device, namely, path is 
>>>> "/sys/class/hwmon/hwmon1/"
>>>> What do you think about this?
>>>>
>>>
>>> That is as intended. The ABI states that the attributes are under
>>> /sys/class/hwmon/hwmonX _or_ /sys/class/hwmon/hwmonX/device/.
>>> The ABI does not guarantee that the underlying path remains the same.
>> Yes
>>> libsensors handles this automatically, as should any userspace programs
>>> accessing the attributes directly.
>>>
>>>
>> So we don't need to care or handle this change of syfs path, right?
>>
>
> Correct. Each driver converted to the new API experiences the same 
> change.
> If you insist keeping the path the same, you'll have to drop this effort
> and live with the deprecated message.
>
>
Ok, thanks for your advice and reply.
will send next version ASAP.

/Huisong
>
> .

