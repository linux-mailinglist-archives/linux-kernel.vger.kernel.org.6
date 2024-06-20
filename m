Return-Path: <linux-kernel+bounces-222834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D020910866
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 16:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD422283174
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 14:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D7D1B1402;
	Thu, 20 Jun 2024 14:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H9zGwtEn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F741AE090;
	Thu, 20 Jun 2024 14:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718893850; cv=none; b=X9HxKPIVXUQm57qIMKvPJ2t9do2kgWvgoX93OIKeVVX3mN7XXFDPWxrsLqyHVzDftvYYvmJfYbfNeXw2O/YRD19vvR+yAizC37K5UuVT0/NcysL2ddxbkSQxXwmk073CZTN1GhApxiq/rMnMtZo7MUGAHPydouCu8MvuTdEjKk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718893850; c=relaxed/simple;
	bh=GSvQb7WiWEZF+mLME5mkvQ7cK5Sd/yBu+9dT+dQ0Ox8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XyaAWHQ1Ions/kzbtoSIair7MfxgheFyHI7MLUMfAliVt2FbZ8aOgOcnTsuGDBYiA7CXM88Zyp8/LNr3fveul63gkf6TWZLwAt+qnGxNYJZoroa/Zu++wbsabazlFfe4meTbJ8oa2LvUklq0D29h6oRJkzCbSt7MIr6sUM6wmV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H9zGwtEn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8B22BC4AF0F;
	Thu, 20 Jun 2024 14:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718893850;
	bh=GSvQb7WiWEZF+mLME5mkvQ7cK5Sd/yBu+9dT+dQ0Ox8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=H9zGwtEnufkyKGQ5eGmfGkIcCmDXcMPxhIn4Ii/W0SjTXUfo+QWzPyheXGTzX1Fyn
	 +PC0CNdpmREFmCKt6Bp+RFk58Z8HGY7/PEtTb6kAdBmo9zEERkktbHK4G8hzNvk8Pg
	 KCS/zqYdVANCzzLvJsMwsRO7LNleD64+CPPgvFdwH26dSDZ/OVy0B4GzO2oeu6+aFA
	 nQD9stiFOYajBVIVJ9bYhQBcGwIy9nmqIPNIbotTFHl3hu5Kxk8JpF43Z7hI7qVO+V
	 NFNoB8d62tpSbdIxrU3qye81PPD6TzrY7dBDb2BAx/otu6ISj2oNcoQs/j47XXMb0L
	 cap5LM7QP2v8g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7518CC4166F;
	Thu, 20 Jun 2024 14:30:50 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v9 0/2] Bluetooth: qca: use the power sequencing subsystem in
 hci_qca
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171889385047.4585.6787872725484709301.git-patchwork-notify@kernel.org>
Date: Thu, 20 Jun 2024 14:30:50 +0000
References: <20240612080150.18375-1-brgl@bgdev.pl>
In-Reply-To: <20240612080150.18375-1-brgl@bgdev.pl>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, bartosz.golaszewski@linaro.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 12 Jun 2024 10:01:48 +0200 you wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Here are the dt-bindings and the hci_qca patches split out of the larger
> power sequencing series. They target the Bluetooth subsystem but depend
> on the following immutable tag:
> 
>     https://lore.kernel.org/lkml/20240612075829.18241-1-brgl@bgdev.pl/
> 
> [...]

Here is the summary with links:
  - [v9,1/2] dt-bindings: net: bluetooth: qualcomm: describe regulators for QCA6390
    https://git.kernel.org/bluetooth/bluetooth-next/c/251180e6dba5
  - [v9,2/2] Bluetooth: qca: use the power sequencer for QCA6390
    https://git.kernel.org/bluetooth/bluetooth-next/c/4029dba6b6f1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



