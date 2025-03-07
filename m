Return-Path: <linux-kernel+bounces-552099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55EA1A575C6
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 00:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 905D9173C5E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 23:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875C3258CEB;
	Fri,  7 Mar 2025 23:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FPWSd8n5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4424DDA9;
	Fri,  7 Mar 2025 23:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741388943; cv=none; b=is/GRITfPKiOuTJhQS4M22+Fr7tG4ZR+i42xDeCTRQOSrU18hS9V9haI9pTz25Nnt3F7D956rkD4cR+zTMmZq+f6cnxxxvIV2tHobfembnXEpYKCCoI5eCcSlTZzbD4Pp3divYp7INQ0acNs9g8DgXAUd0frC3uc/98ZahKrkOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741388943; c=relaxed/simple;
	bh=SWngNpvfoVlVgcBR4hFmGJMigdNQB1Sp49LCsQ/7HYA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LE+0QC1u0gPl985W9oYkYQ+E0FdDs3REz85Nn1uwD20m8WKhMYkuGnsrbS6t9MCdH4Mpp3u63vGzg5lLyvmsYkiTaVeymdUYly0OKw4HSu/j2/zfyH6chB8ONDRHS6zg05rOjwZn/vDDdgTUJlI9DLVdDATDRNFYkcNFNxVztUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FPWSd8n5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46EB7C4CED1;
	Fri,  7 Mar 2025 23:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741388942;
	bh=SWngNpvfoVlVgcBR4hFmGJMigdNQB1Sp49LCsQ/7HYA=;
	h=From:To:Cc:Subject:Date:From;
	b=FPWSd8n5BuZkIDklMoy1kK3/422umDZWY793TDeNtJmB3hbGafi5s0GMMpvBiVarY
	 FRz97cd30b0jqBidSKFgVts18+Bw0gA0GcQu+xlT+fVcYiHiNvxL5/+QI3rPd+BHK+
	 PyHTH7aODKq0ptmL46PlnTKtx3g0P0NEs4NBxNoZyOJEr3rwZCDXTrgcWiyEK9mkwW
	 wAPqWDWFmmFoWEiDjEbzRijx7TCpSUefOiRZVsnvBCnOgmZP7SfxHFpHbZAOSD/D12
	 0khaMUtmsY7oIwQoKf6ZbqqUgsdR+0weDx5+yKxiKpMkRiMFsTZdeeD23h767WnXtH
	 0GvPTjCfxq5gw==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Eddie James <eajames@linux.ibm.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: fsi: ibm,p9-scom: Add "ibm,fsi2pib" compatible
Date: Fri,  7 Mar 2025 17:08:21 -0600
Message-ID: <20250307230822.832936-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "ibm,fsi2pib" compatible was originally in the binding, but it
changed to "ibm,p9-scom" in the end. However, both compatibles are in
use, so just support both.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/fsi/ibm,p9-scom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/fsi/ibm,p9-scom.yaml b/Documentation/devicetree/bindings/fsi/ibm,p9-scom.yaml
index 8cd14a70bedf..b106f5212ea9 100644
--- a/Documentation/devicetree/bindings/fsi/ibm,p9-scom.yaml
+++ b/Documentation/devicetree/bindings/fsi/ibm,p9-scom.yaml
@@ -16,6 +16,7 @@ description:
 properties:
   compatible:
     enum:
+      - ibm,fsi2pib
       - ibm,p9-scom
       - ibm,i2cr-scom
 
-- 
2.47.2


