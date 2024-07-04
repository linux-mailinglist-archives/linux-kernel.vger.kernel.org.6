Return-Path: <linux-kernel+bounces-241319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 480969279B6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 795011C23A6C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 15:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98631B0124;
	Thu,  4 Jul 2024 15:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ljvH83bk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329251B013E;
	Thu,  4 Jul 2024 15:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720106055; cv=none; b=YB55LGziWTAexcXZRQMtp0YaJIlEkBWkELma6/ixiLm4gdfuhGpg8pzY822MnMKx69RxebOygDJy5w74d49SyN8NblaNiO8PMBQhu2ePz0XSSGJ1KfNA+gdHikvQXtGZ/yQBgOd2JuJgZpz8R0XC5MwTCEB10VNDzZDochX0kkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720106055; c=relaxed/simple;
	bh=7VKCl0ANeLlZNUXeoeWD7I9NeKOT1/lix9behB2i6Bw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=W0ew6y7WavNndX/QvoR6A/K4b4HtBe293dbW793tbrt6UDgj9x593WywakkBuFznm78tHpPYu2lDZJtKXxe+aNOmiSZwMSg81r1Oh1PfaGirWcN19+1I54Nn9rAQT1luRQQp0JDteBu5H6lfMtZlNFJnxqB2zS4/FriFxsnfB+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ljvH83bk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E730C3277B;
	Thu,  4 Jul 2024 15:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720106054;
	bh=7VKCl0ANeLlZNUXeoeWD7I9NeKOT1/lix9behB2i6Bw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ljvH83bkA2QRkEXvlGZru55/g3h/4kPxQab8EmulHc5P6LK/uuV9pNTiCNIw+y40G
	 I4Q3KHsg4eaOQyVJw/KgSsN3Sfjn1GmAL1yjsphDsAuTXXkpWeP0oxHeEp0rilqrXx
	 otNywCZZv06PfbPza5zPQiA3hHbJoLHSTJ71zmrMuBCzwMY0ydEDaFmZinD/U4yp0J
	 cykes2QMzcx6G2spstO0BDAUsdag1DWRkbDddIxt7l2l4qozIV5gQNekLs+bDhs8w4
	 N9IL8rQACLGhhK3usw6pRGSQjvptLM2fhCEGCeVyysx0w0fcmrzOlpLrJjRknvzU5s
	 kRi4rio7NYLrg==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Stanislav Jakubek <stano.jakubek@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>
In-Reply-To: <ZoWxnEY944ht2EWf@standask-GA-A55M-S2HP>
References: <ZoWxnEY944ht2EWf@standask-GA-A55M-S2HP>
Subject: Re: [PATCH] dt-bindings: regulator: ti,tps65132: document VIN
 supply
Message-Id: <172010605276.69326.9636234013507796222.b4-ty@kernel.org>
Date: Thu, 04 Jul 2024 16:14:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Wed, 03 Jul 2024 22:16:28 +0200, Stanislav Jakubek wrote:
> TPS65132 is powered by its VIN supply, document it.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] dt-bindings: regulator: ti,tps65132: document VIN supply
      commit: 82fe56c6fe02fde86784bad7f59a340306967efe

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


