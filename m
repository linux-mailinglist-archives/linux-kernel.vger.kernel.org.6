Return-Path: <linux-kernel+bounces-545837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0863BA4F248
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 01:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 710CF3AB7C2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 00:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62A22B9B4;
	Wed,  5 Mar 2025 00:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OmMNEeWp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AE22629F;
	Wed,  5 Mar 2025 00:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741133871; cv=none; b=feYbZ79R5qaJohx3YKQR2Geg/HDIyoVTPuYwm3PB6EyGz/ErqDjrumOPz3UhNss+dnpCNjrOD/QWAVl/qptIvSvFBo21JSqdc2vG1h2n4fE1T2FzPs81O1eEy0Z+bml6Q/pu6O3g6o0n7onO09XELMdibzS9aHRGlk7yeRn2mNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741133871; c=relaxed/simple;
	bh=GCwnNMHtzCFU1wUrFNnbzOpDwp4f92WgfqmKFjh0qtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SW6zLy1WjTMmhBQSyyJ2YD1bLNe03/RLJQz0wVKeay0yBBFwR1i8PfklrKBOHXLqNlXEuLxNnuYEUbtrCXpuTHBCB7AEBu/NWGuuy6NsGwN8O/ZJY6JLm6DJSkX8G1HqJtMa+y7rRJi9JhOxreIXO2Zlk91VItg507HGOfukZAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OmMNEeWp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21EFEC4CEEB;
	Wed,  5 Mar 2025 00:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741133870;
	bh=GCwnNMHtzCFU1wUrFNnbzOpDwp4f92WgfqmKFjh0qtk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OmMNEeWpwMxhWo9WisWFmyn4hZhObP21OQGDrxdaUvrlJBNNogBAufsQ8C7X8XiRj
	 QVqWONyKwKUyte/CdwBTR61br5MkgvUynOA0N+zAtSFXt1r0x0vHLS08Zp1nywmNp8
	 bPbCrjc4YmZ9VX4dd+34qzuFK5uDrZ8qaJvgYvIApyDJVu34mHD4c9M1ynJumVOuu5
	 IBsk3Pcdhm5B0o3EPCpSbHoUtnVk1teJ9NthRLwPgOprOBbzYjvimoxRUx3QqtB1ef
	 sEevljJhuvemDMi9TrgWwDYc6p4ikBsFeCZBFyp5DvXObHKz2W6JY5UeMHjq+dr5oo
	 UpmuAnxG/z84w==
Date: Wed, 5 Mar 2025 02:17:45 +0200
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
Message-ID: <Z8eYKXCl0co-GLaf@kernel.org>
References: <20250304225245.2033120-1-benno.lossin@proton.me>
 <20250304225245.2033120-23-benno.lossin@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304225245.2033120-23-benno.lossin@proton.me>

On Tue, Mar 04, 2025 at 10:56:27PM +0000, Benno Lossin wrote:
> Add maintainers entry for the `pin-init` crate.
> 
> This crate is already being maintained by me, but until now there
> existed two different versions: the version inside of the kernel tree
> and a user-space version at [1]. The previous patches synchronized these
> two versions to reduce the maintenance burden. In order to keep them
> synchronized from now on, separate the maintenance from other Rust code.
> 
> Link: https://github.com/Rust-for-Linux/pin-init [1]
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> ---
>  MAINTAINERS | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8e0736dc2ee0..ced7fac4dbbe 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20735,6 +20735,19 @@ S:	Maintained
>  F:	rust/kernel/alloc.rs
>  F:	rust/kernel/alloc/
>  
> +RUST [PIN-INIT]

In some subsystems the order is exactly the opposite. E.g.,

ASIX PHY DRIVER [RUST]

> +M:	Benno Lossin <benno.lossin@proton.me>
> +L:	rust-for-linux@vger.kernel.org
> +S:	Maintained
> +W:	https://rust-for-linux.com/pin-init
> +B:	https://github.com/Rust-for-Linux/pin-init/issues
> +C:	zulip://rust-for-linux.zulipchat.com
> +P:	rust/pin-init/CONTRIBUTING.md
> +T:	git https://github.com/Rust-for-Linux/linux.git pin-init-next
> +F:	rust/kernel/init.rs
> +F:	rust/pin-init/
> +K:	\bpin-init\b|pin_init\b|PinInit
> +
>  RXRPC SOCKETS (AF_RXRPC)
>  M:	David Howells <dhowells@redhat.com>
>  M:	Marc Dionne <marc.dionne@auristor.com>
> -- 
> 2.47.2
> 
> 
> 

BR, Jarkko

