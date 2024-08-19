Return-Path: <linux-kernel+bounces-292715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2565A95735F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 20:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEFDB2834C3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 18:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DAB189512;
	Mon, 19 Aug 2024 18:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="fOpTRt4a"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90139132124
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 18:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724092478; cv=none; b=rCynrCUNDIlis8+27kcgqSa2d7Lfw+OWtAiKbqJBP2uoynlviRI/iwG2IYz/tTmBvCbFegjGV0KGFtyiEUsp6XvlkQAJSCgestlf4MG22rHC6SRm//Yh5AMMy++b+v9xqKFPxfql4Q0+9EzSaK/PI1WDwIq7A3L7j/phYt5gDOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724092478; c=relaxed/simple;
	bh=CXGmN8EyDVzXoe2M8gWWViUhY6WEqQS87W831yysQDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pWqYFn/7qtuCWl7mgJnFw4JkvgRaM9XyTDjx9SrVqENzYGBpoRCEf3zF3Uh6jYignuydQ9Llgh+I67KWbys/39JEdAn17owUSQ6mYxyLkz931rQxMMatmodHe+tXKRhu4Vs0aHUUr6mbdQLPoz48gl4T1fDtJqXJcUIhMS1Z3jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=fOpTRt4a; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1724092473;
	bh=CXGmN8EyDVzXoe2M8gWWViUhY6WEqQS87W831yysQDg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fOpTRt4aPU7zD4FlbxjvuJHOuq1jBVJvY/sdiFEgogTZkfLG3lZoSmuhLcyiisv+y
	 vbbV6duG5k819VA5VzsH9rONgRuPbn7shPg/0dkZ6aUFuVbeN5RpissOJpqRWsdNp8
	 hRpdDkxK9WIfb+rVnmIPyCeyjevdTtwYIHjUUFlU=
Date: Mon, 19 Aug 2024 20:34:33 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, Xinhui Pan <Xinhui.Pan@amd.com>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/radeon: Switch radeon_connector to struct drm_edid
Message-ID: <cd93d170-152e-4217-b325-32da2ed529a8@t-8ch.de>
References: <20240818-radeon-drm_edid-v1-1-4b7fdd19132e@weissschuh.net>
 <87y14s6gke.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87y14s6gke.fsf@intel.com>

On 2024-08-19 11:51:45+0000, Jani Nikula wrote:
> On Sun, 18 Aug 2024, Thomas Weißschuh <linux@weissschuh.net> wrote:
> > "struct drm_edid" is the safe and recommended alternative to "struct edid".
> >
> > Rename the member to make sure that no usage sites are missed,
> > as "struct drm_edid" has some restrictions, for example it can not be
> > used with kfree().
> >
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > ---
> > This is only compile-tested.
> > ---
> >  drivers/gpu/drm/radeon/radeon_audio.c      |  4 +--
> >  drivers/gpu/drm/radeon/radeon_combios.c    |  4 +--
> >  drivers/gpu/drm/radeon/radeon_connectors.c | 54 +++++++++++++++---------------
> >  drivers/gpu/drm/radeon/radeon_mode.h       |  5 ++-
> >  4 files changed, 33 insertions(+), 34 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/radeon/radeon_audio.c b/drivers/gpu/drm/radeon/radeon_audio.c
> > index 47aa06a9a942..59d0e47c94d0 100644
> > --- a/drivers/gpu/drm/radeon/radeon_audio.c
> > +++ b/drivers/gpu/drm/radeon/radeon_audio.c
> > @@ -311,7 +311,7 @@ static void radeon_audio_write_sad_regs(struct drm_encoder *encoder)
> >  	if (!connector)
> >  		return;
> >  
> > -	sad_count = drm_edid_to_sad(radeon_connector->edid, &sads);
> > +	sad_count = drm_edid_to_sad(drm_edid_raw(radeon_connector->drm_edid), &sads);
> 
> The drm_edid_raw() usages could use a FIXME comment; eventually we want
> all of them gone too.

amdgpu and radeon are the last users of drm_edid_to_sad() and
drm_edid_to_speaker_allocation() which do not have access to a drm_edid.
After that we can fix the to function to directly take the drm_edid.
(I have a patch for it)

Personally  I dislike to have so many FIXMEs in the code.

> 
> >  	if (sad_count < 0)
> >  		DRM_ERROR("Couldn't read SADs: %d\n", sad_count);
> >  	if (sad_count <= 0)
> > @@ -335,7 +335,7 @@ static void radeon_audio_write_speaker_allocation(struct drm_encoder *encoder)
> >  	if (!connector)
> >  		return;
> >  
> > -	sad_count = drm_edid_to_speaker_allocation(radeon_connector->edid, &sadb);
> > +	sad_count = drm_edid_to_speaker_allocation(drm_edid_raw(radeon_connector->drm_edid), &sadb);
> >  	if (sad_count < 0) {
> >  		DRM_DEBUG("Couldn't read Speaker Allocation Data Block: %d\n",
> >  			  sad_count);
> > diff --git a/drivers/gpu/drm/radeon/radeon_combios.c b/drivers/gpu/drm/radeon/radeon_combios.c
> > index df8d7f56b028..f4947acd0419 100644
> > --- a/drivers/gpu/drm/radeon/radeon_combios.c
> > +++ b/drivers/gpu/drm/radeon/radeon_combios.c
> > @@ -390,10 +390,10 @@ bool radeon_combios_check_hardcoded_edid(struct radeon_device *rdev)
> >  }
> >  
> >  /* this is used for atom LCDs as well */
> > -struct edid *
> > +const struct drm_edid *
> >  radeon_bios_get_hardcoded_edid(struct radeon_device *rdev)
> >  {
> > -	return drm_edid_duplicate(drm_edid_raw(rdev->mode_info.bios_hardcoded_edid));
> > +	return drm_edid_dup(rdev->mode_info.bios_hardcoded_edid);
> >  }
> >  
> >  static struct radeon_i2c_bus_rec combios_setup_i2c_bus(struct radeon_device *rdev,
> > diff --git a/drivers/gpu/drm/radeon/radeon_connectors.c b/drivers/gpu/drm/radeon/radeon_connectors.c
> > index 528a8f3677c2..87a78c8e09c0 100644
> > --- a/drivers/gpu/drm/radeon/radeon_connectors.c
> > +++ b/drivers/gpu/drm/radeon/radeon_connectors.c
> > @@ -261,7 +261,7 @@ static void radeon_connector_get_edid(struct drm_connector *connector)
> >  	struct radeon_device *rdev = dev->dev_private;
> >  	struct radeon_connector *radeon_connector = to_radeon_connector(connector);
> >  
> > -	if (radeon_connector->edid)
> > +	if (radeon_connector->drm_edid)
> >  		return;
> >  
> >  	/* on hw with routers, select right port */
> > @@ -271,8 +271,8 @@ static void radeon_connector_get_edid(struct drm_connector *connector)
> >  	if ((radeon_connector_encoder_get_dp_bridge_encoder_id(connector) !=
> >  	     ENCODER_OBJECT_ID_NONE) &&
> >  	    radeon_connector->ddc_bus->has_aux) {
> > -		radeon_connector->edid = drm_get_edid(connector,
> > -						      &radeon_connector->ddc_bus->aux.ddc);
> > +		radeon_connector->drm_edid = drm_edid_read_ddc(connector,
> > +							       &radeon_connector->ddc_bus->aux.ddc);
> >  	} else if ((connector->connector_type == DRM_MODE_CONNECTOR_DisplayPort) ||
> >  		   (connector->connector_type == DRM_MODE_CONNECTOR_eDP)) {
> >  		struct radeon_connector_atom_dig *dig = radeon_connector->con_priv;
> > @@ -280,22 +280,22 @@ static void radeon_connector_get_edid(struct drm_connector *connector)
> >  		if ((dig->dp_sink_type == CONNECTOR_OBJECT_ID_DISPLAYPORT ||
> >  		     dig->dp_sink_type == CONNECTOR_OBJECT_ID_eDP) &&
> >  		    radeon_connector->ddc_bus->has_aux)
> > -			radeon_connector->edid = drm_get_edid(&radeon_connector->base,
> > -							      &radeon_connector->ddc_bus->aux.ddc);
> > +			radeon_connector->drm_edid = drm_edid_read_ddc(&radeon_connector->base,
> > +								       &radeon_connector->ddc_bus->aux.ddc);
> >  		else if (radeon_connector->ddc_bus)
> > -			radeon_connector->edid = drm_get_edid(&radeon_connector->base,
> > -							      &radeon_connector->ddc_bus->adapter);
> > +			radeon_connector->drm_edid = drm_edid_read_ddc(&radeon_connector->base,
> > +								       &radeon_connector->ddc_bus->adapter);
> >  	} else if (vga_switcheroo_handler_flags() & VGA_SWITCHEROO_CAN_SWITCH_DDC &&
> >  		   connector->connector_type == DRM_MODE_CONNECTOR_LVDS &&
> >  		   radeon_connector->ddc_bus) {
> > -		radeon_connector->edid = drm_get_edid_switcheroo(&radeon_connector->base,
> > -								 &radeon_connector->ddc_bus->adapter);
> > +		radeon_connector->drm_edid = drm_edid_read_ddc(&radeon_connector->base,
> > +							       &radeon_connector->ddc_bus->adapter);
> 
> drm_edid_read_switcheroo()!

Ack.

> 
> 
> >  	} else if (radeon_connector->ddc_bus) {
> > -		radeon_connector->edid = drm_get_edid(&radeon_connector->base,
> > -						      &radeon_connector->ddc_bus->adapter);
> > +		radeon_connector->drm_edid = drm_edid_read_ddc(&radeon_connector->base,
> > +							       &radeon_connector->ddc_bus->adapter);
> >  	}
> >  
> > -	if (!radeon_connector->edid) {
> > +	if (!radeon_connector->drm_edid) {
> >  		/* don't fetch the edid from the vbios if ddc fails and runpm is
> >  		 * enabled so we report disconnected.
> >  		 */
> > @@ -306,20 +306,22 @@ static void radeon_connector_get_edid(struct drm_connector *connector)
> >  			/* some laptops provide a hardcoded edid in rom for LCDs */
> >  			if (((connector->connector_type == DRM_MODE_CONNECTOR_LVDS) ||
> >  			     (connector->connector_type == DRM_MODE_CONNECTOR_eDP)))
> > -				radeon_connector->edid = radeon_bios_get_hardcoded_edid(rdev);
> > +				radeon_connector->drm_edid = radeon_bios_get_hardcoded_edid(rdev);
> >  		} else {
> >  			/* some servers provide a hardcoded edid in rom for KVMs */
> > -			radeon_connector->edid = radeon_bios_get_hardcoded_edid(rdev);
> > +			radeon_connector->drm_edid = radeon_bios_get_hardcoded_edid(rdev);
> >  		}
> >  	}
> > +
> > +	drm_edid_connector_update(&radeon_connector->base, radeon_connector->drm_edid);
> >  }
> >  
> >  static void radeon_connector_free_edid(struct drm_connector *connector)
> >  {
> >  	struct radeon_connector *radeon_connector = to_radeon_connector(connector);
> >  
> > -	kfree(radeon_connector->edid);
> > -	radeon_connector->edid = NULL;
> > +	drm_edid_free(radeon_connector->drm_edid);
> > +	radeon_connector->drm_edid = NULL;
> >  }
> >  
> >  static int radeon_ddc_get_modes(struct drm_connector *connector)
> > @@ -327,12 +329,12 @@ static int radeon_ddc_get_modes(struct drm_connector *connector)
> >  	struct radeon_connector *radeon_connector = to_radeon_connector(connector);
> >  	int ret;
> >  
> > -	if (radeon_connector->edid) {
> > -		drm_connector_update_edid_property(connector, radeon_connector->edid);
> > -		ret = drm_add_edid_modes(connector, radeon_connector->edid);
> > +	if (radeon_connector->drm_edid) {
> > +		drm_edid_connector_update(connector, radeon_connector->drm_edid);
> > +		ret = drm_edid_connector_add_modes(connector);
> >  		return ret;
> >  	}
> > -	drm_connector_update_edid_property(connector, NULL);
> > +	drm_edid_connector_update(connector, NULL);
> 
> The whole thing above can be simplified, as the functions handle NULL
> parameters just fine.

Ack.

> 
> >  	return 0;
> >  }
> >  
> > @@ -869,7 +871,7 @@ radeon_lvds_detect(struct drm_connector *connector, bool force)
> >  
> >  	/* check for edid as well */
> >  	radeon_connector_get_edid(connector);
> > -	if (radeon_connector->edid)
> > +	if (radeon_connector->drm_edid)
> >  		ret = connector_status_connected;
> >  	/* check acpi lid status ??? */
> >  
> > @@ -1012,13 +1014,12 @@ radeon_vga_detect(struct drm_connector *connector, bool force)
> >  		radeon_connector_free_edid(connector);
> >  		radeon_connector_get_edid(connector);
> >  
> > -		if (!radeon_connector->edid) {
> > +		if (!radeon_connector->drm_edid) {
> >  			DRM_ERROR("%s: probed a monitor but no|invalid EDID\n",
> >  					connector->name);
> >  			ret = connector_status_connected;
> >  		} else {
> > -			radeon_connector->use_digital =
> > -				!!(radeon_connector->edid->input & DRM_EDID_INPUT_DIGITAL);
> > +			radeon_connector->use_digital = drm_edid_is_digital(radeon_connector->drm_edid);
> >  
> >  			/* some oems have boards with separate digital and analog connectors
> >  			 * with a shared ddc line (often vga + hdmi)
> > @@ -1270,7 +1271,7 @@ radeon_dvi_detect(struct drm_connector *connector, bool force)
> >  		radeon_connector_free_edid(connector);
> >  		radeon_connector_get_edid(connector);
> >  
> > -		if (!radeon_connector->edid) {
> > +		if (!radeon_connector->drm_edid) {
> >  			DRM_ERROR("%s: probed a monitor but no|invalid EDID\n",
> >  					connector->name);
> >  			/* rs690 seems to have a problem with connectors not existing and always
> > @@ -1286,8 +1287,7 @@ radeon_dvi_detect(struct drm_connector *connector, bool force)
> >  				broken_edid = true; /* defer use_digital to later */
> >  			}
> >  		} else {
> > -			radeon_connector->use_digital =
> > -				!!(radeon_connector->edid->input & DRM_EDID_INPUT_DIGITAL);
> > +			radeon_connector->use_digital = drm_edid_is_digital(radeon_connector->drm_edid);
> >  
> >  			/* some oems have boards with separate digital and analog connectors
> >  			 * with a shared ddc line (often vga + hdmi)
> > diff --git a/drivers/gpu/drm/radeon/radeon_mode.h b/drivers/gpu/drm/radeon/radeon_mode.h
> > index 421c83fc70dc..ae1d91cd93ec 100644
> > --- a/drivers/gpu/drm/radeon/radeon_mode.h
> > +++ b/drivers/gpu/drm/radeon/radeon_mode.h
> > @@ -38,7 +38,6 @@
> >  #include <linux/i2c.h>
> >  #include <linux/i2c-algo-bit.h>
> >  
> > -struct edid;
> >  struct drm_edid;
> >  struct radeon_bo;
> >  struct radeon_device;
> > @@ -521,7 +520,7 @@ struct radeon_connector {
> >  	bool use_digital;
> >  	/* we need to mind the EDID between detect
> >  	   and get modes due to analog/digital/tvencoder */
> > -	struct edid *edid;
> > +	const struct drm_edid *drm_edid;
> >  	void *con_priv;
> >  	bool dac_load_detect;
> >  	bool detected_by_load; /* if the connection status was determined by load */
> > @@ -843,7 +842,7 @@ radeon_get_crtc_scanout_position(struct drm_crtc *crtc, bool in_vblank_irq,
> >  				 const struct drm_display_mode *mode);
> >  
> >  extern bool radeon_combios_check_hardcoded_edid(struct radeon_device *rdev);
> > -extern struct edid *
> > +extern const struct drm_edid *
> >  radeon_bios_get_hardcoded_edid(struct radeon_device *rdev);
> >  extern bool radeon_atom_get_clock_info(struct drm_device *dev);
> >  extern bool radeon_combios_get_clock_info(struct drm_device *dev);
> >
> > ---
> > base-commit: 19cff16559a4f2d763faf4f8392bf86d3a21b93c
> > change-id: 20240818-radeon-drm_edid-9f0cec36e227
> >
> > Best regards,
> 
> -- 
> Jani Nikula, Intel

