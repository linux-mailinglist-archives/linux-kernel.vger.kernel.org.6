Return-Path: <linux-kernel+bounces-546042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA791A4F57E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 04:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFD7716F483
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 03:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB9517557C;
	Wed,  5 Mar 2025 03:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GQb90o3s"
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93132E3394
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 03:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741146131; cv=none; b=a2vYIMaJ+Pqu7NUpbjyFQmGFHlSdYRatKbHgCoSjuDgoKoJ/HpWMXEmHLrA33aFgciMmGwK44vkzswOy9iPwddMWBZhuWWDvNGGTIifBfolg12R8nOpH+mT1hoqV4R2KVnkCtCrsxXS/15inNBSv1MZSNDkBVTL1HRaP4MNLCX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741146131; c=relaxed/simple;
	bh=QZ4lWkRttzinBC0AHtaGogoBVkKE6Fr+UE0tadSUJYM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=to1/v50cHSfSlzkMKKfX0VepXd/uOTpKs3Mt5CaDutaDm0DEl4BjK63AhfksqjwlZOz+6+Z216wUllwm4czen0idEhW6szOn5dbwuREFiiMkofCIsMtF3JcfyAxH8mE8YqtOOz6/TKPez6KKXXz25Sm1/XKKBS4lblauGVfzk5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GQb90o3s; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id B3B89114009D;
	Tue,  4 Mar 2025 22:42:07 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 04 Mar 2025 22:42:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741146127; x=1741232527; bh=tz0GmYq+BExKvK4136gHJad7G7TbjBEd2Ek
	cgzIuImk=; b=GQb90o3sM+84OL/1ng3GSlG5DiG1ydWAH6S5CvP/1I20x30e3jr
	kF9ikNvI4PjTkAtpXclbZ3uI96SxWXpi3YZG0jYyFIr4Y9uFKsLlMcpUktY/3336
	IChOv6cszsld3SzsXEzK1XxoXnLGYsc+14BDVXfhCkC26GW1XFzROUkS39G6/nrv
	z7sMnFSozIcKZ/acH+jQpGv2mGXIYFP3qGZaDxBfPZH4PSLvFBGsJLCOWWK72VMk
	TI5M5QZSaXDqf95HVVonMD6o5u0oaZPJE5TSfCzsNpN13pk/Nn4jD26D4pQ3QqYa
	OliRfJUss8kiY+4l2Qr0VLxMOPESvFsOd8w==
X-ME-Sender: <xms:DsjHZz7YXbuPo4wAWMMnHKDWWAFq_1EW-etKql8a-sYsm03XusoBog>
    <xme:DsjHZ47iWnwJcdX4tI3B7Exm86Nfmebxsh4NUyy8zQOkGyXCmk2q2BsTnk_351Xy9
    j1fQOEZMorgTW5TJXA>
X-ME-Received: <xmr:DsjHZ6dihpBVNb-10CZIyt0oDgBg8pRvje4cYxAW0AY1e3O5LdoxQUuCQ36Y-SGCqRuRP84gtTVhxED_KQRJP4SafVban-jh8Rg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdefjeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevufgjkfhfgggtsehttdertddttddv
    necuhfhrohhmpefhihhnnhcuvfhhrghinhcuoehfthhhrghinheslhhinhhugidqmheike
    hkrdhorhhgqeenucggtffrrghtthgvrhhnpeelueehleehkefgueevtdevteejkefhffek
    feffffdtgfejveekgeefvdeuheeuleenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgpdhn
    sggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurghnih
    gvlhestdigtdhfrdgtohhmpdhrtghpthhtohepjhhjuhhrrghnsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghgvvghrtheslhhinhhugidqmheikehkrdhorhhgpdhrtghpthhtoh
    eplhhinhhugidqmheikehksehlihhsthhsrdhlihhnuhigqdhmieekkhdrohhrghdprhgt
    phhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:DsjHZ0J3sU5gd_NsBXEKd4wKI2TYl78BVuJC0aDppv9Ya2gLdQ6G4Q>
    <xmx:DsjHZ3LX0FsYY5R5G_SblUR6LDSFsx_NnURLjUsc3FARg_RgMku8zg>
    <xmx:DsjHZ9zDerMzveL45_U04ycf1a88iSuhMp5sicKidNyedhHCSnW8jQ>
    <xmx:DsjHZzKeqoAUfOh4ozzGKEcgF2HjdxyWXzQNFT9NbPoPZYm1IwlBkQ>
    <xmx:D8jHZ0EBa87QptBOZ8o_5cPlCFxRJg0IbufXXU7ZJlYbIrUvS8ChiUBq>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Mar 2025 22:42:03 -0500 (EST)
Date: Wed, 5 Mar 2025 14:42:02 +1100 (AEDT)
From: Finn Thain <fthain@linux-m68k.org>
To: Daniel Palmer <daniel@0x0f.com>
cc: Josh Juran <jjuran@gmail.com>, geert@linux-m68k.org, 
    linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: Bootloaders, was Re: [RFC PATCH 0/3] m68k goes DT
In-Reply-To: <CAFr9PXmXsW=RqJsWPCUDvQO+vst-wSj__Fi3nuxCo7ZRAi0wOA@mail.gmail.com>
Message-ID: <3893637a-0a03-5782-a61d-18fbaf9938d3@linux-m68k.org>
References: <20250105071433.3943289-1-daniel@0x0f.com> <291d1541-e026-cc50-6a55-42c11c64b6eb@linux-m68k.org> <CAFr9PXm4kTWF27GPMNDb5=W8vZRQia418xOQDF_X1yo0vwn6hA@mail.gmail.com> <4eb796cc-b178-8394-0149-03600f1caaed@linux-m68k.org> <B5B5D58B-D111-431F-9701-44FCBB67D11E@gmail.com>
 <b33b072e-f44a-9450-cbe9-52300ab971a3@linux-m68k.org> <CAFr9PXmXsW=RqJsWPCUDvQO+vst-wSj__Fi3nuxCo7ZRAi0wOA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


On Tue, 4 Mar 2025, Daniel Palmer wrote:

> FWIW I have started to move EMILE over to using meson to build (so
> it's easier to build on modern systems) and fixing up some of the
> issues it has with building with recent GCC.

Thanks for doing that.

> I have it working enough to boot HEAD on a LC475 and on QEMUs Q800
> machine. While the penguin ui is nice EMILE seems to work well enough
> and it can be used to generate bootable CDs.

That's good news -- I've long wondered whether QEMU's emulated q800 had 
reached a point where it could run EMILE. That will make development 
easier.

> I have a setup now that can generate a bootable CD with the kernel and a 
> buildroot based userland that I can drop on the SD card for my bluescsi 
> and boot into Linux without any macos intervention.
> 

I guess it's only a matter of time before someone puts EMILE into EEPROM. 
(Many of these systems have a ROM SIMM slot.)

> So basically, for 68k mac I think EMILE is the way to go.
> 

And there is a way to go...

Penguin 19 works on every 68k Mac model. That's hard to achieve and 
running under MacOS helps a lot. EMILE doesn't have that advantage so it 
isn't expected to enjoy the same level of hardware compatibility without 
further work.

For systems that have the standard ROM, booting MacOS is an easy first 
step for system recovery purposes or just experimentation. So I think 
EMILE needs a MacOS UI which, though it might not boot Linux, could do the 
bootloader installation and config (a bit like what XPostFacto did for Mac 
OS X) so the ROM could then boot into EMILE (and Linux).

