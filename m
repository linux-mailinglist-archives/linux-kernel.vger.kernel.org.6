Return-Path: <linux-kernel+bounces-391108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B88A09B82C6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 19:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 337CAB2395D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 18:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F971CBE80;
	Thu, 31 Oct 2024 18:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="puFaYlxX"
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26991CC888
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 18:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730400211; cv=none; b=DDDj2BwXIG5pQN+b0LjiYgw2J2i/KZgrHusFcGhVhtyZEvWasLNIUXcRAl0wq7/fPwl05wylaGZntQbBuNklxoU7vjLWo13TzgV618hHTtf5svznFuvXgXopp3tNuFbz4QLN5sfT+38vqNnZRO//rUiB6WbyDIvB/fXbPn0Ul1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730400211; c=relaxed/simple;
	bh=5J+G815Wbq7EpxKxEC5plPgUMW1Atv6u30idwn6WjuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F2UXuWSyuC7pWEq7H/ZJPzXaTCdAT1BDg9GXS13iEKj9NjHA5CaKEPiGB2ImBAiV/MDuW3Vk1L/wmRfjQkjNK9/v+erBPF/4uqIc0PmML0paaqVrZzjdIotpAxy/3UbpixJqqxr52y5kMgIA578T35PqxHNHrjb5WSsEg52QNkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=puFaYlxX; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay9-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::229])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id A75E0C0952
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 18:43:24 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 62BA2FF805;
	Thu, 31 Oct 2024 18:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730400197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VsTHOm+NWP4BjSQVtsW8n2E1wPttB+19xqsC8SoC5nU=;
	b=puFaYlxXCiq9fLS4yVt0sYr7svq8GEuGKgCqab46unRHyuCepv/eDBk2aOlCuY41Bzkr5s
	68IILRex1aQxMiPcx73+Vm0/cT5vhF1BNHlfJhaowJ4hpgTk3fP0lYS5pP7cKkMgTI8fQ0
	sv58ZAuaT2e3SH5QB5k6oi84ji1RkSkxVOz/HbgBvRyLGqt1v9VAFljYyqb+NA9UoCy3S9
	iS+IkxWZkM3Riv31fi+I0D39Rjn9ciqXS4UIy/fcggCKskh22pJcmS8DjWYR2Cnw8zgeHW
	qF6sDDF63oWZ2qRDdGEmZs/OPQhVnpJeA2fceFO6U+5zDn9FSh7NsAC2storug==
Date: Thu, 31 Oct 2024 19:43:15 +0100
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
Cc: hamohammed.sa@gmail.com, simona@ffwll.ch, melissa.srw@gmail.com,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/vkms: Drop unnecessary call to drm_crtc_cleanup()
Message-ID: <ZyPPw6m827Ef1_eQ@louis-chauvet-laptop>
Mail-Followup-To: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
	hamohammed.sa@gmail.com, simona@ffwll.ch, melissa.srw@gmail.com,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20241031183835.3633-1-jose.exposito89@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241031183835.3633-1-jose.exposito89@gmail.com>
X-GND-Sasl: louis.chauvet@bootlin.com

On 31/10/24 - 19:38, José Expósito wrote:
> CRTC creation uses drmm_crtc_init_with_planes(), which automatically
> handles cleanup. However, an unnecessary call to drm_crtc_cleanup() is
> still present in the vkms_output_init() error path.

Thanks!

I discussed about this with Maíra on Monday, I agree with this patch!

I will test your patch next week (checkpatch, sparse, CI) before adding
my Acked-by. One less cleanup line in configFS work, thanks!

Thanks,
Louis Chauvet
 
> Fixes: 99cc528ebe92 ("drm/vkms: Use drmm_crtc_init_with_planes()")
> Signed-off-by: José Expósito <jose.exposito89@gmail.com>
> ---
>  drivers/gpu/drm/vkms/vkms_output.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
> index 0a5a185aa0b0..25a99fde126c 100644
> --- a/drivers/gpu/drm/vkms/vkms_output.c
> +++ b/drivers/gpu/drm/vkms/vkms_output.c
> @@ -92,7 +92,7 @@ int vkms_output_init(struct vkms_device *vkmsdev, int index)
>  				 DRM_MODE_CONNECTOR_VIRTUAL);
>  	if (ret) {
>  		DRM_ERROR("Failed to init connector\n");
> -		goto err_connector;
> +		return ret;
>  	}
>  
>  	drm_connector_helper_add(connector, &vkms_conn_helper_funcs);
> @@ -131,8 +131,5 @@ int vkms_output_init(struct vkms_device *vkmsdev, int index)
>  err_encoder:
>  	drm_connector_cleanup(connector);
>  
> -err_connector:
> -	drm_crtc_cleanup(crtc);
> -
>  	return ret;
>  }
> -- 
> 2.47.0
> 

