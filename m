Return-Path: <linux-kernel+bounces-312011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A49CE9690E3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 03:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6249D284021
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 01:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1451CCED4;
	Tue,  3 Sep 2024 01:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C0TM0I9m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD9035894
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 01:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725326637; cv=none; b=en5yAVBj+ad37AzrAyRzHHhfwjO7j4eq8DW1OGiRVOotphXtS396lAAqIIRaUgZfg6UXpKCZGJ8zJ54o8pHq6fpso6/wpOnWJo3fj58IvXKZtZa/JIr/MSaAmJPL18523WYrIzN4bXmq6FP1Pmo8YxENvkFm1wEEd9E3WxjONfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725326637; c=relaxed/simple;
	bh=5dilIVLHn/EYFipuw9tNrZVa8DIM/nWuxEYXe+uhoow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YCIc4d2T38CtxPTZS6AoIf01h0Caj6ddxv80ZcTT0rud3NBTku4U00aoasUDFm8Oh1plOKqzNACNNcwah3cZijvapw5KWLYGlasrEu434cYVdID82O3dVMl0S7XmKEszVAET1vz03QUpOiNPwCwccb8Od7uLtI6TR2tGegE2CCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C0TM0I9m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77CC3C4CEC2;
	Tue,  3 Sep 2024 01:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725326636;
	bh=5dilIVLHn/EYFipuw9tNrZVa8DIM/nWuxEYXe+uhoow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C0TM0I9m1LC+bwE2xxR2e0Kc0AW7r4UUQNoeqYL4M4UvAW5DYSAf1ljohxHdj/ndV
	 nTC02EJRbtll+U0csd7V0nykek+Ho5LvMU5uIuIqbDx8uByTl/OnXKGfkqIW85ye3J
	 /gfEG31uZrmeIdFztR/BbogU4B39sqLLofSGXRefIbhn7xevcXPzX0RjM/pJ163gxP
	 abxHG/24tP2Soj5p7PlxQ5m5joxJiyx5KZKvoemR4ksOkp/lsU816U1Jh3wlAxBXzd
	 IYcdAwbmfB8T0FRXBiS6cYzwxzR1nD1ceVzAF3bmetnKpdXeSKHg3dkeo+V5TldNSz
	 Da0nx5hiq6tcQ==
Date: Mon, 2 Sep 2024 18:23:54 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "Jason A . Donenfeld" <Jason@zx2c4.com>, linux-kernel@vger.kernel.org
Subject: Re: odd endianness toolchains for crosstool
Message-ID: <20240903012354.GA422360@thelio-3990X>
References: <YmX7z+BirkA3VAfW@zx2c4.com>
 <ZtCZF_yaHnECJyZ1@zx2c4.com>
 <f7069edc-a152-425f-afb1-8df326d0131c@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7069edc-a152-425f-afb1-8df326d0131c@app.fastmail.com>

On Thu, Aug 29, 2024 at 10:25:32PM +0200, Arnd Bergmann wrote:
> On Thu, Aug 29, 2024, at 17:51, Jason A. Donenfeld wrote:
> > On Mon, Apr 25, 2022 at 03:39:27AM +0200, Jason A. Donenfeld wrote:
> >
> >
> > I decided to give it another look, seeing if I could replace my musl.cc
> > compilers with your crosstool ones.
> >
> > The actual changes required weren't so bad:
> >
> >     https://git.zx2c4.com/wireguard-linux/commit/?h=update-toolchain
> >
> > But there's not universal success:
> >
> >     x86_64 - good
> >     i386 - good
> >     arm - good
> >     armeb - MISSING
> >     aarch64 - good
> >     aarch64_be - MISSING
> >     mips - BROKEN (doesn't like -EB)
> >     mipsel - MISSING
> >     mips64 - BROKEN (doesn't like -EB)
> >     mips64el - MISSING
> >     powerpc64 - BROKEN (wrong powerpc ABI)
> >     powerpc64le - MISSING
> >     powerpc - BROKEN (builds but some binaries segfault)
> >     m68k - good
> >     riscv64 - good
> >     riscv32 - good
> >     s390 - BROKEN (should be called "s390x" instead)
> >     um - kinda broken (but not crosstool's problem)
> >
> > To try these, I've been running:
> >
> >     ARCH=aarch64 make -C tools/testing/selftests/wireguard/qemu -j$(nproc)
> >
> > or similar, against this tree:
> >
> >     $ git clone -b update-toolchain https://git.zx2c4.com/wireguard-linux/
> >
> > So it looks like it's not quite there, but not bad either. Just FYI in
> > case you're interested.
> 
> I wonder if the ones you list as missing all work with Nathan's clang
> builds from https://mirrors.edge.kernel.org/pub/tools/llvm/ instead.
> 
> As far as I can tell, the main missing bit here is libgcc, which
> is not always built along with gcc for all possible targets.
> The llvm replacement for libgcc is https://compiler-rt.llvm.org/,
> and you may have to build that in addition to musl when you try it.
> 
> I don't know if compiler-rt also works with gcc, but if it does,
> that should fix most of the ones that you report as failing above.
> The only one that won't work at all is um because the x86 toolchain
> is already unable to build a kernel for that.

I doubt my toolchains would fix this issue. As far as I am aware, only
the native compiler runtime is included, not any of the cross ones, as
the kernel itself does not use them. However, I suspect it would not be
too difficult to cross build compiler-rt standalone and stitch it into
my builds separately if desired.

FWIW, I have used your toolchains to build UML but maybe that is
environment dependent?

Cheers,
Nathan

