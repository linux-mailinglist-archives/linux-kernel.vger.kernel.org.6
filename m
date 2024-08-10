Return-Path: <linux-kernel+bounces-282008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64BAB94DE35
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 21:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AE661F216E1
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 19:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92AA513BC0B;
	Sat, 10 Aug 2024 19:15:52 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E5C4AEF2;
	Sat, 10 Aug 2024 19:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723317352; cv=none; b=mLU+Joq7T9stOhIL65KVfluCxgib30/LOUEpBkS3RsYG/I3TUCXNOgbly0DQ1obA6rMqvrUBTWNB/Z9U0gjpwQHW/6k4MUIvf6EmevaNm8+h2gtepAYXLNiNAN1TcJGVu/QOOM+cIVOGdOEf4eMfRprNCZpE0HqE/sIeBwo6K7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723317352; c=relaxed/simple;
	bh=01jaAqvH31E0+tQORMDclX8oCw36OzL96IVEMAsRs7U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AJLVEgoKvneIHkTQLToFBKn2pilq+CQdMN48kw2ohV0itbUaolyYxtSSNLrfowLDM8HqHrATtTBvsDgdBQHLoW85lpsX8+OfJwqFUhaJ3MFRQMD8G+xoQZo+NRNK7iiseESlZ5KGdAHbF3Wt6oySpl+m6En/k/nCmt3irgHYj5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875b02.versanet.de ([83.135.91.2] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1scrYw-0006Wd-Cf; Sat, 10 Aug 2024 21:15:38 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Andy Yan <andyshrk@163.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	dsimic@manjaro.org,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	robh@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Add support for Cool Pi GenBook
Date: Sat, 10 Aug 2024 21:15:35 +0200
Message-Id: <172331732518.282332.16608016053255555622.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240730102433.540260-1-andyshrk@163.com>
References: <20240730102433.540260-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 30 Jul 2024 18:24:31 +0800, Andy Yan wrote:
> Cool Pi GenBook is a rk3588 based laptop, it is designed to consist of a
> carrier board conntected with a CM5 SoM.
> 
> This series add support of eMMC/USB HOST/WiFi/Battery/TouchPad/Keyboard,
> with a mainline based u-boot[0], it can boot a third-party distribution
> such as Armbian on u-disk.
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: arm: rockchip: Add Cool Pi CM5 GenBook
      commit: db0d831c58ce5bc7f37433f5eef65405610cb322
[2/2] arm64: dts: rockchip: Add support for rk3588 based Cool Pi CM5 GenBook
      commit: 4a8c1161b843c366776fc872a6fe45b743b2983e

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

