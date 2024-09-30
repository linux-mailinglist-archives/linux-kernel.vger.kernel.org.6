Return-Path: <linux-kernel+bounces-344321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B524A98A843
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 17:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E75E01C23304
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 15:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A541922DF;
	Mon, 30 Sep 2024 15:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S5DjZKa9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E1A190052;
	Mon, 30 Sep 2024 15:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727709220; cv=none; b=Ag0N35Pfk+C3cZz5A3o1o1mdrtk5Hc80g5ctMeIc5wSwM3YimaIibZ/jKPiDXnwtoDrBVYKaU7ba8cCdyc44iDu+nmYA+mJuPEadnvQDY5rOjZBou3PKJD74VW+9+7CO/WylxHplRwa+K4b9cUpK2a43lMhLItNckVfsF9vNzSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727709220; c=relaxed/simple;
	bh=hUL/J/sUjAaD7bSIXuLWquTa3cBrA2QI7TlPd5l+p2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y81Ut3McxStKpEtGqOUo84BodSD88VVPIPDeayfiXthEHhYw7wtnxTUcyD5w+IzEj5D5HqVhtFu84Vx5MRRj1kngF65RVIHgpTJMS+rsJvOSu51c5snOEaIihHlWCGtEqC3DbOyWCWvT3MlCA17i+rmIlZIOYva73K1K8OzQi9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S5DjZKa9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF23BC4CEC7;
	Mon, 30 Sep 2024 15:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727709219;
	bh=hUL/J/sUjAaD7bSIXuLWquTa3cBrA2QI7TlPd5l+p2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S5DjZKa9QsYsA31FvZuG4C+3ccXslWjxy3kQtLP8dT0eJrzg/1fe3dBORPjr+m42A
	 ZSegMPSK90baMK/CgFnRme59Wd8KL2YbI1xB19jNBEQ3h3Apoi+0nC2VU5qUJbg4Co
	 7K8f97bp1jOs7bi2q1TyvzFUGnF5ulbbhYDwXDB0aRXbzSYOoppHtg271gs2zh7v5v
	 vPBBAJ30Vk4pVQ7Sywt85uRN5l69deSOcQW7g7hBcWU+ESVr//iEFEY2qPNgcAlAIg
	 6Z/6dsE+zP2EOO7BLSe5LyJ78jZCDgzclq9gyuMzNEA9MWCEPeFEx+V8CXWnV0lrSZ
	 QzRbizZ4XhXXA==
Date: Mon, 30 Sep 2024 17:13:34 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	aliceryhl@google.com, mcgrof@kernel.org, russ.weight@linux.dev,
	dakr@redhat.com, a.hindborg@kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] rust: device: rename "Device::from_raw()"
Message-ID: <ZvrAHnN0D7KPlLDc@pollux>
References: <20240930144328.51098-1-trintaeoitogc@gmail.com>
 <20240930144328.51098-2-trintaeoitogc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930144328.51098-2-trintaeoitogc@gmail.com>

On Mon, Sep 30, 2024 at 11:43:27AM -0300, Guilherme Giacomo Simoes wrote:
> This function increments the refcount by a call to
> "bindings::get_device(ptr)". This can be confused because, the function
> Arch::from_raw() from standard library, don't increments the refcount.

`Arc::from_raw`

Again the note, it's both the semantics used in the Rust stdlib and in the
kernel.

Let's wait for what Greg says, if he wants to fix the small typo when
applying the patch.

Acked-by: Danilo Krummrich <dakr@kernel.org>

> Hence, rename "Device::from_raw()" to avoid confusion with other
> "from_raw" semantics.
> 
> Signed-off-by: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
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

