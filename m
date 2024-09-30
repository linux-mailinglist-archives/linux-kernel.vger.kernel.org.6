Return-Path: <linux-kernel+bounces-344855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8456D98AEFC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 23:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B54651C213B7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 21:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3291A2C3D;
	Mon, 30 Sep 2024 21:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L1Nxf/gt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0885E1A2C24;
	Mon, 30 Sep 2024 21:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727731593; cv=none; b=E9TUnDmU3HtwzCQsbqTmjITL6LDsOHnAtlI624HjSTS1FDQ1cWDn8FG1QR6kkxx5rADdWyZRStSwCeADLYusNfpSBZK5+YP/4bC8fGNAkr6e3OFKUQJSNhAmmoW3idYe9OR4wzIILeb4CbhVSLeOJc/FMr+14/0Ulsvcn/g0abo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727731593; c=relaxed/simple;
	bh=3V5RK7vBNv1esonI1+GJwEVtF3mnPRsHJn3lEIJVWco=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=e24LqL/b1Bt6uVifaUdwcy3kPbHNNVQSvB2VTh/gtV/zMgP+nO72gYFDoGvcMWk9m3X3h7bc+JleCyCdwgeSJgyJjkJQzN6sG6KEAFVIoOQICxUalo+UKXQDotFBw7uNCk7ydr1VMtREJHqs5eJTaUH+8Ph1bzIWaGAjaqU7stc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L1Nxf/gt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2008CC4CED2;
	Mon, 30 Sep 2024 21:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727731590;
	bh=3V5RK7vBNv1esonI1+GJwEVtF3mnPRsHJn3lEIJVWco=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=L1Nxf/gtVjBNSQm9ZtPCZRNcqCO2MaLm6ioqh+jC3gAvdNxMVXkBw2pxy0TzsEfcq
	 KdwbCjgAP2DVpD/0bq3X03+zATJ4AWc/ErZl6ZdJOksgHelVVIngpC5DwNf/DrBvXn
	 9cNl+SI/TPx2b+zp+NR/23MosviZin4/0gbTlCg+21z2nEGa//kp8TKv3Xzjl18mUw
	 4I46kjUCjD5Mt+cx/EsGVrkSe18qwVL4qRU+RSTCzM/Ht6xr2nLZ8paouvilQEIYNV
	 v2nlysMQ1FpGP/nwo1YegdXzXvErkQdOME3o62Td2OXx2DyKR6EoW8jcsvpWNUhv/m
	 1s5fOhdKwyx6g==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240911-topic-amlogic-arm32-upstream-bindings-fixes-covert-realtek-rt5640-v1-1-6b3745e34540@linaro.org>
References: <20240911-topic-amlogic-arm32-upstream-bindings-fixes-covert-realtek-rt5640-v1-1-6b3745e34540@linaro.org>
Subject: Re: [PATCH] ASoC: dt-bindings: realtek,rt5640: Convert to dtschema
Message-Id: <172773158891.2197048.8205687551751490665.b4-ty@kernel.org>
Date: Mon, 30 Sep 2024 22:26:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Wed, 11 Sep 2024 17:34:01 +0200, Neil Armstrong wrote:
> Convert the RT5640/RT5639 audio CODEC bindings to DT schema.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: realtek,rt5640: Convert to dtschema
      commit: eba5a0bac211075b9673139df42bab955e984fce

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


