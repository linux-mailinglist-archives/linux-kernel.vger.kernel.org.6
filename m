Return-Path: <linux-kernel+bounces-333609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C4F97CB4E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 17:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 038B6B23560
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 15:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCBA1A070E;
	Thu, 19 Sep 2024 15:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cybernetics.com header.i=@cybernetics.com header.b="DUBj3G8F"
Received: from mail.cybernetics.com (mail.cybernetics.com [72.215.153.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30101A08C2
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 15:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.215.153.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726758341; cv=none; b=oGYM9h5JI9fePzdVyxdmxWUynoI6rRw1nfW8ygrL0dl2z8XeLamtSH/gP8+VRY5qHmW4T0qfBS82Lo0Dy1QsJnX6k0aarjSnQSdH4amCBjhB+Cm/7VVhinzDzL51bZhnrUalUaTvdr9mLYvs17gO3fShTtlxhgkiurDNZAyuKtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726758341; c=relaxed/simple;
	bh=FbVnODCWpuz/f/B2t1kMnQKdFEpGmKe69gEWRkKYW18=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mwByVDrUzoOdDAmmMEbP1HyjTT+lrYI4b7RxnysJBuRFln9k/V1d+WgabPpdUBiKmbra0bymH8/TrYHBg1FOz1dsaqUa2TDGZs2IDFQbkoIBDiRnj4PJjk50NN6QWuC7qbhK2MZ3BHA7QWZAhtkVuTmGko+8EDMZFNsZPaoRXnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cybernetics.com; spf=pass smtp.mailfrom=cybernetics.com; dkim=pass (1024-bit key) header.d=cybernetics.com header.i=@cybernetics.com header.b=DUBj3G8F; arc=none smtp.client-ip=72.215.153.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cybernetics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cybernetics.com
X-ASG-Debug-ID: 1726757536-1cf43946de32800001-xx1T2L
Received: from cybernetics.com ([10.10.4.126]) by mail.cybernetics.com with ESMTP id iAvlkS9sj23Pj4OZ; Thu, 19 Sep 2024 10:52:39 -0400 (EDT)
X-Barracuda-Envelope-From: cbing@cybernetics.com
X-Barracuda-RBL-Trusted-Forwarder: 10.10.4.126
X-ASG-Whitelist: Client
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cybernetics.com; s=mail;
	bh=gaZVIDVew6wagJ6FS+IpTt+gEV/lh5zxCO+z784EoB0=;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:Content-Language:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID; b=DUBj3G8FQDZlN2rHUh93
	RLfYvP7Ji5KFp5bns1trL77YwJQx6SHPyuXk8RwSE3n4ZUXAGZnALtF0KoAG8rvwCVcCBIzb+U7B7
	7iTuZWpEsWOOfaXk78HEG+eBhteQxvsr8ZsbhBr5ZsvBEvVMBJKAI6giZFFaCKssLwzVij0MHA=
Received: from [10.157.1.18] (HELO [192.168.184.100])
  by cybernetics.com (CommuniGate SPEC SMTP 8.0.5)
  with ESMTPS id 13588950; Thu, 19 Sep 2024 10:50:31 -0400
Message-ID: <17b25a86-2a0a-463a-8934-2607f75fedd5@cybernetics.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.157.1.18
Date: Thu, 19 Sep 2024 10:50:31 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/numa: Bump NR_NODE_MEMBLKS to MAX_NUMNODES * 4
To: Nikolay Kuratov <kniv@yandex-team.ru>, linux-kernel@vger.kernel.org
X-ASG-Orig-Subj: Re: [PATCH] x86/numa: Bump NR_NODE_MEMBLKS to MAX_NUMNODES * 4
Cc: x86@kernel.org, Borislav Petkov <bp@alien8.de>,
 Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>
References: <20240520145021.1528151-1-kniv@yandex-team.ru>
Content-Language: en-US
From: Claude Bing <cbing@cybernetics.com>
In-Reply-To: <20240520145021.1528151-1-kniv@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Barracuda-Connect: UNKNOWN[10.10.4.126]
X-Barracuda-Start-Time: 1726757559
X-Barracuda-URL: https://10.10.4.122:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at cybernetics.com
X-Barracuda-Scan-Msg-Size: 5328
X-Barracuda-BRTS-Status: 1

On 5/20/24 10:50, Nikolay Kuratov wrote:
> With modern AMD EPYC platform we're able to spot 3
> memblocks per NUMA, so bump MAX_NUMNODES multiplier
> from 2 to 4. Problem becomes apparent if MAX_NUMNODES
> close enough to real amount of nodes and leaves us with
> `too many memblk ranges` dmesg error.
> 
> Bump also maximal count of immovable regions accordingly.
> 
> Signed-off-by: Nikolay Kuratov <kniv@yandex-team.ru>
> ---
>  If overhead related to doubled arrays is too undesirable
>  maybe we should consider config option for this? It appears that
>  NR_NODE_MEMBLKS used only on LoongArch and x86 (macro in asm-generic
>  is orphane).
> 
>  arch/x86/boot/compressed/acpi.c | 6 +++---
>  arch/x86/boot/compressed/misc.h | 2 +-
>  arch/x86/include/asm/numa.h     | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
> index f196b1d1ddf8..74575a900924 100644
> --- a/arch/x86/boot/compressed/acpi.c
> +++ b/arch/x86/boot/compressed/acpi.c
> @@ -17,9 +17,9 @@
>  
>  /*
>   * Immovable memory regions representation. Max amount of memory regions is
> - * MAX_NUMNODES*2.
> + * MAX_NUMNODES*4.
>   */
> -struct mem_vector immovable_mem[MAX_NUMNODES*2];
> +struct mem_vector immovable_mem[MAX_NUMNODES*4];
>  
>  static acpi_physical_address
>  __efi_get_rsdp_addr(unsigned long cfg_tbl_pa, unsigned int cfg_tbl_len)
> @@ -305,7 +305,7 @@ int count_immovable_mem_regions(void)
>  				num++;
>  			}
>  
> -			if (num >= MAX_NUMNODES*2) {
> +			if (num >= ARRAY_SIZE(immovable_mem)) {
>  				debug_putstr("Too many immovable memory regions, aborting.\n");
>  				return 0;
>  			}
> diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
> index b353a7be380c..a756569852e5 100644
> --- a/arch/x86/boot/compressed/misc.h
> +++ b/arch/x86/boot/compressed/misc.h
> @@ -174,7 +174,7 @@ static inline acpi_physical_address get_rsdp_addr(void) { return 0; }
>  #endif
>  
>  #if defined(CONFIG_RANDOMIZE_BASE) && defined(CONFIG_MEMORY_HOTREMOVE) && defined(CONFIG_ACPI)
> -extern struct mem_vector immovable_mem[MAX_NUMNODES*2];
> +extern struct mem_vector immovable_mem[MAX_NUMNODES*4];
>  int count_immovable_mem_regions(void);
>  #else
>  static inline int count_immovable_mem_regions(void) { return 0; }
> diff --git a/arch/x86/include/asm/numa.h b/arch/x86/include/asm/numa.h
> index ef2844d69173..057eafe6fed5 100644
> --- a/arch/x86/include/asm/numa.h
> +++ b/arch/x86/include/asm/numa.h
> @@ -10,7 +10,7 @@
>  
>  #ifdef CONFIG_NUMA
>  
> -#define NR_NODE_MEMBLKS		(MAX_NUMNODES*2)
> +#define NR_NODE_MEMBLKS		(MAX_NUMNODES*4)
>  
>  extern int numa_off;
>  
Our testing confirms this patch resolves at least one case where a
quad-CPU system (Supermicro X11QPH+) only registers a single NUMA node.
Would it be possible to have this patch merged after a review?

Debug messages seen prior to applying the patch:

  ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x7fffffff]
  ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0x207fffffff]
  ACPI: SRAT: Node 0 PXM 0 [mem 0x2080000000-0x407fffffff]
  ACPI: SRAT: Node 1 PXM 1 [mem 0x4080000000-0x607fffffff]
  ACPI: SRAT: Node 1 PXM 1 [mem 0x6080000000-0x807fffffff]
  ACPI: SRAT: Node 2 PXM 2 [mem 0x8080000000-0xa07fffffff]
  ACPI: SRAT: Node 2 PXM 2 [mem 0xa080000000-0xc07fffffff]
  ACPI: SRAT: Node 3 PXM 3 [mem 0xc080000000-0xe07fffffff]
  too many memblk ranges
  ACPI: SRAT: Failed to add memblk to node 3 [mem
  0xe080000000-0x1007fffffff]
  ACPI: SRAT: SRAT not used.
  NUMA: Initialized distance table, cnt=4
  No NUMA configuration found
  Faking a node at [mem 0x0000000000000000-0x000001007fffffff]
  NODE_DATA(0) allocated [mem 0x1007fffa000-0x1007fffbfff]

After the patch, all four nodes were recognized:

  ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x7fffffff]
  ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0x207fffffff]
  ACPI: SRAT: Node 0 PXM 0 [mem 0x2080000000-0x407fffffff]
  ACPI: SRAT: Node 1 PXM 1 [mem 0x4080000000-0x607fffffff]
  ACPI: SRAT: Node 1 PXM 1 [mem 0x6080000000-0x807fffffff]
  ACPI: SRAT: Node 2 PXM 2 [mem 0x8080000000-0xa07fffffff]
  ACPI: SRAT: Node 2 PXM 2 [mem 0xa080000000-0xc07fffffff]
  ACPI: SRAT: Node 3 PXM 3 [mem 0xc080000000-0xe07fffffff]
  ACPI: SRAT: Node 3 PXM 3 [mem 0xe080000000-0x1007fffffff]
  NUMA: Initialized distance table, cnt=4
  NUMA: Node 0 [mem 0x00000000-0x7fffffff] + [mem
  0x100000000-0x207fffffff] -> [mem 0x00000000-0x207fffffff]
  NUMA: Node 0 [mem 0x00000000-0x207fffffff] + [mem
  0x2080000000-0x407fffffff] -> [mem 0x00000000-0x407fffffff]
  NUMA: Node 1 [mem 0x4080000000-0x607fffffff] + [mem
  0x6080000000-0x807fffffff] -> [mem 0x4080000000-0x807fffffff]
  NUMA: Node 2 [mem 0x8080000000-0xa07fffffff] + [mem
  0xa080000000-0xc07fffffff] -> [mem 0x8080000000-0xc07fffffff]
  NUMA: Node 3 [mem 0xc080000000-0xe07fffffff] + [mem
  0xe080000000-0x1007fffffff] -> [mem 0xc080000000-0x1007fffffff]
  NODE_DATA(0) allocated [mem 0x407fffe000-0x407fffffff]
  NODE_DATA(1) allocated [mem 0x807fffe000-0x807fffffff]
  NODE_DATA(2) allocated [mem 0xc07fffe000-0xc07fffffff]
  NODE_DATA(3) allocated [mem 0x1007fff9000-0x1007fffafff]

Tested-by: Claude Bing <cbing@cybernetics.com>

