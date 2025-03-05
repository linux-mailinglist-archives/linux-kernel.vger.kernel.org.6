Return-Path: <linux-kernel+bounces-546703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F281A4FDD1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 12:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 114A81892F4B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68EE23ED52;
	Wed,  5 Mar 2025 11:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TXFsjj0N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF1821519F;
	Wed,  5 Mar 2025 11:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741174677; cv=none; b=FetOAG8d8dgzFckQmYbGb/qdrcaZtYTvqLYHjihOj5jVgw3v53Kgfb3HKFtGULDTlZOYu2CUDHr35sSVxpAB0vCJLeVwGGrePmR9MprrOnZYkDg4zEtpRqBXnDpflxs6MqzqlgZEAjczQYzNElHjW7haffAHEAp7lQNQXIYhAUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741174677; c=relaxed/simple;
	bh=SfO9DhTgwjDi7AtLeGy/7XGGLiNrKvCDa7E6MONV8Hc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IL2knQjp1+2aKuWa3VqCbEjKCZhcvmMgLKXttlIArxZ3yBXbJJLSZm89xTHyq918zm1xZoqQ5Je/fg2LVBG5FESCAu+/9+r34v9gOmTwdlY5Og8H54l5PfKGewUC/+YxAwHNrhEcigIzTSMR+1nCZPcoiCCIUGrHqlI6+gI/9nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TXFsjj0N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B167AC4CEE2;
	Wed,  5 Mar 2025 11:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741174676;
	bh=SfO9DhTgwjDi7AtLeGy/7XGGLiNrKvCDa7E6MONV8Hc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=TXFsjj0NJnDBQQCVzatjjnWAmDIjtompK+wcNNWUUitWHk1uwd9LW9Si+gj1EYdiz
	 k46/gudfC8/I2NTBZk8Pw0ECvdIA+XMq3HMdfFX2hUcVc4AIx48kaHU2/86gp9GAus
	 mtvLM5KZA17LVBbYVfzscH0XsmnJCUy2y9KCOvwJsfibNdIzS4cHp//uVDYmpJMy7/
	 2zWY2keXHfN+8ltp3p4Uad0XbuBWsXFH3oeH+QINt7C9F6JZCLMz8YCUcQfTirG9WS
	 47Xljtrgeyv2TBXYz9ahc38Bbm0xBCsFk08v/zT2GBRyk+R+VSbXXg/QdvoDqpSFj2
	 5RKR5hwr4bCIw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Benno Lossin" <benno.lossin@proton.me>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Alice
 Ryhl" <aliceryhl@google.com>,  "Trevor Gross" <tmgross@umich.edu>,
  "Danilo Krummrich" <dakr@kernel.org>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 11/22] rust: pin-init: fix documentation links
In-Reply-To: <20250304225245.2033120-12-benno.lossin@proton.me> (Benno
	Lossin's message of "Tue, 04 Mar 2025 22:54:41 +0000")
References: <20250304225245.2033120-1-benno.lossin@proton.me>
	<ya83goUtzcHjLy0IcSqvzACQD0E8Vn3F-w29yUE8jareggYjn0MS8ppl7uT1una8iXgpyTMDiG48RlSzZLTr-w==@protonmail.internalid>
	<20250304225245.2033120-12-benno.lossin@proton.me>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 05 Mar 2025 12:37:42 +0100
Message-ID: <87y0xjd7y1.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Benno Lossin" <benno.lossin@proton.me> writes:

> Before switching to compile the `pin-init` crate directly, change
> any links that would be invalid to links that are valid both before and
> after the switch.
>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> ---
>  rust/kernel/sync/condvar.rs     |  2 +-
>  rust/pin-init/src/__internal.rs |  4 ++--
>  rust/pin-init/src/lib.rs        | 19 +++++++++++--------
>  3 files changed, 14 insertions(+), 11 deletions(-)
>
> diff --git a/rust/kernel/sync/condvar.rs b/rust/kernel/sync/condvar.rs
> index 7df565038d7d..5aa7fa7c7002 100644
> --- a/rust/kernel/sync/condvar.rs
> +++ b/rust/kernel/sync/condvar.rs

[...]

> @@ -204,7 +204,8 @@
>  //! [structurally pinned fields]:
>  //!     https://doc.rust-lang.org/std/pin/index.html#pinning-is-structural-for-field
>  //! [stack]: crate::stack_pin_init
> -//! [`Arc<T>`]: crate::sync::Arc
> +//! [`Arc<T>`]: ../kernel/sync/struct.Arc.html
> +//! [`Box<T>`]: ../kernel/alloc/struct.KBox.html
>  //! [`impl PinInit<Foo>`]: PinInit
>  //! [`impl PinInit<T, E>`]: PinInit
>  //! [`impl Init<T, E>`]: Init

Won't this diff from the user space implementation?


Best regards,
Andreas Hindborg



