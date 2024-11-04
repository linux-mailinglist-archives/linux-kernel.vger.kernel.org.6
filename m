Return-Path: <linux-kernel+bounces-394696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D479BB2F9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 12:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55359B28594
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 11:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D458F1D26FE;
	Mon,  4 Nov 2024 11:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BXqa140Q"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AAA1C3314
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 11:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730718543; cv=none; b=kFwrYg5TONciAWGp9sLCnc1B3r36gSLeALd/1zjUX8uW2seLjRlX3C8GrRXi1lCWaIM/uk82bk2te13WJYuSRRF6BIqT5QKmhq+7PqH9EECZUg6kIuKJ+82bN8zI0kyoYL12zQnSgpkUjmAcTDWXUXJei2vmtm4C1Q+14ujx/98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730718543; c=relaxed/simple;
	bh=CmxyomT51mBmVrBFCVkubCuMxRG2w61+kKrAGp4svto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NCMQRg2VPXzJ85/E3Ef9t0a8VezsaVP6hMUvxfHJwwfv31T6W+0qAiFulcBhEwcRRC/ZjHmtogHaH4to4ZcC1lVwtg4hsY+IzlTXR7J0l2I5JBp9+lrFWBwDFfEP9fB9YDzPGmElpekiS/eU+tZJLx8qzVTjthB0ZqOj+KO1ljk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BXqa140Q; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E00951BF209;
	Mon,  4 Nov 2024 11:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730718538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7PzO5L433cbHkPM9TxObotdQ/KU1hq980Za7kO/ySdE=;
	b=BXqa140Q0pbwNWZNMN7YrM9Q20buEo8TapDVt6/rEicJWVctwjUcNw0w9uR6mB4qmAtj9m
	QxP0nk2mVaBt/YiOwZ7ccxvw12QYAXdRzcDp7l9blUwJTI+lihPEYkSXbruOJfdXfZ7oqZ
	z2rXoLjP5GrKmRN6aXtQ7FFtWY2Q7zPRwJZMaE0a93dgcmw1HA0fVXnpd8JrdTASLtQ51F
	OdiaX0rIDmI7LaaoeRpucDSaGm8FwbkDs6ywLEi00ATs/KW+aQjGorPa34/VTeRNRCieC+
	cqMdV9gtqQSTjDYz6AVkixYRqYytovWYeovQ8KEkh0efYAg1WHltQYD95/rsSw==
Date: Mon, 4 Nov 2024 12:08:56 +0100
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
Cc: hamohammed.sa@gmail.com, simona@ffwll.ch, melissa.srw@gmail.com,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/vkms: Drop unnecessary call to drm_crtc_cleanup()
Message-ID: <ZyirSFz0Gs9_TTgX@louis-chauvet-laptop>
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
> 
> Fixes: 99cc528ebe92 ("drm/vkms: Use drmm_crtc_init_with_planes()")
> Signed-off-by: José Expósito <jose.exposito89@gmail.com>

Acked-by: Louis Chauvet <louis.chauvet@bootlin.com>

Applied on drm-misc-next: 
https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/1d43dddd7c38ea1aa93f78f7ee10087afb0a561f

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

