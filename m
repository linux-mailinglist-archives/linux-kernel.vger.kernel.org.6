Return-Path: <linux-kernel+bounces-196392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4218D5B2D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 09:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AB4A1F25A9C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 07:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44AB8120D;
	Fri, 31 May 2024 07:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="aZvgQmTP"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BAF17E9;
	Fri, 31 May 2024 07:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717139149; cv=none; b=azpk618AlZqSdO/elRmJDAb5xCb7+xYabNpsyivgY8H+lmIpqyP7wRaggwSXTNC6TusBt0eoMO1glZ/G7VaZInhPty8To4xKVI+xTrSw8xMzx5Ek7sy7U98LK0ZUgs09SNtfCFXxvewQAHRdy6LSPJp6ByZN1RqmORUKqhDgX1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717139149; c=relaxed/simple;
	bh=0XK0C55EsMsjaft8p7TPB4SKJqrAJ7KdyEueOggJfd4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FPHB8MMH+EQk3wdily91k436f7JlOSES2M+vIbW4W40/RwmBeG4gZtDuSRZpxSq+M533ko4WIo7MXAacxWc46Xz1OZ+m1bMF/Ld39Rq5RMNqBtTPVP5s2WdNBI0GDHh5v70mV1i2WOkWMPwPg0UZ5PxnqNyndLJ4Koip6EZKvro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=aZvgQmTP; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1717139147; x=1748675147;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0XK0C55EsMsjaft8p7TPB4SKJqrAJ7KdyEueOggJfd4=;
  b=aZvgQmTPPIExpgwagTxtmTXo9qCkjEui1ePhO3Y9zmGvoPdDItxLYDv+
   6hwZtmqfxKdpuY4WKLfJf92Rav7Y+mIuX6ZDts+BHzkiRFwCb4ywYabd4
   vQW/kXyP7nGWlUl9r1jK0dnDTQ6EiVPGaZwp6AMtn9vzmsYoa+HziJ+hm
   WwbMac6AjSz8/Kc9BWVSxtjlDidQEIHp0jI0vfptEcEfO8JaXxjx+eha2
   l3Sp8Ch/K7OKK5YnuN4/lj8B0SmHoslLmHkz9TcZPEdvoUvJSpATlc44n
   OR8YZHA6lWL5OZgmOY4KmsYqZEQ4d+HUU2O4WusSBaA2+EP7iMasZLaJG
   g==;
X-CSE-ConnectionGUID: wTY4LIfiQwGiNFVRU5C2dQ==
X-CSE-MsgGUID: ktTwT2CdTAmqTCWLpjIYUg==
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="26795678"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 May 2024 00:05:44 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 31 May 2024 00:05:20 -0700
Received: from wendy.microchip.com (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 31 May 2024 00:05:18 -0700
From: Conor Dooley <conor.dooley@microchip.com>
To: <linux-usb@vger.kernel.org>
CC: <conor@kernel.org>, <conor.dooley@microchip.com>, Daire McNamara
	<daire.mcnamara@microchip.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, Bin Liu <b-liu@ti.com>,
	<linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v1 0/2] external ulpi vbus control
Date: Fri, 31 May 2024 08:04:30 +0100
Message-ID: <20240531-citable-copier-188d32c108ff@wendy>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1688; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=0XK0C55EsMsjaft8p7TPB4SKJqrAJ7KdyEueOggJfd4=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGmRZbVzm8UKLF4Whm/Y9qlBWsV5m9IJB+Ut66YYHZR8kHxP fgJnRykLgxgHg6yYIkvi7b4WqfV/XHY497yFmcPKBDKEgYtTACYi0svIMKl3WfyST9tOLQ5uuvhxiq 50sTRLWLt5+KeDvfH6dtnl1xgZ+gzecoold9/138Uo9byyJEE8pvTDacmMi+6zX6zwS13KDwA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

A customer sent me a patch adding a dt property to enable external vbus
control as their phy didn't support it*. I was surprised to see that none
of the other musb drivers made any use of this, but there is handling
in the musb core for it - made me feel like I was missing something as
to why it was not used by other drivers.

I've vendor prefixed the property for now, but I figure there may well
be a bunch of other potential users since this isn't just an musb thing,
given that there's a snps,ulpi-ext-vbus-drv used by an xHCI IP.

This is my third attempt to send these patches. I cannot find them on
lore from either of my previous attempts, so I'm gonna treat this as
v1. I think must've tried to send it from my kernel.org account from
Microchip's corp network and that failed. Either way, apologies if this
is #3 you've got from me..

* they didn't want to be identified, but said it was okay to post.

CC: Conor Dooley <conor.dooley@microchip.com>
CC: Daire McNamara <daire.mcnamara@microchip.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Rob Herring <robh@kernel.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC: Bin Liu <b-liu@ti.com>
CC: linux-riscv@lists.infradead.org
CC: linux-usb@vger.kernel.org
CC: devicetree@vger.kernel.org
CC: linux-kernel@vger.kernel.org

Conor Dooley (2):
  dt-bindings: musb: mpfs: add ULPI external vbus support
  usb: musb: mpfs: detect UPLI external vbus control requirement from DT

 .../devicetree/bindings/usb/microchip,mpfs-musb.yaml       | 7 +++++++
 drivers/usb/musb/mpfs.c                                    | 2 ++
 2 files changed, 9 insertions(+)

-- 
2.43.2


