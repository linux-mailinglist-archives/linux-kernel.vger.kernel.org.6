Return-Path: <linux-kernel+bounces-419329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA249D6C8B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 04:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F4B5B2133E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 03:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F113C2AF05;
	Sun, 24 Nov 2024 03:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THCLBAS4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E801E53A;
	Sun, 24 Nov 2024 03:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732418203; cv=none; b=QuGWqLLJbtXRCPnad97mCQFiQaaUGywsEjatfT65Ofktgl4i2fzo1w1U6hsE74vDFcHhfsEbVJXjUio8Fh2wm2YyaanVLMh9p2qrqM7cMqM8NN9tsTtfPA0ZR5eb3rveQPD7X1/0E6wyq3E6/oejqhuV3/+Q9uhnLCqNNUoSXH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732418203; c=relaxed/simple;
	bh=NURJk+W/Vb8yZSaVKlSCaDW7s1l1rsRSALqij7rYauE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pMxcrZWkNHnGFPqHxcV/8iQ5WHvKYlIwZLSCvqWdYQOAZ2a8kSgAQY3pljUiLlrBvFQyCA20MRKAl1k+O/yZNkJ/yS19StXcjk5Z6sVb86uLwIaNsDE5kcPzHtYSGA3ys3dWJtM8MmPoU0hnd+YbkoAgF/L82kH///ZzTCD0d98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THCLBAS4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77DCDC4CED0;
	Sun, 24 Nov 2024 03:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732418202;
	bh=NURJk+W/Vb8yZSaVKlSCaDW7s1l1rsRSALqij7rYauE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=THCLBAS4hOwP4PwbzEUCziIjzMT3fUCVwjnvXkitTWb83M3RfKLBv3qQDaScXEt1M
	 xAcFLZAD78ozXRmiyOIJ31ZTFSZUwECNz/xqjYkdTjLzh5gFfkc7pTa3WQOpxPQLPt
	 xOkqGYCXMFBv9lRaWTf9Q+rQAmWF+Tho0tmQHelquXiExZzl83DgtibvXRS2FSQQa7
	 Y7GsNvGYcx2CCej/PEGMciUdcJM7kkt2dVUMzn6ngnM5o/zSm5T8KLlrA131FgE9Cm
	 ARHmave33nZwRW8Ztd6KmxHWr4b0txZaWPgeVzfQGMW8QGSf6uScxx1lVvo3GNeUc9
	 Qdk4bu5OzJ2HQ==
Date: Sat, 23 Nov 2024 20:16:40 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: jpoimboe@redhat.com, linux-kernel@vger.kernel.org,
	Fangrui Song <i@maskray.me>, llvm@lists.linux.dev
Subject: Re: [PATCH 1/9] objtool: Generic annotation infrastructure
Message-ID: <20241124031640.GA3646332@thelio-3990X>
References: <20241122121016.372005127@infradead.org>
 <20241122121555.621070802@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122121555.621070802@infradead.org>

On Fri, Nov 22, 2024 at 01:10:17PM +0100, Peter Zijlstra wrote:
> Avoid endless .discard.foo sections for each annotation, create a
> single .discard.annotate section that takes an annotation type along
> with the instruction.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
...
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -2373,6 +2373,49 @@ static int read_unwind_hints(struct objt
>  	return 0;
>  }
>  
> +static int read_annotate(struct objtool_file *file, void (*func)(int type, struct instruction *insn))
> +{
> +	struct section *sec;
> +	struct instruction *insn;
> +	struct reloc *reloc;
> +	int type;
> +
> +	sec = find_section_by_name(file->elf, ".discard.annotate");
> +	if (!sec)
> +		return 0;
> +
> +	if (!sec->rsec)
> +		return 0;
> +
> +	if (sec->sh.sh_entsize != 8) {
> +		static bool warned = false;
> +		if (!warned) {
> +			WARN("%s: dodgy linker, sh_entsize != 8", sec->name);

Thanks to Fangrui, this has been resolved in LLVM main:

https://github.com/llvm/llvm-project/commit/d4bed617f4378873d7ddf4b53c041e7b39d1a9ca
https://github.com/ClangBuiltLinux/linux/issues/2057#issuecomment-2495675374

I have built a version of LLVM from main and verified that this warning
does not trigger with that version, while it does with LLVM 19.1.4.

> +			warned = true;
> +		}
> +		sec->sh.sh_entsize = 8;
> +	}
> +
> +	for_each_reloc(sec->rsec, reloc) {
> +		type = *(u32 *)(sec->data->d_buf + (reloc_idx(reloc) * sec->sh.sh_entsize) + 4);
> +
> +		insn = find_insn(file, reloc->sym->sec,
> +				 reloc->sym->offset + reloc_addend(reloc));
> +		if (!insn) {
> +			WARN("bad .discard.annotate entry: %d of type %d", reloc_idx(reloc), type);
> +			return -1;
> +		}
> +
> +		func(type, insn);
> +	}
> +
> +	return 0;
> +}

Cheers,
Nathan

