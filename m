Return-Path: <linux-kernel+bounces-423071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFFC9DA261
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 07:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31F5D285857
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 06:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5D0145B3E;
	Wed, 27 Nov 2024 06:37:54 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA5AF9DD
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 06:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732689473; cv=none; b=C7d4J2GUJWfP38r6YDv2taP7UYgcC0ell5jQVTBTcyq5Vt9IA3wwqvdHFRAtfzq0zYbRdm8JcX+TiX9ZmKp8K1rNIcXX2tMnukRLmZSfqX+hk+TPZq+rogiHtMH1+p1AUgL1UzoZ01IUT/o14TvZubNoGEORKpWY1Pm6tAzsdGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732689473; c=relaxed/simple;
	bh=s+rSKncvjjHHuvJLEkP9hZQs1vncR8jUXTca2CbyQCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RFX669vtLQEakERfKXCjZwo9WD3j/itl2CY8k5Rg00qwAYRprrunkYXruYXFXGzBJA160Vgoth1Ix8T24Cd0K4E4wmvP4iZi7vyLfpACBl8qEP0uZTIN12iaM5NtNRSlBErxFpKvRptJd/FSKPvgs/4TE03edEb+wjh1vWVnTw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4XyqWK5rqhz9sPd;
	Wed, 27 Nov 2024 07:37:49 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nY_sZNC28FxT; Wed, 27 Nov 2024 07:37:49 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4XyqWK4h7Bz9rvV;
	Wed, 27 Nov 2024 07:37:49 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 862598B780;
	Wed, 27 Nov 2024 07:37:49 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id gECYhmM34_MR; Wed, 27 Nov 2024 07:37:49 +0100 (CET)
Received: from [192.168.233.25] (PO18304.IDSI0.si.c-s.fr [192.168.233.25])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id EB4588B77C;
	Wed, 27 Nov 2024 07:37:48 +0100 (CET)
Message-ID: <b5c152a3-d459-4744-84ec-846153de1652@csgroup.eu>
Date: Wed, 27 Nov 2024 07:37:48 +0100
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

Instead of copying all the content of asm-generic version, can you just 
create a receptacle for your new macros, that will include 
asm-generic/preempt.h ?

Look at arch/powerpc/include/asm/percpu.h for exemple.

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

Should be __ASM_POWERPC_PREEMPT_H

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

