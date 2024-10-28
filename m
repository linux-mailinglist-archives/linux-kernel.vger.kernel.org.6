Return-Path: <linux-kernel+bounces-385528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DC09B3836
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 18:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93F1E1C22338
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 17:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4E91DF74D;
	Mon, 28 Oct 2024 17:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uVTPVvCz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rDZ2YPNB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70161DF735
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 17:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730137815; cv=none; b=dV/jkLYlZU0WBgYU8yejKctuuZKQErOFzW7Z6EqOMapJpwxjgMTaIcOrT8XD24xUMYGtydTOAL/PIzJHaF9b0Ep3XPB4fEaWwKNRhtAdgC1uCk7lR0zZjXKAz58bUurT52+oZCixiftLzDim2XgQc6NJfZJud19GAL9snFnvcV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730137815; c=relaxed/simple;
	bh=am9FmeupZaSwxqmhev2j2lFZGvkVdGdy2c0oNmEN1FE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t66UPcBuKiNXViSzdE1NMykTu52QgOTcSP++jGl5qkZBVM3XIsKhnVIfYAdAwiS9jFsoPFyoRXU08KyaPVOTnGh/ckSNkh5bOxH+rFBJboUAamEU5O7SLRv5gIm7fMw/fyJ0DV6cRuRJNbsXFunYdAw/FzOffOlXWdN7AvpECOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uVTPVvCz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rDZ2YPNB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 28 Oct 2024 18:50:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730137811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Uablt6bygIdi/EqgP/WcAcr3ykXK7+q/9dJRlPm3vRQ=;
	b=uVTPVvCzLuSI5qgw1ByMFFUzWeyBMQjS0MrqQEaZPgQUdyZUu97wzfksirDdRXQhfy2qK/
	PIzLDIYcmYuwPDjLs3OAoDq/FU5dejwO/KOpZKKZtkytFFzDsCkNBWR3Y2DDxQ9NtXOCyA
	Pk3sDD3+MpqcVT66Q8Id+BjwQT0lbz9T+cB9PcpI3QoijQgLvKPuLHal2zOIeFCdV3f9QP
	IzdEySOPcuWivELHTsM45zdihuMI1wpTMdx1g3VNtp/B2FwyMRTbhBq/LykuyMT1TB8xCS
	JePaUjbnf1T65XIKUqdiCIROdBMbfrepPLoapA3XJL6RUrD/4EzPv2f2rcDzqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730137811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Uablt6bygIdi/EqgP/WcAcr3ykXK7+q/9dJRlPm3vRQ=;
	b=rDZ2YPNBCM6WXzKa7nk/GVlu9dLZtinBegi8U3hQtwJteyYTuy90ERDRVRrSLRP8Gg4v6t
	SNcQZL4HMOv1uABw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-kernel@vger.kernel.org
Cc: =?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: Re: [RFC v2 PATCH 0/4] futex: Add support task local hash maps.
Message-ID: <20241028175008.lgdGYYtp@linutronix.de>
References: <20241028121921.1264150-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241028121921.1264150-1-bigeasy@linutronix.de>

On 2024-10-28 13:13:54 [+0100], To linux-kernel@vger.kernel.org wrote:
> from time to time and I haven't seen it using the hashmap. Need to do
> more testing.

booted gnome and did a few things:
- Total allocations: 632
- tasks which never used their allocated futex hash: 2
  gpg-agent and systemd-journal
- Tasks which did not terminate within the measurement: 85
  This includes gpg-agent and systemd-journal
- Top5 users of the private hash:
  - firefox-esr-3786 used 215985
  - gnome-software-2343 used 121296
  - chromium-3369 used 65796
  - chromium-3209 used 34639
  - Isolated used 34211

This looks like we could attach the private futex hashmap directly on
fork instead of delaying it to the first usage.

Side note: If someone is waiting for a thread to exit via pthread_join()
then glibc uses here futex() with op 0x109. I would have expected a
private flag. 

Sebastian

