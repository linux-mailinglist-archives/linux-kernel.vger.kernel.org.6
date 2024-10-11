Return-Path: <linux-kernel+bounces-360680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24754999E05
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 09:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 545EF1C20BB5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 07:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5E3209F32;
	Fri, 11 Oct 2024 07:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tb1XGb7Y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="895jXCVn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB23F207217
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 07:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728632173; cv=none; b=asaZ8MaD2K0PsbO1VIrlZh0VZFKosb9FjC/xOhUaaWW0PhvhPHyK9HZI7T8LkCSuv+CU7ccvqNVZxc+CPc8qvW2cdHPXgyBs1UpbJPgdn1vBPpW6v4f8R4MT1AbccARM9y7xOLRcUGPbQGNYsc39mFDu/8DLORaDFgJrcus8RGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728632173; c=relaxed/simple;
	bh=whySh61HgodXvQh0vqNlizeOAQpNCi7xdB+X+d9zW94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e0iLu9jGzhiBJwmfoH0EBErpJkvpBRQvWwfk+fJt2kbrgV4vtVQI7scGQVXIwSxhVR8jhWQI/M80dYCCmKH5kntKb14PEMC1rsLrK37C0hV5Aw8UqRl2VBgSY7Dy/nfAjRfGYm5oT35fLNVxHVtxEZ7rwNcTkA6uwKCchWgHjvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tb1XGb7Y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=895jXCVn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Oct 2024 09:36:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728632164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7dvx7jsEginLAx6CoxNWrWaKXiC/f26aLcG1G/Nbr40=;
	b=tb1XGb7Yi9n0Ry7kcXqpa5BDrImWMdTpr3nK7kPp7b0vW1mqiCWzwW9jCuL7ldSAnA70Vx
	0MtyYYyDn/cjOk7I8hMpFMqqnSQwNLgbvK5pNVU0zIGAIBxO37KgNyrAVmoxhafmmJ0VpD
	l3COggzjTidA6R2YxEozZiOneYzuCrdzSBscNDPvl/dqPfNFFaIu6V9kE+QyoMyvSXyra7
	z6gwHUoGpXru97V9Uz8I/qWN+L+Kyo67wHqHE6Sm8FsTZ/Oix3+T8lEEppH6rsP6Og1/17
	bLSzp1VIvfbBnO+IeRs+T1xXUA+rXZApa7W9lgefxGwcJE25G8y67k0s5FpmKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728632164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7dvx7jsEginLAx6CoxNWrWaKXiC/f26aLcG1G/Nbr40=;
	b=895jXCVngb/SiyPVyuip6AEXM53goYxo61mTj8iuhnMPKGst6XuZ8VKSIurOeOTp1EPKzB
	RtCVzv2XUfTF05Dw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, tglx@linutronix.de,
	paulmck@kernel.org, mingo@kernel.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, frederic@kernel.org, efault@gmx.de
Subject: Re: [PATCH 6/7] osnoise: handle quiescent states for PREEMPT_RCU=n,
 PREEMPTION=y
Message-ID: <20241011073602.7EmDWFkc@linutronix.de>
References: <20241009165411.3426937-1-ankur.a.arora@oracle.com>
 <20241009165411.3426937-7-ankur.a.arora@oracle.com>
 <20241010065338.sw4zZlbm@linutronix.de>
 <87plo797a2.fsf@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87plo797a2.fsf@oracle.com>

On 2024-10-10 10:50:29 [-0700], Ankur Arora wrote:
> > PREEMPTION=y, PREEMPT_RCU=n should not be possible.
> 
> That's a statement. Is there an argument here?

For my taste you should describe in your cover letter the actual problem
and what you intend to do about it. Then you should a series addressing
this issue which would probably qualify for all patches in your series
but 7/7 (the PPC bits for lazy preempt). 7/7 should have been the part
where you make possible to make PREEMPT_RCU selectable.

Based on my understanding so far you (or Paul) want to make PREEMPT_RCU
selectable if PREEMPT_LAZY is enabled _or_ if DYNAMIC_PREEMPT is enabled
with the NONE or VOLUNTARY model.

This series as-is made no sense to me until Peter made the snippet where
you could indeed make PREEMPT_RCU selectable.

Sebastian

