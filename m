Return-Path: <linux-kernel+bounces-439596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B41219EB17E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A54C8287EFA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 13:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312361AC43E;
	Tue, 10 Dec 2024 13:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cXPI5Hm+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C341AB51B
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 13:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733835639; cv=none; b=ewPP1ZAyaLdSrCzg3Q8Ra6T+PYy+nXIfj9SsKPK2Lw6SLVp9Tc+9KfhHtQM5vyqj/wf2fPmN0/RhdsnafN8A/NIC10W96x17ylFRwbeaLr3OcBDyRJ+I5RurOqTadQUZM4GwK+IUKL/AgFcnlutZvySujC2U5gPb4UnIt5GfH34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733835639; c=relaxed/simple;
	bh=ZafKGw9uvt1OMu6pBOh3V5mAtvLn7UKw27wgRS5EpeQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DE/diL/IWyn8OiUbEXRq1hdUka6aXrH1Uk1IjifRP6u5nVrPvGALQ4EgHZ3bXNBAb3V4wWKp3Ra/WVmbRWeP1Jcout+r2iU5c1iAORwPNXN3figct6nr7+Z8y21E4qRViFib4ZxipQZFoFYo9b1TshNzdLcBULPX4KwEarg4XB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cXPI5Hm+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4EA9C4AF09;
	Tue, 10 Dec 2024 13:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733835639;
	bh=ZafKGw9uvt1OMu6pBOh3V5mAtvLn7UKw27wgRS5EpeQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=cXPI5Hm+VKtjdBGKXGv1Qz1jtm+6WVK4bC8hoLtgRgFuDMiITG0zRz3ZbWSrskZq1
	 FK+c0xOJR2iXqOMdMH0IMGNMK2fLfeaJZTBAGAaIIl88FFRtSBqhrCAfxfgdcLm1WZ
	 bg+1zYs6B7Mbebhe/r0pODz7uOIpnWrH7m0Z6FuPJxPUFDmoFgQAlQF1cwKImfU4Cd
	 Qx9bWXr4R88YpPycnSCxFc6gYE939tSNwhc27qIA6WA6h13leoixRNyczYGJbrnfuB
	 6hGP4cdO2V4YRd32caea79NjZAmqnzFDL4nibtacNqvFl61Gp+0TAnGvS8OjCkBWgz
	 eabgjjl7JHo9w==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Chen-Yu Tsai <wens@csie.org>, 
 linux-kernel@vger.kernel.org, Philippe Simons <simons.philippe@gmail.com>
Cc: Hironori KIKUCHI <kikuchan98@gmail.com>, 
 Chris Morgan <macromorgan@hotmail.com>
In-Reply-To: <20241208124308.5630-1-simons.philippe@gmail.com>
References: <20241208124308.5630-1-simons.philippe@gmail.com>
Subject: Re: [PATCH v2] regulator: axp20x: AXP717: set ramp_delay
Message-Id: <173383563766.33920.515022843579626283.b4-ty@kernel.org>
Date: Tue, 10 Dec 2024 13:00:37 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Sun, 08 Dec 2024 13:43:08 +0100, Philippe Simons wrote:
> AXP717 datasheet says that regulator ramp delay is 15.625 us/step,
> which is 10mV in our case.
> 
> Add a AXP_DESC_RANGES_DELAY macro and update AXP_DESC_RANGES macro to
> expand to AXP_DESC_RANGES_DELAY with ramp_delay = 0
> 
> For DCDC4, steps is 100mv
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: axp20x: AXP717: set ramp_delay
      commit: f07ae52f5cf6a5584fdf7c8c652f027d90bc8b74

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


