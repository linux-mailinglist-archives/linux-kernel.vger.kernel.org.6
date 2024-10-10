Return-Path: <linux-kernel+bounces-358499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6AA998029
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 10:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACE13B25304
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 08:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94681BDAA2;
	Thu, 10 Oct 2024 08:10:16 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0CA1BD03E;
	Thu, 10 Oct 2024 08:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728547816; cv=none; b=uVczmv7lT97/IaqtJXN1uOaOnpwKT09EnnKJvPMbh6cZsA8is/qpgLCmWLg0AFL1/g+rk4d63YJb/smzduPPGJYgRTkzCv2VaaL6KWLV39qGOh2H586DD8Bd7/JpWiPadPGsN4pkS/K8wKoyT2SVZB/0yD+KZcGBSJzD9UFh/Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728547816; c=relaxed/simple;
	bh=lUHpaDpkgjwSIOpS7uOdFQf2dUS+V/U9/3xLgBMHyT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CkF978Lj7+rDFRotiGjjQi8AheANs6yMdMZA1CVJM97sR/9x8uwqTkhIsLZJIdTa8JPhbJwX8oWrfFRb9bDXAgw+QYqc5RT5322vDNVG1WJSWV5BdmiGbItfcLEJ/Utl0pQgOjY+ao4l+kNbxiSi04OgEN/jgqG9azIWlXo9Q2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E75EC497;
	Thu, 10 Oct 2024 01:10:36 -0700 (PDT)
Received: from [10.1.33.28] (e122027.cambridge.arm.com [10.1.33.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 255E73F64C;
	Thu, 10 Oct 2024 01:10:05 -0700 (PDT)
Message-ID: <d086651e-410e-4ac6-8825-d192abeac38f@arm.com>
Date: Thu, 10 Oct 2024 09:10:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation/gpu: Fix Panthor documentation build
 warnings
To: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Jonathan Corbet <corbet@lwn.net>,
 Boris Brezillon <boris.brezillon@collabora.com>
Cc: kernel@collabora.com, Stephen Rothwell <sfr@canb.auug.org.au>,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241009214346.2308917-1-adrian.larumbe@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20241009214346.2308917-1-adrian.larumbe@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 09/10/2024 22:43, Adrián Larumbe wrote:
> Fix Panthor documentation build errors uncovered by the makedocs target
> when building with extra warnings enabled.
> 
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> Fixes: f25044688b04 ("drm/panthor: add sysfs knob for enabling job profiling")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  Documentation/gpu/drivers.rst         | 1 +
>  Documentation/gpu/drm-usage-stats.rst | 1 +
>  Documentation/gpu/panthor.rst         | 2 +-
>  3 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/gpu/drivers.rst b/Documentation/gpu/drivers.rst
> index b899cbc5c2b4..7b1282e2d807 100644
> --- a/Documentation/gpu/drivers.rst
> +++ b/Documentation/gpu/drivers.rst
> @@ -22,6 +22,7 @@ GPU Driver Documentation
>     afbc
>     komeda-kms
>     panfrost
> +   panthor
>  
>  .. only::  subproject and html
>  
> diff --git a/Documentation/gpu/drm-usage-stats.rst b/Documentation/gpu/drm-usage-stats.rst
> index a80f95ca1b2f..12ca3193bf15 100644
> --- a/Documentation/gpu/drm-usage-stats.rst
> +++ b/Documentation/gpu/drm-usage-stats.rst
> @@ -186,4 +186,5 @@ Driver specific implementations
>  
>  * :ref:`i915-usage-stats`
>  * :ref:`panfrost-usage-stats`
> +* :ref:`panthor-usage-stats`
>  * :ref:`xe-usage-stats`
> diff --git a/Documentation/gpu/panthor.rst b/Documentation/gpu/panthor.rst
> index cbf5c4429a2d..3f8979fa2b86 100644
> --- a/Documentation/gpu/panthor.rst
> +++ b/Documentation/gpu/panthor.rst
> @@ -4,7 +4,7 @@
>   drm/Panthor CSF driver
>  =========================
>  
> -.. _panfrost-usage-stats:
> +.. _panthor-usage-stats:
>  
>  Panthor DRM client usage stats implementation
>  ==============================================


