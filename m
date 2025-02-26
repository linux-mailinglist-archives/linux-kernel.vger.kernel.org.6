Return-Path: <linux-kernel+bounces-533336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9D1A4589C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 09:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C648E7A91CE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 08:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D521E1E18;
	Wed, 26 Feb 2025 08:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PbvPLbqk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Skl5oxJL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C85E1E1DFA
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 08:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740559233; cv=none; b=SbLvHFETEhznqFU/NgRXMC+GSjdeC2/czEUxGdGenN3eYEhsQDdRKqdtjQZRKIiJkN3Suvx1D83xjUjTTgsuNaKWZw4/PVRQmfGMrmhTPJvVJ+iPZdMByaPYdXDv0QhFo7z8pTQjlfq0k22kbCdNJOCvtzNgmZKigEwlLR/DdXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740559233; c=relaxed/simple;
	bh=BFXRlMltLpsJGq1TFtysWuABxzl7LDTPA2W5fyGGy/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OuMlj/swMOxcFW8k+RW4XClHibx3hf78DVkvIH6UmeU95vPfYi5PIHPnET8JdCVlDjY+RoWl2afCZa4j7iqAOkQ+RM+4AfPRRmSM8Hu++nLF6xSnCKKIsU+DjUbHtzB+rIG40RVlww8UHrqe8IMsDoCMIivvr63j6q2xnUrKK4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PbvPLbqk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Skl5oxJL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Feb 2025 09:40:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740559230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B2KcQDXl/HfwbqMhaaPuOFbhbYmPrfwlA8REnYAWHWE=;
	b=PbvPLbqkitSl3BPbnnY41LJfduEsQwGDlT1bapMamKyuoRmyxUpc+rTaycqZasH9bNDIto
	ugaTIv/AacJX7ec16+8esnAXFNdbiDKXNnx4OuqCES2WRKbX0UdEKXGqHsWh7MrhvygrZf
	O+RyphLauh02Ej1hlbo9wS2rmOBXQDL/JgYVar/Sczy25LzmNNS8dF5D6vA4U8BC1y5kPq
	Zzav/l8OfMirZLHF6HqME4lgNKoIj8HcM/L/JVXRDyzT7LVd6RmrlOa+F6uPRqJgL9EoQk
	2/qJ4xnqkZlGcwbNiKKH9v5qLlttM/Um7k9QEyAdp4HB/vQF1ZhdtNqV8IIMCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740559230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B2KcQDXl/HfwbqMhaaPuOFbhbYmPrfwlA8REnYAWHWE=;
	b=Skl5oxJLhWnVcZq+fYhWU8Dmo2+2+iUss+RGsSOuNi2SK2L1/4jrR/Rr6AIluhhReqkk20
	Kyq2hlbD8qFVt5Ag==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v9 01/11] futex: fixup futex_wait_setup [fold futex: Move
 futex_queue() into futex_wait_setup()]
Message-ID: <20250226084029.iGLKxrlv@linutronix.de>
References: <20250225170914.289358-1-bigeasy@linutronix.de>
 <20250225170914.289358-2-bigeasy@linutronix.de>
 <878qptf7g9.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <878qptf7g9.ffs@tglx>

On 2025-02-26 09:15:02 [+0100], Thomas Gleixner wrote:
> On Tue, Feb 25 2025 at 18:09, Sebastian Andrzej Siewior wrote:
> 
> > we could also make @task a bool signaling it is either NULL or current.
> 
> I have no idea what this change log is trying to tell me. It gives zero
> information what this patch is about and the subject line is confusing
> at best.

This is meant for PeterZ as this should be folded into one of this
patches on which this series is built upon.
The argument "task" passed to futex_wait_setup() is always current or
NULL. The latter is only used by io_uring. So instead getting a task
passed and assuming it belongs to the current process we could have a
bool and enforce this.
The problem would be if things change later on and the passed task does
not belong to the current process hierarchy and would not share the same
private hash.

> Thanks,
> 
>         tglx

Sebastian

