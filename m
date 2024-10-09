Return-Path: <linux-kernel+bounces-356238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE95B995E5B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 05:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C84B1C21962
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 03:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D54214D71E;
	Wed,  9 Oct 2024 03:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mxeiYtxf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA07D14885E
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 03:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728445925; cv=none; b=QGgfzmfg7vcffwVdR4HYX2BYC5YxOzqrRqUkKZtFROkTNC4a4AEXZydFXGl42/7+EiKgijk+7Q47YPJYJ+gCfgmZpTZfSpuzDEpL46cTXGhjIiPmG7vH9/Nr+e3rrJ1Js48eqwWLjQ61ZHbvZGvpApGi6YD/cwvYzjqGFpX6+GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728445925; c=relaxed/simple;
	bh=MWSYD62Ltb5ymo/NwUHdZrIc6KoW2Yhbq3iaAcNNJMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IZRWNGfEt4E1AfTDv6sZf5Gml53lSl+q4AM8tmJcUESvSQ0lNTzRGEUbJ09TG3Uf91LScmX8lV2zOyZnGjx4DjvNdp9mtzVaFpJcNd/ysnPyGnWuBcBQsasYYXJfc78bGmnXkIZlKC91hyG+5Un50Dh+oeEehHbpwdHfhLESFSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mxeiYtxf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CD91C4CEC5;
	Wed,  9 Oct 2024 03:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728445925;
	bh=MWSYD62Ltb5ymo/NwUHdZrIc6KoW2Yhbq3iaAcNNJMk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mxeiYtxf4ijk1OaBAwqdxatmUBgZch4J0W0eSMdIu/SRr8dHeep/g5J8m38wHQqQB
	 TMxg5VyNCcsKdc+X2DEgO2kmIsGMFwAhla0QNhkxF650iDDlbZFWXYiPKtYSP3arpP
	 YJCDe3pOnrhEQ1dYubKgDzQvek2kDsoirybPQ8SYeNqLub7OLluMrq6ZUT+Cqsm+8w
	 9xlB9oW/uTGD2EsP9uNRjsHE6tZFJAv/hBCAY0/FwftpO00j3FBxhHrP4ItckEOdV9
	 oOjnagTHJFIxYIJ5ed9hoBhz0h5YgnK15zHVInag0IeP2xdTW4eY8A6BZ1RybLjgAw
	 LkiWAZ0fE7W6Q==
Date: Tue, 8 Oct 2024 20:52:03 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: HONG Yifan <elsk@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, kernel-team@android.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 RESEND] objtool: Also include tools/include/uapi
Message-ID: <20241009035203.aqaxu22kckgmm4rr@treble>
References: <20241008234718.17127-1-elsk@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241008234718.17127-1-elsk@google.com>

On Tue, Oct 08, 2024 at 11:47:17PM +0000, HONG Yifan wrote:
> When building objtool against a sysroot that contains a stripped down
> version of the UAPI headers, the following error happens:
> 
>     In file included from arch/x86/decode.c:10:
>     In file included from .../tools/arch/x86/include/asm/insn.h:10:
>     In file included from <sysroot>/include/asm/byteorder.h:9:
>     In file included from <sysroot>/include/linux/byteorder/little_endian.h:15:
>     In file included from <sysroot>/include/linux/stddef.h:9:
>     In file included from .../tools/include/linux/compiler_types.h:36:
>     .../tools/include/linux/compiler-gcc.h:3:2: error: "Please don't include <linux/compiler-gcc.h> directly, include <linux/compiler.h> instead."
>         3 | #error "Please don't include <linux/compiler-gcc.h> directly, include <linux/compiler.h> instead."
>         |  ^
>     1 error generated.
> 
> As hinted by the error, this is because <sysroot>/include/linux/stddef.h
> (a stripped-down version of uapi/include/linux/stddef.h) includes
> linux/compiler_types.h directly. However, this gets resolved to
> tools/include/linux/compiler_types.h, which is not expected to be
> included directly.
> 
> To resolve this, I added tools/include/uapi to the include paths when
> building objtool. With this trick, linux/stddef.h is resolved to
> tools/include/uapi/linux/stddef.h, which doesn't include
> linux/compiler_types.h.
> 
> Signed-off-by: HONG Yifan <elsk@google.com>

Queued, thanks!

-- 
Josh

