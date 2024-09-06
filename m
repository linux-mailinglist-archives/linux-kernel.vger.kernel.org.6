Return-Path: <linux-kernel+bounces-319539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2109896FE1E
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 00:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3634B24E03
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 22:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C188715B0E5;
	Fri,  6 Sep 2024 22:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s2RHE1d+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181E32D045;
	Fri,  6 Sep 2024 22:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725662931; cv=none; b=fttTXUF5PrBzXOp+wzD/eAGWKjmFpl9peTi2zHj0G4i+rNMB8HERZdFKY+t+AZupihHYSgUWWbXgy+89+88qZX2fxwKqfPXqLGhjwh6Gbg3+039gPCE/2iCYRrIDpL6T1FV/MmH+Z+8Tx9jaoRPl1WSvTxkvDRcCA5Q4emU3mVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725662931; c=relaxed/simple;
	bh=X7aFEhqI3rIH0qa0XetrnPUhyomIEUgiBfMwLK/ZLXg=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=a8outf6SeYzhqwin87F5OcrsJQEMJB8e/LyqXId2jM8dKFOLQ9222SbZCQQlbF77GKUnzfUi0RX29Y3nCqYPhuU3S5K6g7s3hDB8G1lOoSc6wb+mXjrQhjcHwSyTcnBrtwtLmr76yjlWAGqABdKJm9ph+5Kt99qCrE3esZ55exE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s2RHE1d+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EDDCC4CEC4;
	Fri,  6 Sep 2024 22:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725662930;
	bh=X7aFEhqI3rIH0qa0XetrnPUhyomIEUgiBfMwLK/ZLXg=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=s2RHE1d+1PQQ4WwkJSPyupwN88Gzc7zE5uPmBFp4fX1rp1cvkd5YYG/VPA+fYRtke
	 lnVt3Dw6vIXz1Hnw7NkIwx4d+6rdvTUiFspKrUmPNJCVLf9u7hcaL1/5KUk80xwv0x
	 P85zAjjG8OMRQDiCiBnFbrL9tSEtpT/2+v6HAiMUc7X5dPLs+TmpyJ4zSlqS47aL1y
	 nVp3VcgeAMXP3TqIeESnuqdNUZB20tCl7VOrNeOBmuq3SCztrXk2J0DjWG1v7A0oQu
	 Evl8NIF9wrsd8l5lds3kT21Cf/bMtQgTcI35HxftRmM/MDNyb03CyEM+vSw+TTuT6J
	 oCgnIY/qZJbOw==
Message-ID: <cc247e3a006b15a9c9ed10cd2770f8b0.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240906140111.70922-1-krzysztof.kozlowski@linaro.org>
References: <20240906140111.70922-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [GIT PULL] clk: samsung: drivers for v6.12
From: Stephen Boyd <sboyd@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Chanwoo Choi <cw00.choi@samsung.com>, linux-clk@vger.kernel.org, Sylwester Nawrocki <snawrocki@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, Peter Griffin <peter.griffin@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Michael Turquette <mturquette@baylibre.com>
Date: Fri, 06 Sep 2024 15:48:48 -0700
User-Agent: alot/0.10

Quoting Krzysztof Kozlowski (2024-09-06 07:01:10)
> The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f01=
7b:
>=20
>   Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)
>=20
> are available in the Git repository at:
>=20
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/sam=
sung-clk-6.12
>=20
> for you to fetch changes up to 485e13fe2fb649e60eb49d8bec4404da215c1f5b:
>=20
>   clk: samsung: add top clock support for ExynosAuto v920 SoC (2024-08-23=
 09:21:35 +0200)
>=20
> ----------------------------------------------------------------

Thanks. Pulled into clk-next

