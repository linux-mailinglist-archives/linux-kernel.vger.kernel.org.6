Return-Path: <linux-kernel+bounces-384869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 476699B2F9D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 13:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8546B21A48
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 12:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D931DC74E;
	Mon, 28 Oct 2024 12:02:23 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4021DB92C;
	Mon, 28 Oct 2024 12:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730116942; cv=none; b=jr8f5VE65iiCNjhZ80jSvY303yLckUzP5iGTS2pax4lLgGxQ3webSCOjGLwCfxElv5fPinG5TMQ9gffqLVNQ4Z6yInmgRpIJUfZriM+XA0sMXKTytA0Q+uMpS4meuy6y3p1RGBdccDqKcgeig0+NMMAew1rBG5qU0jjjxqOdCAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730116942; c=relaxed/simple;
	bh=YFSoil/wyoPbsUOnERejF91RTgrdSIFDhVBcGJK0dE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U9CtNy+2z8+jl4sEW9ykAJ1GkDKpIrPMmQ8h+xBR1f8KSMeirAqvWEmnk+5RzWtUNNk5eeZryoIKUj3UEgU2mobzImPAjE8Rakne7P0KQBdYNSpeVnJO7TAeE/QsYp8RAeuM7Dr8WkNJc7+EbTtzJ1ZpFQ8UVXmIliLfyxSkSxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D9CFA13D5;
	Mon, 28 Oct 2024 05:02:49 -0700 (PDT)
Received: from pluto.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC5A93F73B;
	Mon, 28 Oct 2024 05:02:17 -0700 (PDT)
From: Cristian Marussi <cristian.marussi@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org
Cc: sudeep.holla@arm.com,
	james.quinlan@broadcom.com,
	f.fainelli@gmail.com,
	vincent.guittot@linaro.org,
	etienne.carriere@st.com,
	peng.fan@oss.nxp.com,
	michal.simek@amd.com,
	quic_sibis@quicinc.com,
	quic_nkela@quicinc.com,
	dan.carpenter@linaro.org,
	Cristian Marussi <cristian.marussi@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v3 6/7] dt-bindings: firmware: arm,scmi: Add missing vendor string
Date: Mon, 28 Oct 2024 12:01:50 +0000
Message-ID: <20241028120151.1301177-7-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028120151.1301177-1-cristian.marussi@arm.com>
References: <20241028120151.1301177-1-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recently introduced max-rx-timeout-ms optionao property is missing a
vendor prefix.

Add the vendor prefix from the original committer.

Fixes: 3a5e6ab06eab ("dt-bindings: firmware: arm,scmi: Introduce property max-rx-timeout-ms")
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
Note that this fixes a commit that has been merged in v6.12-rc1...so it
should not present any backward compatibility issue.
---
Cc: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/firmware/arm,scmi.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
index 9d6e1147f9e9..e331da4d606b 100644
--- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
+++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
@@ -124,7 +124,7 @@ properties:
       atomic mode of operation, even if requested.
     default: 0
 
-  max-rx-timeout-ms:
+  nxp,max-rx-timeout-ms:
     description:
       An optional time value, expressed in milliseconds, representing the
       transport maximum timeout value for the receive channel. The value should
-- 
2.47.0


