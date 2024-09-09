Return-Path: <linux-kernel+bounces-322117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5FD97243E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 23:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4897A1F240BE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 21:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A8D18C01D;
	Mon,  9 Sep 2024 21:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c4h6DKHm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A41189F2F;
	Mon,  9 Sep 2024 21:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725916238; cv=none; b=jl1cwyYi5tmdwN/VC0jtoLSvJAbU0vWhVRi+KOZ/utrUV+fttjRhMpzjLf4tGtRpAuWI/eyjoeQEMnWYZ05C5YebtYwUjIJ36PXm0eQmtgKDnZnioLOY6YSgqoCiqnX1IViCZEfbIs2lhN0d6x9b1tsRM2flXlES5ORCuXBXY+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725916238; c=relaxed/simple;
	bh=MrtANQVha9P9Lvw9CKpcpRx9xPN484pTQpV1GPE55pg=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=YfL56CBB+o2zOJ6Dk4b/ByfldAPq//SIf3pSQxr1WBpA1s8q4hx5RNX5uyoF2J08hXfWQepdmDwJQA327i8L5nssGVpO9C4d/MPPNnp747+3kshbAzocVACS63IGS9TqJpaXZoVRB5xHDbPh/oLXERNpDAQQ8zx51rWH4wg6VzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c4h6DKHm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7133AC4CEC5;
	Mon,  9 Sep 2024 21:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725916237;
	bh=MrtANQVha9P9Lvw9CKpcpRx9xPN484pTQpV1GPE55pg=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=c4h6DKHmlCr0T/qOShqLVJP/Kvyd2M5/1qtoReBDD/dRwJfzgbmcqVRXvHd8T+Ilq
	 xz8XHZYVxeN0SAy/WS28yczlCiCUHivOWFGRxR6fSLVxApWDA1wZKe/dwPyvT2cbkm
	 361kZB3x+A5ucP6YIV/PgLamWC4Eb5OAXFqlkEbsf6gh27rnZ/MIRxqbSvAEa0K6Pj
	 F4LdOAiwo5evOLOELkhoU0dIfH9qrjlnjXuFsIfm8/QtjmFKqKRRHU/GzMfK2f9dPq
	 3lcBEW2ene9zeFGRHaozo7puHbqGVxEyDUgyHFbiOD5WRigj9jM3GMjyRovP9K/GzL
	 Vt8v1wP2i321A==
Message-ID: <a487389540a0dd6c981257b4939c001a.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240909121116.254036-1-arnd@kernel.org>
References: <20240909121116.254036-1-arnd@kernel.org>
Subject: Re: [PATCH] clk: rockchip: remove unused mclk_pdm0_p/pdm0_p definitions
From: Stephen Boyd <sboyd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Elaine Zhang <zhangqing@rock-chips.com>, YouMin Chen <cym@rock-chips.com>, Detlev Casanova <detlev.casanova@collabora.com>, Sugar Zhang <sugar.zhang@rock-chips.com>, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
To: Arnd Bergmann <arnd@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Michael Turquette <mturquette@baylibre.com>
Date: Mon, 09 Sep 2024 14:10:35 -0700
User-Agent: alot/0.10

Quoting Arnd Bergmann (2024-09-09 05:11:05)
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> When -Wunused-const-variable is enabled (not the default),
> there is a warning about two definitions in this file:
>=20
> In file included from drivers/clk/rockchip/clk-rk3576.c:14:
> drivers/clk/rockchip/clk-rk3576.c:334:7: error: 'mclk_pdm0_p' defined but=
 not used [-Werror=3Dunused-const-variable=3D]
>   334 | PNAME(mclk_pdm0_p)                      =3D { "mclk_pdm0_src_top"=
, "xin24m" };
>       |       ^~~~~~~~~~~
> drivers/clk/rockchip/clk.h:564:43: note: in definition of macro 'PNAME'
>   564 | #define PNAME(x) static const char *const x[] __initconst
>       |                                           ^
> drivers/clk/rockchip/clk-rk3576.c:333:7: error: 'pdm0_p' defined but not =
used [-Werror=3Dunused-const-variable=3D]
>   333 | PNAME(pdm0_p)                           =3D { "clk_pdm0_src_top",=
 "xin24m" };
>       |       ^~~~~~
> drivers/clk/rockchip/clk.h:564:43: note: in definition of macro 'PNAME'
>   564 | #define PNAME(x) static const char *const x[] __initconst
>       |                                           ^
>=20
> Remove them for the moment. If they are needed later, they can
> be added back at that point.
>=20
> Fixes: cc40f5baa91b ("clk: rockchip: Add clock controller for the RK3576")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Applied to clk-next

