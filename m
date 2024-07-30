Return-Path: <linux-kernel+bounces-266868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F149408E1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 08:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB5C91C22D37
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 06:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7922168493;
	Tue, 30 Jul 2024 06:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wgMPcmK8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AE72114;
	Tue, 30 Jul 2024 06:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722322380; cv=none; b=u5Pz+CpzT/KuxKBouGCX/J53Y3YmccYir1KWZgqmUqdK4W97AA1l8Z3reLhbm7YnQbZHaBFak41sW3z4cVLoVxPvFJpDTLvVxnyKnXh603ErkIC6f0AU854LI64W2/5p43n2DDKH0JggoV0AxXGnxTT2PL/dyY6w0PDr4xEfdB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722322380; c=relaxed/simple;
	bh=ONfCUPB7YXaG40OJ/LV1N6ajgsNPBvJARboG7r2mj1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DoU5bfFmkIdGPhzS3r3LiIOCXgX20l5xh2gkklPFl9ksXWXHuaKOjswLYa/2jhGf89Ap6E+yP4lhumvaFOJpI0D6o4ZiJPfQNrntwwA37YMHFVje3+szaY7jUOVMvlXFIKs2vPbulPjl8aLECb4apbvkHk2W9ev/6CHZOqImD2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wgMPcmK8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A2BFC32782;
	Tue, 30 Jul 2024 06:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722322379;
	bh=ONfCUPB7YXaG40OJ/LV1N6ajgsNPBvJARboG7r2mj1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wgMPcmK8o95lYgjGv7X97eyBvpMgV1b+DD7TwctT3x0p7PYfT8EiRi371/+U5MEHU
	 Qs1tI1ROOV5O/Nnx0YScaDsz3mPK5ovlhZZnxLISbsVBvbMmhsY0PXhnHtzyF2iCJT
	 vGhv0uihxUyd72Exr1kLkWA9P9S+QQXp3OiZWUgU=
Date: Tue, 30 Jul 2024 08:52:56 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Benjamin Somers <benjamin.somers@resel.fr>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	~lkcamp/patches@lists.sr.ht, helen.koike@collabora.com
Subject: Re: [PATCH] staging: rtl8723bs: Fix spacing issues
Message-ID: <2024073011-gory-knapsack-7235@gregkh>
References: <20240730064745.2473-1-benjamin.somers@resel.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730064745.2473-1-benjamin.somers@resel.fr>

On Tue, Jul 30, 2024 at 06:47:45AM +0000, Benjamin Somers wrote:
> This patch fixes spacing issues reported by checkpatch on lines 39-40
> 
> Signed-off-by: Benjamin Somers <benjamin.somers@resel.fr>
> 
> ---
> This is my first patch to the kernel
> ---
> ---
>  drivers/staging/rtl8723bs/include/osdep_service_linux.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/include/osdep_service_linux.h b/drivers/staging/rtl8723bs/include/osdep_service_linux.h
> index 188ed7e26..e470abfc2 100644
> --- a/drivers/staging/rtl8723bs/include/osdep_service_linux.h
> +++ b/drivers/staging/rtl8723bs/include/osdep_service_linux.h
> @@ -36,8 +36,8 @@
>  	#include <linux/list.h>
>  	#include <linux/vmalloc.h>
>  
> -/* 	#include <linux/ieee80211.h> */
> -        #include <net/ieee80211_radiotap.h>
> +	/* #include <linux/ieee80211.h> */
> +	#include <net/ieee80211_radiotap.h>

Why not just remove the commented out line entirely?

And this is indented way too much, something went wrong :(

thanks,

greg k-h

