Return-Path: <linux-kernel+bounces-325413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B164797595D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 19:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A557287194
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 17:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F0E1B2EC2;
	Wed, 11 Sep 2024 17:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o3DiFh9u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA4A1A3047;
	Wed, 11 Sep 2024 17:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726075670; cv=none; b=Il9MN1VvkVNUL09bZy/cOomVozL57FGrIdSDkbAufxTmcTmJeJabTu0boWtDByRJuM8B4qfshBv5gkuAnqMprCztZfUFpY26MK0ShdOSd1rwJs4avinK+MayrMqcCSo2UUgc77petl3qn0A7zR3NsglsfMJEXsMDxJLBEoYeKHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726075670; c=relaxed/simple;
	bh=O4UKe6XumuijGy0HK00KGL/iMsCdMCkQHmtMALUoTHQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XQf7mKJYzfsptCZK8giRcJF6pYW8SbJ51O43ErZUez3BiG1wiopOej9AW5g6F8OQ5f278PuKDb/iVM/OeWQ139NCl9kDVFKhTYbBXzLpX2x6atVPtfLgSjiaMPsInpe2CKSJK1pbDhlUsSbts3+dTlGQSnhobgYcbZY/zG0uC/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o3DiFh9u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00C8AC4CEC0;
	Wed, 11 Sep 2024 17:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726075670;
	bh=O4UKe6XumuijGy0HK00KGL/iMsCdMCkQHmtMALUoTHQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=o3DiFh9urvSHpnRKQGRLzHjbD4JimIJi8AjKMdYtO+6Djt8sIVcw4pvCX/UsiGRxY
	 dL8S89MNs1XwtqbMNxqjNs2FDS3fd4hDzQJJX8RV/x7BNgK98o8vFbT2zDtmciuWCp
	 dZzn8+1R40vdwfzyzVjUuG2F6T4R+zduGfE4bdEXP8YCT/FAJGwSny/4836qWqn6xU
	 uZBDCQXf5EbBkNnVxADqtnK0Vr7GlwAAioMNCgunl2E6BvUSBF56t+PHEj6DU9qJLp
	 PO+9naUed9L8oA5ITltkU0QlWi055HnZLVxi6NLJz1/y1nEEtFpFeZP/fVAxDWAtF0
	 5bneWz7hkHXFw==
From: Mark Brown <broonie@kernel.org>
To: claudiu.beznea@tuxon.dev, lgirdwood@gmail.com, robh@kernel.org, 
 krzk+dt@kernel.org, conor+dt@kernel.org, nicolas.ferre@microchip.com, 
 codrin.ciubotariu@microchip.com, 
 Andrei Simion <andrei.simion@microchip.com>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org
In-Reply-To: <20240910082202.45972-1-andrei.simion@microchip.com>
References: <20240910082202.45972-1-andrei.simion@microchip.com>
Subject: Re: [PATCH] ASoC: dt-bindings: microchip,sama7g5-spdifrx: Add
 common DAI reference
Message-Id: <172607566773.120511.17439915869917323050.b4-ty@kernel.org>
Date: Wed, 11 Sep 2024 18:27:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Tue, 10 Sep 2024 11:22:03 +0300, Andrei Simion wrote:
> Update the spdifrx yaml file to reference the dai-common.yaml schema,
> enabling the use of the 'sound-name-prefix' property
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: microchip,sama7g5-spdifrx: Add common DAI reference
      commit: 448aa89af07b83be84a58155c60001743342fca0

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


