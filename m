Return-Path: <linux-kernel+bounces-236532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A583291E37A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 17:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D68101C21BF3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 15:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C87816C87E;
	Mon,  1 Jul 2024 15:11:57 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F68D84DE9
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 15:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719846717; cv=none; b=YTmIv+GKMQFOy3yqh/7J8asODFqUmxel7qaqX9GcqDH2knD6zhHndHZC4iR5nun8cC2Wwf6EDf3nMZbMHiq5Y044Vk7+3UXlvJ7z1eIybb3PswMoKjNPjnRxxPm9/yPsvXj7wGK0YZGMFxFqOju29kLuK2cCO4DwuE7NY4O/pUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719846717; c=relaxed/simple;
	bh=0SaFkezNq+bymhAhyipdlBuMkCiceu5m4FAI991Hcls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SpPOcMw+MzNq6neYf3Kjr76OZ+3h/8w4c8RGl53fyN0UxTeQShzxITfoO5qBF0EEn6rbFqEyq1kAyQNmR8SBjmHiIUZOUWcgZMtEQln4Hu7vspe6An7VRauZP/Fxpt0VS2Z6Iho+LBpZrrRiyFE4nvcB+RmbNk79J8x2mwReee4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8ABDF339;
	Mon,  1 Jul 2024 08:12:19 -0700 (PDT)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 46EE53F762;
	Mon,  1 Jul 2024 08:11:53 -0700 (PDT)
Message-ID: <26cd7080-b8c8-41a8-814b-869759954b73@arm.com>
Date: Mon, 1 Jul 2024 16:11:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] x86/vdso: Fix function reference in comment
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
References: <20240701-vdso-cleanup-v1-0-36eb64e7ece2@linutronix.de>
 <20240701-vdso-cleanup-v1-3-36eb64e7ece2@linutronix.de>
Content-Language: en-US
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
In-Reply-To: <20240701-vdso-cleanup-v1-3-36eb64e7ece2@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 01/07/2024 15:47, Anna-Maria Behnsen wrote:
> Replace the reference to the non-existent function arch_vdso_cycles_valid()
> by the proper function arch_vdso_cycles_ok().
> 
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: x86@kernel.org
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

> ---
>  arch/x86/include/asm/vdso/gettimeofday.h | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/include/asm/vdso/gettimeofday.h b/arch/x86/include/asm/vdso/gettimeofday.h
> index 0ef36190abe6..b2d2df026f6e 100644
> --- a/arch/x86/include/asm/vdso/gettimeofday.h
> +++ b/arch/x86/include/asm/vdso/gettimeofday.h
> @@ -328,9 +328,8 @@ static __always_inline u64 vdso_calc_ns(const struct vdso_data *vd, u64 cycles,
>  	 * due to unsigned comparison.
>  	 *
>  	 * Due to the MSB/Sign-bit being used as invalid marker (see
> -	 * arch_vdso_cycles_valid() above), the effective mask is S64_MAX,
> -	 * but that case is also unlikely and will also take the unlikely path
> -	 * here.
> +	 * arch_vdso_cycles_ok() above), the effective mask is S64_MAX, but that
> +	 * case is also unlikely and will also take the unlikely path here.
>  	 */
>  	if (unlikely(delta > vd->max_cycles)) {
>  		/*
> 

-- 
Regards,
Vincenzo

