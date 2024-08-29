Return-Path: <linux-kernel+bounces-307518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E1F964E6D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 21:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9D3C1C20C73
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 19:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1784F1BA27B;
	Thu, 29 Aug 2024 19:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t+KFAYOH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524951BA26F;
	Thu, 29 Aug 2024 19:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724958350; cv=none; b=bUH1XPjMYjreWJaPwaU5kyStn6r/tfENH12ac22zUp1dzc9nWbLNBfXXrF0GTG41YZpp/B25jHwa//gWN0up7xaiMhsquMdrRIgkl/RJDXcCCedz+0/qLq1SZNlaLM3U5qKK3oHi3HyI9PpGHVNU5djbTIBNGnAMTcArTlObFNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724958350; c=relaxed/simple;
	bh=E68W6HyOr1dym1PCtA6bbg+E2MN5CuGFNKO1zy+6XgU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DDiCETKJNmp01lBvTCpCLgGhZTKErkOHdmA5oCHSZXRfQyzon45DCG8iICHiNMVwhOQ2akjfK/16rPyxGiCRH2ZHZsVItugA71Sn4yVbjB32mOTf0lAvQCLccHOmTErceJaXc+Z2b6O7SsyBtlr2jV7hHUJsaT3y752PQCNsygI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t+KFAYOH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 739B6C4CEC1;
	Thu, 29 Aug 2024 19:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724958349;
	bh=E68W6HyOr1dym1PCtA6bbg+E2MN5CuGFNKO1zy+6XgU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=t+KFAYOHefXd07XQTwKfo43Y5t5epatCYWycfyoGaHMhgTtBa46VFZc2wmxqiu3AG
	 TEu9q/aRebTyjr1wrjrZ5QWWELA/Jzk2kkvjhZvwbCHWaLetU1CLZ1VwUb7lwuzdyW
	 DldvZ8xZ5zZ5Up23ZL26K8Xg+z6cwWmuMxCGS5bBxBjgiUSHZaX3172y0jYu/O62av
	 bZ88QhtkUMXBaf9k/TZDghj0Zu9IUBCtl1qX4othiQBaTGovF4UY9SSiGiYMhuOAsW
	 9zsJxbIg80wk7gBs+gr545VzdojvtHi1jWryCqvLGZ7M7CgquwnznCg5DBl8MMqKOm
	 mHPFqh7wYFWrQ==
From: Vinod Koul <vkoul@kernel.org>
To: kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, Hui-Ping Chen <hpchen0nvt@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240805030356.14565-1-hpchen0nvt@gmail.com>
References: <20240805030356.14565-1-hpchen0nvt@gmail.com>
Subject: Re: [PATCH v4 0/2] Add support for nuvoton ma35 usb2 phy
Message-Id: <172495834711.405683.69011643308831007.b4-ty@kernel.org>
Date: Fri, 30 Aug 2024 00:35:47 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Mon, 05 Aug 2024 03:03:54 +0000, Hui-Ping Chen wrote:
> This patch series adds the usb2 phy driver for the nuvoton ma35 ARMv8 SoC.
> It includes DT binding documentation and the ma35 usb2 phy driver.
> 
> v4:
>   - Update ma35d1 usb2 phy driver
>     - Update the 'readl_poll_timeout' to 'regmap_read_poll_timeout'.
>     - Update MODULE_AUTHOR name.
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: phy: nuvoton,ma35-usb2-phy: add new bindings
      commit: c174f1c6c100b18c4a908b117265d7cd99fff6c7
[2/2] phy: nuvoton: add new driver for the Nuvoton MA35 SoC USB 2.0 PHY
      commit: b48baf69db9725aa5ddde52d98cd7b5517ddd9eb

Best regards,
-- 
~Vinod



