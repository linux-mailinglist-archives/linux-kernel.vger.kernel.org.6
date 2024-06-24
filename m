Return-Path: <linux-kernel+bounces-226864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 426189144EE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 10:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECB4A287D40
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 08:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A386CDB3;
	Mon, 24 Jun 2024 08:33:22 +0000 (UTC)
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2094.outbound.protection.outlook.com [40.107.255.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0D04F201;
	Mon, 24 Jun 2024 08:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719218001; cv=fail; b=PRrSR4ObhLAUYd1Wj3bQ97+x2ZK3eY09s64s9FAp3woHzeotTCYIrwwPdzRBGamC0q+J7myYS2g143/lvx9o6G5nl2CAiEPZxVEak6XRfuXAvCTRR8hV0w8b4+Vp0w414d7nGaG2qByzBlQVxJ2n2vRhItLf2khgBPR8uZaLy6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719218001; c=relaxed/simple;
	bh=RaWIrPpGDqK76+dka/ch7shcVxoPOSSjninfcOn76Us=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=BQMykbkq4y9FJ3dX0s5ORQ6GQJJ1D8lvyhmk4Zez/1RwsGdNUNP2yEvYiEjITwTcPPlRtjgLVqGYKv6CDNUk7wGBw8rVMpGziiPrj6FrPgVjJ5j6KjfnxBM/sWsLXeUOluV6zNTiD/eleBRqAfA4VF94w3cRuC7yi8h2mBScXzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.255.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OMcowJOcnNe4Ce7iepwMnllFj59IxExOW241mZAeXE9zVPa/pBEzKt64neqFFhYsTQi9UfjSjjATSrUdTzR1OdpfYMT/+iUzJ89omF+MJyhLfzFmZ8GIY0k7bqn+Fpq7tAcbC2Y14gawzBOJZBNy7vaLU1E7+ySCooem4ukQZGfkLdI8zgilCjDXl/8xLErAdDTw5QMFMTXxohqHlqD+95Biu4qH7z25RgLzz8ecQ/WA9MRPTo+xCOZQXBhybrzinkfP9UBdh7H5PubnAU5TDeZrwR75Zm4mbO4K/IEVpMySdznqItfzIg4+oyS1I11yTMusQ6gdPAKGqBHE+qUF4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5B9GNLv3iCObu0ZXCbN+fc4XX45FayZVQUJd5FEvZaI=;
 b=fp9eGU6Wb1cMD34Xy9yrOIR69B2maLo0q9NKAYU0Mh9JZQvdINiz6pKMVdel4Ws2+/6+0I8hMYUOe9CA148yprNqmQEK0rKGo7SGwGmdGso+yeoTWIoXinlQ7ZQ4mL7MSuk3EVQuPlxE6/mj/qnPczVALvOBX7sARNZ0s6dbfzgKS9FcRwse9P/lfTXdiZzx9Dm/IU5W9k/3Xaxo5CNWq9A5ahzpBgRdiV8kxwUC2kMsJfvd/YnNheUmu/gI/bf8FVqXCfwmhiD/2sfuEqL4cBSOpGZME7uCogS3y0Bhjo/Q3bPEu0IY7UwKz7Ee5mT/AE8vGPTaO5S6RqhmkSTExg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by SG2PR03MB6456.apcprd03.prod.outlook.com (2603:1096:4:1c4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.26; Mon, 24 Jun
 2024 08:33:10 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7698.024; Mon, 24 Jun 2024
 08:33:09 +0000
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
Subject: [PATCH v4 0/2] arm64: dts: Add board support for Khadas Edge2
Date: Mon, 24 Jun 2024 16:32:34 +0800
Message-Id: <20240624083236.1401673-1-jacobe.zang@wesion.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0107.apcprd02.prod.outlook.com
 (2603:1096:4:92::23) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|SG2PR03MB6456:EE_
X-MS-Office365-Filtering-Correlation-Id: 09c6f427-825c-44f9-e1aa-08dc9428470e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|366013|376011|7416011|52116011|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kiCpCLqjlid74EQbAa/H1x3SRIkItT5uegjvcR0DxghCEZhM+F8EA+fNfO1z?=
 =?us-ascii?Q?3wSLnNCoW+h7GcUTvJcys+61Fx4Mh2TtBlZmJuWVLgLzzzIjO9V/bPYvnJDR?=
 =?us-ascii?Q?+rmxeYOzZ9ui+BhEmBCluoX0+aVLfDTTANBzzGB/gym+P4PixXGLynPeOd/6?=
 =?us-ascii?Q?NHT22m5ne+mNAvtO/DF6HW76iaSLq2CrHVHyhe/wDTrvQAyvTTygkfhC3adL?=
 =?us-ascii?Q?KpNdJGVZB+Jrq78hQkLpXAodELMtof4h6NJ5lc0t1pTzPA3CiNRDTwgc/EzC?=
 =?us-ascii?Q?4obKgouJE7EH6h3vIqHJyZKvOqToZWos4f3N7Zobiu0GPWIFrkTJIobDCmwI?=
 =?us-ascii?Q?v7+cbVvRDiuY2URUfKlQTbg7BNDDGj+b8ulm2NTpO81ExWZT/OiGjTOnivT7?=
 =?us-ascii?Q?kyy4nrvfgz9uC0g46cVpKYh9JxvHas450xZBpUt5D6b9hImQu1YiQ8WLc9BL?=
 =?us-ascii?Q?3SDRITeJWUNDwZynb97aw6JbiRQ9k9lGGM9vmHYt7GB80YikmibtrVCNap0Y?=
 =?us-ascii?Q?S07NpojpqBjwQGwGAQBvktlzfQFkZc9CKRD9qdcOM0GN6IOsIp05ygyu8ith?=
 =?us-ascii?Q?ygm8OimgnkLxsNY1VWHQBbwc78R6ROmpVAG1LRutNy4bYetvywldL3jXF+IH?=
 =?us-ascii?Q?P55AZ0c2ZtpoMYxomnH3dey2aH94tIAsuvev1pEL4uLFExyyK46+j6zHfc0r?=
 =?us-ascii?Q?diJmPpWhZ7RMfiWMS7CpO5oFFc4scNce6MFcu9Cqtev4Z0FtSU2FG7rMnCIQ?=
 =?us-ascii?Q?xbx8l+rChW7A+ZKfuTT2gtn8PeVziPSXg8XOhP+9kpqUSEFEbWxmRGxGEKK6?=
 =?us-ascii?Q?IdNys11UxU0XS4LpfN82/9dwd+m2ZAbkWIAlNzsxr2fCA77Y57npuw/+xsZy?=
 =?us-ascii?Q?Ch4NyBDxtuGWtFJQvWhh8BdkDqEpCyVjvtRnVJheN5R1Y40SBv7K2UhDjWX9?=
 =?us-ascii?Q?DJ97WDOy9xEte5GlIQCfGIlVSi6caaptZYkHQBk7Lfg+N1whx5KOVgaw0u8m?=
 =?us-ascii?Q?ORJv14JqMZsk/W0FgQOMD1xizHzHD4sR/MdNDima7yrshfvjFfYPGgIkC7/V?=
 =?us-ascii?Q?2Tsjvcg5fuzLwb0nR6Wv8HoGSA3PDqjfrw0qNpQKz5QMuVb/hOMFngjvyhc6?=
 =?us-ascii?Q?9F7rTMfaeq2abTXawW33UIeI/A7OuMNoV6DxZVUxOak0tgD+ignsR2Vaofwb?=
 =?us-ascii?Q?+7unWmjgPogthUwxVmPtZq/bMVnx3B95e8xKfR7x3t54T57BSJ2Nz0ylxEkT?=
 =?us-ascii?Q?oNo6kI7qsc5USiRY6PdNdXXhu4PbZGh+S1GkyjcjqyePzpCBuCryqLA3gPB6?=
 =?us-ascii?Q?c/Djm0MzQsuGCgIlv21hARF4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011)(7416011)(52116011)(38350700011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qD8NmXYOkrCzwRHEGXM1jGP4xEBbEBMtmKi8Foe2iTopy4mzB/+BMQu9Ld5o?=
 =?us-ascii?Q?hsfpieuESVO7QPgHfIemTgL4IinFbzf+JCx5XGj7w+H5Nyjjpmeb4toD6kYD?=
 =?us-ascii?Q?GGBboAdJpP2LVgOAv17Me1OGXzvtg2srvk+rjHLSS1xo2KDIS2KfuK0Ld17S?=
 =?us-ascii?Q?e7VwSPuFshZ1Z3JhDHt1pNrvmxrWLmVdmR8cmE3ERb0hqRymq1gCqXN3AdtX?=
 =?us-ascii?Q?RtxQ4aN/+lVc0ihkJGlkvuAvbcE5K2FfwgtOdIqH8LUWbYSogIoHW3xoK3NK?=
 =?us-ascii?Q?muGX1ITyUIoY8egTy6iTjZpHkQkRiEPH/wNRema9B5osDTN8s4lymqWueC2I?=
 =?us-ascii?Q?/Ghj3UtlV30K6N1NeMxMErMoJvOBbrhz9t6Fs0HuWcrqzuGYEE07q5pKvLmb?=
 =?us-ascii?Q?WrWxTh6wIwAI6RN6/AlHt9zNzqsT1m6IxeDD3+YdaJd+6OsfQf1dP5JziXyE?=
 =?us-ascii?Q?uEidCcTmO47gNi/KVVwp/EQVgUUq8RKWEQe8wPkciUI+RZuYyWPt3n6bpFQ4?=
 =?us-ascii?Q?cavqI1vnHr/wZsEb9pFC64kcfk6cL8gEwQ5dGITLQdHdN5UU3dVPc+cOEPSF?=
 =?us-ascii?Q?xqZhA3O2XOfzxwcSqZw8z+DbcCXI0XiDwNZp+Kz97m4MhTLC/QcORsnsJED9?=
 =?us-ascii?Q?ALCBpg+vV3Atrlo2fdamB/qV8EmpKp5l41+v19h1P8w2NdQcXPuE+WNXMS7n?=
 =?us-ascii?Q?UFONcZENp1s/sUkD21ui5Oi4hfOx8OIFPxbBjjsgQT3pLwhprIAfIu5CkfHE?=
 =?us-ascii?Q?HRhlAMHFE84u2rXEhF+RbPdZMHEU6RTpXY/6fUAdwkbZvwca/OXq/s4scjNx?=
 =?us-ascii?Q?IwZ2GlGP8wWB1uSjJGA77aSS3h2TTVx7/ONHQB/ohYlAkss50sGR3mRWEpJV?=
 =?us-ascii?Q?lv/qA4V86EIQtLR3AOk58w3NlCyfLIY/ToXsTzYwjAa4ownU6q8HGFIr1OMF?=
 =?us-ascii?Q?bLSYd/bZojar75eXei4m+BAwlXECSvPKJxGm1+Je6HGZigZEkX5ylcQo215W?=
 =?us-ascii?Q?Xz6DEPbkWrodeMm5yg+qG4bktxAPH/XND0IIKQO+cCXaR+hsv6dg9zHGolj6?=
 =?us-ascii?Q?JhJZ9a8gOX2VzxHwQ+Z7bSrxQMLBPB8KYHS9dVaVXvf2KaDFntn6eLl0q6cr?=
 =?us-ascii?Q?dIuZlEjSFtWN0Gi047CLbq9ro4OeD3M6nTY1kEjs6VwORW6+ooE1UH9T1Lyu?=
 =?us-ascii?Q?EPmqu/KcatCVCCH73NH67snNqvwF0nmRcZqeb3ERqc3RL0xUFU5hS99n2pUR?=
 =?us-ascii?Q?cjmB623ezYP14Gkmu709X+ojlkTPOr3qRBsjhG5JI+AEjsgioHuF67eTQhf5?=
 =?us-ascii?Q?3ip/RF1ZTxyd9GJN2Jq2puvTiJpQRpSFvJLvjkEGGWeAgwNAnTw6Ne/Y8uVH?=
 =?us-ascii?Q?UOIZFPpRfsyQe4qetkotWJjzf210YQevH2dOBijZnYmlregh6CeJG4oxDi/F?=
 =?us-ascii?Q?WRWwQqEAsb7JDGS/OnA5JKZ5PCFwB5UVgmMXvDAr38twHvUgrQuG+01JdB0f?=
 =?us-ascii?Q?aBKVzVRasW7Z/sAEn0t2DbikzBzzmPUtxvzO6MHs9H87apQsmUXG01X6NXl8?=
 =?us-ascii?Q?YYvB68o0MeyHSpyjtQbzgp0pSSL00a/2ghM8e9zP?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09c6f427-825c-44f9-e1aa-08dc9428470e
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 08:33:09.3624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RyB/0WrYWsjcugfJAqmyUxVWgbxSUUOmtiP2eOv2iSqXKajo88+ZSUTTDp/Vju+9ccQXEw+jSsSkXN/llNC1JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6456

These patches add board support as following:

 - 2x TYPE-C port
 - BCM43438 bluetooth

Changes in v4:
 - Add SoB tags for original developer.

 - Link to v3: https://patchwork.kernel.org/project/linux-rockchip/cover/20240620014536.4019524-1-jacobe.zang@wesion.com/

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


