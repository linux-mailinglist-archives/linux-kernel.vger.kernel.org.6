Return-Path: <linux-kernel+bounces-418312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 133149D6045
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 15:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC0352827FA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 14:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C1E70808;
	Fri, 22 Nov 2024 14:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MtKeHHIm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rhbD7aIj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FCC800
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 14:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732285691; cv=none; b=Lf0tWm8PeckRSDxbLLofSLyMGZPnpJ279eABqKrRW9mi2G4BlpWctpdp2/jBDOMycQyYTKedZjjSDN6BBObbAqOwToLXzwkT6uIfsT2A24Tn/67fFA1aYM5dBzkqfFABLAUL1TzQo7Y82mHpYQNgiYl1d90WJToA1XFeDCzvC70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732285691; c=relaxed/simple;
	bh=Ff+UZyO/JMj9DISe2UePaOTQblPds44n39t8KwMbeqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PKLMSgiEhuaBMjGIKYqbE86TBl2bwIqPtiAwwxrCiiYFvSF6evkzArxKp1SBy+rzy2r8c2osgT5lw3ZlwvSQfz/BExNvKYYenOuPoWlwFB2j9HFB6/ogYrK/DHCsPSk67kqEPHVcTvUy3gN4lT0/QQW1ylfGl+DFDbdce9WvMXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MtKeHHIm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rhbD7aIj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 22 Nov 2024 15:28:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732285686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g/PQb43MX+EV+Rlm4+ty7y06eu8hbzBoZm6Y4VLtEv4=;
	b=MtKeHHIm9VHY92ZpQyya0e1vdNmhTlkQmeTDwV+gUV4O+yfCNqZhOqz65jZjyrg1ZdbBAp
	AuJuotoiPLUV5KBKOa5Dj8ye3BZL/+4Sdu/l3aqtHipY5q19Q+7nZXEgIujAcL1ihKPzGu
	Ui3QHUlxM8FYla1Pohuin4+QMQsG7TRdD8vhKOVe4GyjNYyYoGJS4s/DvSKsuNL9MNtpLb
	8eYvG1gGRRnpkbroL7l6l/HRON58cPe5ATF8gUTzItd8hRSy6+FATfjMMJurPPUQGBmkR8
	9E1+bBvhkmw7J/y2medn3/+yX7x6EF54eeyW8pVQ3yNn+4JiFrK9wIM65DeQlw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732285686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g/PQb43MX+EV+Rlm4+ty7y06eu8hbzBoZm6Y4VLtEv4=;
	b=rhbD7aIjM0vCtRns4Qvm6CwnmwS9g1he5tgJiJ14gdH4gbPbh27lHt99SZhPsuAoncrEST
	d9UwfJha20VDQaDg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: Re: [RFC PATCH v3 5/9] futex: Track the futex hash bucket.
Message-ID: <20241122142804.7tGirPjt@linutronix.de>
References: <20241115172035.795842-6-bigeasy@linutronix.de>
 <202411221706.c9d399d3-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202411221706.c9d399d3-lkp@intel.com>

On 2024-11-22 18:08:03 [+0800], kernel test robot wrote:
> Hello,
Hi,

> kernel test robot noticed "WARNING:at_lib/rcuref.c:#rcuref_put_slowpath" on:
> 
> commit: 85bef61dcb6b15e3f68893e8bb8178f38ef4e58d ("[RFC PATCH v3 5/9] futex: Track the futex hash bucket.")
> url: https://github.com/intel-lab-lkp/linux/commits/Sebastian-Andrzej-Siewior/futex-Create-helper-function-to-initialize-a-hash-slot/20241116-230708
> base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git 3b49a347d751553b1d1be69c8619ae2e85fdc28d
> patch link: https://lore.kernel.org/all/20241115172035.795842-6-bigeasy@linutronix.de/
> patch subject: [RFC PATCH v3 5/9] futex: Track the futex hash bucket.

thank you for the report. There is a missing init which has been made
visible by CONFIG_BASE_SMALL.

Sebastian

