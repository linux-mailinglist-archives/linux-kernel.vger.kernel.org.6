Return-Path: <linux-kernel+bounces-360719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D2A999E9F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 09:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F2401F248CE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 07:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272DC20A5FC;
	Fri, 11 Oct 2024 07:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gCOrWPcQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5BexOFRm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D573209664
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 07:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728633528; cv=none; b=Vv2U1UqrP0Q4hf2g0YIrtrFj9umpzwbld3TbuGTxcR0TqaQlKN5vkaf4C7oT7OD2yIC58rTVdH7Kq0zheMN3mt7VFRHGCBs8uD3j9MOs9WG2JnTyoB2/A8GT95+BFjNt+aEDnmCpxXjobxLcYFdbePgYX+c970PanWR0h4CA6Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728633528; c=relaxed/simple;
	bh=WiEXSt+9JX0aNkrQ9JlLuemZT1ICkFVCqU2Suh9wbvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P4czU0sFwtNGZXP2IlscEeG9VI9xgH31/Xa7zLeCf83vBPPtNau6KpghkXd6sUXQXLgp9xC5fRPzbrMxGeXIwtJBk0RHeLrs7hbYJba7ribu5Wuep4NGwcxcFWUYC2xeQB/a27l8HuUE1Adpkl25qDG1+EmWce4Y6F4FyhLjb+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gCOrWPcQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5BexOFRm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Oct 2024 09:58:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728633524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zueu+WricwTTZY5O2D3GbYsJ9exbbDuSMHoZiQ58xhA=;
	b=gCOrWPcQzFz1rRQPL+kzwI/LDEJ7IjlWOKpHId6cA12VuvVi8gkpkMsBngzuAbZU0UtbpO
	bWEGfGSx/Mdt3CE89zc1ck5vFeozAYTzzfdiwvfylwBA2jZAUHPrWDZhrSKmvWu8U6BAOV
	z+TIN1kknczsQqE8E4YG5B+GyknxAxTOKvQJ4mVRm34Tef2PJWZET52oL9MDgs1qEeUhUp
	y15f7fBvasF3vCK3HmMoUE+LphAb83Zr+wC3DQYrtatyMekroMLp4JI2J+CP5rd5nK6Cly
	TvLakuXTqLmpOxFjYCOuNckIKxrmus/IgZT5TM0xyZahUTDmEV+OJqPYx/sbRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728633524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zueu+WricwTTZY5O2D3GbYsJ9exbbDuSMHoZiQ58xhA=;
	b=5BexOFRmQ/3fgvSaJpYBpPEgI8MkNE3xrzGRhKZq8y2SaVgmwHtBEBjjSGHjoblXuXwLKw
	/wDtAy+8bWyTcQAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, frederic@kernel.org,
	efault@gmx.de
Subject: Re: [PATCH 2/7] rcu: limit PREEMPT_RCU configurations
Message-ID: <20241011075843.WABHhY70@linutronix.de>
References: <20241009165411.3426937-1-ankur.a.arora@oracle.com>
 <20241009165411.3426937-3-ankur.a.arora@oracle.com>
 <20241009180117.GS17263@noisy.programming.kicks-ass.net>
 <37af80bd-a54f-4ee4-9175-6f0f27b685a0@paulmck-laptop>
 <20241010063207.xIrynIqO@linutronix.de>
 <20241010081032.GA17263@noisy.programming.kicks-ass.net>
 <20241010091326.nK71dG4b@linutronix.de>
 <878quvamjm.fsf@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <878quvamjm.fsf@oracle.com>

On 2024-10-10 10:35:25 [-0700], Ankur Arora wrote:
> That's odd. I have that exact configuration (PREEMPT_DYANMIC=n,
> PREEMPT_LAZY=y, PREEMPT_RCU=n).
> 
> Can you share your .config?

Sent offlist.

> Ankur

Sebastian

