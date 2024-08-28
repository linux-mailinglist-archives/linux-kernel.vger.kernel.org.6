Return-Path: <linux-kernel+bounces-305107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96655962999
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 16:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DA641F25460
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 14:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219A417A922;
	Wed, 28 Aug 2024 14:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XaPAkuZh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="swj02hBq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042061DFED
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 14:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724853748; cv=none; b=mWYIBXD4EgljVtLvDZ3o6KBEnSyYMZ79Y45u80WVk4l3hujTsvvma70zs0Cz6XmCmsbKEnlRmjYTcOqoVUj6e7klcpCJpj3ROq7h2NcdqgGYHmGMt3UWEqjUWWUO+SmwZD5qLs5h96mqIqm5xtRa3/PFMk9RinaIdnGAU1wP0JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724853748; c=relaxed/simple;
	bh=DDVYsNiPGJxKNMDWH2mMOukmpEHAc2FV2iO5+4WvJJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bns6ow24f8+yLnfbl7MLe3KmzUlge1z8wjUmwDO6pfrn1ZIZWtUO+dPSUN5TEJi/EX0SkC4Di35W1Krpst1Rp3cL/wy24GFwXOVqXqODhd/Gc3vC9aqp955tQfyCaddJ4fhrnCcTNErH3X9UT8493epeeHZbbRGSdAfNbavEqG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XaPAkuZh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=swj02hBq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 28 Aug 2024 16:02:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724853745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O/J3BYmAFM3tQOVWdf9guFVEynCs0mpZgn69dSZCaDE=;
	b=XaPAkuZhIV7IPmpl0i7rGu0dyODCDRJudm1U/s9D4uudFtZ1tpFPqdaMnOCcFxbOBqzvH0
	qHTpRQcKD/AGuoyZ4TWHd94PgDOVDqscYXdKpUMIpUnGQIS51kRbmDXr5yRuY64ba0mPkU
	+3i7zVUCrlH+2P75K/Zm5yT+HgaeN+wdThM+cwatyz4HIKXQ2Od9fcwendRofPwYcnl7Gx
	C9Ci9tR17RUEbb3Tbk+k3Y4sho+5Q+6bWYK0hFjHicNkfrHEzlkUdJk2cHfWt+Z9M72uTI
	LplbBoBdNx8y9L/JmxLdXeJYPpv56cHExkucnvUVU3WuVpeotBOBjH8P9yKmKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724853745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O/J3BYmAFM3tQOVWdf9guFVEynCs0mpZgn69dSZCaDE=;
	b=swj02hBq+W/SxH8MuV+6n/GDAXzQHUI4TH3j0iPJ9PpI+fSVVdroulVo5f46GOKyTuk4C7
	A5QuzyfKAVDMQoCw==
From: "bigeasy@linutronix.de" <bigeasy@linutronix.de>
To: "Brandt, Oliver - Lenze" <oliver.brandt@lenze.com>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] irq_work: Avoid unnecessary "IRQ work" interrupts
Message-ID: <20240828140223.P5vGN54Q@linutronix.de>
References: <25833c44051f02ea2fd95309652628e2b1607a1e.camel@lenze.com>
 <20240828093719.3KJWbR6Y@linutronix.de>
 <20240828095415.43iwHYdM@linutronix.de>
 <1dc4fa0a48b05e14a1ae2a751441ba021ecee286.camel@lenze.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1dc4fa0a48b05e14a1ae2a751441ba021ecee286.camel@lenze.com>

On 2024-08-28 13:26:42 [+0000], Brandt, Oliver - Lenze wrote:
> 
> Hmm.... I see. What about calling wake_irq_workd() directly; something
> like
> 
>         if (rt_lazy_work)
>                 wake_irq_workd();
>         else if (!lazy_work || tick_nohz_tick_stopped())
>                 irq_work_raise(work);

this might work but I'm not too sure about it. This will become a
problem if irq_work_queue() is invoked from a path where scheduling is
not possible due to recursion or acquired locks. 

How much of a problem is it and how much you gain by doing so?

> Regards,
> Oliver

Sebastian

