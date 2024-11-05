Return-Path: <linux-kernel+bounces-397227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A7F9BD805
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 23:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB8171F270CE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 22:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAADB216A27;
	Tue,  5 Nov 2024 21:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="UxeSXAxP"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB7C216440
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 21:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730843957; cv=none; b=GPGK98jm/X1N51rqIQ22WtIy55Gl0gGxss0XF1wonQoUF9eXsHyoPoMmwz1eL63DK9ZME/Dn9PX7yUoZpKMULwn/n5rhUFE4lbVEiZva5GwyiCW7dho5GDQf0Ban/t6iJM6LrxEVtMxJU5//zDRqxYCmammyhIgA+V2xYsvIj64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730843957; c=relaxed/simple;
	bh=uMg0KN4eoqYyvrabydANdOCEvDhrIRJsiYw4TV/De1o=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=qd2Cnfgur/3I2DKTGWEEO7yjiGxH9+wHZxYNSCOgxUY/TOa590HmLC1ADzdN6RQK9LlL3fZubNBmhyRbtZhbWVAroU4eNE+IS4ZoGpLfYA4KYvtLqCUhp54j1Y1pIbazsYHN/KgwmbFoIgDmPuQgjnmQgQe1gb+chGfT39/SBUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=UxeSXAxP; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [172.27.3.244] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 4A5Lwedd402063
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 5 Nov 2024 13:58:41 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 4A5Lwedd402063
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024101701; t=1730843922;
	bh=2V6lRRSml+PQc28h+I3/xRbrRkRKAck28ZK8sI5GONw=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=UxeSXAxPqP6VQxiw3vIIxphOaAavmGtUaYhIs+dh//9lX7gajRr3XqZXhd0rB6kmj
	 ZSU//kHoEi/lIYJpwITEDzB6Ep2PMftaQCE8q11he7qiir92TotAl+7odiM1NMqvEI
	 tCyOKJVdCs35bYB7eM5tQPpeYH3h9RuLANih5G4nTEKVyf7FdFgIb+PmjemEdD00qs
	 k6MWaB/Xmt9D8CRoqlneT2AIJ+Hc1QBRp0fbvzOYufPSGn8P8kjJz/1X3X0lWrLxGW
	 coLcJQB270xDNMhu07myslOC/k2xmSP6ONiRgFu+faPZk8OufQJfVYfi2xEPN4TtRK
	 6zdBipzVD79Bw==
Message-ID: <befeb81d-234b-4e96-9966-2c0b11a78c79@zytor.com>
Date: Tue, 5 Nov 2024 13:58:40 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 6/7] x86/kexec: Debugging support: Dump registers on
 exception
From: "H. Peter Anvin" <hpa@zytor.com>
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
 <b66cd5ca-aae4-48eb-a0ba-2d1d4e53f810@zytor.com>
Content-Language: en-US
In-Reply-To: <b66cd5ca-aae4-48eb-a0ba-2d1d4e53f810@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/5/24 13:37, H. Peter Anvin wrote:
> What is the point of writing this code in assembly in the first place? A 
> much more logical thing to do is to just push the registers you haven't 
> pushed already onto the stack and call a C function to do the actual 
> dumping? It isn't like it is in any shape, way or form performance 
> critical.

arch/x86/boot/compressed/misc.c has some code that you can crib, both 
for writing to a text screen (not that useful anymore with EFI 
framebuffers) and serial port. If you factor it a little bit then you 
can probably even share the code directly.

(__putstr perhaps should have a __putchar() factored out of it?)

Then you can just do the obvious (have your assembly stub point %rdi to 
the base of the register dump; set the frame order to whatever you'd 
like, except rip/err/exc, or reverse the order if you prefer by changing 
the loop):

static inline __noreturn void die(void)
{
	while (1)
		asm volatile("hlt");
}

void dump_register_frame(const unsigned long frame[])
{
	static const char regnames[][5] = {
		"rax:", "rcx:", "rdx:", "rbx:",
		"rsp:", "rbp:", "rsi:", "rdi:",
		"r8: ", "r9: ", "r10:", "r11:",
		"r12:", "r13:", "r14:", "r15:",
		"cr2:", "Exc:", "Err:", "rip:"
	};

	for (size_t i = 0; i < ARRAY_SIZE(regnames); i++) {
		__putstr(regnames[i]);
		__puthex(frame[i]);
		__putstr("\n");
	}

	/* Only return from int3 */
	if (frame[17] != 3)
		die();
}


