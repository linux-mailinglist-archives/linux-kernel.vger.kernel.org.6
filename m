Return-Path: <linux-kernel+bounces-218329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC96290BCB2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 23:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66CBD285607
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 21:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591A5199251;
	Mon, 17 Jun 2024 21:15:02 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F0B199238;
	Mon, 17 Jun 2024 21:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718658901; cv=none; b=GJyXofpzcP5ySqssH1otAi/Ypm0SDDu9CrJtO+hYuC2oml52Kx/dN0HiwPqgz2r1n/Kh0FeUFva2KRDwh4UxM1ov5i/Z2zvGq2Vmy7Ue60MFY5xGItlHoIB7ZNd+nrQvcT8QXBUelJ15xwc4BJBa2Z8ZfYUIC1dT2TxzFPVwdQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718658901; c=relaxed/simple;
	bh=BXQX5/hcoRLxU8I4iXNU2xSfjke0sJkui4tjDutAd0E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=imyblA3rbH/QzWhALVh3SVPuwbdQZ65nVjys3NcsX1h/JqSIQoZdTjeQ6iRuSx0kt1QZ7EHSO6sYlAW3tWRPXnYwO7BIkK6dH8DEJyTgzxRIoa7qZZuAhTi2OfG/cvhNo/udbRJFSvT7k18KNG+gFk2R0t+MOQ7+On9T4u0LrCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e8616c2.versanet.de ([94.134.22.194] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sJJgj-0004LG-FU; Mon, 17 Jun 2024 23:14:53 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Hsin-Te Yuan <yuanhsinte@chromium.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: Re: (subset) [PATCH v2 0/2] arm64: dts: Fix the value of `dlg,jack-det-rate` mismatch
Date: Mon, 17 Jun 2024 23:14:51 +0200
Message-Id: <171865888527.3904644.1008571862368310887.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240613-jack-rate-v2-0-ebc5f9f37931@chromium.org>
References: <20240613-jack-rate-v2-0-ebc5f9f37931@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 13 Jun 2024 11:58:53 +0000, Hsin-Te Yuan wrote:
> According to Documentation/devicetree/bindings/sound/dialog,da7219.yaml,
> the value of `dlg,jack-det-rate` property should be like "32_64" instead
> of "32ms_64ms".
> 
> 

Applied, thanks!

[2/2] arm64: dts: rockchip: rk3399-gru: Fix the value of `dlg,jack-det-rate` mismatch
      commit: a500c0b4b589ae6fb79140c9d96bd5cd31393d41

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

