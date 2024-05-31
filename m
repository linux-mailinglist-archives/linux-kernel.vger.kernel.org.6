Return-Path: <linux-kernel+bounces-197083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B91A18D65E8
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 17:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B52C1F288C5
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 15:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD42158DBA;
	Fri, 31 May 2024 15:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mB1YfGVF"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A40158A28;
	Fri, 31 May 2024 15:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717169870; cv=none; b=nUocHXXiq1tMxGcxV6DZPRq9rDY7pYmlWmhNicDFlgoucW7MteX1Ca14x1VhLcxNvhlbQ2SF3wG2WpNEF9UeuBv1uu2QtxncVo95xuOouYFscwqiygjU0CfkGpH4Zp1JY0BCr+IpX/XgkkS3TsPH0VjpEI/K2rjLYYkN3taKd/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717169870; c=relaxed/simple;
	bh=mUXO2DdblDfnX/yel6rUCY+aqhfc76OrpEirW+mvnIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lv3Iv7KPbkGNGKHIquKemWyiu1y7yi7i93OG6NeNCO12ygDgAXksCdPdLkjiXGIPolYf3riZlJrWzXcM5QJ6J8ZZenjBchvskY6f2Iq9J4aNNd1MaoyARpC7R90lbL0EPJ2GQX3yWudoCWVM9ekVW2Tm/JNO3mxsVHkwVYMPCfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mB1YfGVF; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=BK0lac02MNaStyn+3Zy8cAwlufhllQe54r3zrUsXI1M=; b=mB1YfGVFyFVWCtPAGvOyLQLQUA
	ZQXOmYELgdul8Go9nJYOtWA4sAYG5BCcfKcultVk7arYl4pkXCwXblTWNEFoRhJjNUH61cbdKT8qm
	yk5XfX/j6Prz0MtAFaWDmSbeuJIDXp7ZnREJvAMaFBsBwo6oGFaSoUVcTLQmr0sL0UsIIgAh3gJ0o
	kufgW6LN1Vk1F3AbP3/XD5L/RwHidE6lONY0rGfp7H+hgoG9nebL2Pt/jk0DOB8cqPKA8lsinrZPa
	KZE0CNKo8njhBwTe5yqghny425aB9ft+O4NKAaQ4wSxDHqssWwiU3ZGg5LeaR+29tEGkdJokDpHZs
	Y4jKFG7Q==;
Received: from [50.53.4.147] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sD4KA-0000000AiH7-3OIG;
	Fri, 31 May 2024 15:37:47 +0000
Message-ID: <833fac2c-91f9-4e9a-9b9e-da2db955a488@infradead.org>
Date: Fri, 31 May 2024 08:37:45 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] drm/amd/display: Fix a handful of spelling mistakes
To: Colin Ian King <colin.i.king@gmail.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xinhui.Pan@amd.com, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Hung <alex.hung@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240531093211.498880-1-colin.i.king@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240531093211.498880-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/31/24 2:32 AM, Colin Ian King wrote:
> There are a few spelling mistakes in dml2_printf messages. Fix them.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>


Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  .../dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c      | 6 +++---
>  .../display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c  | 6 +++---
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
> index 8062144a5a6d..e7e6751f4477 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
> @@ -5731,7 +5731,7 @@ static bool CalculatePrefetchSchedule(struct dml2_core_internal_scratch *scratch
>  		dml2_printf("DML: Tvm: %fus - time to fetch vm\n", s->TimeForFetchingVM);
>  		dml2_printf("DML: Tr0: %fus - time to fetch first row of data pagetables\n", s->TimeForFetchingRowInVBlank);
>  		dml2_printf("DML: Tsw: %fus = time to fetch enough pixel data and cursor data to feed the scalers init position and detile\n", (double)s->LinesToRequestPrefetchPixelData * s->LineTime);
> -		dml2_printf("DML: To: %fus - time for propogation from scaler to optc\n", (*p->DSTYAfterScaler + ((double)(*p->DSTXAfterScaler) / (double)p->myPipe->HTotal)) * s->LineTime);
> +		dml2_printf("DML: To: %fus - time for propagation from scaler to optc\n", (*p->DSTYAfterScaler + ((double)(*p->DSTXAfterScaler) / (double)p->myPipe->HTotal)) * s->LineTime);
>  		dml2_printf("DML: Tvstartup - TSetup - Tcalc - TWait - Tpre - To > 0\n");
>  		dml2_printf("DML: Tslack(pre): %fus - time left over in schedule\n", p->VStartup * s->LineTime - s->TimeForFetchingVM - 2 * s->TimeForFetchingRowInVBlank - (*p->DSTYAfterScaler + ((double)(*p->DSTXAfterScaler) / (double)p->myPipe->HTotal)) * s->LineTime - p->TWait - p->TCalc - *p->TSetup);
>  		dml2_printf("DML: row_bytes = dpte_row_bytes (per_pipe) = PixelPTEBytesPerRow = : %u\n", p->PixelPTEBytesPerRow);
> @@ -8268,7 +8268,7 @@ static bool dml_core_mode_support(struct dml2_core_calcs_mode_support_ex *in_out
>  	dml2_printf("DML::%s: mode_lib->ms.DCFCLK = %f\n", __func__, mode_lib->ms.DCFCLK);
>  	dml2_printf("DML::%s: mode_lib->ms.FabricClock = %f\n", __func__, mode_lib->ms.FabricClock);
>  	dml2_printf("DML::%s: mode_lib->ms.uclk_freq_mhz = %f\n", __func__, mode_lib->ms.uclk_freq_mhz);
> -	dml2_printf("DML::%s: urgent latency tolarance = %f\n", __func__, ((mode_lib->ip.rob_buffer_size_kbytes - mode_lib->ip.pixel_chunk_size_kbytes) * 1024 / (mode_lib->ms.DCFCLK * mode_lib->soc.return_bus_width_bytes)));
> +	dml2_printf("DML::%s: urgent latency tolerance = %f\n", __func__, ((mode_lib->ip.rob_buffer_size_kbytes - mode_lib->ip.pixel_chunk_size_kbytes) * 1024 / (mode_lib->ms.DCFCLK * mode_lib->soc.return_bus_width_bytes)));
>  #endif
>  
>  	mode_lib->ms.support.OutstandingRequestsSupport = true;
> @@ -11089,7 +11089,7 @@ static bool dml_core_mode_programming(struct dml2_core_calcs_mode_programming_ex
>  				if (display_cfg->plane_descriptors[k].immediate_flip && mode_lib->mp.ImmediateFlipSupportedForPipe[k] == false) {
>  					mode_lib->mp.ImmediateFlipSupported = false;
>  #ifdef __DML_VBA_DEBUG__
> -					dml2_printf("DML::%s: Pipe %0d not supporing iflip!\n", __func__, k);
> +					dml2_printf("DML::%s: Pipe %0d not supporting iflip!\n", __func__, k);
>  #endif
>  				}
>  			}
> diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c
> index f2e2250d28d3..6eb3fec87ec1 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c
> @@ -1988,7 +1988,7 @@ bool dml2_core_shared_mode_support(struct dml2_core_calcs_mode_support_ex *in_ou
>  	dml2_printf("DML::%s: mode_lib->ms.FabricClock = %f\n", __func__, mode_lib->ms.FabricClock);
>  	dml2_printf("DML::%s: mode_lib->ms.uclk_freq_mhz = %f\n", __func__, mode_lib->ms.uclk_freq_mhz);
>  	dml2_printf("DML::%s: max_urgent_latency_us = %f\n", __func__, mode_lib->ms.support.max_urgent_latency_us);
> -	dml2_printf("DML::%s: urgent latency tolarance = %f\n", __func__, ((mode_lib->ip.rob_buffer_size_kbytes - mode_lib->ip.pixel_chunk_size_kbytes) * 1024 / (mode_lib->ms.DCFCLK * mode_lib->soc.return_bus_width_bytes)));
> +	dml2_printf("DML::%s: urgent latency tolerance = %f\n", __func__, ((mode_lib->ip.rob_buffer_size_kbytes - mode_lib->ip.pixel_chunk_size_kbytes) * 1024 / (mode_lib->ms.DCFCLK * mode_lib->soc.return_bus_width_bytes)));
>  #endif
>  
>  	mode_lib->ms.support.OutstandingRequestsSupport = true;
> @@ -8131,7 +8131,7 @@ static bool CalculatePrefetchSchedule(struct dml2_core_internal_scratch *scratch
>  		dml2_printf("DML: Tvm: %fus - time to fetch vm\n", s->TimeForFetchingVM);
>  		dml2_printf("DML: Tr0: %fus - time to fetch first row of data pagetables\n", s->TimeForFetchingRowInVBlank);
>  		dml2_printf("DML: Tsw: %fus = time to fetch enough pixel data and cursor data to feed the scalers init position and detile\n", (double)s->LinesToRequestPrefetchPixelData * s->LineTime);
> -		dml2_printf("DML: To: %fus - time for propogation from scaler to optc\n", (*p->DSTYAfterScaler + ((double)(*p->DSTXAfterScaler) / (double)p->myPipe->HTotal)) * s->LineTime);
> +		dml2_printf("DML: To: %fus - time for propagation from scaler to optc\n", (*p->DSTYAfterScaler + ((double)(*p->DSTXAfterScaler) / (double)p->myPipe->HTotal)) * s->LineTime);
>  		dml2_printf("DML: Tvstartup - TSetup - Tcalc - TWait - Tpre - To > 0\n");
>  		dml2_printf("DML: Tslack(pre): %fus - time left over in schedule\n", p->VStartup * s->LineTime - s->TimeForFetchingVM - 2 * s->TimeForFetchingRowInVBlank - (*p->DSTYAfterScaler + ((double)(*p->DSTXAfterScaler) / (double)p->myPipe->HTotal)) * s->LineTime - p->TWait - p->TCalc - *p->TSetup);
>  		dml2_printf("DML: row_bytes = dpte_row_bytes (per_pipe) = PixelPTEBytesPerRow = : %u\n", p->PixelPTEBytesPerRow);
> @@ -10959,7 +10959,7 @@ bool dml2_core_shared_mode_programming(struct dml2_core_calcs_mode_programming_e
>  				if (display_cfg->plane_descriptors[k].immediate_flip && mode_lib->mp.ImmediateFlipSupportedForPipe[k] == false) {
>  					mode_lib->mp.ImmediateFlipSupported = false;
>  #ifdef __DML_VBA_DEBUG__
> -					dml2_printf("DML::%s: Pipe %0d not supporing iflip!\n", __func__, k);
> +					dml2_printf("DML::%s: Pipe %0d not supporting iflip!\n", __func__, k);
>  #endif
>  				}
>  			}

-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

