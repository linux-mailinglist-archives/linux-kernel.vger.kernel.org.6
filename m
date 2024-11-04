Return-Path: <linux-kernel+bounces-395464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CAB9BBE35
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 20:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D7581F22946
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 19:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCE7192D7D;
	Mon,  4 Nov 2024 19:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJN5lcrH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4481CBE9E
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 19:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730749396; cv=none; b=p5rLAiXY8GGDAr+p+Afujf4ZkeJkJylOjf3sbxojiJi1Ds7AkNR3lvOMQfaj1l4Jg6epa+0j0rgsKyNwqTufW4yz8Casy8RLJ3M+qIM7dCm1HL8jfGSZmkWtfvSD/JbGtAJHJR+Gl7Kd7efs5B/LClIlThbq5085MGKZrZ4CuAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730749396; c=relaxed/simple;
	bh=Hm1H/22MmFwgZBIeoAEvCZhK8r00qON+EuqF4n2bpoI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ix6DnwoSfzUJPf4IWVOGKuJAzgH+UybkVtnuzNtqpMtAeMwhRvAW47X5RlQZQP8510Zkv+XB7e83ZYVK/0nWjTIQNTSNoQd4Xn53MmaPqh/oUHLQ+2ds8pmRLUm2DYgwxOATZj3Jc8JzefH2rgHQxOvdrtA/xJCMcBF7OskY4nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SJN5lcrH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0232AC4CECE;
	Mon,  4 Nov 2024 19:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730749396;
	bh=Hm1H/22MmFwgZBIeoAEvCZhK8r00qON+EuqF4n2bpoI=;
	h=From:To:Cc:Subject:Date:From;
	b=SJN5lcrHmNEKd6OtVn5Tiq0Klj3va4TiOWaq/g6kDoBVSlRsYGv+eVHk6IhdS24et
	 /iAzm2i6cqIH2QGVlEiRxh7zADPJb5NY+SWR772vafl6eT8pcgAOJ+kK9+Jk3ogFkz
	 ihExdcktwWako1TqvmA9kHE9BcOSXgr1g6O2mn6P3l/d3rjQDA9lGWc/qNNbb+MFDI
	 INyuS8QK9ZX3nGZYbVFoTLsiWbrmdRHhyk/BbXiyZ2WA4ijtGRpasMhJGjn7jWfz0l
	 oqBO5GUlTsUojpzrnAADNvBoewYMerSxStSnybI+nD70VbtBeC0s/g657u3PEZCRZh
	 I/X5Y1xD9ySTQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Joe Perches <joe@perches.com>,
	Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Fix list entries with display names
Date: Mon,  4 Nov 2024 13:40:34 -0600
Message-ID: <20241104194033.321817-2-robh@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

get_maintainers.pl doesn't expect list entries to have a display name.
Entries with a display name are omitted and print just the description:

 (open list:PIN CONTROLLER - FREESCALE)

These cases are pretty much aliases to a few people, not lists which
are archived and can be subscribed to. Change these cases to be reviewers
instead.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
Maybe get_maintainers.pl and/or the tests for MAINTAINERS should be 
fixed as well.

 MAINTAINERS | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c27f3190737f..13aedadb3262 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2797,7 +2797,7 @@ ARM/NXP S32G ARCHITECTURE
 R:	Chester Lin <chester62515@gmail.com>
 R:	Matthias Brugger <mbrugger@suse.com>
 R:	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
-L:	NXP S32 Linux Team <s32@nxp.com>
+R:	NXP S32 Linux Team <s32@nxp.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm64/boot/dts/freescale/s32g*.dts*
@@ -16417,8 +16417,8 @@ F:	arch/nios2/
 
 NITRO ENCLAVES (NE)
 M:	Alexandru Ciobotaru <alcioa@amazon.com>
+R:	The AWS Nitro Enclaves Team <aws-nitro-enclaves-devel@amazon.com>
 L:	linux-kernel@vger.kernel.org
-L:	The AWS Nitro Enclaves Team <aws-nitro-enclaves-devel@amazon.com>
 S:	Supported
 W:	https://aws.amazon.com/ec2/nitro/nitro-enclaves/
 F:	Documentation/virt/ne_overview.rst
@@ -16429,8 +16429,8 @@ F:	samples/nitro_enclaves/
 
 NITRO SECURE MODULE (NSM)
 M:	Alexander Graf <graf@amazon.com>
+R:	The AWS Nitro Enclaves Team <aws-nitro-enclaves-devel@amazon.com>
 L:	linux-kernel@vger.kernel.org
-L:	The AWS Nitro Enclaves Team <aws-nitro-enclaves-devel@amazon.com>
 S:	Supported
 W:	https://aws.amazon.com/ec2/nitro/nitro-enclaves/
 F:	drivers/misc/nsm.c
@@ -18244,8 +18244,8 @@ M:	Fabio Estevam <festevam@gmail.com>
 M:	Shawn Guo <shawnguo@kernel.org>
 M:	Jacky Bai <ping.bai@nxp.com>
 R:	Pengutronix Kernel Team <kernel@pengutronix.de>
+R:	NXP S32 Linux Team <s32@nxp.com>
 L:	linux-gpio@vger.kernel.org
-L:	NXP S32 Linux Team <s32@nxp.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/pinctrl/fsl,*
 F:	Documentation/devicetree/bindings/pinctrl/nxp,s32*
@@ -19373,7 +19373,7 @@ F:	drivers/ras/amd/fmpm.c
 
 RASPBERRY PI PISP BACK END
 M:	Jacopo Mondi <jacopo.mondi@ideasonboard.com>
-L:	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
+R:	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
 L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/media/raspberrypi,pispbe.yaml
-- 
2.45.2


