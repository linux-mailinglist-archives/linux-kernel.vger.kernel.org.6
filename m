Return-Path: <linux-kernel+bounces-324765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B1E975098
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 13:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 572111C2262F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 11:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC37F187352;
	Wed, 11 Sep 2024 11:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bt9tN10W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31380153BC7;
	Wed, 11 Sep 2024 11:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726053364; cv=none; b=eouZvgFeqjOxdKon6fDlcpRWosI0uJv/jzdmfaXQDZnlMRkezXImTSM6HFsgzVtFNBMUQSG/VL8/2f+jr/+3nRo0s8TS840bMePxoy+NdSjN4+PcBDiu28S9F1MS1Z2fmpU0Az0I3dKwg9o5LuVE1X3SQ4/d5185WwGEzah93u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726053364; c=relaxed/simple;
	bh=eKrbjaomEDXQn1d+1L+LNn3HUG2MOI3OG6WLs28DAzQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FYnGLqH+jtfcDsV0ejXhIzSQse8gXMJ/CzhmzMN15jthflwF1egc9RiBUENk9E9BjOCgpwPE4u6rojO2BnYtBZ/1ALn6lyVDg0LJ1479ueSBNPNoIZ+6cZgmK9la/FIVuB61d7ICBCqhguw6CbCIGQbqCCQ7jDBsP188dRO536k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bt9tN10W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85D87C4CEC5;
	Wed, 11 Sep 2024 11:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726053363;
	bh=eKrbjaomEDXQn1d+1L+LNn3HUG2MOI3OG6WLs28DAzQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=bt9tN10WpAwempYNP/4YfUhRmUL3d2fUlMV+8kh4Y9rjgoD9i8zXijycuK9Uoy1IV
	 TBYSMwAutvstlJ/rR6nflCdeBac/aAFoCqyddErCMHJdbSevQrSd2iUnMcSpYynC1i
	 4Im8tpAw10qgx7GIfLHg99+j5FutpHffCr1Ucg7fA+FINfFPPl/AFPnPz5fDX1xGtd
	 EVyxYhxTNi7fGjNtha30Nrg/6gcFtM2MqQDLwgvFobjgacO6wT3epyUEnxguh9+gS7
	 czAlALC7D1x7c3HKeyn81u58ALWZWuq5qSro8V2pdI8h6/09AfS5EMcRITisn+5dmG
	 /9WJBKUQFijOQ==
From: Mark Brown <broonie@kernel.org>
To: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, 
 Baojun Xu <baojun.xu@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Andrew Kreimer <algonell@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
 Matthew Wilcox <willy@infradead.org>
In-Reply-To: <20240910211302.8909-1-algonell@gmail.com>
References: <20240910211302.8909-1-algonell@gmail.com>
Subject: Re: [PATCH] ASoC: tlv320aic31xx: Fix typos
Message-Id: <172605336126.29902.15923004900083559208.b4-ty@kernel.org>
Date: Wed, 11 Sep 2024 12:16:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Wed, 11 Sep 2024 00:12:41 +0300, Andrew Kreimer wrote:
> Fix typos in comments.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tlv320aic31xx: Fix typos
      commit: 69f3014248f0f10e24f07a66ae650061ecaf732b

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


