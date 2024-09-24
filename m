Return-Path: <linux-kernel+bounces-337100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F5E98455A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 14:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BC7A284130
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 12:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3776B1A724D;
	Tue, 24 Sep 2024 12:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="VVsc5T48"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEF11A7044;
	Tue, 24 Sep 2024 12:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727179254; cv=none; b=CT66jeeD3esmRvB/QKLwTiZ0KxmRM+JP65acFYiqgB1Rf5XFVfJdekOXIHhDefuNsoDYi740bPAn5AK8VU0rJ78XdQbvi2F6itQlC4qIO2ZYTMmGb6xAjR1zEY8Zx3440uvCo8Q8i0VpcEk5INpuW3VrNx0dRVy5kKZ+1oCaFKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727179254; c=relaxed/simple;
	bh=FD152mP4Q+bDHzFZaQORNWDz/eem/VoKJVNTlmimtFo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=A7h4Uv7oNQfiq4yGv+TGdrWFaf6Wz85xhsQzksu5Pf2lxwMtx2s/kX0SR9HrFKJMp2k9IZpG9EQwvjdpirEWuvzEOgcVOOx4pEFSFtLn1DIJiMGwif1FXVrQo0oIOntQReNTi8uvkU4fsFaZlAmwaNEEP9iUq+H/Zn8O5JKoBbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=VVsc5T48; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 5C9101FA5E;
	Tue, 24 Sep 2024 14:00:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1727179250;
	bh=Urb5MrVveXhChVclVttxtQ5/44AraOSFmEACjwzk6oE=; h=From:To:Subject;
	b=VVsc5T48YNUXWE5gSvyyq5AcIYZo1YBcM8vNYk4fWRyBBDD4mM8g25w8eStmKqABN
	 EfM+SEH4840emtO2oN5w427uu7Y03x0XwxwSs3VVYnckdQTnPKNYRvGEM0CXuLpQDs
	 VwPRIQjg1c+Wu470WL6xgQW6Yaz7DgTmf/G2J30Cm6M1X8B7bO7VXN4XFGnWvSm6ob
	 bgekaB6a0e0Ff2LtpXKSKm/sgf63jxBZYCiKoLnXtADe1E2rqDSq53NfKkbOEhttT7
	 LIUZ3/XA/BtIzCaR2uytvHYtX3jDlpenqMDRShjgb32yHypCQ2Q5ckJIisiIgIOqut
	 bjropOAARKDdQ==
From: Francesco Dolcini <francesco@dolcini.it>
To: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/3] arm64: dts: ti: k3-am62-verdin: Add Ivy carrier board
Date: Tue, 24 Sep 2024 14:00:41 +0200
Message-Id: <20240924120044.130913-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Add support for the Toradex Verdin AM62 Ivy carrier board. Ivy is a carrier
board designed for industrial environments, supporting industrial
I/O interfaces such as CAN, RS485, RS232, Gigabit Ethernet, 0-25mA analog
inputs, relays, PCIe and more. The board also includes a TPM for security
applications.

https://www.toradex.com/products/carrier-board/ivy-carrier-board

João Paulo Gonçalves (3):
  dt-bindings: arm: ti: Add verdin am62 ivy board
  arm64: dts: ti: k3-am62-verdin: add label to som adc node
  arm64: dts: ti: k3-am62-verdin: Add Ivy carrier board

 .../devicetree/bindings/arm/ti/k3.yaml        |   2 +
 arch/arm64/boot/dts/ti/Makefile               |   2 +
 .../arm64/boot/dts/ti/k3-am62-verdin-ivy.dtsi | 655 ++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi    |   3 +-
 .../dts/ti/k3-am625-verdin-nonwifi-ivy.dts    |  22 +
 .../boot/dts/ti/k3-am625-verdin-wifi-ivy.dts  |  22 +
 6 files changed, 705 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62-verdin-ivy.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625-verdin-nonwifi-ivy.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625-verdin-wifi-ivy.dts

-- 
2.39.5


