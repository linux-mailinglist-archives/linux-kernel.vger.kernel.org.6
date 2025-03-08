Return-Path: <linux-kernel+bounces-552252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98829A57795
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 03:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34B281897D6F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 02:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C25D14831E;
	Sat,  8 Mar 2025 02:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="bbOw0k9R"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24531EEE6;
	Sat,  8 Mar 2025 02:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741399443; cv=pass; b=u7emeP+OgUT7J+qKf6ApVGeKKCQX52IyMY/Q3vNPSZzTtaseEqzRe3ojlXOvl7yKZGgV9gpGwvBR9JZgAr7FXtM6Rwi3n4f1prBpHUV/rqYWQ1HJwUnWY609qJYTYRsg4EL+mCZbQoLOKD32pZr4O1M2u6zOKQYRMz/t0/YeKOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741399443; c=relaxed/simple;
	bh=fzqf8d40kMRV0B/31d4SpvqNTOm3LnawNTjCZEW2sLU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=W0JfCCdz/INlDW6nDDPCFPHXGdwgt0XJKa/KNqzO26OBhyY5MW/Isc5Qtn+3Xj2o6HQRsigxLjyrFOVd+8mNPjxZpkm6zu7RK4UILwY6mmNiq/H8jhYtvWR2B00j+sAI2MbbX36oRbq1Y1sgseKZcT6EerSP+6WwaIVtcFDA+44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=bbOw0k9R; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1741399413; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=giiBA+A+LzQ4rixA9S/EDVikE44XlsdZtBZETAkxthSRSaqTa8veggBhjaEumNaNhqVSumFIYu9krh9v0yelcOLDliFXWanjOUpsLkj02ppCrQQLN7qGB1X9DsBPEGdQRhdOGMbZaAPFpOKneCz6yfiLCpN2eU9PXjVe41TW2Bo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1741399413; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=U5tvOevFekjKfogKK5n5IOeLUWZYMhAuBRM0LtrpGac=; 
	b=ikDTmD2jYCohWzz7++a81be47ZYr0U+3Z/QlfWIw56F7/7JjVIy3p2SJDRGai+S/oVNrVgXrlSX9GCY/PeI400AdWjLSm6VCVgXVsLOUf3ZaIL56+d2U1CBIyTjIdSORcioYhAlJ+8phPXFM/ssaBWGsetXQYVK6hz1gCdW2TkU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1741399413;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=U5tvOevFekjKfogKK5n5IOeLUWZYMhAuBRM0LtrpGac=;
	b=bbOw0k9RLgAZYFzlJYOqf0M3lDnvpHCUPNYKYs2kXme6TAPJ1lrWz+XH4/4iIqgv
	O1IrlLlOH23rKttiTj9fLlgLMs9PsOiXAZ9UFnaJ0YJbAAvYvUWalfZzsM0i2mOC0RI
	h99D8cxjkT7lcverGcVT0SMhojJakI0V20f+LEDY=
Received: by mx.zohomail.com with SMTPS id 1741399412188433.2847528501791;
	Fri, 7 Mar 2025 18:03:32 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH V3 2/2] rust: Add initial clk abstractions
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250304085351.inrvjgixvxla4yn3@vireshk-i7>
Date: Fri, 7 Mar 2025 23:03:15 -0300
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Russell King <linux@armlinux.org.uk>,
 linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 Vincent Guittot <vincent.guittot@linaro.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <DC3B4FA6-5938-49CE-A75C-D354562593B3@collabora.com>
References: <cover.1740995194.git.viresh.kumar@linaro.org>
 <023e3061cc164087b9079a9f6cb7e9fbf286794e.1740995194.git.viresh.kumar@linaro.org>
 <CANiq72kdWzFOZ39EoFNxEAbk4KYgzLi1OAEc1zn8BM07VpXy3g@mail.gmail.com>
 <20250304085351.inrvjgixvxla4yn3@vireshk-i7>
To: Viresh Kumar <viresh.kumar@linaro.org>
X-Mailer: Apple Mail (2.3826.400.131.1.6)
X-ZohoMailClient: External

Hi Viresh,

> On 4 Mar 2025, at 05:53, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>=20
> On 03-03-25, 11:16, Miguel Ojeda wrote:
>> On Mon, Mar 3, 2025 at 11:00=E2=80=AFAM Viresh Kumar =
<viresh.kumar@linaro.org> wrote:
>>>=20
>>> +/// Frequency unit.
>>> +pub type Hertz =3D crate::ffi::c_ulong;
>>=20
>> Do we want this to be an alias or would it make sense to take the
>> chance to make this a newtype?
>=20
> I have tried some improvements based on your (and Alice's comments), =
please see
> if it looks any better now.
>=20
> --=20
> viresh
>=20
> -------------------------8<-------------------------
>=20
> diff --git a/rust/kernel/clk.rs b/rust/kernel/clk.rs
> new file mode 100644
> index 000000000000..fc3cb0f5f332
> --- /dev/null
> +++ b/rust/kernel/clk.rs
> @@ -0,0 +1,232 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Clock abstractions.
> +//!
> +//! C header: [`include/linux/clk.h`](srctree/include/linux/clk.h)
> +//!
> +//! Reference: <https://docs.kernel.org/driver-api/clk.html>
> +
> +use crate::{
> +    bindings,
> +    device::Device,
> +    error::{from_err_ptr, to_result, Result},
> +    ffi::c_ulong,
> +    prelude::*,
> +};
> +
> +use core::{ops::Deref, ptr};
> +
> +/// Frequency unit.
> +#[derive(Copy, Clone, PartialEq, Eq, Debug)]
> +pub struct Hertz(c_ulong);

Maybe make self.0 pub too?

> +
> +impl Hertz {
> +    /// Creates a new `Hertz` value.
> +    pub fn new(freq: c_ulong) -> Self {
> +        Hertz(freq)

I don=E2=80=99t think we need a `new` function.  IMHO, the only thing =
that matters is
that the name Hertz shows up in the calling code, i.e.:

```
fn foo() {
    let clk =3D =E2=80=A6;
    let some_val =3D =E2=80=A6;
    clk.set_rate(Hertz(some_val)); // Ok: crystal clear this is Hertz
}
```

A  impl From<Hertz> for c_ulong would also be helpful, so that we =
don=E2=80=99t have to
manually define all the arithmetic operations on this.

```
fn foo() {
    let clk =3D =E2=80=A6;
    let double =3D u32::from(clk.rate()) * 2;
    clk.set_rate(Hertz(double)); // Ok: crystal clear this is Hertz
}
```

I need more time to look at the rest of the patch, so feel free to carry =
on with the
feedback from others. Sorry for the delay!

=E2=80=94 Daniel=

