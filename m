Return-Path: <linux-kernel+bounces-250771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6F592FCA0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 16:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2702728337B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 14:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A642171E69;
	Fri, 12 Jul 2024 14:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PvT20OK/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A360F16F910;
	Fri, 12 Jul 2024 14:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720794836; cv=none; b=mIa/68svRYPUSZX+O3XV6abXdLQxEbhDIUXqAvq19WtzlyVKJ19dx/6txQUlKSBQsJZ6HOdDQp2igWHzyyjjtqIKWISj3unsADAEXn7QVKMDFwDA8FZxwn5HfT9VLa5LXdeUtD3WdqXkmD5nawhxWmg1FIN4gT10ZXHrH+4TKsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720794836; c=relaxed/simple;
	bh=gQcrFDGWggoe/ec5V49afFn7kmx2z7nIu9TGMMaHQNU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cbqEwYmkMLVbaXqn0hunVIeIoCHRSAe0DVPC1giYEcxaXMNE42dS3FTBp+bxBjPAOrb/xUiH+NdeWgZon4q8WdjisbldA2RhWn5W6QZeebMmShfcteM2BjAgT36xgrzQrTsmltyjC5/Ab1MUKjC76MHOuCvfjlvRUnYpqmmQuAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PvT20OK/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6BAEC32782;
	Fri, 12 Jul 2024 14:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720794836;
	bh=gQcrFDGWggoe/ec5V49afFn7kmx2z7nIu9TGMMaHQNU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=PvT20OK/LujkSr3zquhW8ndmrLa4t0AyCFlAouH+u5qUV0T/+wbBZdJoOaOJuKUOf
	 4xTPxY0rc//GzMP1GafqCstvmgMWh8cBnEBd4Nret4j3BtekCML+ARJ30L4lerVMYQ
	 TZB5Xf+axxgkyW4vKKW+ktP4lLeIcKeq1VP5kqEmUWhAjlopTl+oZhkHjYub/yOS4c
	 7ecO/8T/xtRH08WFSwtC8GAXMT6qQ6R9FpfkuOStenSdu6PwkFXTI/C2VS3NCUSH6W
	 ducD/AsLjlJqKboNh9rDvns7ChSxNig8z79oVg2oDz9CWMFj/mSCa1taF5th9AiONW
	 PmErLVNm/5/Ew==
From: Mark Brown <broonie@kernel.org>
To: Animesh Agarwal <animeshagarwal28@gmail.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>, 
 David Rhodes <david.rhodes@cirrus.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, patches@opensource.cirrus.com, 
 alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240710072756.99765-1-animeshagarwal28@gmail.com>
References: <20240710072756.99765-1-animeshagarwal28@gmail.com>
Subject: Re: [PATCH] ASoC: dt-bindings: cirrus,cs42xx8: Convert to dtschema
Message-Id: <172079483344.520799.13382073069252399762.b4-ty@kernel.org>
Date: Fri, 12 Jul 2024 15:33:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Wed, 10 Jul 2024 12:57:52 +0530, Animesh Agarwal wrote:
> Convert the Cirrus Logic CS42448/CS42888 audio CODEC bindings to DT
> schema format. Set power supply properties to required only for CS42888.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: cirrus,cs42xx8: Convert to dtschema
      commit: e3fff693da9fa0337d98dab496db3a04c5227aae

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


