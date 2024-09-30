Return-Path: <linux-kernel+bounces-343897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A562C98A0EB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 13:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E9B81F282CF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 11:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537B318E04D;
	Mon, 30 Sep 2024 11:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="csmT0cyb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A9C18DF75;
	Mon, 30 Sep 2024 11:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727696112; cv=none; b=CXICtfVZnkqfjid2QaNFw5SMCoZRxq1XfJTejdSkyvScMA2+rIpetkjevakdNgm3bxSi5+lmaR28vaI1eHVFCt+45PjQEZQGp50sYs391QnGUWU0TMUWCBqSc6FzqxoaX5X4NN11bmEei881PujNXbFFyd5DLmulc+XUwsglVgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727696112; c=relaxed/simple;
	bh=rIPG4KDeInmmdaR6xuNCMeu7HNr9U7NNoLao5HdKeTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YQYC6JjXscLOP2nR3+y93RDjTo1JqjsowSKAytOQvJkzCBiZmb0o5SyheSk+DhAWQA5kiy8eiYOolJWzDpWv2qpkAzrLCweEO5qmxcZZIVBRJO3mcDGfxg4xwPF5GcsPy9WpkMD36Zo3sL2ugzO2ubBncYEnWibKJJxH0D/wJdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=csmT0cyb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D3EFC4CEC7;
	Mon, 30 Sep 2024 11:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727696112;
	bh=rIPG4KDeInmmdaR6xuNCMeu7HNr9U7NNoLao5HdKeTA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=csmT0cybmjo/2y3jZwoQZklihK9kqNg9MS0Lxqboq6hGu7fQvp3O9Y205tKcLnvEo
	 X6zFjIbThmHvwe18+gtrFU/soYjdMuXK3d8ESyqV8uvI69HD0N+Ot/5wZDPP3Oa4Sc
	 3J9lTaWbBC1tyh8aqbILLctHkgF9m038DIOVnvGU=
Date: Mon, 30 Sep 2024 13:35:09 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Guilherme =?iso-8859-1?Q?Gi=E1como_Sim=F5es?= <trintaeoitogc@gmail.com>
Cc: rafael@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, aliceryhl@google.com, mcgrof@kernel.org,
	russ.weight@linux.dev, dakr@redhat.com, a.hindborg@kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] device: rust: change the name function
Message-ID: <2024093044-emblaze-disrupt-d479@gregkh>
References: <CAM_RzfbQK5fzqXQN89JCEzD1Bz5ZtQdAz3xD0yaYFx_GC7Pm0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM_RzfbQK5fzqXQN89JCEzD1Bz5ZtQdAz3xD0yaYFx_GC7Pm0Q@mail.gmail.com>

On Sun, Sep 29, 2024 at 10:38:47AM -0300, Guilherme Giácomo Simões wrote:
> This function increments the refcount by this command
> "bindings::get_device(prt)"
> This can be confused because the function Arc::from_raw() from
> standard library, doesn't
> increment the refcount.
> Then, this function "Device::from_raw()" will be renamed for don't
> make confusion
> in the future.

Please wrap the lines here properly so they show up in a sane way :)

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
>      /// It must also be ensured that `bindings::device::release` can
> be called from any thread.

Your patch is line-wrapped and can not be applied :(

Please read the email documentation in the kernel for how to use gmail
to send patches out (hint, almost never do so, but you can use git
send-email through it), that will help you in sending changes that can
be applied.

>      /// While not officially documented, this should be the case for
> any `struct device`.
> -    pub unsafe fn from_raw(ptr: *mut bindings::device) -> ARef<Self> {
> +    pub unsafe fn get_device(ptr: *mut bindings::device) -> ARef<Self> {

With this change, nothing broke?  Does nothing call this code yet?  I
thought the firmware interface did that, but I could be wrong...

thanks,

greg k-h

