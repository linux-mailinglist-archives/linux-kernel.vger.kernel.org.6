Return-Path: <linux-kernel+bounces-191495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4008D1052
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 00:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 736571F220EC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 22:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D7B167D97;
	Mon, 27 May 2024 22:42:29 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F5E101DE;
	Mon, 27 May 2024 22:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716849749; cv=none; b=s13OXE/FBpy9ATINkLV9/fkhmf94jH40d4cSocQMw9vUnP5tf33v1PeT7uM4lUjbnk8adQlsPI7UKaRwKBUhUS22V8YVh+vi0FGHD/xZp2YvSOdbVJkuC0s63pCvc2qikoQRwvWF3z8nMEi1SRzo34dlmWkMOUWf08V5Tqqyx8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716849749; c=relaxed/simple;
	bh=Z034sJTcJLXAysCYfnJ6z8fQuQxK4I4o5rI0JnYxkK8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mDC07lZqXZv+cJOz/yNRYqrhw5eCIloWn8CbzKeOpnYCnPx5pABMh6jv7KQpCm69sBs/IRJPBTeFuQCK6DDRMCvLVoU1FN1ud2BiJ1e9q5QQL40+u8KPEys3NqVmMiT0y4Cbo/PpDa7gVD4c1XLgkjVe37jfd7vsDyTuA3eRTJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e86193d.versanet.de ([94.134.25.61] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sBj2r-0005Os-Bt; Tue, 28 May 2024 00:42:21 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Jonas Karlman <jonas@kwiboo.se>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 0/2] arm64: dts: rockchip: Add Radxa ROCK S0
Date: Tue, 28 May 2024 00:42:17 +0200
Message-Id: <171684956152.1783037.13185837612901353898.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240521212247.1240226-1-jonas@kwiboo.se>
References: <20240521212247.1240226-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 21 May 2024 21:22:41 +0000, Jonas Karlman wrote:
> This series adds initial support for the Radxa ROCK S0 board.
> 
> Radxa ROCK S0 is a single-board computer based on the Rockchip RK3308B
> SoC in an ultra-compact form factor.
> 
> Schematic for the ROCK S0 can be found at:
> https://dl.radxa.com/rockpis0/radxa_rock_s0_v1200_schematic.pdf
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: arm: rockchip: Add Radxa ROCK S0
      commit: 768dfd7b49a24b02f1422bf8e2270bcdccea16b9
[2/2] arm64: dts: rockchip: Add Radxa ROCK S0
      commit: adeb5d2a4ba47910238b3c4f5fd960cc0c26a98b

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

