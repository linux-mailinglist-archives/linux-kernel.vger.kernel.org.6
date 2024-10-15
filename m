Return-Path: <linux-kernel+bounces-365213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF36699DF11
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 09:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFABF1C21843
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 07:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51C919F104;
	Tue, 15 Oct 2024 07:05:09 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2107.outbound.protection.partner.outlook.cn [139.219.146.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F038137930
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 07:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728975909; cv=fail; b=HQL1vjr8C6gN3LpN1gbbRGO96WUDlr1lTt+Cf1USp/NZBtweyqWm+imwUIcBGCRW/1Ynd5WApFOlMtD0gDt5oORKzQOYgbcZaqRofEOW7aBwxG9mUB2JFcs/ryXcCWAMlo0M6LdVCdeumBL0bO4ArCPiBtp/nGuVKiOmZOY+Jes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728975909; c=relaxed/simple;
	bh=1rrjlcapHSqYMhCJQ47iogDvi4yTRi2uNa+8zNmczj0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=bYEu2gs7bQz6ZpSzsaYZt/O8a8tIOVni4OcwoaotcdAN82fdk7eYYPoknXXCebfnZ3bo0EM3Kh0e+XcSlkkswONNClrll/C2q4r8D8DxwjjQ8eYP9sCDtNFiA5IFLVIqPqNOxrQ4F+bI7XVLKbx9iA7xaY7kPMupd0Xyv4pZt5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EoFnRfivQAoJRbN1SfxAuaw8eaY3nKKR1wWjC7VvFFNQf3+K/GHmgxUKS6RpACLyQX7dyH8XhPHiPK/cEgDta//RbRY6kLZCljWMF2jvm+S4M9GMdg8VRmH6IXIcoeQMU8sS/FhzXMQGmKlomkI88EihlPfdQyrqD2P7OENlquwmcY9sRZehYQ6ITiw/DzgMjfoDAQG4D/SEpYGQGGJxgILScEIUNjPRDRvRmMGzdckQyHQw6/otsHxj6vqbGLgW0/RoV/wSH9ugsoB8b72CNwOaqzdOLyNFft1CfFZ7+yc6i2JNtK1U0+Yv2UNvudjH2deAwge+MiNSJ/HClCkUPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H31t3dvzwbJ9lVE0xEm6IYk4OdSIEHP853O2EZM+Xs8=;
 b=mbsZsW5YPJohPrlDNKABxG97Jp09u49h2IfADjPz9yOqZ7uYviMgk0wkapT9P3sInV8M1u3Z1USuKSXXhSx3Ipn7WFLHdvVq3BvKUS23Dbmj924VLFk5wa+yHuh+a+qKX1TodP8ThFVlvN8lH5pEPoC2J527fGBfwvmksDzmxDp+ZSFtyoMJSp6ESVbk7jjDv+SJNRXdRsu+K1JvpAU4LT5AekSurS5dgP2Ga4XWY34NKj00sdVfRXLGk4GD5Fls/XR9NIbvZYOaH2eE+tf3JYSlVpBpOXhVWQMFGWitOvPLMaJgrUv0dPeEp3/9ErLppCXtihFxvieUShfsYp1BBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn (10.43.107.79) by
 SHXPR01MB0496.CHNPR01.prod.partner.outlook.cn (10.43.109.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.27; Tue, 15 Oct 2024 07:04:59 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::3f35:8db2:7fdf:9ffb]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::3f35:8db2:7fdf:9ffb%6])
 with mapi id 15.20.8048.020; Tue, 15 Oct 2024 07:04:58 +0000
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
Subject: [PATCH v3 0/4] Fix configuration for on-chip USB 2.0 support
Date: Tue, 15 Oct 2024 15:04:43 +0800
Message-Id: <20241015070444.20972-1-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0014.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:5::19) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0496:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f09c5ab-65db-4ccc-f306-08dcece7ae2e
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|41320700013|1800799024|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	9bidlKSXafkyg756490lYe3OljEZQMT+e8O9XcnQJHCJk9JpMA76bzDe7GeRMpNrJgRkt9Mr5xemDJh7JYXi8i5QV0dX/llGXDGrj0QoKtCfWpIsoLhjjj+uQ4Oc7n8juGieubxHcfpdgnmGUovkBE4M7iAw5iH+BwY2FP7ZqrfHVKAKRJWofHm3q+cZBHRG6lqeVZCURSED8KoYd5yvf9eY8a3BR/Ltc9LlJCslYOb7ILZ7WfMoXHfiMa7fuSKCWAVTvDq6yR1KluyPjzT8dtP/fJFlhmCFrgTOs1KAAb6u85epJULHK6MeuYDfP2vlkV4BeAwjhsGebz15I2zsMfFlky5s3NpKq/OCBUuG7LdtXTd/ot2Tlld081iK+K0MXlwA82i6DbzYiSU46v8E1NR9aQIzbeGhbmupWsObiWGBpPzgYCPRkSpKXMhXkAWZZ3XXIw3lsI3/o/xkwNH1ndLydz70rLs48OzDdNnJVwtIZcA5+R3dKuN1kd8Q9Fw2bCZ+Z5qEdDn9qL6Z06vSaEQTZdyjyYuv6MxIXHHwASw7wlEhd2nlbMSTxiqD5SCpdcacjhb09nkZVVnIwR/3iJLtiuFNsiNqvikC7wajKUT6edCoIeAPvxfDYA1hkySt
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(41320700013)(1800799024)(52116014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IsHcdY2/CMWgVW+WXHm46vJMWqkmscWRQhMKp88f8UK9fGmCbqLYV84fzQSb?=
 =?us-ascii?Q?elzcqOIWwU1t+ZVL6wKGhsLXzmBYNeYb4GvOwXpb6ZAejE4+rbXFtfXJEwOb?=
 =?us-ascii?Q?srteoYwv5ih1oaDqp/NvNorroncLATYefA/82TOYOV2lda0vNfhY71D8C5hJ?=
 =?us-ascii?Q?7pIrAzgUem2vjhzezY7O0GMkhK/VSq5kKgjGu3hlysgp9Bhr0+0l5yxiwQd4?=
 =?us-ascii?Q?yL5U5s+p5bPRAYch9u1HXTxHqpJpUi3qePrDUK4jse5ywWrT4aJXDbHoGKAP?=
 =?us-ascii?Q?50IAk6nL7L6Vngo2MRffKP3FXJ9QVkbxz1+kr9ccZPEORI55kCKJXaIkAlk3?=
 =?us-ascii?Q?Kp1viBdSSJP39XNQOFQS7e+m0vmsL1bt1wIYyme7wqe6HoO4d1WLBixbleRZ?=
 =?us-ascii?Q?tU9PlE5Wg0MsybGsSHxnoWnMipD6Cfw3nbcXebTL7qAfoc5mUvU6mzOcXRJm?=
 =?us-ascii?Q?/7q8XguRfYTh+i1C5mt/CBYmObfLuZX/DGWTd5RdmznuXENlwDBxeUrcdBoF?=
 =?us-ascii?Q?LjQD6Mex8KsfLKFP0BbGyBYNqUlZWnXjxgBstCeABo2L3Lt6O3s5/13F+Z6+?=
 =?us-ascii?Q?kTbaQHj+pZ0cBbOOjoNW/fy9U35PjqBvs+zhqVHuqqX3bNdybZ+V1U9viTVp?=
 =?us-ascii?Q?RilLTVKgSizs3qm7rILzXUlvNNhBOitBtFBF+8qdgOg1jVliJnb3oV3ZbqzV?=
 =?us-ascii?Q?gMnG08PyJw0B+EAQLrsUbm4OMIuaLRmYk3em9EBssrn03GUJ4Fy/fVQI+0JV?=
 =?us-ascii?Q?LhLLz9rfmgkmuDYf8VOaOokXM3LT9+tffpGrqPHuEndLbQFVk6a1/5fB/ZPG?=
 =?us-ascii?Q?T5MfjG7dp0z7dM0Zz5pzm9sBQxtONd8mnNVznZg+KKEDc16f62plLEMRLapn?=
 =?us-ascii?Q?sSpqBipdz4AC8nRAe9S0t0/zwyhC3HFfbPo4wm2kOpyTAqXfaFJIcfyzbWHz?=
 =?us-ascii?Q?J3gEWhwYc0e3xlsBZAjjsZ9nMv8JO+DoM498wwWLMmEstLRmlAHMvqTo0wNw?=
 =?us-ascii?Q?8B2gs0luf0IaUzG6xhAvO8sX9uwCrJJoyAACOZi9vjYDCTuiDaL7hT4jHps9?=
 =?us-ascii?Q?hOjW5osJtAoT+dWLYAenHwRtBI1zqGh+wZrqZqDyLAggLpFEvMQDot+xkAAh?=
 =?us-ascii?Q?+IGYSuDekkyaThM3eFttUd16mqZKQrTeOYRDrY+sX9+RfUQs4V7ynEnZ+zHO?=
 =?us-ascii?Q?jF2k2Z7tZL950RKU1fsLmjYCjQBj+7+EvCQEbfza+rUEdefJw+/dEWgVI9+D?=
 =?us-ascii?Q?rFsRZbkFS0KFzFHaYoO25X5Tt6VFwo3+JLN3y0MYuDQKoup5MnGMG9wulFlg?=
 =?us-ascii?Q?jlCEKUAUOW5ZP5R1WZbNOMw7ubKafWvUcyPwISGiHJOCKud4hU5PmtG65f1m?=
 =?us-ascii?Q?7qoPe/bYm0yOhdOtSyF2vPadJHBsBWzYXyB/HYGgxDTISxlouXOWDY99ciE9?=
 =?us-ascii?Q?Ph70Yyy/2++57iiPN4uo68OdYMxZG88JqEx3rYoh85UCKQRTQDMTiCJFyiLC?=
 =?us-ascii?Q?sLARujKsEzPT5NPuWP4W/npTktODpVb2IemSiiVa3C2aZbOR1Wetlh52n1+l?=
 =?us-ascii?Q?KJGTgmu67sCIpJYGX57qmvWYvB0eBXlANfY0GrbV7tIhCrEespZe7S0OEy7m?=
 =?us-ascii?Q?2w=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f09c5ab-65db-4ccc-f306-08dcece7ae2e
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 07:04:58.9013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N1BryfpgnhZ6HJPLq+e3FW3B2s94UcWHTInuFvqYGttzuEjVhH9PB8FnfMXXj9f9NDHLSykYlg38/O14cwKy90TVTsfEjiMVFUZJtfDYVqs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0496

While mainline has support for the USB controller of the JH7110 since 6.5,
this never really worked in USB 2.0 only case.
The reason for that was a missing syscon setting that prevented the
connection between USB 2.0 PHY and the controller. This series finally
fixes the issue.

Changes in v2:
 - fix copy&paste mistake in error patch found by kernel test robot and Dan Carpenter

Change in v3:
 - Using syscon_regmap_lookup_by_compatible() to lookup regmap. So dts
   with no changed. Delete v2 patch1 and patch 2.

Change in v4:
 - changed the format to make it pass strict checkpatch.

base on v6.12-rc1

Jan Kiszka (1):
  phy: starfive: jh7110-usb: Fix link configuration to controller

 drivers/phy/starfive/phy-jh7110-usb.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)


base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
-- 
2.17.1


