Return-Path: <linux-kernel+bounces-218356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 943AC90BD1C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 23:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C9CF1F22781
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 21:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45AAC199EB0;
	Mon, 17 Jun 2024 21:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Zt6N2Dcl"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24155199250;
	Mon, 17 Jun 2024 21:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718661390; cv=none; b=ggiXsj1hkoPdH6NJG2wbCSsNWG2/FxwNorcGNq6fLY7DL/p9r7PclexCRCXSpQOFJYD8NZSdg2zaHoCfA2qndLOfk3tobfuz7IBkMq1ZxZ+c7oTrf52w0Xy1N+t7Dnwx/ao0m0sGhjFTgWS1x+NEKlfc/mnDpEB2Qd/gqEZflyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718661390; c=relaxed/simple;
	bh=oYgR1S1ZbdlSr6B4Z6CKaYoTqnd5McG8fHjnbcOE9s8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aryrWJe/YhEnfgs6O/QEdoA6/q5rSo2hHd0DsXUsH5Mk+p6Jt52Mpv/+RebFBHfHu2wBaCP/edc5G5a2aMLCyrQWESBfJh4tEQGPm5OmEvHLlkdv6CQq330qyismiYHxftKOAKit7iMJ5u6WJa52PSl5GPsi+0lzmRK+7uAOTs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Zt6N2Dcl; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718661387;
	bh=oYgR1S1ZbdlSr6B4Z6CKaYoTqnd5McG8fHjnbcOE9s8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Zt6N2DclEpY+u/2/RjfNArjCioQ31CCkl7pliv8zBdKsYiGjt4eBqsziad5afe9Sq
	 kE3deFxnucIKPvHSMWNB6mn9O3XGX3rrAYLL8lccCYY9CP7rn+PSROlGP9dhdEVx6K
	 SoiIYcnb0XGwvr4ONVVwwBXuMYxTTK/DybwvIyVAgCZswlQ1CrDL04WQb9e5ssxft+
	 mKmYFimsfe+UbCMmd4NAdwCI6gePGYtLgkRXdu1XvePhDCWpK5p5/hnZsaNpH9sj23
	 yczJq/eidDR+BpVazO5rk39wMxy/atkH5Zd05iY6hyqmT1aWC3skMwMPgG0HVszhzR
	 g0QWRxOsEzOIA==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 27ACF3782176;
	Mon, 17 Jun 2024 21:56:27 +0000 (UTC)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 18 Jun 2024 00:48:11 +0300
Subject: [PATCH 3/4] dt-bindings: phy: rockchip,rk3588-hdptx-phy: Add
 #clock-cells
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240618-rk3588-hdmiphy-clkprov-v1-3-80e4aa12177e@collabora.com>
References: <20240618-rk3588-hdmiphy-clkprov-v1-0-80e4aa12177e@collabora.com>
In-Reply-To: <20240618-rk3588-hdmiphy-clkprov-v1-0-80e4aa12177e@collabora.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, Algea Cao <algea.cao@rock-chips.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: kernel@collabora.com, linux-phy@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
X-Mailer: b4 0.14-dev-f7c49

The HDMI PHY can be used as a clock provider on RK3588 SoC, hence add
the necessary '#clock-cells' property.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 Documentation/devicetree/bindings/phy/rockchip,rk3588-hdptx-phy.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/rockchip,rk3588-hdptx-phy.yaml b/Documentation/devicetree/bindings/phy/rockchip,rk3588-hdptx-phy.yaml
index 54e822c715f3..84fe59dbcf48 100644
--- a/Documentation/devicetree/bindings/phy/rockchip,rk3588-hdptx-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/rockchip,rk3588-hdptx-phy.yaml
@@ -27,6 +27,9 @@ properties:
       - const: ref
       - const: apb
 
+  "#clock-cells":
+    const: 0
+
   "#phy-cells":
     const: 0
 

-- 
2.45.2


