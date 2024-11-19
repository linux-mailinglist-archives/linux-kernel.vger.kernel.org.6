Return-Path: <linux-kernel+bounces-414750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE169D2CEC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 18:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C47C0B3634F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 17:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527C41D150D;
	Tue, 19 Nov 2024 17:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MlF6T3re"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13181D0F5C;
	Tue, 19 Nov 2024 17:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732037923; cv=none; b=RiwOaA2DlYaLnUU97XWpuViP3ryrazDX3sftqJZvUtJuq3zQ54+h8+Az/y5xl1bvzvtYvZHO6sE90XnQjzjb25x0byERsQ1CEENUSOOfB3IjOh81++ejoSAlzF/Uqo8QlZ8tXSl0KMwWXY7D0StHoyn2FVwbyBC0DZ6gxkIEvHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732037923; c=relaxed/simple;
	bh=8FvQe7CmDiiqtCg1COmi0pytCuaxj4XI0WYiZ+k1y8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ld+Xtt6QWJhiFL1fG3Jrp76Bb2FqLlacxdYjyZ8LD5V9HX8t4S0RT6e3DwZb9guMuidXRNyDbIz+DDCc5PHolX2Z7U87moaCltvDShlYNSd3PSx76iGeY4koy2zfBDJ+JSA0dADaCFy8gxheaebcy5snY6KYFYW4sQyTnIhRB+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MlF6T3re; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29607C4CECF;
	Tue, 19 Nov 2024 17:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732037923;
	bh=8FvQe7CmDiiqtCg1COmi0pytCuaxj4XI0WYiZ+k1y8w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MlF6T3re1MNzu3fiZVN7RnFS3JFfCG1wcknEQhoPhmW/RBMu2WLFxbSRdVIHsoQ3F
	 WW5JNHxs4Z2lXUogrm4q5vICLusABYIgMJnX4tsv4kPge4QfAdFE7/9zWWNYg4Z4lm
	 GiJ18o9rQ2iYPmGpvjqvGtvTAd4iffBHmukfhrA5kStpThiZR0Ab7p/VVMfMzjth5H
	 IxD2ocbOMAqeQm+IrQoVzgkPv/pZ7ANl8uOVsYtUbam1V3NTXdn6MLdFjWoFJSbiOU
	 BxR01NPKlNmwiFItoUjOEdybxHxOD+V2I5JawxIzW85EtuU3nvHoyg2+er+Vc5m7ab
	 Jy3uGs0Df//Jg==
Date: Tue, 19 Nov 2024 09:38:40 -0800
From: Kees Cook <kees@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
	clang-built-linux <llvm@lists.linux.dev>,
	kunit-dev@googlegroups.com,
	open list <linux-kernel@vger.kernel.org>,
	David Gow <davidgow@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Anders Roxell <anders.roxell@linaro.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Rae Moar <rmoar@google.com>
Subject: Re: DEFINE_FLEX_test: EXPECTATION FAILED at
 lib/overflow_kunit.c:1200:
Message-ID: <202411190932.DB9B746B8@keescook>
References: <CA+G9fYs0mh8ex1wWYTW_o+BstwCAZ6rgQJZbGRkSH4WoQNTJdw@mail.gmail.com>
 <20241119150516.GB2196859@thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119150516.GB2196859@thelio-3990X>

On Tue, Nov 19, 2024 at 08:05:16AM -0700, Nathan Chancellor wrote:
> Hi Naresh,
> 
> + Kees (it does not look like you own lib/overflow_kunit.c, should that
> be updated?)

Yeah, though I thought the selftest tree was moving a bunch of these
into a subdirectory? Maybe that didn't happen for v6.12?

> On Tue, Nov 19, 2024 at 04:17:41PM +0530, Naresh Kamboju wrote:
> > The overflow_DEFINE_FLEX_test KUnit test case. This test consistently
> > passes when built with GCC-13 but fails when using Clang-19 or
> > Clang-nightly.
> > 
> > Test Case: overflow_DEFINE_FLEX_test
> > Compilers: Passing: GCC-13
> >            Failing: Clang-19, Clang-nightly
> > Observed Behavior: The test failure is reproducible with Clang builds,
> >                    while GCC builds produce consistent success.
> > 
> > This inconsistency suggests a potential issue either in the Clang toolchain
> > or in the test implementation that is exposed by Clang's compilation behavior.
> > 
> > Test log:
> > ----------
> > <6>[   92.471692]     # castable_to_type_test: 103 castable_to_type()
> > tests finished
> > <6>[   92.474933]     ok 21 castable_to_type_test
> > <3>[   92.476715]     # DEFINE_FLEX_test: EXPECTATION FAILED at
> > lib/overflow_kunit.c:1200
> > <3>[   92.476715]     Expected
> > __builtin_dynamic_object_size(two_but_zero, 0) == expected_raw_size,
> > but
> > <3>[   92.476715]         __builtin_dynamic_object_size(two_but_zero,
> > 0) == 12 (0xc)
> > <3>[   92.476715]         expected_raw_size == 8 (0x8)
> > <6>[   92.480178]     not ok 22 DEFINE_FLEX_test
> > <6>[   92.483020] # overflow: pass:21 fail:1 skip:0 total:22
> 
> I can reproduce this with Clang 19.1.3 on 6.12, so it does not appear to
> be a recent problem.
> 
>   $ printf 'CONFIG_%s=y\n' KUNIT OVERFLOW_KUNIT_TEST >kernel/configs/overflow_kunit.config
> 
>   $ make -skj"$(nproc)" ARCH=arm64 LLVM=1 mrproper {def,hardening.,overflow_kunit.}config Image.gz
> 
>   $ boot-qemu.py ...
>   [    0.000000] Linux version 6.12.0 (nathan@thelio-3990X) (ClangBuiltLinux clang version 19.1.3 (https://github.com/llvm/llvm-project.git ab51eccf88f5321e7c60591c5546b254b6afab99), ClangBuiltLinux LLD 19.1.3 (https://github.com/llvm/llvm-project.git ab51eccf88f5321e7c60591c5546b254b6afab99)) #1 SMP PREEMPT Tue Nov 19 07:28:39 MST 2024
>   ...
>   [    4.184764]     # DEFINE_FLEX_test: EXPECTATION FAILED at lib/overflow_kunit.c:1200
>   [    4.184764]     Expected __builtin_dynamic_object_size(two_but_zero, 0) == expected_raw_size, but
>   [    4.184764]         __builtin_dynamic_object_size(two_but_zero, 0) == 12 (0xc)
>   [    4.184764]         expected_raw_size == 8 (0x8)
>   [    4.190023]     not ok 22 DEFINE_FLEX_test
>   [    4.206181] # overflow: pass:21 fail:1 skip:0 total:22
>   [    4.208635] # Totals: pass:21 fail:1 skip:0 total:22
>   [    4.212218] not ok 1 overflow
>   ...
> 
> I do not really understand how __builtin_dynamic_object_size() can
> return 12 for two_but_zero with __counted_by() because DEFINE_RAW_FLEX()
> does not initialize the counter so it should be zero... Kees? I guess
> maybe something changed on the LLVM side, I will see if I can bisect
> later (all the boxes are tied up with other compilations at the moment).

Hmm. I assume this is related to recent bdos vs counted_by changes in
Clang 19.1.2 (or .3?) But I'm going to have to track down which is
causing it.

The test is supposed to check this...

if counted_by is supported, DEFINE_RAW_FLEX will init counted_by to 0,
so the object is expected to be seen as sizeof(int) + sizeof(u32) (8).

if counted_by is NOT supported, then bdos will return the on-stack size
of the object (8 + sizeof(s16) * 2) == 12.

If LLVM switch to "max of counted_by or bos", then returning 12 would
make sense again.

I will check behaviors and compare it to GCC 15...

-- 
Kees Cook

