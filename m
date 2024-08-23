Return-Path: <linux-kernel+bounces-298733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A217095CABD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 12:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 490BF1F27702
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 10:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1B618732C;
	Fri, 23 Aug 2024 10:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Q695rhya"
Received: from smtp.smtpout.orange.fr (smtp-14.smtpout.orange.fr [80.12.242.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9618C18754D
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 10:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724410017; cv=none; b=bx+KZeXMeYfUucqFT0xZ+jMdf96p+11dfn0bIUnlRf41rQJ4Oypr6k13lskagEg6G17U54VjY5oV/JCfgop8F3k+mJiwPH4F8smTMUokcSwHrNnBxcKaxgj3YgErNv5juAbbW2ckjKUvTwlYibLyVtcD5g2asEP3jCG+uMJXteI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724410017; c=relaxed/simple;
	bh=b96i6lfJuw3wgTE90YXX8fUd2WtCJrryICZRXgKIm9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jWc7ByOVvK8jVuBQZWjmQMYxCFjmRAF/NM+G7sKwTlNbNDT+RWMN+bC/w2aHOJE3H0kIFh+qPSQS841dK3w8wIyDCcqyaNwWNnmMTqYmq4XHybmiht8P/2BeCJTvSJxz61EDh0xB2iQDcQWC6qYmFw3VJML3rZmxJKoS0PL2MTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Q695rhya; arc=none smtp.client-ip=80.12.242.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id hRoUsL4HOzHoQhRoUsTS08; Fri, 23 Aug 2024 12:46:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1724410006;
	bh=M+BJHoqbevs+877BilSmYJZwm2Wj3hyd0gs95c8CmS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=Q695rhyaBTCa8GxEUvcbWDnTM+h61/+qeGfRPaskg25Rmw3+MPFnHIXrEEKIENaPg
	 plIuyFymEP3Jv4vPVizYLBwaRBW+jzBeASP7/nlnkpkbYu1vP8JVUY+uilslZ+M2Xq
	 K7/Rby9SyhmGKEczNXRpJpcBJVTtu353UW1rhZXCSja80MtYtDf33PrKLirykyytCl
	 5a3gY/F/G59CSPrJ+JgjLfh210d3fWSx0aJ4WSy8XcdbuJK+bvmfMCtNb7Skudf7RC
	 mMKNXknhM2YyGDTKam4yub8cdwekmw7m19YjJ2jfAsQzlv+4B0pvIXa2JZzyWqtHKd
	 JqWM25hr7IA0Q==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Fri, 23 Aug 2024 12:46:46 +0200
X-ME-IP: 90.11.132.44
Message-ID: <a4d23c3a-9791-4d2b-9853-9c9b27460db5@wanadoo.fr>
Date: Fri, 23 Aug 2024 12:46:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 2/5] drm/mediatek: Fix missing of_node_put() for
 mtk_drm_get_all_drm_priv()
To: Jinjie Ruan <ruanjinjie@huawei.com>, hjc@rock-chips.com, heiko@sntech.de,
 andy.yan@rock-chips.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 krzk@kernel.org, jic23@kernel.org
References: <20240823092053.3170445-1-ruanjinjie@huawei.com>
 <20240823092053.3170445-3-ruanjinjie@huawei.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240823092053.3170445-3-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 23/08/2024 à 11:20, Jinjie Ruan a écrit :
> In mtk_drm_get_all_drm_priv(), break in for_each_child_of_node() should
> call of_node_put() to avoid child node resource leak, use
> for_each_child_of_node_scoped() to fix it.
> 
> And avoid the need for manual cleanup of_node_put() in early exits
> from the loop for another one.
> 
> Fixes: d761b9450e31 ("drm/mediatek: Add cnt checking for coverity issue")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>   drivers/gpu/drm/mediatek/mtk_drm_drv.c | 10 +++-------
>   1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> index 77b50c56c124..41aff0183cbd 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -371,12 +371,11 @@ static bool mtk_drm_get_all_drm_priv(struct device *dev)
>   	struct mtk_drm_private *temp_drm_priv;
>   	struct device_node *phandle = dev->parent->of_node;
>   	const struct of_device_id *of_id;
> -	struct device_node *node;
>   	struct device *drm_dev;
>   	unsigned int cnt = 0;
>   	int i, j;
>   
> -	for_each_child_of_node(phandle->parent, node) {
> +	for_each_child_of_node_scoped(phandle->parent, node) {
>   		struct platform_device *pdev;
>   
>   		of_id = of_match_node(mtk_drm_of_ids, node);
> @@ -828,7 +827,6 @@ static int mtk_drm_probe(struct platform_device *pdev)
>   	struct device_node *phandle = dev->parent->of_node;
>   	const struct of_device_id *of_id;
>   	struct mtk_drm_private *private;
> -	struct device_node *node;
>   	struct component_match *match = NULL;
>   	struct platform_device *ovl_adaptor;
>   	int ret;
> @@ -869,7 +867,7 @@ static int mtk_drm_probe(struct platform_device *pdev)
>   	}
>   
>   	/* Iterate over sibling DISP function blocks */
> -	for_each_child_of_node(phandle->parent, node) {
> +	for_each_child_of_node_scoped(phandle->parent, node) {
>   		const struct of_device_id *of_id;
>   		enum mtk_ddp_comp_type comp_type;
>   		int comp_id;
> @@ -933,10 +931,8 @@ static int mtk_drm_probe(struct platform_device *pdev)
>   		}
>   
>   		ret = mtk_ddp_comp_init(node, &private->ddp_comp[comp_id], comp_id);
> -		if (ret) {
> -			of_node_put(node);
> +		if (ret)
>   			goto err_node;

Hi,

I've seen on another thread that is was not sure that scoped versions 
and gotos played well together.

It was asked to check more in details and confirm that it was safe 
before applying the patch.

I've not followed the discussion, so I just point it out, in case it helps.

I'll try to give it a look in the coming days.


CJ

> -		}
>   	}
>   
>   	if (!private->mutex_node) {


