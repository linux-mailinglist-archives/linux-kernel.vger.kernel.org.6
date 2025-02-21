Return-Path: <linux-kernel+bounces-525816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86369A3F5D2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 14:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21C4A1892BB6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 13:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A40205E2B;
	Fri, 21 Feb 2025 13:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="ODMba6qQ"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08C63D69;
	Fri, 21 Feb 2025 13:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740143999; cv=pass; b=F0ByOPWan1jIFJB2SBUv/KQwYDZ/zEp8YnRk4BVS0tyzz5dPf1lRqeYq9iBC/c3zg6PCChniy5O5crdjrnDhSU1eMG5YxoUOi4bQJOcIGZuZE0sOtRKjfgL2rU+dddbZuDBHTjnYoD4Sub+QFqmNYbjMBh6vJm5PLITe4QA5m8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740143999; c=relaxed/simple;
	bh=Kb7+wjOASoRGuV6siKUUZOZZ/lQdexbtHAhDUuJ0+NY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=dJ9Y0ClEat7mOm9HEeC0CuevU0VaUWSzqaFRTwALLfqx84YtqGt739d8YSWGA62NItAgyXB6CCTz9yPx2Pc/2g/4m/J7w6BXaYaeYFhqe/k7Vtx7h3wdC917menNZcwbxk1DuYTINEyebkvE7sJvCS/Iy63yG6GLapuQatWFDG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=ODMba6qQ; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1740143969; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=IugQHi1C6eZHLNbgqiaTXmkt+Ad2wKh7CNEwvZ4dX2RD8IEqoQVPb+Mhtrd95Z2qP3vt2Zm4fFVue58GNJRIYC23tIwKuNpVV1ZPefpEnjr0LJFPWwd4lp6/mGLCcXGbf259OYDZGW9OOyQ5KO8nCiMip75ckwpXwMVOloRZJbg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740143969; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=3CaIBrzYWWjRIGQThZeNiKzCqZb7IKXxW3vw/DrceD8=; 
	b=EHCejF3WAVD4Ofdzifa3+jjm8ISK6LHS3uKp/DOqM/w1ktnL9ipsmwuq8fHhv1u2BcKWYQdfe85gKMfdk5fLjNL2Sis478gbQJiqnoNifHoLJVORzkaLf7MoW+EVmDGmAwAZaC/klj385pUmRmCCb4H8mxTXrdBmPlUisAPFpNM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740143968;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=3CaIBrzYWWjRIGQThZeNiKzCqZb7IKXxW3vw/DrceD8=;
	b=ODMba6qQeW2i0K8aFo2qgqdSUB/pMQz+hBDlFr4nHSy+S88plkBk03Cf1IHnce5p
	xnAHxDPCNF6qUa96OzI7+5An5JTKrhBhThcUvP7nn85ESBRAyZXiLFQCSvtL3sNfDrr
	q5Pa+wqOxjh7lTOi3FpH/VOpDMYn1o0Fn4194XFU=
Received: by mx.zohomail.com with SMTPS id 174014396629894.6988383380359;
	Fri, 21 Feb 2025 05:19:26 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.300.87.4.3\))
Subject: Re: [PATCH V2 1/2] rust: Add clk helpers
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <7e4e95e221569070d72bb45ea0922e76be7db2a3.1740118863.git.viresh.kumar@linaro.org>
Date: Fri, 21 Feb 2025 10:19:09 -0300
Cc: Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <CE820212-E2D4-49DB-8B90-45088E74C1D2@collabora.com>
References: <cover.1740118863.git.viresh.kumar@linaro.org>
 <7e4e95e221569070d72bb45ea0922e76be7db2a3.1740118863.git.viresh.kumar@linaro.org>
To: Viresh Kumar <viresh.kumar@linaro.org>
X-Mailer: Apple Mail (2.3826.300.87.4.3)
X-ZohoMailClient: External

Hi Viresh,

> On 21 Feb 2025, at 03:33, Viresh Kumar <viresh.kumar@linaro.org> =
wrote:
>=20
> In order to prepare for adding Rust abstractions for the clock APIs,
> this patch adds clock helpers required by the Rust implementation.
>=20
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> MAINTAINERS                     |  1 +
> rust/bindings/bindings_helper.h |  1 +
> rust/helpers/clk.c              | 57 +++++++++++++++++++++++++++++++++
> rust/helpers/helpers.c          |  1 +
> 4 files changed, 60 insertions(+)
> create mode 100644 rust/helpers/clk.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 25c86f47353d..726110d3c988 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5778,6 +5778,7 @@ F: include/dt-bindings/clock/
> F: include/linux/clk-pr*
> F: include/linux/clk/
> F: include/linux/of_clk.h
> +F: rust/helpers/clk.c
> X: drivers/clk/clkdev.c
>=20
> COMMON INTERNET FILE SYSTEM CLIENT (CIFS and SMB3)
> diff --git a/rust/bindings/bindings_helper.h =
b/rust/bindings/bindings_helper.h
> index 55354e4dec14..4e4e16c3b479 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -10,6 +10,7 @@
> #include <linux/blk-mq.h>
> #include <linux/blk_types.h>
> #include <linux/blkdev.h>
> +#include <linux/clk.h>
> #include <linux/cred.h>
> #include <linux/errname.h>
> #include <linux/ethtool.h>
> diff --git a/rust/helpers/clk.c b/rust/helpers/clk.c
> new file mode 100644
> index 000000000000..3c63b50ad6fb
> --- /dev/null
> +++ b/rust/helpers/clk.c
> @@ -0,0 +1,57 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/clk.h>
> +
> +#ifndef CONFIG_HAVE_CLK

This is a bit confusing. Can you add a comment explaining how
we get inlined stubs if these configs are not set, thus explaining why
we need to define them in helpers.c?

This will let everyone know why we have #ifndef here when the logical =
thing
would be #ifdef. It will also make it clear why the rust code is not =
gated
by these configs.

> +struct clk *rust_helper_clk_get(struct device *dev, const char *id)
> +{
> + return clk_get(dev, id);
> +}
> +
> +void rust_helper_clk_put(struct clk *clk)
> +{
> + clk_put(clk);
> +}
> +
> +int rust_helper_clk_enable(struct clk *clk)
> +{
> + return clk_enable(clk);
> +}
> +
> +void rust_helper_clk_disable(struct clk *clk)
> +{
> + clk_disable(clk);
> +}
> +
> +unsigned long rust_helper_clk_get_rate(struct clk *clk)
> +{
> + return clk_get_rate(clk);
> +}
> +
> +int rust_helper_clk_set_rate(struct clk *clk, unsigned long rate)
> +{
> + return clk_set_rate(clk, rate);
> +}
> +#endif
> +
> +#ifndef CONFIG_HAVE_CLK_PREPARE

Same here.

> +int rust_helper_clk_prepare(struct clk *clk)
> +{
> + return clk_prepare(clk);
> +}
> +
> +void rust_helper_clk_unprepare(struct clk *clk)
> +{
> + clk_unprepare(clk);
> +}
> +#endif
> +
> +int rust_helper_clk_prepare_enable(struct clk *clk)
> +{
> + return clk_prepare_enable(clk);
> +}
> +
> +void rust_helper_clk_disable_unprepare(struct clk *clk)
> +{
> + clk_disable_unprepare(clk);
> +}
> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index 0640b7e115be..4700ee7aaf85 100644
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@ -11,6 +11,7 @@
> #include "bug.c"
> #include "build_assert.c"
> #include "build_bug.c"
> +#include "clk.c"
> #include "cred.c"
> #include "device.c"
> #include "err.c"
> --=20
> 2.31.1.272.g89b43f80a514
>=20
>=20

With this change,

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>


