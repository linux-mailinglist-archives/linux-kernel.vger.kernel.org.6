Return-Path: <linux-kernel+bounces-298774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F1B95CB64
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 13:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 378FE1F247AA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 11:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2292C17E01F;
	Fri, 23 Aug 2024 11:32:19 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F0C149019
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 11:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724412738; cv=none; b=mDvDYrbWwKzI3d15KWgN0IPC0C3lqIE/iZ9GWAh4Bc8WP4vYrxuGXlpXOCRzNolr1gE2Ud1fcuTCpPQTOwgNxjceVtxByYasr5azz66jayDbtz1QyQowRIm64yt+ev6pvrAR7Sn0u+EuP/q9wzgo2uM9Kjdkq05SG/yWnP2UWaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724412738; c=relaxed/simple;
	bh=tFbfVnyr3DIYx/NWQgwm34eLvi/SUarX/FL3vR17cYE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C2++dwC2Jkn5ye9rA5dhDxbPZ4Fshh7fnfqeH0rVSJX2fkB+crgi25fTUMYV4DxX6/tx3sJFDAtYeqemosco1N4GLTWxZxCBRx877SHlOvhVUAZGsNPRHXGMdm/txY464H2JQ4MaoaqjOAqGisvYTRET6FIPIubrvxMbD5/xmsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WqyWm6gp2z6K5qM;
	Fri, 23 Aug 2024 19:29:08 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 44505140447;
	Fri, 23 Aug 2024 19:32:13 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 23 Aug
 2024 12:32:04 +0100
Date: Fri, 23 Aug 2024 12:32:03 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
CC: <hjc@rock-chips.com>, <heiko@sntech.de>, <andy.yan@rock-chips.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<dri-devel@lists.freedesktop.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-rockchip@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<krzk@kernel.org>, <jic23@kernel.org>
Subject: Re: [PATCH -next 1/5] drm/rockchip: Use
 for_each_child_of_node_scoped()
Message-ID: <20240823123203.00002aac@Huawei.com>
In-Reply-To: <20240823092053.3170445-2-ruanjinjie@huawei.com>
References: <20240823092053.3170445-1-ruanjinjie@huawei.com>
	<20240823092053.3170445-2-ruanjinjie@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 23 Aug 2024 17:20:49 +0800
Jinjie Ruan <ruanjinjie@huawei.com> wrote:

> Avoids the need for manual cleanup of_node_put() in early exits
> from the loop.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

There is more to do here, and looking at the code, I'm far from
sure it isn't releasing references it never had.

> ---
>  drivers/gpu/drm/rockchip/rockchip_lvds.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.c b/drivers/gpu/drm/rockchip/rockchip_lvds.c
> index 9a01aa450741..f5b3f18794dd 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_lvds.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c
> @@ -548,7 +548,7 @@ static int rockchip_lvds_bind(struct device *dev, struct device *master,
>  	struct drm_encoder *encoder;
>  	struct drm_connector *connector;
>  	struct device_node *remote = NULL;
> -	struct device_node  *port, *endpoint;

Odd extra space before *port in original. Clean that up whilst here.


> +	struct device_node  *port;

Use __free(device_node) for *port as well.

So where the current asignment is.
	struct device_node *port = of_graph_get_port_by_id(dev->of_node, 1);

>  	int ret = 0, child_count = 0;
>  	const char *name;
>  	u32 endpoint_id = 0;
> @@ -560,15 +560,13 @@ static int rockchip_lvds_bind(struct device *dev, struct device *master,
>  			      "can't found port point, please init lvds panel port!\n");
>  		return -EINVAL;
>  	}
> -	for_each_child_of_node(port, endpoint) {
> +	for_each_child_of_node_scoped(port, endpoint) {
>  		child_count++;
>  		of_property_read_u32(endpoint, "reg", &endpoint_id);
>  		ret = drm_of_find_panel_or_bridge(dev->of_node, 1, endpoint_id,
>  						  &lvds->panel, &lvds->bridge);
> -		if (!ret) {
> -			of_node_put(endpoint);
> +		if (!ret)
>  			break;

This then can simply be
			return dev_err_probe(dev, ret,
					     "failed to find pannel and bridge node\n");
> -		}

Various other paths become direct returns as well.

>  	}

The later code with remote looks suspect as not obvious who got the reference that
is being put but assuming that is correct, it's another possible place for __free based
cleanup.


>  	if (!child_count) {
>  		DRM_DEV_ERROR(dev, "lvds port does not have any children\n");


