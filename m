Return-Path: <linux-kernel+bounces-317672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1E396E1F8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 20:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61EFE1F270D6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 18:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0BCC17C9B9;
	Thu,  5 Sep 2024 18:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="astDoqXp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5750D1C2E;
	Thu,  5 Sep 2024 18:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725560740; cv=none; b=O58ykUXnd7oXH6+U5T3IGE56AjFsnQLDWnAKfZlfep7RK3lNJtnhtID/B+sUS8f1bKYsdLqmgfFI2mYP2jFdRA8/MkhJJPpGeGqX8fUshzP8rs8e7gmtRZBvrd5wpIl64CGkdiJIA+CyGNamHvIvU27CTBH7nIK21mk2qHhLozE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725560740; c=relaxed/simple;
	bh=upDPrIzD3Q5267hh2eQQIgGASxYMEBmzc1rIw5hZSb0=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=QKRmWoMxBaweszCqLql5PeIxFa7JSrSu8wpU7qn5pySbRY2ZNGLQZgn+Fu67XLplpds6JUOO9qYGE4Yeadd9kT8BOm4EGcvLg2PnjwM3dyEw5EMNH+m4mUZunMOguGlvvBJsKDk3l7qLFEk+5pxcTR08CULi0f0LaDYTrKHdNDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=astDoqXp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C53A7C4CEC3;
	Thu,  5 Sep 2024 18:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725560739;
	bh=upDPrIzD3Q5267hh2eQQIgGASxYMEBmzc1rIw5hZSb0=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=astDoqXpHIPiyWN56wTlr1R9sZpmWC+kzNkQY+C60WJJsX6nmAy43OXYgDnib6AEn
	 AhnewzaLfxc5YRKXiGFzpb4ZAmi1UuChBDsoVaoljMNd050hsx6OdoF5t5n/YNw40i
	 X+uJM6AItzS7AmqX9pPzoTpDqhUALLPcN71MV2TtLbBi2ITCiK/qehQzkr3Em+NgK9
	 2ckZKdrQPtjKOD1+eQi7TynpKZQ/RWiLwrdA2rd63r7Goj3X604LiFadDbX2beLgls
	 dGoC9UhKENadf4xweR+PW7/GWcrOLIQ9xVCzZp1hCaK2+mvj+RC20fZLSsev4PTubt
	 UhOTSSm0c9scg==
Message-ID: <a8400f018cc94177b6a91634fd977248.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240904095710.2813541-1-abel.vesa@linaro.org>
References: <20240904095710.2813541-1-abel.vesa@linaro.org>
Subject: Re: [GIT PULL] clk: imx: Updates for v6.12
From: Stephen Boyd <sboyd@kernel.org>
Cc: imx@lists.linux.dev, NXP Linux Team <linux-imx@nxp.com>, linux-clk@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Abel Vesa <abel.vesa@linaro.org>, Mike Turquette <mturquette@baylibre.com>
Date: Thu, 05 Sep 2024 11:25:37 -0700
User-Agent: alot/0.10

Quoting Abel Vesa (2024-09-04 02:57:10)
> The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f01=
7b:
>=20
>   Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)
>=20
> are available in the Git repository at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux.git/ tags/=
clk-imx-6.12
>=20
> for you to fetch changes up to 32c055ef563c3a4a73a477839f591b1b170bde8e:
>=20
>   clk: imx6ul: fix clock parent for IMX6UL_CLK_ENETx_REF_SEL (2024-09-04 =
12:39:38 +0300)
>=20
> ----------------------------------------------------------------

Thanks. Pulled into clk-next. I also found the v6.11 PR for clk-imx in my
repo for some reason :( Sorry about that! I've merged that into clk-next
as well now so the next merge window will get two cycles worth.

