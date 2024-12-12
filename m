Return-Path: <linux-kernel+bounces-443096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3209EE71B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 13:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ED5B1886EDB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 12:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197D02139C1;
	Thu, 12 Dec 2024 12:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gKE5esdb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673BB1714D7;
	Thu, 12 Dec 2024 12:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734007905; cv=none; b=B36eNqSQdlbLC273WRBFKVLMnqHmBQKCxx+w7aRQPJHizjB6am3qPpFJ9yeNaNbY+X1BoNgXGizzfYdT9Tpy73ze1jkey4+mPSfLAnPfQUmLJkeD7rUY06aHN/eLAhpNQ/0fDKWKP9upIx/2GNZOhw7o7UflhYaFxBFFqLatx3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734007905; c=relaxed/simple;
	bh=oGXtoPx45D5829J+m52KpKDc1mjPcUrynCRTW7p6Glc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UklmdzdS4quw7gLX+4S5wFBnp9qQVRFV6snqhwzYNgwO30MGyDHgTYyUx7EEEuVRk4/e70SUoPIGXG4jPV6Wi4jl5DqIDkS1g4MVHuW713lFjQITwx0IVIr4VlTt3c8+cf6KAp2ZpIRbVzHEV/8drH+pTfGXK6DBGH0FIqVbaKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gKE5esdb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9352C4CECE;
	Thu, 12 Dec 2024 12:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734007904;
	bh=oGXtoPx45D5829J+m52KpKDc1mjPcUrynCRTW7p6Glc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=gKE5esdb+JZid2Zing04LqmZtMK4qXG6ucEdMtgrWLIFylmyLOdwvKyWvrd+pMU62
	 NNwzBzi2oD6X3zTbxqb72WqV3SXdjq5DDgl3YkVG5v6QyIpBXTQp3UcCnH9RxE5sT3
	 Rt691hmrFz3oKTXzexw21eN76rPy/qboMqzHOa8GyK5hImrOOA2pMFTyyD+lL4b1ya
	 L9wylYUB+rsepevcpuAHCEguRmlkRQ1kKq+wiWcSYR/8K5zcr1wM3tD/MuzhYnk6MY
	 K0hbAAQw3ukHfGij9cNUX4dZSfYxZzf7G7JcO9Y6cI9zr2mTmy6Zj3v1Cij8Fvy/f9
	 eTNMljcBbFt1w==
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>, 
 Chen-Yu Tsai <wenst@chromium.org>
Cc: devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241211052427.4178367-1-wenst@chromium.org>
References: <20241211052427.4178367-1-wenst@chromium.org>
Subject: Re: (subset) [PATCH 0/8] arm64: dts: mediatek: Drop
 regulator-compatible property
Message-Id: <173400790262.46374.4565987048605318462.b4-ty@kernel.org>
Date: Thu, 12 Dec 2024 12:51:42 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Wed, 11 Dec 2024 13:24:18 +0800, Chen-Yu Tsai wrote:
> This series drops usage of the long deprecated "regulator-compatible"
> property from MediaTek device tree files. The property was introduced
> in 2012, and then subsequently deprecated after two months. It was
> never carried over during the binding YAML conversion.
> 
> Drop the property from the MT6315 regulator binding, and all MediaTek
> device tree files. IMO it should never have been used to begin with.
> This also gets rid of any validation errors [1] related to them.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/8] regulator: dt-bindings: mt6315: Drop regulator-compatible property
      commit: 08242719a8af603db54a2a79234a8fe600680105

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


