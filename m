Return-Path: <linux-kernel+bounces-236529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D7691E375
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 17:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1B7D283676
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 15:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D471516C86A;
	Mon,  1 Jul 2024 15:10:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1D984DE9
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 15:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719846644; cv=none; b=X/DsyQ4yqLnWLYgJy4L9jmAbF4rhDqpGs5d3qkSIIdyz0Lu1j5muJDBJX1Mc5EBl+ToOdREm+CxO+ZinLVOOat0wgwny0q65b2chkuwCoK78qUfKBQ6hv5lp2YQ/HiVfCpp0MhXVv+IClWp3imMUPvgHb90gp3mKovYDqWHwa/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719846644; c=relaxed/simple;
	bh=vE1tS7OZXaz8mGwKFfp3YHGtGZp9ox93J38nNnounrY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NdYqmxr94Ke4VBj0NJm7uICp25SNvVntiPKBj8SF57jYFNf7Hqn9WW35KCbH22YQIAqx2IoVCE2d1hYu2GcQZcAsLic06kGhv0uD2GULQn9v6ZyacBPaWdEZ09J0IcfN5LEOWOdzXu3Kb6pGXjLA3xU1iXeKyBUXw1W/9Y6AcVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A5B78339;
	Mon,  1 Jul 2024 08:11:06 -0700 (PDT)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 103B53F762;
	Mon,  1 Jul 2024 08:10:40 -0700 (PDT)
Message-ID: <ca4f5359-0999-440b-be5d-becfe7f500c8@arm.com>
Date: Mon, 1 Jul 2024 16:10:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] vdso: Add comment about reason for vdso struct
 ordering
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
References: <20240701-vdso-cleanup-v1-0-36eb64e7ece2@linutronix.de>
 <20240701-vdso-cleanup-v1-2-36eb64e7ece2@linutronix.de>
Content-Language: en-US
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
In-Reply-To: <20240701-vdso-cleanup-v1-2-36eb64e7ece2@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 01/07/2024 15:47, Anna-Maria Behnsen wrote:
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

nit: Can you please add something in the commit message?

Otherwise:

Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

> ---
>  include/vdso/datapage.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
> index d04d394db064..7647e0946f50 100644
> --- a/include/vdso/datapage.h
> +++ b/include/vdso/datapage.h
> @@ -77,6 +77,10 @@ struct vdso_timestamp {
>   * vdso_data will be accessed by 64 bit and compat code at the same time
>   * so we should be careful before modifying this structure.
>   *
> + * The ordering of the struct members is optimized to have fast access to the
> + * often required struct members which are related to CLOCK_REALTIME and
> + * CLOCK_MONOTONIC. This information is stored in the first cache lines.
> + *
>   * @basetime is used to store the base time for the system wide time getter
>   * VVAR page.
>   *
> 

-- 
Regards,
Vincenzo

