Return-Path: <linux-kernel+bounces-278304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65FA894AE83
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 18:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 119271F222B5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 16:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB50213B783;
	Wed,  7 Aug 2024 16:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CspDVK3w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0862C13A3F6;
	Wed,  7 Aug 2024 16:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723049946; cv=none; b=QxR4oPKCeGR8KWPD/VlOv5YDzKZlAw+gJPz5lsqOAq+VTfLnM7SNAK9VudNdxUTfrh/MgXJ6rY24JEBXoPJQ4ZAG8NUIxY8EQTAyh/eWyhD86uMpcN/qJBaUMyb+2WzeJsyTOz/Y+Jyb8FQUVJ87tazNQCd0doNtr/ObNXjMKHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723049946; c=relaxed/simple;
	bh=dPEdhycVTOguP7QecWh2DLLxhHRJ4mnqR6lRY3q91o8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oTjNWdSiCEt97R7Uh0yziv54LgHHNcb472XF29T8+7Z/TbnZskx4YtezFQbHNcSg8iH6VD80fgEKdO8mz9oCaLkKt52qmhi/EBmSMFbOhErcPiPTwX3lOmwVbsK8A0e2YPRBReSWpYSaI9pidZileKA+hCXkPibKlU1MlFVwylQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CspDVK3w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 905B9C32781;
	Wed,  7 Aug 2024 16:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723049945;
	bh=dPEdhycVTOguP7QecWh2DLLxhHRJ4mnqR6lRY3q91o8=;
	h=From:Subject:Date:To:Cc:From;
	b=CspDVK3wd+jRFcuLGCeShKTTd8tY+e04zAx8Y9cxjm7jKJMSUg44wQnhtjROu6/Y6
	 /D7lNY6r1PqQoRzZhLG6nWmSmy/Pqu4rZhF6WRn3ODgnQ0QRxg+QKPfDQUrfugKl7u
	 K9Tlb8IFGi/MtHxGpaGUEf+YXaq55OCAKF3y2pKTNyhNwZwwSi+xgmwZ8yCTjOXAJX
	 la1s0001V4ghioc4GvSuw5l+apgiVWv05qwX5vTvSI/SN1ltea01Uk6UsY8wl5kfML
	 /RMzhwCRCPBb5pTesnTLCey0BLJNLuNQXNWbsu2nIMEgm05+vj5rE2TRxGuqCNxrWn
	 7/rBQq/sct6aQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
Subject: [PATCH 0/3] dt-bindings: Convert and move Mediatek clock syscons
Date: Wed, 07 Aug 2024 10:58:52 -0600
Message-Id: <20240807-dt-mediatek-clk-v1-0-e8d568abfd48@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMyns2YC/x3MQQqAIBBA0avIrBtQiYquEi0GHWuoLDQiiO6et
 HyL/x/InIQz9OqBxJdk2WOBqRS4meLEKL4YrLa17nSL/sSNvdDJC7p1wc4EarhtApGDUh2Jg9z
 /cRjf9wNnlYZBYQAAAA==
To: Stephen Boyd <sboyd@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Chun-Jie Chen <chun-jie.chen@mediatek.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org
X-Mailer: b4 0.15-dev

This series converts all the Mediatek syscon bindings which are clock 
controllers to DT schema format moving them to 'clock' directory. The 
existing schemas in arm/mediatek/ which are clock and reset controllers 
are also moved to 'clock' directory.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
Rob Herring (Arm) (3):
      dt-bindings: clock: mediatek,apmixedsys: Fix "mediatek,mt6779-apmixed" compatible
      dt-bindings: Move Mediatek clock controllers to "clock" directory
      dt-bindings: clock: mediatek: Convert MediaTek clock syscons to schema

 .../bindings/arm/mediatek/mediatek,bdpsys.txt      | 24 ------
 .../bindings/arm/mediatek/mediatek,camsys.txt      | 24 ------
 .../bindings/arm/mediatek/mediatek,imgsys.txt      | 30 -------
 .../bindings/arm/mediatek/mediatek,ipesys.txt      | 22 -----
 .../bindings/arm/mediatek/mediatek,ipu.txt         | 43 ----------
 .../bindings/arm/mediatek/mediatek,jpgdecsys.txt   | 22 -----
 .../bindings/arm/mediatek/mediatek,mcucfg.txt      | 23 ------
 .../bindings/arm/mediatek/mediatek,mfgcfg.txt      | 25 ------
 .../bindings/arm/mediatek/mediatek,mipi0a.txt      | 28 -------
 .../bindings/arm/mediatek/mediatek,vcodecsys.txt   | 27 -------
 .../bindings/arm/mediatek/mediatek,vdecsys.txt     | 29 -------
 .../bindings/arm/mediatek/mediatek,vencltsys.txt   | 22 -----
 .../bindings/arm/mediatek/mediatek,vencsys.txt     | 26 ------
 .../bindings/clock/mediatek,apmixedsys.yaml        |  2 +-
 .../{arm/mediatek => clock}/mediatek,infracfg.yaml |  2 +-
 .../mediatek => clock}/mediatek,mt8186-clock.yaml  |  2 +-
 .../mediatek,mt8186-sys-clock.yaml                 |  2 +-
 .../mediatek => clock}/mediatek,mt8192-clock.yaml  |  2 +-
 .../mediatek,mt8192-sys-clock.yaml                 |  2 +-
 .../mediatek => clock}/mediatek,mt8195-clock.yaml  |  2 +-
 .../mediatek,mt8195-sys-clock.yaml                 |  2 +-
 .../{arm/mediatek => clock}/mediatek,pericfg.yaml  |  2 +-
 .../devicetree/bindings/clock/mediatek,syscon.yaml | 93 ++++++++++++++++++++++
 23 files changed, 102 insertions(+), 354 deletions(-)
---
base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
change-id: 20240807-dt-mediatek-clk-81fa6e76faac

Best regards,
-- 
Rob Herring (Arm) <robh@kernel.org>


