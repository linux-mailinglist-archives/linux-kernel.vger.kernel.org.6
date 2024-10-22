Return-Path: <linux-kernel+bounces-376242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C4D9AA204
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 14:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF2322821CA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 12:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9342819C56C;
	Tue, 22 Oct 2024 12:21:27 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E09146D78
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 12:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729599687; cv=none; b=lh3Bn1W+2qeTRMYNr+QGxs1zphYcsjBLosM6cOPyxe1PdXeg1YWDPR8pX/pNx6Fs4vgGZxZeEGOxzPqyarIuDbGlPflhcYHMD3wbm6s/vhOy5ZdsmNfPOA59Sv6A5/t06LbNUZi2Y7sm/fmtKp18XKe7Gu2ByjC35JbIPu1Q0/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729599687; c=relaxed/simple;
	bh=qiwrh4paZdZOhvzfnyjIhPiCK11Yls/d0o/bwPwYjKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eaPSQ8n74PV5s5XFqZn9cCiMrDD1lVrVQS68jQkvbYYIgBiRpJgoc1lw3N124aJaEdBOxz6B43lePYGgh/4w68BfTz4Fc/Ucj034tTSooZmqM9kFU5xLfOJs8DYbHqzcEaWJR0lnqFqW7KoT0ddpmHwYjgH4LqpveWxgCAH1iRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XXrp44BWNzpX8V;
	Tue, 22 Oct 2024 20:19:24 +0800 (CST)
Received: from kwepemd500013.china.huawei.com (unknown [7.221.188.12])
	by mail.maildlp.com (Postfix) with ESMTPS id B97D018010F;
	Tue, 22 Oct 2024 20:21:21 +0800 (CST)
Received: from [10.159.166.136] (10.159.166.136) by
 kwepemd500013.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 22 Oct 2024 20:21:20 +0800
Message-ID: <0ba91907-d3f5-4665-9a63-0b10b5d03f38@huawei.com>
Date: Tue, 22 Oct 2024 20:21:19 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH drm-dp 4/4] drm/hisilicon/hibmc: add dp module in hibmc
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
 <20240930100610.782363-5-shiyongbang@huawei.com>
 <xeemxeld4cqpx47kzb5qqsawk7mu5kje6r7n335dhe2s7ynw6m@eaiowriiilgr>
 <277b126d-e17c-4ef9-a6fe-56f36061606e@huawei.com>
 <CAA8EJpontTXUd0TzvwJZ4gCZ2i6vdB8+PqE+W3ChCuBH3WkfaA@mail.gmail.com>
From: Yongbang Shi <shiyongbang@huawei.com>
In-Reply-To: <CAA8EJpontTXUd0TzvwJZ4gCZ2i6vdB8+PqE+W3ChCuBH3WkfaA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd500013.china.huawei.com (7.221.188.12)

Okay, I'll fix them.
Thanks,
Baihan

> On Mon, 21 Oct 2024 at 14:54, s00452708 <shiyongbang@huawei.com> wrote:
>> Thanks, I will modify codes according to your comments, and I also
>> replied some questions or reasons why I did it below.
>>
>>> On Mon, Sep 30, 2024 at 06:06:10PM +0800, shiyongbang wrote:
>>>> From: baihan li <libaihan@huawei.com>
>>>>
>>>> To support DP interface displaying in hibmc driver. Add
>>>> a encoder and connector for DP modual.
>>>>
>>>> Signed-off-by: baihan li <libaihan@huawei.com>
>>>> ---
>>>>    drivers/gpu/drm/hisilicon/hibmc/Makefile      |   2 +-
>>>>    .../gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c    | 195 ++++++++++++++++++
>>>>    .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c   |  17 +-
>>>>    .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h   |   5 +
>>>>    4 files changed, 217 insertions(+), 2 deletions(-)
>>>>    create mode 100644 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
>>>>
> [...]
>
>>>> +
>>>> +static int hibmc_dp_connector_get_modes(struct drm_connector *connector)
>>>> +{
>>>> +    int count;
>>>> +
>>>> +    count = drm_add_modes_noedid(connector, connector->dev->mode_config.max_width,
>>>> +                                 connector->dev->mode_config.max_height);
>>>> +    drm_set_preferred_mode(connector, 800, 600); /* default 800x600 */
>>> What? Please parse EDID instead.
>>> I'll add aux over i2c r/w and get edid functions in next patch.
> At least please mention that it's a temporal stub which will be changed later.
>
>>>> +
>>>> +    return count;
>>>> +}
>>>> +
> [...]
>
>>>> @@ -116,10 +120,17 @@ static int hibmc_kms_init(struct hibmc_drm_private *priv)
>>>>               return ret;
>>>>       }
>>>>
>>>> +    /* if DP existed, init DP */
>>>> +    if ((readl(priv->mmio + DP_HOST_SERDES_CTRL) &
>>>> +         DP_HOST_SERDES_CTRL_MASK) == DP_HOST_SERDES_CTRL_VAL) {
>>>> +            ret = hibmc_dp_init(priv);
>>>> +            if (ret)
>>>> +                    drm_err(dev, "failed to init dp: %d\n", ret);
>>>> +    }
>>>> +
>>>>       ret = hibmc_vdac_init(priv);
>>>>       if (ret) {
>>>>               drm_err(dev, "failed to init vdac: %d\n", ret);
>>>> -            return ret;
>>> Why?
>>> We have two display cables, if VGA cannot work, this change makes DP
>>> still work.
> But that has nothing to do with init errors. If initialising (aka
> probing) VGA fails, then the driver init should fail. At the runtime
> the VGA and DP should be independent and it should be possible to
> drive just one output, that's true.
>

