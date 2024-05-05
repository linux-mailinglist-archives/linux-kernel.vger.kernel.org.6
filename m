Return-Path: <linux-kernel+bounces-169138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF5A8BC3AC
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 22:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F8B21F22037
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 20:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE64B74437;
	Sun,  5 May 2024 20:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="AxeCn8mU"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E346DD08
	for <linux-kernel@vger.kernel.org>; Sun,  5 May 2024 20:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.172.40.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714940746; cv=none; b=L4IUPoHSRMerocVkvjQnWIEenM1I1uslCGuV20u/XgvCOrtj28zCW08FMY5Jylo2LgS9VICvPP0kBXLS8a4P/6beMw6ETxnNkMZjyoKEGTKtgPqDiRWUj+MJbPPXy7bsF/SbaU2+wMbf/mPdMMVp4yj93u3lT+TGlrZ5O6yOVik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714940746; c=relaxed/simple;
	bh=MoTZYJkUoOWyleyusoyvgj/FFkcL9ArrzwXmf6mrbvo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HYcIMjaE2/9Vkua/FlMerNbvZtEHXTKSB3SBmlIQ2RH4unw8MyWNgQWuR8VWsyY2It2RczQQeYzeDPmPtFh3BXiWSsGv+eQZmDKpcuUjxgFuwkqgN6hTS3FVvizwcUwq2A3DNFlMmDfMO9PbBh28EhShxaTQBZNy6rfDhkpRerM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=AxeCn8mU; arc=none smtp.client-ip=167.172.40.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1714940733;
 bh=yYQHFmGpW55zkbj8zsWMJat5Z4fq40uha7pgN/y0H0k=;
 b=AxeCn8mUsoqrUcxYmZrNm+2pecQHAy/NZIDtA7zLp7abZA/f4bE9RGrP4yQ9wllUAp3M8OcDo
 IoTh+ZvVtcajA0vAZB/laZpOcWCtY6mohdy7VzrbGq+PcA57Ig6/flSSymyQznwaObbUaQ2SjJ6
 rvsl6JvL9lscjUyAgrMRM8EzQYetjASKfjVEOFRjDcrTjmZcPEmzWIJ6oMfl/qszYqPKpYb1eZj
 I5rEJoYtdPuoEjJvBK22GF5gcxB8SKKWJ4NRwQwNa7VVIuHGMDlOJ4AHsK6kgI365dSbb8Pwrwx
 QRbMfXi3iaxDHTrwPPILF2z4uRlF7nHGBCuK1hcqGgfg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Jonas
 Karlman <jonas@kwiboo.se>
Subject: [PATCH 0/2] arm64: dts: rockchip: Add Xunlong Orange Pi 3B
Date: Sun,  5 May 2024 20:25:15 +0000
Message-ID: <20240505202522.2999503-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 6637eb3b50d779b5c30d1117

This series adds initial support for the Xunlong Orange Pi 3B board.

The Xunlong Orange Pi 3B is a single-board computer based on the
Rockchip RK3566 SoC.

Schematic for Orange Pi 3B can be downloaded from:
http://www.orangepi.org/html/hardWare/computerAndMicrocontrollers/service-and-support/Orange-Pi-3B.html

Jonas Karlman (2):
  dt-bindings: arm: rockchip: Add Xunlong Orange Pi 3B
  arm64: dts: rockchip: Add Xunlong Orange Pi 3B

 .../devicetree/bindings/arm/rockchip.yaml     |   5 +
 .../boot/dts/rockchip/rk3566-orangepi-3b.dts  | 694 ++++++++++++++++++
 2 files changed, 699 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-orangepi-3b.dts

-- 
2.43.2


