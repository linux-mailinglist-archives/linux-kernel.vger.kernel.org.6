Return-Path: <linux-kernel+bounces-521017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 620B5A3B2B0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 08:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CAB41890B7F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 07:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F386F1C460A;
	Wed, 19 Feb 2025 07:41:57 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDE11C5D58
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 07:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739950917; cv=none; b=Y4StxODM5hW3vaBfoo47KZBRQa9YFN/tavwryQgOfJ2sHJ0c0cVCD7kPIZnZYjKgZLqwDzj+34Q7Pw/m0XRLBd6AYdehn45nQKTts3UbKq/3Tkd9xdhqwJ0k4SOd5pSGp/Kl0SKc284q8Nui88fpVE/FZRdr5LUnOC8JRefHPAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739950917; c=relaxed/simple;
	bh=//DURPTky6DtdAjwnlDxQOt2N1jiP07056sKv9YgOEc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=on21QhaDuKlr3/A0Vw8YVLfpOI7cOOOc7y7AoJAQBriBsALDYNuxk4vYDAjZ2ATXNyTIeaX3yJkKEv+jWvk7hkqlOACb32viLrcxrN9V1Ql+3Qm2rEp+0q+kSJ0Jv9N2lnuM1gVa1QJ88TgE+bCF60VYC/n1h6ivkXSFew9nY0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4YySv02fDKz22wT6;
	Wed, 19 Feb 2025 15:38:52 +0800 (CST)
Received: from kwepemd500013.china.huawei.com (unknown [7.221.188.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 9926A180044;
	Wed, 19 Feb 2025 15:41:52 +0800 (CST)
Received: from [10.159.166.136] (10.159.166.136) by
 kwepemd500013.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Wed, 19 Feb 2025 15:41:51 +0800
Message-ID: <0e32f611-6261-499b-a54c-5aacc430dc81@huawei.com>
Date: Wed, 19 Feb 2025 15:41:50 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 drm-dp 6/7] drm/hisilicon/hibmc: Add drm debugfs
 functions
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <xinliang.liu@linaro.org>, <tiantao6@hisilicon.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<kong.kongxinwei@hisilicon.com>, <liangjian010@huawei.com>,
	<chenjianmin@huawei.com>, <lidongming5@huawei.com>, <libaihan@huawei.com>,
	<shenjian15@huawei.com>, <shaojijie@huawei.com>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
	<shiyongbang@huawei.com>
References: <20250210144959.100551-1-shiyongbang@huawei.com>
 <20250210144959.100551-7-shiyongbang@huawei.com>
 <afi5npgvnrp56oufhc7576auya26lbwgu377dprddode2kp3sb@u5ctx4o22w4v>
From: Yongbang Shi <shiyongbang@huawei.com>
In-Reply-To: <afi5npgvnrp56oufhc7576auya26lbwgu377dprddode2kp3sb@u5ctx4o22w4v>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd500013.china.huawei.com (7.221.188.12)

> On Mon, Feb 10, 2025 at 10:49:58PM +0800, Yongbang Shi wrote:
>> From: Baihan Li <libaihan@huawei.com>
>>
>> We use the previous two patches as our debug functions and
>> generate two files. "hibmc-dp" and "color-bar".
>> hibmc-dp: read only, print the dp link status and dpcd version
> Please define a generic DP attribute for this, handle it in
> drm_dp_helper.c. Other drivers then can reuse this debugfs file.
> Also note drm_dp_downstream_debug(), it might also be helpful.
> Also see msm_dp_debug_show() for inspiration

Hi Dmitry,
Thanks four your advice! I think I will remove this link status part temporarily.
I'll post a separate patch for this generic function later.


>> color-bar: read/write
>>             write: cfg color bar and enable/disable it by your input
>>             read: print your current cfg info of color-bar
> This really should go into your color-bar patch.
>
>> Signed-off-by: Baihan Li <libaihan@huawei.com>
>> Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
>> ---
>> ChangeLog:
>> v1 -> v2:
>>    - deleting edid decoder and its debugfs, suggested by Dmitry Baryshkov.
>>    - using debugfs_init() callback, suggested by Dmitry Baryshkov.
>> ---
>>   drivers/gpu/drm/hisilicon/hibmc/Makefile      |   3 +-
>>   .../drm/hisilicon/hibmc/hibmc_drm_debugfs.c   | 124 ++++++++++++++++++
>>   .../gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c    |   1 +
>>   .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h   |   2 +
>>   4 files changed, 129 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_debugfs.c
>>
>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/Makefile b/drivers/gpu/drm/hisilicon/hibmc/Makefile
>> index 43de077d6769..1f65c683282f 100644
>> --- a/drivers/gpu/drm/hisilicon/hibmc/Makefile
>> +++ b/drivers/gpu/drm/hisilicon/hibmc/Makefile
>> @@ -1,5 +1,6 @@
>>   # SPDX-License-Identifier: GPL-2.0-only
>>   hibmc-drm-y := hibmc_drm_drv.o hibmc_drm_de.o hibmc_drm_vdac.o hibmc_drm_i2c.o \
>> -	       dp/dp_aux.o dp/dp_link.o dp/dp_hw.o dp/dp_serdes.o hibmc_drm_dp.o
>> +	       dp/dp_aux.o dp/dp_link.o dp/dp_hw.o dp/dp_serdes.o hibmc_drm_dp.o \
>> +	       hibmc_drm_debugfs.o
>>   
>>   obj-$(CONFIG_DRM_HISI_HIBMC) += hibmc-drm.o
>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_debugfs.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_debugfs.c
>> new file mode 100644
>> index 000000000000..af2efb70d6ea
>> --- /dev/null
>> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_debugfs.c
>> @@ -0,0 +1,124 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +// Copyright (c) 2024 Hisilicon Limited.
>> +
>> +#include <linux/debugfs.h>
>> +#include <linux/device.h>
>> +#include <linux/seq_file.h>
>> +#include <linux/pci.h>
>> +
>> +#include <drm/drm_drv.h>
>> +#include <drm/drm_file.h>
>> +#include <drm/drm_debugfs.h>
>> +#include <drm/drm_edid.h>
>> +
>> +#include "hibmc_drm_drv.h"
>> +
>> +static int hibmc_dp_show(struct seq_file *m, void *arg)
>> +{
>> +	struct drm_info_node *node = m->private;
>> +	struct drm_device *dev = node->minor->dev;
>> +	struct hibmc_drm_private *priv = to_hibmc_drm_private(dev);
>> +	int idx;
>> +
>> +	if (!drm_dev_enter(dev, &idx))
>> +		return -ENODEV;
>> +
>> +	seq_printf(m, "enable lanes: %u\n", hibmc_dp_get_lanes(&priv->dp));
>> +	seq_printf(m, "link rate: %d\n", hibmc_dp_get_link_rate(&priv->dp) * 27);
>> +	seq_printf(m, "dpcd version: 0x%x\n", hibmc_dp_get_dpcd(&priv->dp));
>> +
>> +	drm_dev_exit(idx);
>> +
>> +	return 0;
>> +}
>> +
>> +static ssize_t hibmc_control_write(struct file *file, const char __user *user_buf,
>> +				   size_t size, loff_t *ppos)
>> +{
>> +	struct hibmc_drm_private *priv = file_inode(file)->i_private;
>> +	struct hibmc_dp_cbar_cfg *cfg = &priv->dp.cfg;
>> +	u32 input = 0;
>> +	int ret, idx;
>> +	u8 val;
>> +
>> +	ret = kstrtou32_from_user(user_buf, size, 0, &input);
>> +	if (ret)
>> +		return ret;
>> +
>> +	val = FIELD_GET(GENMASK(13, 10), input);
>> +	if (val > 9)
>> +		return -EINVAL;
>> +	cfg->pattern = val;
>> +	cfg->enable = FIELD_GET(BIT(0), input);
>> +	cfg->self_timing = FIELD_GET(BIT(1), input);
>> +	cfg->dynamic_rate = FIELD_GET(GENMASK(9, 2), input);
> Having a binary file format is really a sad idea. Can it be a text file
> instead?
>
>> +
>> +	ret = drm_dev_enter(&priv->dev, &idx);
>> +	if (!ret)
>> +		return -ENODEV;
>> +
>> +	hibmc_dp_set_cbar(&priv->dp, cfg);
>> +
>> +	drm_dev_exit(idx);
>> +
>> +	return size;
>> +}
>> +

