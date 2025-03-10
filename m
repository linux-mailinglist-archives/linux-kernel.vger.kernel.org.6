Return-Path: <linux-kernel+bounces-554418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30450A59772
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47F2E188C820
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 14:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FB822B8DB;
	Mon, 10 Mar 2025 14:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HGK5+wxq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EBYeEaFq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E4A22B8C5
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 14:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741616504; cv=none; b=Gpg3jsm5djT76WxJyH7ZujJJboa/KvEfcU9Dl2enGwpyDsKTvzkSnq+hzoTIGEWh0YOPfDIqjhImpGKBfM0yH1vInXSigDkWN0kbh+pf3FW3IdTutUBqjvmycOhr6nhmp1s7EqHz5BqHDmm9OS3KUukr6JsbcMuF7iFXVRwHaYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741616504; c=relaxed/simple;
	bh=bPTFbFb4aNtUcqVSYlhSt7tLz0c1Xvfeg4JjWcBdf48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CcUe6yzEMyvoVAF4mpGNtOez0+V0Mr74uskFwhuOQ61HvVaWJVyld5JH1lR68Nxn7cX499uZNWDAS44SRo8s4jSZp8W1wWnIZik3XipRplkDXTEj/KWZlqlHbZC4TLvhjewKw3NG63KdvQ1Bfr8woXNevgOZLgrVgkyeJlHO22U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HGK5+wxq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EBYeEaFq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 10 Mar 2025 15:21:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741616500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NUsrafUoHmKipqb0OuXM3oWGVaeb+Q3K1rxqxRp0hEc=;
	b=HGK5+wxqR3RmfXwr2j9qWEoSJ0+3ranU2KxnbUUXMFZd475ESgyCUCHm1xXqpOodfdqZCF
	VDUymKMJ/Xon+vcnfFf1A4PFSXU1knmfFT51k0a4CcQbS4HMQMaLS1w5M+Jajhch3i0Ry2
	Hpma5gr0MnEHvugMENrLjGcxuIDcV2YgUobloTgdAOmiP8WclXolX3bD7QUOMXkvyKDN45
	hHyo9gqGT8c3IBnDWpMoKn+XaMb9L4pvBKb4x6nLz1xAOYeQ5cUzivw008qKcm0DuGTiQ8
	vJqSi8qYeKx5UoMad/BRDZiDrJ4PyzTEGANa3DeErk3F+zdxZOUW8KNofalmDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741616500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NUsrafUoHmKipqb0OuXM3oWGVaeb+Q3K1rxqxRp0hEc=;
	b=EBYeEaFqle0D7yLkzkXlSL6tr9JtE0EmLB7cxoufW/OoDMNLJ7BQPgv3WuCxGyFiWCLg1Z
	K92eZaymdNvu6OAw==
From: "Ahmed S. Darwish" <darwi@linutronix.de>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	John Ogness <john.ogness@linutronix.de>, x86-cpuid@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 07/12] tools/x86/kcpuid: Add rudimentary CPU vendor
 detection
Message-ID: <Z871cVjBXy2A-5E0@lx-t490>
References: <20250306205000.227399-1-darwi@linutronix.de>
 <20250306205000.227399-8-darwi@linutronix.de>
 <0ade78e7-7a3c-459d-bf1c-f0bb1f24baee@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ade78e7-7a3c-459d-bf1c-f0bb1f24baee@intel.com>

Hi,

On Fri, 07 Mar 2025, Dave Hansen wrote:
>
> Do we really need the vendor detection? For example, look at the end of
> cpuid(1)'s output:
>
...
>
> It seems to just blindly poke at all of the CPUID regions. There are
> only a handful of these and there's no hard in poking at them other
> than an extra couple of executions of CPUID.
>

Good point, thanks a lot.

I've checked the cpuid(1) code now.  Indeed, it just tries its luck for
all CPUID ranges.  If the returned CPUID range max function "does not
make sense" (i.e., smaller than the range's start index), it silently
ignores the whole range.

I'll do something similar in v2 then.

(After removing kcpuid's vendor check, its first run, where CPUID is
 invoked, will need a minor change.  kcpuid's second run, where the CSV
 file is parsed line by line, won't need any changes.  So, not adding CPU
 vendor checks is indeed a win.)

Thanks!

--
Ahmed S. Darwish
Linutronix GmbH

