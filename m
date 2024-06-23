Return-Path: <linux-kernel+bounces-226338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB45913D38
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 19:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88F05B2132F
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 17:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209FA1850A5;
	Sun, 23 Jun 2024 17:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b6UIZB1L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC1C1836D8;
	Sun, 23 Jun 2024 17:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719163321; cv=none; b=P2UsMwfjUN/darHonfCO8o04Is8W78Pgeiw4xg7MKOY9oCy2I1B4XGe21IsKKsDKcMSVg2FIXVsmeJVPQQLiPneZ9VJyqoQ0yYpMDpCZahBWO1MdajNGU5HDII9VYhOPjrYnWkiuZR43TtnI37kS5Vs4INEBxJPQPWNXPzpDLus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719163321; c=relaxed/simple;
	bh=8lotr6tXn4Qp6gY0zKXuh9lMrXhL0eYzc8qonNLvuVs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DKI97+U84fq4MSZvmsqq5fXWWctjH7z56CutVZbMTm5WBJITryM+nqYbwC3D9n7A75tPChcFvfxtT8IbZAQXeBPZEzntNDmkKOnBC7RTOJebr3eYW2kAx6Ujl/bcSkw1Yk5eXWPzLsVntqiz53urN63vvnl3PW2UEBlsAhAZRzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b6UIZB1L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7155DC32786;
	Sun, 23 Jun 2024 17:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719163321;
	bh=8lotr6tXn4Qp6gY0zKXuh9lMrXhL0eYzc8qonNLvuVs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=b6UIZB1LZHWCukA1n6bnDQlKaqQRocLNQW/74IcDKRXZgUqxloU3GsZlwFUBqBrsJ
	 qqKv9CzpnREbhAHgVCmyw43JSMwKIZlDiID20FlhGSoUjN9h1OVa/tyJqICECdlRUd
	 JAwFmpXdbrCkJOxCue80Gc+HES0DrCU4YX53c1VVo+EX3ozRZWKgcJ5mwDiwhk/Ug0
	 Hz4LesbpjnDVtSY2dFreeBp2XIKNIVQXntVAOGqMBOY5AKFx1qxsCwhio36StgDm1+
	 AfdmvR6Y/md8k/ghWz+FBx9Gm6Sym4K+6hDrVKjR2eEeh+7VGhIRPLprih1JTdqEJ7
	 bT8qWKr8GELSg==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240620-topic-amlogic-upstream-bindings-convert-everest-v2-0-660985615522@linaro.org>
References: <20240620-topic-amlogic-upstream-bindings-convert-everest-v2-0-660985615522@linaro.org>
Subject: Re: [PATCH v2 0/2] ASoC: dt-bindings: convert everest,es7134.txt &
 everest,es7241.txt to dt-schema
Message-Id: <171916331917.350242.13889976308309993495.b4-ty@kernel.org>
Date: Sun, 23 Jun 2024 18:21:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Thu, 20 Jun 2024 11:39:56 +0200, Neil Armstrong wrote:
> Convert the text bindings of the Everest ES7241/ES7134/7144/7154 2 channels
> I2S analog to digital converter to dt-schema.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: convert everest,es7241.txt to dt-schema
      commit: 78df231dae2e1a9bf22f76b5cf03c0bf98738fd7
[2/2] ASoC: dt-bindings: convert everest,es7134.txt to dt-schema
      commit: 534a0e5e737f8117344372d8658a4702ae816281

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


