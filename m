Return-Path: <linux-kernel+bounces-241577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2165B927CC0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 20:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA3461F24623
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 18:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38767344C;
	Thu,  4 Jul 2024 18:01:38 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378B9101DB;
	Thu,  4 Jul 2024 18:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720116098; cv=none; b=g0JUbufmU0pz1HHkU75i0MjjWi6yKaIqCrXNjwmoZaL5Zk2ob5gqbpZF7YCBHonveSQkBZQ/d8TwS5nRyRHQPV0Lcg2mcdE4FSugr412Z6Mm614oewRptZYMzhluLlpLafTluwa1Aasb6FBjpY4JiYOiq5oOi5IdC1zmzJ00UBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720116098; c=relaxed/simple;
	bh=QNcQI7Lncx7DTyZihuUSMq+AUVBrbFHOAde02Tlg+FY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OuiL6gaDTn5+MLBYijv5nhlXwqe9URAk/0SlOlvFTluLUijRXGi7ftScMh+0UxBQuEdKZfhuJJjpHI7uWcdjhSEnaKX/FkFbeIs/CYGB6k3+dIPLdv0BbuvVfBMsYiaJwdrYF5/PIYBO14r8lTYXbwxW/7v7lrQtnbKd5PJwHaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875ac2.versanet.de ([83.135.90.194] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sPQlt-00049m-Mp; Thu, 04 Jul 2024 20:01:29 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Johan Jonker <jbx6244@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	krzk+dt@kernel.org,
	linux-clk@vger.kernel.org,
	sboyd@kernel.org,
	mturquette@baylibre.com,
	devicetree@vger.kernel.org,
	conor+dt@kernel.org
Subject: Re: [PATCH v1] dt-bindings: clock: rk3188-cru-common: remove CLK_NR_CLKS
Date: Thu,  4 Jul 2024 20:01:25 +0200
Message-Id: <172011606371.897267.1165262107995336205.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <6f21c09b-e8d2-4749-aca6-572c79df775d@gmail.com>
References: <6f21c09b-e8d2-4749-aca6-572c79df775d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 27 Jun 2024 23:17:45 +0200, Johan Jonker wrote:
> CLK_NR_CLKS should not be part of the binding.
> Remove since the kernel code no longer uses it.
> 
> 

Applied, thanks!

[1/1] dt-bindings: clock: rk3188-cru-common: remove CLK_NR_CLKS
      commit: d89e8096957e35742c9922d3f6628f24de0d6163

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

