Return-Path: <linux-kernel+bounces-347633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F0B98D865
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 15:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97DA11F21394
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 13:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7537D1D0BBB;
	Wed,  2 Oct 2024 13:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="psncEfsd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24CA1E52C;
	Wed,  2 Oct 2024 13:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727877516; cv=none; b=XxXuS6lmZocpgoM/9uQl/Yoluc5uX4h6JOWfdIBtlj7bM3dehYKySxV1PhrJAgFuhdbdnsY+DgXsmZH430Lo/7l++wdAIxtL8hG3z3Hr4z1La6BRV6gnezRlEjaDzJ7913o0bSo/cBb2XMAF0FXyAgXqpa13ygmdZlOjLmpJfWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727877516; c=relaxed/simple;
	bh=/UXfQLbEpKjaSF6OXS1imF5v7Ha5rnonCoD0u2Kgl6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQ9HrDTl8DP4uJVcPoCGfjSdVaFZvgA3TGpsM6b+P9jGIuRSl7LNzrZXNuI/3cJs3mTvaqfBZyqKPxu2U6SzCb1qG84mjh4E3/FRV/04ebQ5SzJFeY2Sbjg0+4TJl9Nd4bNaDRHrvkGwlk9234yKKUQXc4bX+wLi5YHJE2OBXOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=psncEfsd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58D4EC4CEC2;
	Wed,  2 Oct 2024 13:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727877516;
	bh=/UXfQLbEpKjaSF6OXS1imF5v7Ha5rnonCoD0u2Kgl6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=psncEfsdP2bKWXOPokOvAFp48D4oK+45oNqooMAw3+cdUNscGoNuR+Dpka1ZIECPK
	 mdcUUAMkKEyHCBdDrMfh+Gy3Bluk8qIk7Jf8SQV6wVBORRg/FOq4FOk4nSieOH81Th
	 ZtrNnvOYgyzGN02TD/zR4tnH76QXTxbR+YslKQBzfyT+Zf8PZWJUtDFyyUFKJ+3RPV
	 XXGYkZ1sMOgP6boBj4Iq21QkK92qU2CXcgT896UOWCnKbL1LlsCmITjQH3Duv67vBT
	 mWYh+59vmhahjFVSNCs2U2boOuYlSA4nVyvQOaAdGLYatWYDt1fSjv7zjvAVGGT3Zu
	 JpGWkzpbNs6pw==
Date: Wed, 2 Oct 2024 15:58:29 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	aliceryhl@google.com, mcgrof@kernel.org, russ.weight@linux.dev,
	dakr@redhat.com, a.hindborg@kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] rust: device: change the from_raw() function
Message-ID: <Zv1RhZpQGkVBlLCU@pollux>
References: <20241001205603.106278-1-trintaeoitogc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001205603.106278-1-trintaeoitogc@gmail.com>

On Tue, Oct 01, 2024 at 05:56:03PM -0300, Guilherme Giacomo Simoes wrote:
> The function Device::from_raw() increments a refcount by a call to
> bindings::get_device(ptr). This can be confused because usually
> from_raw() functions don't increment a refcount.
> Hence, rename Device::from_raw() to avoid confuion with other "from_raw"
> semantics.
> 
> The new name of function should be "get_device" to be consistent with
> the function get_device() already exist in .c files.
> 
> This function body also changed, because the `into()` will convert the
> `&'a Device` into `ARef<Device>` and also call `inc_ref` from the
> `AlwaysRefCounted` trait implemented for Device.
> 
> Signed-off-by: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>

Acked-by: Danilo Krummrich <dakr@kernel.org>

> ---
> differences from v1 to v2:
>  - remove the 0/1 patch
>  - refactor get_device() function
> 
> differences from v2:
> - fix the place of changelog.
> 
> The motivation from this change was will discussion in:
> https://rust-for-linux.zulipchat.com/#narrow/stream/291566-Library/topic/Inconsistency.20of.20.60from_raw.60.2E
> 
> I would like to thanks for Greg <gregkh@linuxfoundation.org>, Danilo
> <dakr@kernel.org> and Alice <aliceryhl@google.com> for help me with this
> patch.
> ---
>  rust/kernel/device.rs   | 15 +++------------
>  rust/kernel/firmware.rs |  2 +-
>  2 files changed, 4 insertions(+), 13 deletions(-)
> 
> diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> index 851018eef885..c8199ee079ef 100644
> --- a/rust/kernel/device.rs
> +++ b/rust/kernel/device.rs
> @@ -51,18 +51,9 @@ impl Device {
>      ///
>      /// It must also be ensured that `bindings::device::release` can be called from any thread.
>      /// While not officially documented, this should be the case for any `struct device`.
> -    pub unsafe fn from_raw(ptr: *mut bindings::device) -> ARef<Self> {
> -        // SAFETY: By the safety requirements, ptr is valid.
> -        // Initially increase the reference count by one to compensate for the final decrement once
> -        // this newly created `ARef<Device>` instance is dropped.
> -        unsafe { bindings::get_device(ptr) };
> -
> -        // CAST: `Self` is a `repr(transparent)` wrapper around `bindings::device`.
> -        let ptr = ptr.cast::<Self>();
> -
> -        // SAFETY: `ptr` is valid by the safety requirements of this function. By the above call to
> -        // `bindings::get_device` we also own a reference to the underlying `struct device`.
> -        unsafe { ARef::from_raw(ptr::NonNull::new_unchecked(ptr)) }
> +    pub unsafe fn get_device(ptr: *mut bindings::device) -> ARef<Self> {
> +        // SAFETY: By the safety requirements ptr is valid
> +        unsafe { Self::as_ref(ptr) }.into()
>      }
>  
>      /// Obtain the raw `struct device *`.
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

