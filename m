Return-Path: <linux-kernel+bounces-399251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A079BFC8B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 03:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB2861C211C6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 02:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D94B38DC8;
	Thu,  7 Nov 2024 02:29:22 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7466A14293
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 02:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730946561; cv=none; b=JPSHG5ppvQnD7/luW1GCq7WG6vYEWErI+5bEKFJW7W5QFrxC3cDjnZec/H5DiM3bNBNWfP6Xft+En0U5ieErrYj5f69phS2umkDfKVOYpT5GfCzcoDNyAQOFuDEkvi+FVVSa/+4WA085RQNv++o64uof5wTVhnnRXqc/QHtIDg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730946561; c=relaxed/simple;
	bh=wmRPTTwfULLb+i3KC7xdEaZ7SiCauQ5sn6G8Q10t85Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GCE3nwzoqdnB/udq8FhTGgCpsWUd6uCfYYCULE52KzqHo7P++9gzzjcdkYh7JBXfwwMBVeIFU9JzHgacfal4H+ltDb+OQ+70tmvIMOQrebbSB/w+VDbN/iiJ4J7YXJsdX0D+BRL+1enMUpf9xSe1/T68NBymx1MNYJG6ORG1PYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XkQvg2F0Fz10V8c;
	Thu,  7 Nov 2024 10:27:27 +0800 (CST)
Received: from kwepemf100008.china.huawei.com (unknown [7.202.181.222])
	by mail.maildlp.com (Postfix) with ESMTPS id B16E6180115;
	Thu,  7 Nov 2024 10:29:14 +0800 (CST)
Received: from [10.174.179.163] (10.174.179.163) by
 kwepemf100008.china.huawei.com (7.202.181.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 7 Nov 2024 10:29:13 +0800
Message-ID: <03cdeacb-918f-7ec7-f7d2-75d86e277872@huawei.com>
Date: Thu, 7 Nov 2024 10:29:13 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] goldfish: Fix unused const variable
 'goldfish_pipe_acpi_match'
Content-Language: en-US
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: <quic_jjohnson@quicinc.com>, <jinqian@android.com>,
	<u.kleine-koenig@pengutronix.de>, <jia-cheng.hu@intel.com>,
	<alan@linux.intel.com>, <gregkh@linuxfoundation.org>,
	<linux-kernel@vger.kernel.org>, <bobo.shaobowang@huawei.com>
References: <20241026070150.3239819-1-zengheng4@huawei.com>
 <ZyuR8blW8IScgNl-@smile.fi.intel.com>
From: Zeng Heng <zengheng4@huawei.com>
In-Reply-To: <ZyuR8blW8IScgNl-@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemf100008.china.huawei.com (7.202.181.222)


On 2024/11/6 23:57, Andy Shevchenko wrote:
> On Sat, Oct 26, 2024 at 03:01:50PM +0800, Zeng Heng wrote:
>> Fix the following compilation warning:
>>
>> drivers/platform/goldfish/goldfish_pipe.c:925:36: warning:
>> ‘goldfish_pipe_acpi_match’ defined but not used
>> [-Wunused-const-variable=]
>>    925 | static const struct acpi_device_id goldfish_pipe_acpi_match[] = {
>>
>> The complexity of config guards needed for ACPI_PTR() is not worthwhile
>> for the small amount of saved data. So remove the use of ACPI_PTR instead
>> and drop now unneeded linux/acpi.h include.
> ...
>
>>   #include <linux/io.h>
>>   #include <linux/dma-mapping.h>
>>   #include <linux/mm.h>
>> -#include <linux/acpi.h>
> Because header inclusions are unsorted, it's unclear if there is
> mod_devicetable.h included. If not, you should replace acpi.h with
> mod_devicetable.h.

Yes, I checked mod_devicetable.h had been already included in 
goldfish_pipe_qemu.c before.

After the patch is applied, the header files included in the source file 
are as follows:

~~~

#include <linux/module.h>
#include <linux/mod_devicetable.h>
#include <linux/interrupt.h>
#include <linux/kernel.h>
#include <linux/spinlock.h>
#include <linux/miscdevice.h>
#include <linux/platform_device.h>
#include <linux/poll.h>
#include <linux/sched.h>
#include <linux/bitops.h>
#include <linux/slab.h>
#include <linux/io.h>
#include <linux/dma-mapping.h>
#include <linux/mm.h>
#include <linux/bug.h>
#include "goldfish_pipe_qemu.h"

~~~


Best regards,

Zeng Heng




