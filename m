Return-Path: <linux-kernel+bounces-374237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B62A89A6746
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 13:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 708C4282268
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 11:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF6C1E908A;
	Mon, 21 Oct 2024 11:57:12 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9271E8840
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 11:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729511832; cv=none; b=VSb3HNqpyTIYjNyVBWxf3wk7dS3sxZQYYycwauv0pKOURHmQQsj8PtI5P3mmoxT/RAL+yVwpopZLCC+4bsGYem6jIM2MFwr+5NmTpL5oVIr1Abs01KE4XB8rgtpAKPMuxt+8h29DYKL3R3G73ojnry7oE2AA9JXUYDPklNOZAEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729511832; c=relaxed/simple;
	bh=ne7DtI2gA4Og0/++gOU+KUHaG+ekXNcVlqBsFxCZOA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mi2+1swYClEN2mP8kCUr4Y5FhrR8XbjlRpH/Glcjvr7QdZNYONLF7jKzxD7ClnkKB9ql8/9D/kpvBOtQREr5IaDPPTGlBcKxdD6a7Ac0kO7S0lEA/H7Dw4Ks7XTM2FFqVeSdOL7FtiQv6mhEKwfYqHPLMKXTv7+neNA2iURCSck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XXDFq4QvSz1HLJh;
	Mon, 21 Oct 2024 19:52:47 +0800 (CST)
Received: from kwepemd500013.china.huawei.com (unknown [7.221.188.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 6C4291A016C;
	Mon, 21 Oct 2024 19:57:06 +0800 (CST)
Received: from [10.159.166.136] (10.159.166.136) by
 kwepemd500013.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 21 Oct 2024 19:57:04 +0800
Message-ID: <0cfe73f0-01a3-4dd6-becf-7662498d56b3@huawei.com>
Date: Mon, 21 Oct 2024 19:57:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH drm-dp 3/4] drm/hisilicon/hibmc: add dp kapi moduel in
 hibmc drivers
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <xinliang.liu@linaro.org>, <tiantao6@hisilicon.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<kong.kongxinwei@hisilicon.com>, <liangjian010@huawei.com>,
	<chenjianmin@huawei.com>, <lidongming5@huawei.com>, <libaihan@huawei.com>,
	<shenjian15@huawei.com>, <shaojijie@huawei.com>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
	<shiyongbang@huawei.com>
References: <20240930100610.782363-1-shiyongbang@huawei.com>
 <20240930100610.782363-4-shiyongbang@huawei.com>
 <eslfc3ejjjpbw5wuf4khcoixeaitpb47iwf6kug7cryplcxcui@sieiyekdpczn>
From: s00452708 <shiyongbang@huawei.com>
In-Reply-To: <eslfc3ejjjpbw5wuf4khcoixeaitpb47iwf6kug7cryplcxcui@sieiyekdpczn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd500013.china.huawei.com (7.221.188.12)

Hi Dmitry,
Thanks for your advices, I'll resolve the problems you mentioned.

> On Mon, Sep 30, 2024 at 06:06:09PM +0800, shiyongbang wrote:
>> From: baihan li <libaihan@huawei.com>
>>
>> Build a kapi level that hibmc driver can enable dp by
>> calling these kapi functions.
>>
>> Signed-off-by: baihan li <libaihan@huawei.com>
>> ---
>>   drivers/gpu/drm/hisilicon/hibmc/Makefile      |  2 +-
>>   .../gpu/drm/hisilicon/hibmc/dp/dp_config.h    | 20 ++++++++
>>   drivers/gpu/drm/hisilicon/hibmc/dp/dp_kapi.c  | 12 ++---
>>   drivers/gpu/drm/hisilicon/hibmc/dp/dp_kapi.h  | 48 +++++++++++++++++++
>>   4 files changed, 75 insertions(+), 7 deletions(-)
>>   create mode 100644 drivers/gpu/drm/hisilicon/hibmc/dp/dp_config.h
>>   create mode 100644 drivers/gpu/drm/hisilicon/hibmc/dp/dp_kapi.h
>>
>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/Makefile b/drivers/gpu/drm/hisilicon/hibmc/Makefile
>> index 94d77da88bbf..693036dfab52 100644
>> --- a/drivers/gpu/drm/hisilicon/hibmc/Makefile
>> +++ b/drivers/gpu/drm/hisilicon/hibmc/Makefile
>> @@ -1,5 +1,5 @@
>>   # SPDX-License-Identifier: GPL-2.0-only
>>   hibmc-drm-y := hibmc_drm_drv.o hibmc_drm_de.o hibmc_drm_vdac.o hibmc_drm_i2c.o \
>> -	       dp/dp_aux.o dp/dp_link.o
>> +	       dp/dp_aux.o dp/dp_link.o dp/dp_kapi.o
>>   
>>   obj-$(CONFIG_DRM_HISI_HIBMC) += hibmc-drm.o
>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_config.h b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_config.h
>> new file mode 100644
>> index 000000000000..a6353a808cc4
>> --- /dev/null
>> +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_config.h
>> @@ -0,0 +1,20 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +/* Copyright (c) 2024 Hisilicon Limited. */
>> +
>> +#ifndef DP_CONFIG_H
>> +#define DP_CONFIG_H
>> +
>> +#define DP_BPP 24
>> +#define DP_SYMBOL_PER_FCLK 4
>> +#define DP_MIN_PULSE_NUM 0x9
>> +#define DP_MSA1 0x20
>> +#define DP_MSA2 0x845c00
>> +#define DP_OFFSET 0x1e0000
>> +#define DP_HDCP 0x2
>> +#define DP_INT_RST 0xffff
>> +#define DP_DPTX_RST 0x3ff
>> +#define DP_CLK_EN 0x7
>> +#define DP_SYNC_EN_MASK 0x3
>> +#define DP_LINK_RATE_CAL 27
> I think some of these defines were used in previous patches. Please make
> sure that at each step the code builds without errors.
>
>> +
>> +#endif
>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_kapi.c b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_kapi.c
>> index 4091723473ad..ca7edc69427c 100644
>> --- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_kapi.c
>> +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_kapi.c
>> @@ -64,12 +64,12 @@ static void hibmc_dp_set_tu(struct hibmc_dp_dev *dp, struct dp_mode *mode)
>>   	rate_ks = dp->link.cap.link_rate * DP_LINK_RATE_CAL;
>>   	value = (pixel_clock * bpp * 5000) / (61 * lane_num * rate_ks);
>>   
>> -	if (value % 10 == 9) { /* 10: div, 9: carry */
>> -		tu_symbol_size = value / 10 + 1; /* 10: div */
>> +	if (value % 10 == 9) { /* 9 carry */
>> +		tu_symbol_size = value / 10 + 1;
>>   		tu_symbol_frac_size = 0;
>>   	} else {
>> -		tu_symbol_size = value / 10; /* 10: div */
>> -		tu_symbol_frac_size = value % 10 + 1; /* 10: div */
>> +		tu_symbol_size = value / 10;
>> +		tu_symbol_frac_size = value % 10 + 1;
>>   	}
>>   
>>   	drm_info(dp->dev, "tu value: %u.%u value: %u\n",
>> @@ -158,7 +158,7 @@ static void hibmc_dp_link_cfg(struct hibmc_dp_dev *dp, struct dp_mode *mode)
>>   	dp_write_bits(dp->base + DP_VIDEO_CTRL,
>>   		      DP_CFG_STREAM_HSYNC_POLARITY, mode->h_pol);
>>   
>> -	/* MSA mic 0 and 1*/
>> +	/* MSA mic 0 and 1 */
>>   	writel(DP_MSA1, dp->base + DP_VIDEO_MSA1);
>>   	writel(DP_MSA2, dp->base + DP_VIDEO_MSA2);
>>   
>> @@ -167,7 +167,7 @@ static void hibmc_dp_link_cfg(struct hibmc_dp_dev *dp, struct dp_mode *mode)
>>   	dp_write_bits(dp->base + DP_VIDEO_CTRL, DP_CFG_STREAM_RGB_ENABLE, 0x1);
>>   	dp_write_bits(dp->base + DP_VIDEO_CTRL, DP_CFG_STREAM_VIDEO_MAPPING, 0);
>>   
>> -	/*divide 2: up even */
>> +	/* divide 2: up even */
>>   	if (timing_delay % 2)
>>   		timing_delay++;
>>   
> This should be squashed into the previous commits.
>
>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_kapi.h b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_kapi.h
>> new file mode 100644
>> index 000000000000..6b07642d55b8
>> --- /dev/null
>> +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_kapi.h
>> @@ -0,0 +1,48 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +/* Copyright (c) 2024 Hisilicon Limited. */
>> +
>> +#ifndef DP_KAPI_H
>> +#define DP_KAPI_H
>> +
>> +#include <linux/types.h>
>> +#include <drm/drm_device.h>
>> +#include <drm/drm_encoder.h>
>> +#include <drm/drm_connector.h>
>> +#include <drm/drm_print.h>
>> +#include <linux/delay.h>
> Sort the headers, please.
>
>> +
>> +struct hibmc_dp_dev;
>> +
>> +struct dp_mode {
>> +	u32 h_total;
>> +	u32 h_active;
>> +	u32 h_blank;
>> +	u32 h_front;
>> +	u32 h_sync;
>> +	u32 h_back;
>> +	bool h_pol;
>> +	u32 v_total;
>> +	u32 v_active;
>> +	u32 v_blank;
>> +	u32 v_front;
>> +	u32 v_sync;
>> +	u32 v_back;
>> +	bool v_pol;
>> +	u32 field_rate;
>> +	u32 pixel_clock; // khz
> Why do you need a separate struct for this?
> I can try to use drm_mode function and refactor this struct, but they're insufficient for ourscenarios.Here's change template bellow: struct dp_mode { sturct 
> videomode mode; u32 h_total; u32 h_blank; u32 v_total; u32 v_blank; 
> u32 field_rate; }; static void dp_mode_cfg(struct dp_mode *dp_mode, 
> struct drm_display_mode *mode) { dp_mode->field_rate = 
> drm_mode_vrefresh(mode); drm_display_mode_to_videomode(mode, 
> &dp_mode->vmode); dp_mode->h_total = mode->htotal; dp_mode->h_blank = 
> mode->htotal - mode->hdisplay; dp_mode->v_total = mode->vtotal; 
> dp_mode->v_blank = mode->vtotal - mode->vdisplay; }
>> +};
>> +
>> +struct hibmc_dp {
>> +	struct hibmc_dp_dev *dp_dev;
>> +	struct drm_device *drm_dev;
>> +	struct drm_encoder encoder;
>> +	struct drm_connector connector;
>> +	void __iomem *mmio;
>> +};
>> +
>> +int hibmc_dp_kapi_init(struct hibmc_dp *dp);
>> +void hibmc_dp_kapi_uninit(struct hibmc_dp *dp);
>> +int hibmc_dp_mode_set(struct hibmc_dp *dp, struct dp_mode *mode);
>> +void hibmc_dp_display_en(struct hibmc_dp *dp, bool enable);
> It looks like this should also be defined earlier.
>
>> +
>> +#endif
>> -- 
>> 2.33.0
>>

