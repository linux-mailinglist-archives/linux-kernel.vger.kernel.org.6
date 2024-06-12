Return-Path: <linux-kernel+bounces-212031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7A2905A3F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 19:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9C0EB21FE2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 17:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62F9184112;
	Wed, 12 Jun 2024 17:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GigXlW0h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F240B1822E4;
	Wed, 12 Jun 2024 17:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718214727; cv=none; b=G2UQ3xkasec7pi9ncrlg5qTfSR1LwwXr6fj4kYssPdWGpAvKIMDYqjL27P0Po2gO/NE7WjDhGtVOy/vQRpVLp5+7WjpD2n7a48Zv0c4MLFz5jbbevzWKM81meqPvxhLaYzEQ//R4WQCI8EHNVwXT9h65Cruo+Q1qbJTLsXTsVRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718214727; c=relaxed/simple;
	bh=dzTwtHi0xEpEXutLs5k+UvmqJUUkMc7f/shDQFFvq24=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TKyOPQoLS1A8ii55U0B70etVOi8YWIw8u1gLUtr582V9l5/LdLCv6fg/6Nx5gtKfHWYBzVwTMSfeZof1MI3hnMmKHJpzPLVOIqQDDmkQg4IDyOV4crFfh7/7dWGU0OUj/T8pl1H/i3CTNg82vY1GFB2YMDnbkE2YyO0JYXPS4QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GigXlW0h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1BCFC116B1;
	Wed, 12 Jun 2024 17:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718214726;
	bh=dzTwtHi0xEpEXutLs5k+UvmqJUUkMc7f/shDQFFvq24=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=GigXlW0h8BeV4E9uEsT0raJRSIaqbwtMR5g+WLO29AZIcKzPQshDUMlzxYNTU3skb
	 wvx+Nr5KMBYd4unSoOaTl2zg8faUHpaH+bmlKRP1EJ/5YDNfAhmtETAfVPa/DKIJtp
	 v44pZbKhzuXBr9MRgsop3yMCbjdW2Ct3RHWST7K4WsAZP12XXu4RzpwIHfJcZNetvt
	 DE+kxbTKWYi33kaV/RyhORCaTy/sBN5DffYulBzWllGnLiGUXwz+JYUqaXCXXVw/NQ
	 poDcrWCcDOgYpTpnbCPEgrqExlaGhr7u7Rno1YCsPMoj4Hvzlkk7Xdkr6AvWzOTP0t
	 D90/3+8npk+zw==
From: Vinod Koul <vkoul@kernel.org>
To: Kevin Hilman <khilman@baylibre.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240605-topic-amlogic-upstream-bindings-fixes-power-domains-phy-v1-1-c819b0ecd8c8@linaro.org>
References: <20240605-topic-amlogic-upstream-bindings-fixes-power-domains-phy-v1-1-c819b0ecd8c8@linaro.org>
Subject: Re: [PATCH] dt-bindings: phy: g12a-usb2-phy: add optional
 power-domains
Message-Id: <171821472227.586907.9102514939175576986.b4-ty@kernel.org>
Date: Wed, 12 Jun 2024 23:22:02 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Wed, 05 Jun 2024 11:36:00 +0200, Neil Armstrong wrote:
> On newer SoCs, the USB2 PHY can require a power-domain to operate,
> add it as optional.
> 
> 

Applied, thanks!

[1/1] dt-bindings: phy: g12a-usb2-phy: add optional power-domains
      commit: 8e97ddd586148fe8852c388eb7c9bba70223da5f

Best regards,
-- 
Vinod Koul <vkoul@kernel.org>


