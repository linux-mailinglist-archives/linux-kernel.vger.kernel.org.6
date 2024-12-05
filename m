Return-Path: <linux-kernel+bounces-433441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2D99E5875
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 15:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D35F31884D94
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 14:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E44421C169;
	Thu,  5 Dec 2024 14:25:42 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB4021A42A;
	Thu,  5 Dec 2024 14:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733408742; cv=none; b=s915L7OuxhlHfNTeFcm9IOmiiJ8CzG1Nj516uNi9mztLYCikiaG1oxqR2MAIib5IqAzgtAuYt/b9Z7EX6Kg39lPQ73vZMzHV/jEkj+an+UKG9urIn/oAa815beCgognX33wWBO5lPBf+8Od4/D7QL8gDLa0LFNUc+nrjZK20sQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733408742; c=relaxed/simple;
	bh=58z5nr6BGX7FwFy2WQAc/WgeN7t4W80pnYi8oOtO4Kc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=T8rzkAZnk4c7JdaUWpMrRNrIHTd2sB+hKZaHmSWYvvx8uCco5VQNHw2+YTdWhoPOOVXXPpC33SXB7i6jTy4gv8MOs1mnPmrZ58hkeLzPw/fsHgaSmbOteSGLIYfOYHVAGyp3b7aWfaPMwkiyJSfNovtusTI78NAJ/i08t86AjBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B082CC4CED1;
	Thu,  5 Dec 2024 14:25:41 +0000 (UTC)
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id EB4315FB49;
	Thu,  5 Dec 2024 22:25:38 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Cs=C3=B3k=C3=A1s=2C_Bence?= <csokas.bence@prolan.hu>
Cc: Mesih Kilinc <mesihkilinc@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Maxime Ripard <mripard@kernel.org>
In-Reply-To: <20241123123900.2656837-1-csokas.bence@prolan.hu>
References: <20241123123900.2656837-1-csokas.bence@prolan.hu>
Subject: Re: [PATCH v6 0/3] Add support for codec of F1C100s
Message-Id: <173340873895.1777403.9265230616081178067.b4-ty@csie.org>
Date: Thu, 05 Dec 2024 22:25:38 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.2

On Sat, 23 Nov 2024 13:38:55 +0100, Csókás, Bence wrote:
> Support for Allwinner F1C100s/200s series audio was
> submitted in 2018 as an RFC series, but was not merged,
> despite having only minor errors. However, this is
> essential for having audio on these SoCs.
> This series was forward-ported/rebased to the best of
> my abilities, on top of Linus' tree as of now:
> commit 28eb75e178d3 ("Merge tag 'drm-next-2024-11-21' of https://gitlab.freedesktop.org/drm/kernel")
> 
> [...]

Applied to dt-for-6.14 in git@github.com:linux-sunxi/linux-sunxi.git, thanks!

[1/5] ASoC: sun4i-codec: Add DMA Max Burst field
      (no commit info)
[2/5] dt-bindings: sound: Add Allwinner suniv F1C100s Audio Codec
      (no commit info)
[3/5] ASoC: sun4i-codec: Add support for Allwinner suniv F1C100s
      (no commit info)
[4/5] ARM: dts: suniv: f1c100s: Add support for Audio Codec
      commit: 95b570f7ded1e921eb3fd256d0a70b294f31bd0c
[5/5] ARM: dts: suniv: f1c100s: Activate Audio Codec for Lichee Pi Nano
      commit: 20296f8baa25839585b9060079946f7333a5c5aa

Best regards,
-- 
Chen-Yu Tsai <wens@csie.org>


