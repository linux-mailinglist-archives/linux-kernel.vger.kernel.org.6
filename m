Return-Path: <linux-kernel+bounces-302434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA7E95FE64
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 03:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 980C41C21BDE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 01:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B98179F6;
	Tue, 27 Aug 2024 01:40:21 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407171C32
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 01:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724722820; cv=none; b=LVcK9A2nupCGOB2VVn0zRYs6lYHbD73z/Syatall1G09u13tQ2FnnMxVTYqXIh487p3hreUYvW+6Vzp1mkoDP/u54bGcwz7d2CoNyq9Q2ChO4UE87NdBhm+wKwVLg0WAv8LCIP5+wHWU05sfcHU1xgsHbl5SSle7H6T4gFFFlk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724722820; c=relaxed/simple;
	bh=CLznSmIb4/qMnWUWFCXh6Gtr5VWOk+gKcsrQXpmun94=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=k5pA5w7ZIYyilmza2EMBaIryANg5Y7zENJDCnne7QDiDbJZ3CBzvuzBnjUhzJQ1oNBiIy9fjg54GlnR5pZ9uA/f8iFFJRpsAK3INfVb553den06533jjwpbTCg8DXZylg6GTJIeKCXPxlvvRY7b48psze4Hf1SnX49pacZ2pM4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Wt9Fm1yyvzyRDc;
	Tue, 27 Aug 2024 09:39:40 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 14645140257;
	Tue, 27 Aug 2024 09:40:09 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemh500013.china.huawei.com (7.202.181.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 27 Aug 2024 09:40:08 +0800
Message-ID: <5d6debd0-1a02-f631-649e-26fb69e164e2@huawei.com>
Date: Tue, 27 Aug 2024 09:40:07 +0800
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
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

Yes，that is right.

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

It seems to me there's no easy way return here, as it will try
drm_of_find_panel_or_bridge() for each child node, only "child_count =
0" or all child node  drm_of_find_panel_or_bridge() fails it will error
and return.

> 
> Various other paths become direct returns as well.
> 
>>  	}
> 
> The later code with remote looks suspect as not obvious who got the reference that
> is being put but assuming that is correct, it's another possible place for __free based
> cleanup.

Yes, the remote looks suspect.

> 
> 
>>  	if (!child_count) {
>>  		DRM_DEV_ERROR(dev, "lvds port does not have any children\n");
> 

