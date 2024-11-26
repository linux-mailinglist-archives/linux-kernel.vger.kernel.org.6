Return-Path: <linux-kernel+bounces-422205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7689E9D95D4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 11:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B7D8B237AB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 10:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20BF6522F;
	Tue, 26 Nov 2024 10:49:56 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF80179DC
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 10:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732618195; cv=none; b=rnM8NX+tDy4kv6VBLQfpGaBP7GMfQ5fNjy9lR1UjpR+ynSUgZU9AdxY2JTsILpofkr5oNQw7dcbukA3mKW0khWbOzUg8bCaDkUZzChOdgTdlHsJcKvyHKRJa3nUQmTqW6n1K/waZLm8YIBtW9b4dvRsjvU+NEcBEDCoOthE1Lzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732618195; c=relaxed/simple;
	bh=zNEgLF3hza9AnD4jD9nteCtVjEXTRMfeajArmI8AFtE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YvvAYQlpeIQggEXvmTtEwZYRb4r4VdMwmiUBGA6Pm5wMXuyglGXYHJ3Kku9jURWfRePuYPg5KRdLNGUTLOox+AjU0gyehFTXQouDgmsG2W6DBubkYwsJ2Hotsq3eMI9LBgWC6TSN6/ruS3Tk9wKtC3vWoYUd4H56dyinT+KWByM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4XyK8c19jCz9sRs;
	Tue, 26 Nov 2024 11:49:52 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gu8-tJzQN5bA; Tue, 26 Nov 2024 11:49:52 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4XyK8c0CwJz9sRk;
	Tue, 26 Nov 2024 11:49:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id E98F38B776;
	Tue, 26 Nov 2024 11:49:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id fg-YBd2-eqnU; Tue, 26 Nov 2024 11:49:51 +0100 (CET)
Received: from [192.168.232.206] (unknown [192.168.232.206])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 77A838B763;
	Tue, 26 Nov 2024 11:49:50 +0100 (CET)
Message-ID: <a96062bc-8bcc-4ca0-b24e-ea64f9ee6329@csgroup.eu>
Date: Tue, 26 Nov 2024 11:49:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] powerpc: copy preempt.h into arch/include/asm
To: Shrikanth Hegde <sshegde@linux.ibm.com>, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Cc: npiggin@gmail.com, maddy@linux.ibm.com, bigeasy@linutronix.de,
 ankur.a.arora@oracle.com, linux-kernel@vger.kernel.org,
 mark.rutland@arm.com, vschneid@redhat.com, peterz@infradead.org
References: <20241125042212.1522315-1-sshegde@linux.ibm.com>
 <20241125042212.1522315-2-sshegde@linux.ibm.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20241125042212.1522315-2-sshegde@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 25/11/2024 à 05:22, Shrikanth Hegde a écrit :
> PowerPC uses asm-generic preempt definitions as of now.
> Copy that into arch/asm so that arch specific changes can be done.
> This would help the next patch for enabling dynamic preemption.

I can't see any valid use in following patches. The only modification 
you do to that file is in patch 2 and it is unused.

> 
> No functional changes intended.
> 
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> ---
>   arch/powerpc/include/asm/preempt.h | 100 +++++++++++++++++++++++++++++
>   1 file changed, 100 insertions(+)
>   create mode 100644 arch/powerpc/include/asm/preempt.h
> 
> diff --git a/arch/powerpc/include/asm/preempt.h b/arch/powerpc/include/asm/preempt.h
> new file mode 100644
> index 000000000000..51f8f3881523
> --- /dev/null
> +++ b/arch/powerpc/include/asm/preempt.h
> @@ -0,0 +1,100 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __ASM_PREEMPT_H
> +#define __ASM_PREEMPT_H
> +
> +#include <linux/thread_info.h>
> +
> +#define PREEMPT_ENABLED	(0)
> +
> +static __always_inline int preempt_count(void)
> +{
> +	return READ_ONCE(current_thread_info()->preempt_count);
> +}
> +
> +static __always_inline volatile int *preempt_count_ptr(void)
> +{
> +	return &current_thread_info()->preempt_count;
> +}
> +
> +static __always_inline void preempt_count_set(int pc)
> +{
> +	*preempt_count_ptr() = pc;
> +}
> +
> +/*
> + * must be macros to avoid header recursion hell
> + */
> +#define init_task_preempt_count(p) do { \
> +	task_thread_info(p)->preempt_count = FORK_PREEMPT_COUNT; \
> +} while (0)
> +
> +#define init_idle_preempt_count(p, cpu) do { \
> +	task_thread_info(p)->preempt_count = PREEMPT_DISABLED; \
> +} while (0)
> +
> +static __always_inline void set_preempt_need_resched(void)
> +{
> +}
> +
> +static __always_inline void clear_preempt_need_resched(void)
> +{
> +}
> +
> +static __always_inline bool test_preempt_need_resched(void)
> +{
> +	return false;
> +}
> +
> +/*
> + * The various preempt_count add/sub methods
> + */
> +
> +static __always_inline void __preempt_count_add(int val)
> +{
> +	*preempt_count_ptr() += val;
> +}
> +
> +static __always_inline void __preempt_count_sub(int val)
> +{
> +	*preempt_count_ptr() -= val;
> +}
> +
> +static __always_inline bool __preempt_count_dec_and_test(void)
> +{
> +	/*
> +	 * Because of load-store architectures cannot do per-cpu atomic
> +	 * operations; we cannot use PREEMPT_NEED_RESCHED because it might get
> +	 * lost.
> +	 */
> +	return !--*preempt_count_ptr() && tif_need_resched();
> +}
> +
> +/*
> + * Returns true when we need to resched and can (barring IRQ state).
> + */
> +static __always_inline bool should_resched(int preempt_offset)
> +{
> +	return unlikely(preempt_count() == preempt_offset &&
> +			tif_need_resched());
> +}
> +
> +#ifdef CONFIG_PREEMPTION
> +extern asmlinkage void preempt_schedule(void);
> +extern asmlinkage void preempt_schedule_notrace(void);
> +
> +#if defined(CONFIG_PREEMPT_DYNAMIC) && defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
> +
> +void dynamic_preempt_schedule(void);
> +void dynamic_preempt_schedule_notrace(void);
> +#define __preempt_schedule()		dynamic_preempt_schedule()
> +#define __preempt_schedule_notrace()	dynamic_preempt_schedule_notrace()
> +
> +#else /* !CONFIG_PREEMPT_DYNAMIC || !CONFIG_HAVE_PREEMPT_DYNAMIC_KEY*/
> +
> +#define __preempt_schedule() preempt_schedule()
> +#define __preempt_schedule_notrace() preempt_schedule_notrace()
> +
> +#endif /* CONFIG_PREEMPT_DYNAMIC && CONFIG_HAVE_PREEMPT_DYNAMIC_KEY*/
> +#endif /* CONFIG_PREEMPTION */
> +
> +#endif /* __ASM_PREEMPT_H */

