Return-Path: <linux-kernel+bounces-567940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E31B5A68C32
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE5DC189686A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 11:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC779254AFD;
	Wed, 19 Mar 2025 11:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TDueyK15";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UMxeURAM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AAD2505D6
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 11:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742385363; cv=none; b=RESkKNU40Xgmlq7lJ88fDb39WfBFym/Z5MOsN16zokxf3miJlkVQLig/oWaCCE1faTL2dIpKc4srPVmdZociD29GKrCFTRqO9DUs34nwEpLwzvcT+hvJqsXa0lcwdhRO4+DEiYFJ+czgxJUMihawz8haq0gjeJb9/ERw6ZoNwoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742385363; c=relaxed/simple;
	bh=lv2MfAR9HZn4fy4zrfRFlhXqTdXIHgXiipgCHy9AgRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QfUPJiCgCUZ7eGVYAvMjaW2v5NU3E2g4u60nkMbl6RCtbZyrDfPYm2xSYyZ1WDklGerWghHkC1jADZLD/EQTZKszd6/fAb9PodbiIPk1NEwjihvKZ3Ab0wuZagGFJnbgypWSGKKUPQoLX0XhKqcKguk3q32fonxuYR12bCWKXig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TDueyK15; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UMxeURAM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 19 Mar 2025 12:55:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742385359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qBrv6isD1kzVwdaIkYxJz7iYTDLyraxYX9p69kZLT04=;
	b=TDueyK15wwN7JSEF+djYbFuRdKm7rdK3whxR40vchZc8V/mzvGdORvInd+Z7dVaKwiwa4r
	yU0vQh1zbV4KMDpzW5Uz/CpNjV9G56KqYKpqy7ISS7AQPQ1CdaX4fndgQ7cu+p9LNIZUEM
	1oC57orMA09krH8AcdYbTkhfY9R5xUBuq2ndvnUMLrfKeFhfR1Ky7fowJ0prZ+3/IvzDta
	aGf7x2mQbFOKjGpstupvJET9HqGW8nSByAGmqncttDA+giamKlhrAcSObegVS6XVdJtlyx
	sWcFhuH5BQ4U3OSPN31yiyFvoOoZP4siaDwwXglVLPOkeJLLpW39pHhl8i6nxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742385359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qBrv6isD1kzVwdaIkYxJz7iYTDLyraxYX9p69kZLT04=;
	b=UMxeURAM/9/AiwetEmATS24aP9ZIwMrq8Tfdg6oLBI9q7WCaijLaoQACpnLTUa3Zmd5CkT
	zXGoWbtffbBvUMCg==
From: "Ahmed S. Darwish" <darwi@linutronix.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	John Ogness <john.ogness@linutronix.de>, x86@kernel.org,
	x86-cpuid@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 19/20] tools/x86/kcpuid: Update bitfields to
 x86-cpuid-db v2.3
Message-ID: <Z9qwzVuvV1p6MjRw@lx-t490>
References: <20250312143738.458507-1-darwi@linutronix.de>
 <20250312143738.458507-20-darwi@linutronix.de>
 <4BCBA481-AC3A-4A65-B791-235E580286CC@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4BCBA481-AC3A-4A65-B791-235E580286CC@zytor.com>

Hi,

On Wed, 12 Mar 2025, H. Peter Anvin wrote:
>
> On Wed, 12 Mar 2025, "Ahmed S. Darwish" wrote:
> >
> > Update kcpuid's CSV file to version 2.3, as generated by x86-cpuid-db.
> >
> > Summary of the v2.3 changes:
> >
> > * Per H. Peter Anvin's feedback, leaf 0x3 is not unique to Transmeta as
> >   the CSV file earlier claimed.  Since leaf 0x3's format differs between
> >   Intel and Transmeta, and the project does not yet support having the
> >   same CPUID bitfield with varying interpretations across vendors, leaf
> >   0x3 is removed for now.  Given that Intel discontinued support for PSN
> >   from Pentium 4 onward, and Linux force disables it on early boot for
> >   privacy concerns, this should have minimal impact.
> >
> > * Leaf 0x80000021: Make bitfield IDs and descriptions coherent with each
> >   other.  Remove "_support" from bitfield IDs, as no other leaf has such
> >   convention.
> >
> > Reported-by: "H. Peter Anvin" <hpa@zytor.com>
> > Closes: https://lkml.kernel.org/r/C7684E03-36E0-4D58-B6F0-78F4DB82D737@zytor.com
> > Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
> > Link: https://gitlab.com/x86-cpuid.org/x86-cpuid-db/-/blob/v2.3/CHANGELOG.rst
> > ---
>
> As I said, you can simply treat leaf 3 as raw 128-bit hexadecimal
> number; there really isn't a need to "interpret" it since the only
> meaningful use of it is as a unique identifier combined with
> vendor-FMS.

Yes, but this would introduce special-case leaf handing in kcpuid.
So far, the kcpuid code is "dumb".  It just parses the CPUID bitfields
according to what's in the CSV file, with no intrinsic knowledge of any
certain leaf by the C code.

This is why, for example, kcpuid does not print CPU vendor strings in
human readable form.  It just dumps whatever is there in the various
leaves bitfields:

    $ kcpuid --all -l 0
        max_std_leaf        	: 0x16
        cpu_vendorid_0      	: 0x756e6547
        cpu_vendorid_2      	: 0x6c65746e
        cpu_vendorid_1      	: 0x49656e69

    $ kcpuid --all --detail -l 0
    CPUID_0x0_EAX[0x0]:
	max_std_leaf        	: 0x16      	- Highest standard CPUID leaf supported
    CPUID_0x0_EBX[0x0]:
	cpu_vendorid_0      	: 0x756e6547	- CPU vendor ID string bytes 0 - 3
    CPUID_0x0_ECX[0x0]:
	cpu_vendorid_2      	: 0x6c65746e	- CPU vendor ID string bytes 8 - 11
    CPUID_0x0_EDX[0x0]:
	cpu_vendorid_1      	: 0x49656e69	- CPU vendor ID string bytes 4 - 7

We can extend kcpuid to handle a special case for the PSN, but if we
gonna do that, then it would be much better to start that with CPUID
leaves that actually matter: CPU vendor strings, leaf 0x2 1-byte
descriptor semantics, etc., etc.

Given all that, can we please move on regarding this leaf 0x3PSN thing?
IMHO, there's no reason to block the series because of that :(

Thanks!

--
Ahmed S. Darwish
Linutronix GmbH

