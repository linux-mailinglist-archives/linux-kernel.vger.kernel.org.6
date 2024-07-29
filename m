Return-Path: <linux-kernel+bounces-266402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBDCF93FF66
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 22:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28BE31C223AF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 20:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4D718EFC9;
	Mon, 29 Jul 2024 20:21:20 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABBE18A944;
	Mon, 29 Jul 2024 20:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722284480; cv=none; b=L7f+MSrX+60edzXMzcfEzkJM+CLvhy9wi9a45VqOmcJIiQxU+FLAqylfCGkkw+3CrbbG3pCi4dsUblRSAaJwFwDerVmbBo87AE4T6ZF20yDgWNGaMHCq7yv76yPKr+hLQ1HrqsUSttiJTY3CGWe7IHgJYVnBqdOzAFr5dMIrc4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722284480; c=relaxed/simple;
	bh=k/o3lXOS7Z7AMmtQXRIdP574iugduvg+ywXzu1P4fg0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JKXuxur8rVAIU1I0Izv4uKXN9fEe1Ykz9F3kf4ZF7j9217aodo0jgW60Mpl+JKS218mRcezy1b36RaKJi/TSJzZ+IQT+E2WHpagSZZ3PyCydkxeIAyBvvgUq7XGijkOvTtyoLnMzrlrgw81Ejbz4EcgT8DsdD7uIOlONk9P75Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e86192c.versanet.de ([94.134.25.44] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sYWro-0007Xp-D2; Mon, 29 Jul 2024 22:21:12 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Diederik de Haas <didi.debian@cknow.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Johan Jonker <jbx6244@gmail.com>,
	linux-kernel@vger.kernel.org,
	Alex Bee <knaerzche@gmail.com>,
	Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v3 0/2] sdmmc/sdio/emmc improvements for RK3328
Date: Mon, 29 Jul 2024 22:21:02 +0200
Message-Id: <172228429366.2312452.3957597355505563883.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240710132830.14710-1-didi.debian@cknow.org>
References: <20240710132830.14710-1-didi.debian@cknow.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 10 Jul 2024 15:28:10 +0200, Diederik de Haas wrote:
> This is a rebased resend of Alex Bee's prior patches which haven't been
> merged even though there doesn't seem to be anything wrong with it.
> These patches have been used in LibreELEC for years, which means I've
> been using it for years on my Rock64 and I've also added it to my
> latest 6.10-rc7 build and that worked fine too.
> 
> Link to v2:
> https://lore.kernel.org/linux-rockchip/20210623145918.187018-1-knaerzche@gmail.com/
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: rockchip: Add sdmmc_ext for RK3328
      commit: 82e3aaae388199a0aff33e5371db307b3274f77a
[2/2] arm64: dts: rockchip: Add sdmmc/sdio/emmc reset controls for RK3328
      commit: bd6e614356d4fc852480cfb14d705da0561d5777

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

