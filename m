Return-Path: <linux-kernel+bounces-537332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B72A48AA1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 22:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC95116CCDD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 21:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F45E271275;
	Thu, 27 Feb 2025 21:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="jdFrtzEU"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9E426FA5D
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 21:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740692077; cv=none; b=f90I93hSQY77BJjtVZVxNbYz/t1cUD701lucpHCGebrtsDlUk5qs88XXslJXR3xC91ckd22Y3L7Oys2HJOo5DvjN73Ly3o6RfuMq4H+chdbvWUOSj4AmL5N53axl8TuWxob/uKUgwepXwN7gYoHFCcT9ojkJAhWx7lOYan1nZsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740692077; c=relaxed/simple;
	bh=LKtB0xO4FJIdCvbj/YY12A0aar2WBAUQgx5dPzVDHd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BrTDUFn2Irw0d9KGcTunxGXqt6ekHhmdaHpe4++gvV7zLNJu34zPnZHN9PHcFK2i22GzvhLfxl+08ODL7gId7TEeYepB2deOgfEUBuLA9Fv5bMa6YQjYaP8EZEJmy/l5O12fXL0Y0e6pC3PbLO/jr1BQNZphlKQpwWpWvmyqJkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=jdFrtzEU; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=uHZuuz0IVdaWI7A2r3gR44iE1/btqOd/7KwGlKdv5sI=; b=jdFrtzEUfaFAzTI9
	BJ8cCJoE1TwRf58Eu7+tc5sa3fEyoHA9qWklQvSLpqFMg61A/jQYwXJCuUH1EKRAOkRb81x2jpj+Q
	Vn/6Ge4D61oCnoP/lyM7JRLGb+xDNZkqsXvhgh+IXdI55vNFJQpkL0icNSfGX/Y6223lo6n/L2ATa
	rNM8p8th8Wf0T7WEX9+gHzEbJ9iHQeGEHYn0pKXk/4PkLg/zWIaYNUroa5HDFi9fXarYZtHuQtxH1
	xU44NNGG4tRbmr4mJkPyCHLDN/Ea5i/Y/z8S6pfZb8oN5y4n8YB2SfSzHsKqf7YdxyOncIwEgYZv/
	KxrAYc4ENdzcXhv8Sw==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1tnlWH-001TD8-1R;
	Thu, 27 Feb 2025 21:34:13 +0000
Date: Thu, 27 Feb 2025 21:34:13 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: airlied@gmail.com, simona@ffwll.ch
Cc: hdegoede@redhat.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/vboxvideo: Remove unused hgsmi_cursor_position
Message-ID: <Z8DaVW_U-QtBVSMf@gallifrey>
References: <20241215220014.452537-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20241215220014.452537-1-linux@treblig.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 21:31:52 up 295 days,  8:45,  1 user,  load average: 0.00, 0.00,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* linux@treblig.org (linux@treblig.org) wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> hgsmi_cursor_position() has been unused since 2018's
> commit 35f3288c453e ("staging: vboxvideo: Atomic phase 1: convert cursor to
> universal plane")
> 
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Hi David, Simona,
  Will this one be picked up by drm-next?  It got Hans's
review back on 16 Dec.
( in 2513e942-6391-4a96-b487-1e4ba19b7aeb@redhat.com )

  Thanks,

Dave

> ---
>  drivers/gpu/drm/vboxvideo/hgsmi_base.c      | 37 ---------------------
>  drivers/gpu/drm/vboxvideo/vboxvideo_guest.h |  2 --
>  2 files changed, 39 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vboxvideo/hgsmi_base.c b/drivers/gpu/drm/vboxvideo/hgsmi_base.c
> index 87dccaecc3e5..db994aeaa0f9 100644
> --- a/drivers/gpu/drm/vboxvideo/hgsmi_base.c
> +++ b/drivers/gpu/drm/vboxvideo/hgsmi_base.c
> @@ -181,40 +181,3 @@ int hgsmi_update_pointer_shape(struct gen_pool *ctx, u32 flags,
>  
>  	return rc;
>  }
> -
> -/**
> - * hgsmi_cursor_position - Report the guest cursor position.  The host may
> - *                         wish to use this information to re-position its
> - *                         own cursor (though this is currently unlikely).
> - *                         The current host cursor position is returned.
> - * Return: 0 or negative errno value.
> - * @ctx:              The context containing the heap used.
> - * @report_position:  Are we reporting a position?
> - * @x:                Guest cursor X position.
> - * @y:                Guest cursor Y position.
> - * @x_host:           Host cursor X position is stored here.  Optional.
> - * @y_host:           Host cursor Y position is stored here.  Optional.
> - */
> -int hgsmi_cursor_position(struct gen_pool *ctx, bool report_position,
> -			  u32 x, u32 y, u32 *x_host, u32 *y_host)
> -{
> -	struct vbva_cursor_position *p;
> -
> -	p = hgsmi_buffer_alloc(ctx, sizeof(*p), HGSMI_CH_VBVA,
> -			       VBVA_CURSOR_POSITION);
> -	if (!p)
> -		return -ENOMEM;
> -
> -	p->report_position = report_position;
> -	p->x = x;
> -	p->y = y;
> -
> -	hgsmi_buffer_submit(ctx, p);
> -
> -	*x_host = p->x;
> -	*y_host = p->y;
> -
> -	hgsmi_buffer_free(ctx, p);
> -
> -	return 0;
> -}
> diff --git a/drivers/gpu/drm/vboxvideo/vboxvideo_guest.h b/drivers/gpu/drm/vboxvideo/vboxvideo_guest.h
> index 55fcee3a6470..643c4448bdcb 100644
> --- a/drivers/gpu/drm/vboxvideo/vboxvideo_guest.h
> +++ b/drivers/gpu/drm/vboxvideo/vboxvideo_guest.h
> @@ -34,8 +34,6 @@ int hgsmi_query_conf(struct gen_pool *ctx, u32 index, u32 *value_ret);
>  int hgsmi_update_pointer_shape(struct gen_pool *ctx, u32 flags,
>  			       u32 hot_x, u32 hot_y, u32 width, u32 height,
>  			       u8 *pixels, u32 len);
> -int hgsmi_cursor_position(struct gen_pool *ctx, bool report_position,
> -			  u32 x, u32 y, u32 *x_host, u32 *y_host);
>  
>  bool vbva_enable(struct vbva_buf_ctx *vbva_ctx, struct gen_pool *ctx,
>  		 struct vbva_buffer *vbva, s32 screen);
> -- 
> 2.47.1
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

