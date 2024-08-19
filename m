Return-Path: <linux-kernel+bounces-292744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5069573D5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 20:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 303221F241FE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 18:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DB218991D;
	Mon, 19 Aug 2024 18:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hXu2LxOw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F61181B9A;
	Mon, 19 Aug 2024 18:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724093125; cv=none; b=GocLKKdQBXU8TH8OvqVxTqwgEel0Zc9440b6zW5NjMtzdwqtNDGxVbjb2fVxXRitoKtYRRHCffeL5zV9r/t9I+3TJUZ8mmUGm96nCP2py+HycqrRI44lZWofPpciBKbT+bcaUFDy4uNE5VDqyM/Bb83T4hKzh/uyy74gtG8QiKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724093125; c=relaxed/simple;
	bh=gU0/EKnZ0FkuHkxxhgkNiyKt5kHXaxnPAjw+Ang2LMs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qzrj9W+A7AsFa8DCbxOOR2ygIMBdlbDe2VAXJXNgDm8FYqQMBBdvKRPVBBO6H5Hi4XrFJcevw8A8pcEw/QQoGfsEK582+FlXIZNxzq35WPTPAYCT+Sfglazu5ucKRLNFrh2QRQ/NJS1n8Pz8oHypkAA3A4nuZyL4tVhynZjWi+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hXu2LxOw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D10BEC32782;
	Mon, 19 Aug 2024 18:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724093124;
	bh=gU0/EKnZ0FkuHkxxhgkNiyKt5kHXaxnPAjw+Ang2LMs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=hXu2LxOwp7l//53NucZem7LHWkGWhAaN14DjXkA34y5aMxMkcWlV5TFjJLLp2tC4K
	 nvPJ3ltQW+kSFScKc4A2VYviqQikEfXyGeiUhG2NaEGCoARB/pfTWr//XSmooCHfwk
	 /GtkRg8PpfRSpCWErPT54J7fQkFU6S7C/BDP+6f7i9NkhS6Gmtp0lLOznEJLgF661V
	 mtq8S0Hx18SntGHiCB9mjW4bTyfDcnOYDaMKECq6bmmujDpUOsiz49tQ1sCbZojyL4
	 KYlpxyu0pU5wtmk/1u5vK90Wy1xLCEofKCHwFsF4S2lBzLdfLQIKbU83eMhpAKvybJ
	 zWip5I9NT6wyQ==
From: Mark Brown <broonie@kernel.org>
To: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, 
 Baojun Xu <baojun.xu@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, alsa-devel@alsa-project.org, 
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
Cc: imx@lists.linux.dev
In-Reply-To: <20240814174422.4026100-1-Frank.Li@nxp.com>
References: <20240814174422.4026100-1-Frank.Li@nxp.com>
Subject: Re: [PATCH 1/1] ASoC: dt-bindings: convert tlv320aic31xx.txt to
 yaml
Message-Id: <172409312157.107250.1290467548898227873.b4-ty@kernel.org>
Date: Mon, 19 Aug 2024 19:45:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Wed, 14 Aug 2024 13:44:20 -0400, Frank Li wrote:
> Convert binding doc tlv320aic31xx.txt to yaml format.
> Additional change:
> - add i2c node in example.
> - replace MICBIAS_OFF with MICBIAS_2_0v in example because MICBIAS_OFF have
> been defined in header file.
> - add ref to dai-common.yaml.
> - add #sound-dai-cells.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: convert tlv320aic31xx.txt to yaml
      commit: e486feb7b8ec04ec7cd53476acc9e18afd4a6a7d

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


