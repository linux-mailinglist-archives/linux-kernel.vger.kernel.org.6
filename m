Return-Path: <linux-kernel+bounces-562768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C824A6329B
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 22:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B298F3AB6B0
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 21:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754B7197A7A;
	Sat, 15 Mar 2025 21:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="j81BZ2W3"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B52863D
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 21:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742074372; cv=none; b=O537IvYL1Jit3Y6GR9WK4l0V0PIE6S7cPn9XjxXG8zU5xJu6TRUCGJRv+CXkoAGTq1TmEEsBtgDnfhA7Pdoit94ZzcrHovx5hp5vHOoPP0zj4svmhNRFyy6FXcGyshK4wsoAKychUtWeGLgTzCUAr4W2J035bi42hjBxOHWS2HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742074372; c=relaxed/simple;
	bh=YMsycZTf1sZBDRojULuAjbtuXXkm2cKLjgcE+aLOlD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BrOg0mJq2MrAmusx19mUeW09muvG/MdhlN8gTqDLbEaEj9ymwfa4h/TkjYwheVG0gnI/rapjLBwurRnJrd6wopROHZQkX+FLatk3Nk2pEYf/9RnMXfldrIkKQ66+xTd8nyuL0IPzuz7qf5JlQX+8HJhXNKEk189okxPsoGExlk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=j81BZ2W3; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 15 Mar 2025 17:32:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742074362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uCfnrpnGg5/zaEOTvXR+A55okyUosFX4hHyaDSJs95g=;
	b=j81BZ2W3bcDGHLUvkHlnge58PDF66akAokecX4BFCDEin9xTq7y2TbBGGoAeIBdFLb/POz
	kC2g1gpympTG+OY2Jjji6p0hHeQOe0+Yxlzbo/92VM5ZNscpanwEEXromwXN6QT1k4TZsw
	RJ3yCb3njoH0kt2K1WRemyZIQMXGrHo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: David Laight <david.laight.linux@gmail.com>
Cc: linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH] random: get_random_u64_below()
Message-ID: <2ekh7esfcxnqdnjxufybel5kkpazjvwadwnb7zok5ske4vmptr@573764kocoga>
References: <20250313163810.60564-1-kent.overstreet@linux.dev>
 <20250315135234.65423e07@pumpkin>
 <olt5s7scbosagj4fpq25xun4kdvi6puwqdocgsvhpzguvpt7jt@dyy37p4uturh>
 <20250315205532.6815f2c5@pumpkin>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250315205532.6815f2c5@pumpkin>
X-Migadu-Flow: FLOW_OUT

On Sat, Mar 15, 2025 at 08:55:32PM +0000, David Laight wrote:
> On Sat, 15 Mar 2025 14:20:46 -0400
> Kent Overstreet <kent.overstreet@linux.dev> wrote:
> 
> > On Sat, Mar 15, 2025 at 01:52:34PM +0000, David Laight wrote:
> > > On Thu, 13 Mar 2025 12:38:10 -0400
> > > Kent Overstreet <kent.overstreet@linux.dev> wrote:
> > >   
> > > > bcachefs needs this, for sampling devices to read from based on squared
> > > > device latencies.
> > > > 
> > > > this uses the same algorithm as get_random_u32_below: since the multiply
> > > > uses the top and bottom halves separately, it works out fairly well.  
> > > 
> > > Adding two separate copies of much the same code is silly.
> > > Given what the code is doing, does it ever make any sense to inline it.
> > > 
> > > Inlining the original get_random_u32_below(ceil) that did
> > > 	(random_u32() * ((1ull << 32) / ceil) >> 32
> > > (for constant ceil) made sense.
> > > While good enough for most purposes it was replaced by the much more
> > > expensive function that guarantees that all the output values are
> > > equally likely - rather than just evenly distributed.  
> > 
> > Expensive!? It adds a multiply.
> 
> I make it two multiplies and a loop.
> Have you looked at what happens on 32bit systems?

Not many people run 32 bit anymore.

Have you looked at get_random_bytes()?

> > That % gets constant folded, in the inlined case, and in the non-inline
> > case it's hit only a small fraction of the, time, for typical ceil.
> 
> If the % is only a small fraction on the cost for the non-inline case
> (and it is over 100 clocks on many cpu that people still use) then
> why inline anything?
> A quick look shows divide being 'only moderately slow' on zen3 and coffee lake.
> 
> What you might want to do is pass -ceil % ceil through to a real function
> (especially if constant).

David, the way get_random_u32_below is optimized now is just fine.

I'm not going to completely redo the inlining just for this, nor am I
going to do get_random_u64_below() differently from
get_random_u32_below().

> Oh I guess you haven't actually tested the version you submitted.
> Time to play 'spot the silly error'.

Please do share what you think you've found.

