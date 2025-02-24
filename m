Return-Path: <linux-kernel+bounces-529268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B34DA42270
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26518189FA2B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34D118892D;
	Mon, 24 Feb 2025 14:03:28 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52E81624F4
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 14:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740405808; cv=none; b=WABJZvGjjqvndt/tvb1qZZxf8NVSTblC4sVRvxJE/AXsIFwR72mgQJ+qEUeUgVRn7CiugmLjr7xeH16ul/M/BN7+3R0SojXIx0foTfGyNjzG9KPwJfvXM+bJuagoRjFGkokKC8aVFT8AbexRftQrIqxLjSHmI0PcWRQuSXHjKOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740405808; c=relaxed/simple;
	bh=BTefghr7eqJvklKX/qO3ZwWK2a9Y1cf2mtRMmV7Lsv4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PLJvlNdGqNjQvET95i+pc9oQe1TQGatj7844+3lU7MwyaydbQdNA6i3ZN0h69HQxeq/wpVU1H5Jv2hPye1r4omL+hKiGncednsCzIa46nHxgEkGatCDPh5eLnVfKLv0v9w0Ea5y1aWKSa6FQYfpb8wHbGSUGLlfZBfablr+g3ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Z1j6q187Lz21p5G;
	Mon, 24 Feb 2025 22:00:19 +0800 (CST)
Received: from kwepemd500013.china.huawei.com (unknown [7.221.188.12])
	by mail.maildlp.com (Postfix) with ESMTPS id EDBBD140120;
	Mon, 24 Feb 2025 22:03:22 +0800 (CST)
Received: from [10.159.166.136] (10.159.166.136) by
 kwepemd500013.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 24 Feb 2025 22:03:21 +0800
Message-ID: <6634386b-afc1-4e31-a2f4-9c1afed2d1d8@huawei.com>
Date: Mon, 24 Feb 2025 22:03:20 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 drm-dp 7/8] drm/hisilicon/hibmc: Enable this hot plug
 detect of irq feature
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <xinliang.liu@linaro.org>, <tiantao6@hisilicon.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<kong.kongxinwei@hisilicon.com>, <liangjian010@huawei.com>,
	<chenjianmin@huawei.com>, <lidongming5@huawei.com>, <libaihan@huawei.com>,
	<shenjian15@huawei.com>, <shaojijie@huawei.com>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
	<shiyongbang@huawei.com>
References: <20250222025102.1519798-1-shiyongbang@huawei.com>
 <20250222025102.1519798-8-shiyongbang@huawei.com>
 <reqpxlbvlz5qssgy6gbjuou33h4zevo4xeztqbsr4keehplyhx@utv22a5ihohx>
 <eef68fc7-30f4-4246-a82e-4f90cd6a665d@huawei.com>
 <6jx5ldpidy2ycrqognfiv5ttqr5ia4dtbryta3kc2mkndrvvgo@qzuakucz765k>
From: Yongbang Shi <shiyongbang@huawei.com>
In-Reply-To: <6jx5ldpidy2ycrqognfiv5ttqr5ia4dtbryta3kc2mkndrvvgo@qzuakucz765k>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd500013.china.huawei.com (7.221.188.12)

> On Sat, Feb 22, 2025 at 06:35:48PM +0800, Yongbang Shi wrote:
>>>> +static int hibmc_dp_hpd_event(struct drm_client_dev *client)
>>>> +{
>>>> +	struct hibmc_dp *dp = container_of(client, struct hibmc_dp, client);
>>>> +	struct hibmc_drm_private *priv = to_hibmc_drm_private(dp->drm_dev);
>>>> +	struct drm_display_mode *mode = &priv->crtc.state->adjusted_mode;
>>>> +	int ret;
>>>> +
>>>> +	if (dp->hpd_status) {
>>>> +		hibmc_dp_hpd_cfg(&priv->dp);
>>>> +		ret = hibmc_dp_prepare(dp, mode);
>>>> +		if (ret)
>>>> +			return ret;
>>>> +
>>>> +		hibmc_dp_display_en(dp, true);
>>>> +	} else {
>>>> +		hibmc_dp_display_en(dp, false);
>>>> +		hibmc_dp_reset_link(&priv->dp);
>>>> +	}
>>> If I understand this correctly, you are using a separate drm_client to
>>> enable and disable the link & display. Why is it necessary? Existing
>>> drm_clients and userspace compositors use drm framework, they should be
>>> able to turn the display on and off as required.
>>>
>> Thanks for your asking, there are cfg/reset process when the connector 's pluging in/out.
>> We want to cfg DP registers again when the connector changes. Not only dp link training, but also cfg
>> the different video modes into DP registers.
> Why? The link training and mode programming should happen during
> pre_enable / enable stage (legacy or atomic).

Hi Dmitry,

Right, that's what I'm curious about. It won't call encoder enble/disable functions when I triggered HPD.
And I'm sure the drm_connector_helper_hpd_irq_event() is called. So I add a drm_client for it.


>>

