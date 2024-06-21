Return-Path: <linux-kernel+bounces-223755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2069117C9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 02:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 873C12819E3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 00:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5589137E;
	Fri, 21 Jun 2024 00:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u8aEH1qU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AF43C2F;
	Fri, 21 Jun 2024 00:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718930943; cv=none; b=gvbDphFUj1/MiTRDLOGTJROb1eU8Zo72eVa1umbD+CAT88pMZftQUENMa+L4RQHn//+IK8Yj5KItrLv8FuNKFDaqIs1ZSRGN3WjzU/WJBSKYnQUfSue56FEPs7Vgh/gdFE6/sXt3bhDb7UMZ4wH1nGYaVUr1+EwaDWAQ2nNiCXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718930943; c=relaxed/simple;
	bh=BiQhCePJJd/KvSg0UgryJ7S8lCqzOeGVDO+ulriZ+ek=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hrKXtqR6w4cUy7h17eaKx20iusi2gHKJLJhobBmbk08/bWyF7vHE59eWBs/chvRmmD6l7J8ZWlguqISkkvWvmfXVTS8bUCcigO6BgFbB/gTMKf54wvWXsx3+dn3RDiXBAfWnaddAMdyksTbGdJ34owzMs2HhP+si4fEuEykb3I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u8aEH1qU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EDF1C2BD10;
	Fri, 21 Jun 2024 00:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718930942;
	bh=BiQhCePJJd/KvSg0UgryJ7S8lCqzOeGVDO+ulriZ+ek=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=u8aEH1qUc/LCdLHqBDh+t7H2qXdlxsi+hS9lIvRp7xQrNo/DcvZZ1GdhB/ZrFTVvb
	 TREAgTtHyD8az2nIkLQc0IpnI9wAMYxx582HZ4D4gg+hOIL7Iy91RlE0PC+DCOwYQ5
	 9K32J9IZ+BjsUgancdVmLLTOw2WpN2JzAgaG0np0TgVTF804KMPTgDBedxS5ZB3OYc
	 3kLPPpqdyQUuCllHcoE9LOuScG4N1dqMy2lEKlC3CdDCKq4Au+JoWmWAt0vRdSJDot
	 TItQlahLGcIY6iMN+f4BZPDIMTUD5G5CyIY40TpuXbd1tW73UlkZ8BhjVMLOC9hR5U
	 SXUqwuXtae6yg==
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>, 
 Chen-Yu Tsai <wenst@chromium.org>
Cc: devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240620094746.2404753-1-wenst@chromium.org>
References: <20240620094746.2404753-1-wenst@chromium.org>
Subject: Re: (subset) [PATCH 0/3] arm64: dts: mediatek: Add MT8186 Voltorb
 Chromebooks
Message-Id: <171893094009.286783.6584763337748943231.b4-ty@kernel.org>
Date: Fri, 21 Jun 2024 01:49:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Thu, 20 Jun 2024 17:47:35 +0800, Chen-Yu Tsai wrote:
> This series adds support for the MT8186 Voltorb Chromebooks. This is yet
> another product based on the Corsola reference design. This particular
> version features a higher end spec-ed SoC, necessitating a beefier
> regulator for the big core cluster.
> 
> Patch 1 adds an entry for a new regulator IC. How this differs from
> the previous iteration is not totally clear.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/3] dt-bindings: regulator: mt6315: Document MT6319 PMIC
      commit: ffe4b381e2ea97c7a5868dbe841c7522b1b0b408

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


