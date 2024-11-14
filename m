Return-Path: <linux-kernel+bounces-409585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C68839C8FA7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 17:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2496DB3F9D5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 15:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67981ABEA8;
	Thu, 14 Nov 2024 15:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="kXloHT1H"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56015150997;
	Thu, 14 Nov 2024 15:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731599357; cv=none; b=kbGa8ivvAXW55s//L3YbCyy447A2TIqVs/Dfrj3LhAqm1p4R06MRvdUfDzSI/TjEdOoMCvBlkXtwQsA2aVhkoeRXdoHUH/pGj5Y/Z60OeKZI6jzMqrbWHCDmGRhCn79Dd5FYxcXQ/fyvOd4n5AGq2w80Ses3d9tcVS8ZKqxd128=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731599357; c=relaxed/simple;
	bh=gAo6CX4oZm/kJbZAgvm4WfBY5lLW1cOId/UAr7MY3wM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GFjtbnZwMxFcXRbW5UoFAR5Ts9AxXOziQrJA+jWLguwnOpbxYwoDou9+n8D57XNiuBeeV6PQvuRorNJdOJWIzWhSxcFi1mdigLGtQ8IntL8yoyV+EiEiIyuyw+w3iRPFSyXEpleUE4PBmmCzKRw0IYGRmRs0IvdS4yRNu61qdAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=kXloHT1H; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 6D8A2100002;
	Thu, 14 Nov 2024 18:49:02 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 6D8A2100002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1731599342;
	bh=lsFacXP5o2cIfFFjFmHt4+id49zlrLdO2XORIjPTsvI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=kXloHT1HT2fl4vo9D14HHJ+tfNVXTgcdzLcP7cbMJG3e92pVtpaBJNgrmE4AD37FE
	 ut1E2T75pKRjrkFOryV7fs50WYGEYW5k2KGjlUVOyxvy1IScoUMBKBmWT6L/mC7KE+
	 kow794vbbvBhnDoY7vZdfhmUgMMrUy835N6q6M5bOJTZbhImM7s3cgFZMPBHWw1xdR
	 D3fmk1zKhinG6TtnD/7FvpmpmlKazqjiBEl7gV53dVmNlC8KUU0K+6E9YI/47keO5x
	 psEmFY1VBjuZR9rpS9TCWZ0bFhcuIw7v9ZDJWzLqJoSUq/HY9Dg3hmtvUK/han9zmf
	 FUFlHsAjasUJw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu, 14 Nov 2024 18:49:02 +0300 (MSK)
From: Jan Dakinevich <jan.dakinevich@salutedevices.com>
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>, Christian Hewitt
	<christianshewitt@gmail.com>, Conor Dooley <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, Jerome Brunet <jbrunet@baylibre.com>, "Kevin
 Hilman" <khilman@baylibre.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	<linux-amlogic@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>, Neil Armstrong
	<neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, Xianwei Zhao
	<xianwei.zhao@amlogic.com>
Subject: [PATCH v2 0/2] Introduce initial support of Amlogic AC200 board
Date: Thu, 14 Nov 2024 18:48:54 +0300
Message-ID: <20241114154856.3353691-1-jan.dakinevich@salutedevices.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-a-m1.sberdevices.ru (172.24.196.116) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 189183 [Nov 14 2024]
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiSpam-Envelope-From: YVDakinevich@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 41 0.3.41 623e98d5198769c015c72f45fabbb9f77bdb702b, {Tracking_smtp_not_equal_from}, {Tracking_uf_ne_domains}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;lore.kernel.org:7.1.1;127.0.0.199:7.1.2;sberdevices.ru:7.1.1,5.0.1;smtp.sberdevices.ru:7.1.1,5.0.1;salutedevices.com:7.1.1, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, {Tracking_sender_alignment_int}, {Tracking_white_helo}, FromAlignment: n
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/11/14 12:25:00
X-KSMG-LinksScanning: Clean, bases: 2024/11/14 12:25:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/11/14 14:31:00 #26861614
X-KSMG-AntiVirus-Status: Clean, skipped

Changes v1 [1] -> v2:
 - added "Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>" to
   dt-bindings
 - don't share the definition of sound card between ac2xx boards

Links:
 [1] https://lore.kernel.org/all/20240521222155.28094-1-jan.dakinevich@salutedevices.com/

Jan Dakinevich (2):
  dt-bindings: arm: amlogic: document AC200 support
  arch/arm64: dts: ac200: introduce initial support of the board

 .../devicetree/bindings/arm/amlogic.yaml      |   1 +
 arch/arm64/boot/dts/amlogic/Makefile          |   1 +
 .../boot/dts/amlogic/meson-sm1-ac200.dts      | 109 ++++++++++++++++++
 3 files changed, 111 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-sm1-ac200.dts

-- 
2.34.1


