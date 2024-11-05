Return-Path: <linux-kernel+bounces-397241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6FD9BD8A8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 23:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA3E3B225FB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 22:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03F521643F;
	Tue,  5 Nov 2024 22:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="HChlsozM"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD03433B5
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 22:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730845703; cv=none; b=ToZ5l0PWUiK0IhGw5Aym3m33hHSfbULmjcQW2ZAXJzdrLpKVnt7s60zEwKoFkMVYD54JYVmSGyadYsI73VZjE626hFsN0uPiJD6IEqMtoVY7F4LOSfGe3CfVV0Pkimz3JuePwxzBoEEDt9DpjpF92i0oZM8YpMwqbDeg8J0AgKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730845703; c=relaxed/simple;
	bh=5l1GZ3eq9pJoL4+XRdcVTCjlrO2K599BLtz8uf88Nao=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=QOTG6Fum/FcrxJWyS94JoqY9zV0ySKHvikizx4hCo1zTS7azM/axhZ74FxQqav+seTQlQojDjB/7YWPUzwJduYqCi419WAUsJp3FzSvBeoRd1SbE3/7Ld8enWpSJXVoqR7iUZdHEWcCaY/QXRdhlILyPMeha8ExvUmAfhcG4SE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=HChlsozM; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [172.27.3.244] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 4A5MRoc9414997
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 5 Nov 2024 14:27:51 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 4A5MRoc9414997
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024101701; t=1730845672;
	bh=IH13q9iPFTI89hpznrhXCva+vUvCu42Sl1a7/K/TTAk=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=HChlsozMrvOP1l8+5N9GO+W6JSJdNeClPzJnm1LHT4mpzRjbJt6m+DX2/lbDkKj5O
	 sfiVcmysHFrEviRMc3GiEc9G/EiSBAEQuX1O++erTD1TXGLg6qO8s1/v+akVn5GAP6
	 SjNoo8kO+dyftE5HjXDQxDpxaYk8wZEWOc/vV6yW2G4k1SeL0EHMnykUwLGh47zP3Q
	 kLSYp/IibDRH/NV3bdn9Bfd+SIXBLtd59ZMT4HBg7cl5ICIKEbK50oAofCcQYc/7L9
	 UDlSexWhd34TGSkLbuTdkd8qtI+Ky97BZulRmd7T1ZJrV2YYb1xlxoMIyDh6mAlFEP
	 4HbSo1YRdV73w==
Message-ID: <88c01eea-9d0f-4cac-914b-50993cbbb3ce@zytor.com>
Date: Tue, 5 Nov 2024 14:27:50 -0800
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
 <befeb81d-234b-4e96-9966-2c0b11a78c79@zytor.com>
Content-Language: en-US
In-Reply-To: <befeb81d-234b-4e96-9966-2c0b11a78c79@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/5/24 13:58, H. Peter Anvin wrote:
> 
> Then you can just do the obvious (have your assembly stub point %rdi to 
> the base of the register dump; set the frame order to whatever you'd 
> like, except rip/err/exc, or reverse the order if you prefer by changing 
> the loop):
> 
> static inline __noreturn void die(void)
> {
>      while (1)
>          asm volatile("hlt");
> }
> 
> void dump_register_frame(const unsigned long frame[])
> {
>      static const char regnames[][5] = {
>          "rax:", "rcx:", "rdx:", "rbx:",
>          "rsp:", "rbp:", "rsi:", "rdi:",
>          "r8: ", "r9: ", "r10:", "r11:",
>          "r12:", "r13:", "r14:", "r15:",
>          "cr2:", "Exc:", "Err:", "rip:"
>      };
> 
>      for (size_t i = 0; i < ARRAY_SIZE(regnames); i++) {
>          __putstr(regnames[i]);
>          __puthex(frame[i]);
>          __putstr("\n");
>      }
> 
>      /* Only return from int3 */
>      if (frame[17] != 3)
>          die();
> }
> 

I don't know if it is necessary, but you can do something like this to 
make absolutely sure you don't end up with non-relative symbol references:

static inline __constfunc void * sym_addr(const void *sym)
{
	void *addr;
	asm("lea %c1(%%rip),%0" : "=r" (addr) : "i" (sym));
	return addr;
}


