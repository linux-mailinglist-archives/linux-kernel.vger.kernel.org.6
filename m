Return-Path: <linux-kernel+bounces-525287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C42A3ED97
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 08:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CCCB17FD05
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 07:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791171FF5EB;
	Fri, 21 Feb 2025 07:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nGH63XC4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n1oE4o11"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96BF1E2848
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 07:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740124203; cv=none; b=mtNGH++atBhn4hla4FXOWNdzyidrLB3aHNmrU6o17OiyOqL24kpuMJiZcX2rTnmnaogJMVMPQlgoz/zRWFuwbsG+9lJc1mApuxSSpWPXiDwaywtIoc8bR/0JGjHP+jgSwXHzwtY2G6mb+se1HH5pmWXFM7IisnVgTCz0t3IBQYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740124203; c=relaxed/simple;
	bh=S2pU4qjm8eBTIuiFwwTjbflOgOr1NkKXPy1G3PHU6RE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VRjjVdG+oZ4qiEwOcUGDsu2Wbzp2fFe0xdvqWkHtOyLWhGH7E7UtRiwRzgtRTGmHboky480ERy58Rc6/gXjaWedh3N5qHoNOKl8wozUo4cPCQyfNX1kYFM1amzv+RQodpWensvIpMyhI3AvUHEyjK3M0G3a+25OdMD2cpX3Rmz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nGH63XC4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n1oE4o11; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Feb 2025 08:49:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740124199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y6rhQ85WWrkjXk8UlNg35K7SZ06Q66L9mwELG4MSZd0=;
	b=nGH63XC4PWRXg4rdH0o/bD7fHcqo/pCW+bkFoIyEGy/Sh5BVJxOS7tH0MUcfwZJ0F9EJ8q
	m4BSdNnCddcFSQeQyAYKPLDR88aIuz0CMKakjyrb2LUfapCzMCigV20sS+Qqy/jBfHc2er
	xLf1IqQy/1DBbwDZs8EPIBOf2Lxoq6pVmjgpbPFg2psTvnIJdo8c+zfBwl0ye/OONAKHIM
	5mLB+HngKx0bfauWc9AD8HWJCVly6Lr7xBtSMkqWowr+8AzR7/D2VRrmGHSBLvFzEF87Nf
	W7gYsfDZDgBshyE7E/v5ADo61bvbYYlZqAB3d6M4piUGVg/A7Ty5spBNGj7d/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740124199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y6rhQ85WWrkjXk8UlNg35K7SZ06Q66L9mwELG4MSZd0=;
	b=n1oE4o11Fdu6eDLZIhU4NopfAwKDMOzPaDEmWA/BvFyhMJy/Vr4a/al889Sh8JXLymtljR
	AcXV8LU/hNXw/CCA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: syzbot <syzbot+ecccecbc636b455f9084@syzkaller.appspotmail.com>,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, tj@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] kernfs: Drop kernfs_rwsem while invoking
 lookup_positive_unlocked().
Message-ID: <20250221074957.6Gqax5ib@linutronix.de>
References: <67b45276.050a0220.173698.004f.GAE@google.com>
 <20250218163938.xmvjlJ0K@linutronix.de>
 <20250220203924.GL1977892@ZenIV>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250220203924.GL1977892@ZenIV>

On 2025-02-20 20:39:24 [+0000], Al Viro wrote:
> On Tue, Feb 18, 2025 at 05:39:38PM +0100, Sebastian Andrzej Siewior wrote:
> 
> > +	scoped_guard(rcu) {
> > +		knparent = find_next_ancestor(kn, NULL);
> > +		if (WARN_ON(!knparent)) {
> > +			dput(dentry);
> > +			return ERR_PTR(-EINVAL);
> > +		}
> 
> NAK.  dput() is blocking; you *can't* do that under rcu_read_lock().

Thank you.
Since it got merged, let me do another one on top.

Sebastian

