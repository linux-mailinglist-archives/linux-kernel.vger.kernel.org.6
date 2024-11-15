Return-Path: <linux-kernel+bounces-411226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5759CF4E9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 20:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 062321F223EF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 19:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628FA1D8DE0;
	Fri, 15 Nov 2024 19:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N6uh53Yf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3C613D297;
	Fri, 15 Nov 2024 19:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731699260; cv=none; b=gWUNdQqkuRzhuv5HsR8OLmMK7i7rn4p3YoLJi4ZuNnTfOHZFcHONRjvZ7LXGO/zzXTaiSNsKmwiyk8Qi3JK9VsFVCYmp/shr7LpY0Jbrx4sHT6sS2+ExNE81irxikttMMGYerRcmf4/Kavo+bDmzmLgrDxpf+8vCbrla89OEre0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731699260; c=relaxed/simple;
	bh=BMh91x6fdW+iPlP/TfZkJMe6h/0iafW6RsXUcY+WgjU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aDK6o/2qo/k55rc5nGmyCSvJjLU3/ngOB5NnL7vkOWvpsvSFQSRuXBmX6ulvI3AAJJCFPn/Voqbrfl2mAvbTkxcG1gvHHDMr6GBQdXKvO57jJD/Jypgm4QVWVuhZbJaQhTET2Erl/wllvoEk/M+PIA+3tmbRT05mDEjX70yQyc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N6uh53Yf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27825C4CECF;
	Fri, 15 Nov 2024 19:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731699260;
	bh=BMh91x6fdW+iPlP/TfZkJMe6h/0iafW6RsXUcY+WgjU=;
	h=From:To:Cc:Subject:Date:From;
	b=N6uh53Yfz9TSFNQA2RwOzSquGK2DjOmPQ19At4SUXYaWaanwfZj72sqAYq6HMhswQ
	 M8NNEin3Y/9N8D6ZH7z4ppYlPHbgtA+k3/Mj4nK5+GfUBkDpWchpcArIC6k9k0jeWF
	 8iKhdgXAyk2B6y2rvxzg+l89EEyOKlwDZbewtWdrUBnUxeFIJ5qsy3aElRpVl1HZql
	 iLPga8IdOpiFf7m4Z4wASqS0QTPjuUGDyIuRRnFknnt9QmU8K4i24U0OH6s5z5/loG
	 g4AL5L/ymrJ7jemNk0A7CdzaelDu/xYNNdDBWqncxOqYwOKcAPJLXlG4InKxSAe6hH
	 7x8pxv9nJiTSg==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: sprd: Remove unused and undocumented "constant_charge_voltage_max_microvolt" property
Date: Fri, 15 Nov 2024 13:34:08 -0600
Message-ID: <20241115193409.3618257-1-robh@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove "constant_charge_voltage_max_microvolt" property which is both
unused in the kernel and undocumented. Most likely they are leftovers
from downstream.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 arch/arm64/boot/dts/sprd/sp9860g-1h10.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts b/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts
index 095b24a31313..e60838695d0e 100644
--- a/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts
+++ b/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts
@@ -71,7 +71,6 @@ bat: battery {
 		compatible = "simple-battery";
 		charge-full-design-microamp-hours = <1900000>;
 		charge-term-current-microamp = <120000>;
-		constant_charge_voltage_max_microvolt = <4350000>;
 		internal-resistance-micro-ohms = <250000>;
 		ocv-capacity-celsius = <20>;
 		ocv-capacity-table-0 = <4185000 100>, <4113000 95>, <4066000 90>,
-- 
2.45.2


