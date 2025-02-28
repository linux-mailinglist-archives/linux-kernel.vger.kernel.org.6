Return-Path: <linux-kernel+bounces-537914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B780A4926B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBFB41893A0F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 07:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CCE81C3F0A;
	Fri, 28 Feb 2025 07:47:32 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2125.outbound.protection.partner.outlook.cn [139.219.17.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59993276D12
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 07:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740728852; cv=fail; b=A9ZR5wxtrOo9IiC1FuMOenE4BRWVu5w5/KBS6ajIDZNuCiJ2S/9TW883on95IQzfCK6o6xi7DZFkOHPigwGcbCUZM20L8CVW8UvNkuFtWmpyKK4wa/SSHhrRwS5GqJ6ta4m/lxv0H6Uv6OinxfHAcalTmfRMLbNSjKot/pAEwvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740728852; c=relaxed/simple;
	bh=zW3pHEUJrJss8mKgQbLuXjwTyCKS8gSyHQ2QC8IRPmo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=u5jbWRUutLLTJTlXQfzNwTrB9uMB4jYt4yKNTOHwdaNa44yr0aelKj/LjCQ3GuyGCr8B0HVqIbiOprLw/n93B6jBczaz5Sr2Ebsfu6aMFTax9M2AafhtXnROhCjc0/9C2VzjDh6FLIykqe6/4K/yMvlXD558wEMyOHErUcOgg9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HeE+sql9hf8JaOX3emt5447SQH44sxgCtzQ7Dt8z6oh7MzObEoPD8MdsbOEkLwSAsyGD0d8euXoIL/eb2APvfAp2kd03cKZ2Ss7ljSEpLr5Xu903S49HAJR6kYQByDLYhuc0YpU1UKhi3puyf1Y/Lg+QjhDEVzPQxlHnsFIayCbAMPoSQ1Jl1oaviHzDpTq3UVZwjrkyh4Z6XiT1682g/QlI3ZeqsfVJz/TnstN1bAwB5eV96Jy0XFSUJm0lyktfyQ9e+Ma7mWhsB1Btyo2e/WewsjWpCaX3xCgcv+Rvfvq28+T6qBkNjB+Dquhw2/RTyHagDx5h4/zLIHlJcurCIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XmRh9a3ROE7dTTrM7ekZQzWTGr8YULqnkpysUq1v204=;
 b=A6hboMiZ8DASa+fWzOuvZ4ZmiN4r3Vfz6IGqod5KPacKoPM4T6W1G3sqp5n76O4xfXrELoL9CPNXtuPD2yV4z0Jof6uBlb4DgyYV1lCzabFcy8wzDlD8vkM16qLSnRAxsBxwK4IEh5sDlJ71mYw7UCEh0rSjpooyHiqKp9iHIofKdeaPtuDdkctPLWHeMJxf8m+tjAAMhSyK/rJaCAG0bgk7P/Pf6oBUFOiDZVB2TKuzntuQOO2Uf9aKKXD3ipRGnQJ8XouzhR7JIrXGotpvMgk92ug/SoudcF/s4uCRuqLUJ4/yY8DjNtrqj8FD02e1/zLvWQYZ0ox58W/KFGkGXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::9) by ZQ0PR01MB0984.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:c::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.15; Fri, 28 Feb
 2025 07:31:38 +0000
Received: from ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
 ([fe80::64c5:50d8:4f2c:59aa]) by
 ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn ([fe80::64c5:50d8:4f2c:59aa%6])
 with mapi id 15.20.8489.014; Fri, 28 Feb 2025 07:31:38 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	Keith Zhao <keith.zhao@starfivetech.com>,
	Changhuang Liang <changhuang.liang@starfivetech.com>
Subject: [v2] phy: starfive: jh7110-dphy-tx: Add missing clk_disable_unprepare()
Date: Thu, 27 Feb 2025 23:31:27 -0800
Message-Id: <20250228073127.635755-1-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0014.CHNPR01.prod.partner.outlook.cn
 (10.43.110.215) To ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn (10.2.3.233)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB1302:EE_|ZQ0PR01MB0984:EE_
X-MS-Office365-Filtering-Correlation-Id: 9209957d-bd5e-43ab-ba4c-08dd57c9efae
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|41320700013|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	MqRyXDvQ0xCwin/tztuLJrXytlw0dn9P8oasG0GeXR22I0wUuN4lujVwbQE5SLzmlPRvSpL9RK3ppVci3sOy7dU7yjz+JTxSrZbeUg/YlpxAxnRB1k+gvwdYZPLhEsiotBr866P2JhZHCcomnf8n6JWsk8w9d57f+WuSWCQ4KsnuLLN4jcbOhUOvewz7cHvtYxRMAmKK4/622K0dQQizjvgqvliNkHRUeewCccHbPwcGEjMVjwuY1IZDqCTSZaTvO0HLZ1tBWN+6U2MRgDLfowmQGqxh06LiJ7KNdThvqgzXjOBpZa4C0MiAdlKNMiBNJ08xaLeFlKJelrGWgsbxv0xIQq7xE8VcHbPieeHJsucWRIDCiBUARmCApOC15csYDgtPkOfIZ2hJsg+tpOMhI3WjNlu80UPK/EFnyKy7bewDBp7ZbMjVWNVkF2naL0KMwZeGbyOSU+Lw6e+zySUpZvvISEz/h04ZWM0+7y2nC+z3wXsDv1Ici+Zc1JH8+ao317RvZJTJiOJZnRRpJMLa/C4K7ZdIfltlF7nhzNxcvZfaVBxGfnnC9hBYxGzD/9V60f2S00EEPOMxjdt1xnyQyw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(41320700013)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zabb8CnuFVo0YQRO7vB48KA511OX6G7CCcd9OAgKwdGIR0pBjq8BPl0ixMRf?=
 =?us-ascii?Q?V5fkEYrG0esYYEfdgxHwraenSFK2kmNdfIl1BB8e4DuLXw/at7WqGHtZwZjg?=
 =?us-ascii?Q?lkfR3UwnwD5ixJPEGNWjL/gRQngwuqxAk5hGbs0pMDE8Y8aCjafPVkpcGNSD?=
 =?us-ascii?Q?sVWfnnp1T2CkgwLyfVLpJbzTOwZWjYRhVa6WfUVhZlT8upL4NJyx6bnJizX6?=
 =?us-ascii?Q?L56klZv9Tc6dlhoyHKJJnsZckBmgf0zPWWhoGo4OoKPAuttza0mPlbRqVZuV?=
 =?us-ascii?Q?Li9hgoOzWAz/ETFrJBNWkRJss0+uGHsD/jAesqk/dG4POSKvR83POwL9NBDA?=
 =?us-ascii?Q?uzrBF4kFtiFFqASe26WLxVeWJCiPLUGMSgDk6DRPnsd0zJQn4m/8tqdG9LAF?=
 =?us-ascii?Q?nn7prgH05FVscsQ/aIRrCNGyiM7L6v3ux7R3Q1mQO64Uo9QbqQTKokn7023P?=
 =?us-ascii?Q?ckrPVGgjOrkIpLGGNip+T2Bq0v2RhZV1mCW32HqOXS0hqEKhTs/xg5QJHn0/?=
 =?us-ascii?Q?SMw/HhCtahUOQl052QlpaS/RP92Jv+lRSinv8+wYWPL1Vr8H8S7/yetWfPLt?=
 =?us-ascii?Q?boHGRG6PcvO/jLYENTauGNCeJx/jP9DbqC/cPDWL8d7fE3BbB9DniNeoLdTS?=
 =?us-ascii?Q?5mHZpxh45iwEe609eU/2V2iFJl3/9YwN0FLo1NFG3GgW6m6hZ2Z4LwcJNK/k?=
 =?us-ascii?Q?wU/s6Qbtj2YduHRtqQGmZ5kUy5Coe517744PFjVf4z67K/LF9B4ban7bSIsu?=
 =?us-ascii?Q?brtu4eDVOwfhBKK5fUYgOw/65Gz1npc9IIXFAM1OkqYhmZFxv4NmN8pNGiEJ?=
 =?us-ascii?Q?q9/Hu2pBqNl5bTahoA+hFlPFl6/KIIc/jcl1hoWT5vrmb3y5xN/HwxG38dmc?=
 =?us-ascii?Q?loVtfmd5hst764CwxVT68N+ST0TI2H7Ufsb3gM7r568D3ZRUQHRknEwIkE3F?=
 =?us-ascii?Q?L76AJbUIauUC7sHYHUKL2xzzdJkdcFrI5bsXv2pl0291E82APXVD2OZF5GUo?=
 =?us-ascii?Q?lCXSDrPoCwTWe6KPGXp4zcpb2BkoPcy8QhidZ5QIfsfmWKXlbNssVXNIvrx6?=
 =?us-ascii?Q?BIs/np8tsTy6djKDQn96xUBY0yJ2L8gDVLnsKCXCGUgzmMhb8NRBohjsEb+I?=
 =?us-ascii?Q?rxYCZ8omowKVnPoIs62scYtnf7NsDju2Qn5piInOzBvJrbUwRrp6aTi9XNcz?=
 =?us-ascii?Q?JbUnNjEQi8iBtq0P0JUKwZ9jjduVF1v/W4zntcHdZHq078oFcdU4Mf8ph9lx?=
 =?us-ascii?Q?1SEtFWbZaKtZRBQCK1HyO3NNAdemRY0y5eX6FWZk+MZ50OG2ZN1wc2X9mXM/?=
 =?us-ascii?Q?uAJ4gz3/Gd2L20ZoWkuzD68KgV10QMlWsZ+e149/9CKIMhmV56zaiyKFuF8w?=
 =?us-ascii?Q?Yw0HqD0rVIoZ+3ASWuRaDhxoVeu+Ct+pSZx6dFZYtuc2GN42QfK6UfbRsdvI?=
 =?us-ascii?Q?jMzOI15WI0FjI0mIqLRKzH3aQiomtaLMOq5QwvRDJNCiLz/MtpIkMLf4vIho?=
 =?us-ascii?Q?TEaOwjnfknNDDAbCUfTvJp0gjVKm+gSxFGMRJW63HzVYYft5nogz/+/ayRpe?=
 =?us-ascii?Q?a5k0uzStRmhj/n51rCnzmawxUH2hYzmoD3gzRdl6kn9ahwv5xiGzpeCKJsu5?=
 =?us-ascii?Q?GTYBRpBr4RmA1hTi0yivXtM=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9209957d-bd5e-43ab-ba4c-08dd57c9efae
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 07:31:37.9550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vbTTYD6HFfWxQk3Ny8QB1hl9s8JvQbVWsMBo2aGvDvfSP0f9x/Jh9VVRJ8CM8UAHLWrfwSetkSho9asD349jFMHrrLKB5bFbLe5kM2bEKLg1RjI+DpL6Ht5hhxk3aEe6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB0984

Once the reset_control_deassert() fails, we need to run the missing
clk_disable_unprepare() before return in stf_dphy_init().

Fixes: d3ab79553308 ("phy: starfive: Add mipi dphy tx support")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202410310715.duo3ShR4-lkp@intel.com/
Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
Reviewed-by: Keith Zhao <keith.zhao@starfivetech.com>
---

v2: Add Keith reviewed tag.

 drivers/phy/starfive/phy-jh7110-dphy-tx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/starfive/phy-jh7110-dphy-tx.c b/drivers/phy/starfive/phy-jh7110-dphy-tx.c
index c64d1c91b130..7b59496983d2 100644
--- a/drivers/phy/starfive/phy-jh7110-dphy-tx.c
+++ b/drivers/phy/starfive/phy-jh7110-dphy-tx.c
@@ -330,6 +330,7 @@ static int stf_dphy_init(struct phy *phy)

 	ret = reset_control_deassert(dphy->sys_rst);
 	if (ret) {
+		clk_disable_unprepare(dphy->txesc_clk);
 		dev_err(dphy->dev, "Failed to deassert sys_rst\n");
 		return ret;
 	}
--
2.25.1

