Return-Path: <linux-kernel+bounces-304593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A55962247
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 10:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1F35B2215D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 08:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C96415B54E;
	Wed, 28 Aug 2024 08:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=mary.guillemard@collabora.com header.b="PC22ZiWO"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B860B67A
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 08:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724833507; cv=pass; b=KYzHRO0AHXrVxF0+eha4gOlRSHkKgBEdVt89fJtaXkbb5+U3COidxeuztdaw6NAOdQbtPThAPLe++zRbyMLXmpJSjN0l1+f2Xmltz5FriF3tdd2Yhp7tg5p11sF12M8B085JiZjfuQeM+AvLtqj+O/aBUj4M38DgwZUIRet90+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724833507; c=relaxed/simple;
	bh=IAoZOjfRXyxGfZKFXhEde4/nVAO23yKEa9nNhsHKZb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bQj4yoA87y8qBjcAK32WCjNXJ1t0Btcvj+XLn1/8sgeDA7vugM9KO0rtrNrNzJ/Lwm6ZM0VhciH+SsCf2XDWd2+6wO06Mgl2kCnpPgCOzFSkfouss2i+HXFzCwdreig4EFInlS00CnzOP3UK88SmLsrQcx0mBdjG2VVTWGx8rwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=mary.guillemard@collabora.com header.b=PC22ZiWO; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: kernel@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1724833488; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=C5TgH6Po65HEXc6einX4yEVx062T4x2kOD2wuZzWncGhyIo2feil2zRmkZ1kvSY3rKGqktC3estaoFHQyoyrkay+P0ze6hUvYNVjYaa7WE2aCMivIiMERqM1Xtl+/zgVM7L3rw+God5qLwkV94nBIUXeoxmh8aSnbB0kalE2WWE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1724833488; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=T2HtZOq/Dm024xV1xLGCEztRUtVIMeJSGLIxvADeSC0=; 
	b=mrdasLoch9ZzSpsTZCjo9KIEjjxK19PDmGbV3yPhK+pdJC9x9eUHQOWPwRE/VTYDFyjJSEqvQt6QranIjVbX1vccsV12GSapbxe6chEnyyymA2VNMAXu8je5cbtnrg0JqTsjshLUYU3k0HdBkPVqldYY8JVdcCCI7f0XkvfjcR4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=mary.guillemard@collabora.com;
	dmarc=pass header.from=<mary.guillemard@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724833488;
	s=zohomail; d=collabora.com; i=mary.guillemard@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=T2HtZOq/Dm024xV1xLGCEztRUtVIMeJSGLIxvADeSC0=;
	b=PC22ZiWOXh1MRC9tycKIT5D3R1m5ij291pO6gPpCEkFdU2x5PfiOli1SIRGeiFsq
	ENi83FuSZ953ELrgP4iDlNUXWij+xwo5oUwoqYxbaY69jtspHJDe3XCSsLHuwQFM3j4
	qocwMSO7QDGJcxnIybDkC77J16d5PADDcZibi4eE=
Received: by mx.zohomail.com with SMTPS id 1724833486164592.3014591788459;
	Wed, 28 Aug 2024 01:24:46 -0700 (PDT)
Date: Wed, 28 Aug 2024 10:24:40 +0200
From: Mary Guillemard <mary.guillemard@collabora.com>
To: Mihail Atanassov <mihail.atanassov@arm.com>
Cc: linux-kernel@vger.kernel.org, kernel@collabora.com,
	Christopher Healy <healych@amazon.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org, nd@arm.com
Subject: Re: [PATCH v3] drm/panthor: Add DEV_QUERY_TIMESTAMP_INFO dev query
Message-ID: <Zs7d2-NHTy-A_oLL@kuroko.kudu-justice.ts.net>
References: <20240819112508.67988-2-mary.guillemard@collabora.com>
 <4538ba23-ee8b-4e15-8857-d653d581bc18@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4538ba23-ee8b-4e15-8857-d653d581bc18@arm.com>
X-ZohoMailClient: External

Hi Mihail,

On Mon, Aug 19, 2024 at 03:25:48PM +0100, Mihail Atanassov wrote:
> > diff --git a/include/uapi/drm/panthor_drm.h b/include/uapi/drm/panthor_drm.h
> > index 926b1deb1116..944f5618aa05 100644
> > --- a/include/uapi/drm/panthor_drm.h
> > +++ b/include/uapi/drm/panthor_drm.h
> > @@ -260,6 +260,9 @@ enum drm_panthor_dev_query_type {
> >   	/** @DRM_PANTHOR_DEV_QUERY_CSIF_INFO: Query command-stream interface information. */
> >   	DRM_PANTHOR_DEV_QUERY_CSIF_INFO,
> > +
> > +	/** @DRM_PANTHOR_DEV_QUERY_TIMESTAMP_INFO: Query timestamp information. */
> > +	DRM_PANTHOR_DEV_QUERY_TIMESTAMP_INFO,
> >   };
> >   /**
> > @@ -377,6 +380,22 @@ struct drm_panthor_csif_info {
> >   	__u32 pad;
> >   };
> > +/**
> > + * struct drm_panthor_timestamp_info - Timestamp information
> > + *
> > + * Structure grouping all queryable information relating to the GPU timestamp.
> > + */
> > +struct drm_panthor_timestamp_info {
> > +	/** @timestamp_frequency: The frequency of the timestamp timer. */
> > +	__u64 timestamp_frequency;
> > +
> > +	/** @current_timestamp: The current timestamp. */
> > +	__u64 current_timestamp;
> > +
> > +	/** @timestamp_offset: The offset of the timestamp timer. */
> > +	__u64 timestamp_offset;
> 
> Are you sure you don't want the cntvct_el0 and cntfrq_el0 values here, too,
> as separate fields? While they're not values coming from the GPU, they are
> related. Getting the lowest delta possible between querying one timestamp
> register and the other is quite useful for tooling. Requiring userspace to
> do two separate queries, one for CPU time and one for GPU time, doesn't feel
> optimal, your max deviation will necessarily be higher that way.
>

Exposing arch dependent values in the uapi feels wrong to me too but
maybe that could be done with just the cpu timestamp with a frequency of
1 on other platform if needed?

In any cases, I think that if we ever need it we can extend this query
with more values. (as we are retrocompatible thanks to PANTHOR_UOBJ_SET)

--
Mary

 

