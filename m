Return-Path: <linux-kernel+bounces-397325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 220DC9BDA7E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 01:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7867281E89
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 00:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E350657CB6;
	Wed,  6 Nov 2024 00:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EgO4amoc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A864F8A0;
	Wed,  6 Nov 2024 00:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730853873; cv=none; b=ka8OQSA3kkFy818V1kD/mYmZ++K3aWWqNPk8hGANm9ftYstpSPCufhcZ4rjNuMzRQj0jbjt/lBcBFLIS3eyKZDM2cJEt5Dzks8NDRVY17PzNBcrl9eIx1iCyCQj2tvwOxPmrBgnSOtNLGbC3cYR4chvV8wlcceQubESzM9Hke74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730853873; c=relaxed/simple;
	bh=0IQzgFC4tYrsOmjeRzELhBNSRrs0Hh0neabXRQN73iQ=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=CcwtXmLRlb62E9bb7cdlSuzMNVMGVm1vdDRKQU9nHjl2NoWFNcXm1JADwUpBuQQnk5ZVgEByWm8s8vCucVyqfmd/SBKq/DBrbm+u4Ak7y75wgkb99lFYq6XLLk78FlM0KsHeHAp+BEC0i5zueGMX0YV+N+bsCy/k2lAXMOCRA8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EgO4amoc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9A5DC4CECF;
	Wed,  6 Nov 2024 00:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730853872;
	bh=0IQzgFC4tYrsOmjeRzELhBNSRrs0Hh0neabXRQN73iQ=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=EgO4amoc8V59tRojC1uZBTXkNJJFTGrZ71vwpRv4+8O3kVGiEml9X3tqOjoN4xNBt
	 CQIxSyduB1K3W9M8WNuzQxDejDS5zPjNdAraYy/1dR0Ia5jVBECwoEKeYH7KGWP+6J
	 qhjuhy5kotKJQuW8eYHw6D6WT4GKVWVrQGW8iMgtyLL30rvn2VA/TrUlOUOHeYD8/k
	 rqkh03yJD4lfU1SgqzNyVrQF0gDNiOCOF2jKcLDmzU92KXlfiKIjNr8YqLb12oqQK1
	 r1rRtXNuDWkpiHi7YTCaPCXx4XQmTKp6LOJ2KX+xo7JJNr/0u9IymGQq98qU/CE91R
	 np43H2J0k83Lg==
Message-ID: <b5e47bf3229f3145cb705cfe83951d99.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241104075037.13323-1-krzysztof.kozlowski@linaro.org>
References: <20241104075037.13323-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [GIT PULL] clk: samsung: drivers for v6.13
From: Stephen Boyd <sboyd@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Chanwoo Choi <cw00.choi@samsung.com>, linux-clk@vger.kernel.org, Sylwester Nawrocki <snawrocki@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, Peter Griffin <peter.griffin@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Michael Turquette <mturquette@baylibre.com>
Date: Tue, 05 Nov 2024 16:44:30 -0800
User-Agent: alot/0.10

Quoting Krzysztof Kozlowski (2024-11-03 23:50:36)
> The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758e=
dc:
>=20
>   Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)
>=20
> are available in the Git repository at:
>=20
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/sam=
sung-clk-6.13
>=20
> for you to fetch changes up to 9174fac3b302a853b78c78f2f5ad11462b0c54b0:
>=20
>   clk: samsung: Introduce Exynos8895 clock driver (2024-10-26 14:00:12 +0=
200)
>=20
> ----------------------------------------------------------------

Thanks. Pulled into clk-next

