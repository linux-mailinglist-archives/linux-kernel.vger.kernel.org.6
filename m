Return-Path: <linux-kernel+bounces-363307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 261A599C060
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 08:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 494B11C22522
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 06:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E3F144304;
	Mon, 14 Oct 2024 06:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="cFIafSMD"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F1A14600F
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 06:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728888629; cv=none; b=QoMIPwx2sNAgvm6eT8JjRYfhRsVKR/X62+6PhicCznBR+j0EF8Jv297Ktzof37J6V2qi4jvHUY/OoxJdSqNt08IA6MqvfrusMzd874xXu+8aju9a37BuuJboQih3NOtCpd5P98sTlgOIg37cmZ+WAbL+IX2oRSCLLkdV0OIE6u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728888629; c=relaxed/simple;
	bh=qJF+kpQrONvE39M3qR5kHo2W0/05cB7CFCdC9OtQgQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tUFMbAC0L8UoyzYYHsZu8B0q/+Ht0XYDk1wvkiSBo1R7gHkEIfh2Bqu1yAYrIdyNkpYkoPNKZID0E/O/8IxY0Hc+UJQHWRoRD36R6jUvLgBlzatJwZ/kur4L0wtLEVEBoyK0NlsfE9iMAPUrnxMxgNAm/ALwIbs4Ehz9SKgz6WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=cFIafSMD; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728888624; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=qqDE2FOehZs6toIhTzk0+At3PD0AOMbhKevFe2pY4/Q=;
	b=cFIafSMDI8LYgeitNTWjodSLaeFs2vGagh8YiXfcKvszlBzksm8dR/gY/EBnuU7En4UNkQwa8aOl3h55OmOYhTH7ZvsbUfR/jJw/uSCF8ceXUZsSvF2XWmLQsSESou65NH4nlfK4wO1iJelJSEHTgavKs39VYCBEatIbEyCjYVg=
Received: from 30.246.164.22(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0WH1pQO._1728888622 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 14 Oct 2024 14:50:23 +0800
Message-ID: <78a18ddd-4704-49ce-86b2-05693ac9b032@linux.alibaba.com>
Date: Mon, 14 Oct 2024 14:50:21 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: arm64: nVHE: gen-hyprel: Silent build warnings
Content-Language: en-US
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>, =?UTF-8?Q?Pierre-Cl=C3=A9ment_Tosi?=
 <ptosi@google.com>, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20241009085751.35976-1-tianjia.zhang@linux.alibaba.com>
 <86set55yca.wl-maz@kernel.org>
 <b3c21234-73a0-43dd-8365-9039c62b7aa7@linux.alibaba.com>
 <CAKwvOdnkTOjV_j6zGAkghgU0L_tLkb=8Nh3Qzvdb1N-tV61wag@mail.gmail.com>
From: "tianjia.zhang" <tianjia.zhang@linux.alibaba.com>
In-Reply-To: <CAKwvOdnkTOjV_j6zGAkghgU0L_tLkb=8Nh3Qzvdb1N-tV61wag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Nick,

On 10/10/24 11:23 PM, Nick Desaulniers wrote:
> On Thu, Oct 10, 2024 at 1:13 AM tianjia.zhang
> <tianjia.zhang@linux.alibaba.com> wrote:
>>
>>
>>
>> On 10/9/24 7:07 PM, Marc Zyngier wrote:
>>> On Wed, 09 Oct 2024 09:57:51 +0100,
>>> Tianjia Zhang <tianjia.zhang@linux.alibaba.com> wrote:
>>>>
>>>> This patch silent the some mismatch format build warnings
>>>> with clang, like:
>>>>
>>>>     arch/arm64/kvm/hyp/nvhe/gen-hyprel.c:233:2: warning: format specifies
>>>>     type 'unsigned long' but the argument has type 'Elf64_Off'
>>>>     (aka 'unsigned long long') [-Wformat]
>>>>       233 |         assert_ne(off, 0UL, "%lu");
>>>>           |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>           |                              %llu
>>>>     arch/arm64/kvm/hyp/nvhe/gen-hyprel.c:193:34: note: expanded from macro 'assert_ne'
>>>>       193 | #define assert_ne(lhs, rhs, fmt)        assert_op(lhs, rhs, fmt, !=)
>>>>           |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>     arch/arm64/kvm/hyp/nvhe/gen-hyprel.c:188:19: note: expanded from macro 'assert_op'
>>>>       187 |                                 " failed (lhs=" fmt ", rhs=" fmt        \
>>>>           |                                                 ~~~
>>>>       188 |                                 ", line=%d)", _lhs, _rhs, __LINE__);    \
>>>>           |                                               ^~~~
>>>>     arch/arm64/kvm/hyp/nvhe/gen-hyprel.c:167:17: note: expanded from macro 'fatal_error'
>>>>       166 |                 fprintf(stderr, "error: %s: " fmt "\n",                 \
>>>>           |                                               ~~~
>>>>       167 |                         elf.path, ## __VA_ARGS__);                      \
>>>>           |                                      ^~~~~~~~~~~
>>>>
>>>> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
>>>
>>> I don't see these warnings. What version of LLVM are you using?
>>>
>>
>> I compiled the kernel on Apple Silicon M3 Pro in macOS 15.0.1, Maybe this is
>> a special scenario that is rarely used.
> 
> Right, so I had an initial patch set for building the kernel from a
> MacOS host.  I sent a v1, but didn't chase sending a v2 at the time
> because there didn't appear to be any interest.
> 
> https://www.phoronix.com/news/Linux-Compile-On-macOS
> 
> Since then, I saw a v2 or even a v3 fly by (I was cc'ed).
> 
> One issue I recall building from MacOS was that MacOS does not have an
> <elf.h> (their object file format is not ELF, but Mach-O).  I had to
> install some dependency through homebrew for that header.
> 
> Just a guess but:
> Perhaps it defines Elf64_Off as a `unsigned long` incorrectly, and
> should be defining it as an `unsigned long long`.  I'd check if that's
> the case and if so, Tianjia, you may want to report that issue on the
> thread where folks are reposting the MacOS host support.
> 

Thanks for the information, great work, very useful attempt.

I have successfully compiled the latest 6.11 rc2 on macOS 15.0.1 Apple
Silicon M3 chip. It seems that compiling on this version of the kernel
is easier. I just added three header files, elf.h, byteswap.h and
endian.h, and add the missing definitions. In addition, I fixed
scriptsj/mod/file2alias.c as you did, and it compiled successfully
without encountering other exceptions. The dependent toolchains are
all installed through brew, include make, llvm and lld.

Cheers,
Tianjia


