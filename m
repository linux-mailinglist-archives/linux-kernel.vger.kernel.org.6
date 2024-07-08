Return-Path: <linux-kernel+bounces-244947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F40192AC13
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 00:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 270721C222EB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 22:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745CD1509B6;
	Mon,  8 Jul 2024 22:27:55 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C31F1527B4;
	Mon,  8 Jul 2024 22:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720477675; cv=none; b=szlskVAuMqy/LSRWHLr0+yYtXYgc3W7Lw8puR+40B8Cby7DJP7F07DMUAAf4ccO8gDJLSLxFmoNrVkvjUFZQVKqbH8+7hyVxkNi0K0iiQkFPwCQ3oR0GBF3JemIWDn49qSO4RWz0EIN5tGqkW6571KsBCgkKUYi107775l2+Mzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720477675; c=relaxed/simple;
	bh=oIKlpNgkl5RIQen92oXvw5GhHrdwhpC3wO/q1J0No8c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qu+KgpqwC58V7ybNFsi8PpCoKUjvI1YEq+erhY7mRq9Hdqmew2rNRnPYN71Kwk0SqDLF1wAUBhhXjY2O4tiaFjlfNteTpuwaYu+BXYgJ5QOnD6hbZkMxCx+QX5oGdxn0u3qCHfce/F5+NyvylJ0VTwd5/II5PiBvFk9SiVckTN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e8616d7.versanet.de ([94.134.22.215] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sQwpj-0006Hg-KE; Tue, 09 Jul 2024 00:27:43 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Jonas Karlman <jonas@kwiboo.se>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-kernel@vger.kernel.org,
	FUKAUMI Naoki <naoki@radxa.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 0/2] arm64: dts: rockchip: Add Radxa ROCK 3B
Date: Tue,  9 Jul 2024 00:27:41 +0200
Message-Id: <172047765645.1423318.7033657572852954750.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240627211737.1985549-1-jonas@kwiboo.se>
References: <20240627211737.1985549-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 27 Jun 2024 21:17:29 +0000, Jonas Karlman wrote:
> This series adds initial support for the Radxa ROCK 3B board.
> 
> The Radxa ROCK 3B is a single-board computer based on the Pico-ITX form
> factor (100mm x 75mm). Two versions of the ROCK 3B exists, a community
> version based on the RK3568 SoC and an industrial version based on the
> RK3568J SoC.
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: arm: rockchip: Add Radxa ROCK 3B
      commit: 056abbd100ce9ce6dae3e5e64ffee92b56439c0c
[2/2] arm64: dts: rockchip: Add Radxa ROCK 3B
      commit: 846ef7748fa9124c8eea76e2d5e833fa69b3ef7c

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

