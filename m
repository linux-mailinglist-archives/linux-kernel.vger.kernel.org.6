Return-Path: <linux-kernel+bounces-401463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D333D9C1AB7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 11:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10FDD1C267F3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 10:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034E21E500F;
	Fri,  8 Nov 2024 10:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m9sTXmEz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a5DY6RyL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019811E4924
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 10:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731061977; cv=none; b=NaLLe2AInTt1eNJa9DlmF9t9DVDuW+p3sB1ZvPdyQt7Rxlmoziwo5f6s1lPOBW/qlWSm/04j77tX8aSaHB5lnILQeaJh468DguRc1XwpizkrOufpZAWOjeJX8nkfmwwNHDKUsb9vnuYg5MsXElxa/iGwWeL/kiyw0yWDywbNNl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731061977; c=relaxed/simple;
	bh=LcKAwSjv5Z1dRNKufRhjACYmla++QX+PDXyeASO5DKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ROmgBq+VKSnuD5/G9eEIWldxRN7HFOiw2QH0130DWuhUEtUN2GWj2IZcI3uR8oPEZ2qkKAcQ1NiXzjlwmRM/OJvxL1cIGfxN+bjS0+pMOW5GysSTPsORuuhk4wVO4ngZWQWpP8Ezf+o00DXhNsVgfcvBM5oFlcoUizv7OEHlnfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m9sTXmEz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a5DY6RyL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 8 Nov 2024 11:32:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731061974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J79gOJvhB5tRp7HnYvETBA8AX34Or6W938K5FMMyFqg=;
	b=m9sTXmEzo1OGqioxW833sOpy3qO95AweykCn9D31VdYuUiiZOE3XgmIHAK1gunqguIxxb8
	duPi80rbAJv74tSgAsg2HqdtbwW6e2C2aL9wVLnuCCOI5RMbi7bypHa2+YTpdMPm/Xq3im
	UInqD79dVTOCkl8g+UROv1UxjjbmxxPHPL/nyaEz8chQ5gCfNUTic5PZJIyR+6Jk+B2KyM
	0qbAmjgjIevPit6qOxzWc8N8WNHCHs2fc/WSeifAmKlb/30jErR3BfqQjjeA2rpvMklmkj
	Ae/9BVg55HBU6rNenmoZsHm5KcvERjxGDDHQEjpjDJKv6V8ZVSw56TFipHWPiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731061974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J79gOJvhB5tRp7HnYvETBA8AX34Or6W938K5FMMyFqg=;
	b=a5DY6RyLjc1BaL5rujJNW0ITFBElHzCIdjrDA3wURPTkmocNc304lO7ma32Ewh+3x0Khoe
	565c6CC71m4xqXBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, "Paul E. McKenney" <paulmck@kernel.org>,
	Marco Elver <elver@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>, akpm@linux-foundation.org,
	cl@linux.com, iamjoonsoo.kim@lge.com, longman@redhat.com,
	penberg@kernel.org, rientjes@google.com, sfr@canb.auug.org.au
Subject: Re: [PATCH v2 3/3] scftorture: Use a lock-less list to free memory.
Message-ID: <20241108103252.4EVzazwC@linutronix.de>
References: <20241107111821.3417762-1-bigeasy@linutronix.de>
 <20241107111821.3417762-4-bigeasy@linutronix.de>
 <Zy0m5TBz3Ne55syG@Boquns-Mac-mini.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zy0m5TBz3Ne55syG@Boquns-Mac-mini.local>

On 2024-11-07 12:45:25 [-0800], Boqun Feng wrote:
> > @@ -538,6 +567,8 @@ static void scf_torture_cleanup(void)
> >  
> >  end:
> >  	torture_cleanup_end();
> > +	for (i = 0; i < nthreads; i++)
> 
> This needs to be:
> 
> 	for (i = 0; i < nr_cpu_ids; i++)
> 
> because nthreads can be larger than nr_cpu_ids, and it'll access a
> out-of-bound percpu section.

And I though I learned my lesson last time.
Thank you.

> Regards,
> Boqun

Sebastian

