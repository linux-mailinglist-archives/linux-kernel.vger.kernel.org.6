Return-Path: <linux-kernel+bounces-572583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B59FA6CBDA
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 19:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B25A3A8943
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 18:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F771A0B15;
	Sat, 22 Mar 2025 18:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="P78cOOK3"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C789222D4F9
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 18:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742668666; cv=pass; b=uzKn2tQojv9JvN/uelQj8kYClQ1LX6f5WmfJB4GjlCTyVCWDsSwbRcCc9CxvfakCdJmUGHCCOP4nYU5c9jzz4mfn2aM9bwzG6mFl6RkHqBJty/xWlrfYIFu+Sdn7ZQrfoGlL/TEIUIMddgfXYSrldEiyLbfMJtOOdFt31/4oHjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742668666; c=relaxed/simple;
	bh=j03pJiHqwVrZku3QGFAinoeiMUhR+kuIgqTt7J66m4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tBNQXLcwiLAqsrv+VJcZefa8VLOyTb1zx2KUFpjrrtBls3cScXXqvGTcP3JybkPmUcnAlX2lKAFB4yasg9+tbDYpqgB0f9UG96bKWQ5D/WShZhlo07MSSNuyEwFYgqMeHnSaoNHDV7N9GXAw1xPG2m7SAe311OCY/FHUA213wY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=P78cOOK3; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1742668645; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=XyWN7OBjTEt5Kf6pHc3iqCwNHigU0MHqrbUxGIAfWBdarqVjgx8Xrg62yWTAJMvX2fy2PlKU1bqQMaGdR2PzEQZv1OFcPl2ZulEJ4rR/BmukUvxBI3oYOSef+F12hrl/KG7yS7fhZCpcrWOdYLSEkALO2UEym9+e4dMFAsEX9Qg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1742668645; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=WTVoLyGgbdmzjrUE8T6GsZDPitalOn1Yi5lAm2rNLKM=; 
	b=NGiLLNnXBjvzD/5K9hpWWxGHtM+95jCExdGFmPPZyJUbKLbo67ffGf0M6HfoepEwPHjWcBbBugemU0llRaGEq7+JC2IlwwKNBghor3Tyalav98CoNYuzt5Bwd5fYYArMOufBvZ656cfp+yQ3AEUbCO8ZAxAhzuQ+Nvws4hVnrDo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1742668645;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
	bh=WTVoLyGgbdmzjrUE8T6GsZDPitalOn1Yi5lAm2rNLKM=;
	b=P78cOOK3yLrTakfL9AysUuqlYQIRr71SKVn8pAn/olUWqqBmU/Q7hC8WdsF3SPHk
	QdF230ZqN6rHDjktqqbWFM4+75eyj5Vfq3uQ+SW/h/OjrdwoOesZ8ZHNEMFnCu7uU5u
	15he9RGEwc1srHlluJffNiOWjoK360kz4VghNPOU=
Received: by mx.zohomail.com with SMTPS id 1742668644881646.2713412624316;
	Sat, 22 Mar 2025 11:37:24 -0700 (PDT)
Date: Sat, 22 Mar 2025 18:37:15 +0000
From: Adrian Larumbe <adrian.larumbe@collabora.com>
To: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	boris.brezillon@collabora.com, robh@kernel.org, steven.price@arm.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
	simona@ffwll.ch, kernel@collabora.com, linux-mediatek@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, sjoerd@collabora.com, angelogioacchino.delregno@collabora.com
Subject: Re: [PATCH v4 3/6] drm/panfrost: Set HW_FEATURE_AARCH64_MMU feature
 flag on Bifrost models
Message-ID: <rocdajh3msvq2mesaftg4garbdxl4qn77kxpqhwn4pv2wncc45@x7iejre6y3kb>
References: <20250317145245.910566-1-ariel.dalessandro@collabora.com>
 <20250317145245.910566-4-ariel.dalessandro@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250317145245.910566-4-ariel.dalessandro@collabora.com>

On 17.03.2025 11:52, Ariel D'Alessandro wrote:
> Set this feature flag on all Mali Bifrost platforms as the MMU supports
> AARCH64 4K page table format.
>
> Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Reviewed-by: Steven Price <steven.price@arm.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Adrián Larumbe <adrian.larumbe@collabora.com>

> ---
>  drivers/gpu/drm/panfrost/panfrost_features.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/panfrost/panfrost_features.h b/drivers/gpu/drm/panfrost/panfrost_features.h
> index 7ed0cd3ea2d4c..52f9d69f6db9d 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_features.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_features.h
> @@ -54,6 +54,7 @@ enum panfrost_hw_feature {
>  	BIT_ULL(HW_FEATURE_THREAD_GROUP_SPLIT) | \
>  	BIT_ULL(HW_FEATURE_FLUSH_REDUCTION) | \
>  	BIT_ULL(HW_FEATURE_PROTECTED_MODE) | \
> +	BIT_ULL(HW_FEATURE_AARCH64_MMU) | \
>  	BIT_ULL(HW_FEATURE_COHERENCY_REG))
>
>  #define hw_features_g72 (\
> @@ -64,6 +65,7 @@ enum panfrost_hw_feature {
>  	BIT_ULL(HW_FEATURE_FLUSH_REDUCTION) | \
>  	BIT_ULL(HW_FEATURE_PROTECTED_MODE) | \
>  	BIT_ULL(HW_FEATURE_PROTECTED_DEBUG_MODE) | \
> +	BIT_ULL(HW_FEATURE_AARCH64_MMU) | \
>  	BIT_ULL(HW_FEATURE_COHERENCY_REG))
>
>  #define hw_features_g51 hw_features_g72
> @@ -77,6 +79,7 @@ enum panfrost_hw_feature {
>  	BIT_ULL(HW_FEATURE_PROTECTED_MODE) | \
>  	BIT_ULL(HW_FEATURE_PROTECTED_DEBUG_MODE) | \
>  	BIT_ULL(HW_FEATURE_IDVS_GROUP_SIZE) | \
> +	BIT_ULL(HW_FEATURE_AARCH64_MMU) | \
>  	BIT_ULL(HW_FEATURE_COHERENCY_REG))
>
>  #define hw_features_g76 (\
> --
> 2.47.2


Adrian Larumbe

