Return-Path: <linux-kernel+bounces-194012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BA88D355E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 13:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80971288609
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 11:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC13416EBF0;
	Wed, 29 May 2024 11:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VH6M9Lrm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF11A282F0;
	Wed, 29 May 2024 11:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716981680; cv=none; b=n+06B7HCWpizM1WG6toUgxJ36G9q+WOv25FwrwDe0ahhxdSxuxZj3Z/t/sYcPgs3HSfOTiKL9b7/XB5a5Qg7Q0GUVbKMtORFCundL8+hf9gYCjMudNSd4rQhZGld0/BS0Qgcxrg4102TjN3dcWZ70jHGarlbbcUVeaSEXy6RnHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716981680; c=relaxed/simple;
	bh=MrsJ1zBquLOcb+TGqqBJ2fZWAs3HCnBp6Bq+t3/l6cU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RS/IhXRVx7q9Np31z7EzbSR6CXjd2oltVAaL6fjAOKYtgw5uTTzrtDOrwxoMVtfcpNfZpoDdK0LHO73jPtQkIuaUZa2EdJ7tJNc02ciH8vqMugMpRPFmL1n+83ASmJYn/qGyPpdeLyE33tWCzthCK7ABWWa/9zpD4IILCWZblDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VH6M9Lrm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35BB3C2BD10;
	Wed, 29 May 2024 11:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716981679;
	bh=MrsJ1zBquLOcb+TGqqBJ2fZWAs3HCnBp6Bq+t3/l6cU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=VH6M9LrmLf+LSZdE/r/SJl8bRgxmCqrUUtGa1Vge4KH8j7nKKbXC+zgY6UCesmZx5
	 a12QuwhVqnjVSZZpE6ITylEz1cwWazeGXutzjNSJPY1bF36my3SoOUKUJiXKOQxcCM
	 KADa4hsRW06VWs7k/qAxUwQ9GNXfIRGA5SE52ksjh0jaOIChDj1Ly7W/Ov8nIDJN0U
	 o4cnCgx+PFHqVfhZI/F5u9vM504Wozsbc4zDvA5Vys/NzYYDVB3hdJ1zdlpaJU48nr
	 ULjSixSk+7i+ZQgfdWVYBD1/hu2hZdFVPezNUQMLyb09hWZ7IH+MU1bSRc/Nj2Dy78
	 zhAuLHnrVJBVA==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, robh+dt@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
 Alina Yu <alina_yu@richtek.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 johnny_lai@richtek.com, cy_huang@richtek.com
In-Reply-To: <cover.1715340537.git.alina_yu@richtek.com>
References: <cover.1715340537.git.alina_yu@richtek.com>
Subject: Re: (subset) [PATCH v3 0/6] Fix rtq2208 BUCK ramp_delay and LDO
 dvs setting
Message-Id: <171698167685.48637.16421950159678446451.b4-ty@kernel.org>
Date: Wed, 29 May 2024 12:21:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-2ee9f

On Fri, 10 May 2024 20:06:19 +0800, Alina Yu wrote:
> This series patches is for hardware modification of RTQ2208.
> ramp_delay range of BUCK is changed.
> The maximum ramp up and down range of BUCK are shorten
>  from 64mVstep/us to 16mVstep/us.
> The LDO's Vout is adjustable if the hardware setting allow it,
> and it can be set either 1800mv or 3300mv.
> Additionally, the discharge register has been moved to another position.
> In this version, a software bug has been fixed.
> rtq2208_ldo_match is no longer a local variable.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/6] regulator: rtq2208: Fix invalid memory access when devm_of_regulator_put_matches is called
      commit: 72b6a2d6506843375c7b91197f49ef38ca0c6d0f

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


