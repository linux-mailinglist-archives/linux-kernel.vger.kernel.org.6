Return-Path: <linux-kernel+bounces-301852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD08195F675
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 18:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E92C1B225FB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 16:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60F8194AFE;
	Mon, 26 Aug 2024 16:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VxzO8VlD"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09744194AE8
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 16:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724689476; cv=none; b=a07h4qnSS0D91i+5iLcM2jn0mllJ/L1BuMO43oBxgIMklM7l2vqxObncvYalVmMox/4n0rerPOF9IMFEYF9lnB0ANc105y0rRqWPs9aRz/ZvWpB9hx5iCmQC/iiTw8/wrsUMzsJV1uru+9fUasbyiyDxh4YKi1fXD2HgQeLiD2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724689476; c=relaxed/simple;
	bh=xYyjl9yHr0sIQm0v1xhvSqkG1BAIHRxRoF6JaeHW3lI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q2c3dcjWQyrkp7UtIqgziNUEvsUe9hubVsI/95w+NQWAzh0S87kza9z1fSuzdozBKVFbVfjzCHhQCGbBQPpRCaWD7+E1zJI4CmoPq69Zv3OApzTzh8+GAxKmHuHgfTCO8xaGSDy7a7jaRquR+aLw3jzK5PPn6tHpbrIhNpuC/uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VxzO8VlD; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7846FC0008;
	Mon, 26 Aug 2024 16:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724689472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QpZT8ZOyrLPYZph4KypijYMFnjyv1P3jmjcB/nk8Hlw=;
	b=VxzO8VlDl6U41sC/HLMbyMZXvuuu0Q/C9autbNu40CL3wl0S5GrIe+DigHc8rpgY3Rgam3
	xeE3l8Fzpcfodsg3cpMCGUiK5ToqvWo4NKNdua0nWAQ2vZgPyv8tjryuFGehDFjjUYhl9u
	iKxUdPqMu21pblJin2+oAFs79EJvnYQ7rfn009c+4cRld2YTcqTK91LNSmgtTvFxXlEH3t
	MAMFtwwhi/Y3aCJnQHwmA1JCQSX75qnh6ghIX/IV3lKWWUOhJws4MD53mNzTz5zv313s3E
	++7F2gF3b4Hf3sQdDWxX8Amwi4IpSBbrnsXD9nL61/v0J4bG2hOC1ows9kO9+w==
Date: Mon, 26 Aug 2024 18:24:29 +0200
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
Cc: airlied@gmail.com, arthurgrillo@riseup.net, daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org, hamohammed.sa@gmail.com,
	jeremie.dautheribes@bootlin.com, linux-kernel@vger.kernel.org,
	maarten.lankhorst@linux.intel.com, mairacanal@riseup.net,
	melissa.srw@gmail.com, miquel.raynal@bootlin.com,
	mripard@kernel.org, nicolejadeyee@google.com,
	rodrigosiqueiramelo@gmail.com, seanpaul@google.com,
	thomas.petazzoni@bootlin.com, tzimmermann@suse.de
Subject: Re: [PATCH RFC 2/4] drm/vkms: Switch to managed for encoder
Message-ID: <ZsysPWEzc0nXHnJ_@louis-chauvet-laptop>
Mail-Followup-To: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
	airlied@gmail.com, arthurgrillo@riseup.net, daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org, hamohammed.sa@gmail.com,
	jeremie.dautheribes@bootlin.com, linux-kernel@vger.kernel.org,
	maarten.lankhorst@linux.intel.com, mairacanal@riseup.net,
	melissa.srw@gmail.com, miquel.raynal@bootlin.com,
	mripard@kernel.org, nicolejadeyee@google.com,
	rodrigosiqueiramelo@gmail.com, seanpaul@google.com,
	thomas.petazzoni@bootlin.com, tzimmermann@suse.de
References: <20240814-google-vkms-managed-v1-2-7ab8b8921103@bootlin.com>
 <20240820090930.2869-1-jose.exposito89@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240820090930.2869-1-jose.exposito89@gmail.com>
X-GND-Sasl: louis.chauvet@bootlin.com

Le 20/08/24 - 11:09, José Expósito a écrit :
> > The current VKMS driver uses non-managed function to create encoders. It
> > is not an issue yet, but in order to support multiple devices easly,
> 
> s/easly/easily
> 
> > convert this code to use drm and device managed helpers.
> > 
> > Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> 
> Reviewed-by: José Expósito <jose.exposito89@gmail.com>

Thanks!
 
> > ---
> >  drivers/gpu/drm/vkms/vkms_drv.h    |  1 -
> >  drivers/gpu/drm/vkms/vkms_output.c | 21 +++++++++------------
> >  2 files changed, 9 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
> > index cea7b2640c5d..2c9d1f20ce84 100644
> > --- a/drivers/gpu/drm/vkms/vkms_drv.h
> > +++ b/drivers/gpu/drm/vkms/vkms_drv.h
> > @@ -42,7 +42,6 @@
> >   */
> >  struct vkms_output {
> >  	struct drm_crtc crtc;
> > -	struct drm_encoder encoder;
> >  	struct drm_writeback_connector wb_connector;
> >  	struct hrtimer vblank_hrtimer;
> >  	ktime_t period_ns;
> > diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
> > index 4767838c3a73..cb8507917b5f 100644
> > --- a/drivers/gpu/drm/vkms/vkms_output.c
> > +++ b/drivers/gpu/drm/vkms/vkms_output.c
> > @@ -16,9 +16,7 @@ static const struct drm_connector_funcs vkms_connector_funcs = {
> >  	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
> >  };
> >  
> > -static const struct drm_encoder_funcs vkms_encoder_funcs = {
> > -	.destroy = drm_encoder_cleanup,
> > -};
> > +static const struct drm_encoder_funcs vkms_encoder_funcs = {};
> 
> This struct is not required, drmm_encoder_init() can take a NULL value.
> 
> >  
> >  static int vkms_conn_get_modes(struct drm_connector *connector)
> >  {
> > @@ -55,7 +53,7 @@ int vkms_output_init(struct vkms_device *vkmsdev, int possible_crtc_index)
> >  	struct vkms_output *output = &vkmsdev->output;
> >  	struct drm_device *dev = &vkmsdev->drm;
> >  	struct drm_connector *connector;
> > -	struct drm_encoder *encoder = &output->encoder;
> > +	struct drm_encoder *encoder;
> >  	struct drm_crtc *crtc = &output->crtc;
> >  	struct vkms_plane *primary, *cursor = NULL;
> >  	int ret;
> > @@ -103,8 +101,12 @@ int vkms_output_init(struct vkms_device *vkmsdev, int possible_crtc_index)
> >  
> >  	drm_connector_helper_add(connector, &vkms_conn_helper_funcs);
> >  
> > -	ret = drm_encoder_init(dev, encoder, &vkms_encoder_funcs,
> > -			       DRM_MODE_ENCODER_VIRTUAL, NULL);
> > +	encoder = drmm_kzalloc(&vkmsdev->drm, sizeof(*encoder), GFP_KERNEL);
> 
> &vkmsdev->drm => dev
> 
> > +	if (!encoder)
> 
> The same here, we could log this error:
> 		DRM_ERROR("Failed to allocate encoder\n");
> 
> > +		return -ENOMEM;
> > +
> > +	ret = drmm_encoder_init(dev, encoder, &vkms_encoder_funcs,
> 
> vkms_encoder_funcs can be NULL.
> 
> > +				DRM_MODE_ENCODER_VIRTUAL, NULL);
> >  	if (ret) {
> >  		DRM_ERROR("Failed to init encoder\n");
> >  		return ret;
> > @@ -118,7 +120,7 @@ int vkms_output_init(struct vkms_device *vkmsdev, int possible_crtc_index)
> >  	ret = drm_connector_attach_encoder(connector, encoder);
> >  	if (ret) {
> >  		DRM_ERROR("Failed to attach connector to encoder\n");
> > -		goto err_attach;
> > +		return ret;
> >  	}
> >  
> >  	if (vkmsdev->config->writeback) {
> > @@ -130,9 +132,4 @@ int vkms_output_init(struct vkms_device *vkmsdev, int possible_crtc_index)
> >  	drm_mode_config_reset(dev);
> >  
> >  	return 0;
> > -
> > -err_attach:
> > -	drm_encoder_cleanup(encoder);
> > -
> > -	return ret;
> >  }

