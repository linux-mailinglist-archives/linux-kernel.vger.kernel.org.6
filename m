Return-Path: <linux-kernel+bounces-447481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED919F331E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 15:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79B067A1805
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 14:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC43B204F9F;
	Mon, 16 Dec 2024 14:25:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164922040BC
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 14:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734359130; cv=none; b=cgcp7QSxHtVU4znx0LDYK552uA0G5H7Yt8Iq8SSmtj+NqpxlCAwptb/v7sPQVg9zHIZFb7YPfJs7AADzYwVzlcIVUMyL9zRv+fSyEyGnLxe6fmJeg0yL3jObJs06x3YtsnjRZPH0glH8QMe2exGjG6JDja9YyMQpjP/SsciGvfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734359130; c=relaxed/simple;
	bh=uS2zaiSZi+kybQ1ejVCiTxzd0SztY/GFXjXTHyAUGy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XMYndzxfm3f8LeTCVVOmodKkZue7fCcGTPn5Wc2/wmtPEYGoWuM54g1CObBVnpWOarKsOdKPiw4Cx2RgneT9tBF2x2WokTOLDceN9vXrGQ0uE1tfpTV2Q5zu/+DJFV6FOKkrFzaV9SZRXCRe/EYBn4kUwUjgO+B6FydHKg6tE9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B14D113E
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 06:25:49 -0800 (PST)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1F31A3F58B
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 06:25:21 -0800 (PST)
Date: Mon, 16 Dec 2024 14:25:10 +0000
From: Liviu Dudau <liviu.dudau@arm.com>
To: =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	kernel@collabora.com, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] Documentation/gpu: Add fdinfo meanings of
 drm-*-internal memory tags
Message-ID: <Z2A4RjVe8gPWpRua@e110455-lin.cambridge.arm.com>
References: <20241211163436.381069-1-adrian.larumbe@collabora.com>
 <20241211163436.381069-3-adrian.larumbe@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241211163436.381069-3-adrian.larumbe@collabora.com>

On Wed, Dec 11, 2024 at 04:34:32PM +0000, Adrián Larumbe wrote:
> A previous commit enabled display of driver-internal kernel BO sizes
> through the device file's fdinfo interface.
> 
> Expand the description of the relevant driver-specific key:value pairs
> with the definitions of the new drm-*-internal ones.
> 
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> ---
>  Documentation/gpu/panthor.rst | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/Documentation/gpu/panthor.rst b/Documentation/gpu/panthor.rst
> index 3f8979fa2b86..c6d8236e3665 100644
> --- a/Documentation/gpu/panthor.rst
> +++ b/Documentation/gpu/panthor.rst
> @@ -26,6 +26,10 @@ the currently possible format options:
>       drm-cycles-panthor:     94439687187
>       drm-maxfreq-panthor:    1000000000 Hz
>       drm-curfreq-panthor:    1000000000 Hz
> +     drm-total-internal:     10396 KiB
> +     drm-shared-internal:    0
> +     drm-active-internal:    10396 KiB
> +     drm-resident-internal:  10396 KiB
>       drm-total-memory:       16480 KiB
>       drm-shared-memory:      0
>       drm-active-memory:      16200 KiB
> @@ -44,3 +48,13 @@ driver by writing into the appropriate sysfs node::
>  
>  Where `N` is a bit mask where cycle and timestamp sampling are respectively
>  enabled by the first and second bits.
> +
> +Possible `drm-*-internal` key names are: `total`, `active` and `resident`.

I think Mihail's comment stands. There is no harm in being thorough, so either
we list `shared` as a possible key name, or we remove it from the example and
re-introduce it later with a patch.

> +These values convey the sizes of the internal driver-owned shmem BO's that
> +aren't exposed to user-space through a DRM handle, like queue ring buffers,
> +sync object arrays and heap chunks. Because they are all allocated and pinned
> +at creation time, `drm-resident-internal` and `drm-total-internal` should always
> +be equal. `drm-active-internal` shows the size of kernel BO's associated with
> +VM's and groups currently being scheduled for execution by the GPU.
> +`drm-shared-memory` is unused at present, but in the future it might stand for
> +the size of the Firmware regions, since they do not belong to an open file context.

But there are firmware regions that are per context, like the save/restore buffers.
Also, I think we are creating confusion there between drm-shared-memory and
drm-shared-internal. I'm fine with having a note here regarding `drm-shared-memory`
as long as `drm-shared-internal` also gets a note to explain the difference with its
cousin.

Best regards,
Liviu

> -- 
> 2.47.0
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯

