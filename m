Return-Path: <linux-kernel+bounces-564578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8EFA657AD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7ADA3AD1B9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 16:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB43D1917FB;
	Mon, 17 Mar 2025 16:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DwMYsgFc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3300A79D0;
	Mon, 17 Mar 2025 16:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742227897; cv=none; b=QaFAxiAYoJ/AWf4CIKief+GAxV6x7Xphc50Fm+PgstNzi510nHHoDvtDPAHEoHiiDwE5uQrj5B/yODRnZe6mhKXjnvziRGkbKXnUOVKdcl1svuVmuNkLCmrcDFH+aLCElmINeJDPTGc6EDiPyNONkqEs05qjrd4bMM1PnW5T5UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742227897; c=relaxed/simple;
	bh=UrHcn1nbAetxuzQy2f5hJefFTlQfWTnGPCmini0of54=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mTDNsi46ts8dQdxiuHzfxXNs3roJ2ZHOahht0djn2SlAKZuEKpUW9kZrWpCre5jBzuilXmCQislM9MeHpReBJApsKJ4wvx9vAcLH/Q0gBxcQ8t7GrUOBfP3Te+5CATgGfvpdNI+npSGZJXNQGE6iBnzw7akcPeALEOJqij2ZJpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DwMYsgFc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44E33C4CEE3;
	Mon, 17 Mar 2025 16:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742227896;
	bh=UrHcn1nbAetxuzQy2f5hJefFTlQfWTnGPCmini0of54=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=DwMYsgFc6rLN4zZ3iuff3Tm2tgm9Q4tSMGhW7Lqy8g0xEpY6C+gRrcdPN5NGM44iG
	 waCBYhtJgxXwXeLxCR7UGbmu5jGaIZYZ23Jr6L9oAfaDiMH7sPI64ee9mx0KcpL7XC
	 +QqKqnSuZvmLhzsdoMKE/GGGNtcMJNO0cq9LG/9j8ZZQh+EFqeVP0Ap7r2EkYcnzAl
	 eAmqZQDM7/uUmuRyJU4mwZVM9CRAPcLFck+It49GjoJrqLbPRYW3qYw+411ASxrlnn
	 ZKXKoQv2xm4UkBCDMVXi1kxt6dliMt6+I9IsDdOqo6/OuBoKgAmrGtI8XQiL5RxrP9
	 oBhe5WLF1KdbA==
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, cy_huang@richtek.com
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <cover.1742204502.git.cy_huang@richtek.com>
References: <cover.1742204502.git.cy_huang@richtek.com>
Subject: Re: (subset) [PATCH 0/3] regulator: rtq2208: Fix incorrect code
 section
Message-Id: <174222789497.223336.16672496286681303116.b4-ty@kernel.org>
Date: Mon, 17 Mar 2025 16:11:34 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Mon, 17 Mar 2025 18:06:20 +0800, cy_huang@richtek.com wrote:
> This patch series is to fix
> - buck converter phase mapping
> - Correctly get LDO DVS capability
> 
> ChiYuan Huang (3):
>   regulator: rtq2208: Fix incorrect buck converter phase mapping
>   regulator: rtq2208: Fix the LDO DVS capability
>   regulator: dt-bindings: rtq2208: Remove unnecessary property of fixed
>     LDO VOUT
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/3] regulator: rtq2208: Fix incorrect buck converter phase mapping
      commit: 1742e7e978babb0f548f85c4c6bcfebe13b88722
[2/3] regulator: rtq2208: Fix the LDO DVS capability
      commit: b65439d9015024c37c6b8a17c0569ec44675a979

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


