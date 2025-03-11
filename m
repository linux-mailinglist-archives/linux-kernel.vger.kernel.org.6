Return-Path: <linux-kernel+bounces-556396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EB1A5C674
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 16:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DFAE189F47D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 15:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04BF25E83D;
	Tue, 11 Mar 2025 15:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pViIHUx/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NLb9GsqO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B19C25E83C
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 15:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741706451; cv=none; b=u3HipaZtddGwdflXeW1DTCJ8ikIw5Eh4MXBDFsq0yjWKK6l2g0FJpkIgL3GYxBqyhIV04nu714WDHmxgaAou0/+qzMRVoN0T4bRfpUKa8OXqgkswwIaQq7wakR92NgXrPBGx0zW9gJsT9nIy08a8jDuHShg7lnQCP6yuSAwdU4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741706451; c=relaxed/simple;
	bh=GcpDziY8qOx5YRGLqb/cRimpWOxsaBJxO50EW31p4Uk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EpE9evYo6nH3rq4BTKFCYALWmkEWHKMU83Zyg0Pu9y+H35z9mBD9WO5yuBJJrjGzmChFydgfYU0AXQeJ/nKHsnIgSXSDK912AYH/PZhGwDI7Bjmb+LLI+5kyLbig7te9FGoMGMn/p37EFmgUT2/7uapoDSA3ywE6AXqYKSNe0Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pViIHUx/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NLb9GsqO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 11 Mar 2025 16:20:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741706447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P3XptVuc2m+IYwJb7oAfuU9ofUsI8DrSGL83HXUys58=;
	b=pViIHUx/PXR4ILaNIa49JfY6VcD6xzYOVdhna8+OLpTUvavL0V3tBmjRI05zo8r7z8BUl5
	labnMkOe+X0h1cOXoSLlUlCl/VNOuDzy7UFVmc+fqjT+7eDNoSF4VTuxkJKxG8Mt9ACd2c
	Gw/JuFSkmfSrpbBztMjxDQI4+rJIa0CFr7w+MOfkTAnj79aU9IzZGgCk4XYCk4ly4iQu18
	7litSp7JgNkMw9GZhXaGT3OjKmXJfCeV90CebNZj/9U91Nj9dAtL8OWWhNqRbZFbyhQzQM
	fTiIPabXKpfmGoeAGbsZh7gl/ESohygwnfO+p2W2SJYsClOXIo96t/BP26kKPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741706447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P3XptVuc2m+IYwJb7oAfuU9ofUsI8DrSGL83HXUys58=;
	b=NLb9GsqOM3nhQShsrIH6WN16qfcSURgMvLlVDXjT0iKgqtbHoxfPZJiGeYxjTr9yc2vfXK
	mB2LMjuyeSFw+kDw==
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
Message-ID: <20250311152045.AqadBOG9@linutronix.de>
References: <20250225170914.289358-1-bigeasy@linutronix.de>
 <20250303105416.GY11590@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250303105416.GY11590@noisy.programming.kicks-ass.net>

On 2025-03-03 11:54:16 [+0100], Peter Zijlstra wrote:
> After that I rebased my FUTEX2_NUMA patch on top of all this and added
> a new FUTEX2_MPOL, which is something Christoph Lameter asked for a
> while back, and something we can now actually do sanely, since we have
> lockless vma lookups working.

I'm going to keep the keep the changes mostly as-is (except the few
compile fallouts). I thing I wanted to mention in case someone has a
simple idea: We have this now:
|struct {
|         unsigned long            hashmask;
|         unsigned int             hashshift;
|         struct futex_hash_bucket *queues[MAX_NUMNODES];
| } __futex_data __read_mostly __aligned(2*sizeof(long));

This MAX_NUMNODES will be set to 1 << 10 due to MAXSMP for instance on
Debian. This in turn leads to an 8KiB huge queues array which will be
largely unused on a simple machine which has no / 1 nodes. I don't have
access to machine with more than 4 nodes so _assumed_ this is the limit.
Anyway. I'm also not aware about the corner cases, say we have that many
nodes (1024) but just two CPUs. That would lead roundup_pow_of_two(0) in
futex_init().

> WDYT?

Sebastian

