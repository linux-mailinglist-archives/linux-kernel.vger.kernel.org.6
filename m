Return-Path: <linux-kernel+bounces-547883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F7AA50EA6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 23:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96F4E3AB49D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 22:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58937205E2E;
	Wed,  5 Mar 2025 22:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSpYkrHH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43FF2063C3;
	Wed,  5 Mar 2025 22:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741213867; cv=none; b=E1KMzLmbYaHikqs+SBwU9Zsqfj+JJD3UgdoCpc/n7ZXI5C3ak5A6E4RuluIkeJuOctmRR8w0lFHXzv38T5CsNcakKTvQDg6nuxDdUwFxJbECaB7D07GKspv0f7s3UOGTxjcnRBUR119vbNt+MFmlV0Y10kz3IWqodukyr61e2Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741213867; c=relaxed/simple;
	bh=0y4rag77MhBPPG5egWFqmgEkirX8At2HrfL9mK2pLU4=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=azS+EEyl6ZgrONkCfN/sTn5cNWQFGIAD6yHJiqa5U2FdEzGhJRo3HqArbgv+/OlBCia7TjSK9PemuapOlEFh2Yl8VY0OVa6R6zwOOQPDjh+yyDnyIwEgzJfFQ2tNQi8JZxzL9AQYYMpYjmZO/rpBROIP9NBFisFwfnQEatl7WBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lSpYkrHH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2AE2C4CED1;
	Wed,  5 Mar 2025 22:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741213865;
	bh=0y4rag77MhBPPG5egWFqmgEkirX8At2HrfL9mK2pLU4=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=lSpYkrHH67Ptj9ZkpMCk5BupP/OUMptrSubo2jtC0mYAi5t0UNd2BPv0CDolwoiQN
	 su9/Cp5xuY67Z9SKhe95XTZDbQUuhB3jh+A9+NMnuf+hQdDWZBJ0kbLdhAOiJ/twjj
	 EcBlyerbkMh27ZvARjXkXjMU3wg2svnkBdsd3rwxEGq6ujcw1JVdetUIsHwyJuE4fc
	 J6rGquKd6JHFrxR2mq2qI1ju+tu+Dh3zo2XB1o1fyMVwbeMkbjaE/dJiYYxBcLbaBf
	 Ao9SdkfrPRsnZXqcKG9jvGPIkAjJuDDB8Odu9EIjwtQxY72NFeHN5zjvO51xsfACm1
	 y600M2sXvwTyw==
Message-ID: <2c17361891c4eb7edd947e5384cc9741.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250305114659.k5pptszvmusblynm@vireshk-i7>
References: <cover.1740995194.git.viresh.kumar@linaro.org> <023e3061cc164087b9079a9f6cb7e9fbf286794e.1740995194.git.viresh.kumar@linaro.org> <CANiq72kdWzFOZ39EoFNxEAbk4KYgzLi1OAEc1zn8BM07VpXy3g@mail.gmail.com> <20250304085351.inrvjgixvxla4yn3@vireshk-i7> <CANiq72=sU1sHvamC5REFPEC1aOVdZw9EKdxOgkUYESTR2yh3iQ@mail.gmail.com> <20250305114659.k5pptszvmusblynm@vireshk-i7>
Subject: Re: [PATCH V3 2/2] rust: Add initial clk abstractions
From: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Russell King <linux@armlinux.org.uk>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Daniel Almeida <daniel.almeida@collabora.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 05 Mar 2025 14:31:02 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Viresh Kumar (2025-03-05 03:46:59)
> On 04-03-25, 10:37, Miguel Ojeda wrote:
> > On Tue, Mar 4, 2025 at 9:53=E2=80=AFAM Viresh Kumar <viresh.kumar@linar=
o.org> wrote:
> > > +///     clk.disable_unprepare();
> >=20
> > Looking at the example, a question that one may have is: should we
> > have something like a scope guard or a closure-passing API for this,
> > or does it not make sense in general?
>=20
> Something like this (untested) ?
>=20
> +/// Runs a cleanup function/closure when dropped.
> +///
> +/// The [`ClkGuard::dismiss`] function prevents the cleanup function fro=
m running.
> +///
> +pub type ClkGuard<'a> =3D ScopeGuard<&'a Clk, fn(&Clk)>;
> +
>  /// A reference-counted clock.
>  ///
>  /// This represents the Rust abstraction for the C [`struct clk`].
> @@ -139,10 +146,12 @@ pub fn as_raw(&self) -> *mut bindings::clk {
>      ///
>      /// [`clk_enable`]: https://docs.kernel.org/core-api/kernel-api.html=
#c.clk_enable
>      #[inline]
> -    pub fn enable(&self) -> Result {
> +    pub fn enable(&self) -> Result<ClkGuard<'_>> {
>          // SAFETY: By the type invariants, it is safe to call clk APIs o=
f the C code for a clock
>          // pointer earlier returned by [`clk_get`].
> -        to_result(unsafe { bindings::clk_enable(self.as_raw()) })
> +        to_result(unsafe { bindings::clk_enable(self.as_raw()) })?;
> +
> +        Ok(ClkGuard::new_with_data(self, Clk::disable))

Does this mean that a clk consumer has to keep the Result returned from
enable() in scope until they want to disable the clk? I don't see how
that makes sense, because most of the time a consumer will enable a clk
during probe and leave it enabled until system suspend or runtime PM
suspend time. At that point, they would disable the clk explicitly with
disable(), but now they would need to drop a reference to do that?

