Return-Path: <linux-kernel+bounces-565519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2F9A66A0B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 07:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F98219A084D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 06:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081151991CF;
	Tue, 18 Mar 2025 06:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="xWMGQN/+"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B3725569
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 06:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742277739; cv=none; b=c3wdFzURUjVIi7hANoJsObWr72taZKM+izoontq+lS5RL8Vhw7HHL2ux4Qcht/mhp+YWP5Zutwc62Aac7br3bMlWDDszn3kBrKNNpgT7/81GR5FWgCa/ywnHqiC8YO1ia0Rfwx+Pxwfp4xm9dZadqFbIouwRpUwGfefIeehSRKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742277739; c=relaxed/simple;
	bh=QTwtoZ4DAHQ+3MbYCZBPNhnDNesv0UZoi+e9JpgOy4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MzfIODQH/c8JuSsDsIZuG8knHvq7tclzsVH/+taD4+CCxSbxt9/Mx+dN+PDJjXDulybSuhjFZMa6v9kL1FN4a3mZE29xJgPrZybzgls8u4hGs2PUq32K3k9isXFIu0ZNRdTBztthJaOGZJJ/P3ql31zvqwo4Jk5TARbLIdb3sfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=xWMGQN/+; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [192.168.7.202] ([71.202.166.45])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 52I61n6N879231
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 17 Mar 2025 23:01:50 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 52I61n6N879231
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1742277710;
	bh=J0XNuiByNztZkYJnBVTtSd3+t8y5ED+ZoRg6F/VhOwE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=xWMGQN/+Sc85FnXgAqCcaP2kIB1e54c4HN/19T3NwZaBBGcbVPCBB6q95m5Lwducl
	 0SQ+VGFCoDzew/HcMAX5ak1bUdmlk18bET0f8296XDzzNwlFSpxKdxka3TqYFmYZjP
	 3bJj3OeAiWfmrsKZLglOCp3534j1sHiYwtanJ1zK7u9t2UVbwEppiIF2ehehoC2fpO
	 BGNBiNtDlEJR1Dr0BFJFbTysB3MM8IkSGaxp1MftfxXRgxLYsj1j85Qh6YDWUXkclb
	 dqU3DP6O2uP+R9honVlTyR1pb374ntZaNav1O2fWekTlLnxzbGHXimkw4hVYeFenHu
	 3cXPKkBBRPYpw==
Message-ID: <b7920c2c-1051-4674-994c-d1b681cf7988@zytor.com>
Date: Mon, 17 Mar 2025 23:01:49 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] x86/cpuid: Use u32 in instead of uint32_t in
 <asm/cpuid/api.h>
To: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "Ahmed S . Darwish" <darwi@linutronix.de>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        "H . Peter Anvin"
 <hpa@zytor.com>,
        John Ogness <john.ogness@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20250317221824.3738853-1-mingo@kernel.org>
 <20250317221824.3738853-6-mingo@kernel.org>
Content-Language: en-US
From: Xin Li <xin@zytor.com>
Autocrypt: addr=xin@zytor.com; keydata=
 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
 l75w1xInsg==
In-Reply-To: <20250317221824.3738853-6-mingo@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/17/2025 3:18 PM, Ingo Molnar wrote:
> Use u32 instead of uint32_t in hypervisor_cpuid_base().
> 
> Yes, I realize uint32_t is used in Xen code et al, but this is
> a core x86 architecture header and we should standardize on the

no "we", right?

> type that is being used overwhelmingly in related x86 architecture
> code.
> 
> The two types are the same so there should be no build warnings.
> 
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Ahmed S. Darwish <darwi@linutronix.de>
> Cc: Andrew Cooper <andrew.cooper3@citrix.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: John Ogness <john.ogness@linutronix.de>
> Cc: x86-cpuid@lists.linux.dev
> Link: https://lore.kernel.org/r/20250317164745.4754-3-darwi@linutronix.de
> ---
>   arch/x86/include/asm/cpuid/api.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/cpuid/api.h b/arch/x86/include/asm/cpuid/api.h
> index 356db1894588..9c180c9cc58e 100644
> --- a/arch/x86/include/asm/cpuid/api.h
> +++ b/arch/x86/include/asm/cpuid/api.h
> @@ -187,9 +187,9 @@ static __always_inline bool cpuid_function_is_indexed(u32 function)
>   #define for_each_possible_hypervisor_cpuid_base(function) \
>   	for (function = 0x40000000; function < 0x40010000; function += 0x100)
>   
> -static inline uint32_t hypervisor_cpuid_base(const char *sig, uint32_t leaves)
> +static inline u32 hypervisor_cpuid_base(const char *sig, u32 leaves)
>   {
> -	uint32_t base, eax, signature[3];
> +	u32 base, eax, signature[3];
>   
>   	for_each_possible_hypervisor_cpuid_base(base) {
>   		cpuid(base, &eax, &signature[0], &signature[1], &signature[2]);


