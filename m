Return-Path: <linux-kernel+bounces-430181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C89D59E2D5F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 21:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A08F61673BB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 20:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8F6209F2A;
	Tue,  3 Dec 2024 20:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cachyos.org header.i=@cachyos.org header.b="nDmBYuoK"
Received: from mail.ptr1337.dev (mail.ptr1337.dev [202.61.224.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0A9205ACD
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 20:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.224.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733258413; cv=none; b=nxAFjSiOpzd1ORcFDkRquiTfyJ5qaSCLYzI5BHOzJYNLGYPIKIR4LK7BTHOWfykZOXvMU9hzryTb7RPid5TKi64Bq9xDl0eYx2JcAQb9h8b6c/R2QdjQBvqyjUbwy3BoGDrWqzYJSdQWmVh827C/cc0MEjcIpvdIGpeejpvjG5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733258413; c=relaxed/simple;
	bh=RTeOSs+PODqfFcdaiufsQm5TwqAd1N5xngHtkbyh/L8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h7fynnvC9uQ5HTU4czknJlGGBUZdId58ix5EKQ+naQd4BD7HMfTVp4pXIp/8muCvvLnqxwKACsOaUDtXpU2jQCQ8uyuXxuJXet35MwxpzFOKex3mk6Jf3+XvRabjCmNjbnx/nlgzOpZg5wHe8+FD+VXNY0pie9EkoaX3PFuFHd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cachyos.org; spf=pass smtp.mailfrom=cachyos.org; dkim=pass (2048-bit key) header.d=cachyos.org header.i=@cachyos.org header.b=nDmBYuoK; arc=none smtp.client-ip=202.61.224.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cachyos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cachyos.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DB8DF2808FE;
	Tue,  3 Dec 2024 21:33:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cachyos.org; s=dkim;
	t=1733257986; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=VOujX2BmJ1X4x59DiECr3ZxaOWVOCu+X9RSDqilqZ1I=;
	b=nDmBYuoKRLzz69/pgTXMtCL4B+90+kz+F+m+orcozJ3PR15zBtt0xjsmpCnhg64yFHIe9f
	GHDKuV0TN76RnQhZ9hmC9SHUu9pA3JRXM3GSERK5hn6uqp+FVbimSI/vQi2b8FZmmbFziE
	NgjE6X7xJ6p9O0CIegmWdIu2obAaYQBeUPnfebE6MpY4zqyZ8dM/YH5NEozNeTiOZw/cuB
	PDvi/+KzkgN3PFbMxe3XMeujNrN7s9IZ3Y65P79KCWZ1x2jLxSdKaRd3Nv75m05CHJkCAF
	E7WK6l89Ti9WOPajj99oA6z3BoXksHQaQ/iXH1vaY7XTSrbiemUdl/Jxecx+gQ==
Message-ID: <87d916f7-b9f5-4bae-82fe-6249e8647a62@cachyos.org>
Date: Tue, 3 Dec 2024 21:33:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/cpu: Enable SD_ASYM_PACKING for PKG domain on
 systems with AMD preferred cores
To: Mario Limonciello <mario.limonciello@amd.com>,
 Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
 "H . Peter Anvin" <hpa@zytor.com>,
 "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>
References: <20241203201129.31957-1-mario.limonciello@amd.com>
Content-Language: en-US
From: Peter Jung <ptr1337@cachyos.org>
Organization: CachyOS
In-Reply-To: <20241203201129.31957-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

This does fix the preferred core behavior now and it works now as it should.
Tested with a 9950X on several games, and the scheduler now picks the 
correct cores, which results into a heavy performance improvement, due 
not migrating through the second ccd.

Thanks!

Tested-by: Peter Jung <ptr1337@cachyos.org>


On 03.12.24 21:11, Mario Limonciello wrote:
> For the scheduler to use and prefer AMD preferred core rankings set
> SD_ASYM_PACKING for x86_die_flags().
> 
> Signed-off-by: Mario Limonciello<mario.limonciello@amd.com>
> ---
> v2:
>   * Fix c23 compatibility issue reported by LKP
> ---
>   arch/x86/kernel/smpboot.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index b5a8f0891135b..6a38cf3feb1a9 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -62,6 +62,8 @@
>   #include <linux/mc146818rtc.h>
>   #include <linux/acpi.h>
>   
> +#include <acpi/cppc_acpi.h>
> +
>   #include <asm/acpi.h>
>   #include <asm/cacheinfo.h>
>   #include <asm/desc.h>
> @@ -501,6 +503,15 @@ static int x86_die_flags(void)
>   	    cpu_feature_enabled(X86_FEATURE_AMD_HETEROGENEOUS_CORES))
>   		return x86_sched_itmt_flags();
>   
> +	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
> +	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
> +		bool prefcore = false;
> +
> +		amd_detect_prefcore(&prefcore);
> +		if (prefcore)
> +			return x86_sched_itmt_flags();
> +	}
> +
>   	return 0;
>   }
>   
> 
> base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
> -- 2.43.0
> 


