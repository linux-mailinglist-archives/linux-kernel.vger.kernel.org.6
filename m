Return-Path: <linux-kernel+bounces-525935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B58A3F789
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 15:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDE7C3BC876
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 14:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479E620FAB6;
	Fri, 21 Feb 2025 14:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="eZovUB/4"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E6520D4E4;
	Fri, 21 Feb 2025 14:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740148968; cv=pass; b=lcK3/BXsugv6KqTCUIIt59KgrLZChlyYww7Sx3RAMupw8wxry5PKOZ9gNZ+9cQ50tU4+iuhjVIIGZMq/U9zm+Ke217Z4iNXsZCPa9QpSWIClKa0Z6SbmuxfLZoo+sSQpD08SuJmQ/AgmTFhG3UiE4jtwXxKjkSxJW+aFW6uwWGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740148968; c=relaxed/simple;
	bh=XB07gHKBWHDcF1ouarEfX4uZThcBgCcup2qEL3S6WDk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ZY2zGlyRZR0h3F15J0MYIWqTeY+0kewn/GWktzBYz4Ygaz+wX2a4B9P9WjYcDCq3jFIazBvUQYW/gMDCKl5MwPvsRB4iv8JNqeM4+WETeqAhc/sfajUltZ8kGacA4efcD+hOYGIcJhT0L8UEQOjb/t3H9fyve6HrYQKs7cLiJiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=eZovUB/4; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1740148940; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=cBdhdXle+NbZJ+UOOn3wzJSupS+qsOQ8pnL5ZB5jAjx6PpOYiYOvq3cSe3nSbVXn9DLNhAABL4j2e9p7lW/GJDfREf0gc8VTuX2GzwFuFlzHD3lCFqiDnEKIyg2u+BMCHsK6DREautGa5K10YTZ9jbV4cv8Ft4pqNpDujVD5Bbk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740148940; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=EESyc1srKUILspKfUnq7YvoORbbaGP4DcpR55jqXw8E=; 
	b=YiYmmBnJpXRC5fR0LGb/FTSLcK0kN77d/oHZlg+kRyutgZSOVMReUNEsPXDow9L6nu31q1X9qhcA0xKj+RvPd2Ymd6yq5GQ1ckqto2ddr13xhphU+ob32W1MsmhCxJGzQyYQk5zQeSd/i9WdHy1ZfHjZ0zOCeNLMn52SoaP63+U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740148940;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=EESyc1srKUILspKfUnq7YvoORbbaGP4DcpR55jqXw8E=;
	b=eZovUB/4FWrdbCtlSHWbDnZQuQRfDFL83quvJXK66PkLvsQxnQKDp9sNePUQxc1y
	NTevesbq0BvbGTyjdgHzskEnLGwkwhXKeILAIR9x6AtwdTjoMR2vUek9QVF68qrpMxm
	Cx8m8wiadz91hzuMpxvRz/0web/G+bp9g8rCznC4=
Received: by mx.zohomail.com with SMTPS id 1740148938858658.3952531689393;
	Fri, 21 Feb 2025 06:42:18 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.300.87.4.3\))
Subject: Re: [PATCH V2 2/2] rust: Add basic bindings for clk APIs
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <a0a1ba4e27c3a0d9e38c677611eb88027e463287.1740118863.git.viresh.kumar@linaro.org>
Date: Fri, 21 Feb 2025 11:42:02 -0300
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
Message-Id: <05A962FE-CEEB-445D-8A7A-F9AE77828B41@collabora.com>
References: <cover.1740118863.git.viresh.kumar@linaro.org>
 <a0a1ba4e27c3a0d9e38c677611eb88027e463287.1740118863.git.viresh.kumar@linaro.org>
To: Viresh Kumar <viresh.kumar@linaro.org>
X-Mailer: Apple Mail (2.3826.300.87.4.3)
X-ZohoMailClient: External


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

Viresh, one thing I forgot to comment. Maybe it=E2=80=99s better if we =
keep the
`get` nomenclature here instead of `new`.

This is to make clear that nothing is getting spawned. A reference to a =
system
resource is (potentially) being returned instead.

This would also mean refactoring the docs for this function.

=E2=80=94 Daniel


