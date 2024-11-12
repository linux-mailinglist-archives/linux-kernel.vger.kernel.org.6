Return-Path: <linux-kernel+bounces-405444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 888339C516F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 10:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB1AA282E58
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 09:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DB520C02B;
	Tue, 12 Nov 2024 09:05:14 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED8620BB5C
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 09:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731402314; cv=none; b=PQVadUavi3V52+tBKHUnzS+rsqxSKHkkXnWYl4Rdjrx3j9UBJFKRLg0fY48BIDsfA2A0vAMYoQJlXZRuwg7m0pqllQwoX25Nc4kGGXFeMGTrzJqme3Eujh8HUxwSuWk+leiOZDOWKgZDnAxWCtmhsDhQtU06TQy934+b9D60O/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731402314; c=relaxed/simple;
	bh=6LRxSMbzXNSLXQ/FSCc/Bd1e0M3r0yQJ9ykrDqZGAH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ObyH0uqTiC7Bxp9DXs8BnEBlEP69SsZJVshoXqsp/peh4JzszwAV62P6PPLQ+oCFS4gta1JIPYfiXCan2M5S/M76iCKoVX2wK+Av/1qgQ450uVM3LcQCtcNhLASKbT9Mn2oPszxpPyK/IZ4pG5Ynh5jQWLD40PEq/npWdeKNSsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4XngRM6k2Mz1TB87;
	Tue, 12 Nov 2024 17:02:39 +0800 (CST)
Received: from kwepemd500013.china.huawei.com (unknown [7.221.188.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 9FC3818006C;
	Tue, 12 Nov 2024 17:05:07 +0800 (CST)
Received: from [10.159.166.136] (10.159.166.136) by
 kwepemd500013.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 12 Nov 2024 17:05:06 +0800
Message-ID: <b6710d2b-8954-41e7-a5d3-8c650cdce397@huawei.com>
Date: Tue, 12 Nov 2024 17:05:05 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 drm-dp 3/4] drm/hisilicon/hibmc: add dp hw moduel in
 hibmc
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <xinliang.liu@linaro.org>, <tiantao6@hisilicon.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<kong.kongxinwei@hisilicon.com>, <liangjian010@huawei.com>,
	<chenjianmin@huawei.com>, <lidongming5@huawei.com>, <libaihan@huawei.com>,
	<shenjian15@huawei.com>, <shaojijie@huawei.com>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
	<shiyongbang@huawei.com>
References: <20241101105028.2177274-1-shiyongbang@huawei.com>
 <20241101105028.2177274-4-shiyongbang@huawei.com>
 <3ke3n6mkxdcllgjohhudv6xi6csnqzpahaocpofmn26l6jdu6c@xpy2z7yeiijq>
 <35cf8895-fbc5-4ab4-bd52-d322990cefde@huawei.com>
 <CAA8EJpoU9Pq4ZpvXj1hzpAgm+Vb002Q=AdTKo2ix4dcAaHNe4Q@mail.gmail.com>
From: Yongbang Shi <shiyongbang@huawei.com>
In-Reply-To: <CAA8EJpoU9Pq4ZpvXj1hzpAgm+Vb002Q=AdTKo2ix4dcAaHNe4Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd500013.china.huawei.com (7.221.188.12)

> On Tue, 5 Nov 2024 at 06:06, Yongbang Shi <shiyongbang@huawei.com> wrote:
>>> On Fri, Nov 01, 2024 at 06:50:27PM +0800, Yongbang Shi wrote:
>>>> From: baihan li <libaihan@huawei.com>
>>>>
>>>> Build a dp level that hibmc driver can enable dp by
>>>> calling their functions.
>>>>
>>>> Signed-off-by: baihan li <libaihan@huawei.com>
>>>> Signed-off-by: yongbang shi <shiyongbang@huawei.com>
>>>> ---
>>>> ChangeLog:
>>>> v2 -> v3:
>>>>     - fix build errors reported by kernel test robot <lkp@intel.com>
>>>>       Closes: https://lore.kernel.org/oe-kbuild-all/202410250931.UDQ9s66H-lkp@intel.com/
>>>> v1 -> v2:
>>>>     - changed some defines and functions to former patch, suggested by Dmitry Baryshkov.
>>>>     - sorting the headers including in dp_hw.h and hibmc_drm_drv.c files, suggested by Dmitry Baryshkov.
>>>>     - deleting struct dp_mode and dp_mode_cfg function, suggested by Dmitry Baryshkov.
>>>>     - fix build errors reported by kernel test robot <lkp@intel.com>
>>>>       Closes: https://lore.kernel.org/oe-kbuild-all/202410040328.VeVxM9yB-lkp@intel.com/
>>>>     v1:https://lore.kernel.org/all/20240930100610.782363-1-shiyongbang@huawei.com/
>>>> ---
>>>>    drivers/gpu/drm/hisilicon/hibmc/Makefile    |   2 +-
>>>>    drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c  | 237 ++++++++++++++++++++
>>>>    drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h  |  31 +++
>>>>    drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h |  41 ++++
>>>>    4 files changed, 310 insertions(+), 1 deletion(-)
>>>>    create mode 100644 drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
>>>>    create mode 100644 drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
>>>>
>>>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/Makefile b/drivers/gpu/drm/hisilicon/hibmc/Makefile
>>>> index 94d77da88bbf..214228052ccf 100644
>>>> --- a/drivers/gpu/drm/hisilicon/hibmc/Makefile
>>>> +++ b/drivers/gpu/drm/hisilicon/hibmc/Makefile
>>>> @@ -1,5 +1,5 @@
>>>>    # SPDX-License-Identifier: GPL-2.0-only
>>>>    hibmc-drm-y := hibmc_drm_drv.o hibmc_drm_de.o hibmc_drm_vdac.o hibmc_drm_i2c.o \
>>>> -           dp/dp_aux.o dp/dp_link.o
>>>> +           dp/dp_aux.o dp/dp_link.o dp/dp_hw.o
>>>>
>>>>    obj-$(CONFIG_DRM_HISI_HIBMC) += hibmc-drm.o
>>>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
>>>> new file mode 100644
>>>> index 000000000000..214897798bdb
>>>> --- /dev/null
>>>> +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
>>>> @@ -0,0 +1,237 @@
>>>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>>> +// Copyright (c) 2024 Hisilicon Limited.
>>>> +
>>>> +#include <linux/io.h>
>>>> +#include <linux/delay.h>
>>>> +#include "dp_config.h"
>>>> +#include "dp_comm.h"
>>>> +#include "dp_reg.h"
>>>> +#include "dp_hw.h"
>>>> +#include "dp_link.h"
>>>> +#include "dp_aux.h"
>>>> +
>>>> +static int hibmc_dp_link_init(struct dp_dev *dp)
>>>> +{
>>>> +    dp->link.cap.lanes = 2;
>>>> +    dp->link.train_set = devm_kzalloc(dp->dev->dev,
>>>> +                                      dp->link.cap.lanes * sizeof(u8), GFP_KERNEL);
>>> Can you replace it just with an array, removing a need for an additional
>>> allocation?
>>>
>>>> +    if (!dp->link.train_set)
>>>> +            return -ENOMEM;
>>>> +
>>>> +    dp->link.cap.link_rate = 1;
>>> Ok, this is why I don't link using indices for link rates. Which rate is
>>> this? Unlike cap.lanes this is pure magic number. I think it should be
>>> handled other way around: store actual link rate and convert to the
>>> register value when required.
>>>
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static void hibmc_dp_set_tu(struct dp_dev *dp, struct drm_display_mode *mode)
>>>> +{
>>>> +    u32 tu_symbol_frac_size;
>>>> +    u32 tu_symbol_size;
>>>> +    u32 rate_ks;
>>>> +    u8 lane_num;
>>>> +    u32 value;
>>>> +    u32 bpp;
>>>> +
>>>> +    lane_num = dp->link.cap.lanes;
>>>> +    if (lane_num == 0) {
>>>> +            drm_err(dp->dev, "set tu failed, lane num cannot be 0!\n");
>>>> +            return;
>>>> +    }
>>>> +
>>>> +    bpp = DP_BPP;
>>> Where is this defined? Is it hibmc-specific or a generic value?
>>>
>>>> +    rate_ks = hibmc_dp_get_link_rate(dp->link.cap.link_rate) * DP_LINK_RATE_CAL;
>>> same question
>> Hi Dmitry,
>> Thanks for your detailed suggestions and questions. These two are defined in dp_config.h.
> Please move defines to the corresponding patch, when the values are
> being used. Also if these defines are HIBMC-specific, please use the
> corresponding prefix (when one sees DP_foo they expect a constant
> defined in the standard, not a driver-specific value).

Hi Dmitry,
I got it, I will fix it in next version.
Thanks,
Baihan.



