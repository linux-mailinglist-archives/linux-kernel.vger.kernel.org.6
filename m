Return-Path: <linux-kernel+bounces-559523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF7AA5F4F8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54EE43BAF8B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F62426770A;
	Thu, 13 Mar 2025 12:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="O6aGSotP"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218DA2673A1
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 12:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741870385; cv=none; b=Pg+AGQOz4pMC9xZokFIGi365RROokBZQ1rL2UtuWnKdY1Gdgj9EdW9R/zHcZSPtQ36KYaGJs+DaxCyAftVYwCKIpbcSSfpo7Jbp0aY5v/ER+ckAbqkPvovqxCS8M1lWcbl7X2yvBAyiG53QuFkVkpNRP5eRh6JcWA7a3fSvKolc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741870385; c=relaxed/simple;
	bh=QIdobgZYkzVhdo1szioagjPNujhQnAnv7YIiKfgqlo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nem2Sen3JuvKy9weHBLAXq9yfQwPUMLthyIvGFQaccA1cooeCGZmEDWRftUxYTCISY1cdFZt6ENp6D8FghvRO2Ezk5SDZ+Yvd+6cyj93J+tpvAstaw1WlXpYds4qiSSwR1UQdObM1JDMHRjjzBk4ltByrSKApVJZdLf/2hAAjIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=O6aGSotP; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43690d4605dso6052515e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 05:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1741870380; x=1742475180; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=whJ5WLOnqJqIdekbdowFNyLodSkqgwLzZprjEG6v7KA=;
        b=O6aGSotPsgOgbS+mhD1ujIONFDWI0Q4Jk7kwb5koFRhss9CEK69UVF4IG/e30xM3Ss
         ogQqyX1N2/Bah4ztzYxglKLF0n4warGzTQQDd4iogzddoorSSFD4Am15ZyBlZ3igRb5S
         74kpxZuvadR6yE35UZPvvd8V/hTy3eBafZDlvp2pZCpPtcy7Aa3mul9cJjQL1/tHQnXT
         ovqWLHACX57VidxJmqZe6t+k5mmV349/7EgA35MwcKdeyuhc25PWoBoibzqxF+DMPxeN
         /4QOU7h3WVjMKoxT8+7qCbdicqBW7434HLWRjKfWlULV5v2JIuw+fQlHnOTbTpQjRzzG
         QbkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741870380; x=1742475180;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=whJ5WLOnqJqIdekbdowFNyLodSkqgwLzZprjEG6v7KA=;
        b=TGYUDvpWuQvnbw4mqRdIfDuZmOAq74YjgBbFbhrOg9UtieXoQ9G8pvyGn4nUL+ohcb
         gRf8Iz/R8HKhU+3XURfpIzkYk8jlaHi+CwrQ6VXRihuu+DEUtEdS+OxAgo6wS25Ewtnc
         QG9qXNPz0Tl80uzhDQqFIumWB4t88Fv2pllEZlYP4e8l7oy0fMV0YlU80v67VXeJqK/t
         WEyaHyy0sdoL+4XT23BgKCufPaqi2FYcUfvB5iPjNGaZsIZ+sJOrjh2zgePztqBcQMyK
         azeW60lpChikcL7MN9fvRTO20UDFFydej41sIOcOkRKGUxWUhLf+4u5OHwhn6H/pqC/R
         ASMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNsbta2Uqq1qWEtu4psZORVVrCPXbxHfnEof6u152vatSesDYw1zvXsA7kh2IIOwEvxuGY83ODByxWLxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsHfUfmy4MbCs4ZOigz1VIknI1mIvoHTYtvRqY9jmHNRqDrcGZ
	pVrBMIUeiUrtrR278hXhWqoUZUG1IF2YbYywAjyrW1p04urZedAP3Kr3z4Aa2QQ=
X-Gm-Gg: ASbGncsvy2nQPWHy70ZA6jrmVsNuVKQ8hSyM0JD8z4B0LsSKmZ+dME/ulN4Ft7ztn09
	0Bk3N0AprlGyoe909IpDInuAYHVreB3xJp4nmYMXx3pIJzT8QBdw3hF6JyPCb4+/liuhd7oincb
	paO+4ynPMO4HVbjDfpEaJC+BZsJ/6QPQxzpGuvNptsgJ4cfZ3J5niBLaPSxF/AwDMIUBugsnCkF
	f8kbGtaxeBuGWKr5YDZRnjutw96MFrOUimnVnA2Gt90ebrsdS73wbXZOTHBaSYWLf0AipRunRYA
	d42Yzl3NN7vX65X5E/7956Z7v5Hk0htk
X-Google-Smtp-Source: AGHT+IG41qlHvVlMBTz+EBNgOBL90SoyA5MRu9vVFfQYuH5YBZLTfvMhSZKO57zcnXjrEIFxRRHKsw==
X-Received: by 2002:a05:600c:3ba4:b0:43c:fabf:9146 with SMTP id 5b1f17b1804b1-43cfabf940emr138350995e9.17.1741870380371;
        Thu, 13 Mar 2025 05:53:00 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200::59a5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d186e9639sm20720865e9.0.2025.03.13.05.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 05:52:59 -0700 (PDT)
Date: Thu, 13 Mar 2025 13:52:58 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Anup Patel <anup@brainfault.org>, 
	Atish Patra <atishp@atishpatra.org>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org, 
	Samuel Holland <samuel.holland@sifive.com>
Subject: Re: [PATCH v3 04/17] riscv: misaligned: request misaligned exception
 from SBI
Message-ID: <20250313-28a56381a2c44ebeff100f91@orel>
References: <20250310151229.2365992-1-cleger@rivosinc.com>
 <20250310151229.2365992-5-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250310151229.2365992-5-cleger@rivosinc.com>

On Mon, Mar 10, 2025 at 04:12:11PM +0100, Clément Léger wrote:
> Now that the kernel can handle misaligned accesses in S-mode, request
> misaligned access exception delegation from SBI. This uses the FWFT SBI
> extension defined in SBI version 3.0.
> 
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> ---
>  arch/riscv/include/asm/cpufeature.h        |  3 +-
>  arch/riscv/kernel/traps_misaligned.c       | 77 +++++++++++++++++++++-
>  arch/riscv/kernel/unaligned_access_speed.c | 11 +++-
>  3 files changed, 86 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
> index 569140d6e639..ad7d26788e6a 100644
> --- a/arch/riscv/include/asm/cpufeature.h
> +++ b/arch/riscv/include/asm/cpufeature.h
> @@ -64,8 +64,9 @@ void __init riscv_user_isa_enable(void);
>  	_RISCV_ISA_EXT_DATA(_name, _id, _sub_exts, ARRAY_SIZE(_sub_exts), _validate)
>  
>  bool check_unaligned_access_emulated_all_cpus(void);
> +void unaligned_access_init(void);
> +int cpu_online_unaligned_access_init(unsigned int cpu);
>  #if defined(CONFIG_RISCV_SCALAR_MISALIGNED)
> -void check_unaligned_access_emulated(struct work_struct *work __always_unused);
>  void unaligned_emulation_finish(void);
>  bool unaligned_ctl_available(void);
>  DECLARE_PER_CPU(long, misaligned_access_speed);
> diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
> index 7cc108aed74e..90ac74191357 100644
> --- a/arch/riscv/kernel/traps_misaligned.c
> +++ b/arch/riscv/kernel/traps_misaligned.c
> @@ -16,6 +16,7 @@
>  #include <asm/entry-common.h>
>  #include <asm/hwprobe.h>
>  #include <asm/cpufeature.h>
> +#include <asm/sbi.h>
>  #include <asm/vector.h>
>  
>  #define INSN_MATCH_LB			0x3
> @@ -635,7 +636,7 @@ bool check_vector_unaligned_access_emulated_all_cpus(void)
>  
>  static bool unaligned_ctl __read_mostly;
>  
> -void check_unaligned_access_emulated(struct work_struct *work __always_unused)
> +static void check_unaligned_access_emulated(struct work_struct *work __always_unused)
>  {
>  	int cpu = smp_processor_id();
>  	long *mas_ptr = per_cpu_ptr(&misaligned_access_speed, cpu);
> @@ -646,6 +647,13 @@ void check_unaligned_access_emulated(struct work_struct *work __always_unused)
>  	__asm__ __volatile__ (
>  		"       "REG_L" %[tmp], 1(%[ptr])\n"
>  		: [tmp] "=r" (tmp_val) : [ptr] "r" (&tmp_var) : "memory");
> +}
> +
> +static int cpu_online_check_unaligned_access_emulated(unsigned int cpu)
> +{
> +	long *mas_ptr = per_cpu_ptr(&misaligned_access_speed, cpu);
> +
> +	check_unaligned_access_emulated(NULL);
>  
>  	/*
>  	 * If unaligned_ctl is already set, this means that we detected that all
> @@ -654,9 +662,10 @@ void check_unaligned_access_emulated(struct work_struct *work __always_unused)
>  	 */
>  	if (unlikely(unaligned_ctl && (*mas_ptr != RISCV_HWPROBE_MISALIGNED_SCALAR_EMULATED))) {
>  		pr_crit("CPU misaligned accesses non homogeneous (expected all emulated)\n");
> -		while (true)
> -			cpu_relax();
> +		return -EINVAL;
>  	}
> +
> +	return 0;
>  }
>  
>  bool check_unaligned_access_emulated_all_cpus(void)
> @@ -688,4 +697,66 @@ bool check_unaligned_access_emulated_all_cpus(void)
>  {
>  	return false;
>  }
> +static int cpu_online_check_unaligned_access_emulated(unsigned int cpu)
> +{
> +	return 0;
> +}
>  #endif
> +
> +#ifdef CONFIG_RISCV_SBI
> +
> +static bool misaligned_traps_delegated;
> +
> +static int cpu_online_sbi_unaligned_setup(unsigned int cpu)
> +{
> +	if (sbi_fwft_set(SBI_FWFT_MISALIGNED_EXC_DELEG, 1, 0) &&
> +	    misaligned_traps_delegated) {
> +		pr_crit("Misaligned trap delegation non homogeneous (expected delegated)");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static void unaligned_sbi_request_delegation(void)
> +{
> +	int ret;
> +
> +	ret = sbi_fwft_all_cpus_set(SBI_FWFT_MISALIGNED_EXC_DELEG, 1, 0, 0);
> +	if (ret)
> +		return;
> +
> +	misaligned_traps_delegated = true;
> +	pr_info("SBI misaligned access exception delegation ok\n");
> +	/*
> +	 * Note that we don't have to take any specific action here, if
> +	 * the delegation is successful, then
> +	 * check_unaligned_access_emulated() will verify that indeed the
> +	 * platform traps on misaligned accesses.
> +	 */
> +}
> +
> +void unaligned_access_init(void)
> +{
> +	if (sbi_probe_extension(SBI_EXT_FWFT) > 0)
> +		unaligned_sbi_request_delegation();
> +}
> +#else
> +void unaligned_access_init(void) {}
> +
> +static int cpu_online_sbi_unaligned_setup(unsigned int cpu __always_unused)
> +{
> +	return 0;
> +}
> +#endif
> +
> +int cpu_online_unaligned_access_init(unsigned int cpu)
> +{
> +	int ret;
> +
> +	ret = cpu_online_sbi_unaligned_setup(cpu);
> +	if (ret)
> +		return ret;
> +
> +	return cpu_online_check_unaligned_access_emulated(cpu);
> +}
> diff --git a/arch/riscv/kernel/unaligned_access_speed.c b/arch/riscv/kernel/unaligned_access_speed.c
> index 91f189cf1611..2f3aba073297 100644
> --- a/arch/riscv/kernel/unaligned_access_speed.c
> +++ b/arch/riscv/kernel/unaligned_access_speed.c
> @@ -188,13 +188,20 @@ arch_initcall_sync(lock_and_set_unaligned_access_static_branch);
>  
>  static int riscv_online_cpu(unsigned int cpu)
>  {
> +	int ret;
>  	static struct page *buf;
>  
>  	/* We are already set since the last check */
>  	if (per_cpu(misaligned_access_speed, cpu) != RISCV_HWPROBE_MISALIGNED_SCALAR_UNKNOWN)
>  		goto exit;
>  
> -	check_unaligned_access_emulated(NULL);
> +	ret = cpu_online_unaligned_access_init(cpu);
> +	if (ret)
> +		return ret;
> +
> +	if (per_cpu(misaligned_access_speed, cpu) == RISCV_HWPROBE_MISALIGNED_SCALAR_EMULATED)
> +		goto exit;
> +
>  	buf = alloc_pages(GFP_KERNEL, MISALIGNED_BUFFER_ORDER);
>  	if (!buf) {
>  		pr_warn("Allocation failure, not measuring misaligned performance\n");
> @@ -403,6 +410,8 @@ static int check_unaligned_access_all_cpus(void)
>  {
>  	bool all_cpus_emulated, all_cpus_vec_unsupported;
>  
> +	unaligned_access_init();
> +
>  	all_cpus_emulated = check_unaligned_access_emulated_all_cpus();
>  	all_cpus_vec_unsupported = check_vector_unaligned_access_emulated_all_cpus();
>  
> -- 
> 2.47.2
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

