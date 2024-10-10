Return-Path: <linux-kernel+bounces-358780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0836C99838D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 12:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFC791F23C5F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 10:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF22A1BFE17;
	Thu, 10 Oct 2024 10:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yZJ9IR67";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C+ZK8Irb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E331BFE0B
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 10:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728556023; cv=none; b=WT28z/80HkLGZBW+kCEmwBeQZlmSgiavnCVQedwd+J7TmkgomKg9PcSKCKUfXCdhtQrybQLkl23bRDBMGEXHJ62H4u6WnJvAc3+TTNehVJCfpdz5Y9rxxRD5Fhc189PCY6neGfFD+eUIOFy3322REQ2z9fUHqxT84J3/vvcwPHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728556023; c=relaxed/simple;
	bh=Zcwqr+AwcUDSNxX0xkLd+10HDTyg1jPzohbE6jwSFwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pTZIRtnAbAgjvrWzCEps0Spk8L+P5Fjb7FfYxIRR0ijit4LwWo5ECLm6uVzHBDxWAMFQU3lwaU8+/u+Xw4SsK5u9XS+VDx650jmAVw4T+7EAvEweJxrYRoqwdThw+xsD+9KCzXbN4aWE+x1lryObqq80OfTxOcpi3MIMZGL1pmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yZJ9IR67; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C+ZK8Irb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 10 Oct 2024 12:26:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728556019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tnezkotHKXVjhl9YICjV8wtVMuR62azVKg2NoQ6mASU=;
	b=yZJ9IR67ywRbn0fjvy3qXDFY566Ze0RQ3aKxzTMKVKxQQxBS03qNHuxIY5OR3h7+qPBbn6
	lC78IgtMhQ84xcy5A99M3iTGhDaiZlWLlNvZB789q5DkXtjHlVQqkk+Q68sFZ66PC6Oc4R
	X3tM8pHDEZyc/XMmQ50MiDGGLOmZdAqOqLDekJ8aEjhziy4WRM7dUneMQSVmDnCsF5AHvE
	l8AUA3Yi6wGXHsYuaRhCpq4hnYyDXZFuKLALCjjJZH2RPhoKgNJDZKDVZElga2Oh1hfSrj
	NBWoR+3NZinOHksdCm3IFzhVW0JfcoufD4lgGMkvWUpOxb6R0q0fQEq+u9sfNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728556019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tnezkotHKXVjhl9YICjV8wtVMuR62azVKg2NoQ6mASU=;
	b=C+ZK8Irb7v6/Rv1Souxa3qMghds6shfwpCCjXXhC9qPmqBCymgDAH9M2vhQ/CXIro3Hr0X
	WfGJg+vl6DnHPtCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Ankur Arora <ankur.a.arora@oracle.com>,
	linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, frederic@kernel.org,
	efault@gmx.de
Subject: Re: [PATCH 2/7] rcu: limit PREEMPT_RCU configurations
Message-ID: <20241010102657.H7HpIbVp@linutronix.de>
References: <20241009165411.3426937-1-ankur.a.arora@oracle.com>
 <20241009165411.3426937-3-ankur.a.arora@oracle.com>
 <20241009180117.GS17263@noisy.programming.kicks-ass.net>
 <37af80bd-a54f-4ee4-9175-6f0f27b685a0@paulmck-laptop>
 <20241010063207.xIrynIqO@linutronix.de>
 <20241010081032.GA17263@noisy.programming.kicks-ass.net>
 <20241010091326.nK71dG4b@linutronix.de>
 <20241010100308.GE17263@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241010100308.GE17263@noisy.programming.kicks-ass.net>

On 2024-10-10 12:03:08 [+0200], Peter Zijlstra wrote:
> >=20
> > I can't deselect CONFIG_PREEMPT_RCU=3Dy. This is because LAZY selects
> > PREEMPT_BUILD and PREEMPT_RCU selects itself once PREEMPTION is on.
>=20
> Oh, the entry isn't user selectable? Fix that perhaps?
>=20
> -	bool
> +	bool "Use preemptible RCU"
>=20
> Or something along those lines -- I forever forget how Kconfig works.

Oh. Well, yes. If we do this then it becomes suddenly selectable and
half of the series makes sense=E2=80=A6
But as you said, this complicates things.=20

Sebastian

