Return-Path: <linux-kernel+bounces-354925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B876C9944AB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 11:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0E961C217C8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 09:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826B4191F8C;
	Tue,  8 Oct 2024 09:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mAfwGVML"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA29318DF96;
	Tue,  8 Oct 2024 09:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728380877; cv=none; b=Azocho4ZHr3jRkDu5pHqSLA+rCi/sOYjwMZsW+cSEUZ61sp9rAIeRgpdORvJnIh14Hl9snez4B0Ah712YQyHqMSDuopZgDETFTcpcAGc39okT76qbYUlt8Tr6VaPWMMWGA+VNVOOPZ6tN04fFJcvfLTb8iXoL2ZPr+0YM2MNDig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728380877; c=relaxed/simple;
	bh=ykHfEdBXhl1fXBnfbo9MF4au8+Teea347Ae9LYLabp4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JvUAi9G3iiOYMFfnKX57qAfKOr78Vt5T0DPGsWP0SG1zA4jvfEdCOauN/BvhN8gaxDXbQoW6hk1wjTmZWDuL5U5Up3+6vkbfI7B1yurRewbc6PLZL7ud9NZZephFmQevwXv5chUAyeZfsOkSRhh1ODQ/3wUFQ7ta0gS4xLVChlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mAfwGVML; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 609F5C4CEC7;
	Tue,  8 Oct 2024 09:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728380876;
	bh=ykHfEdBXhl1fXBnfbo9MF4au8+Teea347Ae9LYLabp4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=mAfwGVMLzJiAlIHjTdcfj2bCS5f//Oq8LHfH9ojls6gbEYbHS65QLvHAbMg86EIEM
	 XRKZBJkiPNsj49zMtC8YXY0tXnEZN5z3hLbGNDU0myId76zlo8R73AT2sYIelkIecO
	 cn9V6hZF6+FTi3Pk+4UEtzbrT4s517yG1fGMriQtGMUscV88brG5RLMJC03DFy2Zvy
	 8OxiPWOStuqDL0+OQUAiV1//nFo1ku699FxJE31Ua88KMeBZH5bLSrbZfZunwsyddy
	 4CvKR78HoY/4Ux1Q9dnOQ5aYPu/FnV9DRVf7k9C4CQftkeLvaeJAKMQSVr8GUpXetN
	 +0mDZBZDJlKVg==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, Heiko Stuebner <heiko@sntech.de>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org
In-Reply-To: <20241007205639.2477635-1-heiko@sntech.de>
References: <20241007205639.2477635-1-heiko@sntech.de>
Subject: Re: [PATCH v2] ASoC: dt-bindings: rockchip,rk3036-codec: convert
 to yaml
Message-Id: <172838087307.2574699.1959235888192800827.b4-ty@kernel.org>
Date: Tue, 08 Oct 2024 10:47:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Mon, 07 Oct 2024 22:56:39 +0200, Heiko Stuebner wrote:
> Convert the binding to yaml.
> 
> The codec seems to be from Innosilicon, but the compatible has ever only
> been rockchip-based, as they sythesized the codec for the rk3036.
> 
> So the yaml file gets a name matching that compatible.
> The only other notable change is the addition of the #sound-dai-cells
> property, that is always required.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: rockchip,rk3036-codec: convert to yaml
      commit: 5cd575a87f141e438b3e062533bf0c6cc9eba99a

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


