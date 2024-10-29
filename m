Return-Path: <linux-kernel+bounces-387518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EAFB9B523B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 19:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ACCD1F21461
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 18:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310F92071F2;
	Tue, 29 Oct 2024 18:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jRya4OeQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823F5205159;
	Tue, 29 Oct 2024 18:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730228198; cv=none; b=qS4LhWFe78SYaXvL3ZWmbO3jH99aq+OlYb+jThr+tgqsVBn9izxEXJScbJRoO/KbutxAs4ssJYhQc1oY+F9SUjL47g+Y8U7aXC7wr63G8HkOFdyYyoNJXHbF8uHKKOrzreAiPNiE6MZAqYVQHXCd3O+zLQRz1gYYkDT515Qq3t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730228198; c=relaxed/simple;
	bh=9wfadzzh1VnQtg6LRhMagkiOx4YTPfzItSf0HhOo8IQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=eCYADdJHPekzbi1DmD/BiMX7X40jGYvcGwbFD65yqPPwow+jDJrfv2mBfWjWAwtzyQeNENPlyE8V4WpRgc4cXlFTMOizAsAYSa79TovvC9Ge7esmq0FUNMbrPy/jjh0VP3FTKkDtBsu6gqGAzEZrd1R7UKKc05Z+2nBMUyPyJe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jRya4OeQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1D12C4CEE4;
	Tue, 29 Oct 2024 18:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730228198;
	bh=9wfadzzh1VnQtg6LRhMagkiOx4YTPfzItSf0HhOo8IQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=jRya4OeQfmmxvY7x5muWWu5Ig00y++Aa7s6voYFgMNP3UXnJGSCy8mWcoFH9jaAaZ
	 Gevmg+OY4USApAe/g1zY9I4ULdh0eAVDgGQ9nmJ4yojmFeVFX+KEPPAfzeH6IGBW0o
	 ut0wHOK4YfEmWdpXDggEa7KjuHSH6tKxizQwstJxr69xL1tRrxEQGRR4lO3OuEbvDC
	 fU1MndB8HvLcaoFb0fUNXoc7RcGTgqNEZ8Uxq8HSCkk0sd6QFUeum0qIVk1NN1B5s0
	 GIdf5O+wyYjJvL7QY+mU4k5FzXaGGRRklfEHmuJInaFq/wN1FW/OLKeDk1Rz38C2+P
	 mEK8LAiIxd/pw==
From: Mark Brown <broonie@kernel.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Dmitry Yashin <dmt.yashin@gmail.com>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20241028213314.476776-1-dmt.yashin@gmail.com>
References: <20241028213314.476776-1-dmt.yashin@gmail.com>
Subject: Re: (subset) [PATCH 0/3] arm64: dts: rockchip: add Banana Pi
 BPI-P2 Pro board
Message-Id: <173022819553.134081.16666383098906856024.b4-ty@kernel.org>
Date: Tue, 29 Oct 2024 18:56:35 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Tue, 29 Oct 2024 02:33:11 +0500, Dmitry Yashin wrote:
> This series add support for Banana Pi BPI-P2 Pro based on Rockchip RK3308
> (RK3308B-S variant) made by Shenzhen SINOVOIP.
> 
> Patch 1 fixes rk3308-codec DTB warning.
> Patch 2-3 adds binding and dts for the board.
> 
> Dmitry Yashin (3):
>   ASoC: dt-bindings: rockchip,rk3308-codec: add port property
>   dt-bindings: arm: rockchip: add Banana Pi BPI-P2 Pro board
>   arm64: dts: rockchip: add Banana Pi BPI-P2 Pro board
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: dt-bindings: rockchip,rk3308-codec: add port property
      commit: cc8475a07cf34891bf11a63025659d3537b638ef

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


