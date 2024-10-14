Return-Path: <linux-kernel+bounces-364448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED9C99D4C7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 18:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1344EB232B9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 16:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A293D1BDAB9;
	Mon, 14 Oct 2024 16:35:51 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9711A1B85D7
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 16:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728923751; cv=none; b=YYqalDtp7JM2YJcIURz5dt+zsX27S9qRHCZdxXEkQconke84R1x5gfXCfAORJ1jtwR9O04lqkRetRhAU7N1tFVuBAUlyVr6POjKkG8cyVlwmN3s9nvWUfqCSJHXrywUYfE3N3U7LpZmSm5xtIOYIf3KNuuNUyA6R4+K9g5gI7u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728923751; c=relaxed/simple;
	bh=d173Jk96NCJr1l+5dnAPhO3yiGJFo0DF39NFHAaWTRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OcSavMy8zWP3n1sU41BGS30t6nQZG9f2G8fqyQmnSEaNDqSJlT8IJXD/0Y3h9VJ1vOKcsIoWE7tUCLDOuxmHZT9j4UyoEgnn9+3MlQFv57N34v+vKgevTrI5pDBqDswJbS9DNvvJRdEYQwvn7UB1hI71QRfRo836YZyffDu22Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4XS2sV0NNfz9sPd;
	Mon, 14 Oct 2024 18:35:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id buVrh9wG_YJs; Mon, 14 Oct 2024 18:35:41 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4XS2sT65Hrz9rvV;
	Mon, 14 Oct 2024 18:35:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id BA8588B766;
	Mon, 14 Oct 2024 18:35:41 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id H0wbCbiFQOXZ; Mon, 14 Oct 2024 18:35:41 +0200 (CEST)
Received: from [192.168.233.7] (POS169783.IDSI0.si.c-s.fr [192.168.233.7])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id E17658B764;
	Mon, 14 Oct 2024 18:35:39 +0200 (CEST)
Message-ID: <615e9d81-dac8-41de-9831-5792bdb3f3bf@csgroup.eu>
Date: Mon, 14 Oct 2024 18:35:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-next:master] [x86/module] 6661cae1aa:
 WARNING:at_arch/x86/mm/pat/set_memory.c:#__cpa_process_fault
To: Mike Rapoport <rppt@kernel.org>, Dave Hansen <dave.hansen@intel.com>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
 lkp@intel.com, Linux Memory Management List <linux-mm@kvack.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Andreas Larsson <andreas@gaisler.com>, Andy Lutomirski <luto@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@quicinc.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Christoph Hellwig <hch@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Dinh Nguyen
 <dinguyen@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Guo Ren <guoren@kernel.org>, Helge Deller <deller@gmx.de>,
 Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Matt Turner <mattst88@gmail.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Michal Simek <monstr@monstr.eu>, Oleg Nesterov <oleg@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Peter Zijlstra <peterz@infradead.org>,
 Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>,
 Song Liu <song@kernel.org>, Stafford Horne <shorne@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Thomas Gleixner <tglx@linutronix.de>, Uladzislau Rezki <urezki@gmail.com>,
 Vineet Gupta <vgupta@kernel.org>, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org
References: <202410111408.8fe6f604-lkp@intel.com>
 <ZwkjPKKxRKUoJuOE@kernel.org>
 <73d5a6ed-da3c-448e-8cf8-6abb59cb2c36@intel.com>
 <ZwlG9NENb3GWT8Ea@kernel.org>
 <f2af0c30-c7d7-472d-9aa3-ffa311b2e777@intel.com>
 <ZwuCLKivIJkB7aza@kernel.org>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <ZwuCLKivIJkB7aza@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 13/10/2024 à 10:17, Mike Rapoport a écrit :
> On Fri, Oct 11, 2024 at 09:30:33AM -0700, Dave Hansen wrote:
>> On 10/11/24 08:40, Mike Rapoport wrote:
>>> On Fri, Oct 11, 2024 at 07:00:01AM -0700, Dave Hansen wrote:
>>>> On 10/11/24 06:08, Mike Rapoport wrote:
>>>>> This patch disables ROX caches on 32-bit, it should fix the issue.
>>>> While I'm not going to shed a tear for 32-bit, what's the actual
>>>> compatibility issue with 32-bit?
>>>  From the stack trace it looks like execmem tries to update the direct map
>>> for highmem memory, and cpa is not happy about it.
>>
>> First of all, if it's a highmem problem, shouldn't the check be for
>> CONFIG_HIGHMEM and not on 32-bit vs. 64-bit?  We do have non-highmem
>> 32-bit configs.
> 
> 32 bit also does not have ARCH_HUGE_VMALLOC and execmem cache will be
> anyway populated with 4k pages, so I don't see why it would be useful on 32
> bit all.
>   

Are you talking about X86 only or any architecture ?

On powerpc we have:

arch/powerpc/Kconfig:   select HAVE_ARCH_HUGE_VMALLOC           if 
HAVE_ARCH_HUGE_VMAP
arch/powerpc/Kconfig:   select HAVE_ARCH_HUGE_VMAP              if 
PPC_RADIX_MMU || PPC_8xx

PPC_8xx is 32 bits.

Christophe

