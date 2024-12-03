Return-Path: <linux-kernel+bounces-430007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 053689E2ACB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 19:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF966286A37
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 18:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415921FCF72;
	Tue,  3 Dec 2024 18:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P7ZbYoAc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ODByuAMb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7F21F4733
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 18:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733250465; cv=none; b=fwzzb7SK8Rl7MQN7V/JObTiWX7uG+b/dDrdJYj2yNTrVP41WByECJeAly4Wb+mqSb7UIBCdpYeq0ZPkedpZi3YJK8yDm+2Wo2hFKuuT2Lp4610cuL9yEiefJE7fiXlWxk0d4l+S2eCp+fAz/FDlxYbrwsT2E53nCrupzrl9S4o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733250465; c=relaxed/simple;
	bh=dO4ndMn3sZMgczB3oNRanGdyZHULJUiSlFaBzeB9zJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ruB8ermTAPrII02tbVEBLNvVjwNZ0HQZ9gNv5BvlKqVfYM7Q1M4McoCOmFjuimv/twIC2uh91zt1ENLtsByjjS63dPuHkQSV9QkcXAtGGBTdtcC00rap+idDXPZXFXlA8JpJMDKp9cHLsVYaaGaR5+YHvCvy9aeXQm0LY8hlIYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P7ZbYoAc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ODByuAMb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 3 Dec 2024 19:27:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733250462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4L6ZYZw1cI/9nLWodUSRVMbOnAoZR2tD6CT00fe1Kvs=;
	b=P7ZbYoAc5VW9lMu8fx9ykExmQt3RNYCnlcuzTJBxIa7tpwrFwEj+Q0iLumu7ULP6XKfTYd
	pHOLNenzxo/USE75fUJt3HtNf/tWAKY4nObpXvyYJ+rYsrTjoHbTwZLJPFFWDHmg261idR
	MaHU8CF3kjF3prjNhgDvqr+IwkiHHxGanN2/Yixwe0+HEJ0By+0yMXcX7l1xF91SocIc2w
	BivH24t5B9LKeSR/vkcbL81CtqnefRFY8Pw6I6f2lxCx4web8IzljwGIU+curacYA5QeJy
	Zxu4f7rcsgpJSVEKROFUpwsI2SBO4+OJfrOW3HmEzNdWaaQY+DFrLdHdwqrpOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733250462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4L6ZYZw1cI/9nLWodUSRVMbOnAoZR2tD6CT00fe1Kvs=;
	b=ODByuAMbqRkTkM8+zPzZ6T3Z5JvQtjUHnHlUM8MmSMChBWe0qSYzOzuEjviAww5mw0lVHF
	lSH0iYGYLq602OAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: Re: [RFC PATCH v3 0/9] futex: Add support task local hash maps.
Message-ID: <20241203182740.NQdnjPBd@linutronix.de>
References: <20241115172035.795842-1-bigeasy@linutronix.de>
 <Z0nX2olCQtSciY7-@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z0nX2olCQtSciY7-@jlelli-thinkpadt14gen4.remote.csb>

On 2024-11-29 16:03:54 [+0100], Juri Lelli wrote:
> Hi Sebastian,
Hi Juri,

> On 15/11/24 17:58, Sebastian Andrzej Siewior wrote:
> > Hi,
> > 
> > this is a follow up on
> > 	https://lore.kernel.org/ZwVOMgBMxrw7BU9A@jlelli-thinkpadt14gen4.remote.csb
> > 
> > and adds support for task local futex_hash_bucket. It can be created via
> > prctl().
> > 
> > This version supports resize at runtime. This fun part is limited is to
> > FUTEX_LOCK_PI which means any other waiter will break.
> > 
> > I posted performance numbers of "perf bench futex hash"
> > 	https://lore.kernel.org/all/20241101110810.R3AnEqdu@linutronix.de/
> 
> Performance looks generally good on our side as well. However, while
> testing the set manually with a debug enabled config (attached) I hit
> the following BUG (decoded) while booting the machine.

Thanks. That sounds good. Sorry for getting so late back. I posted v4
which fixes the bug you reported.  The new version has auto resizing of
the hash table :)

Sebastian

