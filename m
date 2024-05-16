Return-Path: <linux-kernel+bounces-181040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 405978C7694
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 14:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECEB7281967
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 12:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35BE145B3D;
	Thu, 16 May 2024 12:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hw0gb46n"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9B53A1B7
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 12:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715863022; cv=none; b=e+V+PZpLfM63m3/BkfqAhQ1eFzz7xGBOdHLgcRjYp0qpKGlzBUZT9vTW2CGB97MZHMsOiQOCECq2pmF6DWeT6Tc3/VORoRHqZ2DWRZwYJd7woMbJBGhIvndZZqyR7/bUjPbrPjJ6jLyC15GPbTOY9asaIp2sj+ULjLZ3pARuZJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715863022; c=relaxed/simple;
	bh=lUIqlFYuN29mBhVFPrstHhiZnHcJHsxCoyUlbxGON78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=svM0QRq7OL/LRc96RdD0m0DWns/T4CVISi1f+nmMKZPDf4yTkweS0OHggHZfLHqDg9te+1PevKIxU2YhG5E153++1dwmzXnFZ0bBD+ToVgfPh8QSAYFHOfRxjcS50VVBXojg5kuM7EoEsIxxfGKvG8WEEcvJtBEvthE6lQAJLfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hw0gb46n; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: jani.nikula@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715863018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r04OWwAV6eA+faXUNBmKwuom7bvhLBgHLac87pt1QOQ=;
	b=hw0gb46ny2v+HvV7NXffk9l8Afg9gqMvJ65EWd0CM8zOs2FoRESiyCSD3gj1HG8eVSBEWU
	xQaf6CykNbaZX4FIgHAmIqGC0mhfBHF1FPfL7jO3gRBYMSxQvWxkqzoGmm6nxcEEN4SdIY
	C0KEI2kIcAyi0vc3SR2SA6KnDaqAmLk=
X-Envelope-To: dri-devel@lists.freedesktop.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: airlied@gmail.com
X-Envelope-To: torvalds@linux-foundation.org
Message-ID: <d24aa187-88b4-4651-9634-f8324880c823@linux.dev>
Date: Thu, 16 May 2024 20:36:54 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: drm: have config DRM_WERROR depend on !WERROR
To: Jani Nikula <jani.nikula@intel.com>, dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, airlied@gmail.com,
 Linus Torvalds <torvalds@linux-foundation.org>
References: <20240516083343.1375687-1-jani.nikula@intel.com>
Content-Language: en-US, en-AU
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <20240516083343.1375687-1-jani.nikula@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,


On 5/16/24 16:33, Jani Nikula wrote:
> If WERROR is already enabled, there's no point in enabling DRM_WERROR or
> asking users about it.
> 
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Closes: https://lore.kernel.org/r/CAHk-=whxT8D_0j=bjtrvj-O=VEOjn6GW8GK4j2V+BiDUntZKAQ@mail.gmail.com
> Fixes: f89632a9e5fa ("drm: Add CONFIG_DRM_WERROR")
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>

Wow, you successfully get Linus's attention, haha.

> ---
>   drivers/gpu/drm/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index 026444eeb5c6..d0aa277fc3bf 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -450,6 +450,7 @@ config DRM_PRIVACY_SCREEN
>   config DRM_WERROR
>   	bool "Compile the drm subsystem with warnings as errors"
>   	depends on DRM && EXPERT
> +	depends on !WERROR
>   	default n
>   	help
>   	  A kernel build should not cause any compiler warnings, and this

-- 
Best regards
Sui

