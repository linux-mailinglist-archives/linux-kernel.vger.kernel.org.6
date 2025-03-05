Return-Path: <linux-kernel+bounces-546102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 207F0A4F655
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 06:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FD0A168E4F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 05:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04ADB1C8623;
	Wed,  5 Mar 2025 05:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xx/vFU2u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0114A06;
	Wed,  5 Mar 2025 05:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741151656; cv=none; b=Zs2Ku+Bnof7eDGCPciZPGbJsnFp/3cSTz4LndxE891kpGeKQuMPxUpDTMwbvqx2AY9bbXX/dHrUKTHG9wF/w5G/eRubHUaH3OSCArHzXjnV+RcMWR1dan6Z4XZQAEpnwstkoLPuZoRgjIGKHqAKh1kliWE+C0SFdph5IiLXk60E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741151656; c=relaxed/simple;
	bh=a37mwpxg/329Ql18YmT7M0sn5MSdBswKZ6X0FxpRc4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j0xkvHrFOzYVux1zXKSz6t148yhYUj7fycw1+HpL2ITGXjCYDpb2wiQPnwPTI4tA6C5dSI54IHLc2zWDn7+/PZvnJmKjHA/PhETz/AmhQ/fihNUhA5/uWQEXC7HkTR+eKWZzP1f9cGmCh3M7zBT5JlsTyG2QMdO8Axk9is1GH4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xx/vFU2u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D68DC4CEE2;
	Wed,  5 Mar 2025 05:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741151653;
	bh=a37mwpxg/329Ql18YmT7M0sn5MSdBswKZ6X0FxpRc4g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xx/vFU2uWRv5gOSLFXGAjRuDw4e5VsSXRNW8A28ok0f93/wjec6RA8GxcgbucH7kO
	 XHxp3SE34E737A3lLqwMLAGtssVtR11AEc3mAX7SSfqJJ9FVcjMDKt95a/NAhQxJEA
	 Ymq7mH7lO6Ipr4URST5znadabiEj5HpekgJK5CqL2BewL6GkUo05pzAt8m9QTQlgsE
	 pWLbzn0bDpD96LbgVqYaTnQuqm1YJGMS6kewweW3EhOwoixDp8419fsgGxOL34iFd6
	 qDDzWg187R9emSHz1ay2ZgKmbK/bJx1bIESe2NZQlHb1cK0jBJhKE3EDJUwrs00RAs
	 jW17PHTlW/BFw==
Date: Wed, 5 Mar 2025 07:14:09 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 22/22] MAINTAINERS: add entry for the `pin-init` crate
Message-ID: <Z8fdoWB5hMHe0EaB@kernel.org>
References: <20250304225245.2033120-1-benno.lossin@proton.me>
 <20250304225245.2033120-23-benno.lossin@proton.me>
 <Z8eYKXCl0co-GLaf@kernel.org>
 <D87WZI6NPPOG.EJ4OGCTG4O9R@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D87WZI6NPPOG.EJ4OGCTG4O9R@proton.me>

On Wed, Mar 05, 2025 at 12:43:18AM +0000, Benno Lossin wrote:
> On Wed Mar 5, 2025 at 1:17 AM CET, Jarkko Sakkinen wrote:
> > On Tue, Mar 04, 2025 at 10:56:27PM +0000, Benno Lossin wrote:
> >> Add maintainers entry for the `pin-init` crate.
> >>
> >> This crate is already being maintained by me, but until now there
> >> existed two different versions: the version inside of the kernel tree
> >> and a user-space version at [1]. The previous patches synchronized these
> >> two versions to reduce the maintenance burden. In order to keep them
> >> synchronized from now on, separate the maintenance from other Rust code.
> >>
> >> Link: https://github.com/Rust-for-Linux/pin-init [1]
> >> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> >> ---
> >>  MAINTAINERS | 13 +++++++++++++
> >>  1 file changed, 13 insertions(+)
> >>
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index 8e0736dc2ee0..ced7fac4dbbe 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -20735,6 +20735,19 @@ S:	Maintained
> >>  F:	rust/kernel/alloc.rs
> >>  F:	rust/kernel/alloc/
> >>
> >> +RUST [PIN-INIT]
> >
> > In some subsystems the order is exactly the opposite. E.g.,
> >
> > ASIX PHY DRIVER [RUST]
> 
> I think that `RUST [PIN-INIT]` makes sense in this case, since it is a
> core Rust library. In the example you gave above, the `ASIX PHY DRIVER`
> subsystem already exists, so it makes sense to have a rustified version.
> With pin-init, there is no C counterpart. So IMO the only other
> alternative would be just `PIN-INIT`.

Right, got it, thanks.

BR, Jarkko

