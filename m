Return-Path: <linux-kernel+bounces-575099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA65FA6ED84
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 11:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85A1A18929A1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 10:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33EC21EEA4E;
	Tue, 25 Mar 2025 10:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uYQ+sJ87"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CFC78F24
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 10:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742898308; cv=none; b=Upm+kMw7MD68kbPzxVqFmFTZVBYz5pbLOOYBN+Wz1fjer0qXaDvcRr2ekpVVbfgCcIRqEev7jluO0rsq3IpwuqIgKkaahGkMaOlv9H+B2OE3qVlbkYMQPYwBwLP0HPbNdtI5pMw7IG4BGuc/dAoOaw16fcIo+k6Yp0pAK36UXIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742898308; c=relaxed/simple;
	bh=uYre/A4PkxVQHPqNGZlncX/w1QLB853sHFpxDXYqsGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JOn+qLvCLfjc/KVig/mv/blrFgKIQLjASPcPFYOWksg5vqdckdsBVSoUE5TILXxNmANAmxMcRNjaXzVhGp9S3gBZERd7OoHXnwAsXA/ZlaYFJKopnEm7NLXkdARb7rgI5wXeR649u5jkCXeu8+Y0Hi8I4HC0MfeD2YHkCvAM0jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uYQ+sJ87; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2252FC4CEE4;
	Tue, 25 Mar 2025 10:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742898308;
	bh=uYre/A4PkxVQHPqNGZlncX/w1QLB853sHFpxDXYqsGM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uYQ+sJ877nqUREu9OpLvvM1aMjcDTq1qlcQTVjrWRZaImWmXmWao2/uenlMqOiH3f
	 FjprDIlHH1UpOWznIeJq4Z92DHHQK6ABALTbEVM0y8wti9tXjSvFw5YFF5Gt5qhirE
	 JFx5x5Wr33NjaQDK8nJuYAmHF/h+0rcQahWyVg4B0bbZyhMl/72Kd39gnDS7SzbcoP
	 ykqzK1OqYX5SS9Nq3Lyj+42IFAWD+wfmIAA4VN+PRiMictrybqPFcCHy4sGaWnFOS/
	 Rs7gn22U68ilYuEd0u3k3bjhQJcUMiPyDF44nNCbYTGJvooBkBCI2bjwv2Ae4VDuCy
	 B5KmeW6yTIaIw==
Date: Tue, 25 Mar 2025 11:25:03 +0100
From: Ingo Molnar <mingo@kernel.org>
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com
Subject: Re: [PATCH RFC v2 0/9] x86: Support Intel Advanced Performance
 Extensions
Message-ID: <Z-KEf0AqHtH8GwBJ@gmail.com>
References: <20250227184502.10288-1-chang.seok.bae@intel.com>
 <20250320234301.8342-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320234301.8342-1-chang.seok.bae@intel.com>


* Chang S. Bae <chang.seok.bae@intel.com> wrote:

> Chang S. Bae (9):
>   x86/fpu/xstate: Remove xstate offset check
>   x86/fpu/xstate: Introduce xfeature order table and accessor macro
>   x86/fpu/xstate: Adjust XSAVE buffer size calculation
>   x86/fpu/xstate: Adjust xstate copying logic for user ABI

So I've applied these first 4 as preparatory patches to tip:x86/fpu, 
let's get these tested a bit broadly.

>   x86/cpufeatures: Add X86_FEATURE_APX
>   x86/fpu/apx: Define APX state component
>   x86/fpu/apx: Disallow conflicting MPX presence
>   x86/fpu/apx: Enable APX state support
>   selftests/x86/apx: Add APX test

Planning to apply these remaining 5 as well in a couple of days, if all 
goes well with the others.

Thanks,

	Ingo

