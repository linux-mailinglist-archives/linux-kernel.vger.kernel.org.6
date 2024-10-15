Return-Path: <linux-kernel+bounces-366517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBAA599F6BE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 21:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D1121F241B4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 19:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D481F80C5;
	Tue, 15 Oct 2024 19:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="SedXyKGs"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582691F80A1;
	Tue, 15 Oct 2024 19:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729019192; cv=pass; b=GR2h8OOvid4xQsonj5ABV04z3WBumUwjU3Ylp7aBqwPTJkc+2+s4r2pyo6tUFeDqfJEYeK6mofkgTkBc5CmyIPVeDgU3Rdef1XvFFsoSDPbIrnPj+dhpabmWwW76gsZY7JNV/9L0NhQqXFewQTCl0dzh+TQfs+n2yijyWZYZa+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729019192; c=relaxed/simple;
	bh=CarnKUlhEU03dHn4YNQcPgKD7oX57DpUNhiC4PewB1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cuIUgI1bD0tseTcgaLHz4v06YRpDYy6BEb1hqhD+/GuTKWqoaP8TSsazkC2n47Ehi4Sfj85hJCc+kZRZkXPojhtssdfmsGkVHWpoOLISipyoWBhsbuHDpbpS00+lD8faaIzBer0zIhmm7C5tZoJvxFt9Zv0Ymn6YDvmvC9abCXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=SedXyKGs; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1729019147; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=dB1vlzJPn4ZQ9O+yJ3xePEbvZOkN4EjPA6hUzpPQgt6DEN19OmLbv2RsgLNszKADe30OX/QA6dhvq33Yr7Vfatb1PotiEmWedb4oeE54xBMZ7eDPvIlPqhaWZ411QH6XsBzaRPLYDxKHgUxhcx9WVM7mvT0cFtwbyDZ76L3cnks=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1729019147; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=wDPu8Hrc9URjHX/IjEjHZZ5zhMpMQLyvAxJls66kHv8=; 
	b=HmflID4oApGQv5At/vq+zdX+oEH1qi4AihKG1O/fzJsTLcq9PyihhjoiB0qFuHdVReG7c/5rCCOSYN+laqxFHLd+s4plN/bF1A26QlaryCTBzh6HX3woP4W2ex4yIy9Cu/fHwG8RagDKnkCfdez2AcD0HOQZ5AVqAWcJOg2n2N4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1729019147;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
	bh=wDPu8Hrc9URjHX/IjEjHZZ5zhMpMQLyvAxJls66kHv8=;
	b=SedXyKGs5Iry/O4Y7FG1ui3dQYsY0YavLWQFDO7UAxLusfYLLOQRgLEypDqr/roA
	TqqNW+DaCgxBNigxqyCL9IbDo+gAaCvIKJ7JuHsYCC/dEUdDUzB5aHWjHWKp6JYXdtK
	+3uYOUvAcP2Zp7II3ml6zB8oo3WryGLZQ2Ch3UmE=
Received: by mx.zohomail.com with SMTPS id 1729019145808902.2055791020094;
	Tue, 15 Oct 2024 12:05:45 -0700 (PDT)
Date: Tue, 15 Oct 2024 20:05:40 +0100
From: =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>
To: Tvrtko Ursulin <tursulin@ursulin.net>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	Boris Brezillon <boris.brezillon@collabora.com>, Rob Herring <robh@kernel.org>, 
	Steven Price <steven.price@arm.com>, Melissa Wen <mwen@igalia.com>, 
	=?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>, Lucas De Marchi <lucas.demarchi@intel.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	freedreno@lists.freedesktop.org
Subject: Re: [RFC PATCH 1/2] drm/drm_file: Add display of driver's internal
 memory size
Message-ID: <5h4vxk6hw7fkw4rebqprfdf3tmz7skdxfh6qgljcd4thxkpobu@jly67q62us4b>
References: <20241002234531.3113431-1-adrian.larumbe@collabora.com>
 <20241002234531.3113431-2-adrian.larumbe@collabora.com>
 <6657b080-f41e-4c95-8895-e474f1ca5d57@ursulin.net>
 <p72rfjerzsg4wsp6rgfcoo5fmlu77jmzdynosflj2hlos63pql@mnetv3t66wsc>
 <87a21c19-8fd2-492a-a620-243cd9c642dc@ursulin.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a21c19-8fd2-492a-a620-243cd9c642dc@ursulin.net>

Hi Tvrtko,

On 10.10.2024 10:50, Tvrtko Ursulin wrote:
> 
> On 09/10/2024 23:55, Adrián Larumbe wrote:
> > Hi Tvrtko,
> > 
> > On 04.10.2024 14:41, Tvrtko Ursulin wrote:
> > > 
> > > Hi Adrian,
> > > 
> > > On 03/10/2024 00:45, Adrián Larumbe wrote:
> > > > Some drivers must allocate a considerable amount of memory for bookkeeping
> > > > structures and GPU's MCU-kernel shared communication regions. These are
> > > > often created as a result of the invocation of the driver's ioctl()
> > > > interface functions, so it is sensible to consider them as being owned by
> > > > the render context associated with an open drm file.
> > > > 
> > > > However, at the moment drm_show_memory_stats only traverses the UM-exposed
> > > > drm objects for which a handle exists. Private driver objects and memory
> > > > regions, though connected to a render context, are unaccounted for in their
> > > > fdinfo numbers.
> > > > 
> > > > Add a new drm_memory_stats 'internal' memory category.
> > > > 
> > > > Because deciding what constitutes an 'internal' object and where to find
> > > > these are driver-dependent, calculation of this size must be done through a
> > > > driver-provided function pointer, which becomes the third argument of
> > > > drm_show_memory_stats. Drivers which have no interest in exposing the size
> > > > of internal memory objects can keep passing NULL for unaltered behaviour.
> > > > 
> > > > Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> > > > Cc: Rob Clark <robdclark@gmail.com>
> > > > Cc: Tvrtko Ursulin <tursulin@ursulin.net>
> > > > Cc: Lucas De Marchi <lucas.demarchi@intel.com>
> > > > ---
> > > >    drivers/gpu/drm/drm_file.c              | 6 +++++-
> > > >    drivers/gpu/drm/msm/msm_drv.c           | 2 +-
> > > >    drivers/gpu/drm/panfrost/panfrost_drv.c | 2 +-
> > > >    drivers/gpu/drm/v3d/v3d_drv.c           | 2 +-
> > > >    include/drm/drm_file.h                  | 7 ++++++-
> > > >    5 files changed, 14 insertions(+), 5 deletions(-)
> > > > 
> > > > diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
> > > > index ad1dc638c83b..937471339c9a 100644
> > > > --- a/drivers/gpu/drm/drm_file.c
> > > > +++ b/drivers/gpu/drm/drm_file.c
> > > > @@ -856,6 +856,7 @@ void drm_print_memory_stats(struct drm_printer *p,
> > > >    	print_size(p, "total", region, stats->private + stats->shared);
> > > >    	print_size(p, "shared", region, stats->shared);
> > > >    	print_size(p, "active", region, stats->active);
> > > > +	print_size(p, "internal", region, stats->internal);
> > > >    	if (supported_status & DRM_GEM_OBJECT_RESIDENT)
> > > >    		print_size(p, "resident", region, stats->resident);
> > > > @@ -873,7 +874,7 @@ EXPORT_SYMBOL(drm_print_memory_stats);
> > > >     * Helper to iterate over GEM objects with a handle allocated in the specified
> > > >     * file.
> > > >     */
> > > > -void drm_show_memory_stats(struct drm_printer *p, struct drm_file *file)
> > > > +void drm_show_memory_stats(struct drm_printer *p, struct drm_file *file, internal_bos func)
> > > >    {
> > > >    	struct drm_gem_object *obj;
> > > >    	struct drm_memory_stats status = {};
> > > > @@ -919,6 +920,9 @@ void drm_show_memory_stats(struct drm_printer *p, struct drm_file *file)
> > > >    	}
> > > >    	spin_unlock(&file->table_lock);
> > > > +	if (func)
> > > > +		func(&status, file);
> > > > +
> > > >    	drm_print_memory_stats(p, &status, supported_status, "memory");
> > > >    }
> > > >    EXPORT_SYMBOL(drm_show_memory_stats);
> > > > diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
> > > > index edbc1ab0fbc8..2b3feb79afc4 100644
> > > > --- a/drivers/gpu/drm/msm/msm_drv.c
> > > > +++ b/drivers/gpu/drm/msm/msm_drv.c
> > > > @@ -880,7 +880,7 @@ static void msm_show_fdinfo(struct drm_printer *p, struct drm_file *file)
> > > >    	msm_gpu_show_fdinfo(priv->gpu, file->driver_priv, p);
> > > > -	drm_show_memory_stats(p, file);
> > > > +	drm_show_memory_stats(p, file, NULL);
> > > >    }
> > > >    static const struct file_operations fops = {
> > > > diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> > > > index 04d615df5259..aaa8602bf00d 100644
> > > > --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> > > > +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> > > > @@ -609,7 +609,7 @@ static void panfrost_show_fdinfo(struct drm_printer *p, struct drm_file *file)
> > > >    	panfrost_gpu_show_fdinfo(pfdev, file->driver_priv, p);
> > > > -	drm_show_memory_stats(p, file);
> > > > +	drm_show_memory_stats(p, file, NULL);
> > > >    }
> > > >    static const struct file_operations panfrost_drm_driver_fops = {
> > > > diff --git a/drivers/gpu/drm/v3d/v3d_drv.c b/drivers/gpu/drm/v3d/v3d_drv.c
> > > > index fb35c5c3f1a7..314e77c67972 100644
> > > > --- a/drivers/gpu/drm/v3d/v3d_drv.c
> > > > +++ b/drivers/gpu/drm/v3d/v3d_drv.c
> > > > @@ -195,7 +195,7 @@ static void v3d_show_fdinfo(struct drm_printer *p, struct drm_file *file)
> > > >    			   v3d_queue_to_string(queue), jobs_completed);
> > > >    	}
> > > > -	drm_show_memory_stats(p, file);
> > > > +	drm_show_memory_stats(p, file, NULL);
> > > >    }
> > > >    static const struct file_operations v3d_drm_fops = {
> > > > diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
> > > > index 8c0030c77308..661d00d5350e 100644
> > > > --- a/include/drm/drm_file.h
> > > > +++ b/include/drm/drm_file.h
> > > > @@ -469,6 +469,7 @@ void drm_send_event_timestamp_locked(struct drm_device *dev,
> > > >     * @resident: Total size of GEM objects backing pages
> > > >     * @purgeable: Total size of GEM objects that can be purged (resident and not active)
> > > >     * @active: Total size of GEM objects active on one or more engines
> > > > + * @internal: Total size of GEM objects that aren't exposed to user space
> > > >     *
> > > >     * Used by drm_print_memory_stats()
> > > >     */
> > > > @@ -478,16 +479,20 @@ struct drm_memory_stats {
> > > >    	u64 resident;
> > > >    	u64 purgeable;
> > > >    	u64 active;
> > > > +	u64 internal;
> > > 
> > > So equally as in the last round of discussion back in June, internal in my
> > > mind still does not fit alongside the categories.
> > > 
> > > Reason is that in some drivers, at least such as i915, "internal" can be:
> > > 
> > > a) Backed by either system memory or device memory - so this does not provice
> > > that visibility;
> > > 
> > > b) They can also be resident or not, active or not, etc - so from that angle
> > > it also does not fit.
> > > 
> > > Do you lose anything if you add the internal objects into their respective
> > > regions and under the existing categories? Like do you have an use case in
> > > mind which needs to be able to distinguish between userspace and internal, or
> > > the problem simply is internal are unaccounted for?
> > 
> > The main use case we have in mind is exposing the size of driver buffer
> > allocations that are triggered in respone to an ioctl(), and so linked to an
> 
> Most of this and below is old and clear - but to this specific point - so you
> do have an use case which specifically wants to know about the internal
> allocations separately from the rest? Could you describe what it is?
> 
> > open file. I gave a summary of what these could be in the patch description, but
> > in Panthor's case all these allocations are done with drm shmem functions
> > because it makes it easier to retrieve the sgtable that gives us their system
> > memory layout so that we can more easily map them onto the MMU's address space
> > for a Pantor VM. These BO's, though managed by the drm shmem API, are never
> > added to the open file list of user-exposed drm objects but we would still like
> > to tell UM how much memory they take up.
> > 
> > In the case of Panthor, they all add into the resident tally because all these
> > internal BO's are immediately pinned so that they can also be accessed by the
> > HW, but it doesn't have to be so for other drivers which might also keep track
> > of similar allocations.
> > 
> > I think maybe naming that tag as 'internal' is a bit of a misnomer and I could
> > pick one that more accurately represents its meaning? Something like 'file-internal'
> > or else 'file-private'.
> > 
> > Regarding a), I don't think where the allocations happen (system or device memory)
> > is relevant in this case, just that the allocations are tied to an open file, but
> > not exposed to UM through a DRM buffer object handle.
> 
> On this last paragraph - right.. I possibly got confused on a). Which is why I
> always say it is good to include example output at least in the cover letter,
> if not the commit message.
> 
> How would it look on this driver?
> 
> drm-total-$what: ..
> drm-resident-$what: ..
> drm-internal-$what: ...

In the case of Panthor, it would look like this:

drm-driver:     panthor
drm-client-id:  3
drm-engine-panthor:     611046570346 ns
drm-cycles-panthor:     1172733302061
drm-maxfreq-panthor:    1000000000 Hz
drm-curfreq-panthor:    1000000000 Hz
drm-total-memory:       16480 KiB
drm-shared-memory:      0
drm-active-memory:      16200 KiB
drm-internal-memory:    10396 KiB
drm-resident-memory:    26876 KiB
drm-purgeable-memory:   0

Then in Panfrost:

drm-driver:     panfrost
drm-client-id:  6
drm-engine-fragment:    481941638 ns
drm-cycles-fragment:    60243117
drm-maxfreq-fragment:   799999987 Hz
drm-curfreq-fragment:   124999998 Hz
drm-engine-vertex-tiler:        55546675 ns
drm-cycles-vertex-tiler:        6943796
drm-maxfreq-vertex-tiler:       799999987 Hz
drm-curfreq-vertex-tiler:       124999998 Hz
drm-total-memory:       138420 KiB
drm-shared-memory:      7200 KiB
drm-active-memory:      0
drm-internal-memory:    0
drm-resident-memory:    2196 KiB
drm-purgeable-memory:   128 KiB


> b) still stands though in that internal can be resident or not, purgeable or
> not.. Which is why I would like to know about the use case.

This is true, DRM file-internal objects or memory allocations could fall
into any of these categories, and adding their sizes to the right one would
be the responsibility of the function pointer passed to drm_show_memory_stats(),
because that decision would have to be made on a per-driver basis.

> Also if you add drm-internal for any driver calling drm_print_memory_stats I
> think you "break" at least i915. There internal objects are already accounted
> in the existing categories. And printing out internal with zero would be very
> misleading.

I wasn't aware of this. So i915 is already doing this kind of accounting for internal
memory allocations. In that case, maybe printing of the 'drm-internal-memory' could
be done conditionally when it's greater than 0 to avoid 'breaking' existing drivers,
or else renaming it to 'drm-file-memory' would be seen as less invasive?

I'm asking this because if, at the end of the day, making this change part of the 
drm fdinfo core is going to clash with existing accounting in other DRM drivers, perhaps
it'd be easier to keep it Panthor-specific and add that tag together with its meaning
to Documentation/gpu/panfrost.rst.

I thought about this at first, but it also struck me as something other drivers might
want to do in the future in a sort of unified way, since internal allocations happening
in response to an ioctl() is a common thing.

Cheers,
Adrian

> Regards,
> 
> Tvrtko
> 
> > 
> > Regards,
> > Adrian
> > 
> > > Regards,
> > > 
> > > Tvrtko
> > > 
> > > >    };
> > > >    enum drm_gem_object_status;
> > > > +typedef void (*internal_bos)(struct drm_memory_stats *status,
> > > > +			     struct drm_file *file);
> > > > +
> > > >    void drm_print_memory_stats(struct drm_printer *p,
> > > >    			    const struct drm_memory_stats *stats,
> > > >    			    enum drm_gem_object_status supported_status,
> > > >    			    const char *region);
> > > > -void drm_show_memory_stats(struct drm_printer *p, struct drm_file *file);
> > > > +void drm_show_memory_stats(struct drm_printer *p, struct drm_file *file, internal_bos func);
> > > >    void drm_show_fdinfo(struct seq_file *m, struct file *f);
> > > >    struct file *mock_drm_getfile(struct drm_minor *minor, unsigned int flags);


