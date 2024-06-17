Return-Path: <linux-kernel+bounces-218015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF01A90B800
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 19:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 610C7283276
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 17:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4478516F0DD;
	Mon, 17 Jun 2024 17:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H8VsfgaB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F72171E71;
	Mon, 17 Jun 2024 17:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718645201; cv=none; b=f2u9/AQs9iGHuotxTirciI4s323OFSCDAV5thpuG+3OOkAE0+oALZa8uDZF/ehB5p4RmbMBknosde5XJoVtOxY3S+ReOuklS9h8tDtOlKrUV254zca4dxv0YKMMDhk7YTUVXRPieXVMXi5FKfrqVaHvCr+iLuTV78EosJeJTE+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718645201; c=relaxed/simple;
	bh=71HffJ+XEI3ngVEa42GGtWC/vp+0n+DShaElYCkRY/k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=N7zeL4ObczNP451VmitBGQB1n97GRCYjFtclN/PFnb4ox+hrWNfPpnZSIIH1fV2+pjdN0uaGhZlmbdCyWtGiwKnH2kSsfSf2hj/hMl6n5YaGtLEG0YBecqYRndAXvMmBvAZWPrM5ZDAGE2gzXZo+B4+UVlC1jzE6ONnhPmv55Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H8VsfgaB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 979BDC4AF4D;
	Mon, 17 Jun 2024 17:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718645201;
	bh=71HffJ+XEI3ngVEa42GGtWC/vp+0n+DShaElYCkRY/k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=H8VsfgaB2WEFCGtJBEAV4TMvnIXtCZPDMf5LGnmf2ZfcYLgdLZ/m3hOhDd0qtExM+
	 hlM+QhC5/eCWoTYWREuNrhHwIfszfMvcSNnyBllsvcN4pfw5vngUXkCdOI2fAnTFeJ
	 AssS+fLY3x8M0AS3L++wspOvfdM1Ee8xzrgcfXB14qNhv2YsJTPbdoihg10AtZfDky
	 cb83OM95ELpw9AICQSAX4C95b/F/SSGxiA7Y2M9QGx31c4s2VnALlQPUBwkixdieAZ
	 vguQOaJodrB4CPNoIGZXcqT7WI5KO3fg1PXr1aj6RoycH3kteAeFp7bvxjydWtjKcF
	 SVCJ/wMzAGCrQ==
From: Mark Brown <broonie@kernel.org>
To: Animesh Agarwal <animeshagarwal28@gmail.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-sound@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240616095223.260786-1-animeshagarwal28@gmail.com>
References: <20240616095223.260786-1-animeshagarwal28@gmail.com>
Subject: Re: [PATCH v2 1/2] ASoC: dt-bindings: realtek,rt5514: Convert to
 dtschema
Message-Id: <171864519820.209755.15379676298751564791.b4-ty@kernel.org>
Date: Mon, 17 Jun 2024 18:26:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Sun, 16 Jun 2024 15:22:19 +0530, Animesh Agarwal wrote:
> Convert the RT5514 audio CODEC bindings to DT Schema. Make bindings
> complete by adding 'spi-max-frequency', 'wakeup-source' properties.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: realtek,rt5514: Convert to dtschema
      commit: 2618b2ec8d140951588e4b4c8dd745676427d2cb

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


