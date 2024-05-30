Return-Path: <linux-kernel+bounces-195007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 239A68D4618
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 09:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4FC81F204E0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 07:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47559143720;
	Thu, 30 May 2024 07:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="pnvtxLPo"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7945C7407D;
	Thu, 30 May 2024 07:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717054062; cv=none; b=Kq5I/L3CM7/gaWkp3B19Rj2IRpR2GScSzb1tCOofq2q+3UxmrjvziXFZp8U4XTlLFFANjplry/CvMFpRvorCeyUPOYzoeqgsTF+nI9igLop80e7l/s8BcP682vdwh3hLgBttca84TH9Q8L1T5bJQS7sL8LC9QHjgsJi59ryR2JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717054062; c=relaxed/simple;
	bh=O8AHpX5IpgZrQ5DBIEjmSIJjPbIByFjGSlJzd9IlnNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LENviQH3DGJYgJXD7Y43JIMidCoLaCTXeNnUvXTBsZgNnkkPZjgdoMSKmf7VIdNyPj6aRYY79oyosHahF7vLOmgctJ24VsNVFhGeEix/fwcoKk9lE2s2r99P2B/xrz+LwOmpkfexTT0fszjfBAoPBrStmIScCuVrCPEXjGm2fYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=pnvtxLPo; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=J9EIxHlBMwuMm3cDceJb/8aeH1kbcupDUVTcaKgaWKA=;
	t=1717054060; x=1717486060; b=pnvtxLPog3Sq4Oercy7eexmBtdhiKgUu75FPVt0TFu768el
	XnT8fEwBqqs73/N1FXkR44x5mnoO/rjS0G7/qstlpVIMVuTRFZXkDmkEgjfLQwCiwvJXeWH6E1mJ0
	IZRdbPP4RJQcBgK78tPB9wFjuGUAmd2BSsCjyCZ1786Yivsdl0+vjZU3ZctcHWgKCCcN4sStp+PZt
	NVCwi04XzL8NED0PjQl321cHbDSPN6f5jCYDA3+DgUgtDlkgesJCAX088fAkOtyMofmOTJ9JaP7M+
	FFJkTtyoAYtVxGfedAyPcwakOfRPNN2VUo5iV98eFMiugtIlLhs7ExlBhTTc/qPA==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sCaCE-0000co-WF; Thu, 30 May 2024 09:27:35 +0200
Message-ID: <4611b3c8-0ef6-4951-8b34-10a1c7262355@leemhuis.info>
Date: Thu, 30 May 2024 09:27:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] commit fbf6449f84bf5e4ad09f2c09ee70ed7d629b5ff6
 (Linux 6.7+) crashes during boot
To: =?UTF-8?Q?J=C3=B6rn_Heusipp?= <osmanx@heusipp.de>,
 linux-kernel@vger.kernel.org
Cc: regressions@lists.linux.dev, x86@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Adam Dunlap <acdunlap@google.com>, 1071378@bugs.debian.org
References: <ebb0791c-60a5-4fe3-bc85-4921ad026605@heusipp.de>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <ebb0791c-60a5-4fe3-bc85-4921ad026605@heusipp.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1717054060;7d2dc0e2;
X-HE-SMSGID: 1sCaCE-0000co-WF

On 30.05.24 08:55, Jörn Heusipp wrote:
> 
> Hello x86 maintainers!
> 
> commit fbf6449f84bf5e4ad09f2c09ee70ed7d629b5ff6 ("x86/sev-es: Set
> x86_virt_bits to the correct value straight away, instead of a two-phase
> approach") crashes during boot for me on this 32bit x86 system.

FWIW, not my area of expertise, but there is a patch from Dave with a
Fixes: tag for your culprit up for review:
https://lore.kernel.org/all/20240517200534.8EC5F33E@davehans-spike.ostc.intel.com/

Ciao, Thorsten

> Updating a Debian testing system resulted in a hang during boot before
> printing anything, with any 6.7 or later kernel. With 'earlyprintk=vga',
> I managed to capture the crash on video and stitched it together as an
> image [1].
> Trimmed transcription (might contain typos) of the crash from Debian
> kernel 6.7.12-1:
> ===
> BUG: kernel NULL pointer dereference, address: 00000010
> #PF: supervisor write access in kernel mode
> #PF: error_code(0x0002) - not-present page
> Oops: 0002 [#1] PREEMPT SMP NOPTI
> [...]
> EIP: __ring_buffer_alloc+0x32/0x194
> [...]
> show_regs
> __die
> page_fault_oops
> kernelmode_fixup_or_oops.constprop
> __bad_area_nosemaphore.constprop
> bad_area_nosemaphore
> do_user_addr_fault
> prb_read_valid
> exc_page_fault
> pvclock_clocksource_read_nowd
> handle_exception
> pvclock_clocksource_read_nowd
> __ring_buffer_alloc
> pvclock_clocksource_read_nowd
> __ring_buffer_alloc
> early_trace_init
> start_kernel
> i386_start_kernel
> startup_32_smp
> [...]
> ===
> I could transcribe all of it or capture it again from latest git and
> decode the symbols, if truely really needed, but I figured the type of
> crash and the trace itself could maybe be sufficient. It looks identical
> to me for all later crashing kernel versions.
> 
> I bisected this down to commit fbf6449f84bf5e4ad09f2c09ee70ed7d629b5ff6.
> 
> The kernel config [2] I used is 'make olddefconfig' based on Debian's
> config-6.8.11-686-pae [3].
> 
> I also tested 6.9.2 and 6.10-rc1, both also still crash in the same way.
> 
> cpuinfo:
> ===
> manx@caesar:~$ cat /proc/cpuinfo
> processor       : 0
> vendor_id       : AuthenticAMD
> cpu family      : 6
> model           : 8
> model name      : AMD Duron(tm)
> stepping        : 1
> cpu MHz         : 1798.331
> cache size      : 64 KB
> physical id     : 0
> siblings        : 1
> core id         : 0
> cpu cores       : 1
> apicid          : 0
> initial apicid  : 0
> fdiv_bug        : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 1
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
> mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow cpuid
> 3dnowprefetch vmmcall
> bugs            : fxsave_leak sysret_ss_attrs spectre_v1 spectre_v2
> spec_store_bypass
> bogomips        : 3596.66
> clflush size    : 32
> cache_alignment : 32
> address sizes   : 34 bits physical, 32 bits virtual
> power management: ts
> ===
> 
> dmesg from a successful boot (Debian kernel 6.6.15-2) is here [4].
> 
> This particular system has been running all Debian testing kernels since
> at least the 2.6.32 days and is currently running 6.6.15-2 completely
> fine, thus this is an obvious regression.
> 
> The original Debian bug is #1071378 [5].
> 
> 
> #regzbot introduced: fbf6449f84bf5e4ad09f2c09ee70ed7d629b5ff6
> 
> [1] https://manx.datengang.de/temp/linux-6.7-crash/6.7.12-1-crash.png
> [2] https://manx.datengang.de/temp/linux-6.7-crash/config
> [3] https://manx.datengang.de/temp/linux-6.7-crash/config-6.8.11-686-pae
> [4] https://manx.datengang.de/temp/linux-6.7-crash/dmesg-6.6.15-2.txt
> [5] https://bugs.debian.org/1071378
> 
> 
> Best regards,
> Jörn
> 
> 

