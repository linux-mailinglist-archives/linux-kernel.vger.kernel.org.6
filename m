Return-Path: <linux-kernel+bounces-436504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A267F9E86DB
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 18:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AEB718827A6
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 17:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3619C189F3B;
	Sun,  8 Dec 2024 17:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bBlumy80"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84651189B83
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 17:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733677378; cv=none; b=n7T9txx6CRwronvf/f1ndjRNVEUUUpnk25aytn+UIzSkT4LkOL61DLaOj2fuH1wZFtfc+/0e+PB1ODWkuMiTPPZEU2QQDUoDRIy8zM7Wk4olXcGbiGfEkYndvNyfg25lr3BsULBz6X04qRBg6sdmzI5W1yC1xcq9RucM2tgqT8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733677378; c=relaxed/simple;
	bh=Yj+pgAR8shJSNEyI78vmqdR4SR1lJHoF/1keS1AQU6c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Z85b/WTTUYm85ot2n+fxIJIyKdZDX4nI1nOtsgokciCdVFWr71B2eE0Gy7xTJRYLsgoqrzsYQMr8iKduARmktlOrrYWSzs7tROa/D/Uwm4+pfNtL2b5exsL3Ys9EhEtE1fPcxeKrZVN5sJb6CS54DgO1vZKGThEMIJUxGImOOcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bBlumy80; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14883C4CED2;
	Sun,  8 Dec 2024 17:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733677378;
	bh=Yj+pgAR8shJSNEyI78vmqdR4SR1lJHoF/1keS1AQU6c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=bBlumy808xRVfANPPX1aJJf5cNC3/WG0x6lVsLhojohe068iELVH82pzyrkJmnqyw
	 0G3ESz+edFlqEIMnq9XjxY0NiFwkf+DnctIYdWgYeg3sXxPPIv3ERCY6+7/aHgWLAa
	 OZCPMqBam/ih33OGzdJJhWZxRbnix8aF4hhTf8Xc6pp/x4g7qTs8whlz7D5AIpmK0f
	 ZgRVLsm2qo27EH3rTjghjsxyp6xAqv9AJj/vjWWjr0bNlPjtvpCvjYtYFfyxxZu2rc
	 Y6l1ifvH3zPHzy6EDjNI8kTEBsvVAbGQ3h/7rtjXxFkrd6s0JQ+d8x0yraqZmJFEZq
	 K3V7wZBO2EtfQ==
From: Vinod Koul <vkoul@kernel.org>
To: Kishon Vijay Abraham I <kishon@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Thierry Reding <treding@nvidia.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Stefan Eichenberger <eichest@gmail.com>, 
 Advait Dhamorikar <advaitdhamorikar@gmail.com>
Cc: linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241127104333.18944-1-advaitdhamorikar@gmail.com>
References: <20241127104333.18944-1-advaitdhamorikar@gmail.com>
Subject: Re: [PATCH] phy: marvell: Fix spelling mistake "exlicitly" ->
 "explicitly"
Message-Id: <173367737467.1042266.16446493563282944059.b4-ty@kernel.org>
Date: Sun, 08 Dec 2024 22:32:54 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 27 Nov 2024 16:13:33 +0530, Advait Dhamorikar wrote:
> Fix spelling mistake in mvebu_comphy_ethernet_init_reset
> comments.
> 
> 

Applied, thanks!

[1/1] phy: marvell: Fix spelling mistake "exlicitly" -> "explicitly"
      commit: 691cdb40d521809bec03788c29dcf8f7a4f9cf76

Best regards,
-- 
~Vinod



