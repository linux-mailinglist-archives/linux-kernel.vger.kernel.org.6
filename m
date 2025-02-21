Return-Path: <linux-kernel+bounces-525834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70833A3F614
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 14:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50AEE860C9A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 13:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3858920E018;
	Fri, 21 Feb 2025 13:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="e6wbIEJK"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2A420AF84;
	Fri, 21 Feb 2025 13:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740144667; cv=pass; b=bhsWup973q+8SRzM4jxSL8WfLZMR9y0w37SigCTblgyK+NOgJskUoMdVCZIcbCyeMNc16KZ9HHBsbilN42l9jl9JVWsF7HzyqeSSlACSaV9JEHqa5hBvqtOZ7UKrKSoOa3u0kbijTvMhH0sLGA507Bu4kvNERbu2k8gTez4OVto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740144667; c=relaxed/simple;
	bh=nCdpaE1K9+MGr50OMsIMf32WrQ5N1FuRPptvOvgsB+o=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=RMU00wJzzmLBnnK/i+idAt5/PVitXpftIY0ab1NTthYmbbriFlSo+A+hGXI4LipFMfWzEthS5l7yZu4+g0A3s0K9+VHUnzwqWLrk9q6v6rcq9I2iC1sgRVv7gNNQDFU7tDBKq13vNfQwpsErl8g+ZC2EkcaZz61GdbliPIF3Ga8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=e6wbIEJK; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1740144637; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=J18nX6Z3v2yzmaf8/1O4OB5FC0I4OjwerPr4mVmmbwj1NENX4QBO2BJgLg+XNNGidStnvPBeI/yGFNlZqu4A7Bk87TOOE1Na+3IEwaXHQfJ8RAGaQXdRGP2EkA/JJHuiTHg96afaVFuGjdlmtzoPv9Roy4EDRLH7OOqsFSzcgr4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740144637; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=KvYwYtWeaPtW8lwE8gHG4KOI90CKWqXAC4F6smx3L24=; 
	b=dvpd1QsVWdvGTNEXBrn4EQo9bbB5i+rmyqSoPFNVt/yKok4DeRfJaSmSGqpGv3qq52gxS9bSEbWMAQNuyCUeaUBm0VV3OALWrSFfVc7oZdEVSfTF6yQ2T0XrLcOm5wXeYjOdWlXcWaQTL4T3k2wFg8Sh9gi+m/bCU9+jM7L7hBE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740144637;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=KvYwYtWeaPtW8lwE8gHG4KOI90CKWqXAC4F6smx3L24=;
	b=e6wbIEJKeFbU141VW3c0624bBtV1h2g3q4jBhcoOBJX0p0i6sYvp0yyzKMpJ1Tfy
	JFIVpFNovRSRzKU5mZsB5e9I9fImW1GVadTzkHwc5loWbZVYbQtuu8/fVaJPGKbxRx8
	pIsYyn5F1yC75k1ofZ+eJorOIS0R89dhRZo9QYd8=
Received: by mx.zohomail.com with SMTPS id 1740144634645949.3358858508584;
	Fri, 21 Feb 2025 05:30:34 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.300.87.4.3\))
Subject: Re: [PATCH V2 2/2] rust: Add basic bindings for clk APIs
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <a0a1ba4e27c3a0d9e38c677611eb88027e463287.1740118863.git.viresh.kumar@linaro.org>
Date: Fri, 21 Feb 2025 10:30:17 -0300
Cc: Michael Turquette <mturquette@baylibre.com>,
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
 rust-for-linux@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <17E31EBB-339C-47DD-87AE-0B39EB934559@collabora.com>
References: <cover.1740118863.git.viresh.kumar@linaro.org>
 <a0a1ba4e27c3a0d9e38c677611eb88027e463287.1740118863.git.viresh.kumar@linaro.org>
To: Viresh Kumar <viresh.kumar@linaro.org>
X-Mailer: Apple Mail (2.3826.300.87.4.3)
X-ZohoMailClient: External

Hi Viresh, thank you for working on this.


> On 21 Feb 2025, at 03:33, Viresh Kumar <viresh.kumar@linaro.org> =
wrote:
>=20
> Add initial bindings for the clk APIs. These provide the minimal
> functionality needed for common use cases, making them straightforward
> to introduce in the first iteration.
>=20
> These will be used by Rust based cpufreq / OPP layers to begin with.
>=20
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> MAINTAINERS        |   1 +
> rust/kernel/clk.rs | 104 +++++++++++++++++++++++++++++++++++++++++++++
> rust/kernel/lib.rs |   1 +
> 3 files changed, 106 insertions(+)
> create mode 100644 rust/kernel/clk.rs
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 726110d3c988..96e2574f41c0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5779,6 +5779,7 @@ F: include/linux/clk-pr*
> F: include/linux/clk/
> F: include/linux/of_clk.h
> F: rust/helpers/clk.c
> +F: rust/kernel/clk.rs
> X: drivers/clk/clkdev.c
>=20
> COMMON INTERNET FILE SYSTEM CLIENT (CIFS and SMB3)
> diff --git a/rust/kernel/clk.rs b/rust/kernel/clk.rs
> new file mode 100644
> index 000000000000..c212cd3167e1
> --- /dev/null
> +++ b/rust/kernel/clk.rs
> @@ -0,0 +1,104 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Clock abstractions.
> +//!
> +//! C header: [`include/linux/clk.h`](srctree/include/linux/clk.h)
> +
> +use crate::{
> +    bindings,
> +    device::Device,
> +    error::{from_err_ptr, to_result, Result},
> +    prelude::*,
> +};
> +
> +use core::ptr;
> +
> +/// A simple implementation of `struct clk` from the C code.
> +#[repr(transparent)]
> +pub struct Clk(*mut bindings::clk);

> +
> +impl Clk {
> +    /// Creates `Clk` instance for a device and a connection id.
> +    pub fn new(dev: &Device, name: Option<&CStr>) -> Result<Self> {
> +        let con_id =3D if let Some(name) =3D name {
> +            name.as_ptr() as *const _
> +        } else {
> +            ptr::null()
> +        };
> +
> +        // SAFETY: It is safe to call `clk_get()`, on a device =
pointer earlier received from the C
> +        // code.
> +        Ok(Self(from_err_ptr(unsafe {
> +            bindings::clk_get(dev.as_raw(), con_id)
> +        })?))
> +    }
> +
> +    /// Obtain the raw `struct clk *`.
> +    pub fn as_raw(&self) -> *mut bindings::clk {
> +        self.0
> +    }
> +
> +    /// Clock enable.
> +    pub fn enable(&self) -> Result<()> {
> +        // SAFETY: By the type invariants, we know that `self` owns a =
reference, so it is safe to
> +        // use it now.
> +        to_result(unsafe { bindings::clk_enable(self.0) })
> +    }
> +
> +    /// Clock disable.
> +    pub fn disable(&self) {
> +        // SAFETY: By the type invariants, we know that `self` owns a =
reference, so it is safe to
> +        // use it now.
> +        unsafe { bindings::clk_disable(self.0) };
> +    }
> +
> +    /// Clock prepare.
> +    pub fn prepare(&self) -> Result<()> {
> +        // SAFETY: By the type invariants, we know that `self` owns a =
reference, so it is safe to
> +        // use it now.
> +        to_result(unsafe { bindings::clk_prepare(self.0) })
> +    }
> +
> +    /// Clock unprepare.
> +    pub fn unprepare(&self) {
> +        // SAFETY: By the type invariants, we know that `self` owns a =
reference, so it is safe to
> +        // use it now.
> +        unsafe { bindings::clk_unprepare(self.0) };
> +    }
> +
> +    /// Clock prepare enable.
> +    pub fn prepare_enable(&self) -> Result<()> {
> +        // SAFETY: By the type invariants, we know that `self` owns a =
reference, so it is safe to
> +        // use it now.
> +        to_result(unsafe { bindings::clk_prepare_enable(self.0) })
> +    }
> +
> +    /// Clock disable unprepare.
> +    pub fn disable_unprepare(&self) {
> +        // SAFETY: By the type invariants, we know that `self` owns a =
reference, so it is safe to
> +        // use it now.
> +        unsafe { bindings::clk_disable_unprepare(self.0) };
> +    }
> +
> +    /// Clock get rate.
> +    pub fn rate(&self) -> usize {
> +        // SAFETY: By the type invariants, we know that `self` owns a =
reference, so it is safe to
> +        // use it now.
> +        unsafe { bindings::clk_get_rate(self.0) }
> +    }
> +
> +    /// Clock set rate.
> +    pub fn set_rate(&self, rate: usize) -> Result<()> {

It might be worth it to add a type here to make it clear what in what =
unit is `rate` expressed as.

Something like:

pub struct Hertz(pub u32);

pub fn set_rate(&self, rate: Hertz);

Assuming `rate` is in Hertz.


> +        // SAFETY: By the type invariants, we know that `self` owns a =
reference, so it is safe to
> +        // use it now.
> +        to_result(unsafe { bindings::clk_set_rate(self.0, rate) })
> +    }
> +}
> +
> +impl Drop for Clk {
> +    fn drop(&mut self) {
> +        // SAFETY: By the type invariants, we know that `self` owns a =
reference, so it is safe to
> +        // relinquish it now.
> +        unsafe { bindings::clk_put(self.0) };
> +    }
> +}
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 496ed32b0911..324b86f127a0 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -40,6 +40,7 @@
> pub mod block;
> #[doc(hidden)]
> pub mod build_assert;
> +pub mod clk;
> pub mod cred;
> pub mod device;
> pub mod device_id;
> --=20
> 2.31.1.272.g89b43f80a514
>=20
>=20


This is working fine on Tyr, so:

Tested-by: Daniel Almeida <daniel.almeida@collabora.com>

With the minor change above:

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>


