Return-Path: <linux-kernel+bounces-344305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A483D98A810
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 17:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CBE11F214FF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 15:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DE41922D5;
	Mon, 30 Sep 2024 15:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e46dFKHf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED784191473;
	Mon, 30 Sep 2024 15:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727708481; cv=none; b=ZBXEPRkjZ/v83/bbZDan8+Qs8dK1LYi4LHhTWr3LCas74VFD0DTM/qA/CDmC9BHRHHnLmset+fFJ2zPz01ToeJgAgTjATeYgt0CYwTpWdFmyncKjKroLYwuJwczay1OvWqnoT4xDF2ZgBpAX50FUXZRjdJ0f6RYX5jOOidAZr3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727708481; c=relaxed/simple;
	bh=7u3rXBL5wKMAnZxv41R56LBzZrdAt8JKmrS+unGkl7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NrSLmS+ScTfvOAguRxTodRAeBu5/SlSyRgGdunjUHgDB9Gmmw5SCwzJJSMEUGLcEyaPN/BxirhSY/hZ/VDmbGTMFVdKZG9PbeK5DrA4TT43BcxysDiGuliRb88SNLPAvuhr0dnKGurr9mTGJgznhz3bWABcesrj2VpEaXQAbmEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e46dFKHf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E4AAC4CEC7;
	Mon, 30 Sep 2024 15:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727708480;
	bh=7u3rXBL5wKMAnZxv41R56LBzZrdAt8JKmrS+unGkl7Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e46dFKHfn4jf+zkL8DZMfETZKLzOCZhJkmpCD5NZc/BJQ61F/nuG9M1jzijQIU+BP
	 mcHSVrcAueqWpfkz3hm3jyscaHOS/z7Aid/XdhCmGo8zgecTQB/xYaeALf8XOJIACj
	 PW+n44/DokrmJYg9olDW5DIeIiqLs5oW8WoNvLGlGhiFBMGcS+hQkMaQuPjZlLybfI
	 VlCgbYiJCPkJIigoc3NhG7356ozemLCgFqZhtzISudEuNpV7XGKyGODLMj2EyfueRl
	 3t1hTAN+1t0suh2ApY7j6oPcFZ2MpJJip1jzUursEeS5alGJXNPVva5JvnyoEZa0My
	 lTHMTQPNj7Ofg==
Date: Mon, 30 Sep 2024 17:01:14 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Guilherme =?iso-8859-1?Q?Gi=E1como_Sim=F5es?= <trintaeoitogc@gmail.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	aliceryhl@google.com, mcgrof@kernel.org, russ.weight@linux.dev,
	dakr@redhat.com, a.hindborg@kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] device: rust: change the name function
Message-ID: <Zvq9OqEu0yN1Ahgq@pollux>
References: <20240930123957.49181-1-trintaeoitogc@gmail.com>
 <20240930123957.49181-2-trintaeoitogc@gmail.com>
 <ZvqkAuxWZIMZshN_@pollux>
 <CAM_RzfYXWJ1ePZk7-DFR4P--F1pyzWg8bnC40mbLWaHpx_aNJA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM_RzfYXWJ1ePZk7-DFR4P--F1pyzWg8bnC40mbLWaHpx_aNJA@mail.gmail.com>

On Mon, Sep 30, 2024 at 10:52:27AM -0300, Guilherme Giácomo Simões wrote:
> Danilo Krummrich <dakr@kernel.org> writes:
> > > diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> > > index 851018eef885..ecffaff041e0 100644
> > > --- a/rust/kernel/device.rs
> > > +++ b/rust/kernel/device.rs
> > > @@ -51,7 +51,7 @@ impl Device {
> > >      ///
> > >      /// It must also be ensured that `bindings::device::release` can be called from any thread.
> > >      /// While not officially documented, this should be the case for any `struct device`.
> > > -    pub unsafe fn from_raw(ptr: *mut bindings::device) -> ARef<Self> {
> > > +    pub unsafe fn get_device(ptr: *mut bindings::device) -> ARef<Self> {
> >
> > As a follow-up, it probably makes sense to also change the function body to
> > just: `unsafe { Self::as_ref(ptr) }.into()`.
> 
> But if we change the function body that is suggested for you, the
> function will not have your own refcount. If I don't wrong, the
> Device::as_ref() expects the caller to have its own reference counter.
> And if we change the behavior of function, your name don't need to be
> changed, because your behavior will be equal the from_raw() from
> standard library.

I think you missed the `into()` above. This will convert `&'a Device` into
`ARef<Device>`, and also call `inc_ref` from the `AlwaysRefCounted` trait
implemented for `Device`, and hence increase the reference count.

