Return-Path: <linux-kernel+bounces-519307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 247EBA39B62
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 12:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DB091894938
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 11:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6853723ED7E;
	Tue, 18 Feb 2025 11:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NBaxtDmt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P/+tbWof"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1C7154C12
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 11:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739879342; cv=none; b=RbAONAHopZSphRDlbgfpkNRvmRbYOXCv1fFasmqqFGw/4o1cJ3OaTx2QPKGi5NyYyI1E/P0L7J1ZdxyrsIBakqQPrZhcHGmKPSlOYcJha7gSvCtjSX03XRqE0kPBIagb6S7cjUOc4wNt5k39BjrNzE0T0Rg8zrbMDS2KFXg8XGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739879342; c=relaxed/simple;
	bh=/Agu9UZpwMOMJa/3V+RSlri5QH5zzp8ZBK1cBmLTLoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SffHmeAuu0nqBhfHkdH+hG9XxSZQBXPYCeFyiZyec2FdzqITYM/4/I43mDx9j4aHzHZoXLoSKdwHEUKJIC2eWOob82mEb5zMJUC6agvomygrgsPVAeQno41JvZwIYT5Py7NXKVE4fnz1BNb8eSPYxYwR6sdykfCtv/eYBr324Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NBaxtDmt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P/+tbWof; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 12:48:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739879338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qIaFQ7eiwfJAitD6oNiQEj86aF61YiHuAPe8K1OOpj8=;
	b=NBaxtDmtb+spYi6lePNzYrF6Jffsk/v4UWZ3qOJcnDYl5OJl/O8keUrE62Jp4jp0v327rk
	ieWoz/ZDAdkOAZhz4xsc7YIN5R4ZdT7EKsLoSvjOTz9wpWnTE9TQzBDjewGA1+cUzPC7Bc
	eqCDmlGt8W5xkDAb0kA3itdQsgTGm3Ra3/p+cO4Npy5QC+W498mM+/CA0NxAmGEQyEOs0h
	wlrKXnXqSSecuesNBeHaaW474Mm7Qd0Iej59FNUFTSW4M59WdNeiTaf3xpUEjtSu61JhBZ
	4a8V+2TtEeGA18gYFcGw/FjBYXG5l5oDJH4JD68Lk350oQa3Z1UsimEGRjyFuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739879338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qIaFQ7eiwfJAitD6oNiQEj86aF61YiHuAPe8K1OOpj8=;
	b=P/+tbWof/LxaNkv2NFJl6hxfQ1PcNdd8y1G2WSzIqMn5b2ku4tAPmIei7KDchpHB7LHQJU
	cUdcqu863Tqc+LAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: kernel test robot <lkp@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: ERROR: modpost: "kmsan_handle_dma"
 [drivers/virtio/virtio_ring.ko] undefined!
Message-ID: <20250218114857.oBuLvPYs@linutronix.de>
References: <202502150634.qjxwSeJR-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <202502150634.qjxwSeJR-lkp@intel.com>

On 2025-02-15 06:42:36 [+0800], kernel test robot wrote:
> >> arch/x86/kvm/cpuid.o: warning: objtool: do_cpuid_func+0x2428: undefine=
d stack state

I have been staring at this and have no idea what to do. I get here:
| arch/x86/kvm/cpuid.o: warning: objtool: do_cpuid_func+0x21e1: undefined s=
tack state

The assembly at this spot looks as from the .o:
|   110e4:       e8 00 00 00 00          call   110e9 <do_cpuid_func+0x21d9>
|                        110e5: R_X86_64_PLT32   __msan_metadata_ptr_for_lo=
ad_4-0x4
|   110e9:       44 8b 38                mov    (%rax),%r15d
|   110ec:       48 85 db                test   %rbx,%rbx
|   110ef:       8b 1a                   mov    (%rdx),%ebx
|   110f1:       4c 8b 64 24 18          mov    0x18(%rsp),%r12
^^^ do_cpuid_func+0x21e1

|   110f6:       0f 85 72 01 00 00       jne    1126e <do_cpuid_func+0x235e>
|   110fc:       41 83 e7 fe             and    $0xfffffffe,%r15d
|   11100:       48 89 ef                mov    %rbp,%rdi
|   11103:       e8 00 00 00 00          call   11108 <do_cpuid_func+0x21f8>
|                        11104: R_X86_64_PLT32   __msan_metadata_ptr_for_st=
ore_4-0x4

I've been looking at .s file but this does not realy match the .o. The
registers are different, the offsets, too.
Anyway.

Looking at the opcodes it was processing "recently":
base: 4, offset 1109d Dest: 0 Src: 5 lea    0x10(%r14),%rax
base: 4, offset 110a1 Dest: 1 Src: 0 mov    %rax,0x20(%rsp)
base: 4, offset 110ae Dest: 0 Src: 0 mov    %rsp,%r8
base: 4, offset 1124b Dest: 0 Src: 1 mov    0x20(%rsp),%rsi
base: 4, offset 11253 Dest: 0 Src: 1 mov    0x8(%rsp),%rcx
base: 4, offset 11258 Dest: 0 Src: 0 mov    %r15,%rsp
-> set UNDEF
base: -1, offset 110f1 -> mov    0x18(%rsp),%r12
arch/x86/kvm/cpuid.o: warning: objtool: do_cpuid_func+0x21e1: undefined sta=
ck state 110f1

=46rom the assembly it seems to make sense:
|   110ae:       49 89 e0                mov    %rsp,%r8
stash for later
|   110b1:       48 85 db                test   %rbx,%rbx
|   110b4:       c7 00 00 00 00 00       movl   $0x0,(%rax)
|   110ba:       45 89 7e 14             mov    %r15d,0x14(%r14)
|   110be:       0f 85 40 01 00 00       jne    11204 <do_cpuid_func+0x22f4>
=E2=80=A6
|   11204:       44 8b 74 24 38          mov    0x38(%rsp),%r14d
|   11209:       44 89 f7                mov    %r14d,%edi
|   1120c:       4d 89 c7                mov    %r8,%r15

mov rsp to r15

|   1120f:       e8 00 00 00 00          call   11214 <do_cpuid_func+0x2304>
|                        11210: R_X86_64_PLT32   __msan_chain_origin-0x4
|   11214:       89 c7                   mov    %eax,%edi
|   11216:       e8 00 00 00 00          call   1121b <do_cpuid_func+0x230b>
|                        11217: R_X86_64_PLT32   __msan_warning-0x4
|   1121b:       44 89 f7                mov    %r14d,%edi
|   1121e:       e8 00 00 00 00          call   11223 <do_cpuid_func+0x2313>
|                        1121f: R_X86_64_PLT32   __msan_chain_origin-0x4
|   11223:       89 c7                   mov    %eax,%edi
|   11225:       e8 00 00 00 00          call   1122a <do_cpuid_func+0x231a>
|                        11226: R_X86_64_PLT32   __msan_warning-0x4
|   1122a:       44 89 f7                mov    %r14d,%edi
|   1122d:       e8 00 00 00 00          call   11232 <do_cpuid_func+0x2322>
|                        1122e: R_X86_64_PLT32   __msan_chain_origin-0x4
|   11232:       89 c7                   mov    %eax,%edi
|   11234:       e8 00 00 00 00          call   11239 <do_cpuid_func+0x2329>
|                        11235: R_X86_64_PLT32   __msan_warning-0x4
|   11239:       44 89 f7                mov    %r14d,%edi
|   1123c:       e8 00 00 00 00          call   11241 <do_cpuid_func+0x2331>
|                        1123d: R_X86_64_PLT32   __msan_chain_origin-0x4
|   11241:       89 c7                   mov    %eax,%edi
|   11243:       e8 00 00 00 00          call   11248 <do_cpuid_func+0x2338>
|                        11244: R_X86_64_PLT32   __msan_warning-0x4
|   11248:       4c 89 ef                mov    %r13,%rdi
|   1124b:       48 8b 74 24 20          mov    0x20(%rsp),%rsi
|   11250:       4c 89 e2                mov    %r12,%rdx
|   11253:       48 8b 4c 24 08          mov    0x8(%rsp),%rcx
|   11258:       4c 89 fc                mov    %r15,%rsp

restore rsp. I just don't see how rsp is destroyed but this could be
related to paravirt's xxl clobbing in__cpuid().

I miss 1120c in my output. I don't understand how it jumps from 110ae to
1124b. It misses the assignments in between but this might not be goal
here=E2=80=A6

gcc does not cause objtool to produce the warning but then gcc does
shuffle rsp as much as llvm does.

Sebastian

