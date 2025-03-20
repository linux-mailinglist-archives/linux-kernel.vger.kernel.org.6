Return-Path: <linux-kernel+bounces-569514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D26D3A6A409
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 11:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B69AE189E7D9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 10:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D5B22423E;
	Thu, 20 Mar 2025 10:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sC9jHY6R";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M7NG2Ct1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8050D1EB9F3
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 10:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742467626; cv=none; b=FFG1MAvea3W4nxfj2c36zDgIAvhaRSER99FOnOYZvcQ42VBWdpW8oEmBMb4XEaJmqXZ0nt8Zut0XyBofraLVATaTz9tiMKFNOwGrw+yMPG62TjJrlKzTwaiTi0Dn1A4pz7ZP2lWl9pS95NCqbfyuUj6hJH85x0r+CIhUrvRIH/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742467626; c=relaxed/simple;
	bh=nfjuP5bAezlTHS42u66xkiaf4QBcEY5QodQ62iy0EJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rQj5gh4ItE7xVTa2LpxioHLtDulUmcTcjscejzt+0QSUxqKz2Uc2QlpqXvxhseMh7K1qkS2QjTDTVkmqraki1+HXIAIKI3nnJOLvH62si+eV+gZoUok4g1cc5Mo4P8jkV3u/Ac2wfnhN1LNyXrLeLvGmV6yqPitygI9tQlEX93U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sC9jHY6R; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M7NG2Ct1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 20 Mar 2025 11:47:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742467622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jvEvvo9n9Zn/KFYTYk1CutaYJchw2EpXo8jFzaqmNkI=;
	b=sC9jHY6RDY65gMJYJG9ICseYBvSaDBj+rWU0XaeuAn1uJkZJWS/jxTXK4ZdarhV1fjBhVq
	AYNAFD/nRv2LNQK5BRbYXY9BYelgZrPEeNYQPbTOJGDubX/npDFdZ8DiQnDBvXLgido8OF
	VEZ7zj5r+558K6mYtEH/djx1/MEqAbP+yj3UQfYQexEtbsHDx+z9VJHrMdGg5r7EYULP3a
	SZJD+sLP1a1gj13g9mlE6zOBzYhfIac03AdWkN46vs4/z2yQeCg7OwmGzvpE+po1PafBeJ
	fnE7vwZDoa3mqUAXNn7WaodRmn7Jlv2L06wcGGEwU84xgkSC2Q/go6GuQ2S+sg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742467622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jvEvvo9n9Zn/KFYTYk1CutaYJchw2EpXo8jFzaqmNkI=;
	b=M7NG2Ct1zZHKDNJGVw9PHnH6AwSALrZKAeHSSrIG1Zz2cmXJgQ3UpTsuoKtjDj9Btn/4mm
	TIi+gyDry1pmwGBA==
From: "Ahmed S. Darwish" <darwi@linutronix.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	John Ogness <john.ogness@linutronix.de>, x86@kernel.org,
	x86-cpuid@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 01/29] x86: treewide: Introduce
 x86_vendor_amd_or_hygon()
Message-ID: <Z9vyJLXNL2-CTIIG@lx-t490>
References: <20250317164745.4754-1-darwi@linutronix.de>
 <20250317164745.4754-2-darwi@linutronix.de>
 <20250317173216.GGZ9hcoDICYl1fBtBG@fat_crate.local>
 <Z9lUB2t0eZ8bz4vW@lx-t490>
 <14F10A4B-A274-40B2-9609-669E09981812@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14F10A4B-A274-40B2-9609-669E09981812@zytor.com>

On Wed, 19 Mar 2025, H. Peter Anvin wrote:
>
> On March 18, "Ahmed S. Darwish" wrote:
> >
> > Then I found that there are 28 other cases in the x86 tree where the
> > AMD/Hygon CPU vendor check is also combined.  So I did that macro and
> > it also made a number the affected sites more succinct; e.g.:
> >
> > ...
>
> I would agree that abstracting this into something higher level makes
> sense, but have you considered whether or not it is actually necessary
> to do this in the first place? In the case of level 0x8000001d for
> example, that should be handled by the end bracket from leaf
> 0x80000000.
>
> In general, VFMS checks are not a good thing.
>

Great point, I'll consider that when I (soon) touch these areas again.

In the next PQ, wherea cached CPUID table built on early boot, "CPUID
truth" is centralized.  This way, the VMFS checks can indeed be reduced.

Thanks!

--
Ahmed S. Darwish
Linutronix GmbH

