Return-Path: <linux-kernel+bounces-221958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3FF90FB17
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 03:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F01BA282B24
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 01:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835CF1CD23;
	Thu, 20 Jun 2024 01:57:37 +0000 (UTC)
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2105.outbound.protection.outlook.com [40.107.117.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B96217736;
	Thu, 20 Jun 2024 01:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718848656; cv=fail; b=ipLaFCoGN/Qy9JhSo4kaOa0c2KLlQGyCbS6WCSxnpoHEsJdYZOdaN4ExA0IiYL3ZQKd4aeP6iiPCIKYvrKywu0ZpGQUOpfuhVNQ/tmjlITfcQAVShnThh7JZ7VIJ1q8T2SaBzxgWi4OhH15nqrH/MzLX560CsnWho0kqPbK8gio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718848656; c=relaxed/simple;
	bh=ZMYnVQazM7CXh8qKdDUBXqVWKabmcRsUIzJc3kyM8G4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=iCvSKKZoMwYRHe3FHL/ES+4TkvU6i2GefiRlWKTHB95ULwKfj5GuhkcVtx0Zy0AmdoKWgfVqrND4oY+Qo/G4l9LNZPTDXcbCZVM1QHi55GmZyfAslTS7wEOjR8pb6i6sSO8PNTKTmpieuHtCEZ9yKOOX4RyS2EHow0pE+2PrxS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.117.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hOwEBx/bJjzTMvBAyUJp1tLXHgMEMoIHrqx+oEo62+9hp+shlBWW8FFJNSOCHP3e58CbUzx9Qk/WDKtkhH4owBu/VJfUBch9Rkzo2y6JdoDvG57qgJKs9ZZBV7xPsDd1VIHP+uIUxQTgMjLDoR8SOQy97qTIEIrpEjy08kFhEDD9Lnj0kG3SdASH5stQdqEC9Cerj0/5avLGyVFCpyYkckk2Eh9k/aT4SVYx2ywwIp7oqzjwTBnQcizzsNOZTkgnKyv+9hwclN46mj7N76s/0weoNzBtoZ907MU51DesTK7gHO9b5oszUYVA6NjtTktuR7sgq4Zzjg9OhD41KSuWkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pSRIAlyNqnzWXP4ILpMgoo3s1R5yegU+j9zJCKQbrOc=;
 b=JgN7tvNZeEUlzoTQU1yHk6PBmzVDOkXb+SalfN3V5MPpR2aWsPUbjDbrUH5LEpexzPOYnI/TiZJSWZfcDlKtl2AM44mV6kkdG+ElwXRMQlk0kep8dvwnZ19A/qYGovO9umpln9DxHG0MzIDygNtDLCYF1rhIbB/d145USd9EU1xbaPJxz7Pvfc1ULCLBIe9vHPhYnALV8J3WZqMjozy7rzRQO15daMNJNGwXzpFJdAk8P+G9dSVsWSit3Q9hBBhKH2xzV41lc/TQ1OJnTgxEg3bQZKOSk0r/ytUP0C5oGTxGw807aVncghbLlJfvalH+t/wAp4F5osqedBanDoYozQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by SEYPR03MB8078.apcprd03.prod.outlook.com (2603:1096:101:16b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Thu, 20 Jun
 2024 01:57:26 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7677.029; Thu, 20 Jun 2024
 01:57:26 +0000
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
Subject: [PATCH v3 0/2] arm64: dts: Add board support for Khadas Edge2
Date: Thu, 20 Jun 2024 09:45:34 +0800
Message-Id: <20240620014536.4019524-1-jacobe.zang@wesion.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0052.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::20) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|SEYPR03MB8078:EE_
X-MS-Office365-Filtering-Correlation-Id: 96b8ee17-6b6e-44c5-b134-08dc90cc555e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|366013|52116011|376011|7416011|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z87+PGW4kpzLtvyOrSHlfkd2Ud+F0DjHUSIJF9gNWpE25dRB0DmFvRk7RdgP?=
 =?us-ascii?Q?eKvdVtVwBv8r93K3roJwhmX1CXtnYdNHKn0TvgwA/WkjaU0UNK9ywc0StPwY?=
 =?us-ascii?Q?+CIfn7RAivqcAwSaPKdzDq1INO+jMwQYE4xeBj3LJIhynxKh3x2V+lHC1+6s?=
 =?us-ascii?Q?HLYndi6+DLuIuvw0ax1XrSo4QS28Iw3jnxF67ov/MLyWDvarPYKZ1mrHduIn?=
 =?us-ascii?Q?tALIP3pA62H2wkbKgoQlqw7YvXi5LUHMTCvooyC6sr1Ixb6S3zDr3ibScQCN?=
 =?us-ascii?Q?kCdMhemWVqJ2Tr7/DRQUNmo1UoUcPQG6tSiFd0qmJLrRTBp5BIwJMs3Ojkg/?=
 =?us-ascii?Q?nVFdynDSTgLl1ORBmf5NFjK/AiPFrCT2+g25ccvIRhxHlq81J3ISr1LyRTmX?=
 =?us-ascii?Q?2R6M8N8zN74VcYzuywU5F4O1OsBNnLAt1lLCjMPvDNk4wVOwyOmT1xY4FcVc?=
 =?us-ascii?Q?B+2rV7NjwFNSJB8WvjSm04o6L8kXCuCdxjz3nIB12COcf9ZIgUhzz+fV1ez1?=
 =?us-ascii?Q?OUftl2zDM1Scd/XlevUPRmNojrSg86glj6b/iDAxapcL8SwuMXBnYww5XW03?=
 =?us-ascii?Q?ELCMAQTm+YZwbHLPkagpBvWK6JTuBL5jWJw9eJAtZY7cZlcZQ5qFfFpMGPTE?=
 =?us-ascii?Q?oYO4n/c++A/JfFch50P7XZ9gjCixhDDafwS9twdvsAQ00a2LSExV/KMj1hbP?=
 =?us-ascii?Q?URdPyMR7t8IPGHNJM4/mBywtrthHKgTrbQb2SxA/ZzUcK0+Hd4Tmd+X2fgbH?=
 =?us-ascii?Q?OGVsSD7imSZ0PiYH+ss46QJhygkXgARhqD5qLo00kiojujpBtMRBgU+TJTwo?=
 =?us-ascii?Q?9HZxCx5uhsvqMrr1DqhVWNx+qD4UpIAJBvcYDKqqSX1MkZb3cm0kDuh+h0ib?=
 =?us-ascii?Q?h8cahkYW9MSm9PArKCogxJuxq67+pnWEqwPCIS4woQ1MktyVLEHJJx5KAmXn?=
 =?us-ascii?Q?wYCH5TZz6t/Cf5AFSqfuU5LlWFvh0Gg2GoE/YBAJ3tELVklojCw7azIjM3i+?=
 =?us-ascii?Q?8PlL9XkMsLBguU5YQ79CTHdu5gIVYrbj+Bg47tjRLugxfFB/Bw1YU1R/edeF?=
 =?us-ascii?Q?0LOiucB7unWR1Z8fkEdT01L37pTir+iBf0ZjyLXzr2cb+tclnCFguwlOfhrM?=
 =?us-ascii?Q?lFkKev1iHt4q3aWH7coWcosBTM4dOWh7FjWhhN3CuoF9GGm+7kwePyTVew54?=
 =?us-ascii?Q?YaZlGQo8ChSEI3m8zDrWmQ14aBGfmWuj8TOmBUGh/AVvXiyH45a4wFZmm3u7?=
 =?us-ascii?Q?GV/qYpJJjm3Y6lx7aqv5Rb0gVd05pqGgm19gHniq96tvq1h7JKe/aAC4Wcsz?=
 =?us-ascii?Q?JUkzA7MOTX2dmTE4e7lpsZhY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(52116011)(376011)(7416011)(38350700011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Tw6vMI6ZRe/0BtdE4ASmAMvQfIB5h0txxMw8c/xDLK2yCuksMydkY4B0yEGy?=
 =?us-ascii?Q?K5KXDMQwoZ07x9LkKDALGD2uqoXSAf8iNn1fzoUgqZrhR6vyjvN7DUGTR3LH?=
 =?us-ascii?Q?m2UFdAoa5pNNuB793J4SERqLZCFJSHaq/c6leV4pen6YsFsxRCVYnHsOOFHh?=
 =?us-ascii?Q?u6aNJ9K72t1k0wdhCwfpEG5ASaYDo7+JPKmT20knoB/YixH/dgJwdfUUFMap?=
 =?us-ascii?Q?VTeYfO9BNkUq9fZp/Mv2IGJXjWOV63FTxUyuR2E1dxiRSrxSduTeYfahVbIP?=
 =?us-ascii?Q?Zusl4/bh2DENF4LSxrLh+viEfGpiUcMmniv4AFF5TH6J814FCRPc+RbYSd7p?=
 =?us-ascii?Q?5Lv6w3klPKqDYDkuJw0NzaQaD2T1HXutpa9UX75Qft6dY4UZ6h6JyBezKufZ?=
 =?us-ascii?Q?bY6KOk2n2ihSJxOh3P6lknsKMwbdS8LNppGUfVF5cGLnoTxQbaIAVfQW8c4R?=
 =?us-ascii?Q?DkV4RI/W6O8PmyKgGcxdOHFFsEKnjS6fZzv5rpazOuLFYFHG0FXGj9i8xLZ9?=
 =?us-ascii?Q?/7/96/VUGAlohVBVupbaOeYZhDGwegRxEb6SM+OXQFsqXoUbU2FyF6pHpwtN?=
 =?us-ascii?Q?Mxl8G7PIAPOGzDT4r/XwuyPs2QGaIrGDLNftll9XT3KB115fFpnWwZZacr0z?=
 =?us-ascii?Q?x+Qj6mbE8DmktI0jo2ZpOB8NTOJ6TD7zuKmwwL10PJ4seCDTLmG2o1uCMfhO?=
 =?us-ascii?Q?aYcFxoQjdxXTNkNKG7dfpqxtoibaQTSRTj/nxgsRmU0LLpKOLy+gI0+q1NeJ?=
 =?us-ascii?Q?cVmKl3ll55Uz/1ibG6nrlDwobBv2Cfs+ERaHEZ3siBzpCh0fqZHZuT5kYKDr?=
 =?us-ascii?Q?b0vtrKzvpr2saqXVOuFKPnroDx+ufSyDyBh7T54oDdXtvy076LuFzGMfHh+E?=
 =?us-ascii?Q?QlHEP4GjVIF5mylq/0b0ucEKCx2xHYBHrg9I8n2JXgzUum1K+pi0xZOLuAqV?=
 =?us-ascii?Q?5Wod0jumCh8ZDQLmAeVv4dza/XoL7hZ2+/Cjz9bj1xTzFwjYlVlmR9f0WIUF?=
 =?us-ascii?Q?n/7NPAEIZHAjNQWDEcgvNCItLqvIzSRS9oku0I50dygyzosjYanVqaCVFHan?=
 =?us-ascii?Q?pOOPPerVhV4d8s0hbcZ5blPrTAU6Ox2heFJZFgSYX8my2ukqCkYsVPc5x6wZ?=
 =?us-ascii?Q?pKPB3G3LasWqGovJ2ul4dO0bP5HqcUQtGjXrUNqfHRmEiZoSNmI2monNWqfn?=
 =?us-ascii?Q?zO+ytBSGrydzk+FgSZrGiIhymmzhqOBdpulMWs/pZNrft/epYFRabTlbEcWe?=
 =?us-ascii?Q?pAqb8mmc9iSTW8vRzd8Fp706KTVqVzsO3E3vEwEq4QZsCrTwvDdEgAwFL/q+?=
 =?us-ascii?Q?jRb5OFAAlbmVOKje5B1K521DujEFXYDgpc4IinizQXuqQ1vlKyxi55p4r8nA?=
 =?us-ascii?Q?Nm3otF26YBXQyRM54k+5kyxleVNWB+oU6DpexoAzvu4tRjLlOwS6n76cKYNf?=
 =?us-ascii?Q?p1ohvQLeCnmxiSYSwGYf2utkfv1fI5d2mUtHnxV9rxSHtz1fL9FGQ211FzTI?=
 =?us-ascii?Q?jfe9v1Cli6o2wReQr4KXvJQlRxifLtjrbgUwFfS5u/9L+RcPSFeH2z2qLtfW?=
 =?us-ascii?Q?HceiVaFuc9EiekFuFrC4AOJ+WxAczt+X9xb/1qvf?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96b8ee17-6b6e-44c5-b134-08dc90cc555e
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 01:57:26.2156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CIfGupF3jdJlxylBVr4PXO4k4h4lSMu7sfVkTEu9UyfXxGV3XHFCDuu03VSvn1Pi7N5DXTEYiPUVxFZRghiwGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB8078

These patches add board support as following:

 - 2x TYPE-C port
 - BCM43438 bluetooth

Changes in v3:
 - Strip Wi-Fi patch, commit it with PCI driver together.
 - Removed CPU frequency patch because it won't be needed.
 - Revert HDMI patch, waiting for the previous commit to be merged.

 - Link to v2: https://patchwork.kernel.org/project/linux-rockchip/cover/20240617071112.3133101-1-jacobe.zang@wesion.com/

Changes in v2:
 - Removed unrelated parts in Wi-Fi patch.
 - Fix indent error in USB-C patch.

 - Link to v1: https://patchwork.kernel.org/project/linux-rockchip/cover/20240617030537.3112356-1-jacobe.zang@wesion.com/

Jacobe Zang (2):
  arm64: dts: rockchip: Add USB-C to Khadas Edge 2
  arm64: dts: rockchip: Add bluetooth rfkill to Khadas Edge2

 .../dts/rockchip/rk3588s-khadas-edge2.dts     | 127 +++++++++++++++++-
 1 file changed, 126 insertions(+), 1 deletion(-)

-- 
2.34.1


