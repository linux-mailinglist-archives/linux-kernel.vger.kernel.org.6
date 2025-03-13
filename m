Return-Path: <linux-kernel+bounces-559322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E4FA5F24E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7BAD19C1E58
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 11:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB3E2661A8;
	Thu, 13 Mar 2025 11:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b="XZ+bf98u"
Received: from gimli.kloenk.de (gimli.kloenk.de [49.12.72.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11E3266189;
	Thu, 13 Mar 2025 11:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.72.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741865212; cv=none; b=HJZxuLmp122lsbuZKP7WCku3UzGsz5wrrE/0LAQmCmb2KItOhn9SI+s/p7VTLZcjpwokXIOfQBvrPQiiBMHUv1xfFnw+Clf71QcmafCZaSeYdDv4j9WZ8xnBmcG9GPKlMMbi/1kEQSrLqhaGWJLK2nKcEwNjOuZx8+2b5PzcEL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741865212; c=relaxed/simple;
	bh=3/x30GJGtcjFchnJj431Pg0+QQZck3UirD0xqfkulZ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LET9FUW8wUkr4QMAjOO4+XbX5qLwtCCTaBlHqgDfhfwJ8+cGJHB688BSISoA315WxdJNebZwvbyDplO8+TAtixDL6ZRJQH5K2JtAIkiVVxqfQZ5fsgutKf+4R4YgbKTXUpdiAMTEt4Qb1s3IQF9BKnyafZuH8BTrVEgZC70vgRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev; spf=pass smtp.mailfrom=kloenk.dev; dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b=XZ+bf98u; arc=none smtp.client-ip=49.12.72.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kloenk.dev
From: Fiona Behrens <me@kloenk.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kloenk.dev; s=mail;
	t=1741865208; bh=3/x30GJGtcjFchnJj431Pg0+QQZck3UirD0xqfkulZ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=XZ+bf98uLGbo/a3FrECGUEsrFjO1JFv+ostMZqtKV5VxD9/8b0bR7Kr3ep7Hg7238
	 K8v2NDfHRZ5pVyG7yUG6aLJsDW3mKgaZoFSTh4/iNiMqxhiiu0Tz2AecTe999f7f4c
	 238doWlTkT1bL+VCk2G5ukq0xh69u2Y+9p+OK2sI=
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
  linux-kernel@vger.kernel.org,  Miguel Ojeda <ojeda@kernel.org>,  Alex
 Gaynor <alex.gaynor@gmail.com>,  Boqun Feng <boqun.feng@gmail.com>,  Gary
 Guo <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,
  Benno Lossin <benno.lossin@proton.me>,  Andreas Hindborg
 <a.hindborg@kernel.org>,  Alice Ryhl <aliceryhl@google.com>,  Trevor Gross
 <tmgross@umich.edu>,  rust-for-linux@vger.kernel.org,  Tamir Duberstein
 <tamird@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: TPM DEVICE DRIVER: linux-tpmdd-nixos
In-Reply-To: <Z8skWemfaM7siKl8@kernel.org> (Jarkko Sakkinen's message of "Fri,
	7 Mar 2025 18:52:41 +0200")
References: <20250306211716.51120-1-jarkko@kernel.org>
	<CANiq72kfo1zSsLc5TWr3wS3t2e5OK_hnECGMpAv-7ezyBsnPig@mail.gmail.com>
	<Z8skWemfaM7siKl8@kernel.org>
Date: Thu, 13 Mar 2025 12:26:47 +0100
Message-ID: <m2ikodxjbc.fsf@kloenk.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jarkko Sakkinen <jarkko@kernel.org> writes:

> On Fri, Mar 07, 2025 at 10:22:10AM +0100, Miguel Ojeda wrote:
>> On Thu, Mar 6, 2025 at 10:17=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.o=
rg> wrote:
>> >
>> > This is my new testing tree for my kernel tree. It will over time repl=
ace
>> > my previous BuildRoot based testing tree (but not just yet).
>>=20
>> Thanks for Cc'ing! I assume this is related to your subsystem and that
>> it will go through there.
>>=20
>> Cc'ing Fiona as well since she was interested in Nix and Tamir who
>> does macOS; so they may be interested.
>
> Yeah, so I just used get_maintainer.pl and it picked you but I'm
> happy if you enjoy it :-) linux-tpmdd comes originally from TPM driver
> but these days it's really just my maintainer tree for every possible
> pull request I do, as I'm also e.g. Linux keyring co-maintainer.
>
> My biggest barrier with Rust has been testing (like almost always in any
> software engineering problem) so I just figured out something that would
> sort it out for me. I also thought that by starting doing some testing
> for Rust patch sets that contain some tests would be a low-barrier way
> for me to learn a bit how everything works in that side.
>
> I think I quickly talked about this with Fiona and this is a bit
> different angle in a way i.e., using Nix for profit as a tool to
> implement together with Docker a trivial embedded build system so that
> you can build kernel + EFI in any operating system (I personally use
> Fedora).

Yeah exactly, took me a while to understand your usage :)
I use nix mainly as a dev shell and plan to add building the kernel
through nix.

Once I have the time and remember this still then I might try to include
your work in the nix repo I maintain. Maybe we can also build docker
container images for kernel development processes using nix and stuff
like that.

Thanks,
Fiona

>
>>=20
>> Cheers,
>> Miguel
>
> BR, Jarkko

