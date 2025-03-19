Return-Path: <linux-kernel+bounces-568106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DE8A68E36
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 14:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32AA617AEB1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 13:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E6A14B092;
	Wed, 19 Mar 2025 13:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="VhcglxxP"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA111487F6
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 13:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742392179; cv=pass; b=E7pHakCEISfzBtUwyAcWmDICLnWAsMYxiXsQs9fTY+MxcGjWhJv0IYFKoCVcPuH0ksXtjXu1uYCEgqma9DO5zOMJg7PsxyVjEDHjjqf+Pp6dJk1CS2G0cpOGpt5ng811XcTQlgcgCNrSWWES35psgTLSovCqojvghYJlc5ykONw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742392179; c=relaxed/simple;
	bh=2tIWz1C2twnM+EvhW+ABaubTQlgqTLcyClyOylY3MWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uhzH2oWS9u89MSj9Q1fSWd91GM9lp268YOnpk7iVAXJNhUvvFkUwKq6l2dL0o0sGMs6mFFSzClQuZCUJb0H9ATAs1O29DRBBAcCGawP7lE0vqQ3W+580MU2FKZqw/Qwj+tz/vXmlYXx7akVFP7iWc8tFhGtEVzEutqpWuHTUnQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=VhcglxxP; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1742392154; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ey1QH0n7FfMM64EVoEo7bX0WdaYs4I6n4OqpjOQ2//3Z5UjAvV92vmClkX2ag/JRnjoHe9qzjXV/vtF9lJmmfHfH5BPkbjDxxEmW18mmn+Rhvpc8oqcpp4KWOXVBIy8V1BuYdr+Lrc9PrabPU8ROFgWNhnut6gbFy4Z2W+tOPvk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1742392154; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=n3IDWvnhYhcxXWYENV2UH3cwkFZ/jgBYJo9QfzCsIvs=; 
	b=PGkctcyCvkwySutN3G9WCtHTFAUCbg722lauRzWeeI8un6G0sSxxgKfh1v/StNz1xEa6wOABTauFDP15GBHF9tahU2b0B41KmOyJssCPzMWtDu7D+gRDFw+kjmaSqXXCmgUeSB6kvWVLif6bDzD4aqmxpXXS0UIbsum2jRzTElo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1742392154;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
	bh=n3IDWvnhYhcxXWYENV2UH3cwkFZ/jgBYJo9QfzCsIvs=;
	b=VhcglxxPcgm+y11gsuujZ52j+4ZDN6taSF74AuEy+J/yXds1yn0JcslPwbyRD5u8
	bGaGpc7Lq+MowxjJsArZFhDuRhX9IWR7lD57KqApc8FXluRHZtenBdjQ7DXOfGRssa+
	j0hV+3ywT6ZBVASbgBufgtrvkDBCy22AQPvfoDtM=
Received: by mx.zohomail.com with SMTPS id 174239215178733.56992181549083;
	Wed, 19 Mar 2025 06:49:11 -0700 (PDT)
Date: Wed, 19 Mar 2025 13:49:02 +0000
From: =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, kernel@collabora.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] drm/panthor: Add driver IOCTL for setting BO labels
Message-ID: <afw6maib3dvwlkb7llizczajbxi2gj5snecasycdlacvot3r2e@qlj7wvj7q6iz>
References: <20250316215139.3940623-1-adrian.larumbe@collabora.com>
 <20250316215139.3940623-3-adrian.larumbe@collabora.com>
 <20250317085002.304305cf@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250317085002.304305cf@collabora.com>

Hi Boris,

On 17.03.2025 08:50, Boris Brezillon wrote:
> On Sun, 16 Mar 2025 21:51:33 +0000
> Adrián Larumbe <adrian.larumbe@collabora.com> wrote:
>
> > Allow UM to label a BO for which it possesses a DRM handle.
> >
> > Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> > ---
> >  drivers/gpu/drm/panthor/panthor_drv.c | 31 +++++++++++++++++++++++++++
> >  include/uapi/drm/panthor_drm.h        | 14 ++++++++++++
> >  2 files changed, 45 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
> > index 310bb44abe1a..f41b8946258f 100644
> > --- a/drivers/gpu/drm/panthor/panthor_drv.c
> > +++ b/drivers/gpu/drm/panthor/panthor_drv.c
> > @@ -1330,6 +1330,35 @@ static int panthor_ioctl_vm_get_state(struct drm_device *ddev, void *data,
> >  	return 0;
> >  }
> >
> > +static int panthor_ioctl_label_bo(struct drm_device *ddev, void *data,
> > +				  struct drm_file *file)
> > +{
> > +	struct drm_panthor_label_bo *args = data;
> > +	struct drm_gem_object *obj;
> > +	const char *label;
> > +	int ret = 0;
> > +
> > +	obj = drm_gem_object_lookup(file, args->handle);
> > +	if (!obj)
> > +		return -ENOENT;
> > +
> > +	if (args->len && args->label) {
> > +		label = strndup_user(u64_to_user_ptr(args->label), args->len + 1);
> > +		if (IS_ERR(label)) {
> > +			ret = PTR_ERR(label);
> > +			goto err_label;
> > +		}
> > +	} else
> > +		label = NULL;
> > +
> > +	panthor_gem_label_bo(obj, label);
> > +
> > +err_label:
> > +	drm_gem_object_put(obj);
> > +
> > +	return ret;
> > +}
> > +
> >  static int
> >  panthor_open(struct drm_device *ddev, struct drm_file *file)
> >  {
> > @@ -1399,6 +1428,7 @@ static const struct drm_ioctl_desc panthor_drm_driver_ioctls[] = {
> >  	PANTHOR_IOCTL(TILER_HEAP_CREATE, tiler_heap_create, DRM_RENDER_ALLOW),
> >  	PANTHOR_IOCTL(TILER_HEAP_DESTROY, tiler_heap_destroy, DRM_RENDER_ALLOW),
> >  	PANTHOR_IOCTL(GROUP_SUBMIT, group_submit, DRM_RENDER_ALLOW),
> > +	PANTHOR_IOCTL(LABEL_BO, label_bo, DRM_RENDER_ALLOW),
> >  };
> >
> >  static int panthor_mmap(struct file *filp, struct vm_area_struct *vma)
> > @@ -1508,6 +1538,7 @@ static void panthor_debugfs_init(struct drm_minor *minor)
> >   * - 1.2 - adds DEV_QUERY_GROUP_PRIORITIES_INFO query
> >   *       - adds PANTHOR_GROUP_PRIORITY_REALTIME priority
> >   * - 1.3 - adds DRM_PANTHOR_GROUP_STATE_INNOCENT flag
> > + * - 1.4 - adds DRM_IOCTL_PANTHOR_LABEL_BO ioctl
> >   */
> >  static const struct drm_driver panthor_drm_driver = {
> >  	.driver_features = DRIVER_RENDER | DRIVER_GEM | DRIVER_SYNCOBJ |
> > diff --git a/include/uapi/drm/panthor_drm.h b/include/uapi/drm/panthor_drm.h
> > index 97e2c4510e69..1a7ed567d36a 100644
> > --- a/include/uapi/drm/panthor_drm.h
> > +++ b/include/uapi/drm/panthor_drm.h
> > @@ -127,6 +127,9 @@ enum drm_panthor_ioctl_id {
> >
> >  	/** @DRM_PANTHOR_TILER_HEAP_DESTROY: Destroy a tiler heap. */
> >  	DRM_PANTHOR_TILER_HEAP_DESTROY,
> > +
> > +	/** @DRM_PANTHOR_LABEL_BO: Label a BO. */
> > +	DRM_PANTHOR_LABEL_BO,
>
> DRM_PANTHOR_BO_SET_LABEL to follow the DRM_PANTHOR_<object>_<action>
> naming scheme used in this file.
>
> I'd also be tempted to introduce a DRM_PANTHOR_BO_GET_LABEL ioctl while
> we're at it.

I thought of this too, but I was a bit reluctant because at present there are no UM
driver users who need this functionality.

> >  };
> >
> >  /**
> > @@ -977,6 +980,15 @@ struct drm_panthor_tiler_heap_destroy {
> >  	__u32 pad;
> >  };
> >
> > +/**
> > + * struct drm_panthor_label_bo - Arguments passed to DRM_IOCTL_PANTHOR_LABEL_BO
> > + */
> > +struct drm_panthor_label_bo {
> > +	__u32 handle;
> > +	__u32 len;
> > +	__u64 label;
>
> Can you document these fields?
>
> > +};
> > +
> >  /**
> >   * DRM_IOCTL_PANTHOR() - Build a Panthor IOCTL number
> >   * @__access: Access type. Must be R, W or RW.
> > @@ -1019,6 +1031,8 @@ enum {
> >  		DRM_IOCTL_PANTHOR(WR, TILER_HEAP_CREATE, tiler_heap_create),
> >  	DRM_IOCTL_PANTHOR_TILER_HEAP_DESTROY =
> >  		DRM_IOCTL_PANTHOR(WR, TILER_HEAP_DESTROY, tiler_heap_destroy),
> > +	DRM_IOCTL_PANTHOR_LABEL_BO =
> > +		DRM_IOCTL_PANTHOR(WR, LABEL_BO, label_bo),
> >  };
> >
> >  #if defined(__cplusplus)


Adrian Larumbe

