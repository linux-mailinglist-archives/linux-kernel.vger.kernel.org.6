Return-Path: <linux-kernel+bounces-536138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E7AA47BE9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 896B53B7ADF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D215022DFB9;
	Thu, 27 Feb 2025 11:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="DzLSVsRp"
Received: from mail-m19731103.qiye.163.com (mail-m19731103.qiye.163.com [220.197.31.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227DD22CBEA;
	Thu, 27 Feb 2025 11:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740655179; cv=none; b=l4DAh0jjQUIXpoTyCjDdpTcoujDidLaHFivwGa/T6SI2uXPICCMW15cqqYDfMvAi/z4vKZ19r1tpc2ox0E34skmUJ5mHEZdpteeya/dY98PXuc72mbLiEwr1EQRmif0VOrNJqj+x0vdQgiBrZ9wFGPo9/hA6k9cInNA4vxRQ23A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740655179; c=relaxed/simple;
	bh=9o+QfhTcEoto6KBALV0z2dEFZ2Kt2QCBhVkd/uaOQkw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Sel0aTT1mpR0nNhPrGOL0riG/C1KsEW63vj/D82lBx0k/k5CPylJtbHco1p7+TYyjE7WX6z5Aky7PZJneeRPo/rK/W9EAccE7F4GlQ6b9Lc6/VflansubtdzIK0VMby2go4hDUL7XAFLds4cNIid4y0iTyeTJBxiS71YJPd8IHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=DzLSVsRp; arc=none smtp.client-ip=220.197.31.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id c65f97db;
	Thu, 27 Feb 2025 19:19:27 +0800 (GMT+08:00)
From: Kever Yang <kever.yang@rock-chips.com>
To: heiko@sntech.de
Cc: linux-rockchip@lists.infradead.org,
	Kever Yang <kever.yang@rock-chips.com>,
	devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Ripard <mripard@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	David Airlie <airlied@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v3 05/15] dt-bindings: gpu: Add rockchip,rk3562-mali compatible
Date: Thu, 27 Feb 2025 19:19:03 +0800
Message-Id: <20250227111913.2344207-6-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250227111913.2344207-1-kever.yang@rock-chips.com>
References: <20250227111913.2344207-1-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUJMHVYeTEhDS0weT0xDH0pWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a95472208e903afkunmc65f97db
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OjY6Hgw6HjIUCQ0xOENMHktI
	EQJPCj9VSlVKTE9LTU5OSk1CSklIVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKSk5PNwY+
DKIM-Signature:a=rsa-sha256;
	b=DzLSVsRpWeADSEV57EPeMbbJY6NTmrx3RdNlMsoWRh6hB7DEhOEGMN4J4THsgXp84/1MXepE6w8XR75n0iNPlqrfhqPjGkBPMdGKweBpOk1TXWbaXV8yI+3r4/gMtIoKbNjDzUnUn1KKmgWrRg0Ck+2Rfe8JMfmvXJrBePAE1ms=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=Z9sDSJlttd2n0D1mkrX2Tzu/ncWJMZn7YZjMBONHk/o=;
	h=date:mime-version:subject:message-id:from;

The Rockchip RK3562 GPU is ARM Mali-G52, use the same driver with
"arm,mali-bifrost". Extend the binding accordingly to allow

	compatible = "rockchip,rk3562-mali", "arm,mali-bifrost";

Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
---

Changes in v3:
- Update the commit message,
- remove the change for clock maxItems

Changes in v2: None

 Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
index 735c7f06c24e..fc8e82cb28a9 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
@@ -25,6 +25,7 @@ properties:
               - renesas,r9a07g044-mali
               - renesas,r9a07g054-mali
               - rockchip,px30-mali
+              - rockchip,rk3562-mali
               - rockchip,rk3568-mali
               - rockchip,rk3576-mali
           - const: arm,mali-bifrost # Mali Bifrost GPU model/revision is fully discoverable
-- 
2.25.1


