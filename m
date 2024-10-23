Return-Path: <linux-kernel+bounces-378890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F2F9AD6C6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 23:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 143A0B230C5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 21:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6131CC144;
	Wed, 23 Oct 2024 21:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="j14LfudI"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFC4481B1
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 21:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729719136; cv=none; b=eV3lLLtmJRMN3OFna++xER2+LxUwbsluN9Z6a5bmIAwBbONZOaIXfLvHy4AU7q2M7hIIdzQQurydZeJCecp5KKBCtqQTa1oGr8LlwXdRshl8QPBWO4z6G5jBMQea8dWLDrVt8mO722KS1uWvFxMx2Cl/gVVvVDOdppaGnQbIfWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729719136; c=relaxed/simple;
	bh=kJBMUngqTwc/6QW7XYSPiHU9s03YZIKPBYasnxp6tgo=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=UfsNzNXF3FoAJJ2fpAncTt6klmSDM4YxBEf8PMzFaR7nMvFEWVGzrQJF2XhAhUUwlrmHYJ7s0x4ol1AeVBleZWlEmEyh7rt+uFdpAmE/uPZpj30ESUA3okIF1foO296JOzFd7TRoiBAWuwqFH4ep3qcTO3YgCb3HQaBKpB0swGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=j14LfudI; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [172.27.3.244] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 49NLVp4Y1410192
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 23 Oct 2024 14:31:51 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 49NLVp4Y1410192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024101701; t=1729719112;
	bh=8tEFyHawjdZYoHhrKgxfixSEdW8mWDvC1bwQ29nPWGo=;
	h=Date:To:Cc:From:Subject:From;
	b=j14LfudIur4YPCqfGGEkfvQ4jB/tGkBNhbUWI2Qnd/q3gbmjdD5sTI5kGjvRZf+mA
	 bNcKr/u6rgUtKm4A9bv0fkUMG9wRLct/YOP3rXwUQ/05zW+d6GnK/CAhCwbgcdR/iy
	 BTlEV3lpo/+75JwbkAxlYLMK5uPTzC0u4mlmUe1fEK8F4tq6Tm2EmJz/g+Vb6sNfxv
	 azriVz0g9imGObwjZ9pVPwbFCD55FgwfU0ew26wrD0fPTKN3rBZZD7jeHvZOkMfYwZ
	 ivA1bNXF3XhePdSoL6jKebg2BgmsQ8EVvULS2wPAUghYB/ArCezsbdE375+KjESkfo
	 xkUzIeYqPuSUQ==
Message-ID: <7a4de623-ecda-4369-a7ae-0c43ef328177@zytor.com>
Date: Wed, 23 Oct 2024 14:31:51 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Xin Li <xin3.li@intel.com>, Xin Li <xin@zytor.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Cc: "x86@kernel.org" <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: RFC, untested: handing of MSR immediates and MSRs on Xen
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

So the coming of WRMSRNS immediate and RDMSR immediate forms is now 
official in the latest edition (Oct 2024) of the Intel ISE document, see:

https://www.intel.com/content/www/us/en/developer/articles/technical/intel-sdm.html

I have been thinking about how to (a) leverage these instructions to the 
best effect and (b) get rid of the code overhead associated with Xen 
paravirtualization of a handful of MSRs. As it turns out, the vast 
majority of MSRs under Xen are simply passed through anyway; a handful 
(perf related) are handled differently, and a small number are ignored.

The immediate form of these instructions are primarily motivated by 
performance, not code size: by having the MSR number in an immediate, it 
is available *much* earlier in the pipeline, which allows the hardware 
much more leeway about how a particular MSR is handled.

Furthermore, we want to continue to minimize the overhead caused by the 
remaining users of paravirtualization. The only PV platform left that 
intercepts MSRs is Xen.

So, as per previous discussions what we want to do is:

- Have Xen handled by the normal alternatives patching;
- Use an assembly wrapper around the Xen-specific code;
- Allow Xen to invoke the standard error handler by adding a new
   exception intercept type: EX_TYPE_INDIRECT. This exception type
   takes a register (i.e. _ASM_EXTABLE_TYPE_REG) and then looks up
   the exception handler at the address pointed to by that register.
   This lets the Xen assembly wrapper deal with error by:

     /* let CF be set on error here (any flag condition works) */
     jc .L_error
     ret
   .L_error:
     pop %rdx	  /* Drop return address */
     sub $5,%rdx	  /* Rewind to the beginning of CALL instruction */
     1: ud2        /* Any unconditionally trapping instruction */
     _ASM_EXTABLE_TYPE_REG(1b, 1b /* unused */, EX_TYPE_INDIRECT, %rdx)

Rather than trying to explain the whole mechanism, I'm including a 
crude-and-totally-untested concept implementation for comments and 
hopefully, eventually, productization.

Note: I haven't added tracepoint handling yet. *Ideally* tracepoints 
would be patched over the main callsite instead of using a separate 
static_key() -- which also messes up register allocation due to the 
subsequent call. This is a general problem with tracepoints which 
perhaps is better handled separately.

	-hpa


	-hpa


