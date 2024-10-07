Return-Path: <linux-kernel+bounces-352998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F926992710
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 10:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45358283B41
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 08:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC74218C005;
	Mon,  7 Oct 2024 08:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="voBOfHn4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m7YVeewT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37C518BB82
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 08:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728290039; cv=none; b=sBj0lcWvpgknMoorrK0VZM79FJllE2cVkU0Ft7UYNQRY2+o44PfWHnBJzmSiGPx40Qj/t622rbkicoKJ+2DSmYco4jcw5Bl03Bn8XmKRzvzhuOS8wFEe3xa0xE5+1X7S8JHQrkHOea4NWiOe3X6I9gH9zeWzmauHinJo+mHgfI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728290039; c=relaxed/simple;
	bh=01lzTK7lgk7enfWa88zlSQLFcO17Q0f6ndXgFs5zo1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gcu0XvMemIa7dNW/S7Hx2CettFhCytYGMZsm+PUDOMwIefDeneV8TOzu4U2pBlg1jW4oK2uGXXHc4hDuDnvcU0jzmOJdfbZuIwK8Ng9Eb2rhItpLFXGVtAAwZoUvUNYVIJXkpgwCScq05HnBxKaIAXGozijn4b9Sg9IMpeiLmLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=voBOfHn4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m7YVeewT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 7 Oct 2024 10:33:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728290036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=01lzTK7lgk7enfWa88zlSQLFcO17Q0f6ndXgFs5zo1A=;
	b=voBOfHn4sw5XIQ7CwwinQQpCGHYkftjIx9eKxwoIKAbiuomDQyJpYZFKm3ApGMK4B7Xn13
	iaf3rl2Jy17Qz0a24QdRy0zoaOxIARaQFoo8rJinIOPMoxHXsyWdpc0dqgQiK3hbP9f/Az
	6Jz83XCzfUXDgwQMqf8+Y66rSicptBNCO63HQRhtV5pllm3aYKMTl6PkfGBws3jJjpaXn/
	+e6b9uyxgUry8TYnzV4GXGG/z2w6zDyynL70VbfGRsnnTzuiuiGPkHNl8R1UrWVeWLjwCG
	2zl7e4I9N8qHYJ64lXF7dPNWFHldWZlHu5HkBA1iNN+CF5C6mFgqqKIrQz+cAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728290036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=01lzTK7lgk7enfWa88zlSQLFcO17Q0f6ndXgFs5zo1A=;
	b=m7YVeewTDiaFfbAn62NpXnxe8AByYs/9Ghcyf+pjK0zKnsSklZDQm7Cxvbke0VRtJ1tYDk
	rpi8Zd/Z7BayzsAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, ankur.a.arora@oracle.com,
	efault@gmx.de
Subject: Re: [PATCH 0/5] sched: Lazy preemption muck
Message-ID: <20241007083354.MQeIWIdU@linutronix.de>
References: <20241007074609.447006177@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241007074609.447006177@infradead.org>

On 2024-10-07 09:46:09 [+0200], Peter Zijlstra wrote:
> Hi!
Hi,

> During LPC Thomas reminded me that the lazy preemption stuff was not there yet.
oh thank you.
I still have an older version in my tree. I will take a look and back to
you.

Sebastian

