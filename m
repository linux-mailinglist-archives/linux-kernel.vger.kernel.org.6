Return-Path: <linux-kernel+bounces-351647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F07B399142F
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 05:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93D962853FE
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 03:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D4D39FC1;
	Sat,  5 Oct 2024 03:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+vn+RW4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14813FF1;
	Sat,  5 Oct 2024 03:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728100284; cv=none; b=qau5LGNCuvsVp7PZlid6ELYXo45i8ioyYhovWoaTV7xuyS/l6QJi9/W3Tb0PLa7U7FLBjDTGcqHnzKCu1YmIh+Q7dhsdzo1T9ij4D1IJvVtCnnWvJTpGWSwRIx2sphjQVeHpzNH/Nrz+d4LldvpDO1aDG2ftgxjZtuHkVdSWTpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728100284; c=relaxed/simple;
	bh=xnB03o5wj5wkk+9w0FLxKpxojhy1VFJSSIfAcXclIOc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iLpjI4PBNRdUDPcH2dca41MAu7yAwtKTyvanAhsuQxtlgUmZKOI/kuD1qWQwAihexrz/NWnN+42SWp/g5FHsfkcfVpU38YP6ehFkyhl/vdXrBX4tWjlW9r1IbzdIOjZqqHqt3X1ljs5pvwN3NNZBs+/HOH7SPJovbNDZ+p7z670=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+vn+RW4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76559C4CECF;
	Sat,  5 Oct 2024 03:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728100284;
	bh=xnB03o5wj5wkk+9w0FLxKpxojhy1VFJSSIfAcXclIOc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=L+vn+RW4m7vTnlDWpM6dhmh6kl6uSlhKXTvZTL8kgKxSlVTmM7K+LUmnAqPoyhSrE
	 mxiZRDPOR4kWv13mNhxmqTHa7dEGj8ZP5KeYMKBJ75K78L+aA/gW/KWonHWK+hbhK1
	 AfVwQ18grQRL6bVsZvFTlNjkp/QQ6yQT0ObsOt9Z4J83PfByfe/ls3AZXwugObDyQI
	 Ea9YIQCTgQ5W9pHTHxDxmN8LnLyCAzv1X6Lzch4zAykHeOepSz1VBh0vt6IAiXAIb+
	 Xc6E1I0I52o6TKwj41lk7p0CapnYRz5hBhX5bT9xVzoX9t76BFL+S0Z52kc15rRnBr
	 Rhg075je05X7A==
From: Mark Brown <broonie@kernel.org>
To: perex@perex.cz, tiwai@suse.com, hayashi.kunihiko@socionext.com, 
 mhiramat@kernel.org, 
 =?utf-8?q?=28=ED=95=99=EC=83=9D=29_=EC=9E=A5=EC=9D=B8=EA=B7=9C_=28=EC=BB=B4=ED=93=A8=ED=84=B0=EA=B3=B5=ED=95=99=EA=B3=BC=29?= <ingyujang25@unist.ac.kr>
Cc: lgirdwood@gmail.com, alsa-devel@alsa-project.org, 
 linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <SE1P216MB2287F4D575CFBDC9755E896BFD6A2@SE1P216MB2287.KORP216.PROD.OUTLOOK.COM>
References: <SE1P216MB2287F4D575CFBDC9755E896BFD6A2@SE1P216MB2287.KORP216.PROD.OUTLOOK.COM>
Subject: Re: [PATCH] sound: soc: uniphier: Handle regmap_write errors in
 aio_src_set_param()
Message-Id: <172810028220.832098.12998489877950324784.b4-ty@kernel.org>
Date: Sat, 05 Oct 2024 04:51:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-9b746

On Thu, 26 Sep 2024 21:15:18 +0000, (학생) 장인규 (컴퓨터공학과) wrote:
> The aio_src_set_param() function did not previously check the return
> values of regmap_write() and regmap_update_bits().
> If these functions fail, it could lead to silent failures when
> configuring the sample rate converter (SRC), causing improper behavior
> in audio processing without any indication of an error.
> 
> This patch modifies aio_src_set_param to check the return values of
> regmap_write() and regmap_update_bits().
> If either function returns an error, the error code is propagated back
> to the caller to ensure proper error handling.
> This change aligns with the existing error-handling behavior in
> functions like uniphier_aio_prepare(), where a failure in a sub-function
> should result in an immediate return of the error.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] sound: soc: uniphier: Handle regmap_write errors in aio_src_set_param()
      commit: 23fa0b04d3fd4b8277083e9a8abb1a975a05c837

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


