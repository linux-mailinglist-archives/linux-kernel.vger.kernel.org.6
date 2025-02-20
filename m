Return-Path: <linux-kernel+bounces-523615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D69EDA3D942
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 12:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D98071892E64
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 11:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AB11F12FC;
	Thu, 20 Feb 2025 11:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b="Q1cW/5Yu"
Received: from gimli.kloenk.de (gimli.kloenk.de [49.12.72.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38171EE01B;
	Thu, 20 Feb 2025 11:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.72.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740052642; cv=none; b=WMGAdIjBLyaBZwmYTkWehHGizlfUj/hscC8d4y0wGjjJC2mkmKULfsnabIiY5cEgSBqhHLrQQOwyprxvag2SCrNMgZrMFP9vHHOEMW/II/MKJl+fE4+f/NYdu/taFDb0YRSOSDsbrL1A8erUuhUdXwoVcrPZMy4LP9buML2aQi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740052642; c=relaxed/simple;
	bh=CArsqcWhGizkeiG7wKjwp3IOv3hSwBEcxCzbBao/Zk4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fuQWb/bJ9rdkgwpRi4B92U6TEkDr/ecUdseLcmHgwSgdZQ/2wHEUR+s2wun+c4Lm2XR2rL0LFRf7vKqaaBjIE/G3h0jEfj2CEdAmKvNNOEUFVZPjodPm1if5Iuslz7HCuG4w29PHFub8qJikasIJkqB5Mxqc7Bpb79K4CK2SMbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev; spf=pass smtp.mailfrom=kloenk.dev; dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b=Q1cW/5Yu; arc=none smtp.client-ip=49.12.72.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kloenk.dev
From: Fiona Behrens <me@kloenk.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kloenk.dev; s=mail;
	t=1740052632; bh=q5JoUJwBv/CiMFU1ElCY7M1WksjUZ2azkZJP1PhEzUo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Q1cW/5YuayzXA0m4zWXQcoXS1FcZ1g1bJWMZSEBf3BCizvf6WYeQwV+FU57thRTB8
	 2d6ShjXwigB9g+3CU/MYhxi8nx+FWO36jIFkK9mUKpCgT20T21Ja72pAC1LFof8crc
	 OTit9X7Fg69WJNn8qVbsHLHFx3IGf3TWWGLE0ajY=
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>,  Steven Rostedt
 <rostedt@goodmis.org>,  Jason Gunthorpe <jgg@nvidia.com>,  Kees Cook
 <kees@kernel.org>,  Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
  Christoph Hellwig <hch@infradead.org>,  rust-for-linux
 <rust-for-linux@vger.kernel.org>,  Linus Torvalds
 <torvalds@linux-foundation.org>,  Greg KH <gregkh@linuxfoundation.org>,
  David Airlie <airlied@gmail.com>,  linux-kernel@vger.kernel.org,
  ksummit@lists.linux.dev
Subject: Re: Rust kernel policy
In-Reply-To: <89f2547edcaaba53d9965cab9133d809607330ac.camel@kernel.org>
	(Jarkko Sakkinen's message of "Thu, 20 Feb 2025 10:13:52 +0200")
References: <CANiq72m-R0tOakf=j7BZ78jDHdy=9-fvZbAT8j91Je2Bxy0sFg@mail.gmail.com>
	<Z7SwcnUzjZYfuJ4-@infradead.org>
	<CANiq72myjaA3Yyw_yyJ+uvUrZQcSLY_jNp65iKH8Y5xGY5tXPQ@mail.gmail.com>
	<202502191026.8B6FD47A1@keescook>
	<20250219140821.27fa1e8a@gandalf.local.home>
	<202502191117.8E1BCD4615@keescook> <20250219202751.GA42073@nvidia.com>
	<20250219154610.30dc6223@gandalf.local.home>
	<97841173-1de8-4221-8bf3-3470a5ac98a7@acm.org>
	<89f2547edcaaba53d9965cab9133d809607330ac.camel@kernel.org>
Date: Thu, 20 Feb 2025 12:57:11 +0100
Message-ID: <87pljc6d7s.fsf@kloenk.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jarkko Sakkinen <jarkko@kernel.org> writes:

> On Wed, 2025-02-19 at 12:52 -0800, Bart Van Assche wrote:
>> On 2/19/25 12:46 PM, Steven Rostedt wrote:
>> > I do feel that new drivers written in Rust would help with the
>> > vulnerabilities that new drivers usually add to the kernel.
>> 
>> For driver developers it is easier to learn C than to learn Rust. I'm
>> not sure that all driver developers, especially the "drive by"
>> developers, have the skills to learn Rust.
>
> IMHO, Rust is not that difficult to learn but it is difficult to
> run.
>
> One point of difficulty for me still is the QA part, not really the
> code. QuickStart discusses on how to install all the shenanigans
> with distribution package managers.
>
> The reality of actual kernel development is that you almost never
> compile/run host-to-host, rendering that part of the documentation
> in the battlefield next to useless.
>
> Instead it should have instructions for BuildRoot, Yocto and
> perhaps NixOS (via podman). It should really explain this instead
> of dnf/apt-get etc.

What do you mean with via podman for NixOS?

I do still have on my ToDo list to build and publish a better nix
development shell for kernel with rust enabled, and could also add a
section on how to build a NixOS iso in the same nix code.
But sadly time is a finite resource and so did not yet got to it.

Fiona

>
>> 
>> Bart.
>> 
>
> BR, Jarkko

