Return-Path: <linux-kernel+bounces-225489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC73A91312B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 02:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F4471F22D6B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 00:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C0010F1;
	Sat, 22 Jun 2024 00:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="nJhUUIL2"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A13763E
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 00:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719016344; cv=none; b=IxmI1kJHCXm1iChk5fDBNw9uy7bjRcL0OZeelt1k5FXZRlfkwurUovhz63kEEQyA1pqDsHeUInf6/WawM9h8uaw+B29i0m48vw4o5Ij1hMm0uhyhxiGbvm575J2L+2IGMdVtVzp2H6oMIPgDLd8e+9N45EBlUwQoAhVLkP+PV1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719016344; c=relaxed/simple;
	bh=24/di/nQEB80I+4mmVpG4wYUtwjFONBgqLcDMtWGie0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gjUYhZJxzbhMcVK9I/VKwRC/OtgA6hOA4sIpHElSYVmCMKaVD2wzqCxoMtgrqqiSqrwOoO1W+vfI/LZwSGHsc9B+5pG2rvsrgStV0GqNA1sZiTBgvASQIy0DTQxuaG5nZkYoIbMF9laB9MA/b3jc8YZl6ujgI0Bg7lnRgj1S/Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=nJhUUIL2; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [192.168.7.205] ([71.202.166.45])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 45M0VQAF3462277
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 21 Jun 2024 17:31:27 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 45M0VQAF3462277
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024061501; t=1719016289;
	bh=z+z8Oe9/SZ+Fl9R7KW8seIScjfZQWA1FIQve8M4KgBY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nJhUUIL2NVCGZDwb2MRwBG9QztxI5Wd9p6Lb+omb6dd6sY8ehZQa0Gfql/q7Oe2FY
	 FPft7XLl5/XSS50HEZCIIqXf82wlMnBURAR2wFgSjFqUjM5/wn8eQ0Yv0KFP993AFH
	 kYfLgPo737dG8fwXq0XyJYLh5jIoQw/nGEHkElr+ymp4pzq5/G5talDGquypbfQFam
	 lGdqAGjzQZyEfRraGGAYnPYecfqMov7gy72hXitQbsaP4pLdfNNUItxGWGNVpscYvJ
	 k04KX1NXW/3eWg24nq5xRS8OuEVEgNvHuiZorRyDK1bhvyGhMwmqBNxZwkFaczcM3D
	 N/TRrTFkt61hw==
Message-ID: <58ec98bf-b66c-4249-8a10-ff254cd405c2@zytor.com>
Date: Fri, 21 Jun 2024 17:31:26 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] x86/fred: Fix two problems during the FRED
 initialization
To: Hou Wenlong <houwenlong.hwl@antgroup.com>, linux-kernel@vger.kernel.org
Cc: Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Xin Li
 <xin3.li@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
References: <cover.1718972598.git.houwenlong.hwl@antgroup.com>
Content-Language: en-US
From: Xin Li <xin@zytor.com>
Autocrypt: addr=xin@zytor.com; keydata=
 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
 l75w1xInsg==
In-Reply-To: <cover.1718972598.git.houwenlong.hwl@antgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/21/2024 6:12 AM, Hou Wenlong wrote:
> When I reviewed the FRED code and attempted to implement a FRED-like
> event delivery for my PV guest, I encountered two problems which I may
> have misunderstood.

Hi Wenlong,

Thanks for bringing the issues up.

> 
> One issue is that FRED can be disabled in trap_init(), but
> sysvec_install() can be called before trap_init(), thus the system
> interrupt handler is not installed into the IDT if FRED is disabled
> later. Initially, I attempted to parse the cmdline and decide whether to
> enable or disable FRED after parse_early_param(). However, I ultimately
> chose to always install the system handler into the IDT in
> sysvec_install(), which is simple and should be sufficient.

Which module with a system vector gets initialized before trap_init() is
called?

> Another problem is that the page fault handler (exc_page_fault()) is
> installed into the IDT before FRED is enabled. Consequently, if a #PF is
> triggered in this gap, the handler would receive the wrong CR2 from the
> stack if FRED feature is present. To address this, I added a page fault
> entry stub for FRED similar to the debug entry. However, I'm uncertain
> whether this is enough reason to add a new entry. Perhaps a static key
> may suffice to indicate whether FRED setup is completed and the handler
> can use it.

How could a #PF get triggered during that gap?

Initialization time funnies are really unpleasant.

Thanks!
     Xin

