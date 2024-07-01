Return-Path: <linux-kernel+bounces-236625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D57E91E51C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 18:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 038731F22363
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458D916D4E8;
	Mon,  1 Jul 2024 16:19:17 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9502562E
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 16:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719850756; cv=none; b=Qztto79K3t05iv3JRqN1u13EdjMeeweT95+Bzff/lomXDHBVICDQRGwHV1fg6QMUAUVgltVO9lByygQDUt7gne/2+Rta/AKGvEFyooyFo5dgnalpxb9Pg3u4ZaiPtQWqxwBMUVzfDevb/mrxzjV4KJjrEnYr7GCNYEeCtVhQWvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719850756; c=relaxed/simple;
	bh=dLVgkVL5LeWt7JxWdFhj/ivushHoW6Ug6ubH0rv2e+c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hir4VHONMDzvmyzyqqCN5I/Hz4sOm3+jBuHR9VlnWK0bhkB90/Ps40+LP+NL8/NVYMCC3BxwRnDB22s4t7bqRT+qgnTKPl3cOjOWBVyXUs6fMVsObBboUC/g5H6vku0SdDWUOYyX1X0mmhpLSBGN3Sm54BY1FfyyV5fX7iUoUPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C50A1339;
	Mon,  1 Jul 2024 09:19:38 -0700 (PDT)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8888F3F73B;
	Mon,  1 Jul 2024 09:19:12 -0700 (PDT)
Message-ID: <55eb7d9a-7256-44f9-ad50-e4d7dd8ac007@arm.com>
Date: Mon, 1 Jul 2024 17:19:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] x86/vdso: Remove unused include
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
References: <20240701-vdso-cleanup-v1-0-36eb64e7ece2@linutronix.de>
 <20240701-vdso-cleanup-v1-5-36eb64e7ece2@linutronix.de>
Content-Language: en-US
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
In-Reply-To: <20240701-vdso-cleanup-v1-5-36eb64e7ece2@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 01/07/2024 15:47, Anna-Maria Behnsen wrote:
> Including hrtimer.h is not required and is probably a historical
> leftover. Remove it.
> 
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: x86@kernel.org
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

> ---
>  arch/x86/include/asm/vdso/vsyscall.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/vdso/vsyscall.h b/arch/x86/include/asm/vdso/vsyscall.h
> index be199a9b2676..93226281b450 100644
> --- a/arch/x86/include/asm/vdso/vsyscall.h
> +++ b/arch/x86/include/asm/vdso/vsyscall.h
> @@ -4,7 +4,6 @@
>  
>  #ifndef __ASSEMBLY__
>  
> -#include <linux/hrtimer.h>
>  #include <linux/timekeeper_internal.h>
>  #include <vdso/datapage.h>
>  #include <asm/vgtod.h>
> 

-- 
Regards,
Vincenzo

