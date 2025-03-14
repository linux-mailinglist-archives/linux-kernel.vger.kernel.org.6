Return-Path: <linux-kernel+bounces-561613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD683A61408
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 15:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68187883DA9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 14:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70433201027;
	Fri, 14 Mar 2025 14:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kFb1CS52"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D262D1990BA;
	Fri, 14 Mar 2025 14:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741963744; cv=none; b=RcF6qMrbR+si3eQ2WKhCfEVhZGSfn1eoaUVYix5OGyqDyAPo+fXj42CAIraAXFeJDt94w58crnSq9OIXO7SDDeh8g09SDEmarsM8IpbvIXyUVVZ/+cYJgDL+AwZU4J03aBkePjzy70nX5FKm/5qPtCy8apzJ47X2hPpPAxsBSRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741963744; c=relaxed/simple;
	bh=umdtNZvCMKR3hyTkxSzAD7wrEpgB28z7LyK6WGLi+Fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dA3+TbLSggwtIJjXAg9yq9hp7mJnMgk+tRhTGgr9h4VaZcGxn6zUC1f77M+9duB0qAqamYrcviPYnmK3WmsghiGMsqGj6QwUopPRQovXdn/88UQ5YbTJ5nFzYkDZjSfpM2wSTliI6nBuijR14G6du4oVzs6gd146HFQZEu1dLKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kFb1CS52; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF3D7C4CEE3;
	Fri, 14 Mar 2025 14:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741963744;
	bh=umdtNZvCMKR3hyTkxSzAD7wrEpgB28z7LyK6WGLi+Fw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kFb1CS52A91O11wr5MdYvoQ3kIKjDKCftOYtJBonBRofQ/ynlA2l4ZKjRVoyiopNa
	 Hkw2h6F9wvGGLd6ri6eUd98mLx4XpWOcHIob/vxoVICTR7QiGLosi2eZ8g9jGeAgPl
	 vL/Vrc5HbS58gfsb7hky1+0qf/dvrSODv+KsxKTJ2yo0d/sYCf8Qhv6ElKzrKaUXFs
	 rWSMJKHA1gIlHyJlV9gIc61W6dJMxfjAqLWvnBOIkS50chYGyKO5dBUYMXHSJUbEvp
	 cti+pZUpM9RUZ2o+dEebLzcwcd2JhesY3fJ5Tkx+6S817IPOoJ9ZyvfWnUfTBIIxkT
	 tfiDt4DYNVlSQ==
Date: Fri, 14 Mar 2025 16:48:59 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Fiona Behrens <me@kloenk.dev>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org, Tamir Duberstein <tamird@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: TPM DEVICE DRIVER: linux-tpmdd-nixos
Message-ID: <Z9RB2zwtCBq32CKy@kernel.org>
References: <20250306211716.51120-1-jarkko@kernel.org>
 <CANiq72kfo1zSsLc5TWr3wS3t2e5OK_hnECGMpAv-7ezyBsnPig@mail.gmail.com>
 <Z8skWemfaM7siKl8@kernel.org>
 <m2ikodxjbc.fsf@kloenk.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <m2ikodxjbc.fsf@kloenk.dev>

On Thu, Mar 13, 2025 at 12:26:47PM +0100, Fiona Behrens wrote:
> Jarkko Sakkinen <jarkko@kernel.org> writes:
> 
> > On Fri, Mar 07, 2025 at 10:22:10AM +0100, Miguel Ojeda wrote:
> >> On Thu, Mar 6, 2025 at 10:17 PM Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >> >
> >> > This is my new testing tree for my kernel tree. It will over time replace
> >> > my previous BuildRoot based testing tree (but not just yet).
> >> 
> >> Thanks for Cc'ing! I assume this is related to your subsystem and that
> >> it will go through there.
> >> 
> >> Cc'ing Fiona as well since she was interested in Nix and Tamir who
> >> does macOS; so they may be interested.
> >
> > Yeah, so I just used get_maintainer.pl and it picked you but I'm
> > happy if you enjoy it :-) linux-tpmdd comes originally from TPM driver
> > but these days it's really just my maintainer tree for every possible
> > pull request I do, as I'm also e.g. Linux keyring co-maintainer.
> >
> > My biggest barrier with Rust has been testing (like almost always in any
> > software engineering problem) so I just figured out something that would
> > sort it out for me. I also thought that by starting doing some testing
> > for Rust patch sets that contain some tests would be a low-barrier way
> > for me to learn a bit how everything works in that side.
> >
> > I think I quickly talked about this with Fiona and this is a bit
> > different angle in a way i.e., using Nix for profit as a tool to
> > implement together with Docker a trivial embedded build system so that
> > you can build kernel + EFI in any operating system (I personally use
> > Fedora).
> 
> Yeah exactly, took me a while to understand your usage :)
> I use nix mainly as a dev shell and plan to add building the kernel
> through nix.
> 
> Once I have the time and remember this still then I might try to include
> your work in the nix repo I maintain. Maybe we can also build docker
> container images for kernel development processes using nix and stuff
> like that.

Yes, so no plans to step on your toes. I'm going to keep this
"opionated repository" for my own maintainer work :-) And
possibly for some contributions outside my usual sandbox.

That said, anything can be taken for more generic use... [ping
me for license incompatibility issues, I de-facto to GPLv3 but
permit to other licensing framework on request].

> 
> Thanks,
> Fiona

BR, Jarkko

