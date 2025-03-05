Return-Path: <linux-kernel+bounces-547539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF9CA50A94
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 20:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3494D188E5EC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672C5253B77;
	Wed,  5 Mar 2025 18:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="shb/nAom";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Bq/9sah1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB1C254AF3
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 18:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741201097; cv=none; b=hlOvprqqGKhigwCB3IuJkvm2jQUKpUXgW9wQxaMz2BiDPZi9hHZ9FZXhFNJSL578++wot2s3+s8cIIcDeuGdXimkfVx6yLMYEDiQe+Bi0y/pfRiffsTkH76K3hFycxObzC+BO5J6ir+4CT8iBhEKWbHGHhD9tYWo61OU8driUPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741201097; c=relaxed/simple;
	bh=RSntaKRcX6bb5OX0LcGpaXqGDiYfJFg4PmaXQ7xssMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=US9UpTp8VYTPH35WaykJVNbEAHKKP1eo5TMsJIq9JOs//g5P99cLSIMfUJmnF1JN+MFGar1xyyGtbzZQSzoaEY2elFVwEsCxCDpdQvxf73YAouNV4BF7d0qPeIVdwEamiOoXmd/30tWq075Bd/LfhD5/Jj1UoruU7FmCIynhtT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=shb/nAom; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Bq/9sah1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 5 Mar 2025 19:58:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741201092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RSntaKRcX6bb5OX0LcGpaXqGDiYfJFg4PmaXQ7xssMs=;
	b=shb/nAomBa1r0w31MtoWVdqGrxVaqYJjhXdvjWDo2YBc2f/bdFvNHbu5tPY154CN4GPP6z
	4K/e+fBgmZuzDx88juCpAR/FBCWMRv94hBkLMysaHWal8CCed6n5pBvciJVdo6pAoCy18/
	RgMpPT6pnz+L3ARi4rdvmDaHuNcFQbIAWnf5mebu5k1vuMHWDw8BXnyY0vHRHxSeRZk0Ya
	m8IKONDv4VapZARtyW/+dDMDFlesv3bF9Zq0nX5Qm+DFf65p9KartORjwoN6Sa7IBAtz0w
	CVgyHJXwFsy4TyTOrdUxm1v5rB2fYAGY1AOskQIcyBUIRWX4qcEyCrAa9zMNQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741201092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RSntaKRcX6bb5OX0LcGpaXqGDiYfJFg4PmaXQ7xssMs=;
	b=Bq/9sah1YOs1Z+rX2TbAXViKuJRFACZgCMXswrHlauBuLhj3DYahHeC4xjroJCWIZAj9ek
	FL9FzU2chLM9qhBQ==
From: "Ahmed S. Darwish" <darwi@linutronix.de>
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	x86-cpuid@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 37/40] x86/cacheinfo: Extract out cache self-snoop
 checks
Message-ID: <Z8iewiPz4WZOdmbE@lx-t490>
References: <20250304085152.51092-1-darwi@linutronix.de>
 <20250304085152.51092-38-darwi@linutronix.de>
 <01367a6b-8eeb-417e-9a66-e7a64d518319@citrix.com>
 <Z8iahUTYuq0gVXmP@lx-t490>
 <6ba638d3-b3a3-410b-9761-0b3658e3215a@citrix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6ba638d3-b3a3-410b-9761-0b3658e3215a@citrix.com>

On Wed, 05 Mar 2025, Andrew Cooper wrote:
...
> It turns out not to be safe in cases where the underlying physical
> memory changes from cacheable to unchangeable.  By skipping the WBINVD
> as part of changing the memory type, you end up with spurious writebacks
> at a later point when the memory is expected to be UC.  Apparently this
> is a problem for CLX devices, hence the change in the SDM.
...
>
> CLX (Cascade Lake) != CXL (Compute eXpress Link).
>
> CXL is the new PCIe.  (So say the CXL consortium at least.)
>

Oh, sorry, you wrote "CLX devices" above, not CXL... Only thing my poor
brain could come up with was CASCADELAKE_X :)

