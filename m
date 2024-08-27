Return-Path: <linux-kernel+bounces-302590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC46B960098
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 06:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EF962834F1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 04:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF886629E4;
	Tue, 27 Aug 2024 04:58:34 +0000 (UTC)
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284252747D
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 04:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724734714; cv=none; b=azChExO+aasjuaYqYRn8X9EzZy0WfQQjHN/gYl/KbT8Amq3G1sd7cwmxMZ/mTKli6L2rI317WDxObi58YybDJx/BE1WUI9S1lMPE46Za3tqSezmktMqTRBoSZW891HVohf94bsR50wGTTr5CD7C0uJ7T1qFLL0rMm7NT4lJ/P6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724734714; c=relaxed/simple;
	bh=wenqTgPQf46AXJBlS4tMlTCwfOslhxGNMWCOIfHTil8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IGq50LYuF4qYk+F+pqTPVzSSF+dB9ZyKsw74FgV/WnpcP19nKcGEJMf5QbW5JPPA2mjE/cQg9W7RCIWTdvLWCtBezr/qjd9/qm+jx4CUiBQGRWk8FKGCF9cwbhO8kAgFOdpepAAIsNNlilLuJkQeBzvHYYh9AXPBTJnJqPvViog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from mail-lj1-f170.google.com (unknown [209.85.208.170])
	by APP-05 (Coremail) with SMTP id zQCowAAnEDvqXM1mdoSqCg--.65434S2;
	Tue, 27 Aug 2024 12:58:20 +0800 (CST)
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f3edb2d908so52552031fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 21:58:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXnCXLeT7lXgfp+XgBgqrNlT5VWxDnlxYNXEUOgbHkLLVOaNNekVnw9/zHnPGv8Go7r/UJgHER37ziabWU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5hRPUsJfEmDgdqzPWg0cvE3OXGCD6y6VZZuNYLPFODvupyE/U
	zmGWcmDexYMc4nU5zOMZDdjHJ/uz03AXzby/DL16ZHK/6MK1o5lBA0z/BQzBIWtHiJycaLbBI/v
	6bZZoYdpgZriSuwmt3Ao1PkJXAfY=
X-Google-Smtp-Source: AGHT+IEX2H14GaCeJnkXY/Hbp0IXMG89lckaKR7RzwZ1eGKC2jJnXqdOjHhRK9agwk4zLmoFkQsnPUlFPowk5NPeaZM=
X-Received: by 2002:a2e:be0e:0:b0:2f3:d032:4489 with SMTP id
 38308e7fff4ca-2f4f48ef6c3mr95286331fa.8.1724734697966; Mon, 26 Aug 2024
 21:58:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826105737.106879-1-alexghiti@rivosinc.com>
In-Reply-To: <20240826105737.106879-1-alexghiti@rivosinc.com>
Reply-To: zhangchunyan@iscas.ac.cn
From: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
Date: Tue, 27 Aug 2024 12:57:41 +0800
X-Gmail-Original-Message-ID: <CAOsKWHCCEAi-G=Ld9GJ2YUrbbV6dEzThXh5rOzYp6kWfUHfNHw@mail.gmail.com>
Message-ID: <CAOsKWHCCEAi-G=Ld9GJ2YUrbbV6dEzThXh5rOzYp6kWfUHfNHw@mail.gmail.com>
Subject: Re: [PATCH -fixes] riscv: Fix RISCV_ALTERNATIVE_EARLY
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CM-TRANSID:zQCowAAnEDvqXM1mdoSqCg--.65434S2
X-Coremail-Antispam: 1UD129KBjvJXoW3XFyfAFW3ZryUuFy8CF1Dtrb_yoWxKr1UpF
	W5GFn8Kr4rX3y7try3AFWDZF1fA34kG342qa12yryrXayUAryrtrWag39FyFn5AFZ7XayI
	yFZYqrs8CF4UJ3DanT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPab7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVWxJr0_GcWln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvE
	ncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x
	IIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_
	Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK6IIF6r45MxAIw28Icx
	kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E
	5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtV
	W8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY
	1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
	0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU
	3NtxUUUUU
X-CM-SenderInfo: x2kd0wxfkx051dq6x2xfdvhtffof0/1tbiDAcCB2bNLauHMwAAsX

Hi Alex,

On Mon, 26 Aug 2024 at 18:58, Alexandre Ghiti <alexghiti@rivosinc.com> wrote:
>
> RISCV_ALTERNATIVE_EARLY will issue sbi_ecall() very early in the boot
> process, before the first memory mapping is setup so we can't have any
> instrumentation happening here.

I also found that when CONFIG_KASAN is enabled, and either
RISCV_ALTERNATIVE_EARLY or CONFIG_DT_IDLE_GENPD is set, the kernel
cannot boot.

This patch fixed the issue.

Tested-by: Chunyan Zhang <zhangchunyan@iscas.ac.cn>

>
> In addition, when the kernel is relocatable, we must also not issue any
> relocation this early since they would have been patched virtually only.
>
> So, instead of disabling instrumentation for the whole kernel/sbi.c file
> and compiling it with -fno-pie, simply move __sbi_ecall() and
> __sbi_base_ecall() into their own file where this is fixed.
>
> Fixes: 1745cfafebdf ("riscv: don't use global static vars to store alternative data")
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/include/asm/sbi.h  |  2 ++
>  arch/riscv/kernel/Makefile    |  6 ++++-
>  arch/riscv/kernel/sbi.c       | 44 --------------------------------
>  arch/riscv/kernel/sbi_ecall.c | 48 +++++++++++++++++++++++++++++++++++
>  4 files changed, 55 insertions(+), 45 deletions(-)
>  create mode 100644 arch/riscv/kernel/sbi_ecall.c
>
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index 7cffd4ffecd0..5843a10b380e 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -9,6 +9,7 @@
>
>  #include <linux/types.h>
>  #include <linux/cpumask.h>
> +#include <linux/jump_label.h>
>
>  #ifdef CONFIG_RISCV_SBI
>  enum sbi_ext_id {
> @@ -304,6 +305,7 @@ struct sbiret {
>  };
>
>  void sbi_init(void);
> +long __sbi_base_ecall(int fid);
>  struct sbiret __sbi_ecall(unsigned long arg0, unsigned long arg1,
>                           unsigned long arg2, unsigned long arg3,
>                           unsigned long arg4, unsigned long arg5,
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index 06d407f1b30b..7f88cc4931f5 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -20,17 +20,21 @@ endif
>  ifdef CONFIG_RISCV_ALTERNATIVE_EARLY
>  CFLAGS_alternative.o := -mcmodel=medany
>  CFLAGS_cpufeature.o := -mcmodel=medany
> +CFLAGS_sbi_ecall.o := -mcmodel=medany
>  ifdef CONFIG_FTRACE
>  CFLAGS_REMOVE_alternative.o = $(CC_FLAGS_FTRACE)
>  CFLAGS_REMOVE_cpufeature.o = $(CC_FLAGS_FTRACE)
> +CFLAGS_REMOVE_sbi_ecall.o = $(CC_FLAGS_FTRACE)
>  endif
>  ifdef CONFIG_RELOCATABLE
>  CFLAGS_alternative.o += -fno-pie
>  CFLAGS_cpufeature.o += -fno-pie
> +CFLAGS_sbi_ecall.o += -fno-pie
>  endif
>  ifdef CONFIG_KASAN
>  KASAN_SANITIZE_alternative.o := n
>  KASAN_SANITIZE_cpufeature.o := n
> +KASAN_SANITIZE_sbi_ecall.o := n
>  endif
>  endif
>
> @@ -88,7 +92,7 @@ obj-$(CONFIG_DYNAMIC_FTRACE)  += mcount-dyn.o
>
>  obj-$(CONFIG_PERF_EVENTS)      += perf_callchain.o
>  obj-$(CONFIG_HAVE_PERF_REGS)   += perf_regs.o
> -obj-$(CONFIG_RISCV_SBI)                += sbi.o
> +obj-$(CONFIG_RISCV_SBI)                += sbi.o sbi_ecall.o
>  ifeq ($(CONFIG_RISCV_SBI), y)
>  obj-$(CONFIG_SMP)              += sbi-ipi.o
>  obj-$(CONFIG_SMP) += cpu_ops_sbi.o
> diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> index 837bdab2601b..ace9e2f59c41 100644
> --- a/arch/riscv/kernel/sbi.c
> +++ b/arch/riscv/kernel/sbi.c
> @@ -14,9 +14,6 @@
>  #include <asm/smp.h>
>  #include <asm/tlbflush.h>
>
> -#define CREATE_TRACE_POINTS
> -#include <asm/trace.h>
> -
>  /* default SBI version is 0.1 */
>  unsigned long sbi_spec_version __ro_after_init = SBI_SPEC_VERSION_DEFAULT;
>  EXPORT_SYMBOL(sbi_spec_version);
> @@ -27,36 +24,6 @@ static int (*__sbi_rfence)(int fid, const struct cpumask *cpu_mask,
>                            unsigned long start, unsigned long size,
>                            unsigned long arg4, unsigned long arg5) __ro_after_init;
>
> -struct sbiret __sbi_ecall(unsigned long arg0, unsigned long arg1,
> -                         unsigned long arg2, unsigned long arg3,
> -                         unsigned long arg4, unsigned long arg5,
> -                         int fid, int ext)
> -{
> -       struct sbiret ret;
> -
> -       trace_sbi_call(ext, fid);
> -
> -       register uintptr_t a0 asm ("a0") = (uintptr_t)(arg0);
> -       register uintptr_t a1 asm ("a1") = (uintptr_t)(arg1);
> -       register uintptr_t a2 asm ("a2") = (uintptr_t)(arg2);
> -       register uintptr_t a3 asm ("a3") = (uintptr_t)(arg3);
> -       register uintptr_t a4 asm ("a4") = (uintptr_t)(arg4);
> -       register uintptr_t a5 asm ("a5") = (uintptr_t)(arg5);
> -       register uintptr_t a6 asm ("a6") = (uintptr_t)(fid);
> -       register uintptr_t a7 asm ("a7") = (uintptr_t)(ext);
> -       asm volatile ("ecall"
> -                     : "+r" (a0), "+r" (a1)
> -                     : "r" (a2), "r" (a3), "r" (a4), "r" (a5), "r" (a6), "r" (a7)
> -                     : "memory");
> -       ret.error = a0;
> -       ret.value = a1;
> -
> -       trace_sbi_return(ext, ret.error, ret.value);
> -
> -       return ret;
> -}
> -EXPORT_SYMBOL(__sbi_ecall);
> -
>  int sbi_err_map_linux_errno(int err)
>  {
>         switch (err) {
> @@ -535,17 +502,6 @@ long sbi_probe_extension(int extid)
>  }
>  EXPORT_SYMBOL(sbi_probe_extension);
>
> -static long __sbi_base_ecall(int fid)
> -{
> -       struct sbiret ret;
> -
> -       ret = sbi_ecall(SBI_EXT_BASE, fid, 0, 0, 0, 0, 0, 0);
> -       if (!ret.error)
> -               return ret.value;
> -       else
> -               return sbi_err_map_linux_errno(ret.error);
> -}
> -
>  static inline long sbi_get_spec_version(void)
>  {
>         return __sbi_base_ecall(SBI_EXT_BASE_GET_SPEC_VERSION);
> diff --git a/arch/riscv/kernel/sbi_ecall.c b/arch/riscv/kernel/sbi_ecall.c
> new file mode 100644
> index 000000000000..24aabb4fbde3
> --- /dev/null
> +++ b/arch/riscv/kernel/sbi_ecall.c
> @@ -0,0 +1,48 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2024 Rivos Inc. */
> +
> +#include <asm/sbi.h>
> +#define CREATE_TRACE_POINTS
> +#include <asm/trace.h>
> +
> +long __sbi_base_ecall(int fid)
> +{
> +       struct sbiret ret;
> +
> +       ret = sbi_ecall(SBI_EXT_BASE, fid, 0, 0, 0, 0, 0, 0);
> +       if (!ret.error)
> +               return ret.value;
> +       else
> +               return sbi_err_map_linux_errno(ret.error);
> +}
> +EXPORT_SYMBOL(__sbi_base_ecall);
> +
> +struct sbiret __sbi_ecall(unsigned long arg0, unsigned long arg1,
> +                         unsigned long arg2, unsigned long arg3,
> +                         unsigned long arg4, unsigned long arg5,
> +                         int fid, int ext)
> +{
> +       struct sbiret ret;
> +
> +       trace_sbi_call(ext, fid);
> +
> +       register uintptr_t a0 asm ("a0") = (uintptr_t)(arg0);
> +       register uintptr_t a1 asm ("a1") = (uintptr_t)(arg1);
> +       register uintptr_t a2 asm ("a2") = (uintptr_t)(arg2);
> +       register uintptr_t a3 asm ("a3") = (uintptr_t)(arg3);
> +       register uintptr_t a4 asm ("a4") = (uintptr_t)(arg4);
> +       register uintptr_t a5 asm ("a5") = (uintptr_t)(arg5);
> +       register uintptr_t a6 asm ("a6") = (uintptr_t)(fid);
> +       register uintptr_t a7 asm ("a7") = (uintptr_t)(ext);
> +       asm volatile ("ecall"
> +                      : "+r" (a0), "+r" (a1)
> +                      : "r" (a2), "r" (a3), "r" (a4), "r" (a5), "r" (a6), "r" (a7)
> +                      : "memory");
> +       ret.error = a0;
> +       ret.value = a1;
> +
> +       trace_sbi_return(ext, ret.error, ret.value);
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL(__sbi_ecall);
> --
> 2.39.2
>
>


