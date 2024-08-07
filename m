Return-Path: <linux-kernel+bounces-278165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B0994ACF0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 17:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA0961C20A67
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 15:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55C985931;
	Wed,  7 Aug 2024 15:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mZt78lUn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MJSRFqAv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2FA5811A
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 15:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723044755; cv=none; b=QqK2XsG5ikTbj9qyPYQ5VGFvh2C2dOQ7TA3Hg+9SldndekCSR8lW/5DH8BLjaN16WctU+Aqif2dCEhpiiLbl0Miw99Y38QmvnQo6OfqlToTqX4cN7fK/6SXEThF7SGYSNnQQI+zx9VftaR7Ng0E12fddzqpgO0fU6QKvWh42cMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723044755; c=relaxed/simple;
	bh=fuVOuUa4Ml+VjQZSzBWdr2ADPtpoNcU+lqN8KJkSgr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a8q/DEvorxmHfqVGagKFqlhyUAP+jDpQGDKiP5PaE/jEYasjgKFSNPkMS9FnL0KKdDwcgh0KSNgkGl93cO68JV7jYGAH10K8ye7sMy/F5+c3EPWWZiK8A+LnWdjuEoPasy+VBL0Q1djEErHFbEHeAlQOQS4+2Vhc8UKglYpSttA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mZt78lUn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MJSRFqAv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 7 Aug 2024 17:32:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723044751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D8zIUiMT2pUs/Jjsabusuu6Dail7VCPc204Mw9DO+N4=;
	b=mZt78lUnu634OvoSPmOF4HTMeMm7bdWJG9mn+pvDCUpvXkvm300kF4UUKOqFW81Qg1e9in
	t5AmMT26K9CxBxR5oMqyoYY/r9ArryNUQqp4oipcZAPwn4dV8Uh0jppT3WcuciBD5leuAc
	t853ezr0+VTvFLCDRsXBBp7kmna6/OgJjFvMoxYY22G9cC+u8PIPr63YxRxWBS6vEn/o8+
	RezqlNBnlAbm9c5bfyXzsVj9q9eAqtonC3SNdTGf3r9hIs1J7qJbM01CEcIRNKyRuQUbiT
	OAImQ0Msnm+gUPsbYddOj4MgAEb5ibMAXCwBAkivj61nsK3Wu3javbiN3G+uoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723044751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D8zIUiMT2pUs/Jjsabusuu6Dail7VCPc204Mw9DO+N4=;
	b=MJSRFqAvzWtrabAbY6VnHoj4NXrSv0SYbG6QQduNw9j39xEr2bGLR4cTfRwZfTW2+1/iEF
	4xB4eyvyfnzGPZCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Petr Malat <oss@malat.biz>
Cc: linux-kernel@vger.kernel.org, paulmck@kernel.org, tglx@linutronix.de,
	nsaenzju@redhat.com, frederic@kernel.org
Subject: Re: [PATCH] softirq: Do not loop if running under a real-time task
Message-ID: <20240807153230.rDSKGnY9@linutronix.de>
References: <20230306154548.655799-1-oss@malat.biz>
 <20230308091458.Q42uCjR2@linutronix.de>
 <ZAnZKoH38Telq1qG@ntb.petris.klfree.czf>
 <CANMuvJk95Ui09wZ89OrjJeOF5ySx5xO4+sS5Nd8af2wgaXgt=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANMuvJk95Ui09wZ89OrjJeOF5ySx5xO4+sS5Nd8af2wgaXgt=w@mail.gmail.com>

On 2024-07-25 08:44:02 [+0000], Petr Malat wrote:
> Hi Sebastian,
Hi Petr,

> what is the status of this softirq issue? By looking on the current
> upstream code, I think the problem is still there. I can resend my
> patch or rework it to use independent task struct flag to decide if
> softirq processing should be skipped in the current thread.

I was re-reading the thread. I don't see how the migration thread should
run softirqs. This should not happen or please show how if so.

Your example has a long running timer callback which probably gets
PI-boosted by a threaded-IRQ. The longterm plan is that long running
timer callbacks don't affect threaded interrupts as they do now.
The worked started with
	c5bcab7558220 ("locking/local_lock: Add local nested BH locking infrastructure.")
	https://git.kernel.org/torvalds/c/c5bcab7558220

and needs to continue.

> BR,
>   Petr

Sebastian

