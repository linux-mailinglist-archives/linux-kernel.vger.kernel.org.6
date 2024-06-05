Return-Path: <linux-kernel+bounces-203313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF668FD93F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 23:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D19691F225C9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 21:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8844816190A;
	Wed,  5 Jun 2024 21:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TKdvPWUa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84FC15FA73;
	Wed,  5 Jun 2024 21:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717623507; cv=none; b=MULyO6OdgScHwxiJhQMN89EApv3IHXxLUG7CehLKdlVHa0CgeHZ4TnuDbNmbJhk12nzMGNiSUYZ8LdUZ9x7IAUviEeuQRsIZQpcE51Ui3PhwqxkEQEN4PqWtluN+IPkW68UMaF0uWg3/PKAPYgUcElqmN/f5N7jP9IiEWFF5MqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717623507; c=relaxed/simple;
	bh=8hay60Greow1omChJOGvvYkdjMVtVCAHBT0W/Ohlr/Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=vCUT9GV5kQo7n9k0PhPtVWrxMjXEN3Tcd4dcpZX/z7uGZmaNrKb6lIn70o+oRoqUPQlWVhRmSVMCFPvq+Pu6oPyfzNKYvYO6+7RjzLPh4SdnIpFxzk5znfnknz74uOQoTW3T7z6E80j+cRB1hQ1WHtalqhRwvjbdf7nq/x29RPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TKdvPWUa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E725CC2BD11;
	Wed,  5 Jun 2024 21:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717623506;
	bh=8hay60Greow1omChJOGvvYkdjMVtVCAHBT0W/Ohlr/Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=TKdvPWUa35aZm/YidZOLUclkifjdNdJ4sK3LN9XTkOV+0/UEqGfwMZKdwZZ8rZrMK
	 zrCngkF3t4ikRnDHdIrvv5atgc/esY7h1Te52fLbSeeYgGH8MAZa6gsBbd1K/pkIQ8
	 q8XDwCyb4aInC9jaOC2UQ6uJU4G2h8MiG7DIXDIVDHVZ+mZ+Cnb1A0+1RRw6H18gHK
	 YIY9TNXKJMtFfh5DPvqaYQSOMt9vljSO3ZAFnfhtMcYtSkxJk67b4ddmy8LdbJM1pA
	 dIiG689+qgW540wYbbt1x9IOP4B+9Bzc8/8Os8z/sNNuSURDxY9hbn7h4oCMvmtt1k
	 A4/iWSdPf3IIw==
From: Mark Brown <broonie@kernel.org>
To: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, 
 Baojun Xu <baojun.xu@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Ricard Wanderlof <ricard.wanderlof@axis.com>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@axis.com
In-Reply-To: <20240528-tlv320adc3xxx-dt-gpio-fix-v1-1-209fb2c2f86f@axis.com>
References: <20240528-tlv320adc3xxx-dt-gpio-fix-v1-1-209fb2c2f86f@axis.com>
Subject: Re: [PATCH] dt-bindings: sound: tlv320adc3xxx: Fix incorrect GPIO
 description
Message-Id: <171762350367.565712.5511446466309082536.b4-ty@kernel.org>
Date: Wed, 05 Jun 2024 22:38:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Tue, 28 May 2024 17:40:04 +0200, Ricard Wanderlof wrote:
> Fix the description for the ti,dmdin-gpio1 and ti,dmclk-gpio2
> properties to correctly describe that when configured as general
> purpose outputs (ADC3XXX_GPIO_GPO), the pins are available via
> the GPIO framework.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] dt-bindings: sound: tlv320adc3xxx: Fix incorrect GPIO description
      commit: 39d762edd1f353c4446dbce83a18da4e491cc48e

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


