Return-Path: <linux-kernel+bounces-538450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBACA498E5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 13:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E4DA3BC6CB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 12:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5455C26B086;
	Fri, 28 Feb 2025 12:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="eAW5u2N7"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89BB26A1CD
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 12:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740744781; cv=none; b=J2L0IuISZOf3/O6Ug3N++Ayt5ttM0+IMTmLahrpyYNVmpFJ7mBtZbiVuSmZqD04Ybkmkr+bOZexaIJEB82SlkE9LNaI46LTMPEZZdUiZF2u4AMuTTrVG0uIiaM4K0KKEiHleWYAZJIZ1+d0Ez/phLeYrQDe9dJ/TemzJPIhn1G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740744781; c=relaxed/simple;
	bh=p5FTCxkDarvA4bFqx29jb7fzd25JkroGfFErjHdL8lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UH2/ygsqNc+FHmKpwGXHsSC+0M+OGRufoUwP5hUP+PBwi7HJQRxLMQLHPPb4q9Pa1HMlQkvh0qRoFpijGl6jUdQgCg/Zvn7wc/85iHKY7wNFJEjx0wwcJ/xvmjCg7e1dEb0IR7iO1K2Nzv+GTqj4zgTJUUQmPAU7i/UF7cQX7yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=eAW5u2N7; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=G9cZKFxW4oLU983sOFab31be+2wQdCOOeWwGe3gB4bQ=; b=eAW5u2N7Z2g0hcGe
	gJgITOVoeZ7woxeI0C/ECMrFQ2iWbEKDJmBcuRQy/0adXTR9qguodqsLi7naIHx7Og3qbWP8JlpTn
	4NPc0B5bz6Dz7/tE7zPMi44p/zVQEFj2riutUcUIgkhofPvDCE/pq65TOJ1d+R+rgtigPkNYsrYXw
	FmDCadJYV7jnwaUNIe/jLXV/TpIPECSP81rFY2V9yqRtAvjsKNrQIK0E8T1yrKptY5GVCYJJSkHcU
	vxin1GiLq/0arByDHxVbF14LqlVA354MX30lTTh3KYTyh+N96mYXwoj46tIvKrogdCXPVHYs4f69A
	TE7HO+t2rhNZ4Ee/Lg==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1tnzEP-001cNB-0w;
	Fri, 28 Feb 2025 12:12:41 +0000
Date: Fri, 28 Feb 2025 12:12:41 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: airlied@gmail.com, simona@ffwll.ch, hdegoede@redhat.com,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/vboxvideo: Remove unused hgsmi_cursor_position
Message-ID: <Z8GoOUjgtq-1WCiw@gallifrey>
References: <20241215220014.452537-1-linux@treblig.org>
 <Z8DaVW_U-QtBVSMf@gallifrey>
 <f853d48f-f0aa-45af-89f3-4081a620f234@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <f853d48f-f0aa-45af-89f3-4081a620f234@suse.de>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 12:12:03 up 295 days, 23:26,  1 user,  load average: 0.01, 0.01,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Thomas Zimmermann (tzimmermann@suse.de) wrote:
> Hi
> 
> Am 27.02.25 um 22:34 schrieb Dr. David Alan Gilbert:
> > * linux@treblig.org (linux@treblig.org) wrote:
> > > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > > 
> > > hgsmi_cursor_position() has been unused since 2018's
> > > commit 35f3288c453e ("staging: vboxvideo: Atomic phase 1: convert cursor to
> > > universal plane")
> > > 
> > > Remove it.
> > > 
> > > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> > Hi David, Simona,
> >    Will this one be picked up by drm-next?  It got Hans's
> > review back on 16 Dec.
> > ( in 2513e942-6391-4a96-b487-1e4ba19b7aeb@redhat.com )
> 
> Merged into drm-misc-next now. Apologies for the delay.

Thanks; I've got a bunch of other old ones with reviews I'll also ping
soon.

Dave

> Best regards
> Thomas
> 
> > 
> >    Thanks,
> > 
> > Dave
> > 
> > > ---
> > >   drivers/gpu/drm/vboxvideo/hgsmi_base.c      | 37 ---------------------
> > >   drivers/gpu/drm/vboxvideo/vboxvideo_guest.h |  2 --
> > >   2 files changed, 39 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/vboxvideo/hgsmi_base.c b/drivers/gpu/drm/vboxvideo/hgsmi_base.c
> > > index 87dccaecc3e5..db994aeaa0f9 100644
> > > --- a/drivers/gpu/drm/vboxvideo/hgsmi_base.c
> > > +++ b/drivers/gpu/drm/vboxvideo/hgsmi_base.c
> > > @@ -181,40 +181,3 @@ int hgsmi_update_pointer_shape(struct gen_pool *ctx, u32 flags,
> > >   	return rc;
> > >   }
> > > -
> > > -/**
> > > - * hgsmi_cursor_position - Report the guest cursor position.  The host may
> > > - *                         wish to use this information to re-position its
> > > - *                         own cursor (though this is currently unlikely).
> > > - *                         The current host cursor position is returned.
> > > - * Return: 0 or negative errno value.
> > > - * @ctx:              The context containing the heap used.
> > > - * @report_position:  Are we reporting a position?
> > > - * @x:                Guest cursor X position.
> > > - * @y:                Guest cursor Y position.
> > > - * @x_host:           Host cursor X position is stored here.  Optional.
> > > - * @y_host:           Host cursor Y position is stored here.  Optional.
> > > - */
> > > -int hgsmi_cursor_position(struct gen_pool *ctx, bool report_position,
> > > -			  u32 x, u32 y, u32 *x_host, u32 *y_host)
> > > -{
> > > -	struct vbva_cursor_position *p;
> > > -
> > > -	p = hgsmi_buffer_alloc(ctx, sizeof(*p), HGSMI_CH_VBVA,
> > > -			       VBVA_CURSOR_POSITION);
> > > -	if (!p)
> > > -		return -ENOMEM;
> > > -
> > > -	p->report_position = report_position;
> > > -	p->x = x;
> > > -	p->y = y;
> > > -
> > > -	hgsmi_buffer_submit(ctx, p);
> > > -
> > > -	*x_host = p->x;
> > > -	*y_host = p->y;
> > > -
> > > -	hgsmi_buffer_free(ctx, p);
> > > -
> > > -	return 0;
> > > -}
> > > diff --git a/drivers/gpu/drm/vboxvideo/vboxvideo_guest.h b/drivers/gpu/drm/vboxvideo/vboxvideo_guest.h
> > > index 55fcee3a6470..643c4448bdcb 100644
> > > --- a/drivers/gpu/drm/vboxvideo/vboxvideo_guest.h
> > > +++ b/drivers/gpu/drm/vboxvideo/vboxvideo_guest.h
> > > @@ -34,8 +34,6 @@ int hgsmi_query_conf(struct gen_pool *ctx, u32 index, u32 *value_ret);
> > >   int hgsmi_update_pointer_shape(struct gen_pool *ctx, u32 flags,
> > >   			       u32 hot_x, u32 hot_y, u32 width, u32 height,
> > >   			       u8 *pixels, u32 len);
> > > -int hgsmi_cursor_position(struct gen_pool *ctx, bool report_position,
> > > -			  u32 x, u32 y, u32 *x_host, u32 *y_host);
> > >   bool vbva_enable(struct vbva_buf_ctx *vbva_ctx, struct gen_pool *ctx,
> > >   		 struct vbva_buffer *vbva, s32 screen);
> > > -- 
> > > 2.47.1
> > > 
> 
> -- 
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Frankenstrasse 146, 90461 Nuernberg, Germany
> GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
> HRB 36809 (AG Nuernberg)
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

