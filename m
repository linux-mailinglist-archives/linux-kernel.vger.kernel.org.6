Return-Path: <linux-kernel+bounces-242370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4DD3928730
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 12:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4029AB264E6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 10:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21D114A4D0;
	Fri,  5 Jul 2024 10:54:19 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6135C1494D7
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 10:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720176859; cv=none; b=XjS9TeKEtCI2ZEEZjeblD5GcjI7YTEyKD8D90lIeeztAOBjYVllYzudtLtdsssPsV6o2RM8dTEzkwGiTU5jNyy4/ZIipyQuLomqVRHH1+QkAEVmvaYiRDoIV2jUFgpYG4ppL6sjzjOl740pNVFpLGtiVteHYLTO6XswdO0zWwfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720176859; c=relaxed/simple;
	bh=dJaw7Yj8YHyhn2HGwoWXWTb4R+MZDDf5X2EPbwEHge4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YbULccbfijtGP9+1t40udLzeYXCHHkeclpL4MjYWsw1RymwhD2Xx+0PL96zCayMp97E+XtmEEhOuIOdWnLYb7CEFTJaHv+tnPhy2av9I6WvjVemdNukb52plb9ZWtKvMegvrMPGwOAi6If6Zg2Ofoy6rlfqLg+LiqveEzn7RFxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WFr2m6Sjbz6K6Jn;
	Fri,  5 Jul 2024 18:53:04 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id C2DB0140B38;
	Fri,  5 Jul 2024 18:54:14 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 5 Jul
 2024 11:54:14 +0100
Date: Fri, 5 Jul 2024 11:54:13 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Kousik Sanagavarapu <five231003@gmail.com>
CC: Julia Lawall <julia.lawall@inria.fr>, Nishanth Menon <nm@ti.com>, Santosh
 Shilimkar <ssantosh@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Shuah
 Khan <skhan@linuxfoundation.org>, "Javier Carrasco"
	<javier.carrasco.cruz@gmail.com>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 3/3] soc: ti: pm33xx: do device_node auto cleanup
Message-ID: <20240705115413.0000307d@Huawei.com>
In-Reply-To: <20240703065710.13786-4-five231003@gmail.com>
References: <20240703065710.13786-1-five231003@gmail.com>
	<20240703065710.13786-4-five231003@gmail.com>
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
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed,  3 Jul 2024 12:25:28 +0530
Kousik Sanagavarapu <five231003@gmail.com> wrote:

> Use scope based cleanup instead of manual of_node_put() calls, hence
> simplifying the handling of error paths.
> 
> Suggested-by: Julia Lawall <julia.lawall@inria.fr>
> Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
I think you can make use of dev_err_probe() in here to
further simplify things (a bit anyway!)

Jonathan

> ---
>  drivers/soc/ti/pm33xx.c | 20 +++++++-------------
>  1 file changed, 7 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/soc/ti/pm33xx.c b/drivers/soc/ti/pm33xx.c
> index 8e983c3c4e03..40988c45ed00 100644
> --- a/drivers/soc/ti/pm33xx.c
> +++ b/drivers/soc/ti/pm33xx.c
> @@ -383,10 +383,9 @@ static void am33xx_pm_free_sram(void)
>   */
>  static int am33xx_pm_alloc_sram(void)
>  {
> -	struct device_node *np;
> -	int ret = 0;
> +	struct device_node *np __free(device_node) =
> +			of_find_compatible_node(NULL, NULL, "ti,omap3-mpu");
>  
> -	np = of_find_compatible_node(NULL, NULL, "ti,omap3-mpu");
>  	if (!np) {
>  		np = of_find_compatible_node(NULL, NULL, "ti,omap4-mpu");
>  		if (!np) {
> @@ -400,24 +399,21 @@ static int am33xx_pm_alloc_sram(void)
>  	if (!sram_pool) {
>  		dev_err(pm33xx_dev, "PM: %s: Unable to get sram pool for ocmcram\n",
>  			__func__);
> -		ret = -ENODEV;
> -		goto mpu_put_node;
> +		return -ENODEV;
>  	}
>  
>  	sram_pool_data = of_gen_pool_get(np, "pm-sram", 1);
>  	if (!sram_pool_data) {
>  		dev_err(pm33xx_dev, "PM: %s: Unable to get sram data pool for ocmcram\n",
>  			__func__);
> -		ret = -ENODEV;
> -		goto mpu_put_node;
> +		return -ENODEV;
>  	}
>  
>  	ocmcram_location = gen_pool_alloc(sram_pool, *pm_sram->do_wfi_sz);
>  	if (!ocmcram_location) {
>  		dev_err(pm33xx_dev, "PM: %s: Unable to allocate memory from ocmcram\n",
>  			__func__);
> -		ret = -ENOMEM;
> -		goto mpu_put_node;
> +		return -ENOMEM;
Why not dev_err_probe()?
Seems to only be called from a probe() callback.

>  	}
>  
>  	ocmcram_location_data = gen_pool_alloc(sram_pool_data,
> @@ -425,12 +421,10 @@ static int am33xx_pm_alloc_sram(void)
>  	if (!ocmcram_location_data) {
>  		dev_err(pm33xx_dev, "PM: Unable to allocate memory from ocmcram\n");
>  		gen_pool_free(sram_pool, ocmcram_location, *pm_sram->do_wfi_sz);
> -		ret = -ENOMEM;
> +		return -ENOMEM;
I doubt the ordering matters so can probably do dev_err_probe() in here.
>  	}
>  
> -mpu_put_node:
> -	of_node_put(np);
> -	return ret;
> +	return 0;
>  }
>  
>  static int am33xx_pm_rtc_setup(void)


