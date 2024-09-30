Return-Path: <linux-kernel+bounces-344102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C41B798A487
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 15:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A34B1F24E8B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 13:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA8118FC67;
	Mon, 30 Sep 2024 13:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T2L+WaLC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4315218E755;
	Mon, 30 Sep 2024 13:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727702025; cv=none; b=CMOHmMYVk1jxhikbqiXHCtUE/6C3gbLqYsz0L9nLV39DdFFwU9WXNQ25P7f4wU2K+0zLPzd62swMxmH2mNAF7XlxIYo18+/crCmctctKmDkJtPiFAnMcvKRYgF4Jxz3THVY72BoA0B0qxBfpHtCWyNDlli3/Bbyg/485cISyLqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727702025; c=relaxed/simple;
	bh=wnhQmf6b9KijXUnLutsEx25F8v79k5sda79kxBSTxRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sM3zF+SmZTt2AQbUJ43QpYWfXneUg6kExTro/EjYrcGd80W/e3dzBB84tKDhEPu50K5Hb7GlYNVdkNZAENU4N/R3xIC9Hykfhbi1Z4TCsM2qzIcNt7HzEhTjomBT1qll9vycmpAQJjCVXZiRSya7OCVLkz7nyGb64LP4J5hHNUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T2L+WaLC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84702C4AF0B;
	Mon, 30 Sep 2024 13:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727702024;
	bh=wnhQmf6b9KijXUnLutsEx25F8v79k5sda79kxBSTxRM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T2L+WaLCsNVCz/b++Y8phnIC2k/qXkmpvwPct75K3z1xzrVGGVzEVFHZrPL7PyL+G
	 7Gatkyt/YGePfTDYw1AkPJ9B5NSoNqUDgLMEInjUyrq7S9u5q1u5mM+R8ppDhqDo2P
	 DHCe5FB+dDcnHyxFBkH20jsrU72gAVMsCuG21+iNH1baSGqH1jfcA9C6FrI85qrDOQ
	 N+1XSiPP0uZflhJ3Tq1/EC9uBmqqyzx8m+G80vE1MfrC2EybCb5yW9LPf9CAPd8A4Y
	 MMFfA7X9yokP4xK4W4tO72T0nHH/1wh0pGWkYtde1aT9xj6vdAxuyJ57UVRWy1M2Sc
	 MyzTJJ5xlfnEA==
Date: Mon, 30 Sep 2024 15:13:38 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	aliceryhl@google.com, mcgrof@kernel.org, russ.weight@linux.dev,
	dakr@redhat.com, a.hindborg@kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] device: rust: change the name function
Message-ID: <ZvqkAuxWZIMZshN_@pollux>
References: <20240930123957.49181-1-trintaeoitogc@gmail.com>
 <20240930123957.49181-2-trintaeoitogc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930123957.49181-2-trintaeoitogc@gmail.com>

On Mon, Sep 30, 2024 at 09:39:56AM -0300, Guilherme Giacomo Simoes wrote:
> This function increment the refcount by this command "bindings::get_device(prt)".

'increments', 'bindings::get_device(ptr)'

I'd also say 'by a call to' instead of 'by this command'.

> This can be confuse becuase, the function Arc::from_raw() from standard library, don't increment the refcount.

Neither the stdlib one, nor the kernel one.

> Then, this function "Device::from_raw()" will be renamed for don't make confusing in the future.

Prefer the imperative, e.g. "Hence, rename `Device::from_raw` to avoid
confusion with other `from_raw` semantics."

> 
> Signed-off-by: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>

Please make sure to run ./scripts/checkpatch.pl before submitting patches.

I see the following two warnings:

WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#6:
This function increment the refcount by this command "bindings::get_device(prt)".

WARNING: 'becuase' may be misspelled - perhaps 'because'?
#7:
This can be confuse becuase, the function Arc::from_raw() from standard library, don't increment the refcount.

Please also use a more descriptive commit summary, e.g.
"rust: device: rename `Device::from_raw`".

> ---
>  rust/kernel/device.rs   | 2 +-
>  rust/kernel/firmware.rs | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> index 851018eef885..ecffaff041e0 100644
> --- a/rust/kernel/device.rs
> +++ b/rust/kernel/device.rs
> @@ -51,7 +51,7 @@ impl Device {
>      ///
>      /// It must also be ensured that `bindings::device::release` can be called from any thread.
>      /// While not officially documented, this should be the case for any `struct device`.
> -    pub unsafe fn from_raw(ptr: *mut bindings::device) -> ARef<Self> {
> +    pub unsafe fn get_device(ptr: *mut bindings::device) -> ARef<Self> {

As a follow-up, it probably makes sense to also change the function body to
just: `unsafe { Self::as_ref(ptr) }.into()`.

>          // SAFETY: By the safety requirements, ptr is valid.
>          // Initially increase the reference count by one to compensate for the final decrement once
>          // this newly created `ARef<Device>` instance is dropped.
> diff --git a/rust/kernel/firmware.rs b/rust/kernel/firmware.rs
> index dee5b4b18aec..13a374a5cdb7 100644
> --- a/rust/kernel/firmware.rs
> +++ b/rust/kernel/firmware.rs
> @@ -44,7 +44,7 @@ fn request_nowarn() -> Self {
>  ///
>  /// # fn no_run() -> Result<(), Error> {
>  /// # // SAFETY: *NOT* safe, just for the example to get an `ARef<Device>` instance
> -/// # let dev = unsafe { Device::from_raw(core::ptr::null_mut()) };
> +/// # let dev = unsafe { Device::get_device(core::ptr::null_mut()) };
>  ///
>  /// let fw = Firmware::request(c_str!("path/to/firmware.bin"), &dev)?;
>  /// let blob = fw.data();
> -- 
> 2.46.2
> 

