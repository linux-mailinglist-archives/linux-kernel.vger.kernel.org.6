Return-Path: <linux-kernel+bounces-557993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB799A5E023
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F9C23AB59A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4B42512EC;
	Wed, 12 Mar 2025 15:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sCbrzobx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dboEebtC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95206240604
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 15:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741792718; cv=none; b=g3Y9XFnPqgGJc8D9iVT6he2gk+pi5E2TlZmIDko4sK+xDfJuX1TR0kNQUq47Nggo5FvmAN6wkrAwbGa0JSpz+6NLN5p9eVpCGJt6h2zhZy3ZQsusegI5B34Qe6pTUAzMJKGHQGpNCqAIf9KKj58fYpHKFelbNvlxxQAs4lM01SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741792718; c=relaxed/simple;
	bh=0WGj6/Avd/HW9QCLdm+3A/IoqJrQKSrIFja7C3uaLDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U/QAD7QhZ/g8RICV2Ghp6gizHqeAFKR68f3dWprrerFQICwEBaK+ImfgNUDyZeD2MoNz3szFLkP9KpUbtST2KY/4aBMhHPCwSnCPozo5OQf9p2wDVIi/FAyVCMY+BceeyKFaQzse4DuabRxKc5Eq1JgQgxJHB/WibeHmf9kzgM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sCbrzobx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dboEebtC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 12 Mar 2025 16:18:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741792715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i7Oi0ejhX3+OkOvAUCrRQfusj0+GsV3Blg6cnIjRiS8=;
	b=sCbrzobxs4D741pQK78A6FejYUYdLwUCGjfXJx/v/OM+YkzdW/rWbdGmvX4VYWtgNzymUn
	LA0KQ/WiJZLurb/QmmQq/WAHsGN9av8mh0vYMp2MgBmoZNtqBnmAyxc1zx/1AkARqvDIH8
	PFNJzV0vW1r5YXXrNHAKnejUc/HYRsTIaEDyxMSEuRmKTKO8wscEPT4QTSwj0+EkB+xlq4
	CX2lVDjFHFI5zCiJy9AXwk+E/25gJxuxD0NZ7tyjfl1ALUpgE53ZVrxcP77fSoTO+El9Ud
	EVGC23bOCCHq+9m5tUoJV31jUU27UzNpBKLH1Lrwab3vmLxUKgKn7GrwD6zEvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741792715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i7Oi0ejhX3+OkOvAUCrRQfusj0+GsV3Blg6cnIjRiS8=;
	b=dboEebtCpfTu9SKVqtaXhTeUPFh3h7705RSeIZ+eDt1CtA3XmEditRxe/dZWcXdXJoL6/7
	gUAqPSfTx1VFLDAg==
From: "Ahmed S. Darwish" <darwi@linutronix.de>
To: Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	John Ogness <john.ogness@linutronix.de>, x86@kernel.org,
	x86-cpuid@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 14/20] tools/x86/kcpuid: Filter valid CPUID ranges
Message-ID: <Z9GlyaR-oFEur1zy@lx-t490>
References: <20250312143738.458507-1-darwi@linutronix.de>
 <20250312143738.458507-15-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312143738.458507-15-darwi@linutronix.de>

On Wed, 12 Mar 2025, Ahmed S. Darwish wrote:
>
> @@ -342,6 +359,7 @@ static void parse_line(char *line)
>  		return;
>
>  	/* Skip line parsing if the index CPUID output is all zero */
> +	index &= CPUID_FUNCTION_MASK;
>  	func = &range->funcs[index];
>  	if (!func->nr)
>  		return;

My apologies, this line should've been part of the previous patch.
Probably a rebase issue.

I have it now fixed, but I'll wait before sending v3 to see if there are
any comments on the PQ.

Thanks,

--
Ahmed S. Darwish
Linutronix GmbH

