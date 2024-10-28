Return-Path: <linux-kernel+bounces-384643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFE39B2CBB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 11:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 982DA1C2192E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 10:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DAAB1D3648;
	Mon, 28 Oct 2024 10:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Db66mUDV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9Egw9xh4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C2B1D31B2
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 10:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730111071; cv=none; b=FnoP6palmK5XBRb57OHEpltta4Rf1c67w+CxnN+bGz//1/h4G2Z6fp9gSBU/j31G6IwdLJk7RVg1U1+aA08EUWoV7++QoRnWEJV2qUyHGKujx9k9Dh2SKDplg8MnaLyEw3Gw+UsomLNZf2gtnttQGLEyb+++JXsC9+Y46mkas4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730111071; c=relaxed/simple;
	bh=25A/dnz9vMAZKq1Al/87FPz2rLwJeOhCE2JInwfbuvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VjrnLCIJBikrq+XwKK7GGFCWLxc86nOcDVEtYp7dkG215tjuLm2QtEe73qu0yy7pkXoHq8oSToX2rrNWLEec11Ndu9NhaGtaoeuZ3pFg47ItPMs7bUWII/EhlIz0jKLMA43mSecL3kB+hDkvIZgGdm9500//yVPi1S94TSCLFAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Db66mUDV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9Egw9xh4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 28 Oct 2024 11:24:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730111068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mPjkMvVki+4RsCT6VVKdMQ+FzkDRmydq2kXD61JKTdg=;
	b=Db66mUDVelAuBT/wA+jWdsW5ZnfOZ4EGEIPBG7uMqGwsbPvp+NWL05D0z5mw19VhW167+e
	iMKvAvscCPpkdhrLwgOx/Dy4tiEpvqAJzszIgTBtdgmWVZpm5jPDoYMvlwUhdcPneWEM+G
	uITELuMg5mXC+Yrjysp/L68lBq4eAYbwACAjbcJHs0qw7djP1jqoH6jrIc3Fxp0MZE/HNk
	jOzchoDLmJgH9rIbEXD5XVDr7wiKNqvNUMAb82JswLQwa6T7rNflrtcuZNULzehwLKDS26
	3Mp+djtps3I2mud79mgWu3bnreWk4O2XGROgFulxY9WStVTTxBLPifYVXBYD1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730111068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mPjkMvVki+4RsCT6VVKdMQ+FzkDRmydq2kXD61JKTdg=;
	b=9Egw9xh40zEHEvwiMJIaa0/oYIu1E8ahIJ+cWrkXVNk0sTcbsuqO3jTOVfB8U5l/vbmyXR
	KsP2uJRCULT65YAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org,
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: Re: [RFC PATCH 3/3] futex: Use the task local hashmap.
Message-ID: <20241028102427.rhVmBDLD@linutronix.de>
References: <20241026224306.982896-1-bigeasy@linutronix.de>
 <20241026224306.982896-4-bigeasy@linutronix.de>
 <20241028102253.GN9767@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241028102253.GN9767@noisy.programming.kicks-ass.net>

On 2024-10-28 11:22:53 [+0100], Peter Zijlstra wrote:
> >  struct futex_hash_bucket *futex_hash(union futex_key *key)
> >  {
> > +	struct futex_hash_table *fht;
> >  	u32 hash = jhash2((u32 *)key, offsetof(typeof(*key), both.offset) / 4,
> >  			  key->both.offset);
> >  
> > +	fht = current->futex_hash_table;
> > +	if (fht && (key->both.offset & (FUT_OFF_INODE | FUT_OFF_MMSHARED)) == 0)
> > +		return &fht->queues[hash & (fht->slots - 1)];
> 
> Perhaps add a helper like:
> 
> static inline bool futex_key_is_private(struct futex_key *key)
> {
> 	/*
> 	 * Relies on get_futex_key() to set either bit for shared
> 	 * futexes -- see comment with union futex_key.
> 	 */
> 	return !(key->both.offset & (FUT_OFF_INODE | FUT_OFF_MMSHARED));
> }

Oki.

Sebastian

