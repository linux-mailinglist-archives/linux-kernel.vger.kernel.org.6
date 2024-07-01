Return-Path: <linux-kernel+bounces-236500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 592E591E30A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ADF51C21666
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040BC16CD29;
	Mon,  1 Jul 2024 14:58:20 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCB916CD01
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 14:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719845899; cv=none; b=m6IW7Usi4kNuIxpUjZBTZ6RwYgzhOujKNO2XvHWcDiCVKTmtFBuB/eAFveoYYV7o0AEK7Qu3ZQmwIDMDRNUnuvqGyc4BWDpecCCSoE5kj6hX9NbPkGmtthx52BmOm2ZZ8rSqTeSfd1uzyZufM9GAsvOQHNJumf8G1unKL6ZW4f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719845899; c=relaxed/simple;
	bh=h2gUqhqwUZP4/709Y6B7avIyTDjySe+jW23TwpADrT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WXBdoq3uYIyXP7qLGrcLBAGjggp5VOfNf+DqSCX3SonSvD8cK4K8GQ7hoOC3b/J1GBTTZ5ijP3/7/VKb9DIRYh/uXO3cHakzFl/0v0AOyhANtntrVygFVwV7TqvQcozS1VsUb4t7kWGzmxQI25Tc+Lzk8J7htYlWzhq72uPSGtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9AAF5339;
	Mon,  1 Jul 2024 07:58:41 -0700 (PDT)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 048A53F762;
	Mon,  1 Jul 2024 07:58:15 -0700 (PDT)
Message-ID: <ebba1959-53b3-4001-bf7d-30704cd3866d@arm.com>
Date: Mon, 1 Jul 2024 15:58:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] vdso/gettimeofday: Clarify comment about open coded
 function
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
References: <20240701-vdso-cleanup-v1-0-36eb64e7ece2@linutronix.de>
 <20240701-vdso-cleanup-v1-1-36eb64e7ece2@linutronix.de>
Content-Language: en-US
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
In-Reply-To: <20240701-vdso-cleanup-v1-1-36eb64e7ece2@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 01/07/2024 15:47, Anna-Maria Behnsen wrote:
> The two comments state, that the following code open codes something but
> they lack to specify what exactly is open coded.
> 
> Expand comments by mentioning the reference to the open coded function.
> 
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

> ---
>  lib/vdso/gettimeofday.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
> index 899850bd6f0b..c01eaafd8041 100644
> --- a/lib/vdso/gettimeofday.c
> +++ b/lib/vdso/gettimeofday.c
> @@ -140,14 +140,14 @@ static __always_inline int do_hres(const struct vdso_data *vd, clockid_t clk,
>  
>  	do {
>  		/*
> -		 * Open coded to handle VDSO_CLOCKMODE_TIMENS. Time namespace
> -		 * enabled tasks have a special VVAR page installed which
> -		 * has vd->seq set to 1 and vd->clock_mode set to
> -		 * VDSO_CLOCKMODE_TIMENS. For non time namespace affected tasks
> -		 * this does not affect performance because if vd->seq is
> -		 * odd, i.e. a concurrent update is in progress the extra
> -		 * check for vd->clock_mode is just a few extra
> -		 * instructions while spin waiting for vd->seq to become
> +		 * Open coded function vdso_read_begin() to handle
> +		 * VDSO_CLOCKMODE_TIMENS. Time namespace enabled tasks have a
> +		 * special VVAR page installed which has vd->seq set to 1 and
> +		 * vd->clock_mode set to VDSO_CLOCKMODE_TIMENS. For non time
> +		 * namespace affected tasks this does not affect performance
> +		 * because if vd->seq is odd, i.e. a concurrent update is in
> +		 * progress the extra check for vd->clock_mode is just a few
> +		 * extra instructions while spin waiting for vd->seq to become
>  		 * even again.
>  		 */
>  		while (unlikely((seq = READ_ONCE(vd->seq)) & 1)) {
> @@ -223,8 +223,8 @@ static __always_inline int do_coarse(const struct vdso_data *vd, clockid_t clk,
>  
>  	do {
>  		/*
> -		 * Open coded to handle VDSO_CLOCK_TIMENS. See comment in
> -		 * do_hres().
> +		 * Open coded function vdso_read_begin() to handle
> +		 * VDSO_CLOCK_TIMENS. See comment in do_hres().
>  		 */
>  		while ((seq = READ_ONCE(vd->seq)) & 1) {
>  			if (IS_ENABLED(CONFIG_TIME_NS) &&
> 

-- 
Regards,
Vincenzo

