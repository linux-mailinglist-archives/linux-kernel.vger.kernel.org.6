Return-Path: <linux-kernel+bounces-551599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B12A56E60
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70C811898693
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8641223BCFF;
	Fri,  7 Mar 2025 16:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pR164suK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09EB2DF68;
	Fri,  7 Mar 2025 16:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741366367; cv=none; b=K6ELknpRXWejAUVGAZIpFqapqvCAy4sIMPYjhviT8fjN2ZHc5Xerb3bQlwIX0fJriHvkFG9UIAa4QwSHzCAa7Y33bG0Q44cPSZPhofW7CKZVbB7T2wVmU20OHTXI+XdVOG3VlJz6+JdmgXMWG7poxagPXb7O1lA/LRvCKx9cl54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741366367; c=relaxed/simple;
	bh=6eORa4q2JbfM6X1xTRVea2APNpFRXnTm29+hH+QB02s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uNu1QnmEG3Ac26zZOwi5Y7RMy4AMTuB5lk7pZTn/QL0UgWPhAU9fdkWQSzw6zs7SAw3I+Vn1JvD6IDQNuBa7MhQXsJF7kUoBWEnltNzLrg38jz7OeLGjJ4EvFgE0TQVaHh5WjM9AAvagxaxnq+v2bMYmOcA5avntIAUWCWQgSZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pR164suK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5DC2C4CED1;
	Fri,  7 Mar 2025 16:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741366366;
	bh=6eORa4q2JbfM6X1xTRVea2APNpFRXnTm29+hH+QB02s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pR164suKtLS/74NOzc4YR7bPeN9hM40XVMPjGgiwOePTV5a81GMCPNsraL0jd2nGx
	 5aQ+gnZd1ju9gzjzVhoXJNvvWUbBdCKnWCPSkh42sM/trQmhK2EnPsU2Qhfx5DgP7B
	 AzV2KwUOc99Jwk7gEF7F6Ju9BoIkhwLjZ9sTeaZYT/ldWrmPOood9gwDP6efX7vzEf
	 /ra0LA30ch+/rViydLlOd5KiUnH/ORjq+Yu1h6iRZ+wMtCbFOYek//XgZLQy0w4Aa+
	 uQIddmYO95Z4U3vAaKhsk+N+jZw5Q+n4T0ertodWok7XHyfSc1K+02kYflWnjjjg0W
	 sjC2+G0AcTHjA==
Date: Fri, 7 Mar 2025 18:52:41 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org, Fiona Behrens <me@kloenk.dev>,
	Tamir Duberstein <tamird@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: TPM DEVICE DRIVER: linux-tpmdd-nixos
Message-ID: <Z8skWemfaM7siKl8@kernel.org>
References: <20250306211716.51120-1-jarkko@kernel.org>
 <CANiq72kfo1zSsLc5TWr3wS3t2e5OK_hnECGMpAv-7ezyBsnPig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72kfo1zSsLc5TWr3wS3t2e5OK_hnECGMpAv-7ezyBsnPig@mail.gmail.com>

On Fri, Mar 07, 2025 at 10:22:10AM +0100, Miguel Ojeda wrote:
> On Thu, Mar 6, 2025 at 10:17 PM Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >
> > This is my new testing tree for my kernel tree. It will over time replace
> > my previous BuildRoot based testing tree (but not just yet).
> 
> Thanks for Cc'ing! I assume this is related to your subsystem and that
> it will go through there.
> 
> Cc'ing Fiona as well since she was interested in Nix and Tamir who
> does macOS; so they may be interested.

Yeah, so I just used get_maintainer.pl and it picked you but I'm
happy if you enjoy it :-) linux-tpmdd comes originally from TPM driver
but these days it's really just my maintainer tree for every possible
pull request I do, as I'm also e.g. Linux keyring co-maintainer.

My biggest barrier with Rust has been testing (like almost always in any
software engineering problem) so I just figured out something that would
sort it out for me. I also thought that by starting doing some testing
for Rust patch sets that contain some tests would be a low-barrier way
for me to learn a bit how everything works in that side.

I think I quickly talked about this with Fiona and this is a bit
different angle in a way i.e., using Nix for profit as a tool to
implement together with Docker a trivial embedded build system so that
you can build kernel + EFI in any operating system (I personally use
Fedora).

> 
> Cheers,
> Miguel

BR, Jarkko

