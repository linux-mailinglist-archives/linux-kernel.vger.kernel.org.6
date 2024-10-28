Return-Path: <linux-kernel+bounces-385082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C495A9B322C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 14:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B4381F22688
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 13:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9ABA1DC19A;
	Mon, 28 Oct 2024 13:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="AhGlPWYG"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEEE1D9341
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 13:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730123573; cv=none; b=CcXa3rN4mXQ+QQeIEKpIr8m/E2X5kKLynpREbFfuPKj7XVRnyqoG6I5+WjjPT3RSPKKHYIHfgQQqSaXKsTW26r7eviPHp4TI8vhzL22GHixARccT0sT0TGGxMwxslaBTH52XDM+MEZFETy2ozeRQl8wX9+ZPMswAej7zyXRexNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730123573; c=relaxed/simple;
	bh=vVqhPfgBhgeuvDAm9XppgKxOcxNyc45bcb8vYhsBSVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vmu0ZK/JVOmPkATnPSWMFQ5k+RwXNDARlPmjYdBCbZXk6QyKdd0LJosTfsfi5OaH77mBtuVDxkpd+hUomq2ZROgiz+1k199U8OrZ1t9jtDlIuWiUdhE+zUsSwrIcxrlu0k1CpqlzS945AwP6TOt/PYMwWK0l6GOF/CW2edFV8Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=AhGlPWYG; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=o32MA+a6kTD/M+9AA75OQEg/YuYNo/r4de4OQFNR1cE=; b=AhGlPWYG3O+GzH8G
	aV3Nz3f973a0nXlabg2SdWENhISEo/wOEWNyFYBfQ6rwHH1ahnfGmQTe9NETHdXvl/pLQmiQ4iqME
	HZDiM8tKdOI9pUDiL6sBkeXc/VJNdyYisVrQtV+qB8jRnFNOjVsd8hg4Sl+3NaMHZa0zBpbqKxR2K
	kDs/DmFsrkJq0ia7S/G28O7vOCm0bxdKCvtoONOFPusMngAOQL6krJpuoSS3MYY7Uprw2Rh8Io0mu
	k9v/SPKNQ+Mt/MGHgGFxUJoV3zFma3d6PDL40Y3Fi42koNamZ8/cNOA0cBG9xgJEWjFS4CDhZei2E
	sHn2N5HRGBwhyEKS3A==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1t5QAl-00DyII-0b;
	Mon, 28 Oct 2024 13:52:43 +0000
Date: Mon, 28 Oct 2024 13:52:43 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] drm/client: Remove unused drm_client_modeset_check
Message-ID: <Zx-XK7XTJLOpzpvT@gallifrey>
References: <20241022232934.238124-1-linux@treblig.org>
 <20241022232934.238124-6-linux@treblig.org>
 <zvhtltfbu6dpwri7yuwwrpnno6g2hu7tv2q7ua73epfj6gi5e6@x2snh7otbalb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <zvhtltfbu6dpwri7yuwwrpnno6g2hu7tv2q7ua73epfj6gi5e6@x2snh7otbalb>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 13:52:02 up 173 days,  1:06,  1 user,  load average: 0.00, 0.00,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Dmitry Baryshkov (dmitry.baryshkov@linaro.org) wrote:
> On Wed, Oct 23, 2024 at 12:29:34AM +0100, linux@treblig.org wrote:
> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > 
> > drm_client_modeset_check() was explicitly added in 2020 by
> > commit 64593f2a6fc9 ("drm/client: Add drm_client_modeset_check()")
> > but has never been used.
> > 
> > Remove it.
> 
> If you are removing it, it makes more sense to revert the mentioned
> commit completely, dropping the third argument of
> drm_client_modeset_commit_atomic().

Sure, I can look at that; and resend this series also without 4/5 which
people still wanted.
What about 3/5 - that's the only one that's not reviewed either way?

Dave

> > 
> > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> > ---
> >  drivers/gpu/drm/drm_client_modeset.c | 24 ------------------------
> >  include/drm/drm_client.h             |  1 -
> >  2 files changed, 25 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_client_modeset.c b/drivers/gpu/drm/drm_client_modeset.c
> > index cee5eafbfb81..69e1ce4d18cd 100644
> > --- a/drivers/gpu/drm/drm_client_modeset.c
> > +++ b/drivers/gpu/drm/drm_client_modeset.c
> > @@ -1126,30 +1126,6 @@ static int drm_client_modeset_commit_legacy(struct drm_client_dev *client)
> >  	return ret;
> >  }
> >  
> > -/**
> > - * drm_client_modeset_check() - Check modeset configuration
> > - * @client: DRM client
> > - *
> > - * Check modeset configuration.
> > - *
> > - * Returns:
> > - * Zero on success or negative error code on failure.
> > - */
> > -int drm_client_modeset_check(struct drm_client_dev *client)
> > -{
> > -	int ret;
> > -
> > -	if (!drm_drv_uses_atomic_modeset(client->dev))
> > -		return 0;
> > -
> > -	mutex_lock(&client->modeset_mutex);
> > -	ret = drm_client_modeset_commit_atomic(client, true, true);
> > -	mutex_unlock(&client->modeset_mutex);
> > -
> > -	return ret;
> > -}
> > -EXPORT_SYMBOL(drm_client_modeset_check);
> > -
> >  /**
> >   * drm_client_modeset_commit_locked() - Force commit CRTC configuration
> >   * @client: DRM client
> > diff --git a/include/drm/drm_client.h b/include/drm/drm_client.h
> > index 560aae47e06d..e1fd32adb3e9 100644
> > --- a/include/drm/drm_client.h
> > +++ b/include/drm/drm_client.h
> > @@ -176,7 +176,6 @@ int drm_client_modeset_create(struct drm_client_dev *client);
> >  void drm_client_modeset_free(struct drm_client_dev *client);
> >  int drm_client_modeset_probe(struct drm_client_dev *client, unsigned int width, unsigned int height);
> >  bool drm_client_rotation(struct drm_mode_set *modeset, unsigned int *rotation);
> > -int drm_client_modeset_check(struct drm_client_dev *client);
> >  int drm_client_modeset_commit_locked(struct drm_client_dev *client);
> >  int drm_client_modeset_commit(struct drm_client_dev *client);
> >  int drm_client_modeset_dpms(struct drm_client_dev *client, int mode);
> > -- 
> > 2.47.0
> > 
> 
> -- 
> With best wishes
> Dmitry
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

