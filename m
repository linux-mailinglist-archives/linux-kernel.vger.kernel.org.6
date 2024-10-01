Return-Path: <linux-kernel+bounces-345750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B9898BAB6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 13:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1AC7B21AF0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 11:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15F61BF7E8;
	Tue,  1 Oct 2024 11:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IFB+tdt/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BED1BF33A;
	Tue,  1 Oct 2024 11:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727781220; cv=none; b=d016J+DbqI9lbJBwEM1O7HwQFedYLxeLwT/6AlgxNWi9FCYisxHOKoSAhRU5DAZ7YwpuxbtZs03A1hFDVrK2c8YV4FujVbS3LJmqrW+4okfAUP7rI7Kqy7Znnf++rch18G/slYEPLrBfRl3IX0iF7M3aijEJgy92AUK4f5Ppvr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727781220; c=relaxed/simple;
	bh=lPXeZRkpEt7WUNU5nhjY9mrKHBjxiap39LWea4BKxgs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=e+vOFHw4EHpuCxNsYYaT0vIj+hzwwnVd0ewPZ+CS+KPG5S3NDio2y3rEWYYRn3gufFSf9k9X6oXVhSOkMAiJ/f59wmCc62mbxtYA4SvLE9wDXWdMKvmmBHxGL6CTHF4v+65V4Med8pFxPmaSfq43JktJrryZNrArfELywdOmAIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IFB+tdt/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7155BC4CEC6;
	Tue,  1 Oct 2024 11:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727781219;
	bh=lPXeZRkpEt7WUNU5nhjY9mrKHBjxiap39LWea4BKxgs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=IFB+tdt/AemK7nQqXrUKwZYq+L4x21aly2yUZSuYAQAJSKUZzP016t+duHpsHoSXf
	 sEvoKWeBd638UgUts56fr7MXm/nA9wljMhwy0+Ds4+HSdaARjLz/hApBviIjgVrJC+
	 FGPZmfZqfaCyC8ewyW865LrK3CGWPWwyMFDLZxUoTnjkqbNK7XC1gmpVJomGJpQxxK
	 KtdjjYNDCBxF1EQFD7tBoIs4iwiWe6iRv83RAXwapoH6Mwf8Qa7Ndi3ZFzHuhpVf8a
	 JwO5t1QryHCADLTMqpQk7SOxQAp+LnKouwmPKkU8MkRVxzh9gD58DY85WJe+9Z4kgR
	 KXMsWQYQJc/Ew==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 Alexandre Mergnat <amergnat@baylibre.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>
Cc: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>, 
 Macpaul Lin <macpaul@gmail.com>, Sen Chu <sen.chu@mediatek.com>, 
 Chris-qj chen <chris-qj.chen@mediatek.com>, 
 MediaTek Chromebook Upstream <Project_Global_Chrome_Upstream_Group@mediatek.com>, 
 Chen-Yu Tsai <wenst@chromium.org>, Jiaxin Yu <jiaxin.yu@mediatek.com>
In-Reply-To: <20240930075451.14196-1-macpaul.lin@mediatek.com>
References: <20240930075451.14196-1-macpaul.lin@mediatek.com>
Subject: Re: (subset) [PATCH v2 1/2] ASoC: dt-bindings: mt6359: Update
 generic node name and dmic-mode
Message-Id: <172778121572.2280749.3048462139330835631.b4-ty@kernel.org>
Date: Tue, 01 Oct 2024 12:13:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Mon, 30 Sep 2024 15:54:50 +0800, Macpaul Lin wrote:
> Some fix and updates in the following items:
> 1. examples:
>    Update generic node name to 'audio-codec' to comply with the
>    coming change in 'mt6359.dtsi'. This change is necessary to fix the
>    dtbs_check error:
>    pmic: 'mt6359codec' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: mt6359: Update generic node name and dmic-mode
      commit: 4649cbd97fdae5069e9a71cd7669b62b90e03669

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


