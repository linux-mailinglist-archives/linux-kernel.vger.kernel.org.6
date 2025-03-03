Return-Path: <linux-kernel+bounces-541709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 413BDA4C069
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 13:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6254D171486
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 12:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F8B1F0E34;
	Mon,  3 Mar 2025 12:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qgad3ie1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE125661
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 12:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741005199; cv=none; b=rQMYUEQFJWWBahKLv113CgonGGAMKVW7fhFebSJ1aas2QKmhd7QUwGO4d9Ixo6GRcagbSObLdSXAl/SgJfNbYDU0XOohMeHJHrTcg8JnfeP547AszIr0uaDxJFUAdUEzjtt3zL9fb/VYZNxHYsbhKlsDWebKxxLKwNbc6yVVCic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741005199; c=relaxed/simple;
	bh=x9SEbmFJPq62LJOYO+aRF/L+53QttHd8dBpeE2pMwrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k78qJuFGNJ6yWPqauu8yMMytVFXWg+F1oHElJRZrrRjXPL66ucdTTsV8OY4TnEBoK0348kom8uqjOI9J4zvLIxGFiFPoM6T1ZIpG/kXXpPps0hTpbJv0mvsSWiZCd39TFllTyDtBybxl8uffSrak1cJAjjjnrbmZWLTPbIzEtYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qgad3ie1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E91FC4CED6;
	Mon,  3 Mar 2025 12:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741005197;
	bh=x9SEbmFJPq62LJOYO+aRF/L+53QttHd8dBpeE2pMwrQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qgad3ie1d+F48UWQikUiSMHknHCw/FUCVeasoQdNnbjUasylxuyoJHw0AiApXA0/e
	 O8HxrPdpr4G2lTEuO8guMUDlLWJkPRkJ2vZYy7DGlqvN1Y1xWBYbeHnB7zZAFFVAK0
	 /CyK3sC7AuC+nODDrXAKTJ5YDL2lKofIQKaeYITSOkJF5xeHgsPW2+gUz5zmfRcFmd
	 ceJHe6y5iHGrKJEvcwqzJBo8CRgE3zjYjtFXHvfR0I65wa+hOVjtprh6m7zI5xkGYP
	 6SlLeVysL95CyO9mBH29ZTqobIgDtGLva0/bSoUu1crRSHSZhmm0iRZg1MTIBQC98K
	 VYJ9A4JSg4qfw==
Date: Mon, 3 Mar 2025 13:33:12 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, xin3.li@intel.com,
	krisman@collabora.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: Remove unused _TIF_SINGLESTEP
Message-ID: <Z8WhiJizjKw_qEkY@gmail.com>
References: <20241030012438.358269-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030012438.358269-1-ruanjinjie@huawei.com>


* Jinjie Ruan <ruanjinjie@huawei.com> wrote:

> Since following commit, _TIF_SINGLESTEP is not used by x86 anymore,
> remove it.
> 
> Fixes: 6342adcaa683 ("entry: Ensure trap after single-step on system call return")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  arch/x86/include/asm/thread_info.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
> index 12da7dfd5ef1..734db7221613 100644
> --- a/arch/x86/include/asm/thread_info.h
> +++ b/arch/x86/include/asm/thread_info.h
> @@ -110,7 +110,6 @@ struct thread_info {
>  #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
>  #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
>  #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
> -#define _TIF_SINGLESTEP		(1 << TIF_SINGLESTEP)
>  #define _TIF_SSBD		(1 << TIF_SSBD)
>  #define _TIF_SPEC_IB		(1 << TIF_SPEC_IB)
>  #define _TIF_SPEC_L1D_FLUSH	(1 << TIF_SPEC_L1D_FLUSH)

While technically _TIF_SINGLESTEP is not used, TIF_SINGLESTEP is very 
much used, and _TIF_SINGLESTEP is its canonical mask definition that we 
construct for all the other TIF bits as well.

Thanks,

	Ingo

