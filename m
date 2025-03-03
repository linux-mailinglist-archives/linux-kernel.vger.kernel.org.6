Return-Path: <linux-kernel+bounces-542335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7ECEA4C8AC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8033175108
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C93241675;
	Mon,  3 Mar 2025 16:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IZZSZc5n";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5vhqhchG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF628214A6C
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 16:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741020020; cv=none; b=ZYyche6x1R5TZiIvdK6fhJmC3Me20cyxLZo6zMjLyKYBuDndc+82cs3SRMm1eqj6xI4g/9MH/4HxkjsJErdcRGB3vHthSe0G4PNF/k25aBGedHEYEbpfM4yoTgTHMJaZOWqBTWYiJCb+2EaHs4MFn/kr+rpmZIlb73bz0oubiEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741020020; c=relaxed/simple;
	bh=QdkxP77BRcAwMbcPIB2MHF28HZIagGB9EjdrZfFXb9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dE/NGRDNuefxLJoCLvA/YhmqrKkQsXKx947FVa2nzmM3f3JWHq8mBag/Dh9mA1zcDZp/w9aSZgiY6RV2CvGZaRQJWd1LkfIaQ+DQEijmxxsg+EbhigUL3W18vF4z7B4VjGIg0IQO4Zer7w4l2b35zEP1imP/02CVwiilzZQ75bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IZZSZc5n; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5vhqhchG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 3 Mar 2025 17:40:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741020016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EmqmOOmykWxXuSiFE2JPHQqW/PeacKQl+YUmlDiAnxE=;
	b=IZZSZc5n2KjHMruuBMr93YuvOnFrK7JWoCKL6wt7Dft5LTWwrFP+m6K5JLs36zRUMxfBQN
	lKiA27+Yayjqd2tMHR830eNUgqHaveh5TWESVP2AMTV0U+wZFITb/xtMkL8lHvZ9Cz9cGw
	X8Ht6A46LtcBFfOpjHy5wcm7+++0tlBenTNVQIxz3t/oQR9LQLrJDI+uJspGqN5QvFt2Bv
	b+m2i6DI0qMXc4PJEDJluVPATkTPeGsPK3wTZGmgNsptD29NeDL2UXg6xhOb+KLzaD9qHc
	qQqp1QAAohJusoGNffmCOGQKvZl62cpidQJeYKx5IXmsBPZ6DzfHWw2mkbU3lw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741020016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EmqmOOmykWxXuSiFE2JPHQqW/PeacKQl+YUmlDiAnxE=;
	b=5vhqhchGQ0/YQsKZyBff7nyRTUugwyksZC+naxgMmc38oROnIf80fYdtsaNZXjc/Bm9toS
	NFvZV3M0fPfXesCw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org,
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v9 00/11] futex: Add support task local hash maps.
Message-ID: <20250303164015.HHfy1Ibj@linutronix.de>
References: <20250225170914.289358-1-bigeasy@linutronix.de>
 <20250303105416.GY11590@noisy.programming.kicks-ass.net>
 <20250303141753.tF-FoCm1@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250303141753.tF-FoCm1@linutronix.de>

On 2025-03-03 15:17:55 [+0100], To Peter Zijlstra wrote:
> > Anyway, the entire stack builds and boots, but is otherwise very much
> > untested.
> > 
> > WDYT?
> 
> well. Let take a look and do a bit of hammering.

so you kept the q.drop_hb_ref logic and the reference get. You kept the
private reference but renamed it and hid it behind the CLASS. I meant to
do it, just wanted to check if you had another idea regarding it. But
okay.

You avoided the two states by dropping refcount only there is no !new
pointer. That should work. 

There is no refcount check in futex_hash_free(). It wouldn't hurt to
check futex_phash for 0/1, right?

My first few tests succeeded. And I have a few RCU annotations, which I
post once I complete them and finish my requeue-pi tests.

Sebastian

