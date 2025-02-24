Return-Path: <linux-kernel+bounces-529590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 516CAA4283F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FF111896CDA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 16:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0CA263C73;
	Mon, 24 Feb 2025 16:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Rhc4Ljhn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="atsu8b74"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424F8263F54
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 16:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740415684; cv=none; b=g9B3qMYLPMuNz5l86bExh7tvtOsRsju8xUd2qXQ9wGsYY91d7QujmH3ne0a2IY/ruozyXGY0mDAjrsY0+rWCG0bqhKMrTmlEzJM8xkLsaW3sbNoqa/FozR4ZsgClRDEp46ZW9Qus9+OlsLW7TrIsdfmiokIO+9weyJNkWS1tUsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740415684; c=relaxed/simple;
	bh=ss7DsXSePjzwcGsWpdrAzZfHY8fzjDuFkhk++YlMGXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n5jG5f6nYpn/84Hh8nGgCDGnWBY9NofdD4XT0YhPUmXGWPteUkuWq3m9Uk0YbkXKlCX/YjlIeL+juoOMrRGfF6lvqPPRxH8lRVO/l0+OkF2CA3uWEXKpMmKIAGjL/tfNqkOXjc9FJz434/68VZJDhmxrQ3a+NnM+VCHVUbPkGGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Rhc4Ljhn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=atsu8b74; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 24 Feb 2025 17:47:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740415679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uo7PSOn1I+58u8X1rquB1nGVmVCrObwoTLEm9Qwm5c4=;
	b=Rhc4Ljhn+XMM2lmynf4wXIkqMIluTVAojvslMrRIXAoX4WNY/H6u5xExPWLaqH/cc674Nm
	ht1Oh+Sn1bUxSuZHssWtcnraVG4eaMxuuXHFt0dL3gzjzRhPHT/p202DZRzK/fp2L/GQHY
	wPf9U2BdHeYoqXnn+rOOSSnJUmA3LSxhBj0Vfbx8k4NifsFF/nR07V93cK8bqpusKYh/Y6
	L6+PheT6x7KWHTge6txiqI3eCH7ccLZjjI8OZO8hNXbpXfyO7mdzEoITetMuhSkqBhag3a
	tIw/Uk1UiNWySWQK5ZdfrnhXl5y4QaK1A1wI+gbzVoqTCeqZ8SvJWNYbrdAZtw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740415679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uo7PSOn1I+58u8X1rquB1nGVmVCrObwoTLEm9Qwm5c4=;
	b=atsu8b74l45P+4nb9C1LNYZ/aOM1Vsvo5SYSlm02/X7mcWxNVlo+wCcdISljtTcIy90nFl
	XrydRrQfpQ88mWCA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: syzbot <syzbot+7f4f9a43a9c78eaee04f@syzkaller.appspotmail.com>
Cc: Jason@zx2c4.com, boqun.feng@gmail.com, hdanton@sina.com,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	tytso@mit.edu
Subject: Re: [syzbot] WARNING: locking bug in get_random_u8
Message-ID: <20250224164758.Nrr6Gqi6@linutronix.de>
References: <6738c3ba.050a0220.bb738.000d.GAE@google.com>
 <67bc8764.050a0220.bbfd1.0088.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <67bc8764.050a0220.bbfd1.0088.GAE@google.com>

On 2025-02-24 06:51:16 [-0800], syzbot wrote:
> This bug is marked as fixed by commit:
> kasan: Make kasan_record_aux_stack_noalloc() the default behaviour
> 
> But I can't find it in the tested trees[1] for more than 90 days.
> Is it a correct commit? Please update it by replying:
> 
#syz fix: kasan: make kasan_record_aux_stack_noalloc() the default behaviour

Sebastian

