Return-Path: <linux-kernel+bounces-244946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6EC392AC11
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 00:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 825721F2291F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 22:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E233815252E;
	Mon,  8 Jul 2024 22:27:51 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2F53CF63;
	Mon,  8 Jul 2024 22:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720477671; cv=none; b=QqFdLeV9EVnXxUdUPdiDpXo+tAHJhFGrT+JCGRVIN3YZ704S29ALeoo83xEKdO5KcYpdxtOSuQGuXfnkhbOCAUsxwa92cSoACnOOXsSXi0Kwjve9KRNxWIszrlZueQ6AKyZyWVQVpo1baIC33/e28DI47J5nhjQM/ZSE58RvDQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720477671; c=relaxed/simple;
	bh=7keSjNKjUQZHP6i7oY/3+jzUHcGs9ywO2e3Ox+NNw7M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b9PdNhXD5V0jHeunmd7oRsGyRbgFuouynfzStnRlfVQEGfzBm2oXrGVRRZpaOb9a7rGoTbOS9qAGBUHx548NxaeUe4wwxMZFvRwx+IBCASUPAlDYvpVLuSdfKdfLhKQdnB8vW/wFcpJIXVPyEheFVXBwuxVj8hFIjAcHm4LkdCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e8616d7.versanet.de ([94.134.22.215] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sQwpj-0006Hg-2v; Tue, 09 Jul 2024 00:27:43 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Jonas Karlman <jonas@kwiboo.se>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] arm64: dts: rockchip: Add Xunlong Orange Pi 3B
Date: Tue,  9 Jul 2024 00:27:40 +0200
Message-Id: <172047765645.1423318.42844340203979.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240626230319.1425316-1-jonas@kwiboo.se>
References: <20240626230319.1425316-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 26 Jun 2024 23:03:10 +0000, Jonas Karlman wrote:
> This series adds initial support for the Xunlong Orange Pi 3B board.
> 
> The Xunlong Orange Pi 3B is a single-board computer based on the
> Rockchip RK3566 SoC.
> 
> Schematic for Orange Pi 3B can be downloaded from:
> http://www.orangepi.org/html/hardWare/computerAndMicrocontrollers/service-and-support/Orange-Pi-3B.html
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: arm: rockchip: Add Xunlong Orange Pi 3B
      commit: 6d48d5045d99a938b42ee875ae6be80b832e6d77
[2/2] arm64: dts: rockchip: Add Xunlong Orange Pi 3B
      commit: d79d713d602e8b32cf935ddfdf61769cb74ba1dc

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

