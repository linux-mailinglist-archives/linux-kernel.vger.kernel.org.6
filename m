Return-Path: <linux-kernel+bounces-532594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB248A44FA4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 23:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E78D017C26D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 22:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737F4212FAC;
	Tue, 25 Feb 2025 22:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b="HmIbJR+T"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C831820E6FC
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 22:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740521940; cv=none; b=NyCm9aZl4HyKvToX/RrbVcRiNF0a5HI8afxfMcC0IGX64PMVUVpjIv06yGEPe4qZ/gyG6zwuy0z0G3FahPpUyS8+X/3IyUctyJ6mO3zN3RVcTe2JMVBXg/WsKwGJRO+K6mJbo9j5MHXDG3T/gdDQIBzqfELGJcgBy8k8vViiaJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740521940; c=relaxed/simple;
	bh=7WXjPFXolBqyPlRHbl2aOzCryeCE6lRBTS1Z5mOA1e8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R30F6Vzv9BRYAd1rDEkBaA5VKn5xH+rcBuMrPLlRzl687S6WgpJj5PyGsigcS0VVgtMTOsxR3/C4Y11duMfgEGvQC27Jn7PB6m4iU7FeOxQKLfU3+GBd2zwYzzRRM0rlrjOVZKwovqsmUScXi29PWpnQI20qiurmDEA/eFLhz+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io; spf=pass smtp.mailfrom=rosenzweig.io; dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b=HmIbJR+T; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosenzweig.io
Date: Tue, 25 Feb 2025 17:18:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosenzweig.io;
	s=key1; t=1740521927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RzgOyhdKuLwcBRSLmcJJ0Jbuz6w06hvV2SnnIVn+zvE=;
	b=HmIbJR+TaH7Wme6F4IPgbYtpzGHncrdCmBgNbeauOOAC7dPDo9n+83JhZyKZNWClyuOlQl
	4Yd6Y5swrftBaTXfLZ9TqMEMumfngYObl51LG3XLlMGkk3nLBjg2wARO3s+7inOWpMfdz+
	9BEjD65HMh9hRlIOn9GZhbw78eZ2p04pZFjupo1J238pOamFvvMrciBkX1/2num0Ki1TYh
	fOcGw6WA01Qm5YZeXvQgPxYJZHCLkyzLYbzl0KwKZ9FdgdsdEC6m+YOm/ePvW01IzWFKsd
	WEy23MZtEcougGgl1L1VyWuZovF6cjpx821nBtTsG/9yhVdMcht6FOW402plDg==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
To: Daniel Stone <daniel@fooishbar.org>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	asahi@lists.linux.dev
Subject: Re: [PATCH v2] drm: add modifiers for Apple GPU layouts
Message-ID: <Z75BwWllrew-DIlS@blossom>
References: <20250225-apple-twiddled-modifiers-v2-1-cf69729e87f6@rosenzweig.io>
 <CAPj87rO3N2=3mNQg8-CUF=-XTysJHLmgArRKuvDpdk3YZ2xMvQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPj87rO3N2=3mNQg8-CUF=-XTysJHLmgArRKuvDpdk3YZ2xMvQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

> > These layouts are notably not used for interchange across hardware
> > blocks (e.g. with the display controller). There are other layouts for
> > that but we don't support them either in userspace or kernelspace yet
> > (even downstream), so we don't add modifiers here.
> 
> Yeah, when those have users with good definitions matching these, we
> can add them here, even if they are downstream. Anything the GPU would
> share out of context, or the codec, would be good for this.

Sure. The mentioned "other layouts" are for scanout (GPU->display), and
apparently the GPU can render but not sample them... You can imagine
about how well that would go without a vendor extension + compositor
patches......

(Currently we use linear framebuffers for scanout and avoid that rat's
nest.)

> 
> > +/*
> > + * Apple GPU-tiled layout.
> > + *
> > + * GPU-tiled images are divided into tiles. Tiles are always 16KiB, with
> > + * dimensions depending on the base-format. Within a tile, pixels are fully
> > + * interleaved (Morton order). Tiles themselves are raster-order.
> > + *
> > + * Images must be 16-byte aligned.
> > + *
> > + * For more information see
> > + * https://docs.mesa3d.org/drivers/asahi.html#image-layouts
> 
> This writeup is really nice. I would prefer it was inlined here though
> (similar to AFBC), with Mesa then referring to the kernel, but tbf
> Vivante does have a similar external reference.

Thanks :-) I wasn't sure which way would be better. Most of the
complexity in that writeup relates to mipmapping and arrayed images,
which I don't think WSI hits...? Also, the Mesa docs are easier for me
to update, support tables and LaTeX, have other bits of hw writeups on
the same page, etc... so they feel like a better home for the unabridged
version.  And since Vivante did this, I figured it was ok.

If people feel strongly I can of course inline it, it's just not clear
to me that dumping all that info into the header here is actually
desired. (And there's even more info Marge queued ...
https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/33743/diffs?commit_id=5ddb57ceb46d42096a34cbef1df6b4109ac2b511
)

> The one thing it's missing is an explicit description of how stride is
> computed and used. I can see the 'obvious' way to do it for this and
> compression, but it would be good to make it explicit, given some
> misadventures in the past. CCS is probably the gold standard to refer
> to here.

Ah, right -- thanks for raising that! I'll add this for v3. Indeed, I
picked the "obvious" way, given said misadventures with AFBC ;)

This is the relevant Mesa code:

   /*
    * For WSI purposes, we need to associate a stride with all layouts.
    * In the hardware, only strided linear images have an associated
    * stride, there is no natural stride associated with twiddled
    * images.  However, various clients assert that the stride is valid
    * for the image if it were linear (even if it is in fact not
    * linear). In those cases, by convention we use the minimum valid
    * such stride.
    */
   static inline uint32_t
   ail_get_wsi_stride_B(const struct ail_layout *layout, unsigned level)
   {
      assert(level == 0 && "Mipmaps cannot be shared as WSI");
   
      if (layout->tiling == AIL_TILING_LINEAR)
         return ail_get_linear_stride_B(layout, level);
      else
         return util_format_get_stride(layout->format, layout->width_px);
   }

I can either copy that comment here, or to make that logic more explicit:

    Producers must set the stride to the image width in
    pixels times the bytes per pixel. This is a software convention, the
    hardware does not use this stride.

Thanks,

Alyssa

