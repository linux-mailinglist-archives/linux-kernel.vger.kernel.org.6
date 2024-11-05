Return-Path: <linux-kernel+bounces-397248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 616959BD93C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 23:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6767B223EB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 22:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D7A21644F;
	Tue,  5 Nov 2024 22:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="eo6NVK9j"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA3A1F80C4
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 22:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730847481; cv=none; b=pS1UwieABr97EIY9EEMDnrfrP7xvyIcM47ngdnMs8hFhflgpIlVObzL5U89aUj80BSuE/0t7BM3X4yRyNpB8903S7pEnZ/j9mVmlHi5GJYQ2bZuajoCCLLYO97wH20JOn/BfoL3N9RAX5fjiHwWQRxnhM20k+9/hCZU1dg4yRE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730847481; c=relaxed/simple;
	bh=oRKY3pJgwUoPtyHVvYXKZKyUSjmfkmtl+U6JscCFE7Q=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=WSW/s+wskORiDJafKOIeIKp4PukTT+0VLcYcXiNYIvSdSWvbyEtv42VT5n07xfAMu2Vwl5f53/lYh7e/Xs4WDMjAA9MsSMiZ5OTNry0XRVtTI9H7I7CpZ9l8jCI2kzimc3BwEhIR9cymzqxFr5vz2MTogYtcYDhWT4r4Y9yHUDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=eo6NVK9j; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [172.27.3.244] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 4A5MvSdh424848
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 5 Nov 2024 14:57:28 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 4A5MvSdh424848
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024101701; t=1730847450;
	bh=FxTpXSTQa9JsCRn1p6lVgcE0xkUvR08XuNrFIpNz3kg=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=eo6NVK9jCY9J0ahyD46pfe20rkRWwCv3gYYK9no9YYO75yZQwG0KXsDvzIlzn2t+Y
	 sJsRzkedETZLV47rytFOOM+htDCKqVGHXUrvuaKISN3n3Tbjh3MSiN/3EdFV72eK+i
	 dOvOCFw6qI9qW3GNFvN7zEBEChBaBeyWnd9ZyqpBX/Vbwn53ssIcrXuAeTXmGDfz3E
	 4SAyfFwmkoJaQ8Zxg9bFMu/MnsabftcqrbWeRaL4AyGEq0qaldV+4noXc6b+NoWYte
	 F1HjHM2G7LkMlwUQwSC7rkmvFGbb2fVZMX91Ai+bnJ7padfBVs3nDL6yW8+B32J/te
	 9DvbzHydENhjQ==
Message-ID: <3a91abd7-5edd-4f4e-bb15-fb9c91f64cc9@zytor.com>
Date: Tue, 5 Nov 2024 14:57:28 -0800
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
 <88c01eea-9d0f-4cac-914b-50993cbbb3ce@zytor.com>
Content-Language: en-US
In-Reply-To: <88c01eea-9d0f-4cac-914b-50993cbbb3ce@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/5/24 14:27, H. Peter Anvin wrote:
> 
> I don't know if it is necessary, but you can do something like this to 
> make absolutely sure you don't end up with non-relative symbol references:
> 
> static inline __constfunc void * sym_addr(const void *sym)
> {
>      void *addr;
>      asm("lea %c1(%%rip),%0" : "=r" (addr) : "i" (sym));
>      return addr;
> }
> 

Compiling with "-fpic -fvisibility=hidden -mcmodel=medium" can also be 
used to suppress non-relative references. If you have external symbol 
references they at least *should* be emitted as GOTPCRELX relocations 
which the linker should relax to relative references; however, I would 
think that you really don't want any of those :)

	-hpa


