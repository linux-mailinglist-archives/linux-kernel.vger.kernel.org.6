Return-Path: <linux-kernel+bounces-561459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3125A6121B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 14:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C179E882217
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 13:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A28E1F4169;
	Fri, 14 Mar 2025 13:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YIUCJFQQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Vbbd0stQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCA92E3398
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 13:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741957823; cv=none; b=AvyHr77xB2wcygUCHQKBXnI+r79w7Bp5WJYVQ6cHsWuPvCzlGTUtF0+CM/aBFSdc2Pa9aeTrm6cjfQojA2yt+y7dbQKiVI9YcfIQc/6zn/NiyTNa6odxNzO2Ao/NEYqdA7+RXgET1s+laBOhVxBSk3pmStKYMSGrNbK/24lSxR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741957823; c=relaxed/simple;
	bh=EA0qdPGUD2lS0ZauKz2Z2wdeIa731EySFkiViGuC9y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hn185HqOIZ4SUTF8CSeXuxV60GvpS4QHzDnmPlVpXyFIkKRtAExQkQcyu+lJXmkWK1nvhsGfuthz5tbqQCaN/yoLJ4xJuwVrf7SSHwGt4WsNcl4WCiDAAZc/ctPzo1Rr3qdBVl+d/uQurgcVeLvebIRncVokWEWcnz8ZQ1yReXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YIUCJFQQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Vbbd0stQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 14 Mar 2025 14:10:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741957820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eznsYR8qScvWc0ljO5BhSDjnnLWmM748Zmb8ZXYo+Vo=;
	b=YIUCJFQQRkVXgCj8loHxE04hy5lux1TB3MxJ36bJ9kQBbNUQVcXzYg5CwQCIis7DCJiRPS
	yVtpGoEzpp6K1/RUsPG4CM4CoCRLzm7NanysGr8inpMfUhr0oaOTD4rnEDXispkhM8lUgn
	nhyVV3UnuViMID837JkJos1oSsZimizTH0hbynPkZarT4CbWyH65oMRWrCYE5o+HaP28Ak
	6fljVDV2WO9eR6apw5DtEzQLiM0d6eA4gNNZ6MX4E3vIGSxod0wqCffOztWG3JVr6e12UG
	v3mIXFPfwWsExYIugrBZkfSyIoa4fjL3ao7VroQ+HYn7EMXHZFrr7j60vgJVWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741957820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eznsYR8qScvWc0ljO5BhSDjnnLWmM748Zmb8ZXYo+Vo=;
	b=Vbbd0stQFw7ysGGlj0OSfYc+osK1JKpdJa3zP4AhNY0NXhk56z8991ui0UdYttlFFvRHoz
	509A28sh9rFQWeBQ==
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
Subject: Re: [PATCH v10 15/21] futex: s/hb_p/fph/
Message-ID: <20250314131018.YAFJq53Q@linutronix.de>
References: <20250312151634.2183278-1-bigeasy@linutronix.de>
 <20250312151634.2183278-16-bigeasy@linutronix.de>
 <20250314123650.GA5880@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250314123650.GA5880@noisy.programming.kicks-ass.net>

On 2025-03-14 13:36:50 [+0100], Peter Zijlstra wrote:
> On Wed, Mar 12, 2025 at 04:16:28PM +0100, Sebastian Andrzej Siewior wrote:
> > From: Peter Zijlstra <peterz@infradead.org>
> > 
> > To me hb_p reads like hash-bucket-private, but these things are
> > pointers to private hash table, not bucket.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> Hum, do we want to fold this back instead? It seems a bit daft to
> introduce all this code and then go and rename it all again.
> 
> But whatever.

I kept it separate. I can merge the way you want it. Your call.

Sebastian

