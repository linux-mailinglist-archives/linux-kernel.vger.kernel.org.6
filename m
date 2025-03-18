Return-Path: <linux-kernel+bounces-566027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F9CA67237
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 12:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77A527A7192
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB90D209F33;
	Tue, 18 Mar 2025 11:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IY3SS548";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UceKltUO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB68209F38
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 11:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742296179; cv=none; b=q6hxM1rPLdnmMotV5ep6P/rI6QEDaqmV9GBkSsRP1O2sGLkUWlmr/ItUcjb+XZunvKJ0rm4MDlyHd9CzdZPsVkQfcjQtOWCrsCNpF3iuSPHFRc8P0hIX+hHYyUJf/nQewGi6LHKL5cAIru0baohXJxqEaDJ/RE56558l7K88Al4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742296179; c=relaxed/simple;
	bh=hyVj8uYyP/1SoMIwYvBVqUPsk+CiVLmStLlDmg9A2xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XfqW+zqH2UwWtYY5kppmqQehf0OsC1LnUBxsPglT6SPxEzhij1g3ILNi3E0LgiuCb15xk6n5jZ94HxYOFQxp8QDuJJtGOuXuDBT10xDe+fXowlue0BQjZVFh6tvv+1O/5mWcMqpK2bijPuQvmejfRDghYXxCknyOiqyCzgdvXeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IY3SS548; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UceKltUO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Mar 2025 12:09:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742296176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eic6q/rozoGbuSYNe4ZPpX4CFUhLOFjPoS0vJbaheh0=;
	b=IY3SS548E6ttGoeKuSmJ3pYh3CqCCSsbmjSc4oAUJBKopjPlf9rairrzHprSG6dQRm3pJi
	i/qtkje+KLBb/diuDnqEHusdE2FNI9GHOtLSJVZOxjj/FL7ZJk7f/tvvGBD7AscgHuKwk3
	tx2u/MvfaJ+91h65kJEE0bNwqsZedfWGddKYDwyPsmNPpcqotFS8er3QMSdp2v3OqfZSOH
	LNVxehnx8QZMVOXbn/kV/F5cov4IJy+q46dzWVthV4iD3r9bWMdFWBmsSDPdPl7zcoSk6N
	fm+pSegx0RXdu9YB6lSEieNyLt1DQp3fPibOPofqSN6WeZ/uBffWnCJGK7jSdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742296176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eic6q/rozoGbuSYNe4ZPpX4CFUhLOFjPoS0vJbaheh0=;
	b=UceKltUOb4R8knmkk8rPGyTbahs76sp3PW0ul68OPHNfgFTkVg/Suy7oCInnwZBswR31mo
	Yf96K5AeP12Fx0Cw==
From: "Ahmed S. Darwish" <darwi@linutronix.de>
To: Ingo Molnar <mingo@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	John Ogness <john.ogness@linutronix.de>, x86@kernel.org,
	x86-cpuid@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 03/29] x86/cpu: Remove leaf 0x2 parsing loop and add
 helpers
Message-ID: <Z9lUbnEAR1RmdbE_@lx-t490>
References: <20250317164745.4754-1-darwi@linutronix.de>
 <20250317164745.4754-4-darwi@linutronix.de>
 <Z9iVyrlDbFyI9Rqi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9iVyrlDbFyI9Rqi@gmail.com>

On Mon, 17 Mar 2025, Ingo Molnar wrote:
>
> Could you please turn this into at least two patches:
>
>   - One does the functional change - this patch should be as small as
>     possible. This patch turns a piece of 'Intel documents' property
>     into 'actual code' that differs from the previous code, which may
>     or may not regress in practice.
>
>   - The other does the factoring out and the introduction of
>     <asm/cpuid/leaf_0x2_api.h>.
>

Sure, will do.

Thanks!
Ahmed

