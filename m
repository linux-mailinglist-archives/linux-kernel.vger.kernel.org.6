Return-Path: <linux-kernel+bounces-547673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA90A50C40
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 21:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6E50188A6C6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 20:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD962561A6;
	Wed,  5 Mar 2025 20:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SSrkxgZh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827CA253F01;
	Wed,  5 Mar 2025 20:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741205404; cv=none; b=kvjs5cA6oxYWH8EbP+JOBU9wrb1nRWISjtTzb2UmCdF8ayjfTWyVlSXsPj5Z+yMkbTxe9Ls+w0IoNlj5lmpa+Y45TQqCSe7q6dTtQbkPyBZWNVdKjD/zDTTjA3+r59r8AholyVIrisR7xMQZXJMKz7sdWDW1bCCRWzW55RHpbZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741205404; c=relaxed/simple;
	bh=MVQzYhdHYMH5Tuq8M5PbpZZQYMj7UeFVNdHr1ME5bo0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=abwvuYuJIrBjx4Jq62c7QY5otJ8RcUst5SjsE/TDmI22FCqZMFj4XccoS6VLUMLBdBOWwGNp2qgd4Fw5qBuwyFLnyJi4Yrpnc60FTg+Ac6nz1efeTOXAcnYBEmk1oLY1S0U5VMVVb0oUAmv9zVdxbeGC66WxfylU9yE74JXIMeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SSrkxgZh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3F4AC4CEE8;
	Wed,  5 Mar 2025 20:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741205403;
	bh=MVQzYhdHYMH5Tuq8M5PbpZZQYMj7UeFVNdHr1ME5bo0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SSrkxgZhKdVo4V+cb3FZtsIc/LAHvZkDRhMI+tRGyqs9pk5VNVcFNCNj5VilzgWG1
	 NzXYoG/FxyB5p0benZfrCbfIJeW6GDxMdYijUVIxDx3zi+vqqzF+SUhpEvBP4O6mna
	 eDlzwB/f0Ohq8hgspy55b1oIHIF5mPQo+XI3hCubBIBCNAXtdOCeHIrWEWC/ZPp7mG
	 85SfmsYZeH9G667pi1/NzpIEpF1DqRjMKDw/fOCwmHZQob+f1wT3AyJmm4+u75mcss
	 gEEDGtD5tc42CGe9CULSW/dZ/okawOK1NluQ1QLrhwNcSM/zf2AXfsgbPsk0wLzKFH
	 UuDlbpF8CMjHg==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e535e6739bso6749793a12.1;
        Wed, 05 Mar 2025 12:10:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX9gCvMBWx7s2UK60dtIL7qOtHcK9/gSTgiq5oANAVbxyN3lcb0P5nyqjfO5WzIqKP+4OVZga/CSbsi5xUVEPM=@vger.kernel.org, AJvYcCXOzn4LOyGxnHibSZNgM9UIKPMsR8CPL45KvKYg9OVHUedoOOYqh4C+fwz1OcJFaBAnHh4fvyJUSmA=@vger.kernel.org, AJvYcCXXP0rqYthMdFPNfQDcK0UwlOOZTR3L5W1ZTMC10rfqs7Isj8Uj42icw7wlrIt1DYyvGspZaV7RUzZm6CgQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzKp/fM125ZA41YtZg0hLSv34Z3yoRvyw/sfZL9D3AlvjoJhzLN
	rHlbaS/6vktqhOUiSFiRGK3P3aq78ZHjx+76tVVpnVQbPc0SpYAbPCSB5GvqT47D1BMR2xorViZ
	haJcjsg77hw6krDNbaBwLdprzCg==
X-Google-Smtp-Source: AGHT+IE8JkbPtgQEvGcdwu3Oy8kHLnR4vi/qv5XyO2NhqlaLAfUlUjiafyfzsW3zJtBF0d5vjuOf+dRYq75NjTCrqUY=
X-Received: by 2002:a05:6402:42cb:b0:5de:4b81:d3fd with SMTP id
 4fb4d7f45d1cf-5e59f38a96fmr5092348a12.13.1741205402341; Wed, 05 Mar 2025
 12:10:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1740118863.git.viresh.kumar@linaro.org> <a0a1ba4e27c3a0d9e38c677611eb88027e463287.1740118863.git.viresh.kumar@linaro.org>
 <Z7iGHiQcqa-_AXli@pollux> <4AD8A8F3-EA7E-4FBE-9F0D-58CF7BB09ED5@collabora.com>
 <Z7iSHR0F2QpiNpMZ@pollux> <aoprvojsnmkbzmmpgx5wxjqtamnr3jyhyqfcqnwhxulp34gn32@aau57u4cotpe>
 <20250221215931.GA134397-robh@kernel.org> <20250224095945.xjcjwkoqlgcsd2np@vireshk-i7>
In-Reply-To: <20250224095945.xjcjwkoqlgcsd2np@vireshk-i7>
From: Rob Herring <robh@kernel.org>
Date: Wed, 5 Mar 2025 14:09:51 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJFeb66pt37wsTB7esCpRD1tpvqP1bvW=Nw8MmP5LvktQ@mail.gmail.com>
X-Gm-Features: AQ5f1JqvsOjM_L6JzavnVJyGd40bKnZ6_QrvavlB-hVTsrLbruc9kIjQqNkfbcw
Message-ID: <CAL_JsqJFeb66pt37wsTB7esCpRD1tpvqP1bvW=Nw8MmP5LvktQ@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] rust: Add basic bindings for clk APIs
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, Danilo Krummrich <dakr@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Russell King <linux@armlinux.org.uk>, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 4:00=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> On 21-02-25, 15:59, Rob Herring wrote:
> > It would be nice to handle the optional case from the start. Otherwise,
> > driver writers handle optional or not optional themselves. The not
> > optional case is typically some form of error message duplicated in
> > every driver.
> >
> > Every foo_get() needs foo_get_optional(), so let's figure out the rust
> > way to handle this once for everyone.
>
> Are we talking about adding another field here (like below code) or
> something else ?

Either way, but generally I think 2 functions are preferred over 1
function and flags.

The harder part here is in C we just return NULL and all subsequent
functions (e.g. clk_enable()) just return with no error for a NULL
struct clk. For rust, I think we'd need a dummy Clk returned and then
handle comparing the passed in reference to the dummy Clk in the rust
bindings.

>
> impl Clk {
>         pub fn get(dev: &Device, name: Option<&CStr>, optional: bool) -> =
Result<Self> {
>                 ...
>
>                 let clk =3D if optional {
>                         bindings::clk_get(dev.as_raw(), con_id)
>                 else {
>                         bindings::clk_get_optional(dev.as_raw(), con_id)
>                 };
>
>                 Ok(Self(from_err_ptr(clk)?))
>         }
> }
>
> --
> viresh

