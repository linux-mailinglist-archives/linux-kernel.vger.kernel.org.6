Return-Path: <linux-kernel+bounces-414508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE9C9D2932
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 16:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 628102816A8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 15:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138D71D0E06;
	Tue, 19 Nov 2024 15:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="twdttrHe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644191D0B9C;
	Tue, 19 Nov 2024 15:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732028719; cv=none; b=rxVqlo6Rigp1+XW6U1rEk3HH7rxia29SpricJiVAxIe09SvflO/mrio0mg5bhl2Sdg+jHY6arYHqm9eGDxGfO39WN6g4G5KWKsnKantZ/FDGl0MvdraC5qa4cs+v3BfDhMohSAovEfmpMbA4AFHaOkYcMm2JSjUgp0DnIK8vxcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732028719; c=relaxed/simple;
	bh=dwJMy7gU6p+EgePP78qE28lNzONbp71uHZRwxTX4wzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DaFjGmy+eCj41DVFPNx6JYrfSm7KC/7rG91Jn+IVSFNBbtnCsFwvr9Pu2aeZ73PcqYo/zbtim1FxCW0wD1Tj5NGjWWzvtSQAnM4NOw3FR6UW4bnFn7k716LC7jGVjmkg2eACH87udFVXJrcf6u+sX4z9wAxvSbX4oEC1hpjG45U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=twdttrHe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D69BC4CED0;
	Tue, 19 Nov 2024 15:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732028719;
	bh=dwJMy7gU6p+EgePP78qE28lNzONbp71uHZRwxTX4wzI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=twdttrHemy+5Iklw3JpaYLpwyRLu6KZ2klJJkPGu7C4Fd/5n2bBHc1mx6/3ZfKVYu
	 r6sfPAN6ytBtya/ZQ5NaIDMdMuI1dEQznq6oDXsqR5wBkSJBmauijv/Y8HveTfiCxZ
	 2KdjixLUagU3bNYaCP+V/PyHPMK3LTATFciaKfp2zKnju4rJMAXOIAiRLeyFO9UkLD
	 atTuSrBQii9UfCnJVfNG5XSF8D6lLVJKdfQyE/7pFP4LMSK0V4+U84rYfMQIxx1+JR
	 hay7v6sPIYtc7ZFMmkeIrWE2qWUfdPgGFedLwBgeKkEFPaw3dYmZeku4CiitXyAO62
	 Ik2IoMb1+OW4Q==
Date: Tue, 19 Nov 2024 08:05:16 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>, kees@kernel.org
Cc: clang-built-linux <llvm@lists.linux.dev>, kunit-dev@googlegroups.com,
	open list <linux-kernel@vger.kernel.org>,
	David Gow <davidgow@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Anders Roxell <anders.roxell@linaro.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Rae Moar <rmoar@google.com>
Subject: Re: DEFINE_FLEX_test: EXPECTATION FAILED at
 lib/overflow_kunit.c:1200:
Message-ID: <20241119150516.GB2196859@thelio-3990X>
References: <CA+G9fYs0mh8ex1wWYTW_o+BstwCAZ6rgQJZbGRkSH4WoQNTJdw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYs0mh8ex1wWYTW_o+BstwCAZ6rgQJZbGRkSH4WoQNTJdw@mail.gmail.com>

Hi Naresh,

+ Kees (it does not look like you own lib/overflow_kunit.c, should that
be updated?)

On Tue, Nov 19, 2024 at 04:17:41PM +0530, Naresh Kamboju wrote:
> The overflow_DEFINE_FLEX_test KUnit test case. This test consistently
> passes when built with GCC-13 but fails when using Clang-19 or
> Clang-nightly.
> 
> Test Case: overflow_DEFINE_FLEX_test
> Compilers: Passing: GCC-13
>            Failing: Clang-19, Clang-nightly
> Observed Behavior: The test failure is reproducible with Clang builds,
>                    while GCC builds produce consistent success.
> 
> This inconsistency suggests a potential issue either in the Clang toolchain
> or in the test implementation that is exposed by Clang's compilation behavior.
> 
> Test log:
> ----------
> <6>[   92.471692]     # castable_to_type_test: 103 castable_to_type()
> tests finished
> <6>[   92.474933]     ok 21 castable_to_type_test
> <3>[   92.476715]     # DEFINE_FLEX_test: EXPECTATION FAILED at
> lib/overflow_kunit.c:1200
> <3>[   92.476715]     Expected
> __builtin_dynamic_object_size(two_but_zero, 0) == expected_raw_size,
> but
> <3>[   92.476715]         __builtin_dynamic_object_size(two_but_zero,
> 0) == 12 (0xc)
> <3>[   92.476715]         expected_raw_size == 8 (0x8)
> <6>[   92.480178]     not ok 22 DEFINE_FLEX_test
> <6>[   92.483020] # overflow: pass:21 fail:1 skip:0 total:22

I can reproduce this with Clang 19.1.3 on 6.12, so it does not appear to
be a recent problem.

  $ printf 'CONFIG_%s=y\n' KUNIT OVERFLOW_KUNIT_TEST >kernel/configs/overflow_kunit.config

  $ make -skj"$(nproc)" ARCH=arm64 LLVM=1 mrproper {def,hardening.,overflow_kunit.}config Image.gz

  $ boot-qemu.py ...
  [    0.000000] Linux version 6.12.0 (nathan@thelio-3990X) (ClangBuiltLinux clang version 19.1.3 (https://github.com/llvm/llvm-project.git ab51eccf88f5321e7c60591c5546b254b6afab99), ClangBuiltLinux LLD 19.1.3 (https://github.com/llvm/llvm-project.git ab51eccf88f5321e7c60591c5546b254b6afab99)) #1 SMP PREEMPT Tue Nov 19 07:28:39 MST 2024
  ...
  [    4.184764]     # DEFINE_FLEX_test: EXPECTATION FAILED at lib/overflow_kunit.c:1200
  [    4.184764]     Expected __builtin_dynamic_object_size(two_but_zero, 0) == expected_raw_size, but
  [    4.184764]         __builtin_dynamic_object_size(two_but_zero, 0) == 12 (0xc)
  [    4.184764]         expected_raw_size == 8 (0x8)
  [    4.190023]     not ok 22 DEFINE_FLEX_test
  [    4.206181] # overflow: pass:21 fail:1 skip:0 total:22
  [    4.208635] # Totals: pass:21 fail:1 skip:0 total:22
  [    4.212218] not ok 1 overflow
  ...

I do not really understand how __builtin_dynamic_object_size() can
return 12 for two_but_zero with __counted_by() because DEFINE_RAW_FLEX()
does not initialize the counter so it should be zero... Kees? I guess
maybe something changed on the LLVM side, I will see if I can bisect
later (all the boxes are tied up with other compilations at the moment).

Cheers,
Nathan

