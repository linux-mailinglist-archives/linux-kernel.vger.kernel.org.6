Return-Path: <linux-kernel+bounces-183900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6765B8C9F94
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 17:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 998141C22276
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 15:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF89137745;
	Mon, 20 May 2024 15:22:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DED5136E39
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 15:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716218520; cv=none; b=UBV6vFnQZ9gTvWa3mVgJlAJ2VIdcVOmx2DrMrvuuRLWrKwv9ZHVOvX2ksy3Rbm2lWKvLd7LklhN7/NhwrptssJZVgUbBxH54jtw552uKpH6ZtuPrgIUutJI/BZMT4JMyThpyNESxq6Ib3qTl7Nof/Cd67lyfz3KJ2nKeHCz3Dmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716218520; c=relaxed/simple;
	bh=MPKHgID2qG+wjU1fHnZrCa7zZGQCaKUpi3gC3zmuUZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p/RTAotakxqhAulk8DQffdy3yCH1v0Js2/j8Jna6xG2e1p4FNghXCcFu2v5T1AOr6cpvLa5oHsuUwHktMH1ZJ+uZNuotAslGiaRScTqPgnbsdu5b7iqhUo2Ff0Rb0W81LSoTqxDVi9cOxWg03023+GbeRFuTq6rvDNTWLkDS4uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 31AA0FEC
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 08:22:20 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F12843F762
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 08:21:55 -0700 (PDT)
Date: Mon, 20 May 2024 16:21:51 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: linux@treblig.org
Cc: mripard@kernel.org, airlied@gmail.com, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/komeda: remove unused struct 'gamma_curve_segment'
Message-ID: <Zktqj8lONGfcl-AU@e110455-lin.cambridge.arm.com>
References: <20240516133724.251750-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240516133724.251750-1-linux@treblig.org>

On Thu, May 16, 2024 at 02:37:24PM +0100, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> 'gamma_curve_segment' looks like it has never been used.
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Acked-by: Liviu Dudau <liviu.dudau@arm.com>

Thanks for the clean up!

Best regards,
Liviu

> ---
>  drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.c b/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.c
> index d8e449e6ebda..50cb8f7ee6b2 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.c
> @@ -72,11 +72,6 @@ struct gamma_curve_sector {
>  	u32 segment_width;
>  };
>  
> -struct gamma_curve_segment {
> -	u32 start;
> -	u32 end;
> -};
> -
>  static struct gamma_curve_sector sector_tbl[] = {
>  	{ 0,    4,  4   },
>  	{ 16,   4,  4   },
> -- 
> 2.45.0
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯

