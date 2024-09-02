Return-Path: <linux-kernel+bounces-311540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F36968A38
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 16:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C315828228A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40E01A264E;
	Mon,  2 Sep 2024 14:44:11 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2122.outbound.protection.partner.outlook.cn [139.219.17.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7A81A2646
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 14:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725288251; cv=fail; b=UcZhWa9jQSz51U7c8hi5KmPPF52/ck9XAX5msWIsLYjA6OMDL8PvjtRyLivX5nk3Tak1EqTnUxREHUbBfrRVZCE1Yl+Xa/khu2MvXlM/BZpswdPY+KXMWBkRSuEQq9Q64ZUWySwiIufiT9manMOD8ZqnxBnbZ0ZUCdqwNXcal3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725288251; c=relaxed/simple;
	bh=u8Vr/FRo7Yy6Gh0YmNokSJAMA6e+tUOE+QhAEtuYuRQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pMhFGPeAwWM5BMi5aUPNpubgVi9Nu00TRfxbm0UDgHwv0PFeqIwATeId+1fbjXFBTwaz5pCTUePQ944Ul6eabHwnjx/kT+IkdbGWbu1kGzFkJLKQ0Jk8XTC4Pj5Ge/dwHaIsZds9oQTfbLhYTAT4XA2lRqABGpB6kS8HVbaxchY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PRTWJ5Vfk96HYYjzub1Cy82F2wZVedyDgeD/zueRh5DU6cNZkKQnCYpFQN2DS2AWI6LxHrrkFzfyN03XLIEIZ38f8JdkIpvyTBKZ/lo7bSqMl5czXdznIXEj1H3yrBTtVr0yAb6bsiMoLSlGTbrQsgNmWp5AhkZMZiwx43rscRDkwYkFN46p8w/tSlq42yajxkrYqXCuv/sHvERd4KSi3c+u0osG2E8rgLXxWwvwTVx4q07bL56JL/4IAtPqNKfZGHW40Ta6NiMAs4swRq1BnQyAeG3MFDovRidAvp+XI7vK0kPz9X3/4PP+orXFcJQam4cAdbWOADmYlUPJfznljg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TppdNoLo2ldaBs2Uz6JCCm/HHs4c6cV+OaUC59fcXkU=;
 b=Rzz0IJfxXcYKXvPE83YsfgFKtbjXq60QX02bKGCHldk4pvUB8ROBLJLN1TYP39UJq/IZaOPDnBmqpzIYWEgvoyrrfB7dJnJuPFuPip+TGKtylsI9UFifg9ZMpHZfB4t4slKTTEHClfzHbbxTiylfTirneb2tbjGHVCM2mvNBrc9t8lAdOqC0P5csw32sjgWBAXYGEZmslR1aHuUEuvznNgB0+JP5L+DEzBx0k8WicaDPuocrPA7oVHnuMGYxEIVMoXDEoEg5lD3V3Icit40RsRMRizUrvjCVA6AAuQ0PLixmCoR0c8KtXc//+FYC/F/g45B9Pt1oWFGVz7X05hm+RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0768.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:24::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.31; Mon, 2 Sep
 2024 11:11:39 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::3f35:8db2:7fdf:9ffb]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::3f35:8db2:7fdf:9ffb%5])
 with mapi id 15.20.7897.027; Mon, 2 Sep 2024 11:11:39 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	linux-phy@lists.infradead.org
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Rob Herring <robh+dt@kernel.org>,
	Conor Dooley <conor@kernel.org>,
	linux-kernel@vger.kernel.org,
	Minda Chen <minda.chen@starfivetech.com>
Subject: [PATCH v3 1/1] phy: starfive: jh7110-usb: Fix link configuration to controller
Date: Mon,  2 Sep 2024 19:11:27 +0800
Message-Id: <20240902111127.15155-2-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240902111127.15155-1-minda.chen@starfivetech.com>
References: <20240902111127.15155-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0032.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:2::6) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0768:EE_
X-MS-Office365-Filtering-Correlation-Id: f66990a5-90ea-4466-b93e-08dccb40043e
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|41320700013|38350700014;
X-Microsoft-Antispam-Message-Info:
	hS3NisPQU6cUXWTFEMyOuP17PP711jEg3R4ESo0JeWHi1qx1XotziD/yha3TkwINkj5sAevtCqhQBrjlLT55Z/W5u6SysVDvX0jivOAgObrSilN9dU9h9thA93sWBql0sPdy7waTdSP0QAZYDCuZdeCxq/pPLJarmeIvNFNRie0BXTfugDGqViPlnr22ljp82DGvWznon1uunDbcKeDMjp5o9iN/aAj6G72L6Y2LMrUw0t3O3lL4bL9+OQwVcS/TzOYAuINXrvkOO/QRxfaPVSeOgFT5uuqLAy2sDBR6yYauXwNH8Nso1JTQtsxJCbYFo309phb0j9pbnBk8K1ZdzygoMpOMPdbYST3kNUZeEJ/y1SYeRFHEZZ7fgq6pJxIxRSFpPKyBWtsvmrgSVj4ZMu42xb52ov1v5r8cvfVGhfE5i3KqULPM/hjrc5nRBfsklWL8o8eHgDeaOHLCFfs+9refEFciY1E60UIZNvlblw6QV6AkJi/ODaOTvfrOVGxWNBOtHxSpBVNfVSV43KRwNJ0/8I33NwzD0it/8AMGUx5zBD9uGy3xRVgujVIN+/sRZsCnBp2agfxE6A4LS0v4I9TB2UEB+7InLi4JtOH7WCL9pSrXim2icrLsb9lCn1He
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(41320700013)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?royIqz+z7hhhxohBMGv5udcPf4OiJ6yKFBhCmczo4CsPpAsOUAWjF4jh7WdK?=
 =?us-ascii?Q?2ZvKDQZ8q7RmYbsC540phFhUI6tEO2vaUNSqqoMphXbgbe9jal6ys4/bLJaC?=
 =?us-ascii?Q?FZAKgSbYIdS/NAkeJSoSuqE9flYFUdw7DHF5amdR+YJsKX1sMrWH9HBWAqiJ?=
 =?us-ascii?Q?3gyTvb2ubYQsHnBDMa99lMZ9mcKVnsCImJy49MJ9/cj4DPmwITDulqEyR0JE?=
 =?us-ascii?Q?qi55bhQBw/5C4cYLa4v0y34Upcng82p+W8w6TFuAD9C03zUbvXem+s0MWSpo?=
 =?us-ascii?Q?M24NHrB6JI7QKiKwiOKDsO/VQJmT4BZ6IPSVUQR4IpTkn+H8TcyVPc7simTX?=
 =?us-ascii?Q?7q/o/Y0DJHWvDMkXNjqKKfuDtEKmSyfJRWBtNInmdstptfq7ky81lI3h6eYa?=
 =?us-ascii?Q?8HcyIrPGPAId7wR5oGgiToxilk3XOmodSW0zAeQBsRS9FQTJso4/BTve6FMO?=
 =?us-ascii?Q?yxoWpJzVL81o1RqM7Vu8cqAKW6KNpPV9XTPPyESl1Rh10kh7w9E+18/R382A?=
 =?us-ascii?Q?Li5xIXOcwhmy1e/AqQXk6I76czI4TDfTR/yLtFGlE3KoGwQuF9qCUw08nTon?=
 =?us-ascii?Q?aU/oA+Rw2BDp1xtJAPsB5im5RKZcTR5uqHJzKY9WqLajmAeHP+iJU19lgfzi?=
 =?us-ascii?Q?fqqFIp+/q8f2nDlMA63RWedjCfqfNyOmcgV0mCNpll/AOydqGLqS79JmRt/D?=
 =?us-ascii?Q?VyCWFmUxSIaT8+KMV6LokVihOVLHmjO8CQdmr4RvH1VM6bDjGfHMKTR3Evqc?=
 =?us-ascii?Q?0MYwE2KVhosSQuisMIIEU9YJFybK7tNg0tSvnw7caAKh8R+8PgVDlERMKP1Z?=
 =?us-ascii?Q?07llFXdoTFemTNOKltv5oPsLamjI1YIflKuGp/LqA0m2+Kt0ydPHzT68EVHH?=
 =?us-ascii?Q?cyQY3wmjR1yS4bVKyergSdYVgDL+Yh7ivJPe5RQP093lvOj+g+xteUwYC247?=
 =?us-ascii?Q?BCb34f7zZ7RZ37tqBgWkzi+tPCQNZuELt2rPVewfd/FIjogkuPy2Vvk3wQE8?=
 =?us-ascii?Q?y90ev6dhGrSKfppj3k364cB63OuZTJH8ku15RgFRtBtoXom/Iv8OPw+cugyB?=
 =?us-ascii?Q?BUXQlIOG4H51oQHMvSSU4xN6Z3au9WZZ4WFSNxG7lta8rSGd2Pmbp5K47Btd?=
 =?us-ascii?Q?VTBxlvl+LFNGYvsGMfjmYSHBK3fdOErRZ2dWyRgwKylvTQ9QZqOhbmd9+HaA?=
 =?us-ascii?Q?EjpAr/t/d/WfTuUXnV0wXo4US2OwjdQP5tR4FTkKVLbF3knevF0/hwkIx7TB?=
 =?us-ascii?Q?4ofANdoEhQvIYMJCwcxfTY06q7q2GqhElVUAubAGjrnVhI19bsKXYTlk9OpJ?=
 =?us-ascii?Q?epj7Vz5XOWnMly/Qq4BWpgbB6O6llGZIbtbTnWaY8HyIJEoCGfwqhayYBFyd?=
 =?us-ascii?Q?eHR6F561WgpPLSYHtpqsR3u744L9aCCgCnOSBjbAwclNo46Q+mSpOAMERDTR?=
 =?us-ascii?Q?QMkLiOeozVTI+pmiPgUmMTcT6apbnzRu2XtdvBUkDiKnPfy7KWz8wPBOz2x0?=
 =?us-ascii?Q?qAK+F6LyUzcO82I5UzW+DYasNUdUOOCQP0T72/iCFsdBWL0SjQzFrF50bjJm?=
 =?us-ascii?Q?5qtQpkwsuRYLwZ7sPck2CnXZIYg7wRJGRREAQ0lzcURBQ+ZV7IkaWlWXKeWa?=
 =?us-ascii?Q?+w=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f66990a5-90ea-4466-b93e-08dccb40043e
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 11:11:39.0522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zsxRcnC2ZpOuKTxqMYnb2qNl8N+3aEFqjm8yp/njM0N4F50e1l/gJ7TXG7oo/9ngx6+1YJu1nDeZtrRRREbFw0MwdaiELYndpqyl0XufgHo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0768

From: Jan Kiszka <jan.kiszka@siemens.com>

In order to connect the USB 2.0 PHY to its controller, we also need to
set "u0_pdrstn_split_sw_usbpipe_plugen" [1]. Some downstream U-Boot
versions did that, but upstream firmware does not, and the kernel must
not rely on such behavior anyway. Failing to set this left the USB
gadget port invisible to connected hosts behind.

Link: https://doc-en.rvspace.org/JH7110/TRM/JH7110_TRM/sys_syscon.html#sys_syscon__section_b3l_fqs_wsb [1]
Fixes: 16d3a71c20cf ("phy: starfive: Add JH7110 USB 2.0 PHY driver")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
---
 drivers/phy/starfive/phy-jh7110-usb.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/phy/starfive/phy-jh7110-usb.c b/drivers/phy/starfive/phy-jh7110-usb.c
index 633912f8a05d..dabe59953070 100644
--- a/drivers/phy/starfive/phy-jh7110-usb.c
+++ b/drivers/phy/starfive/phy-jh7110-usb.c
@@ -10,18 +10,24 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/io.h>
+#include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/regmap.h>
 #include <linux/usb/of.h>
 
 #define USB_125M_CLK_RATE		125000000
 #define USB_LS_KEEPALIVE_OFF		0x4
 #define USB_LS_KEEPALIVE_ENABLE		BIT(4)
 
+#define USB_PDRSTN_SPLIT		BIT(17)
+#define SYSCON_USB_SPLIT_OFFSET		0x18
+
 struct jh7110_usb2_phy {
 	struct phy *phy;
 	void __iomem *regs;
+	struct regmap *sys_syscon;
 	struct clk *usb_125m_clk;
 	struct clk *app_125m;
 	enum phy_mode mode;
@@ -61,6 +67,10 @@ static int usb2_phy_set_mode(struct phy *_phy,
 		usb2_set_ls_keepalive(phy, (mode != PHY_MODE_USB_DEVICE));
 	}
 
+	/* Connect usb 2.0 phy mode */
+	regmap_update_bits(phy->sys_syscon, SYSCON_USB_SPLIT_OFFSET,
+			   USB_PDRSTN_SPLIT, USB_PDRSTN_SPLIT);
+
 	return 0;
 }
 
@@ -129,6 +139,12 @@ static int jh7110_usb_phy_probe(struct platform_device *pdev)
 	phy_set_drvdata(phy->phy, phy);
 	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
 
+	phy->sys_syscon =
+		syscon_regmap_lookup_by_compatible("starfive,jh7110-sys-syscon");
+	if (IS_ERR(phy->sys_syscon))
+		return dev_err_probe(dev, PTR_ERR(phy->sys_syscon),
+			"Failed to get sys-syscon\n");
+
 	return PTR_ERR_OR_ZERO(phy_provider);
 }
 
-- 
2.17.1


