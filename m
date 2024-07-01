Return-Path: <linux-kernel+bounces-236996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B1591E997
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 22:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 772C21F22AFE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 20:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E02517109D;
	Mon,  1 Jul 2024 20:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s64hNPq2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3D92AD0C;
	Mon,  1 Jul 2024 20:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719865777; cv=none; b=b1uBy1+smIdrd34bqD2+oSvjnqxYCSfAUfI+UErP4nU2xg+bzAvKKXlNNjoBW1FOE7ijAb4BgRrb4sM9zBxJ3OH7AAAORKFj923uPb5w6jYkUKrjYnOBkgCVBOEIynM3dQfR05jhr+yhU1lwlWetUsY0kK5zuv+q1C11kTQsmdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719865777; c=relaxed/simple;
	bh=DfY6xZJ0wJtz6unu308rhQqHaFInyGavjVB1DMTESBU=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=kAwLXWZvsBA0XlOn5Rf4nEKhoesxhhsZkUtGijhWFCK+c8JeiZIyxxHmKErrr1sdzSFOClVFCrzE0uoAbpXmbsIcqc6FS0D5vnDv3Mp2v//j5rS1DpA/R/D0tsQHm84YLBaPv8RJIDDAccbfQ8iq3RxtKM4S3mKFu7bT4G8G1N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s64hNPq2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CBFFC116B1;
	Mon,  1 Jul 2024 20:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719865777;
	bh=DfY6xZJ0wJtz6unu308rhQqHaFInyGavjVB1DMTESBU=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=s64hNPq2WcJEVn8yTfUfT4SUceN8dFomnlhmy+p/E3CFuncAOQGkfJxMMv5uDMVv9
	 zrsHR/JzpRrKtioUNApt8A4z41P2YTd0LX76SnA5SEZ8MWqZYmlAKkb/cmo574RXKb
	 VO5opsh+xZL1eSlfpE3MOL+xi+y0+KUzcAIGoLvk5tx/s7CzdH5quE9q6Y9NI7RBdn
	 Hm795HNUZ2qluh9ioF2yMVBW60wMHWEJHe1tLFLADZALK3XsxrvpP19p/e/yxBxsdL
	 sOY/cLlArI1xSUACho8+/sooQW9LVyWSsmdYFI4TNCrV5Va7xjqFEJ06iakvOI31Lm
	 hMiZvfZ3IYNTw==
Message-ID: <9ed5affb3e67a6848dad5c108804f8bd.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240701181825.916610-1-abel.vesa@linaro.org>
References: <20240701181825.916610-1-abel.vesa@linaro.org>
Subject: Re: [GIT PULL] clk: imx: Updates for v6.11
From: Stephen Boyd <sboyd@kernel.org>
Cc: imx@lists.linux.dev, NXP Linux Team <linux-imx@nxp.com>, linux-clk@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Abel Vesa <abel.vesa@linaro.org>, Mike Turquette <mturquette@baylibre.com>
Date: Mon, 01 Jul 2024 13:29:34 -0700
User-Agent: alot/0.10

Quoting Abel Vesa (2024-07-01 11:18:25)
> The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfab=
d0:
>=20
>   Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)
>=20
> are available in the Git repository at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux.git/ tags/=
clk-imx-6.11
>=20
> for you to fetch changes up to 466da3d2d967ee87d82060df2bc9c6ad4fc4af49:
>=20
>   clk: imx: composite-7ulp: Use NULL instead of 0 (2024-06-24 14:22:08 +0=
300)
>=20
> ----------------------------------------------------------------

Thanks. Pulled into clk-next

