Return-Path: <linux-kernel+bounces-253433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C9A93214B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 09:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3E76281484
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 07:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F21339A0;
	Tue, 16 Jul 2024 07:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="axVKom0m";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rLsd0uKS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF122C19E
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 07:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721115411; cv=none; b=Y9hU89CF8h+FYsy5s31UQyMV8SZr+FVScsxgRnR9ftQcnyvEK3Y9v8uSQxLGDueioMn9MUs6APhSEAChoSUmWU+jj/IuGjeT+7AOqPhGNV9kDNggC8EPRVdRSDLNj4M2Iz18+xfIhIgXL9hLKTL8TcNEF5ZtlpA/FgeWO/KhOXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721115411; c=relaxed/simple;
	bh=AcwgECalwiRlLB4Ju4NRdeNfjCCveD44v/AW/VpfCWI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IdraMjWiPZHvcxorhbBstokEO8/RHD6qWdCBJgKlrvpDj0/WZ6i6Oz4eyPaA0qOEYMDGYvqjm3i4wQnLs4g6XOH//olfnPeeQeLZZry2RNTvOljoL0EgPhG0442c7QmQBBJq7zZ12sUCk+BfBAJkyGEFS+5u4cH0OPf9rRLJ0F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=axVKom0m; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rLsd0uKS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721115407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uDxF9sSe/k93/H0Tzst8MDwBRBa53lTAMgOiYTVdhDI=;
	b=axVKom0mL0uXqVnW/22leBnXYuECaD0xUu0QU12dUQq3nS0jQcI7SBKhFQPKOJTMP016Wv
	miEdpXSJGjtBJ3hCVwcds8Syu4iSBtxr25AmF+Ft1NLzkRoPNzXO270lsaymm0QHR+Lr+s
	fF0CBBOIrEjngl6P/7BE5kqIGYSdqnH9pngPPAtzYW8EPwm9FjewY+zjU+SdddgFlzP6OW
	1x0hZp0Wj+LXhW+dSRFyM//lyB+msC1SDIZhu5SSI+YRd0J3A7zrviE0kYAN8NmVxzaxHu
	lHrvd8BF5QNHxjTv0a+9sl+r4yEwvmV6WMeKr/XeJfVi8VS/bqAj/s6im3dF6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721115407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uDxF9sSe/k93/H0Tzst8MDwBRBa53lTAMgOiYTVdhDI=;
	b=rLsd0uKSrVOqOD5prV9wTYcuO6dHemlRUfx7t4dSL223Je23MD6HcZlQX3lXhnCN4mtpIy
	62zjbjv/zaERESBQ==
To: paulmck@kernel.org, kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
 x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Frederic Weisbecker
 <frederic@kernel.org>
Subject: Re: [tip:timers/urgent] [timers/migration]  8cdb61838e:
 WARNING:at_kernel/time/timer_migration.c:#tmigr_connect_child_parent
In-Reply-To: <68204aba-dc0a-47dc-902b-76d6553e17de@paulmck-laptop>
References: <202407101636.d9d4e8be-oliver.sang@intel.com>
 <68204aba-dc0a-47dc-902b-76d6553e17de@paulmck-laptop>
Date: Tue, 16 Jul 2024 09:36:47 +0200
Message-ID: <87ikx53i0g.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Paul,

"Paul E. McKenney" <paulmck@kernel.org> writes:

> On Wed, Jul 10, 2024 at 04:37:00PM +0800, kernel test robot wrote:
>> 
>> 
>> Hello,
>> 
>> kernel test robot noticed "WARNING:at_kernel/time/timer_migration.c:#tmigr_connect_child_parent" on:
>> 
>> commit: 8cdb61838ee5c63556773ea2eed24deab6b15257 ("timers/migration: Move hierarchy setup into cpuhotplug prepare callback")
>> https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git timers/urgent
>
> For whatever it is worth, I am also seeing this on refscale runs on
> recent -next.
>
> The reproducer is to clone perfbook [1] in your ~/git directory
> (as in ~/git/perfboot), then run this from your Linux source tree,
> preferably on a system with few CPUs:
>
> bash ~/git/perfbook/CodeSamples/defer/rcuscale.sh
>
> The output will have "FAIL" in it, which indicates that the corresponding
> guest OS splatted.  If it would be useful, I would be happy to produce
> a one-liner that runs the guest OS only once and leaves the console
> output around.  Otherwise, I will continue being lazy.  ;-)

Thanks for the report. I found the root cause for it and I am working on
a fix as the commit which triggers the warning also has another
problem... And I already requested to drop the tip timers/urgent patches
(at least my patches).

So, enjoy being lazy!

Thanks,

	Anna-Maria


