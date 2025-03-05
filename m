Return-Path: <linux-kernel+bounces-546341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E6AA4F971
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0747E3A66CA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE9E20013E;
	Wed,  5 Mar 2025 09:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qFkZkqOB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9732khKQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3000E1FC7D1
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 09:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741165362; cv=none; b=Jgnl9TAHjbqMzTWarbEu8OMAvUBvArjH87f6k6u9d08+ARe2gkGX1j79r3onTSBWMw5yY74ZKpymGf7s+5oZPFlOFv6NpgUkTN6vgFw6wkc1xdy0dvHcho1SAZhUxSIxlln789PWCeJlO+34vzgie6xhw/b0ejZ2NyiY77bb38o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741165362; c=relaxed/simple;
	bh=/55WYkTyMJhM1DoK8DRZUOaqBCB7yJjGbAuaGgYFSB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iSh7r/cQ/a9k+x3Hdmapn6/47nBNwpCghGMiPJzBNteUqrPfA4BtAx6he2VcFSGrC3Xzzxy1sWdKv/StqOK/Bs35iySFBQ9qlMxsY9rJRFJW++8xSA+rq7ecCGLLFcM0utyLNOY8R0EHQu9ohZg5APcXQxOdKmZX38hVio2c7y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qFkZkqOB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9732khKQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 5 Mar 2025 10:02:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741165359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/55WYkTyMJhM1DoK8DRZUOaqBCB7yJjGbAuaGgYFSB0=;
	b=qFkZkqOBhxBEC/VDil3wkpOejAYsG7xsfuzAHj+8n19uiiz7qYmK3TvjAkFdZ7PSSPQNUE
	UQvXyyw1kaPnkzsSnhAbASA5p2OoSBEAyFZPz+DAyU4/al0OD81QFU0N7U6WrPU/YhFkU3
	nvRvTr6H0vLM6a94jvxkXUqezVasUAScq299jGBIKop6pJ3W8K4JIhMuMUy9gOgzJNNKEH
	KiWYahXMgpJ1WmnBVPHPaxtdCWWpnep8gnhP5JAvmpO619XdF/6YmItrktd/oa51s2SSm0
	VgR0URIpN4Re8yDIox1qu5n4m/CB+OECQPxfLiFCH7H/84YwmMCdquksTuZJuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741165359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/55WYkTyMJhM1DoK8DRZUOaqBCB7yJjGbAuaGgYFSB0=;
	b=9732khKQwy8mHehA8LNEGagcp0F6Txdq+mIOMkKMHjUtl42UcWrOIbJNGF/PgpoTkTWpn8
	N8Fg9dKv7U59pbCA==
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
Message-ID: <20250305090237.2Q9GwRA1@linutronix.de>
References: <20250225170914.289358-1-bigeasy@linutronix.de>
 <20250303105416.GY11590@noisy.programming.kicks-ass.net>
 <20250303141753.tF-FoCm1@linutronix.de>
 <20250303164015.HHfy1Ibj@linutronix.de>
 <20250304145837.a8g07J-k@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250304145837.a8g07J-k@linutronix.de>

On 2025-03-04 15:58:39 [+0100], To Peter Zijlstra wrote:
> hash. That is why I had the `released' member.

The box was still alive this morning so it did survive >12h testing. I
would bring back the `released' member back unless you have other
preferences.
Depending on those I could fold the fixes directly into the patches and
repost the whole thing or prepare you patches that can be folded back
and send those.

Sebastian

