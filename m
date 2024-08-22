Return-Path: <linux-kernel+bounces-298038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B1F95C0FF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 00:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AE1F1F246D2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 22:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B188E17555;
	Thu, 22 Aug 2024 22:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aTUJsipR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0364B1D1F7F
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 22:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724366669; cv=none; b=ltEELgv3qPbuyIeZ9th8M3MIx2J/bmeySabkpekDYa3EQmH379WWfk3H2s0EeYLwJ3tl5fkWTBt0jxyfrf9vyL4kooP0jxWFcn19gXLkoKHJlLaKTOc6oU25gsjQi+dmwoc1qk8fNA+JwFGCyrLWWAl4wTbKzBZkw2mTkZayWbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724366669; c=relaxed/simple;
	bh=AyWJXV6SkdaKf1YuIDAOBYhJkDalL2nkN99ePZ+M3Ts=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QbDGWXynWsHGIOnykG86RuWOOHGIRef7q30/DjfJGWljkZ0fnPYxWb1S8dIN4u/E7/wHzRQ7czB36zQRB/r4+82c1gCymknG6goKNcNIEJy7hBerl2RFvZFdcW0stABOwIF4JVgeFgbUts57cuAnCnJKxKO8ZPpzpnJEuIQ+WRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aTUJsipR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3B62C4AF0E;
	Thu, 22 Aug 2024 22:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724366668;
	bh=AyWJXV6SkdaKf1YuIDAOBYhJkDalL2nkN99ePZ+M3Ts=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=aTUJsipRXIBr+MU1UReVSD9u0sfUYdkZiZwBxtRVhzvZNNbC+cBDeVh6t1nlB4a/d
	 HYKmG0xdoDE8gUsz3hUV9uiCr+H8A4mT2cLOH00HePLmB2uXHuAShe2CVHMCDPRLvz
	 Zr9YU2AZyjFXOGTlriiGNDdGcv2JD0GPVUYhqoEX9ZGCYcWuxRQtLmCl9dVvolU7Qp
	 TxRVkcqWlvlegP5zS1r5T3ZdFgADqJqTbwo6Np94+IYErtpE96HPj3DgnaitAwqPN8
	 +1po5PML8MIaNoedkDGtBYe05ygh/u5P+sf+AwGAUOidgNRRuzpMUqJ7mde7mP9Bq8
	 zLFxB/7bKoZCg==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Chen-Yu Tsai <wenst@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20240822072047.3097740-1-wenst@chromium.org>
References: <20240822072047.3097740-1-wenst@chromium.org>
Subject: Re: [PATCH 0/3] regulator: Minor cleanups
Message-Id: <172436666750.826139.6639277295564469617.b4-ty@kernel.org>
Date: Thu, 22 Aug 2024 23:44:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Thu, 22 Aug 2024 15:20:43 +0800, Chen-Yu Tsai wrote:
> Here are some cleanups for some bits that I saw while reworking my I2C
> device tree component prober to use of_regulator_bulk_get_all().
> These are not directly related to that series, so I send them
> separately here.
> 
> Patch 1 makes the regulator_get*() function misuse error message easier
> to understand.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/3] regulator: Clarify error message for "id == NULL" in _regulator_get()
      commit: ad9d7a82901d9cea756b8666035b30ca41728e15
[2/3] regulator: Return actual error in of_regulator_bulk_get_all()
      commit: 395a41a1d3e377462f3eea8a205ee72be8885ff6
[3/3] regulator: Fully clean up on error in of_regulator_bulk_get_all()
      commit: bfefa214d179f13d01cf1b64a7efbabf586b0c49

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


