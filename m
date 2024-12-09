Return-Path: <linux-kernel+bounces-437792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C929E98B7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 15:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 584001886BD9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0CE1B0429;
	Mon,  9 Dec 2024 14:24:51 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BFF1B0420
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 14:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733754290; cv=none; b=L04J8DbmfxDbgY5f+Q07BfoFAeKJT7lM/5SXtF2xc1/jPSpw3iwrwEfGw52psyCLR9wFqrYMqyuJIX7+j/dezQvrbZPM2TORTnY+NUL3XD0GrcgPQd8ueaLWHRC7fjlfMYcBZSN857ExqCEgGmIk6BSKigb0OHJWbd6nAKEZwYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733754290; c=relaxed/simple;
	bh=T0VMIzT5WRaYwP4FmcGV2kf99JyL8bVA+M748znKzDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IQ9OjYUxTZ5xBChDwkMyUBBwm2bY84zVBS41g0JxvvYooFCVl68fS1y3jyowWHlO1xh+UtZIYfKmMV7zvrr/hQpqmZW1gspUv3SZPZKCBe9D3RIKp1PSoWO1DWZhyDnAWTRJiWvMKVDk/awppli1sDTbte1c30qVaG5/M4KIYKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Y6PFn5lT4zhZV8;
	Mon,  9 Dec 2024 22:22:21 +0800 (CST)
Received: from kwepemd500013.china.huawei.com (unknown [7.221.188.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 6CC90180064;
	Mon,  9 Dec 2024 22:24:44 +0800 (CST)
Received: from [10.159.166.136] (10.159.166.136) by
 kwepemd500013.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 9 Dec 2024 22:24:42 +0800
Message-ID: <bca38499-5479-4edc-9cea-217f3164258b@huawei.com>
Date: Mon, 9 Dec 2024 22:24:41 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 drm-dp 2/5] drm/hisilicon/hibmc: add dp link moduel in
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
References: <20241202131322.1847078-1-shiyongbang@huawei.com>
 <20241202131322.1847078-3-shiyongbang@huawei.com>
 <yyunb5oxzlmrrcxlsrub4j7iwwpaptbvubbtxr3omjftietc5b@3tfg2ldxeaoa>
From: Yongbang Shi <shiyongbang@huawei.com>
In-Reply-To: <yyunb5oxzlmrrcxlsrub4j7iwwpaptbvubbtxr3omjftietc5b@3tfg2ldxeaoa>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd500013.china.huawei.com (7.221.188.12)

> On Mon, Dec 02, 2024 at 09:13:19PM +0800, Yongbang Shi wrote:
>> From: baihan li <libaihan@huawei.com>
>>
>> Add link training process functions in this moduel.
>>
>> Signed-off-by: Baihan Li <libaihan@huawei.com>
>> Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
>> ---
>> Changelog:
>> v5 -> v6:
>>    - using drm_dbg_dp() to print debug info instead of drm_info(), suggested by Dmitry Baryshkov.
>> v3 -> v4:
>>    - optimizing hibmc_dp_link_get_adjust_train() to delete for loop, suggested by Dmitry Baryshkov.
>>    - changing ELNRNG to EIO error code, suggested by Dmitry Baryshkov.
>>    - deleting meaningless macro, suggested by Dmitry Baryshkov.
>>    - fixing build errors reported by kernel test robot <lkp@intel.com>
>>      Closes: https://lore.kernel.org/oe-kbuild-all/202411041559.WIfxRN6n-lkp@intel.com/
>> v2 -> v3:
>>    - using switchcase in dp_link_reduce_lane, suggested by Dmitry Baryshkov.
>>    - deleting dp_link_pattern2dpcd function and using macros directly, suggested by Dmitry Baryshkov.
>>    - deleting EFAULT error codes, suggested by Dmitry Baryshkov.
>> v1 -> v2:
>>    - using drm_dp_* functions implement dp link training process, suggested by Jani Nikula.
>>    - fix build errors reported by kernel test robot <lkp@intel.com>
>>      Closes: https://lore.kernel.org/oe-kbuild-all/202410031735.8iRZZR6T-lkp@intel.com/
>>    v1:https://lore.kernel.org/all/20240930100610.782363-1-shiyongbang@huawei.com/
>> ---
>>   drivers/gpu/drm/hisilicon/hibmc/Makefile     |   2 +-
>>   drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h |  24 ++
>>   drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c | 339 +++++++++++++++++++
>>   drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h  |   8 +
>>   4 files changed, 372 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c
>>
>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/Makefile b/drivers/gpu/drm/hisilicon/hibmc/Makefile
>> index 8770ec6dfffd..94d77da88bbf 100644
>> --- a/drivers/gpu/drm/hisilicon/hibmc/Makefile
>> +++ b/drivers/gpu/drm/hisilicon/hibmc/Makefile
>> @@ -1,5 +1,5 @@
>>   # SPDX-License-Identifier: GPL-2.0-only
>>   hibmc-drm-y := hibmc_drm_drv.o hibmc_drm_de.o hibmc_drm_vdac.o hibmc_drm_i2c.o \
>> -	       dp/dp_aux.o
>> +	       dp/dp_aux.o dp/dp_link.o
>>   
>>   obj-$(CONFIG_DRM_HISI_HIBMC) += hibmc-drm.o
>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h
>> index 7d3cd32393c0..8422999acbf0 100644
>> --- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h
>> +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h
>> @@ -13,11 +13,34 @@
>>   #include <linux/io.h>
>>   #include <drm/display/drm_dp_helper.h>
>>   
>> +#define HIBMC_DP_LANE_NUM_MAX 2
>> +
>> +struct hibmc_link_status {
>> +	bool clock_recovered;
>> +	bool channel_equalized;
>> +};
>> +
>> +struct hibmc_link_cap {
>> +	int rx_dpcd_revision;
>> +	u8 link_rate;
>> +	u8 lanes;
>> +	bool is_tps3;
>> +	bool is_tps4;
> These two fields are set neither in this patch nor in any of the
> following patches.

Hi Dmitry,
Thanks for your carefully and patiently reviewing. These two will be assigned when edid is acquired,
so I accept and delete them in this patch, and I will add them in next series.

Sincerely，
Baihan Li


>> +};
>> +
> [...]
>
>> +static int hibmc_dp_link_training_configure(struct hibmc_dp_dev *dp)
>> +{
>> +	u8 buf[2];
>> +	int ret;
>> +
>> +	/* DP 2 lane */
>> +	hibmc_dp_reg_write_field(dp, HIBMC_DP_PHYIF_CTRL0, HIBMC_DP_CFG_LANE_DATA_EN,
>> +				 dp->link.cap.lanes == 0x2 ? 0x3 : 0x1);
>> +	hibmc_dp_reg_write_field(dp, HIBMC_DP_DPTX_GCTL0, HIBMC_DP_CFG_PHY_LANE_NUM,
>> +				 dp->link.cap.lanes == 0x2 ? 0x1 : 0);
>> +
>> +	/* enhanced frame */
>> +	hibmc_dp_reg_write_field(dp, HIBMC_DP_VIDEO_CTRL, HIBMC_DP_CFG_STREAM_FRAME_MODE, 0x1);
>> +
>> +	/* set rate and lane count */
>> +	buf[0] = dp->link.cap.link_rate;
>> +	buf[1] = DP_LANE_COUNT_ENHANCED_FRAME_EN | dp->link.cap.lanes;
>> +	ret = drm_dp_dpcd_write(&dp->aux, DP_LINK_BW_SET, buf, sizeof(buf));
>> +	if (ret != sizeof(buf)) {
>> +		drm_dbg_dp(dp->dev, "dp aux write link rate and lanes failed, ret: %d\n", ret);
>> +		return ret >= 0 ? -EIO : ret;
>> +	}
>> +
>> +	/* set 8b/10b and downspread */
>> +	buf[0] = 0x10;
> DP_SPREAD_AMP_0_5
>
>> +	buf[1] = 0x1;
> DP_SET_ANSI_8B10B
>
>> +	ret = drm_dp_dpcd_write(&dp->aux, DP_DOWNSPREAD_CTRL, buf, sizeof(buf));
>> +	if (ret != sizeof(buf)) {
>> +		drm_dbg_dp(dp->dev, "dp aux write 8b/10b and downspread failed, ret: %d\n", ret);
>> +		return ret >= 0 ? -EIO : ret;
>> +	}
>> +
>> +	ret = drm_dp_read_dpcd_caps(&dp->aux, dp->dpcd);
>> +	if (ret)
>> +		drm_err(dp->dev, "dp aux read dpcd failed, ret: %d\n", ret);
>> +
>> +	return ret;
>> +}
>> +

