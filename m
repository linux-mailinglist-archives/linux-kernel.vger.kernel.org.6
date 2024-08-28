Return-Path: <linux-kernel+bounces-305084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2914C962948
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 15:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D95EE285A9B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 13:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FFB186E2C;
	Wed, 28 Aug 2024 13:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="VIdn+1S8"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED93A175D5D
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 13:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724853072; cv=none; b=PqauhOrUIR7HVAcR/25Iym6cdvPp7FDd/VfMRpiqCPDrl3rFEAfSQ7UkKDw1/+uj/0ekxtx2c/NA2/HaYhqNOwJY6XNbaUn9jXVrKjkOAArGF3bpucL9bowMcjrsoevu3NM92vwZ4wGhcBWjLL3xnGfFNkQe7MCjA2lOBSlFKxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724853072; c=relaxed/simple;
	bh=0JqbVVk8ZKB5BH0F3tvupNAmLRWvpSuhEZuWeLBjlQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o82sSJsIJyxzQT5ITjDw+sDETzy/4dinSxMrfmFaT7s5Ll+MM9N6FWowcRj9m+yLm1pPMtfmgIyfvcbljtfsJLh38iKAvkzXlz/49/DwueFxsmU265nnU/0mw26K/LA0FFftMpyHV7J+U3p6VS5W30OkTW5BCiypHr6tj3zz0tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=VIdn+1S8; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1A49F2C5;
	Wed, 28 Aug 2024 15:50:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1724853000;
	bh=0JqbVVk8ZKB5BH0F3tvupNAmLRWvpSuhEZuWeLBjlQA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VIdn+1S8BYJtynOyCu2LikSnR6kDI0dICtB47/5pEm0btk2jXBwQg0DkIzcyq7j3e
	 n7sMOeMeJtcC7tkh59itW+VdVeUL3+y7QtJfaZhXcdzCUpvYB1Jxh6IXP+ASLFGdvb
	 6/x1NjjWU8+ci7XCnXZB0jrGYST3e78AP94D1XVU=
Date: Wed, 28 Aug 2024 16:51:03 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: tomi.valkeinen@ideasonboard.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	daniel@ffwll.ch, michal.simek@amd.com,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] drm: zynqmp_dp: Use
 devm_platform_ioremap_resource_byname()
Message-ID: <20240828135103.GC27131@pendragon.ideasonboard.com>
References: <20240828084929.2527228-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240828084929.2527228-1-ruanjinjie@huawei.com>

Hi Jinjie,

Thank you for the patch.

On Wed, Aug 28, 2024 at 04:49:29PM +0800, Jinjie Ruan wrote:
> platform_get_resource_byname() and devm_ioremap_resource() can be
> replaced by devm_platform_ioremap_resource_byname(), which can
> simplify the code logic a bit, No functional change here.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Tomi, feel free to push this to drm-misc.

> ---
>  drivers/gpu/drm/xlnx/zynqmp_dp.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c b/drivers/gpu/drm/xlnx/zynqmp_dp.c
> index 129beac4c073..4eb19ac95bdb 100644
> --- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
> +++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
> @@ -1715,7 +1715,6 @@ int zynqmp_dp_probe(struct zynqmp_dpsub *dpsub)
>  	struct platform_device *pdev = to_platform_device(dpsub->dev);
>  	struct drm_bridge *bridge;
>  	struct zynqmp_dp *dp;
> -	struct resource *res;
>  	int ret;
>  
>  	dp = kzalloc(sizeof(*dp), GFP_KERNEL);
> @@ -1729,8 +1728,7 @@ int zynqmp_dp_probe(struct zynqmp_dpsub *dpsub)
>  	INIT_WORK(&dp->hpd_work, zynqmp_dp_hpd_work_func);
>  
>  	/* Acquire all resources (IOMEM, IRQ and PHYs). */
> -	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dp");
> -	dp->iomem = devm_ioremap_resource(dp->dev, res);
> +	dp->iomem = devm_platform_ioremap_resource_byname(pdev, "dp");
>  	if (IS_ERR(dp->iomem)) {
>  		ret = PTR_ERR(dp->iomem);
>  		goto err_free;

-- 
Regards,

Laurent Pinchart

