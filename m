Return-Path: <linux-kernel+bounces-344505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CB198AA7F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 19:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6705287C87
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 17:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3641953AB;
	Mon, 30 Sep 2024 17:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQFxr4md"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA49193070;
	Mon, 30 Sep 2024 17:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727715774; cv=none; b=dQddNgnmrTG0Kz3L1BG7K1TrhtRi/3DGrDNfIRlWtrOhqqKsYRnkT27cGZx4VCOw/4fsv2DpOAEuYDNlZSurMh4wHLssT+x71A4mm5w3O1SWr2j9xzV82GvWoIQpdWxTjnbzWVAJdTBpihUaKeBv5H/xrRdCDVmm90KS760Kl4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727715774; c=relaxed/simple;
	bh=5kWtAOosC6jFsT+N/2cVG76tIgdEXfNyyFg9yeuEykE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gXwf+4PELPf5mQ49y5aMLdxIRQNbik0QZop5JSiWYinsEIqLFQgAMXcFUdHeYANxmLtghX8pr9SGSHKb1hp7e2t2vIonSYRe5u6aaMDn3HZM9qRp9BiOGDozjKpwjm6t9wa2eRwlxOWstz6+Y6k3v5v0bZIfIwjEk5a8oEHP9Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQFxr4md; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3796C4CEC7;
	Mon, 30 Sep 2024 17:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727715774;
	bh=5kWtAOosC6jFsT+N/2cVG76tIgdEXfNyyFg9yeuEykE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DQFxr4mdRrR/FOq2Leyt2ZpsZaLmxslczA0b2PPsSD7qxFkLEMxpOw7zDkjTOMPQ6
	 J1Ezhe66ehzmtY8G7k6A13NlbK5f+S2tiOm/4Zgu6aWQ5vNRgd/zttFgd8KMTvWru1
	 cSY8c4tvSPTwaGcIiJlQHi9CqTl1tcEhkU+2z1GNj5dIR3EjARCX10MRCP9choJSDn
	 dRHq2KEyzd1VM3iFcE8kK7noT9WijNSKWiYUETTLv3tOxoXhLO4Zn0wXhFsT2lsSMb
	 22RBFQBgSV5Ge1UPkYsV6IKjtjxvy27XgBX9thD2H4Vsfy0cuvCjTzjsVcWanKBqfL
	 ReNpA9I5LV6kg==
Date: Mon, 30 Sep 2024 19:02:48 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Guilherme =?iso-8859-1?Q?Gi=E1como_Sim=F5es?= <trintaeoitogc@gmail.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	aliceryhl@google.com, mcgrof@kernel.org, russ.weight@linux.dev,
	dakr@redhat.com, a.hindborg@kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] device: rust: change the name function
Message-ID: <ZvrZuLrPy_5fAbC7@pollux>
References: <20240930123957.49181-1-trintaeoitogc@gmail.com>
 <20240930123957.49181-2-trintaeoitogc@gmail.com>
 <ZvqkAuxWZIMZshN_@pollux>
 <CAM_RzfYXWJ1ePZk7-DFR4P--F1pyzWg8bnC40mbLWaHpx_aNJA@mail.gmail.com>
 <Zvq9OqEu0yN1Ahgq@pollux>
 <CAM_RzfZhMey0u75+M1-hcek6QutS6H9kctpChQ+6g3juSJy5Tg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM_RzfZhMey0u75+M1-hcek6QutS6H9kctpChQ+6g3juSJy5Tg@mail.gmail.com>

On Mon, Sep 30, 2024 at 01:53:20PM -0300, Guilherme Giácomo Simões wrote:
> Danilo Krummrich <dakr@kernel.org> wrote:
> >
> > On Mon, Sep 30, 2024 at 10:52:27AM -0300, Guilherme Giácomo Simões wrote:
> > > Danilo Krummrich <dakr@kernel.org> writes:
> > > > > diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> > > > > index 851018eef885..ecffaff041e0 100644
> > > > > --- a/rust/kernel/device.rs
> > > > > +++ b/rust/kernel/device.rs
> > > > > @@ -51,7 +51,7 @@ impl Device {
> > > > >      ///
> > > > >      /// It must also be ensured that `bindings::device::release` can be called from any thread.
> > > > >      /// While not officially documented, this should be the case for any `struct device`.
> > > > > -    pub unsafe fn from_raw(ptr: *mut bindings::device) -> ARef<Self> {
> > > > > +    pub unsafe fn get_device(ptr: *mut bindings::device) -> ARef<Self> {
> > > >
> > > > As a follow-up, it probably makes sense to also change the function body to
> > > > just: `unsafe { Self::as_ref(ptr) }.into()`.
> > >
> > > But if we change the function body that is suggested for you, the
> > > function will not have your own refcount. If I don't wrong, the
> > > Device::as_ref() expects the caller to have its own reference counter.
> > > And if we change the behavior of function, your name don't need to be
> > > changed, because your behavior will be equal the from_raw() from
> > > standard library.
> >
> > I think you missed the `into()` above. This will convert `&'a Device` into
> > `ARef<Device>`, and also call `inc_ref` from the `AlwaysRefCounted` trait
> > implemented for `Device`, and hence increase the reference count.
> 
> Okay, I understand now that the .into() call, also call `inc_ref` that I
> was don't have knowing. This body change of the get_device() really make
> sense, and I will send a v4 patch.

No need to send a v4, please just send a separate patch for this.

> 
> Thanks for this Mr. Krummrich.

Danilo is just fine, we call people by their first name.

> 

