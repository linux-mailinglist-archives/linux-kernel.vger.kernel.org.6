Return-Path: <linux-kernel+bounces-244124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE23929F7B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 11:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07AD2B26DCF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 09:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6275E6BFBA;
	Mon,  8 Jul 2024 09:47:30 +0000 (UTC)
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322AC48CCD
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 09:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720432050; cv=none; b=ow9jRjPy0grjIQrPKt2gQWQw6YMw7HySt0FUPtrAb0PzUYQUDgO2eNKPwJXomKVV1KqzPMBXcAg+k8HLwc2YfFE+Cw/09lUCVwdOYME4JuFRkiKcv8c44VRyQMdpc1ssBdcfrh7KwJPGeO42ZbffeFLcYrnSI86Ir2tBnKiv04k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720432050; c=relaxed/simple;
	bh=QL73G3seQeHMaEK9VNA8CHNze8yQ1wmaIMYmPcfU8hA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=cQ2AmYj7OBAcv3/2abaFONk4twfuNy9mFDT5XIRUZCdA1MiF+L9uhJAVbo+WimAgGkaS+6EB4Bl1t3UTpBYQjGvVzCuea7mpWjbrrYls4gh2G8+IMkjq9kwcMOmlJ4A70t2XBiNWhMXV9mnNMwW0u9Wb44O3ukttenKwrUJsRmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id EA38392009C; Mon,  8 Jul 2024 11:47:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id E7FAC92009B;
	Mon,  8 Jul 2024 10:47:18 +0100 (BST)
Date: Mon, 8 Jul 2024 10:47:18 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Peter Zijlstra <peterz@infradead.org>
cc: Ingo Molnar <mingo@kernel.org>, juri.lelli@redhat.com, 
    vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
    bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
    linux-kernel@vger.kernel.org, tglx@linutronix.de
Subject: Re: sched: Update MAINTAINERS
In-Reply-To: <20240708075752.GF11386@noisy.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.2407081038350.38148@angie.orcam.me.uk>
References: <20240708075752.GF11386@noisy.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 8 Jul 2024, Peter Zijlstra wrote:

>   Thank you for having been our friend!
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19929,7 +19929,6 @@ R:	Dietmar Eggemann <dietmar.eggemann@ar
>  R:	Steven Rostedt <rostedt@goodmis.org> (SCHED_FIFO/SCHED_RR)
>  R:	Ben Segall <bsegall@google.com> (CONFIG_CFS_BANDWIDTH)
>  R:	Mel Gorman <mgorman@suse.de> (CONFIG_NUMA_BALANCING)
> -R:	Daniel Bristot de Oliveira <bristot@redhat.com> (SCHED_DEADLINE)

 I think perhaps a CREDITS entry would be due rather than just dropping 
from MAINTAINERS.

  Maciej

