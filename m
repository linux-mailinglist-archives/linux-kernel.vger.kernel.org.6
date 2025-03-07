Return-Path: <linux-kernel+bounces-552100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79072A575C8
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 00:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3255173D0B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 23:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBD9258CF8;
	Fri,  7 Mar 2025 23:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o/uCB8Zm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6766DDA9;
	Fri,  7 Mar 2025 23:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741388952; cv=none; b=MlVpdLqT17LWDRonCo9R5qNd0dLkZQytK+UB6gpFOoXJyTNAriJNFAOpK2/gP6cyD8lPrbQSwe/Y+8dJvi3Usr0fzJLM/M7ijNncrWERzGFThAe+rBT2IkYmrK4jSA40tuMzLyV+iwW6a45EL/sUsaaFemk+MIP/rOlzSrlY8gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741388952; c=relaxed/simple;
	bh=73S5sEstMJgBasmeBcr0mNwdZz9zkyWoBmdgOYOPhrw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GvZAFcEB6QtKQ+Xy03NGzZiFaQpJcJGnromArQlgvpVUzCoIquC8E45R3t30UyttViEaoPzjn9F4pTV5qtBdU3PrDUUJIM6/CPKsja6ROkd+688XgxX2IS/E35qC8N3+DFywktYL8NcyPW3kcdZD5TQBIyPze5Z05t6O3NVUzGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o/uCB8Zm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88391C4CED1;
	Fri,  7 Mar 2025 23:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741388952;
	bh=73S5sEstMJgBasmeBcr0mNwdZz9zkyWoBmdgOYOPhrw=;
	h=From:To:Cc:Subject:Date:From;
	b=o/uCB8ZmPIlVRANoP9T/IOxTiaI0puWrAzsJjV2mfX+oSXCj0fCLIGuf+JPW38S8l
	 OfpVdYzZyoyotTi0Kx2e8PHf1jcMxAMQXm1zLLAbsv9VCtEA6ZgUYEkE4kyes+1rx8
	 z2qgHT/YP8KqDGeBBJJvdCQ2GV/yGzjMaF+hzvaZz2qPTRSgXrwQY+y79YUssCqlfm
	 IiGlGp+PrHEMtjzrpNFDh/kvbuBTXOPi0YDAMzEbkd0LGMw72G5bvPtJY5XM90Rzx6
	 t6LoFpuZVtIBww+4uyLKxdjgZjphNq82G6iYMsvk64DIisEEySaCslCGn4Yk6nRD2c
	 pDlhTEzs10+WQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: trivial-devices: Add Maxim max15301, max15303, and max20751
Date: Fri,  7 Mar 2025 17:09:06 -0600
Message-ID: <20250307230907.840875-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Maxim max15301, max15303, and max20751 devices are all simple PMBus
devices already in use, but have not been documented.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 91a19faa8d9a..efe844be8700 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -185,6 +185,12 @@ properties:
           - maxim,max5484
             # PECI-to-I2C translator for PECI-to-SMBus/I2C protocol conversion
           - maxim,max6621
+            # InTune Automatically Compensated Digital PoL Controller with Driver and PMBus Telemetry
+          - maxim,max15301
+            # 6A InTune Automatically Compensated Converter with PMBus Telemetry
+          - maxim,max15303
+            # Multiphase Master with PMBus Interface and Internal Buck Converter
+          - maxim,max20751
             # mCube 3-axis 8-bit digital accelerometer
           - mcube,mc3230
             # Measurement Specialities I2C temperature and humidity sensor
-- 
2.47.2


