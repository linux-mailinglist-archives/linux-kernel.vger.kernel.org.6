Return-Path: <linux-kernel+bounces-369377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4D99A1C8F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 10:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1091282BA9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 08:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0436E1D31BA;
	Thu, 17 Oct 2024 08:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J4xlSpTd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hPrid67i"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A391D0E39
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 08:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729152286; cv=none; b=NeXDjbu9Q4100qOH6qLvqK8KV97C3gjdTfQDWpga7Dyq3rfFHI4vs+rtFNEGPDPawNp50Jt5k8HZFSvGDbrpMl0r0JE0IFEGKEdbwobLq0kITKw+0mFD6VjyeB8jcS8HWBWpEXTYeAzNCudlZEVWYXmuYJ4z09b6cIRFTn1kHEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729152286; c=relaxed/simple;
	bh=j3c8+NLAuYIaB+rFrTDZ2PAlAlizl3JHEfmDp9V3WBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iwE33jnPLKwz2qveRpe/rRlL9hpzxIRmWl675f6Wvbh3oxKYuqZ6yIraszQtzNe9PCGwsaz7BPJWgDtDxWUP55ZWnQXLmTt+U6US9FAh0wBsmDl6Rp8WRS5ci5eOfsW15AdmNiQBsn7ObAcFQBjmzKpici2mYDlcRYpgzhTOOWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J4xlSpTd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hPrid67i; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 17 Oct 2024 10:04:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729152281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qQvFbje6Y5bp3700D7ie90FmdPJUkfMdE2zUD1ht/DA=;
	b=J4xlSpTdn+81tVHB23YlpWq5c09JXE5+IfyDDxyKa1bYRdXQH597hrcNBvy9mJE+h7i8Vz
	FuNcygz+p9OwzC6dAfqDCllX3cAtzBgdskQvblJmvXkceBFt9VCjag/f7dCzaa/cLdGI0T
	eTYX/0rHRuqUabPtEAmXYu8HHgIBEA/0bE/4T6cVW5lPpD5kWHFGPnySAMjcuAHCTM40re
	hCewa7ePzQRpFYNzBOsLjyv4SdFS8VwhMKpBr8WMcGS1VBPae/8wLjX44VVFB8qDJU23d+
	TJyggYnj1CH+2u+zC72NcErezI3fMbGOdEuO+pab/cfutR1f5NQX+I7UYf1qNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729152281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qQvFbje6Y5bp3700D7ie90FmdPJUkfMdE2zUD1ht/DA=;
	b=hPrid67icuX9etcrtzCQxMpQVCKokq1ndjn9yK7PQeQaz/3VcIVe+LwWkHQ/TfwipggapK
	1ZZ+cRqeNnJIH2AA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	tglx@linutronix.de, mingo@kernel.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, frederic@kernel.org, efault@gmx.de
Subject: Re: [PATCH 2/7] rcu: limit PREEMPT_RCU configurations
Message-ID: <20241017080439.9od9eoBO@linutronix.de>
References: <20241010100308.GE17263@noisy.programming.kicks-ass.net>
 <20241010102657.H7HpIbVp@linutronix.de>
 <20241010104438.GJ14587@noisy.programming.kicks-ass.net>
 <c6cbc343-01c3-4a38-8723-cc44e83dedf7@paulmck-laptop>
 <20241011081847.r2x73XIr@linutronix.de>
 <db3b0a4b-bec6-4b2b-bb22-d02179779cf9@paulmck-laptop>
 <20241011144341.mQKXkGkm@linutronix.de>
 <dcffa722-986a-437b-abb9-af9f4de852df@paulmck-laptop>
 <20241015112224.KdvzKo80@linutronix.de>
 <87ed4hrp45.fsf@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <87ed4hrp45.fsf@oracle.com>

On 2024-10-15 15:13:46 [-0700], Ankur Arora wrote:
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:
>=20
> >>
> >> As for PREEMPT_LAZY, you seem to be suggesting a more intrusive change
> >> than just keeping non-preemptible RCU when the Kconfig options are
> >> consistent with this being expected.  If this is the case, what are the
> >> benefits of this more-intrusive change?
> >
> > As far as I understand you are only concerned about PREEMPT_LAZY and
> > everything else (PREEMPT_LAZY + PREEMPT_DYNAMIC or PREEMPT_DYNAMIC
> > without PREEMPT_LAZY) is fine.
> > In the PREEMPT_LAZY + !PREEMPT_DYNAMIC the suggested change
> >
> > | config PREEMPT_RCU
> > | 	bool
> > | 	default y if (PREEMPT || PREEMPT_RT || PREEMPT_DYNAMIC)
> > | 	select TREE_RCU
> > | 	help
> >
> > would disable PREEMPT_RCU while the default model is PREEMPT. You argue
>=20
> With PREEMPT_LAZY=3Dy, PREEMPT_DYNAMIC=3Dn, isn't the default model
> PREEMPT_LAZY, which has PREEMPTION=3Dy, but PREEMPT=3Dn?

Correct.

> > that only people on small embedded would do such a thing and they would
> > like to safe additional memory.
> >
> > I don't think this is always the case because the "preemptible" users
> > would also get this and this is an unexpected change for them.
>=20
> Can you clarify this? The intent with lazy is to be preemptible but
> preempt less often. In that it is meant to be quite different from
> CONFIG_PREEMPT.

A wake up with PREEMPT may not always lead to a preemption but will lead
to preemption once the time slice is up. With LAZY this changes to the
point that a preemption point will be delayed to the sched tick. Tasks
which are not based on the fail class (SCHED_DL, FIFO, =E2=80=A6) will rece=
ive a
wake up right away.

If in the long term NONE and VOL goes away you could argue that everyone
using LAZY + !DYNAMIC is one of those. If additionally PREEMPT goes away
then you can not. Therefore I would prefer to have the RCU model to be
selectable rather than forced. While !PREEMPT_RCU may save memory, it
also disable preemption for the read section.=20

> Ankur

Sebastian

