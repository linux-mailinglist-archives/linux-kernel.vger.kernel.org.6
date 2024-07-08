Return-Path: <linux-kernel+bounces-244991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4685A92AC9C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 01:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0E0A2812D1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 23:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4675152DE3;
	Mon,  8 Jul 2024 23:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="XpaciIi1"
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E605054FAD
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 23:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720482301; cv=none; b=N+c2wYPh6iVVmcfbgoWxZI9hGHNAZ++6QEhNYT1y0wCIoimctpw/Y2hpk0Cjt/IjuTCKDQX+HOEP9D7R4XljVXg1XC7bK+wKkqNX6ZRsTHPrt46UShkpvdXuLDC4YoJyzWKSDLN2SEsA/+k1UXEqUIgxWsKqT3YeewYaElf+dTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720482301; c=relaxed/simple;
	bh=AuzHgZOLjpR176vDzbu1ba2zU5kfS/Q5uYsYWaRIEO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jKUvPNoZyV5QSsEPvLooUe/NRe2hJD8HywPOeYbLsDlQ9u2ht/Dn1f8MjcB8Uxf2flmhpYye/Opvx7i9oGtNC/xDmceFoBs9RbpJKtUCGHb+XbtfQBnLDNXnYegXmhoBON/NPO4319MXspNkANZesBAHpmBqMHiyZpQH6syhvP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=XpaciIi1; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6009a.ext.cloudfilter.net ([10.0.30.184])
	by cmsmtp with ESMTPS
	id QuMMs7p9kjZAYQy2OsSGVn; Mon, 08 Jul 2024 23:44:52 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id Qy2Ns6tXfDkWaQy2Ns4JVj; Mon, 08 Jul 2024 23:44:51 +0000
X-Authority-Analysis: v=2.4 cv=MO5mmtZl c=1 sm=1 tr=0 ts=668c79f3
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=frY+GlAHrI6frpeK1MvySw==:17
 a=IkcTkHD0fZMA:10 a=4kmOji7k6h8A:10 a=wYkD_t78qR0A:10 a=pGLkceISAAAA:8
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=QyXUC8HyAAAA:8 a=oGMlB6cnAAAA:8
 a=1XWaLZrsAAAA:8 a=YATm3ayRHBIWB40sf30A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=NdAtdrkLVvyUPsUoGJp4:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DRXxuRgGv2q11f8yChcm9SHFs2TQBg0qlsQgA2M+2v0=; b=XpaciIi1s0oNqork12yhyqLV8b
	45ZKicGftoeA/3DmsBPs6wHS29appxz3W6eZwyCR5UvTM6YIGfuDEaSNkxRxcQ+DsQPXBOI1/e1ab
	6brsb/y5+W1dL76naIR0s1Of9xj3WKPJLYDcy8Y7GypKspo9BVk746JaUapB7poPyaMsO35DUFivF
	Lr1knQNKOqRByuQR/Pl9BJdXtVf+KVe0zCPocJLUgclzBXOATQAqRxyVQ6eJAg2DVgVxmypyUsU1o
	eEDx76IoAYgCee+ksN60JJUlnOhlorHcPsMFaNyz4H0z8DWz7HsMDVvRHQXR25SxerGyRDlmwLeTt
	xj6uE9/A==;
Received: from [201.172.173.139] (port=48468 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1sQy2L-0039pb-0k;
	Mon, 08 Jul 2024 18:44:49 -0500
Message-ID: <e95852cf-231a-4525-9075-fad42930d328@embeddedor.com>
Date: Mon, 8 Jul 2024 17:44:42 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/syscall: Avoid memcpy() for ia32
 syscall_get_arguments()
To: Kees Cook <kees@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Mirsad Todorovac <mtodorovac69@gmail.com>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>,
 Daniel Sneddon <daniel.sneddon@linux.intel.com>,
 Arnd Bergmann <arnd@arndb.de>, Brian Gerst <brgerst@gmail.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Peter Collingbourne <pcc@google.com>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20240708202202.work.477-kees@kernel.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240708202202.work.477-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.173.139
X-Source-L: No
X-Exim-ID: 1sQy2L-0039pb-0k
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.10]) [201.172.173.139]:48468
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfCO3NThfb/0eK9ltPCakEFKsD1URPrIk2+QuAMTfUxYDBGrpIA0ngPWX7PLtiQjQuoPUkDgtDdoUmVijahJGNEDMiqbC9PpB5kHf0hdJQEyLNsEPXjN9
 5Vk7Kz4AfuZBv7kF6SBz9vujViT48uRsXuA68i/DP0j/FxGmqx27nTt8861lUpqVyI6urQRqgQL974rCEhkD0aYXrx+pc0J7RlQ1DVEZptCjFww9BP/77hzS



On 7/8/24 14:22, Kees Cook wrote:
> Modern (fortified) memcpy() prefers to avoid writing (or reading) beyond
> the end of the addressed destination (or source) struct member:
> 
> In function ‘fortify_memcpy_chk’,
>      inlined from ‘syscall_get_arguments’ at ./arch/x86/include/asm/syscall.h:85:2,
>      inlined from ‘populate_seccomp_data’ at kernel/seccomp.c:258:2,
>      inlined from ‘__seccomp_filter’ at kernel/seccomp.c:1231:3:
> ./include/linux/fortify-string.h:580:25: error: call to ‘__read_overflow2_field’ declared with attribute warning: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Werror=attribute-warning]
>    580 |                         __read_overflow2_field(q_size_field, size);
>        |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> As already done for x86_64 and compat mode, do not use memcpy() to
> extract syscall arguments from struct pt_regs but rather just perform
> direct assignments. Binary output differences are negligible, and actually
> ends up using less stack space:
> 
> -       sub    $0x84,%esp
> +       sub    $0x6c,%esp
> 
> and less text size:
> 
>     text    data     bss     dec     hex filename
>    10794     252       0   11046    2b26 gcc-32b/kernel/seccomp.o.stock
>    10714     252       0   10966    2ad6 gcc-32b/kernel/seccomp.o.after
> 
> Reported-by: Mirsad Todorovac <mtodorovac69@gmail.com>
> Closes: https://lore.kernel.org/lkml/9b69fb14-df89-4677-9c82-056ea9e706f5@gmail.com/
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: x86@kernel.org
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Daniel Sneddon <daniel.sneddon@linux.intel.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Brian Gerst <brgerst@gmail.com>
> Cc: Josh Poimboeuf <jpoimboe@kernel.org>
> Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> Cc: Peter Collingbourne <pcc@google.com>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
>   arch/x86/include/asm/syscall.h | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/syscall.h b/arch/x86/include/asm/syscall.h
> index 2fc7bc3863ff..7c488ff0c764 100644
> --- a/arch/x86/include/asm/syscall.h
> +++ b/arch/x86/include/asm/syscall.h
> @@ -82,7 +82,12 @@ static inline void syscall_get_arguments(struct task_struct *task,
>   					 struct pt_regs *regs,
>   					 unsigned long *args)
>   {
> -	memcpy(args, &regs->bx, 6 * sizeof(args[0]));
> +	args[0] = regs->bx;
> +	args[1] = regs->cx;
> +	args[2] = regs->dx;
> +	args[3] = regs->si;
> +	args[4] = regs->di;
> +	args[5] = regs->bp;
>   }
>   
>   static inline int syscall_get_arch(struct task_struct *task)

