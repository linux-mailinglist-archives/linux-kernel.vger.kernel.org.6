Return-Path: <linux-kernel+bounces-397181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 192429BD7BC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 22:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC8171F23869
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 21:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526EB215F52;
	Tue,  5 Nov 2024 21:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="s2V7ohyX"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECD0383
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 21:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730842662; cv=none; b=pEYhZzLE7wM9NbT9FI8zFxpqEsJOPgzv+CU10ALqAIvNJreqWWO7G2/W0pAarGY7yRtz4yjP/f/Cp2zgloiVAfNArx8bc6FNHt1nZNWzZvA7wsQSBDv8DS9gVkKiTnBvzDXHLcAye0Nai/jfsOgLscW7eUUuzIpowSojLcuNzuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730842662; c=relaxed/simple;
	bh=iDx70iG3SButOMhlgqZ2/dg7lvsXt2b4SbgJ4ViyDSA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r9v6fAxDWY3WD+bm2j9RyhJc2yX0ZNo/hPAzQ9EFsnt1UFFg3RNjocdZfMMFE2STelNiaXtCa/cvqL/6QjxqhyLQo5uVMevSmZS/04E/Uppi9VkZw0cS7TEFW+XduPHWcDKge1Q0f0nY/qMlt58xQdwz/5La2O9DnaPE2atlVYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=s2V7ohyX; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [172.27.3.244] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 4A5Lb2rA394145
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 5 Nov 2024 13:37:03 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 4A5Lb2rA394145
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024101701; t=1730842624;
	bh=gVNz4z0YQjtXd1WB/AEasi4Rhq+Td1PSdtdB5FjTHlk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=s2V7ohyXGEeGmyrhjDFLDX29Vc8YfP3+0uZqjIuHFLdRCDgN/KgwsS8vkj4k7IeGa
	 YuoJfmGbkVPOO5LSWWXW/NPSJzN759FXDxTuB4YUL1Zbhn+uVZcGHbHmjYnHgS1C5g
	 VBDRsAHR09NzmbXI9ApgTpXjY1PZScQPKQvyEjf8hUt7NOZ8zAWCNqyDyl10sVF4bk
	 vc1HbVknPmu0hH4vDNDl5aPKtkJzYAGUNmChtAtgFSdORczfEA2ftnKdDnB3yBlv5F
	 Z9EX/eRZ2R/9uZR/AN6jNTIJIe5Np/U1G+E2SZVBU9pGbaGZN6PezpkHUaZWcI5kmJ
	 hCr3aGoSXTeNw==
Message-ID: <b66cd5ca-aae4-48eb-a0ba-2d1d4e53f810@zytor.com>
Date: Tue, 5 Nov 2024 13:37:02 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 6/7] x86/kexec: Debugging support: Dump registers on
 exception
To: "Woodhouse, David" <dwmw@amazon.co.uk>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>
Cc: "horms@kernel.org" <horms@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "kai.huang@intel.com" <kai.huang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "nik.borisov@suse.com" <nik.borisov@suse.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
References: <20241103054019.3795299-1-dwmw2@infradead.org>
 <20241103054019.3795299-7-dwmw2@infradead.org>
 <230aacb0ca0d57581f9350f96390933646f203e4.camel@amazon.co.uk>
Content-Language: en-US
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <230aacb0ca0d57581f9350f96390933646f203e4.camel@amazon.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/5/24 12:38, Woodhouse, David wrote:
> On Sun, 2024-11-03 at 05:35 +0000, David Woodhouse wrote:
>>
>> +
>> +/* Print the byte in %bl, clobber %rax */
>> +SYM_CODE_START_LOCAL_NOALIGN(pr_byte)
>> +       movb    %bl, %al
>> +       nop
>> +       andb    $0x0f, %al
>> +       addb    $0x30, %al
>> +       cmpb    $0x3a, %al
>> +       jb      1f
>> +       addb    $('a' - '0' - 10), %al
>> +1:     pr_char
>> +       ANNOTATE_UNRET_SAFE
>> +       ret
>> +SYM_CODE_END(pr_byte)
>> +
> 
> Obviously that function name (and comment) are wrong; fixed in my tree.
> at
> https://git.infradead.org/users/dwmw2/linux.git/shortlog/refs/heads/kexec-debug
> 
> This function (and also pr_qword) are also what objtool is complaining
> about:
> 
> vmlinux.o: warning: objtool: relocate_range+0x2f6: unreachable instruction
> vmlinux.o: warning: objtool: relocate_range+0x305: unreachable instruction
> 
> I don't quite see why, because pr_qword() quite blatantly calls
> pr_nyblle(), as it's now named. And exc_handler() repeatedly calls
> pr_qword().
> 
> But most of the objtool annotations I've added here were just to make
> it shut up and build, without much though. Peter, Josh, any chance you
> can help me fix it up please?
> 
> It would also be really useful if objtool would let me have data inside
> a "code" segment, without complaining that it can't decode it as
> instructions — and without also failing to decode the first instruction
> of the *subsequent* function. I've put the GDT at the end to work
> around that, but it's a bit nasty.
> 

Looking at your code, you have a much bigger problem here:

+/*
+ * This allows other types of serial ports to be used.
+ *  - %al: Character to be printed (no clobber %rax)
+ *  - %rdx: MMIO address or port.
+ */
+.macro pr_char
+       outb    %al, %dx
+.endm
+

This will overflow your UART buffer very quickly since you are now 
dumping a whole bunch of data. The URT buffer -- if you even have one 
and it is enabled -- is only 16 bytes in a standard 16550A UART. In 
older UARTs (or emulated older UARTs) you might not have a buffer at 
all. To print more than a handful of bytes, you need to poll for the 
THRE bit=1 (bit 5 of register 5).

What is the point of writing this code in assembly in the first place? A 
much more logical thing to do is to just push the registers you haven't 
pushed already onto the stack and call a C function to do the actual 
dumping? It isn't like it is in any shape, way or form performance critical.

	-hpa


