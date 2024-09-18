Return-Path: <linux-kernel+bounces-332690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 786A897BD35
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 15:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F31491F23252
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 13:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FF418A6D8;
	Wed, 18 Sep 2024 13:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="L+GVSpqq"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A3A16FF45
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 13:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726666895; cv=none; b=Sb5igX/+3GWwdnp/WzGWa+Rxz/boDiebsgJX5OIY2ePvp8BaqQGvKQ5nAg4l3JxjScslkZD9pczg/1i8BRIi2oRK/UoFJ5EnjH+ML1XmW9TbVDU7je4z9332SuN9O7uSgHzDUPD7q7wC/YpPtACZiZVKbmA67w7MPciquWGT/oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726666895; c=relaxed/simple;
	bh=fEjMuvLNAT0QhjJ9pfzlvpLb0w7B23M0p8zE93JrC1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=poQfTlkRr8VFm/CyLHHPaTrFX7SR7TdiPLewm6jXjzLONpRkmVyI9Kos/gm9hbHo44mbffLxnSu9PoP6HhZX7laaxAoRtZ9MsyfHb+hT2231b1xtRM+Dm2qRfCojIMDZXyZOsb4kgCqUaJwzDpWCvNrUGJs2Wclyj/YgEvjt3NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=L+GVSpqq; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F2AF51C0010;
	Wed, 18 Sep 2024 13:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1726666890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rAY9cN6Z9NY/XbFmukbFAgwfkl3fXG7BleBv30HSNDo=;
	b=L+GVSpqqDDkcFz6lzcnToh6BWBjzR4RBjLMfS7n9IhGwL5lTavGUcHu3rXGA1I+O9ZqJ0S
	uXMhLnnjFbYC98/nSlMrAMY59nmWi75V4TbQ1jT8BtskciYdhVbkDSvUKDbTDWwvZyCQvy
	2xyyKsqRjvHUb5Z5wxvYPDxaaciFVF+n+zRf2/C5aMO2p01Auw/e71QouUD+tq1+stBAUQ
	A/sPa8oB9FEdutXMHKxvjiacFXY7J+RDq1pjcShCeoThO1R97aFJUX57BOMUafWmSrapyP
	Lr+4N49IxdPsGesihzdbsE7xGi9+W8cImx0hqkQENIYIY3pyCHMsIpp4s8imLg==
Date: Wed, 18 Sep 2024 15:41:27 +0200
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
Cc: airlied@gmail.com, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
	hamohammed.sa@gmail.com, linux-kernel@vger.kernel.org,
	maarten.lankhorst@linux.intel.com, mairacanal@riseup.net,
	melissa.srw@gmail.com, mripard@kernel.org,
	rodrigosiqueiramelo@gmail.com, thomas.petazzoni@bootlin.com,
	tzimmermann@suse.de
Subject: Re: [PATCH] drm/vkms: Remove index parameter from init_vkms_output
Message-ID: <ZurYh47gu4MCPVuY@localhost.localdomain>
Mail-Followup-To: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
	airlied@gmail.com, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
	hamohammed.sa@gmail.com, linux-kernel@vger.kernel.org,
	maarten.lankhorst@linux.intel.com, mairacanal@riseup.net,
	melissa.srw@gmail.com, mripard@kernel.org,
	rodrigosiqueiramelo@gmail.com, thomas.petazzoni@bootlin.com,
	tzimmermann@suse.de
References: <20240906-vkms-remove-index-v1-1-3cfedd8ccb2f@bootlin.com>
 <20240917160216.2921-1-jose.exposito89@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240917160216.2921-1-jose.exposito89@gmail.com>
X-GND-Sasl: louis.chauvet@bootlin.com

Le 17/09/24 - 18:02, José Expósito a écrit :
> Hi Louis,
> 
> > VKMS currently supports only one CRTC, so it make no sense to have this
> > index configurable. To avoid issues, replace this hardcoded index by
> > drm_crtc_mask when applicable.
> > 
> > There is no need to manually set a crtc mask on primary and cursor plane
> > as it is automatically set by drmm_crtc_alloc_with_planes.
> > 
> > In addition, this will remove the use of an uninitialized structure in
> > vkms_add_overlay_plane. This currently works by chance because two things:
> > - vkms_plane_init always set a possible_crtcs value, so the problematic
> >   branch is never used;
> > - drm_crtc_mask on an kzalloc'd drm_crtc returns BIT(0), and the VKMS CRTC
> >   always have this id.
> > 
> > Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> > ---
> >  drivers/gpu/drm/vkms/vkms_drv.c    |  2 +-
> >  drivers/gpu/drm/vkms/vkms_drv.h    |  4 ++--
> >  drivers/gpu/drm/vkms/vkms_output.c | 42 +++++++++++++-------------------------
> >  drivers/gpu/drm/vkms/vkms_plane.c  |  4 ++--
> >  4 files changed, 19 insertions(+), 33 deletions(-)
> > 
> > 
> > ---
> > base-commit: a6bb1f77a94335de67dba12e7f52651c115b82d2
> > change-id: 20240906-vkms-remove-index-3a6e04c38e02
> > 
> > Best regards,
> > 
> > diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
> > index 0c1a713b7b7b..1226a790bece 100644
> > --- a/drivers/gpu/drm/vkms/vkms_drv.c
> > +++ b/drivers/gpu/drm/vkms/vkms_drv.c
> > @@ -172,7 +172,7 @@ static int vkms_modeset_init(struct vkms_device *vkmsdev)
> >  	dev->mode_config.preferred_depth = 0;
> >  	dev->mode_config.helper_private = &vkms_mode_config_helpers;
> >  
> > -	return vkms_output_init(vkmsdev, 0);
> > +	return vkms_output_init(vkmsdev);
> >  }
> >  
> >  static int vkms_create(struct vkms_config *config)
> > diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
> > index 5e46ea5b96dc..dac063f11dcd 100644
> > --- a/drivers/gpu/drm/vkms/vkms_drv.h
> > +++ b/drivers/gpu/drm/vkms/vkms_drv.h
> > @@ -148,10 +148,10 @@ struct vkms_device {
> >  int vkms_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
> >  		   struct drm_plane *primary, struct drm_plane *cursor);
> >  
> > -int vkms_output_init(struct vkms_device *vkmsdev, int index);
> > +int vkms_output_init(struct vkms_device *vkmsdev);
> >  
> >  struct vkms_plane *vkms_plane_init(struct vkms_device *vkmsdev,
> > -				   enum drm_plane_type type, int index);
> > +				   enum drm_plane_type type);
> >  
> >  /* CRC Support */
> >  const char *const *vkms_get_crc_sources(struct drm_crtc *crtc,
> > diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
> > index 5ce70dd946aa..a6a942b4f84f 100644
> > --- a/drivers/gpu/drm/vkms/vkms_output.c
> > +++ b/drivers/gpu/drm/vkms/vkms_output.c
> > @@ -31,47 +31,24 @@ static const struct drm_connector_helper_funcs vkms_conn_helper_funcs = {
> >  	.get_modes    = vkms_conn_get_modes,
> >  };
> >  
> > -static int vkms_add_overlay_plane(struct vkms_device *vkmsdev, int index,
> > -				  struct drm_crtc *crtc)
> > -{
> > -	struct vkms_plane *overlay;
> > -
> > -	overlay = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_OVERLAY, index);
> > -	if (IS_ERR(overlay))
> > -		return PTR_ERR(overlay);
> > -
> > -	if (!overlay->base.possible_crtcs)
> > -		overlay->base.possible_crtcs = drm_crtc_mask(crtc);
> > -
> > -	return 0;
> > -}
> > -
> > -int vkms_output_init(struct vkms_device *vkmsdev, int index)
> > +int vkms_output_init(struct vkms_device *vkmsdev)
> >  {
> >  	struct vkms_output *output = &vkmsdev->output;
> >  	struct drm_device *dev = &vkmsdev->drm;
> >  	struct drm_connector *connector = &output->connector;
> >  	struct drm_encoder *encoder = &output->encoder;
> >  	struct drm_crtc *crtc = &output->crtc;
> > -	struct vkms_plane *primary, *cursor = NULL;
> > +	struct vkms_plane *primary, *overlay, *cursor = NULL;
> >  	int ret;
> >  	int writeback;
> >  	unsigned int n;
> >  
> > -	primary = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_PRIMARY, index);
> > +	primary = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_PRIMARY);
> >  	if (IS_ERR(primary))
> >  		return PTR_ERR(primary);
> >  
> > -	if (vkmsdev->config->overlay) {
> > -		for (n = 0; n < NUM_OVERLAY_PLANES; n++) {
> > -			ret = vkms_add_overlay_plane(vkmsdev, index, crtc);
> > -			if (ret)
> > -				return ret;
> > -		}
> > -	}
> > -
> >  	if (vkmsdev->config->cursor) {
> > -		cursor = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_CURSOR, index);
> > +		cursor = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_CURSOR);
> >  		if (IS_ERR(cursor))
> >  			return PTR_ERR(cursor);
> >  	}
> > @@ -80,6 +57,15 @@ int vkms_output_init(struct vkms_device *vkmsdev, int index)
> >  	if (ret)
> >  		return ret;
> >  
> > +	if (vkmsdev->config->overlay) {
> > +		for (n = 0; n < NUM_OVERLAY_PLANES; n++) {
> > +			overlay = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_OVERLAY);
> > +			if (IS_ERR(overlay))
> > +				return PTR_ERR(overlay);
> 
> At this point the CRTC is initialized and, in case of error, it
> would need to be freed with drm_crtc_cleanup().
> 
> Instead of returning, you'd need to jump to "err_connector", which
> would need to be renamed to something else that makes sense.

Thanks for pointing this I missed this, I will fix it for v2!
 
> Jose
> 
> > +			overlay->base.possible_crtcs = drm_crtc_mask(crtc);
> > +		}
> > +	}
> > +
> >  	ret = drm_connector_init(dev, connector, &vkms_connector_funcs,
> >  				 DRM_MODE_CONNECTOR_VIRTUAL);
> >  	if (ret) {
> > @@ -95,7 +81,7 @@ int vkms_output_init(struct vkms_device *vkmsdev, int index)
> >  		DRM_ERROR("Failed to init encoder\n");
> >  		goto err_encoder;
> >  	}
> > -	encoder->possible_crtcs = 1;
> > +	encoder->possible_crtcs = drm_crtc_mask(crtc);
> >  
> >  	ret = drm_connector_attach_encoder(connector, encoder);
> >  	if (ret) {
> > diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
> > index e5c625ab8e3e..ad137c9a75f5 100644
> > --- a/drivers/gpu/drm/vkms/vkms_plane.c
> > +++ b/drivers/gpu/drm/vkms/vkms_plane.c
> > @@ -198,12 +198,12 @@ static const struct drm_plane_helper_funcs vkms_plane_helper_funcs = {
> >  };
> >  
> >  struct vkms_plane *vkms_plane_init(struct vkms_device *vkmsdev,
> > -				   enum drm_plane_type type, int index)
> > +				   enum drm_plane_type type)
> >  {
> >  	struct drm_device *dev = &vkmsdev->drm;
> >  	struct vkms_plane *plane;
> >  
> > -	plane = drmm_universal_plane_alloc(dev, struct vkms_plane, base, 1 << index,
> > +	plane = drmm_universal_plane_alloc(dev, struct vkms_plane, base, 0,
> >  					   &vkms_plane_funcs,
> >  					   vkms_formats, ARRAY_SIZE(vkms_formats),
> >  					   NULL, type, NULL);
> > 

