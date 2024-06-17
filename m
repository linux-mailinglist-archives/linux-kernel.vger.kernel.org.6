Return-Path: <linux-kernel+bounces-216794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0894490A68A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 09:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8A7E1C20D93
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 07:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B349188CCE;
	Mon, 17 Jun 2024 07:11:30 +0000 (UTC)
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2129.outbound.protection.outlook.com [40.107.215.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD24181CE1;
	Mon, 17 Jun 2024 07:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718608289; cv=fail; b=XhAaEqHZfXoeT0zoTUXjfCZn+f+xUnwi5A4fNF4ljIzIMgmzIwQ+MNRBR7k91D9YDFwM4D8Lxh9tjxk+pBUGvzvElDvmk5tUTG/oqybxpRUVY0tMNq33SW8oMT1Z/Id9a5NgVynqzsKhrFpKLlr1Y+KJy8rOn4MLPv6NdUaxJXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718608289; c=relaxed/simple;
	bh=DearOktLtxNzn+LmqnF1d9mQroFjAZU/obxx66cg0bk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=hQJ05V+n30SGzaBcJyLp5wQFTnNILIeIworWFnVVeymtneS+vfe5PbUi3T3GI8HcxU9KaAesoxmY+62jVjVZLtnrF8n3kAG+9lnomE0HT9if9/gDuV5YWfSKwwiXVUj1su/wyPMCTPBfR90ThdEVV/MpWa/nh1f/TNqKF34BJ/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.215.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aTtzuPlm9DHu9xYLlwyVYhdzBDUjx5k6SheeL/QI+YrRi0/pr+932HC4IP4QwS1ekVo4M0YIi/3Ivk4+UqcZbDUG9ju2H0MbP/pKGKtcGzM2+08n92b309XDmq+8xgALR/+vZ354IYFHn5KObHK0bNyxoXKCvK7JoonMURyIggSnwOl9mdBxmprvWjOu+0T3LSn0lXP7DWYjfT0ZkJzE83OsduMHjgF1UD/orqgtKN5NwK0zuZh0upLJLpGXgVWgNEaKt3cdFr91n93UDdXKysrHTTMuXk1MR6Zs18no4QGASdn3ZDasUguQUkYXWWrZMK6ZmrSXmGgArgfomLK+0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ccZBzCiztifQu6aaEgEHa8HADASEjhUj0bWe6OYnMTE=;
 b=KeezgYDHJNeVvCxElGk/AezNGDVj9QY0YSafMz3Q5qXe3MJo11MOB3dzn8IJqnr0C61yVPIc1XoEYi9ad3yOgLc/ipvPIpeLGxSPl7UDP0U4W0jVCKeDS/sbkI7gFdFogQVmRyaTkVsdgHPxX//Ccj9PuOVCvUU+QrgbRBWIzsjh/hNnKPEDIe32Vsb9evS4Et6xPVrzQA06QAu0pG6Xy7nwESo9IcAEeLlBDkwKXLbCPi9VPfFCWHQgNNavqY9wJTWJF+90znAB24kjb9UCSXCuFICtli/YnE72Y7WWkb2aZ7bcCq0w6FMJRv53SS891arQRlMpLGe505kcZDjgRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by SG2PR03MB6705.apcprd03.prod.outlook.com (2603:1096:4:1d0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 07:11:23 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7677.029; Mon, 17 Jun 2024
 07:11:23 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de
Cc: nick@khadas.com,
	efectn@protonmail.com,
	jagan@edgeble.ai,
	dsimic@manjaro.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jacobe Zang <jacobe.zang@wesion.com>
Subject: [PATCH v2 0/5] arm64: dts: Add board support for Khadas Edge2
Date: Mon, 17 Jun 2024 15:11:07 +0800
Message-Id: <20240617071112.3133101-1-jacobe.zang@wesion.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0017.apcprd06.prod.outlook.com
 (2603:1096:4:186::15) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|SG2PR03MB6705:EE_
X-MS-Office365-Filtering-Correlation-Id: 49a8ccdc-790a-48e0-da14-08dc8e9cb1e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|7416011|1800799021|366013|52116011|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h8ZbzVYmWIOBybv06+xj2jhM+Elshw85QRoZQ/tVW584QBP2YhBDQ+ZPgwhI?=
 =?us-ascii?Q?GSdOIrDn0gi/hKB0m82ASy/p2zgjjaF/XyjBcNmlZDZs7WhhhoVDgCoG3stG?=
 =?us-ascii?Q?M1rtHeG2Uqoy/Nkrpfs1sMAFScTt14CouN2kBWr03QlS3ZDY/sQeVyovL6Xe?=
 =?us-ascii?Q?dR61Zs/ZE2uYLtlCAl4XsVhCKUB9MN5hAWRFcEtvhWTVkH9ZsZ55+oOntUfL?=
 =?us-ascii?Q?ncykzHNL5SrAujSi+U6W7Uc8XcTCHt6+cWnldJuQsclCY23NC3gep6lpPisX?=
 =?us-ascii?Q?xy7mRWpmrZv6Fpr7w7Vo28O+the04/8Amnm6DJ5PnEk/HqPuJoQpG4gvcaB9?=
 =?us-ascii?Q?8wWzPrT/WgVWSTXHK0+/twS1wexTdGQFSleMpehys6tcnPmcGnCcBe4/qgTs?=
 =?us-ascii?Q?oTCRixmXXMAkaA7xbOFZWej2uXHCjiQiUEDUiB80ygFsOrwu79JdZq35XwRx?=
 =?us-ascii?Q?cYgHhnXU2w3iQcHcub8H4hTWtvSHmyomXPHVAVdc5mbrRqRxG/t2giBJff41?=
 =?us-ascii?Q?GAvdHZuKb1HX7odCWRptgoZb82Z++rkNBnrcoeJ9p8VezQ/3xLPa6NDwfsv+?=
 =?us-ascii?Q?MeyuT2M1hkmo36WqEzwzf4xOckkCvAm315Qy+5Ovc2wkxQVX4cMIj0lAjD+P?=
 =?us-ascii?Q?C/qAi3W7xtHWi0s7/kYEnROB5J1xWaZNNVVecI4MDfegbQ5++FXMlsu2mFBZ?=
 =?us-ascii?Q?xL39IzoYiKf6xQy89wMa4SJ4vTjvueUV9r5WMg/VgXSgzK1SnOiDHfj3njRI?=
 =?us-ascii?Q?yiks+Co3Xv5HlmaN69GNtRAUvH/oRc+PMSAWsjKh5ROigkjHKI3gvJlRQ7Mz?=
 =?us-ascii?Q?iqkcevMEd2H4y3NHHU6aG+Win8jYg2PQ6r/GlYOQ833b2YVPs8HNJn50kgvl?=
 =?us-ascii?Q?cRIVRhCgoUNNR/QFjVOGMWp2ubkCHYm7XNRmqTIsOcRLcCZl7aV/kAhFuWFC?=
 =?us-ascii?Q?fiOpKbgI4wK2mOyM4rzr5rVSmomTnY9HASHOyeknO7LpoSMEwDl289iNiuhH?=
 =?us-ascii?Q?wEt5FLlQ2Dbeq95kddBpxcHCAA1Wea5wIIx4ErRmU9hp9tt5h2svQPO2dChM?=
 =?us-ascii?Q?ECjcrR4WaW68Q+Z+JGH2tMqOHCwSGs02idngNOwcBKZjLTP+xAn7OrRn/2Zy?=
 =?us-ascii?Q?WsNJOHpsg9bxEaW1eiV4J1Mr8GBLn5aCJXGF+60/MHjP2rsigExzUmjsNpKv?=
 =?us-ascii?Q?+S8XynCh/e1F95ETM3TcfkXLD1/7yiippKIjONQfFD65YJ9M3EnO4SaJk/Q+?=
 =?us-ascii?Q?IMizg8zofJslv7DiIkR7rbjs6aHduLqwGNKGIfcTrc37Q0QUFPDOkeGzGJuF?=
 =?us-ascii?Q?djM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(7416011)(1800799021)(366013)(52116011)(38350700011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gkAAz0wIq5pvCgQJeXYCK8kv5TaGh6peJS1vLD1L8MQOT1G3mYkV35ntoMnV?=
 =?us-ascii?Q?54QZfs9tjwOgCgawT8vNmFqu2VSo6PtTmXiZu70Qx34umEXKbmyb3+yDeaW+?=
 =?us-ascii?Q?mYIQZOL8tj+fYCRFmhZZxSe0A3ASXkvDhlyEIf81k0evLCczlhLmhWDe07bl?=
 =?us-ascii?Q?UTAjatQVrVZ+XeQAL0KxY/p/lFouZGMzCviipzTY47J7aUSs9AHKO+H9cYQZ?=
 =?us-ascii?Q?e4rdy7LHHWCP6qXA3fqkRPGVdpR5esrybLCT8g75jQC+RIQAgsYLXd9pGxjZ?=
 =?us-ascii?Q?j175zIQ2bWYh+yN1tUTW3dzgmpwNnnCiOvyjRt3+PTCJWiUsNsrKHwqoiOqS?=
 =?us-ascii?Q?8yloeynEdEFefif4oACZnQnVhrxw63tC2GfrIpqmtFZY5L5sEeVQd7ZbBoK6?=
 =?us-ascii?Q?90wTKK6WV5W0joDATQKhMISgorhTFVbA+DCu8vLRmdGW1h6vB9f5VvDtxVe4?=
 =?us-ascii?Q?DOOdlwY2tA8BfoVprnCN3YGkTdiToGV360CLIpWkp34wreynkbOkcSr7+Q6E?=
 =?us-ascii?Q?XpwSJLvQWjqmLd8Q1uEd7/Val7mFYeQv2QV7Hin+y256PyDgEiSd3ICmxmlv?=
 =?us-ascii?Q?RKol/WKFq294NBWSC7ufoJ8GjzxrHcNa3Y4oIoP+O7P1SZE+eu0peBiLFz1O?=
 =?us-ascii?Q?gwQqkhZVUJAHyYn8en/7cc/v9x8KtYEy1ThX5MI/KTIQtnIdL+6bNOpb1+NC?=
 =?us-ascii?Q?ZRXb9eOPFKqZvf4H48RjucS9QyF0PNIvUV3FYollBjK3Xajfb+FRrU/y0CsS?=
 =?us-ascii?Q?wTO3ufiAfK0kXKrAdjzzEID65hd8Pm4s3/qnAAXRFq2fXc1fbH6aXQLo5brH?=
 =?us-ascii?Q?d8/bEfD5wKM1fjz0uH6FPNR+wMfdsbRON/SIdapV7+Wj6VecfXhnT9Hj/9gk?=
 =?us-ascii?Q?0TxNs3t9SzeG/IGEeCNxlGFnATAeOL1Z0P+5WXlkOPGnNbkaMMrt8z3ywQC1?=
 =?us-ascii?Q?b5LuIAB/o24V51YF0/+5ZS9ao3qr4y0WflI5kyVVjoC0Mh8GKqFqlCBMCqHj?=
 =?us-ascii?Q?LVXaeK1qBXUGj+kMQ/OotxhrjczDnZh8CXYf+g8cqkNVqHE0v4dAKKSAB8Xm?=
 =?us-ascii?Q?66jXoqTAvkFyJBQzYzyLDwwwVmft2qilZHXx6coXokf7VywM41rzCVMsw+eO?=
 =?us-ascii?Q?IjqxOmw3z2jtUnDAkkQgLykOB2X+Q16wDeeX2s7bLVEfKKKV5ym7542nX5YB?=
 =?us-ascii?Q?H/fLdnAIk1P1KZe2PkKtVj+0YGmG0vOIvMUDjCSDTFZAzDx/SpVtId2faEnr?=
 =?us-ascii?Q?EuyTPqW9YabDsQrkDzoifiTCCVPQwSEPAcJllnVbynKsI9tthQ4TInHgMM2+?=
 =?us-ascii?Q?Pq+GgzWci6ViPl+/82blUrryda67h9lIcwXBjzd296pYk2DCKDyxOjbmAtJv?=
 =?us-ascii?Q?F/ga7xTYPXIQ4W4wF5ymdw//bhc02UQeuKHznAcXDlBYhOT+mVomze0hcbag?=
 =?us-ascii?Q?aWd8nukhWh0/oDqDTR9WgJfg4urmekN623AUqbrLvWj7vRjKictfhMFh4r9A?=
 =?us-ascii?Q?/p3Ck/L5HS88j6Yhw7rjptCG3NBkseIRxgJqvdBX8erwCByed6xdotuF1n57?=
 =?us-ascii?Q?cdAhw9yJ2K1f5vwAKNSwlcCDGLhjHmtqIxSA4vxMelUBBonyCdSC46gVfQzl?=
 =?us-ascii?Q?bQ=3D=3D?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49a8ccdc-790a-48e0-da14-08dc8e9cb1e6
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 07:11:23.2570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GbJEx+Rl2pV02nPnJzJEAJl1cW80oFBBRVpWFw1y+Rs3aiLx8NAFzGqmlSsyqmTirmhStUKwvHqcvOlKSP/QUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6705

These patches add board support as following:

 - 2x TYPE-C port
 - BCM43438 bluetooth
 - 1x HDMI port
 - AP6275P Wi-Fi module
 - Adjust CPU frequency

Changes in v2:
 - Removed unrelated parts in Wi-Fi patch.
 - Fix indent error in USB-C patch.

 - Link to v1: https://patchwork.kernel.org/project/linux-rockchip/cover/20240617030537.3112356-1-jacobe.zang@wesion.com/

---
Jacobe Zang (5):
  arm64: dts: rockchip: Add USB-C to Khadas Edge 2
  arm64: dts: rockchip: Add bluetooth rfkill to Khadas Edge2
  arm64: dts: rockchip: Add HDMI & VOP2 to Khadas Edge 2
  arm64: dts: rockchip: Add AP6275P wireless support to Khadas Edge 2
  arm64: dts: rockchip: Add cpufreq support to Khadas Edge2

 .../dts/rockchip/rk3588s-khadas-edge2.dts     | 200 +++++++++++++++++-
 1 file changed, 197 insertions(+), 3 deletions(-)

-- 
2.34.1


