Return-Path: <linux-kernel+bounces-301124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4202B95EC9F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 11:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8DC31F21EA0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 09:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD10C13AD3F;
	Mon, 26 Aug 2024 09:04:15 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E35481741
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 09:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724663055; cv=none; b=E1BLiHXWB7OnCoEr9U3DgzRbynDlNPMZGZ3Gp3r5JY3mb0tsiCH0dhb0aMhCTTxEHbWOuf0AFjFqUoAYfmZ1kYCdW2KNK4WzaSLdxxeiOnKSzyjX1rDIetwTWI8GDg17imYNrmUGUFnGbIM6wwVK7unu9b7XVocsMR4I1l7+IPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724663055; c=relaxed/simple;
	bh=X6oTBQ18A8CVtTZSU27ASfOb98LdqIea2rftawhxxwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LulbLkSQdE+Y3p+Y5QEZcJQNNePJO8V+webI/7MDE7vGw9yUrRjpfMUy9bv1VM7uptrUX/gQjnWxub+ZhibOXZ6gmVeBW/lEQeY7zhPHS+ngxpDNCoU6tiaBaASMGX/w+VJdts4d4cv50RwMuhjzUe3nIDbycJcA7kV9KbRPjFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Wsl7D27nYzpTZH;
	Mon, 26 Aug 2024 17:02:32 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 28A361401F0;
	Mon, 26 Aug 2024 17:04:11 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemh500013.china.huawei.com (7.202.181.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 26 Aug 2024 17:04:09 +0800
Message-ID: <ab3c09e7-43cc-b946-0f7c-44ea7f4111f2@huawei.com>
Date: Mon, 26 Aug 2024 17:04:09 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH -next 1/5] drm/rockchip: Use
 for_each_child_of_node_scoped()
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC: <hjc@rock-chips.com>, <heiko@sntech.de>, <andy.yan@rock-chips.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<dri-devel@lists.freedesktop.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-rockchip@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<krzk@kernel.org>, <jic23@kernel.org>
References: <20240823092053.3170445-1-ruanjinjie@huawei.com>
 <20240823092053.3170445-2-ruanjinjie@huawei.com>
 <20240823123203.00002aac@Huawei.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20240823123203.00002aac@Huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemh500013.china.huawei.com (7.202.181.146)



On 2024/8/23 19:32, Jonathan Cameron wrote:
> On Fri, 23 Aug 2024 17:20:49 +0800
> Jinjie Ruan <ruanjinjie@huawei.com> wrote:
> 
>> Avoids the need for manual cleanup of_node_put() in early exits
>> from the loop.
>>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> 
> There is more to do here, and looking at the code, I'm far from
> sure it isn't releasing references it never had.
> 
>> ---
>>  drivers/gpu/drm/rockchip/rockchip_lvds.c | 8 +++-----
>>  1 file changed, 3 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.c b/drivers/gpu/drm/rockchip/rockchip_lvds.c
>> index 9a01aa450741..f5b3f18794dd 100644
>> --- a/drivers/gpu/drm/rockchip/rockchip_lvds.c
>> +++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c
>> @@ -548,7 +548,7 @@ static int rockchip_lvds_bind(struct device *dev, struct device *master,
>>  	struct drm_encoder *encoder;
>>  	struct drm_connector *connector;
>>  	struct device_node *remote = NULL;
>> -	struct device_node  *port, *endpoint;
> 
> Odd extra space before *port in original. Clean that up whilst here.
> 
> 
>> +	struct device_node  *port;
> 
> Use __free(device_node) for *port as well.
> 
> So where the current asignment is.
> 	struct device_node *port = of_graph_get_port_by_id(dev->of_node, 1);
> 
>>  	int ret = 0, child_count = 0;
>>  	const char *name;
>>  	u32 endpoint_id = 0;
>> @@ -560,15 +560,13 @@ static int rockchip_lvds_bind(struct device *dev, struct device *master,
>>  			      "can't found port point, please init lvds panel port!\n");
>>  		return -EINVAL;
>>  	}
>> -	for_each_child_of_node(port, endpoint) {
>> +	for_each_child_of_node_scoped(port, endpoint) {
>>  		child_count++;
>>  		of_property_read_u32(endpoint, "reg", &endpoint_id);
>>  		ret = drm_of_find_panel_or_bridge(dev->of_node, 1, endpoint_id,
>>  						  &lvds->panel, &lvds->bridge);
>> -		if (!ret) {
>> -			of_node_put(endpoint);
>> +		if (!ret)
>>  			break;
> 
> This then can simply be
> 			return dev_err_probe(dev, ret,
> 					     "failed to find pannel and bridge node\n");
>> -		}

Thank you! I'll resend and cleanup them.

> 
> Various other paths become direct returns as well.
> 
>>  	}
> 
> The later code with remote looks suspect as not obvious who got the reference that
> is being put but assuming that is correct, it's another possible place for __free based
> cleanup.
> 
> 
>>  	if (!child_count) {
>>  		DRM_DEV_ERROR(dev, "lvds port does not have any children\n");
> 

