Return-Path: <linux-kernel+bounces-216658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A380490A2B4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 05:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA1BBB218C3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 03:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE0117B412;
	Mon, 17 Jun 2024 03:04:04 +0000 (UTC)
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2139.outbound.protection.outlook.com [40.107.255.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00047D2FE;
	Mon, 17 Jun 2024 03:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718593443; cv=fail; b=miSPB/r6CEJwXktbENza8hFP6eARLYibGNk7iQ+8q7YzK6BddSN24VLPhdGrHlrfHWELkN2OEJvzC6i6hIXJybbFgfea33L2eefFz8XAPQKzNhWfZZVlVO+XnAOYXUzSACupHcQCVmE2/BujssxmoNZHh5HAmF7MkMMbHVoq5cE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718593443; c=relaxed/simple;
	bh=5kuKb7/mPAaCt27DlkRpIwqodEH9WPDkkS9FSCRuZnw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=FJvvl8Ff1VJIvvPLgW5yUT/uWLQxmMOTAtvKYPI63PITWlWlu1DnGcJMocn5Xu1fra40DMGKntXHfVQ5TQcwGVBw+NcFwspxS7JN15P43aj/NdfXCOWXgti/3j2xsScnw6EWXug6P3iK2f6j7NMMncjAWhKT/HmDLC/QfgTOZfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.255.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aT94sZogifNkWUe6jEf9itRyyAEVdtUx6sSOckLJhXXnElldx9lSGwNjqqvj4qJ1igIuaATFp5i4Yr7uwQJ/qMtWCssRaTuDTeNC+tAV5HOZxjxc/pRmLOrh6xLHe/vh0xdFzR60gfvDbZY896tEv3E++8Jm7pQ+IpOZuKP8WEHCJLD+9yebIvpDsW5+nrWRg8jTujcFUHOkbaaKrZypioqf4y8NonC00hlL5eiUiyDlBtZjId0375xzDus0c7ybz0GavlLOc0AIFsoRVl5kN9DIAeHn/gJsayftao8svogv6SW5RNSkNJq4liRAGTNW8sYqTOCAn1aAcHpOhPfmzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZXiksnxuxOWL0MtLwPNPb1xPZamjLZtc0ZwfJ5zxL/Y=;
 b=nbkhNLfZIUR5sk0up2+2J5cs51fBde88Zl2sgl3kAoXzV0Cpc+Lad03zGaTt/ks5OfVz4Te/UfZPZFmp73m+mwYgMNBYU4f0DRiQHL9nQYkjtJPJis9ChrRX1QtzXUszduKxj7+SXxYQdxcnkoUFDQIrjUZacmKoDAxrtvyv7PRaDhBB+NIJ+eysN7axYQPgoO4/t+72pOjU7ebPsFV/pg9oUaZtZr5myAtDXBPKiS1AINUev9W1B4ooet6TyJR0esEYBYvFZTilZx0293dw6Kj5iDc2S4vCXnljwSIoSl4an6TPYNQYGKAk2Ba645ZIchRv5PF6GKQUxpTOI57cYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by TY0PR03MB8223.apcprd03.prod.outlook.com (2603:1096:405:15::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.29; Mon, 17 Jun
 2024 03:03:57 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7677.029; Mon, 17 Jun 2024
 03:03:57 +0000
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
Subject: [PATCH v1 0/5] arm64: dts: Add board support for Khadas Edge2
Date: Mon, 17 Jun 2024 11:03:39 +0800
Message-Id: <20240617030344.3111148-1-jacobe.zang@wesion.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KL1PR01CA0102.apcprd01.prod.exchangelabs.com
 (2603:1096:820:3::18) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|TY0PR03MB8223:EE_
X-MS-Office365-Filtering-Correlation-Id: e81e65b9-1883-4dc0-78a9-08dc8e7a211d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|366013|376011|7416011|52116011|1800799021|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2uIrcZX0ACXaKF/alV3wChxtrSZICZH5jus8S360v1kjcKpBbiRVzuS2b8tX?=
 =?us-ascii?Q?Ycd90ALX+e2p/HwfdLJR/g8ss27byx/S4oPLiV6i355Nwe+NIlm5h77sD+P9?=
 =?us-ascii?Q?xxhfsiGuA0cxJ7alJcthiRk+Lv4EulOB/t/6QeaEF3etRBpTOk2kUiZS/t7Y?=
 =?us-ascii?Q?vE203vIZAW0+opFxiGH9GWFFBz1ZNAKezVkSpv0Y5efnJ1eO4mEgM8aDnUl7?=
 =?us-ascii?Q?nN8w+jRZWFVMsdg1gLRpZgkbPNMKMnZFfMFgUjdcXhNFcuTyNosVNSHif7+o?=
 =?us-ascii?Q?wREEeUGGR9TS403qh9UkDFNMUoIvIYIn7DHyiRsZfJ1EljXg+RmDd71S3TOo?=
 =?us-ascii?Q?gqemKbgYgLusaxDqHuWzfTn3/fmcomsEb8iDwPYc8S198DVdl4CiWFYl6ifM?=
 =?us-ascii?Q?rhKHZwtStrb6O49BQOpkD2vv2/w8fDTy8zHymTAgpOtMMhAjYquz0CfSs4jL?=
 =?us-ascii?Q?4b4X6LjPlh4vznsNVpnz0cLo1JAMoSpKwIBHZgkFV/qNM0J3eDGHhgC6smq1?=
 =?us-ascii?Q?kGOzoC4xsIHJP8xEbFwfmIvM/XYQMExfu+QvFVW+cFsG7kZDkm3vByMcC8DO?=
 =?us-ascii?Q?r5HXtZDdFNk2jmhHhpsWgM7VfVahsoubUG6QsafMAJz8E5obyvSZomz+Up1Z?=
 =?us-ascii?Q?B0UcmkHK9dDKNq82Z06ViIW4u0lsgMw3v7RhxgThPIZabdbPygcML67IVn0g?=
 =?us-ascii?Q?CfATc5FH2h5XIz6htx2W7UbuIiw3tHhMvraCiGpwtZ1Iu81A88/Xl8MuEgw8?=
 =?us-ascii?Q?LV4zwbV0g6rJInehqFYjHqHyFozPExVWWNO8urgrJbm+in1Wsd1kidfOMxTG?=
 =?us-ascii?Q?DKXcCYT7I0+vhZYmtEVuaLcHuLQ3UNcNOjSEp9SBIDQoSJIwvrB5WkPtIGEe?=
 =?us-ascii?Q?4QIg72ikrR539psgnzWh6JNIK4QQiYZdOOFvKPCS+qrpvuP0Z+dPBDcXXoQK?=
 =?us-ascii?Q?QMqqxefPSqh9EpMHrFKBCk2Vg8vp7fCA9IwPO2mK3TGWlE1KesTK6cnGPQ8F?=
 =?us-ascii?Q?z+na+i2oAkhTEem08Dt2NYf6rNRnUqEbfUBnD7WXHlCbA7SK09YlXjigqyb2?=
 =?us-ascii?Q?O8VR+zX2sI1closCaOshFNawe6dsVcV7VOi9uE8Q+Z71yuj5ZlX5G2y7BOeW?=
 =?us-ascii?Q?f+FtrwyLkSUpgZ7zqUA8KhzkOKzjjbeLeDMhVAGps6gwXv7/Gn7RcoOVJEZc?=
 =?us-ascii?Q?61UIJDZOktIsWpDJkTt4sAhN9oP+5viv6Yi0tMPr6z7UBHthP/xq2ubdnVqB?=
 =?us-ascii?Q?epRUqqeQdQFlHb4i3hYUkOlYOcKCAmDEMr+6Qm/tYphanXAEhuPPOE1IbpDm?=
 =?us-ascii?Q?PrH4EUUL8290lD7tBPuVieQlg2FqYXL9+4hPDNaFXxOGU7XyWTIf5F5kdtZ1?=
 =?us-ascii?Q?edx/H6A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(7416011)(52116011)(1800799021)(38350700011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kfd9qsD9JpFunOuyzCuDqyg/ll54SfYrdA8DT8ovRX2GG3GaOoYbDv3vBwua?=
 =?us-ascii?Q?zc+zD2ELiXr5jTyW4BJ+A7WbwOD2rO1y2PnS4u2V3S/uJdHSlwbEHGLCk5Cd?=
 =?us-ascii?Q?iR8omxq5cDLw+zs0o83enB77CTKiMYTBB0I//KTGhgzHqDC1r2zVEo85A5v1?=
 =?us-ascii?Q?2ytYBpTg5iRrVRqd6xxRuHUdwSH284K/GV/xnfc+DzPC0T9EfSLKLdzTfFkn?=
 =?us-ascii?Q?gtTLTlvKOTf9L5cZsPA0XktjRXnb0sTEilcNzyIYpshpCX/3UDKsAXa0DZfE?=
 =?us-ascii?Q?+l3BHr2hCpjp6HvPSYs5WMBZSOmha5tuSP5dZAJ8HDUb0T3nuQH4IGHjROJk?=
 =?us-ascii?Q?PdZTmzMQuYh2WBZ005m4gJ4W4HyrGXHK0MbJZBQ3Di03S9hmOkykqopMtIQ0?=
 =?us-ascii?Q?sP8mgdQLqhyxZHPO5T4N3x6hhsJbVFjJ2XJEJ/unB2Aucnf+C/4MHZyQF9uM?=
 =?us-ascii?Q?zCPxmsnuB54YVapYs34FZ3pJti27fSJwfUNARplwqkGrLjQQaJwDifJTaJYo?=
 =?us-ascii?Q?c9q7Vt0MQLWoDuR8iEzWcF/BwT+i/WKp7vmGyTPs1tQwvjXrbGsyj/5JyLHk?=
 =?us-ascii?Q?GTuC2bGkzYwcHDNRCp5OnNXPtiMDB/WbkrJd0ppqVl/K+TGI6LNTHveGOPed?=
 =?us-ascii?Q?BQxmZzmkOBvSBf1h/+FUaxpKnfD/mKxc/MeaXba7jcqlU+yXgEHsvu9jUBVc?=
 =?us-ascii?Q?9A3GtVVBNIIYOmglXtg75L7wSmowmva8gmBiKqPqrB5/PI0jJ0lxC5591RDi?=
 =?us-ascii?Q?5NZXHxR+eG2lLEQEcXlNCH4OUpEW9VlpX9awtOxzjmBiT1GQldFOFoYM0XHo?=
 =?us-ascii?Q?U4XiDnPacgLC5kNmZEos3vK/E6qgo4+yyyfX5dbryUa9l1QBYG2zUT9QMoWd?=
 =?us-ascii?Q?7pZB2JZWg6mqtHCfNA9EB3LIf0AHUMsO5jd1ZlcC+Zwxi77UWxPLHiyHYiiB?=
 =?us-ascii?Q?mp1dX5eoR63pp2RyhPNAzqN924nEeYhz3bIxkBE7YYAXLEk4FTRmjowj1IEx?=
 =?us-ascii?Q?8Oogp0Ru1M4fJGUcqGT9fIYsZi1/bvK9t1aDP2HNgRRJZg3v0dicQzAVLdF4?=
 =?us-ascii?Q?vwr86TRcNiqf/y6PTT/9n9RNvX3cEJoyWjUudaiLsVUQJDwZSRHY26tRhkDz?=
 =?us-ascii?Q?tM025VVBbiQXBR1US+E9YKpytr8onyJw38UFHKkFZF463EBOgcTbI+NbCEY0?=
 =?us-ascii?Q?UhX/Qn+BXOA08SLC0zWEwIiRkDnFqqfe8WpzNHOKC2a6h2KOJTVCERJ9+5jP?=
 =?us-ascii?Q?iv423Wgv6zmTr77vCQ9t0MJu9EsVw+Q8MpZmkRaRMdp2WFrOtreACOpzV8nV?=
 =?us-ascii?Q?XeWvOh8ZEkWlQfWgf5Wzmusau+FA9BRjdxYMdGwcWdAmL1agRGmDGLGQSl5R?=
 =?us-ascii?Q?tEugp2mj/FIogHxa3dzwmy6iWc8NgKN93q0XaoZVfpBOUNkNoRxyF/smKEoZ?=
 =?us-ascii?Q?KhN2ZV11zBYQo7MeXOvzAWzAJjqlV7ADXWSP40th2VkA35iAojgCHWhk3RkW?=
 =?us-ascii?Q?Y4fhgRyPcLgty20yXzW/5tMx8bcWxkYN7uoynIpa3AmTs1XrREyzsAXSDd9G?=
 =?us-ascii?Q?+V+wtTZkIDwKX/Y14xN8p/EdXDKVySJq2O8d6iTzqVsxu6fu3geUWxiSyDqB?=
 =?us-ascii?Q?MQ=3D=3D?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e81e65b9-1883-4dc0-78a9-08dc8e7a211d
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 03:03:57.4556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AUhND05SWwDXikkR4wb7SKmDDCWOolVicrakw1DWgs4eMlSrN5r2H2+syNdI1mUC5158Z1nCwNYbxhE22M0meA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB8223

This patches add board support as followings:

 - 2x TYPE-C port
 - BCM43438 bluetooth
 - 1x HDMI port
 - AP6275P Wi-Fi module
 - Adjust CPU frequence 
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


