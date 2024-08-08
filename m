Return-Path: <linux-kernel+bounces-280202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 079BB94C718
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 00:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 387BA1C210C5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 22:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75DDD15B0FC;
	Thu,  8 Aug 2024 22:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SdTz5mdy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7ECA4A1E;
	Thu,  8 Aug 2024 22:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723157286; cv=none; b=dTzhb7l6okVNRPX2ciYOW4VQO7yq7BkIT8MVVrdJVKSg0s2ufK14vckXxVJ87GHXs14xzpKQrq8+PNUbsc/MM3+YKWWH4SoSEwviJhyxEkqFEbbmwcZ6h3UN2129CT3aY/NftlI84F652e28pKPAjqfIQowxh/C+Tym4LJIgRVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723157286; c=relaxed/simple;
	bh=aPaESeImOrbfP0m5Al8CEekd6PKV0hGYl7I48g2RPqw=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=ewNjqn3RWQKkwSsE7cWIj04TcOL0GOYgmLu3f7R7pK8bNVggHdSny48U8QHFEwltE+qlEMYqegKLeHheU2O2ntl/9OHIpa7LOlrfYpehHf0DJ4dGhcjXhomWczA6ReEBfb+Pvm9SPsxVaayEO5yHOzejfXvv6pTuON848hqE388=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SdTz5mdy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A1CFC32782;
	Thu,  8 Aug 2024 22:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723157286;
	bh=aPaESeImOrbfP0m5Al8CEekd6PKV0hGYl7I48g2RPqw=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=SdTz5mdyfEf8YjwUfL3VZjxml4aBFJFv7+EWX+kJ4B90UD0i9TXvKSIxINVzRMjrD
	 LAoPK680XmAdvEW3s71SQtHNXYEzgX7hMwalrloTIP6qr0W25q1YpmlhSUvaOpBbVB
	 udcW08elVxFxbIiakPWhfU0a3hxucIOPb0treGd/ftO1Y2AHiq0LfG0AF1Fs4Ma9/X
	 c0eFZOBcsGTapQoempW8Y3tiBoHVVaijP0f28Ged8lFfvpcQOdWBh5FEHLt3Grv9Xu
	 sHa5/LOgxPMjKGOivH4c0SbvfMEw5fYd0SteOUwyPLGCiIaE9nDC8iVO2ddyzpnof0
	 8JEr5ck6FCPNw==
Message-ID: <ac67f76d4b4b5f4bf108c1457f1263c7.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240722121910.14647-1-naman.trivedimanojbhai@amd.com>
References: <20240722121910.14647-1-naman.trivedimanojbhai@amd.com>
Subject: Re: [PATCH V2] drivers: clk: zynqmp: remove clock name dependency
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, Naman Trivedi Manojbhai <naman.trivedimanojbhai@amd.com>
To: Naman Trivedi <naman.trivedimanojbhai@amd.com>, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, michal.simek@amd.com, mturquette@baylibre.com, senthilnathan.thangaraj@amd.com
Date: Thu, 08 Aug 2024 15:48:03 -0700
User-Agent: alot/0.10

Quoting Naman Trivedi (2024-07-22 05:19:10)
> From: Naman Trivedi Manojbhai <naman.trivedimanojbhai@amd.com>
>=20
> Use struct clk_parent_data to register the clock parents with the clock
> framework instead of parent name.
>=20
> Signed-off-by: Naman Trivedi Manojbhai <naman.trivedimanojbhai@amd.com>

This is great! Thanks for doing this.

> diff --git a/drivers/clk/zynqmp/clk-gate-zynqmp.c b/drivers/clk/zynqmp/cl=
k-gate-zynqmp.c
> index b89e55737198..6bb9704ee1d3 100644
> --- a/drivers/clk/zynqmp/clk-gate-zynqmp.c
> +++ b/drivers/clk/zynqmp/clk-gate-zynqmp.c
> @@ -104,8 +104,8 @@ static const struct clk_ops zynqmp_clk_gate_ops =3D {
>   *
>   * Return: clock hardware of the registered clock gate
>   */
> -struct clk_hw *zynqmp_clk_register_gate(const char *name, u32 clk_id,
> -                                       const char * const *parents,
> +struct clk_hw *zynqmp_clk_register_gate(struct device_node *np, const ch=
ar *name, u32 clk_id,

General comment: Please use 'struct device' instead so that this driver
isn't DT specific. When you do that you can similarly use
devm_clk_hw_register() instead and introduce a lot of automatic cleanup.
If you want to do that in two steps that's fine. One patch that uses
parent_data/parent_hws and one that uses devm_ APIs and struct device to
register.

> diff --git a/drivers/clk/zynqmp/clkc.c b/drivers/clk/zynqmp/clkc.c
> index a91d98e238c2..b791a459280e 100644
> --- a/drivers/clk/zynqmp/clkc.c
> +++ b/drivers/clk/zynqmp/clkc.c
> @@ -543,7 +554,7 @@ static int zynqmp_clock_get_parents(u32 clk_id, struc=
t clock_parent *parents,
>   * Return: 0 on success else error+reason
>   */
>  static int zynqmp_get_parent_list(struct device_node *np, u32 clk_id,
> -                                 const char **parent_list, u32 *num_pare=
nts)
> +                                 struct clk_parent_data *parent_list, u3=
2 *num_parents)
>  {
>         int i =3D 0, ret;
>         u32 total_parents =3D clock[clk_id].num_parents;
> @@ -555,18 +566,30 @@ static int zynqmp_get_parent_list(struct device_nod=
e *np, u32 clk_id,
> =20
>         for (i =3D 0; i < total_parents; i++) {
>                 if (!parents[i].flag) {
> -                       parent_list[i] =3D parents[i].name;
> +                       ret =3D of_property_match_string(np, "clock-names=
",
> +                                                      parents[i].name);

You shouldn't need to match 'clock-names'. The order of that property is
fixed in the binding, which means you can simply use the index that the
name is at in the binding in 'struct parent_data'.

