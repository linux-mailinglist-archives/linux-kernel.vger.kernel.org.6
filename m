Return-Path: <linux-kernel+bounces-537477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E3DA48C6C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 00:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 964F8188F14C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 23:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F2626AABA;
	Thu, 27 Feb 2025 23:08:36 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3000023E34E;
	Thu, 27 Feb 2025 23:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740697716; cv=none; b=eSTXHYU0bB36B3DJ6iJK4j1cNk0ByW/D0wegRhYSxM3mPcCyQwPUEee7MSvyyeMHoHN+/lFWuUNqePtQjOmZHap4CjhiebU8lP5nh1WzwMo9q4282VN/wsb0sZHYpwdnxji9nE2gJieOxJDoUhDGnykamvTXSKjo2UOnCstQlOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740697716; c=relaxed/simple;
	bh=joBGlcLd9Vxq/Nt9/lZmpQVzJB0vbN5RW6URD4nAPvI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MfzxjOoIE0ozVq3BXaT3tshu1D3EySJOnBxxhP2y2MEhBmAuRNXpECueDU6z7gfScP6xxDGWiMmxDDdbhhVPM8Xxia8cAbDhMIIwes9FUurhxWHWRA4eFvE8bZI7FBrCQM/8M0s1Q9zqFj2s9+y6dHzsnWB9pb/GXwKZKcAvApQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42143C4CEDD;
	Thu, 27 Feb 2025 23:08:33 +0000 (UTC)
Date: Thu, 27 Feb 2025 18:09:16 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Lyude Paul <lyude@redhat.com>
Cc: rust-for-linux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, Mel Gorman
 <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org (open list:SCHEDULER)
Subject: Re: [PATCH v9 1/9] preempt: Introduce HARDIRQ_DISABLE_BITS
Message-ID: <20250227180916.1ab6d957@gandalf.local.home>
In-Reply-To: <20250227221924.265259-2-lyude@redhat.com>
References: <20250227221924.265259-1-lyude@redhat.com>
	<20250227221924.265259-2-lyude@redhat.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Feb 2025 17:10:12 -0500
Lyude Paul <lyude@redhat.com> wrote:

> From: Boqun Feng <boqun.feng@gmail.com>

-ENOCHANGLOG

Why is this patch needed?

-- Steve

> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Lyude Paul <lyude@redhat.com>

