Return-Path: <linux-kernel+bounces-227570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E922915357
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 18:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C14FBB25498
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03BE119DF79;
	Mon, 24 Jun 2024 16:20:30 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF0019B590;
	Mon, 24 Jun 2024 16:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719246029; cv=none; b=YlmSgcCTz96Lfro33d3xaS5xhGW/zqK+RrikQ6DtTfglUNF8ia5n2S2Qlqrn6+7rWd53KY7qE5CVQmS6n1uM8P7M4Nqmr32VBnwk01/VwGAgoidDm2M7yhl3mv2GQAIywR072GXANyuu59cNbll+TeCj+7rDcSBZWN5pv2LG2jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719246029; c=relaxed/simple;
	bh=y5Z4U+TdeDs+v1Ueg6ZM+8HEr8gmOsAkl1mnLsVQsEM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G1fl+5ipDK08h1Eo/jJ3KvMDS2XJbihq7nM+Auon8xOcgDXsksUhVfXCS8bE/WPv5Dl9hv6M85WRQ5ld7f/oiBH+NZ/43ckkfaBheUEKLpbo/CbnwIn9kRdOGpNDCF4FvEeBZmncnJ+j0UiHJhFNOY7hw8qr9dVVpHcyFWGy6vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875b6a.versanet.de ([83.135.91.106] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sLmQZ-0001wn-Qq; Mon, 24 Jun 2024 18:20:23 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Johan Jonker <jbx6244@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	robh@kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	conor+dt@kernel.org,
	krzk+dt@kernel.org
Subject: Re: [PATCH v1] ARM: dts: rockchip: enable hdmi_sound and i2s0 for mk808 hdmi
Date: Mon, 24 Jun 2024 18:20:14 +0200
Message-Id: <171924573800.612064.1539997666589623837.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <aa79ff87-ea94-4f6d-a81b-5110724243f4@gmail.com>
References: <aa79ff87-ea94-4f6d-a81b-5110724243f4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 20 Jun 2024 16:11:38 +0200, Johan Jonker wrote:
> Enable the hdmi_sound node and add i2s0 as sound source
> for mk808 hdmi.
> 
> 

Applied, thanks!

[1/1] ARM: dts: rockchip: enable hdmi_sound and i2s0 for mk808 hdmi
      commit: 99a2b6d16b37258bcbdc2e07eb55e129362a182f

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

