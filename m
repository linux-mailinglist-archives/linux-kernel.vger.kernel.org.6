Return-Path: <linux-kernel+bounces-414882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C279D2ED0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 20:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F77B283F03
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 19:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7CB1D1729;
	Tue, 19 Nov 2024 19:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fvFiJa6q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0878528E
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 19:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732044364; cv=none; b=p5hoXj0g1gI3MdTh/wjc48p5OQfwA+g2GaKgo356PWFHwIkMQFvJuRm9/L5SeJifvcYUOVnDHcGMup8OjwE1xCiv5Yi+/MAUx/bzNfxFIX/RshYUgkNG/05uwqu9N+IPn6GXe9QnRXufT+n9uMwDUmgGVjlhx7P/5fHLrBsiUZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732044364; c=relaxed/simple;
	bh=oBkk8fzSDVtSWlZe0n/ZHrtp46932fkOtXsQw+BAtTo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=uaQNzFKc7MdoWI1Oh/14AOCDhAehkC6OxeaH37/3yMXtwoJHWKvGS1kxvuHVm1fFgLsNtE0N/QeVHIvXc3/CwvATztxqtvc7EpqrGXNOPp/TV5I9r8xCH5W9gWRefuRGRGo/tVHoeKOGQ72yHrDVpuBIexKIu9Ebn6mZXjTF7EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fvFiJa6q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84866C4CECF;
	Tue, 19 Nov 2024 19:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732044363;
	bh=oBkk8fzSDVtSWlZe0n/ZHrtp46932fkOtXsQw+BAtTo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=fvFiJa6qtJCOhR3ZjV+Dgwt1551Kx+3lxj2OUV+m2OeIyjhoFftTrf3vdAe8rOZaT
	 63RotJ8DqXSUHXSzYYqlFgMdjmr5d8D7uqyO+tjq5NihzAts4vemlHc/HEKz+gARNA
	 IZEZjDqSZaqmpprpMFrWIwFXNSBw4hshEigObPKjy7EKaZS85dxxmrAXxJP6JMwYo6
	 4dvD4JYKMjfxm7mvWRexOFjNMvWMBlCrigTfJxIlmt26lFVEb99lPuIqw76S7fDqnJ
	 yQzzc3c8/+Mok+LM7lTxx2fwkPFT7N467tjv+Gt8ZzBXX3v2kbTGfY7qfVERPI3hVg
	 cvhTJIbAT444Q==
Date: Tue, 19 Nov 2024 13:26:02 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ragavendra <ragavendra.bn@gmail.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, thomas.lendacky@amd.com,
	ardb@kernel.org, tzimmermann@suse.de, bhelgaas@google.com,
	x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Updating es_em_ctxt fi to zero
Message-ID: <20241119192602.GA2272685@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119180517.196079-2-ragavendra.bn@gmail.com>

On Tue, Nov 19, 2024 at 10:05:18AM -0800, Ragavendra wrote:
> Updating es_em_ctxt to zero for the ctxt->fi variable in
> verify_exception_info when ES_EXCEPTION is returned.

This commit log basically says in English what the code does in C.  If
you can include the *reason* why this is important, it will be more
helpful.  For example, maybe somebody consumes other parts of ctxt.fi
(a struct es_fault_info), and without this patch, they use junk that
causes an oops or some other bad thing.

If the 34ff65901735 Fixes: tag is correct, I suppose the problem
happens because ctxt is allocated on the stack and contains junk, and
then svsm_perform_ghcb_protocol() passes it on to
vc_forward_exception(), which does use fields of ctxt->fi other than
.vector, which will be junk without this patch.

Hints and samples for commit logs:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/maintainer-tip.rst?id=v6.11#n134

Based on "git log --oneline arch/x86/coco/sev", I would expect the
subject line to have an "x86/sev: " prefix, e.g.,

  x86/sev: Clear es_em_ctxt.fi to ...

> Fixes: 34ff65901735 x86/sev: Use kernel provided SVSM Calling Areas
> Signed-off-by: Ragavendra Nagraj <ragavendra.bn@gmail.com>
> ---
>  arch/x86/coco/sev/shared.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/x86/coco/sev/shared.c b/arch/x86/coco/sev/shared.c
> index 71de53194089..b8540d85e6f0 100644
> --- a/arch/x86/coco/sev/shared.c
> +++ b/arch/x86/coco/sev/shared.c
> @@ -239,6 +239,8 @@ static enum es_result verify_exception_info(struct ghcb *ghcb, struct es_em_ctxt
>  		if ((info & SVM_EVTINJ_VALID) &&
>  		    ((v == X86_TRAP_GP) || (v == X86_TRAP_UD)) &&
>  		    ((info & SVM_EVTINJ_TYPE_MASK) == SVM_EVTINJ_TYPE_EXEPT)) {
> +			memset(&ctxt->fi, 0, sizeof(ctxt->fi));
> +
>  			ctxt->fi.vector = v;
>  
>  			if (info & SVM_EVTINJ_VALID_ERR)
> -- 
> 2.46.1
> 

