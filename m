Return-Path: <linux-kernel+bounces-344816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C084598AE85
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 22:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C520B22360
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 20:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CB017B50A;
	Mon, 30 Sep 2024 20:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJkAMC3E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F191E152E1C
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 20:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727728656; cv=none; b=Exe2XmjzpzrLIZJ5HzfR6sYHvQAXew1kwAaJevZE1FYd7eUyNZeyPEhCTfJ6lfOOKCw/BLlS4afxx7Qd4yUKYqMGa+5RS9zwHQafyE0Rgb1qoNmentR2zkTI08zlurf3tBxHU4dib25+BfeZ6SsmRpuLSucRk+DWU8xXRtc0fdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727728656; c=relaxed/simple;
	bh=2MuPBMsuaPsMd86DsStni/MKPDlfs2/SmEj3oUwVOuI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=p5ylE6rXgOGOIMxBSByAecVzy2YdQhUUa+uxLJiqFksEaIcUlhw2j+VaUQAMek/fme1TZjN+bg4PVfzNk+h2mvyckAJstkw5HzjaJlvS97xZnxTUuia98tSFbbjzvzC6CnMetMVHswWLf8RTdrdJVIzER6g1RLM5c7KmMAQYXXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OJkAMC3E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 265C5C4CED1;
	Mon, 30 Sep 2024 20:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727728655;
	bh=2MuPBMsuaPsMd86DsStni/MKPDlfs2/SmEj3oUwVOuI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=OJkAMC3EUaPUl0vdl3c6UWEdim/SNyUUyuwKRegQGb9e3OADyVxQTMj9CvaNkOX2I
	 hOoaVMQwrzMc3+2HyOc7kpEguX27F6/pFIpLYJHV5pIuoY/VcHDlsNzbfb3i/T9TH+
	 6Vy1xu6293UuSM/p9T9Pf/RwFBzpPSEU9KLwcCs/t2hhjWRHewUVd5U5HYJDFjHuiA
	 ljFtuvM4iuLnr7XEDweejvUevDRUSrj/dksNm7hCZyBU7HWSux1m6U28gH4jqFzenk
	 fy0q9Pb7NrxDZh5h0JRKSgiX/ttkH2WvK++7PK9BGFnff6ITagXWyIOo2QSj3u1LEj
	 HwX8j1Cb9mRbA==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20240920153430.503212-14-u.kleine-koenig@baylibre.com>
References: <20240920153430.503212-14-u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH] regulator: isl6271a: Drop explicit initialization of
 struct i2c_device_id::driver_data to 0
Message-Id: <172772865477.2147169.11243573301530962890.b4-ty@kernel.org>
Date: Mon, 30 Sep 2024 21:37:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-99b12

On Fri, 20 Sep 2024 17:34:32 +0200, Uwe Kleine-König wrote:
> These drivers don't use the driver_data member of struct i2c_device_id,
> so don't explicitly initialize this member.
> 
> This prepares putting driver_data in an anonymous union which requires
> either no initialization or named designators. But it's also a nice
> cleanup on its own.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: isl6271a: Drop explicit initialization of struct i2c_device_id::driver_data to 0
      commit: f4e06afb0b47eb8ef6aa42eb8df2adb73b397bf7

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


