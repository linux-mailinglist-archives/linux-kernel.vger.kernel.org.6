Return-Path: <linux-kernel+bounces-266401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8AB93FF65
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 22:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C9331F2368C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 20:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9687F18EFC8;
	Mon, 29 Jul 2024 20:21:20 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC0618E759;
	Mon, 29 Jul 2024 20:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722284480; cv=none; b=OzkcF1BV8MLLb7vaivsWeoWVxpNwklWHGulI3LY1/WGnfn3woJsHDPrrNasC44hnBdLwmh0vzVF2wNtFIwamx3H75kSb+DjLjABrGhwVVnt03cbCqDpImUF/TVRN62C5GFLKGZmEQxi4LstqnTl3onO5jHlq2H7yu7x3JF9bY+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722284480; c=relaxed/simple;
	bh=7/wDYMNrplYYTb+QGN+Vu8X+Nkg3e8kk/JiUZaNEsjI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sf723/1kvDoEMDMymmrbcCAQS3nzt6E1ycInU/D0+bBbk0zxge1awlO+h+WkAZ4YPSVb3LiYibYDWESRuXf4ukm0EVOyWanDLPNOEunkYG4E1Ok4Tls3Pw2CNuiK4BFageg2WDWPjvymSn/HVA65n/yYdP6xyAePS97Qn/EM7lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e86192c.versanet.de ([94.134.25.44] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sYWrn-0007Xp-Cj; Mon, 29 Jul 2024 22:21:11 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH v3 0/3] arm64: dts: rockchip: fixes support for Lunzn Fastrhino R6xS
Date: Mon, 29 Jul 2024 22:21:00 +0200
Message-Id: <172228429363.2312452.2816091351792477648.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240710143017.685905-1-amadeus@jmu.edu.cn>
References: <20240710143017.685905-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 10 Jul 2024 22:30:14 +0800, Chukun Pan wrote:
> Changes in v3:
>   Remove merged patches
>   Further explanation of the PHY reset time changes
> 
> Changes in v2:
>   Separate commits for regulator and supply changes
>   Separate commits for R68S Ethernet PHY changes
> 
> [...]

Applied, thanks!

[1/3] arm64: dts: rockchip: use generic Ethernet PHY reset bindings for Lunzn Fastrhino R68S
      commit: 22de886d49613ea36b39bbe563bf77a2de057865
[2/3] arm64: dts: rockchip: remove useless tx/rx_delay for Lunzn Fastrhino R68S
      commit: ecb0835328a534f48f1213a257888d8510a1cad3
[3/3] arm64: dts: rockchip: Enable UHS-I SDR-50 for Lunzn FastRhino R66S
      commit: 9df34247766b2a42c48cf0d81a0dd756c546cbdc

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

