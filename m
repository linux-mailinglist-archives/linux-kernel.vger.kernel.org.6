Return-Path: <linux-kernel+bounces-377907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 294799AC876
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 13:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C90751F22349
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 11:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABF01A7262;
	Wed, 23 Oct 2024 11:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="ab8f5i78"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676F019D075
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 11:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729681431; cv=none; b=qg3FULgvE959BjHlDb5bczE615NiQbbEwZsi1kVwsNM3+Ei7FvrBuw26Ud0M2Rg8kDvN59OIacjdgjRNyZWsM74ybIWG+hZYbMeI4+Zq686CSCrQpQ+WIpmd9fk6U/SS9x8ag6PEeY3EWvfDstdEcW3tYIoOGyjIe4dzSjgYtDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729681431; c=relaxed/simple;
	bh=fJy7SjHNjeJfpwoXYoRqXVBeTrUv6GXVworm99dHB5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KpjPwy39J5dfbAO1/nUktzJKweZ9MxQmQk/kglE+Ro/0TLfnuCtgwCmdywPsyeE7iohDXxwltjvySGwKYXs+anasrGMQ/n03tjudcnKOER2SPXu8rcjcIlQQaE++/NI/IsXPK0U0eR3orA4iW6LZWXzlfADq8DQRVAMHZXYejG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=ab8f5i78; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=bHGP7JRBaCSysfpKlshFcLgSRwMDYg7xmq1kLK1A24s=; b=ab8f5i78WdZUXwGp
	wbqtbsfxiYAumw4Utmi29eFbkaMVABYBaZz68D5czH649u5ecSTBAoQU/BhSm42j1G7F031d8EgNn
	V3Gq7frcwiEie57ldcEwp0vbI6ZmsoxCaX1e4XgqA4gfw/VjArQ6al9KJPDqzsNp83fMYH6X7OrWd
	50uocxktXGnkyCdHPkw3jYfjC1sINTEH6Wa5U+w2xWTRxrX01HMX+u9nEYH5W7mUAASe8u5s3BV1r
	LalTExpRCnLN/GSBAYmkn5Fmjw5MrzPuNEeojqe8r61odsbnrQaIKYHtwmceUlvmiH5AQ6oI1g+8B
	me/PBtU7Uyjnmnv3hg==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1t3Z9J-00CzTf-1G;
	Wed, 23 Oct 2024 11:03:33 +0000
Date: Wed, 23 Oct 2024 11:03:33 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Jocelyn Falempe <jfalempe@redhat.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] drm/client: Remove unused
 drm_client_framebuffer_flush
Message-ID: <ZxjYBbusIbQU6WDv@gallifrey>
References: <20241022232934.238124-1-linux@treblig.org>
 <20241022232934.238124-5-linux@treblig.org>
 <a56b486c-9341-41aa-a3ab-090f7ffd56d6@suse.de>
 <44141638-4d8f-4e11-9ede-51cdb51d3a28@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <44141638-4d8f-4e11-9ede-51cdb51d3a28@redhat.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 11:01:50 up 167 days, 22:15,  1 user,  load average: 0.06, 0.03,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Jocelyn Falempe (jfalempe@redhat.com) wrote:
> On 23/10/2024 08:46, Thomas Zimmermann wrote:
> > Hi
> > 
> > Am 23.10.24 um 01:29 schrieb linux@treblig.org:
> > > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > > 
> > > drm_client_framebuffer_flush() was explicitly added in 2020
> > > by
> > > commit c9c03e3cf072 ("drm/client: Add drm_client_framebuffer_flush()")
> > > but has never been used.
> > > 
> > > Remove it.
> > 
> > I had a patchset to use this helper for fbdev emulation. It just needs
> > preparation in a number of drivers.
> 
> It is used by drm_log, which is under review.
> Please don't remove it.

OK, no problem.

Reviews on the rest of the series would be great.

Dave

> https://patchwork.freedesktop.org/series/136789/
> 
> -- 
> 
> Jocelyn
> 
> 
> > 
> > Best regards
> > Thomas
> > 
> > > 
> > > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> > > ---
> > >   drivers/gpu/drm/drm_client.c | 33 ---------------------------------
> > >   include/drm/drm_client.h     |  1 -
> > >   2 files changed, 34 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/drm_client.c b/drivers/gpu/drm/drm_client.c
> > > index bfedcbf516db..5d10ad3c2ca5 100644
> > > --- a/drivers/gpu/drm/drm_client.c
> > > +++ b/drivers/gpu/drm/drm_client.c
> > > @@ -552,39 +552,6 @@ void drm_client_framebuffer_delete(struct
> > > drm_client_buffer *buffer)
> > >   }
> > >   EXPORT_SYMBOL(drm_client_framebuffer_delete);
> > > -/**
> > > - * drm_client_framebuffer_flush - Manually flush client framebuffer
> > > - * @buffer: DRM client buffer (can be NULL)
> > > - * @rect: Damage rectangle (if NULL flushes all)
> > > - *
> > > - * This calls &drm_framebuffer_funcs->dirty (if present) to flush
> > > buffer changes
> > > - * for drivers that need it.
> > > - *
> > > - * Returns:
> > > - * Zero on success or negative error code on failure.
> > > - */
> > > -int drm_client_framebuffer_flush(struct drm_client_buffer *buffer,
> > > struct drm_rect *rect)
> > > -{
> > > -    if (!buffer || !buffer->fb || !buffer->fb->funcs->dirty)
> > > -        return 0;
> > > -
> > > -    if (rect) {
> > > -        struct drm_clip_rect clip = {
> > > -            .x1 = rect->x1,
> > > -            .y1 = rect->y1,
> > > -            .x2 = rect->x2,
> > > -            .y2 = rect->y2,
> > > -        };
> > > -
> > > -        return buffer->fb->funcs->dirty(buffer->fb, buffer->client-
> > > >file,
> > > -                        0, 0, &clip, 1);
> > > -    }
> > > -
> > > -    return buffer->fb->funcs->dirty(buffer->fb, buffer->client->file,
> > > -                    0, 0, NULL, 0);
> > > -}
> > > -EXPORT_SYMBOL(drm_client_framebuffer_flush);
> > > -
> > >   #ifdef CONFIG_DEBUG_FS
> > >   static int drm_client_debugfs_internal_clients(struct seq_file *m,
> > > void *data)
> > >   {
> > > diff --git a/include/drm/drm_client.h b/include/drm/drm_client.h
> > > index bc0e66f9c425..560aae47e06d 100644
> > > --- a/include/drm/drm_client.h
> > > +++ b/include/drm/drm_client.h
> > > @@ -165,7 +165,6 @@ struct drm_client_buffer {
> > >   struct drm_client_buffer *
> > >   drm_client_framebuffer_create(struct drm_client_dev *client, u32
> > > width, u32 height, u32 format);
> > >   void drm_client_framebuffer_delete(struct drm_client_buffer *buffer);
> > > -int drm_client_framebuffer_flush(struct drm_client_buffer *buffer,
> > > struct drm_rect *rect);
> > >   int drm_client_buffer_vmap_local(struct drm_client_buffer *buffer,
> > >                    struct iosys_map *map_copy);
> > >   void drm_client_buffer_vunmap_local(struct drm_client_buffer *buffer);
> > 
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

