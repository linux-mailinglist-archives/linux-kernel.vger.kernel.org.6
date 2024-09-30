Return-Path: <linux-kernel+bounces-344504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B2C98AA7E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 19:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA86A2878E1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 17:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF1C19047D;
	Mon, 30 Sep 2024 17:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8RfV0zz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE44193070
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 17:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727715762; cv=none; b=GeAUeqYbviNpXnRZEzMbb6Kuhzay+VRc5bTQmgbogMnak1gnLh7yYaxh55LE38kMI0aWaKx1QVgzirjqaQFqznrQB4U1NGvYFIsiUhWMPq8tnQOfY8LJ2JGL7QkG3P/Y7KAxKrvfqehkKDzEcw4/Vj+qX7/ZGpehNVEZe3Of4Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727715762; c=relaxed/simple;
	bh=niebGD8vq4wvHaouk91DDIoTfYQZztvU1J2oPsB1tls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RlTET/NUsVbfFsiH8ENu+/n7QksgqUrxDHW9tAGHdY6g41seEOIO45INjSacNyg/gJqj4f/OGtiUSfzKsNnr+GjIl9Y1sNVpuueX5lKIIIZdM96GWzWTuZZ9nBPnuGbZfRbiPqb2FCmejxO1HIe73jIN7zbL4Nte3wARu9Dv6j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i8RfV0zz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 703B0C4CEC7;
	Mon, 30 Sep 2024 17:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727715762;
	bh=niebGD8vq4wvHaouk91DDIoTfYQZztvU1J2oPsB1tls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i8RfV0zztz7ke+JbcaWTm82xfWcgtrHY4ZtW0HxOYTeo2iv/5FpJZOemWmYeoOQhM
	 M3rrrWvF/XoUuoA+IY99eu8zfuATMXor31+Qgb4sJ4GQTZfLsWp79fwpEJYnr/f3ia
	 +KwE7/9J3+h/cV5G3dqILSIVWmiZlyBcTCTlWtpEPydj7Wif6DnNmUDgR08yAmRFAL
	 YlVtpnmXlD1rvWacTBFqEWe465oIMIqFHCKha/IBFeTaSYulEsprfkfq+uE00dffck
	 /AMD0sAkchq+5RDqfdXzZWkuFayWOI3zJW0QFjNB5QdwtVY9ClvLAKYFhZwzA1r/Tg
	 eFp8zw6FkH9hw==
Date: Mon, 30 Sep 2024 07:02:41 -1000
From: Tejun Heo <tj@kernel.org>
To: Matthias =?iso-8859-1?Q?M=E4nnich?= <maennich@google.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com,
	peterz@infradead.org, void@manifault.com
Subject: Re: [PATCH] sched: fix include for task_cpu_possible
Message-ID: <ZvrZsQ-uXHFQsxII@slm.duckdns.org>
References: <20240930164455.2060692-2-maennich@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240930164455.2060692-2-maennich@google.com>

Hello,

On Mon, Sep 30, 2024 at 04:44:56PM +0000, Matthias Männich wrote:
> From: Matthias Maennich <maennich@google.com>
> 
> Commit 2c390dda9e03 ("sched_ext: Make task_can_run_on_remote_rq() use
> common task_allowed_on_cpu()") moved the call for task_cpu_possible from
> kernel/sched/core.c, but did not add an include of linux/mmu_context.h
> where this symbol is defined. Fix that by adding the missing include.
> 
> Fixes: 2c390dda9e03 ("sched_ext: Make task_can_run_on_remote_rq() use common task_allowed_on_cpu()")
> Signed-off-by: Matthias Maennich <maennich@google.com>
> ---
>  kernel/sched/sched.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index e2b7c5282f5d..a7832c53cc92 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -44,6 +44,7 @@
>  #include <linux/lockdep.h>
>  #include <linux/minmax.h>
>  #include <linux/mm.h>
> +#include <linux/mmu_context.h>

Should the patch also remove mmu_context.h from kernel/sched/core.c?

Thanks.

-- 
tejun

