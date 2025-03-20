Return-Path: <linux-kernel+bounces-570325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F09E5A6AEE3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 20:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68D324231B8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 19:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD8F227EBE;
	Thu, 20 Mar 2025 19:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mX6OPokz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nSMr3UaN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDA0221579
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 19:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742500568; cv=none; b=W7t6jXeTeeLPyAALNINe2UE1gQOx0Tgyo3wg+F1VuqPtumEd+1DNDESaqJqyzPXiiuNXE74VVOQvylb5Jh6nFJUuewfJQQmVyuv5V7sBkB8OUe5a940dttKXTyIWclsKEE4KIrZlxNKYLbYcF0Bz1s27waVVi6uvJSO4E71q6U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742500568; c=relaxed/simple;
	bh=jB8nKIZepojlgR210ZZ91lH3AgazjD4Izczc9q0NSC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IbnVOKVTQkZakwk+EHeKz0+GesQEZcqotNhlyl7YC40s3+ddKtmQLsg85wegxTRthld50An8QP7OWgcK0lSOcraiDezrdK7BtJXG03QPo0JHElbUYwDd4VDcBHwRIffQobsQ8n/IP57yJY7p+fmOhmgrZB5Naxb8D4NK1cCb+1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mX6OPokz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nSMr3UaN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 20 Mar 2025 20:56:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742500565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jB8nKIZepojlgR210ZZ91lH3AgazjD4Izczc9q0NSC0=;
	b=mX6OPokz5w/4bGcXyVy1l8sSdmrcuLLkwz39pQCvNgbdvYO8uG5A+xhuQRDjSnlEwi5oku
	Z2c0dipPEManlUykBah0toKWz6HWnvbB2JwexK3FGVFY7wpdCiBzfUmD1VExcBVOO7XRno
	5CSYJ99v/ZaDzsHW4iLizKJLPjgPNq9xdiDRv4A0h9Z52e/+6aqVpu4oghZRMPH8Sg2wan
	/ZqsAYib8qde7Sb7miQdSJ0S9sqe8ge60r0bmfV8e1jy/0tU48K4GkAg0Lhh0ZyluYoab9
	liQZRPGW8V/rX6T0rpl1v5Z3/UUerrqiqz52jAfEtbbrwLLPZkS90ehoipBOPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742500565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jB8nKIZepojlgR210ZZ91lH3AgazjD4Izczc9q0NSC0=;
	b=nSMr3UaNtwp/HjkFpQa2ZLBF2+nbUaEUR2cqqFCPGValGTluILCP25SZthTtjmJxoJBL2E
	WxdoRCrLVu4nEkCg==
From: "Ahmed S. Darwish" <darwi@linutronix.de>
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	John Ogness <john.ogness@linutronix.de>, x86@kernel.org,
	x86-cpuid@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [x86/cpuid] Question regarding historic leaf 0x80000000 code
Message-ID: <Z9xy04RL3Uww9DYy@lx-t490>
References: <Z9xtfC5pL-g4LYvK@lx-t490>
 <d4fcfd91-cc92-4b3c-9dd2-56ecd754cecc@citrix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4fcfd91-cc92-4b3c-9dd2-56ecd754cecc@citrix.com>

On Thu, 20 Mar 2025, Andrew Cooper wrote:
>
> The problem is that for an out-of-range leaf, Intel returns the data
> from the maximum in-range leaf, rather than zeroes.
>
> On pre-AMD64-capable Intel CPUs, you'll get what amounts to junk in a
> query for leaf 0x80000000, where it's probably leaf 5 or so.
>
> Checking for the upper half of the output matching the input is a way of
> distinguishing Intel behaviour from all the other vendors.
>

Thanks a lot Andrew for all your help!

Then I'll mention that, in a comment, on top of the new CPUID scanner's
leaf 0x8000000 code.

Kind regards,

--
Ahmed S. Darwish
Linutronix GmbH

