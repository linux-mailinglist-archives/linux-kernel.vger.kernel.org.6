Return-Path: <linux-kernel+bounces-514916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A93A35D4F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 13:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E9E57A242E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 12:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABBB263C69;
	Fri, 14 Feb 2025 12:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kaN/ixHY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509AC2139A8
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 12:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739534996; cv=none; b=pQfkyoY1mHOlfc0DSEs9ASKePggWXaNJmfn6o13M3w6FKfaPfIEMx0pb1TdAMtpjlCwW3mjSYjQDPWne4S+mnF4RDF37noQC7YlTK32mZ6BwEhHDPObEwALntqXjVDtYWA2XlOBdhONjD2ytcgcGXyln/nRjqfYe095F79yTi9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739534996; c=relaxed/simple;
	bh=aMZ0cmH8caWaku0ONbONWBbEbf8eUQ81CViz/ZDY0Ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GyX9UwrFQQ3Saw6lyZ7wRburG42Ax2Z4XFglQ0cQe78+7u5QIko9ojL8m43ct+4CE0i2j48ZJOtFV5koMoCj6Hd/jxDPq272dwphJh8ZhFi7T/+VvP5KADGb5mkxDMkcyUxKfPY+MDWqkQ+QSdk5HNmvgVeee2K+4/Sj1aKG2T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kaN/ixHY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8EEDC4CED1;
	Fri, 14 Feb 2025 12:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739534995;
	bh=aMZ0cmH8caWaku0ONbONWBbEbf8eUQ81CViz/ZDY0Ko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kaN/ixHYZVsyIh53ymK5s3pCRmBqz31qY2izgd8EvdNcoO0lNCyxV5O9t922mcH6A
	 VQhA5lPJuajiEsBcVSZjGdPeT1XDaW5KkF4rD0HyuPzoC9yVM7HuZByJO1bjVg6QAN
	 W7ONolEqPuyonTXbNBJYImXvPPWvsldL2GBI0DTQXU8jYBZ26B/6CpclU+E1X5iOVT
	 KedRs79+TMfk1CB34POekCy6vqNhHGP95dw1cdygpe+f6Dx/cXco7rCXla4DTH3X3X
	 am6o0pElXYsqn9P1awqfvXqHEEAV2qV3Iph7MWGgB/mq+zyEz7mtkWqXkF07ogP11J
	 J+IEgrLHtQL6g==
Date: Fri, 14 Feb 2025 12:09:50 +0000
From: Will Deacon <will@kernel.org>
To: Steven Price <steven.price@arm.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
	David Airlie <airlied@gmail.com>, Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panthor: Clean up FW version information display
Message-ID: <20250214120949.GA12809@willie-the-truck>
References: <20250213161248.1642392-1-steven.price@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213161248.1642392-1-steven.price@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Feb 13, 2025 at 04:12:48PM +0000, Steven Price wrote:
> Assigning a string to an array which is too small to include the NUL
> byte at the end causes a warning on some compilers. But this function
> also has some other oddities like the 'header' array which is only ever
> used within sizeof().
> 
> Tidy up the function by removing the 'header' array, allow the NUL byte
> to be present in git_sha_header, and calculate the length directly from
> git_sha_header.
> 
> Reported-by: Will Deacon <will@kernel.org>
> Fixes: 9d443deb0441 ("drm/panthor: Display FW version information")
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
> Note that there should be no functional change from this patch.
> ---
>  drivers/gpu/drm/panthor/panthor_fw.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
> index 4a9c4afa9ad7..645fc6d2e63b 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.c
> +++ b/drivers/gpu/drm/panthor/panthor_fw.c
> @@ -636,8 +636,8 @@ static int panthor_fw_read_build_info(struct panthor_device *ptdev,
>  				      u32 ehdr)
>  {
>  	struct panthor_fw_build_info_hdr hdr;
> -	char header[9];
> -	const char git_sha_header[sizeof(header)] = "git_sha: ";
> +	const char git_sha_header[] = "git_sha: ";
> +	const int header_len = sizeof(git_sha_header) - 1;

nit: strlen()?

In any case, this fixes the arm64 CI [1], so:

Acked-by: Will Deacon <will@kernel.org>

It would be great to land this as a fix to save us having to carry it
on our CI branch.

Cheers,

Will

[1] https://lore.kernel.org/r/20250213154237.GA11897@willie-the-truck

