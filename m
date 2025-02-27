Return-Path: <linux-kernel+bounces-536201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A46A47CAD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81F383AAD9B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B57B22D7B3;
	Thu, 27 Feb 2025 11:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="fEdLJ4x5"
Received: from mail-m3281.qiye.163.com (mail-m3281.qiye.163.com [220.197.32.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFB622D797;
	Thu, 27 Feb 2025 11:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740657313; cv=none; b=I38/g4wA7icHDxoajqmKrljuTNO6wEPkvs8s7eH0G9HX2uTcPb6+QsJ4ZA2OwlIg31/SWxqMvJvoNLZTe1DhLulXZN/hZRuLfwanZ6RzeNjDd1Z19fRA2LzxScauuR5WU0sH3hW5aa0gLJkmxvkrp/aQ9vlHt4qwlOUJM/YBzMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740657313; c=relaxed/simple;
	bh=b3otlmYze9P+WQAHU4dcgfehv56atm3V7zvBhXwqQoc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Smzct3ogp82MAPOqPN84r7z/0edrYxH/M3Jrgs1ZNvFt+fsmx8DqCswj1SReuM31QFcilbEVDkZ6PTrQ8J4OSPR2NWfgn+0X0TodTqT5ot+HxgFcsYnNYANWMa0n2izVKJVkbI4SUvvXmgxM8jobXq2jZHQ4A4e+T2Cn/30cR2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=fEdLJ4x5; arc=none smtp.client-ip=220.197.32.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id c65f97ee;
	Thu, 27 Feb 2025 19:19:37 +0800 (GMT+08:00)
From: Kever Yang <kever.yang@rock-chips.com>
To: heiko@sntech.de
Cc: linux-rockchip@lists.infradead.org,
	Kever Yang <kever.yang@rock-chips.com>,
	devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Elaine Zhang <zhangqing@rock-chips.com>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 11/15] dt-bindings: rockchip: pmu: Add rk3562 compatible
Date: Thu, 27 Feb 2025 19:19:09 +0800
Message-Id: <20250227111913.2344207-12-kever.yang@rock-chips.com>
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
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQxoaTlYdSh5DSUoaQkwdS0tWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpKQk
	1VSktLVUpCWQY+
X-HM-Tid: 0a9547222d6a03afkunmc65f97ee
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PQw6Vgw6IjINGQ0pKE0hHkIe
	LVFPChdVSlVKTE9LTU5OSkxDT0tCVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKSktLNwY+
DKIM-Signature:a=rsa-sha256;
	b=fEdLJ4x5HQA3FnCbyYmtLwifAt7Lu0K2jEi1z8fDYnFyH1+lzLf8qpNG+6b9Cj5MBqPvM2G/SwBHBPvI8Vu64Bd73M0Zwts0uqmAzo5AmcSpgEC6DcxUjPGT6vyS775PiWLgKbux5A+p73X+fjxt8XvcdR2o4ykUwQ2LzcReL9o=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=3fktVaFKovjecxV81xIAXyNMJaQRx8m47zFV33JrqbE=;
	h=date:mime-version:subject:message-id:from;

Add the compatible for the pmu mfd on rk3562.

Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
---

Changes in v3: None
Changes in v2: None

 Documentation/devicetree/bindings/arm/rockchip/pmu.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip/pmu.yaml b/Documentation/devicetree/bindings/arm/rockchip/pmu.yaml
index 932f981265cc..9b1919fc5598 100644
--- a/Documentation/devicetree/bindings/arm/rockchip/pmu.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip/pmu.yaml
@@ -25,6 +25,7 @@ select:
           - rockchip,rk3288-pmu
           - rockchip,rk3368-pmu
           - rockchip,rk3399-pmu
+          - rockchip,rk3562-pmu
           - rockchip,rk3568-pmu
           - rockchip,rk3576-pmu
           - rockchip,rk3588-pmu
@@ -43,6 +44,7 @@ properties:
           - rockchip,rk3288-pmu
           - rockchip,rk3368-pmu
           - rockchip,rk3399-pmu
+          - rockchip,rk3562-pmu
           - rockchip,rk3568-pmu
           - rockchip,rk3576-pmu
           - rockchip,rk3588-pmu
-- 
2.25.1


