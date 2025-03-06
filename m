Return-Path: <linux-kernel+bounces-549861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC28DA557F1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1B4B188B107
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 20:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61751205AD0;
	Thu,  6 Mar 2025 20:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sF5vDClO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96F61448E3;
	Thu,  6 Mar 2025 20:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741294741; cv=none; b=YSMN31b1n4+FYprEzHARHN12SI+ffYke8EwSt5ss92jQCQbOD2eL3bhBBI6fvGGhw0VFJnXpWC8bIj2kiJ9YXZzMClBd5qgdHBGlUGOnUWY6gDTVkHaMOiTF6D4ic7Oswz2Jz2E8K62hryrf7WE4TgKYs1C3K8nF3zLltrgUdRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741294741; c=relaxed/simple;
	bh=f1QK2mLhu61dQP77Dh10tRCOAe/KkFRULj8FshlI91s=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=Eh6Ozu6FPPs1MWJAXyRIFSH0oejKh6eBPFx2Q4VYbeqiffqBl9FfTFdvTfe0Q1rP084YlX6N7fU7SVcllH/mw1hqhyQe8FLOp824q+HsA/uFJBd4yNyVuEioPVleyIXNkmdEYJ53ZkHb8e0QuaZL1FRIJNNw2HXiFRG+s/JNcHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sF5vDClO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C21BC4CEE5;
	Thu,  6 Mar 2025 20:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741294741;
	bh=f1QK2mLhu61dQP77Dh10tRCOAe/KkFRULj8FshlI91s=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=sF5vDClOlHisT0FCugbO0msJQooMzyuy/mLdvggcnfNY3SxbG3wuEYvlni0LJZeUH
	 z70B4uipJCF5WuBi25mzlBVAyfGVv06UMcHGpPjQp7I5Ck3i39ApT/tt83/0vSLGsj
	 CxzidIvlyDEDTxmxM3s2PvcOBnU9N0DYRjhfe8oj2TaSX0W/qNiJk96jM2sLT0ppjn
	 C18j4P73gHZikR/xhCeuUfzO+rZ5V+5bJ4dDCm/p1t2HiKGazcVtmRL2dNn25HhiGq
	 /pcm0zgfMW2K6zA5npqIl7sA0w4yRU1e4gWSgeDn9X3vqHsCBYfwtTd4ruCO9WCA2+
	 EtiWhP9oIvh1g==
Message-ID: <1ad3e7e2f8f2fc375b472d7676e47f5d.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250306044028.5d2w4og2juclktqs@vireshk-i7>
References: <cover.1740995194.git.viresh.kumar@linaro.org> <023e3061cc164087b9079a9f6cb7e9fbf286794e.1740995194.git.viresh.kumar@linaro.org> <CANiq72kdWzFOZ39EoFNxEAbk4KYgzLi1OAEc1zn8BM07VpXy3g@mail.gmail.com> <20250304085351.inrvjgixvxla4yn3@vireshk-i7> <CANiq72=sU1sHvamC5REFPEC1aOVdZw9EKdxOgkUYESTR2yh3iQ@mail.gmail.com> <20250305114659.k5pptszvmusblynm@vireshk-i7> <2c17361891c4eb7edd947e5384cc9741.sboyd@kernel.org> <20250306044028.5d2w4og2juclktqs@vireshk-i7>
Subject: Re: [PATCH V3 2/2] rust: Add initial clk abstractions
From: Stephen Boyd <sboyd@kernel.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Russell King <linux@armlinux.org.uk>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Daniel Almeida <daniel.almeida@collabora.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Date: Thu, 06 Mar 2025 12:58:58 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Viresh Kumar (2025-03-05 20:40:28)
> On 05-03-25, 14:31, Stephen Boyd wrote:
> > Does this mean that a clk consumer has to keep the Result returned from
> > enable() in scope until they want to disable the clk?
>=20
> Yes and no.
>=20
> > I don't see how
> > that makes sense, because most of the time a consumer will enable a clk
> > during probe and leave it enabled until system suspend or runtime PM
> > suspend time. At that point, they would disable the clk explicitly with
> > disable(), but now they would need to drop a reference to do that?
>=20
> Broadly there are two type of clk users I believe:
>=20
> 1. clk is enabled / disabled from same routine:
>=20
>    In this case the result can be kept in a local variable and the matchi=
ng
>    cleanup fn will be called at exit.

This is almost never the case. Listing these as two types of clk users
tries to make the two equal, when the vast majority of users are the
second. Please don't.

>=20
>    fn transfer_data(...) -> Result {
>         let _guard =3D clk.enable()?;
>=20
>         ...
>         transfer-data here
>         ...
>         // clk.disable() will be called automatically as soon as _guard g=
oes out
>         // of scope.
>    }
>=20
> 2. clk is enabled / disabled from different routines:
>=20
>    In this case the caller needs to call dismiss to avoid the automatic f=
reeing
>    of resource. Alternatively the returned value can be stored too somewh=
ere,
>    but I am not sure if it what users will end up doing.
>=20
>    fn probe(...) -> Result {
>         clk.enable()?.dismiss();

Yuck. Can't we tie the lifetime of the clk to the consumer device driver
so that when the driver is unbound the clk is dropped and it decrements
all the enables/prepares and puts the clk with clk_put()? A ScopeGuard
could probably be used for that on the struct Clk itself, but we would
want to track the enables and prepares in the rust wrapper code until
the struct clk can be inspected directly.

The problem is we don't know how a platform may implement the clk API,
and CCF hasn't taken over the entire kernel yet so we can't rely on some
private API between the CCF and the rust wrapper to know how many
clk_disable()s to call, or even rely on clk_put() to do the work for us.
Can the rust wrappers depend on CONFIG_COMMON_CLK? If they did then we
could have some private API between rust and CCF. We probably don't want
rust code to _not_ use COMMON_CLK underneath so we can encourage the
last few holdouts to migrate to CCF. I'd lean towards depending on
COMMON_CLK for the rust wrappers in this case.

