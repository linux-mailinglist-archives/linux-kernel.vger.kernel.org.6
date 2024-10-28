Return-Path: <linux-kernel+bounces-385435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E03AE9B3725
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 17:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 687DE1F223C1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 16:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5161DEFFE;
	Mon, 28 Oct 2024 16:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="fldBw7Bn"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073D6155C97
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 16:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730134488; cv=none; b=EXqvSWMgrzMd1kaUAA4nppfoA/Tc7MbX/L8YXb1p9qR3c3gqCXuVWZbDoYCGHRQrqw1eqHgUCyrwsCii6kEDaAD73BT/OIV8K1gWMOVgWepDy0lnpajVVqldz/1BqFRw3xTnDD27Rn3CegPlrptTRUf1bANycihrocoFU5pEij8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730134488; c=relaxed/simple;
	bh=kDYYXtEwDcVFVU30Ud3+jI3BBY7/a2VU32bmxfTEdJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KStJUjq2VfI5MOFTmfP/D5XYkfBX1sqgiSh6h/qqfqzhMHd4s5QJE6mIdglJ4FgWG1IbJ6a5L5/RvbC7x78D+M7y2gVhnObJtNCbFSVIgTbXpKJOhM6eSpcNXP/oSoUB3PXZgrPjl+uG0rXapGDQmGIAVc421sHibbvGU15dfB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=fldBw7Bn; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=AVnjKmwmjF//A5bLFbLEWmmqZOfn3gFmKBQroKAL0ZA=; b=fldBw7BnPeCSNn5o
	3Hdsm2FFepKFMz/mGu2kQhuaFtwucmyXNPODqNalt4Vv+6SfLggsdXnGchCDnVd738tUDxAJT+UMO
	qWIm+ugjYnndKkle6NvybE0BBFBFIxrI8Uu/n7BjvywR2NxjsJiHSsRBm79fQkVKbk8OsjiNesOG1
	AzZ/1f8KKKRWCaKARlKWgswq1REbeQDhgv4fpYnn4JaKVbvgWmSp9iw8lZ9O/Bo6LpsxxeWtLC6wS
	yxH0p8JiBLUH/qDogfrtGi2vg7mb/hhxYuFnBwRbV90ENZC98UvjShC/GxHY9ilQdKD7g6JqxD+sC
	K6ES7j7nkriSKwYRlg==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1t5T0o-00E1Zn-1Y;
	Mon, 28 Oct 2024 16:54:38 +0000
Date: Mon, 28 Oct 2024 16:54:38 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] drm/vblank: Remove unused
 drm_crtc_vblank_count_and_time
Message-ID: <Zx_Bzho9M3bGshLH@gallifrey>
References: <20241022232934.238124-1-linux@treblig.org>
 <20241022232934.238124-4-linux@treblig.org>
 <Zx-4LsWPQEB_1mED@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zx-4LsWPQEB_1mED@intel.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 16:53:32 up 173 days,  4:07,  1 user,  load average: 0.00, 0.00,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Ville Syrjälä (ville.syrjala@linux.intel.com) wrote:
> On Wed, Oct 23, 2024 at 12:29:32AM +0100, linux@treblig.org wrote:
> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > 
> > drm_crtc_vblank_count_and_time() was explicitly added by
> > commit cf6483050e9b ("drm/irq: Add drm_crtc_vblank_count_and_time()")
> > in 2015, but never used.
> 
> I see a bunch of places that could trivially use it.
> That might be the more sensible thing to do so that
> we keep moving towards using the crtc for everything.

Do you intend to send those since you understand it?

> The EXPORT_SYMBOL() looks completely pointless though.

Hmm, we probably shouldn't change that until something uses it?

Dave

> > 
> > Remove it, and rework comments that reference it.
> > 
> > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> > ---
> >  drivers/gpu/drm/drm_vblank.c | 44 +++++++-----------------------------
> >  include/drm/drm_vblank.h     | 10 ++++----
> >  2 files changed, 12 insertions(+), 42 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
> > index 94e45ed6869d..67d6367e9f4b 100644
> > --- a/drivers/gpu/drm/drm_vblank.c
> > +++ b/drivers/gpu/drm/drm_vblank.c
> > @@ -908,10 +908,10 @@ drm_get_last_vbltimestamp(struct drm_device *dev, unsigned int pipe,
> >   * drm_crtc_accurate_vblank_count() for such use-cases.
> >   *
> >   * Note that for a given vblank counter value drm_crtc_handle_vblank()
> > - * and drm_crtc_vblank_count() or drm_crtc_vblank_count_and_time()
> > - * provide a barrier: Any writes done before calling
> > - * drm_crtc_handle_vblank() will be visible to callers of the later
> > - * functions, if the vblank count is the same or a later one.
> > + * and drm_crtc_vblank_count() provide a barrier:
> > + * Any writes done before calling drm_crtc_handle_vblank() will be
> > + * visible to callers of the later functions, if the vblank count is
> > + * the same or a later one.
> >   *
> >   * See also &drm_vblank_crtc.count.
> >   *
> > @@ -936,7 +936,6 @@ EXPORT_SYMBOL(drm_crtc_vblank_count);
> >   * modesetting activity. Returns corresponding system timestamp of the time
> >   * of the vblank interval that corresponds to the current vblank counter value.
> >   *
> > - * This is the legacy version of drm_crtc_vblank_count_and_time().
> >   */
> >  static u64 drm_vblank_count_and_time(struct drm_device *dev, unsigned int pipe,
> >  				     ktime_t *vblanktime)
> > @@ -959,33 +958,6 @@ static u64 drm_vblank_count_and_time(struct drm_device *dev, unsigned int pipe,
> >  	return vblank_count;
> >  }
> >  
> > -/**
> > - * drm_crtc_vblank_count_and_time - retrieve "cooked" vblank counter value
> > - *     and the system timestamp corresponding to that vblank counter value
> > - * @crtc: which counter to retrieve
> > - * @vblanktime: Pointer to time to receive the vblank timestamp.
> > - *
> > - * Fetches the "cooked" vblank count value that represents the number of
> > - * vblank events since the system was booted, including lost events due to
> > - * modesetting activity. Returns corresponding system timestamp of the time
> > - * of the vblank interval that corresponds to the current vblank counter value.
> > - *
> > - * Note that for a given vblank counter value drm_crtc_handle_vblank()
> > - * and drm_crtc_vblank_count() or drm_crtc_vblank_count_and_time()
> > - * provide a barrier: Any writes done before calling
> > - * drm_crtc_handle_vblank() will be visible to callers of the later
> > - * functions, if the vblank count is the same or a later one.
> > - *
> > - * See also &drm_vblank_crtc.count.
> > - */
> > -u64 drm_crtc_vblank_count_and_time(struct drm_crtc *crtc,
> > -				   ktime_t *vblanktime)
> > -{
> > -	return drm_vblank_count_and_time(crtc->dev, drm_crtc_index(crtc),
> > -					 vblanktime);
> > -}
> > -EXPORT_SYMBOL(drm_crtc_vblank_count_and_time);
> > -
> >  /**
> >   * drm_crtc_next_vblank_start - calculate the time of the next vblank
> >   * @crtc: the crtc for which to calculate next vblank time
> > @@ -1978,10 +1950,10 @@ EXPORT_SYMBOL(drm_handle_vblank);
> >   * This is the native KMS version of drm_handle_vblank().
> >   *
> >   * Note that for a given vblank counter value drm_crtc_handle_vblank()
> > - * and drm_crtc_vblank_count() or drm_crtc_vblank_count_and_time()
> > - * provide a barrier: Any writes done before calling
> > - * drm_crtc_handle_vblank() will be visible to callers of the later
> > - * functions, if the vblank count is the same or a later one.
> > + * and drm_crtc_vblank_count() * provide a barrier:
> > + * Any writes done before calling * drm_crtc_handle_vblank() will be
> > + * visible to callers of the later functions, if the vblank count is
> > + * the same or a later one.
> >   *
> >   * See also &drm_vblank_crtc.count.
> >   *
> > diff --git a/include/drm/drm_vblank.h b/include/drm/drm_vblank.h
> > index 151ab1e85b1b..572e54425970 100644
> > --- a/include/drm/drm_vblank.h
> > +++ b/include/drm/drm_vblank.h
> > @@ -141,10 +141,10 @@ struct drm_vblank_crtc {
> >  	 * Current software vblank counter.
> >  	 *
> >  	 * Note that for a given vblank counter value drm_crtc_handle_vblank()
> > -	 * and drm_crtc_vblank_count() or drm_crtc_vblank_count_and_time()
> > -	 * provide a barrier: Any writes done before calling
> > -	 * drm_crtc_handle_vblank() will be visible to callers of the later
> > -	 * functions, iff the vblank count is the same or a later one.
> > +	 * and drm_crtc_vblank_count() provide a barrier:
> > +	 * Any writes done before calling drm_crtc_handle_vblank() will be
> > +	 * visible to callers of the later functions, iff the vblank count is
> > +	 * the same or a later one.
> >  	 *
> >  	 * IMPORTANT: This guarantee requires barriers, therefor never access
> >  	 * this field directly. Use drm_crtc_vblank_count() instead.
> > @@ -260,8 +260,6 @@ struct drm_vblank_crtc *drm_crtc_vblank_crtc(struct drm_crtc *crtc);
> >  int drm_vblank_init(struct drm_device *dev, unsigned int num_crtcs);
> >  bool drm_dev_has_vblank(const struct drm_device *dev);
> >  u64 drm_crtc_vblank_count(struct drm_crtc *crtc);
> > -u64 drm_crtc_vblank_count_and_time(struct drm_crtc *crtc,
> > -				   ktime_t *vblanktime);
> >  int drm_crtc_next_vblank_start(struct drm_crtc *crtc, ktime_t *vblanktime);
> >  void drm_crtc_send_vblank_event(struct drm_crtc *crtc,
> >  			       struct drm_pending_vblank_event *e);
> > -- 
> > 2.47.0
> 
> -- 
> Ville Syrjälä
> Intel
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

