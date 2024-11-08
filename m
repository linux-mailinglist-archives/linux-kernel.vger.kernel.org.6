Return-Path: <linux-kernel+bounces-402049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1036B9C22B8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 18:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31A4D1C2355C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 17:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF8E199953;
	Fri,  8 Nov 2024 17:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bZ8hbI/d";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5IxHBaFH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B2E1DFD1
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 17:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731085982; cv=none; b=oVot3mfl79QqXSqLHbD4JwkAg478bHSIOZcypzZ9QC/VSTORuo4BVXTPH78ltO3a24laevdtU7pDBioLwSWl3H8CXff56FHVNOxL/TQ6cfalAtusJ2Co7uJLuD2uwXrIonqsH2d+xbvagME774hlWpQwJPedYRmEpZ/9UUbj4kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731085982; c=relaxed/simple;
	bh=TDaopfkZGxk8I35kcvWYXyTCi+ARQGaq18I06kPfKb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CPkG2MjomUU2+0kJwS9EYPvSUs7AsiE0V+IvQKisRePR8hCh4hr3rGhNsFj7wQjBW9OERuqYCrlJ1AS86bp5xwWQ23Uf55+TxOBedPbGCM0heXIDzw+C+yrHmyySvcOHSn/WnOyI9JmoVZ4h7j/UDMnM2FrHJT0YPSdH1uzmCWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bZ8hbI/d; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5IxHBaFH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 8 Nov 2024 18:12:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731085979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b/xfJbI02fPPq5be4DTi43PTz0QyQy04viOATK8PVQY=;
	b=bZ8hbI/dKxfEnnQoKKImjEAzkpecVCLW60IlrUv9njvukJryRvEnMkcEzvNB7ydi/4abdm
	vX19NnAGfYH6JDA4FWHGB+qOWG3Ij56j36XnZF7yZT8GkBRl7/ZIg2EwXnXBccxwG290z0
	DUQH7NOVhpNtjwAW+1gannB27Ybkz5smvvMJxv/myrbdyBE8NkuPcSHlIunPZ6Pf/6KnA1
	APXaj2XyY5PFt+zAcAP0Zg5vu26w+ahZN+99Far1iYOwXVJqLRUurOxqDuWyfuebmOwbjG
	ZMof0b0Vl9sCaqEj6Vpy5M+pPlTQNdAp1o8m1sc63spH1cf1ydwA+vyoFpAbtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731085979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b/xfJbI02fPPq5be4DTi43PTz0QyQy04viOATK8PVQY=;
	b=5IxHBaFH7vDvVRGf6gQ7jAae7HdG43FZqSAWKAwgpgv0IStF/Nsfb3Lt4ESSDVvSYx2YPZ
	rJnlks5vRPYVv0CQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Tejun Heo <tj@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org, tglx@linutronix.de,
	syzbot <syzbot+6ea37e2e6ffccf41a7e6@syzkaller.appspotmail.com>
Subject: Re: [BUG] -next lockdep invalid wait context
Message-ID: <20241108171257.i0EpS9m3@linutronix.de>
References: <41619255-cdc2-4573-a360-7794fc3614f7@paulmck-laptop>
 <e06d69c9-f067-45c6-b604-fd340c3bd612@suse.cz>
 <ZyK0YPgtWExT4deh@elver.google.com>
 <66a745bb-d381-471c-aeee-3800a504f87d@paulmck-laptop>
 <20241102001224.2789-1-hdanton@sina.com>
 <ZyV2DfuIPsISds-1@Boquns-Mac-mini.local>
 <ZykNhbMOrlgCXFYJ@slm.duckdns.org>
 <20241108100503.H-__545n@linutronix.de>
 <Zy5EIHUwoXjK1sAJ@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zy5EIHUwoXjK1sAJ@slm.duckdns.org>

On 2024-11-08 07:02:24 [-1000], Tejun Heo wrote:
> Hello,
Hi,

> > @@ -223,12 +226,11 @@ int kernfs_name(struct kernfs_node *kn, char *buf, size_t buflen)
> >  int kernfs_path_from_node(struct kernfs_node *to, struct kernfs_node *from,
> >  			  char *buf, size_t buflen)
> >  {
> > -	unsigned long flags;
> >  	int ret;
> >  
> > -	read_lock_irqsave(&kernfs_rename_lock, flags);
> > +	rcu_read_lock();
> >  	ret = kernfs_path_from_node_locked(to, from, buf, buflen);
> > -	read_unlock_irqrestore(&kernfs_rename_lock, flags);
> > +	rcu_read_unlock();
> >  	return ret;
> >  }
> 
> The _locked suffix looks awkward afterwards. Given that there's no
> restriction on how the function is called anymore, maybe we can just
> collapse _locked bodies into the callers?

Sure.

> ...
> > diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
> > index 87c79d076d6d7..733d89de40542 100644
> > --- a/include/linux/kernfs.h
> > +++ b/include/linux/kernfs.h
> > @@ -199,8 +199,8 @@ struct kernfs_node {
> >  	 * never moved to a different parent, it is safe to access the
> >  	 * parent directly.
> >  	 */
> > -	struct kernfs_node	*parent;
> > -	const char		*name;
> > +	struct kernfs_node	__rcu *parent;
> > +	const char		__rcu *name;
> 
> ->parent doesn't have to be converted to RCU. As long as the node is
> accessible, the parent is guaranteed to be pinned and unchanged. We only
> need to RCUfy ->name.

I was uncertain about parent. But in that case, let me keep parent as-is
and just do name.
Thanks.

> Thanks.
> 

Sebastian

