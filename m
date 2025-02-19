Return-Path: <linux-kernel+bounces-521010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C99A3B2A2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 08:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EA263AD14F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 07:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4121C305A;
	Wed, 19 Feb 2025 07:39:21 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983271C07EE
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 07:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739950760; cv=none; b=SIpqEEVB1uXVHhjZ69mEglItgiDBvg8GrUN5DYgSFuGu6ONOXViOBb2aiE0GA+fz13mZBZmYAm166knEOsUebQiyTTka5iFE9rjt0pPhyvkI64J5HTaZTfIiXtl4W3s9ROJpD1FxNgw/QuE2+q0X8xVAZrao9qYCU2FZAZzR4VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739950760; c=relaxed/simple;
	bh=25W4zpjuzTbc/goZ8HcNEGCMNQMxlSsgct2loWgWkMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=To1ojIROGaCpAQGfR6Bp/4t5QCco1MEBGEDXEYw8Skz0lhnMHzFGs4kuWKQbQvv26Ue+bxL07swBfgsqQ+mh6RBldELQNq6/3IAl5wKnfqn77CqEZ5rWlJl91uoh1iknxSzKOMwboK9XYpICcT5QKCCCG4eM0VBbVz056GJkk9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4YySsb2LcDzcpbY;
	Wed, 19 Feb 2025 15:37:39 +0800 (CST)
Received: from kwepemd500013.china.huawei.com (unknown [7.221.188.12])
	by mail.maildlp.com (Postfix) with ESMTPS id BF29414034E;
	Wed, 19 Feb 2025 15:39:12 +0800 (CST)
Received: from [10.159.166.136] (10.159.166.136) by
 kwepemd500013.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Wed, 19 Feb 2025 15:39:11 +0800
Message-ID: <110f8ad3-341c-457d-883e-d417a6a7f9dc@huawei.com>
Date: Wed, 19 Feb 2025 15:39:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 drm-dp 2/7] drm/hisilicon/hibmc: Add dp serdes cfg in
 dp process
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
 <20250210144959.100551-3-shiyongbang@huawei.com>
 <cqlf4jj5mtxig4pw7nn5wi34miisuh7veuv5i4lz2wrxafbdb7@h7glfdpl6tyf>
From: Yongbang Shi <shiyongbang@huawei.com>
In-Reply-To: <cqlf4jj5mtxig4pw7nn5wi34miisuh7veuv5i4lz2wrxafbdb7@h7glfdpl6tyf>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd500013.china.huawei.com (7.221.188.12)

> On Mon, Feb 10, 2025 at 10:49:54PM +0800, Yongbang Shi wrote:
>> From: Baihan Li <libaihan@huawei.com>
>>
>> Add dp serdes cfg in link training process, and related adapting
>> and modificating. We change some init values about training,
> Imperative language, please. Use 'change', not 'we change'.
>
>> because we want completely to negotiation process, so we start with
>> the maximum rate and the electrical characteristic level is 0.
>>
>> Signed-off-by: Baihan Li <libaihan@huawei.com>
>> Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
>> ---
>> ChangeLog:
>> v1 -> v2:
>>    - splittting the patch and add more detailed the changes in the commit message, suggested by Dmitry Baryshkov.
>> ---
>>   .../gpu/drm/hisilicon/hibmc/dp/dp_config.h    |  1 +
>>   drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c    |  6 +++-
>>   drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c  | 33 ++++++++++++++++---
>>   drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h   |  1 +
>>   .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c   |  8 ++---
>>   5 files changed, 38 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_config.h b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_config.h
>> index 74dd9956144e..c5feef8dc27d 100644
>> --- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_config.h
>> +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_config.h
>> @@ -15,5 +15,6 @@
>>   #define HIBMC_DP_CLK_EN			0x7
>>   #define HIBMC_DP_SYNC_EN_MASK		0x3
>>   #define HIBMC_DP_LINK_RATE_CAL		27
>> +#define HIBMC_DP_SYNC_DELAY(lanes)	((lanes) == 0x2 ? 86 : 46)
>>   
>>   #endif
>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
>> index 39fd3687efca..ee1ff205ff56 100644
>> --- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
>> +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
>> @@ -3,6 +3,7 @@
>>   
>>   #include <linux/io.h>
>>   #include <linux/delay.h>
>> +#include <drm/drm_managed.h>
>>   #include "dp_config.h"
>>   #include "dp_comm.h"
>>   #include "dp_reg.h"
>> @@ -73,6 +74,9 @@ static void hibmc_dp_set_sst(struct hibmc_dp_dev *dp, struct drm_display_mode *m
>>   				 HIBMC_DP_CFG_STREAM_HTOTAL_SIZE, htotal_size);
>>   	hibmc_dp_reg_write_field(dp, HIBMC_DP_VIDEO_HORIZONTAL_SIZE,
>>   				 HIBMC_DP_CFG_STREAM_HBLANK_SIZE, hblank_size);
>> +	hibmc_dp_reg_write_field(dp, HIBMC_DP_VIDEO_PACKET,
>> +				 HIBMC_DP_CFG_STREAM_SYNC_CALIBRATION,
>> +				 HIBMC_DP_SYNC_DELAY(dp->link.cap.lanes));
>>   }
>>   
>>   static void hibmc_dp_link_cfg(struct hibmc_dp_dev *dp, struct drm_display_mode *mode)
>> @@ -170,7 +174,7 @@ int hibmc_dp_hw_init(struct hibmc_dp *dp)
>>   		return -EAGAIN;
>>   
>>   	dp_dev->link.cap.lanes = 0x2;
>> -	dp_dev->link.cap.link_rate = DP_LINK_BW_2_7;
>> +	dp_dev->link.cap.link_rate = DP_LINK_BW_8_1;
>>   
>>   	/* hdcp data */
>>   	writel(HIBMC_DP_HDCP, dp_dev->base + HIBMC_DP_HDCP_CFG);
>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c
>> index f6355c16cc0a..43a4b656493f 100644
>> --- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c
>> +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c
>> @@ -6,6 +6,7 @@
>>   #include <drm/drm_print.h>
>>   #include "dp_comm.h"
>>   #include "dp_reg.h"
>> +#include "dp_serdes.h"
>>   
>>   #define HIBMC_EQ_MAX_RETRY 5
>>   
>> @@ -108,7 +109,11 @@ static int hibmc_dp_link_training_cr_pre(struct hibmc_dp_dev *dp)
>>   		return ret;
>>   
>>   	for (i = 0; i < dp->link.cap.lanes; i++)
>> -		train_set[i] = DP_TRAIN_VOLTAGE_SWING_LEVEL_2;
>> +		train_set[i] = DP_TRAIN_VOLTAGE_SWING_LEVEL_0;
>> +
>> +	ret = hibmc_dp_serdes_set_tx_cfg(dp, dp->link.train_set);
>> +	if (ret)
>> +		return ret;
>>   
>>   	ret = drm_dp_dpcd_write(&dp->aux, DP_TRAINING_LANE0_SET, train_set, dp->link.cap.lanes);
>>   	if (ret != dp->link.cap.lanes) {
>> @@ -137,21 +142,28 @@ static bool hibmc_dp_link_get_adjust_train(struct hibmc_dp_dev *dp,
>>   	return false;
>>   }
>>   
>> -static inline int hibmc_dp_link_reduce_rate(struct hibmc_dp_dev *dp)
>> +static int hibmc_dp_link_reduce_rate(struct hibmc_dp_dev *dp)
>>   {
>> +	u8 rate = 0;
>> +
>>   	switch (dp->link.cap.link_rate) {
>>   	case DP_LINK_BW_2_7:
>>   		dp->link.cap.link_rate = DP_LINK_BW_1_62;
>> -		return 0;
>> +		rate = DP_SERDES_BW_1_62;
>> +		break;
>>   	case DP_LINK_BW_5_4:
>>   		dp->link.cap.link_rate = DP_LINK_BW_2_7;
>> -		return 0;
>> +		rate = DP_SERDES_BW_2_7;
>> +		break;
>>   	case DP_LINK_BW_8_1:
>>   		dp->link.cap.link_rate = DP_LINK_BW_5_4;
>> -		return 0;
>> +		rate = DP_SERDES_BW_5_4;
>> +		break;
>>   	default:
>>   		return -EINVAL;
>>   	}
>> +
>> +	return hibmc_dp_serdes_rate_switch(rate, dp);
> This looks like:
>
> if (dp->link.cap.link_rate == DP_LINK_BW_1_62)
>      return -EINVAL;
>
> dp->link.cap.link_rate++;
> return hibmc_dp_serdes_rate_switch(rate, dp);

We need map DP_LINK_BW_2_7 to DP_SERDES_BW's value firstly, which is for our SERDES' register cfg.
This value is not like 0x6, 0xa, etc.


>>   }
>>   
>>   static inline int hibmc_dp_link_reduce_lane(struct hibmc_dp_dev *dp)
>> @@ -159,6 +171,7 @@ static inline int hibmc_dp_link_reduce_lane(struct hibmc_dp_dev *dp)
>>   	switch (dp->link.cap.lanes) {
>>   	case 0x2:
>>   		dp->link.cap.lanes--;
>> +		drm_warn(dp->dev, "dp link training reduce to 1 lane\n");
> drm_dbg
>
>>   		break;
>>   	case 0x1:
>>   		drm_err(dp->dev, "dp link training reduce lane failed, already reach minimum\n");
>> @@ -206,6 +219,11 @@ static int hibmc_dp_link_training_cr(struct hibmc_dp_dev *dp)
>>   		}
>>   
>>   		level_changed = hibmc_dp_link_get_adjust_train(dp, lane_status);
>> +
>> +		ret = hibmc_dp_serdes_set_tx_cfg(dp, dp->link.train_set);
>> +		if (ret)
>> +			return ret;
>> +
>>   		ret = drm_dp_dpcd_write(&dp->aux, DP_TRAINING_LANE0_SET, dp->link.train_set,
>>   					dp->link.cap.lanes);
>>   		if (ret != dp->link.cap.lanes) {
>> @@ -255,6 +273,11 @@ static int hibmc_dp_link_training_channel_eq(struct hibmc_dp_dev *dp)
>>   		}
>>   
>>   		hibmc_dp_link_get_adjust_train(dp, lane_status);
>> +
>> +		ret = hibmc_dp_serdes_set_tx_cfg(dp, dp->link.train_set);
>> +		if (ret)
>> +			return ret;
>> +
>>   		ret = drm_dp_dpcd_write(&dp->aux, DP_TRAINING_LANE0_SET,
>>   					dp->link.train_set, dp->link.cap.lanes);
>>   		if (ret != dp->link.cap.lanes) {
>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h
>> index 4a515c726d52..f2fa9807d8ab 100644
>> --- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h
>> +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h
>> @@ -72,5 +72,6 @@
>>   #define HIBMC_DP_CFG_STREAM_TU_SYMBOL_FRAC_SIZE	GENMASK(9, 6)
>>   #define HIBMC_DP_CFG_STREAM_HTOTAL_SIZE		GENMASK(31, 16)
>>   #define HIBMC_DP_CFG_STREAM_HBLANK_SIZE		GENMASK(15, 0)
>> +#define HIBMC_DP_CFG_STREAM_SYNC_CALIBRATION	GENMASK(31, 20)
> Please consider restructuring the header so that it becomes more
> obvious, which register are these masks for.
>
>>   
>>   #endif
>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
>> index e6de6d5edf6b..bade693d9730 100644
>> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
>> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
>> @@ -28,9 +28,7 @@
>>   #include "hibmc_drm_drv.h"
>>   #include "hibmc_drm_regs.h"
>>   
>> -#define HIBMC_DP_HOST_SERDES_CTRL		0x1f001c
>> -#define HIBMC_DP_HOST_SERDES_CTRL_VAL		0x8a00
>> -#define HIBMC_DP_HOST_SERDES_CTRL_MASK		0x7ffff
>> +#define HIBMC_DP_HOST_SERDES_CTRL	0x1f001c
> Unnecessary whitespace change.
>
> Why HIBMC_DP_HOST_SERDES_CTRL is not in the dp_reg.h?
>
>>   
>>   DEFINE_DRM_GEM_FOPS(hibmc_fops);
>>   
>> @@ -122,8 +120,8 @@ static int hibmc_kms_init(struct hibmc_drm_private *priv)
>>   	}
>>   
>>   	/* if DP existed, init DP */
>> -	if ((readl(priv->mmio + HIBMC_DP_HOST_SERDES_CTRL) &
>> -	     HIBMC_DP_HOST_SERDES_CTRL_MASK) == HIBMC_DP_HOST_SERDES_CTRL_VAL) {
>> +	ret = readl(priv->mmio + HIBMC_DP_HOST_SERDES_CTRL);
>> +	if (ret) {
>>   		ret = hibmc_dp_init(priv);
>>   		if (ret)
>>   			drm_err(dev, "failed to init dp: %d\n", ret);
>> -- 
>> 2.33.0
>>

