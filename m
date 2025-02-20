Return-Path: <linux-kernel+bounces-523823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CAEA3DBBF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 748B37A1B0B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 13:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A1E1FA177;
	Thu, 20 Feb 2025 13:52:04 +0000 (UTC)
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BBD35942;
	Thu, 20 Feb 2025 13:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740059523; cv=none; b=DCndAtN64FZvFuVGsmpL3J7ywjcdZX386xCjC9fyxsAyKKyldvdjoLnDUCPeZ5t+T+3pgu6QDvIM/EcnnFgXP4AxliIaK+/0kFM4fFdhZnsuaH5hABk+w1XUV2yN9aL9Dj9e7QYPNXgMqT0eZNR6qGzu0nNEsio300r81kpe9zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740059523; c=relaxed/simple;
	bh=UnilBy2RnRb9X3rZBbiCd90PGFsBjYwR6gwfmw/GDyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F521U50Trm0KqxAMniKoKKRaWEpSJnoXBbuhTILvhA6MOiJ5DKG7BjXXORM2KBqAetT7pjFS/Ce+TikKmAx+5NpuJgBF9LHwFptA/fTcbc/en3pGUUZzU76/+GJ6kd2BMLYpMnCO/eC+2X6VtilRcKjjoWiiQIHqtHW9BVMTsc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 51KDpngr031624;
	Thu, 20 Feb 2025 14:51:49 +0100
Date: Thu, 20 Feb 2025 14:51:49 +0100
From: Willy Tarreau <w@1wt.eu>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Jan Engelhardt <ej@inai.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
        ksummit@lists.linux.dev
Subject: Re: Rust kernel policy
Message-ID: <20250220135149.GB31486@1wt.eu>
References: <Z7SwcnUzjZYfuJ4-@infradead.org>
 <CANiq72myjaA3Yyw_yyJ+uvUrZQcSLY_jNp65iKH8Y5xGY5tXPQ@mail.gmail.com>
 <326CC09B-8565-4443-ACC5-045092260677@zytor.com>
 <CANiq72m+r1BZVdVHn2k8XeU37ZeY6VT2S9KswMuFA=ZO3e4uvQ@mail.gmail.com>
 <a7c5973a-497c-4f31-a7be-b3123bddb6dd@zytor.com>
 <Z7VKW3eul-kGaIT2@Mac.home>
 <2025021954-flaccid-pucker-f7d9@gregkh>
 <2nn05osp-9538-11n6-5650-p87s31pnnqn0@vanv.qr>
 <2025022052-ferment-vice-a30b@gregkh>
 <9B01858A-7EBD-4570-AC51-3F66B2B1E868@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9B01858A-7EBD-4570-AC51-3F66B2B1E868@zytor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Feb 20, 2025 at 05:23:54AM -0800, H. Peter Anvin wrote:
> In the NASM codebase I long ago started using nasm_new() and nasm_zero()
> macros for this purpose, and structure copies really can just be aasignment
> statements. People writing C seem to have a real aversion for using
> structures as values (arguments, return values or assignments) even though
> that has been valid since at least C90 and can genuinely produce better code
> in some cases.

I do use them in some of my code, particularly dual-value return types.
They have the benefit of often working with a register pair and coming
at zero cost, while allowing to support both a status and a value. I've
even made a strings library ("ist") that uses (ptr,len) and passes that
as arguments and returns that. That's super convenient because you can
chain your operations on a single line (e.g. to concat elements) and
the resulting code remains efficient and compact.

The real issue with structure assignment (in the kernel) is that the
compiler knows what to copy and will usually not do anything of holes
so that's how we can easily leak uninitialized data to userland. But
outsize of this specific case that could be instrumented, I like and
encourage this practice!

Willy

