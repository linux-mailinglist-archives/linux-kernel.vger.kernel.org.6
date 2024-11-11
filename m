Return-Path: <linux-kernel+bounces-404205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA679C40CE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 15:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B30C1C20321
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 14:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E151A00FA;
	Mon, 11 Nov 2024 14:22:32 +0000 (UTC)
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01on2131.outbound.protection.outlook.com [40.107.239.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6F815A85A
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 14:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.239.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731334952; cv=fail; b=YsIQ9q4Wc9NLwiKL/W2jWIQS1BgUXP15Vlk0qwZVzV89vH5beAU8gXEuQgZ0qkMWwbSgDL7yRT7I4mYRJfwFWbVKrNToCduTIC07WHudnrASBbhkjePbPk/TXYT5wjoV7cMdyBbr8tLkjawBRGd76OCowInYQ4DTWibXbLvIQ4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731334952; c=relaxed/simple;
	bh=9l2lDNiVYb06H0SWJBs7LRlRjl4GzT8xywYpSgoBGZM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=R/RGJ4VqiJJ9abs5MRJ8e+s0DQIFigiROA0E3V+2Ct24TJbQYpRZ/l5vW7xdTCIUjPRjxWqJzym/suGPhZjv8h1QWR3TH34uzJM65p+9H/5F4J74mBZ5VXI00ipmGENRdicLt69lEXSlxd58JrYVA8md+jSRk3sFWaUznDSTaBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.239.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c6dab1rGH9EOqstXtMdxkjkfyCTUMnrixm9zxcaI8iMzyIN7MFJVNEVja03UNS0jPJ6LFj637346W//6+TFbXHu9+hQEvbgjK8XsMlKEokbuE/zCOzXPjW5xWPDzaWMX5SoDTuOiF9mwnh0xedmF+L6sugRvw2BDDsJ9Ryv66ZuSA6XtUQ1BcrPLQP5fzBt3PXaz8KbE46N1o76XLw/gJXxX9VlqgUjzuOUtmYoPippZu9EQKlFzOCPlIMTKUZrh8k/7qCKK+JrFW40CDspWr2HQgbNFa+2p7+VamBdskSRKOYHPEcRG41jcoAUx2baPUkae/1IbbpkXpIrdbwjGlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xLzAuLFmKjPuTsLOMKHI8zz76Uk7wZ+X4PYIZo7w5uk=;
 b=WZ3S/9i9oAdKnTikbDr9ZIFuQ6j+m+oWvIevx7tt6bEgzNImMA5NisrHqF3eJrWDhjBSf5T85k668CENFJHQyrgS7LHi7RPrKsochAzbxxbgcg2AwuMAreQWV2XeRxcw5aqAEGYDym1ZVuHh8EFw9jhpk+c84um0kO/EY0aYBgirrv5ZJnYT2Gz1SXHLKnXjdVFOzA8CHEx9LMnT5o2fXL/+gzs//kcEjWPAawTqanLgszLb//22BB9kRfKbNSzDMilH4x+1pBfLr/+NOBXtO3VtEV2EXcj/WzY0RjPFdtUJ56ZFFVvFSdWeyzhnR4jLy82YZFPL0GW6eW8JZ/sO/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from PN0P287MB2843.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:204::8)
 by MA0P287MB1516.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:fb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.27; Mon, 11 Nov
 2024 14:22:26 +0000
Received: from PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
 ([fe80::1134:92d7:1f68:2fac]) by PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
 ([fe80::1134:92d7:1f68:2fac%3]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 14:22:26 +0000
From: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
To: will@kernel.org
Cc: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Marc Zyngier <maz@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mark Brown <broonie@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: Refactor conditional logic
Date: Mon, 11 Nov 2024 19:51:45 +0530
Message-ID: <20241111142204.67751-1-hardevsinh.palaniya@siliconsignals.io>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PR01CA0092.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::7) To PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:204::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN0P287MB2843:EE_|MA0P287MB1516:EE_
X-MS-Office365-Filtering-Correlation-Id: 6aeecbbb-181e-4546-83c5-08dd025c4419
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0WHCwGsOnuZFxL8RIs22sO/JMHuAv1MHrPI7npvL5TWQocvtzThU7YSHTSVk?=
 =?us-ascii?Q?ztNS2xwSdDR0jBTwmUO1ZIfcZ4+mWm3XXNRk8xD4CmhTvZ966Oo6rciRHywH?=
 =?us-ascii?Q?kcqMs3GSYMhFbkM1RwSCl+RZKQG16GAn9s/0a7Gls5A9NMUNTBBixlwb08/n?=
 =?us-ascii?Q?2bUykg4pWUJEBYvW8WsofPCEZcP3ryEwRpGEpQOY0EI9F0ZC6DjtC4DLB/Oo?=
 =?us-ascii?Q?+4eUhBEfEh5YxQW5LdR9umf8cExt1lCFAaKJ2hzxW//nuFm6AWT2l97ayj1y?=
 =?us-ascii?Q?27C5v9n6enc+vwyNBQ+havUzNe3HBq1/x0dHHjik5bYSsGabTmxftJ2pXbrv?=
 =?us-ascii?Q?WFTQ/CqltJZTnt4yo4H5siLuR3NVQoO/Bjv0Q2TZNKl1chDWyhT2SUj0QpgC?=
 =?us-ascii?Q?0UU1cIPVH5S8pN/HpLREtEWAEnr/NqT3dMPXb9cenF2QNYQnWoOW8BI4xeqW?=
 =?us-ascii?Q?los6sXNHcX28MBzbzVxcjFJszrfwN9hhl4IrxAtEExIzFCfHGkMbK1hmcwac?=
 =?us-ascii?Q?OWtEhZYPHDRPSllRGN3ynIpiXodnnCEPIguBtj9eT/u6IhhWjM/YyzNVo87S?=
 =?us-ascii?Q?1/zSyKeGRxDweW/RIQu5oAuHoMPkSOgj0pZT+4w4tWnnFV0kJqWE+Js0x7mS?=
 =?us-ascii?Q?feJgxxUMlPeAaXLpZbequOlE+aZLsHl+vagKetjEirQDnMLKlRWKU+k+mij4?=
 =?us-ascii?Q?Rbt9I4K1Q0cB41b3Km2EQgvCHUaGfHVS02KFTt0+05d4doF6cG428xo7+/f0?=
 =?us-ascii?Q?sibXRE5TcgCzCQ3rUqed0+MmB78wi8h19R2wRMmWf/Vg7RPXSutiR63MmniL?=
 =?us-ascii?Q?uG8YRPAamctqk9Sjf2Wre4i5CKEuqrx4SCmEBxCHiiYi4m+tEVzftYNzslN4?=
 =?us-ascii?Q?pcZXyU+aPjeVAEfxzLb3UcK1b3pQE3QTwayxqxV/hBVSTVI7LMb4Ew/0ZDza?=
 =?us-ascii?Q?6/qsAiB49coTUD9TZtiGOBIR0irKoLa87wcZXLBU2DynEQUL7s6CAVXXNH0r?=
 =?us-ascii?Q?nSHveUbKfAMSxnyK5YKjca5x7QLGMsPAQ1zPH6hmUntq25tXMD3JG57JlU5a?=
 =?us-ascii?Q?24nY6D/UROfu2jaQZbVXSLmf1ZCVx6ZW/Qklty/I7RuZbs1BnpEoSNDEB1un?=
 =?us-ascii?Q?GojyV/kNgNaz2IrD1ujZo1ddlRDXa0xvlKj4u7QHJts/yUsxpKQIyYCzjTZI?=
 =?us-ascii?Q?bueo58/Qc/Oi2DXDxSQfY5hQPRppkpWYbzHMwLzscv4mehOBPw6acab56Sf6?=
 =?us-ascii?Q?T8qFZb43UCFBuGFqG/sQ0FHnscklyxesUNNxqjmwTObP003OxlF7BbEkDt8N?=
 =?us-ascii?Q?uBAggXIw8m2Kmyx0U7hQrZzkfVT5k+TuuqytQYLDiUdZTlKhFwXzO/A96BBQ?=
 =?us-ascii?Q?jClVDR4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN0P287MB2843.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DDVSdIP0rxPffmZqyLWcGn3B6ctcL3+rfr9v9KSSkT/a/h1DPCmPsc4IBizV?=
 =?us-ascii?Q?uElcpbXYaHK/0AYIA3d8mXVBAR8HJBj+JDHZbGweHM+LMfOM3bNLC36nR5GR?=
 =?us-ascii?Q?xpa4Lb/w0a/RhoALrknLw8nhEEWJBtZwXxg38L2SEWSqfphVKUjRr0SLZN7A?=
 =?us-ascii?Q?szWYtmD+nIg/+wmRIbwdZOJHpt4hiMRPhhfsAlG5MHa7db20pzYGmJCftPNd?=
 =?us-ascii?Q?wY1HiV06wV9uyLc4IvB8V3QyeFvyn4GoiZnBgH8oqB+159Z/ZN9ExrA56U6M?=
 =?us-ascii?Q?HFYt/JWDq1UbLgqXtWdiHtargnTXC0OnCWFNZzQM+ts+xFt92lRozlsotYRO?=
 =?us-ascii?Q?op2FyDgjj85CHi09c4Ht//jiDr+nn7HAnKhBv5eIcK9Ba3wJtAQGgt/zUgOP?=
 =?us-ascii?Q?vwYvnwRzCgnakjci7/OOD3jZmBhurE43p1GICGjvgb1H5J1kk61l437+s8JQ?=
 =?us-ascii?Q?0CFrFO67HowvlPIURUCSl+fzEjiFKdpNfiK8eU3tLOI3Cnoi6Rz3vJgb/1sF?=
 =?us-ascii?Q?t00EavRWCOO7GXu7CvfNeXs387yb4y4X5sBIkWNWPzE+55KzkaEGVBLlqGoG?=
 =?us-ascii?Q?ODYFcCVjAkBsFyGZEwSafRPDvp8RobkFCw2y66Ac4Dr3NecHY2pv/oJHAeKg?=
 =?us-ascii?Q?ioz0eCl5E25Bwqf8ej9vpTKoGLr6abNBMB6kcSU7zaVwGmc0dR5L39vqabDL?=
 =?us-ascii?Q?WIHcY+0+77J/fSpEezkbNE/ToIVqO9DOe29aaqNhtG5ERQcX/f8mXqzVGkWn?=
 =?us-ascii?Q?2f1gb42RhbSVy6ulg1w4FBXCtq/EIGE2YuR4/SQcTyNxF8piQDsrhu5gZ7TA?=
 =?us-ascii?Q?wV1ivOW1aUv2qLUa2S0c/pYaVFoYuOfGew2bvRjV6n6rBYweh1fJOCBVwPKr?=
 =?us-ascii?Q?Xy1Vsir7NRGgz2guo3c5elx6cRwSdIX0LirU/VSEwhS68gS39pGaIYdvsRKa?=
 =?us-ascii?Q?dOIYVUfX/hXOTmoFgGAylBJo2tBXHyhiPvVf7vxFX/87QShThAdG6xWZi2PX?=
 =?us-ascii?Q?9h9SbQJK6QS13xherAOAcTBaCdXiTOKwRIqFNsEt25v9Klk1v1FtEeT4Ijok?=
 =?us-ascii?Q?lf8mnqVJx/lA1NCRjE1pjNpb0EjPW5Zi3IrJl81B+qxqZxO8tRVfhft7UjYO?=
 =?us-ascii?Q?fAH2NGennngBYbAvN8viQtjfTjeSb0iIAnsv2q00i8pp7Nr8dHAIFqQHaX6b?=
 =?us-ascii?Q?swiezPzzkgEJutnPsJ+mKhWVeBzS1m8AZsWo+R7afuHYioVD+FoHxFMVhmjp?=
 =?us-ascii?Q?FosHRAexectYTtgA7SHxxMpi3QANX1tj34IwiQyPvNp81vlSuSOjQPIGEEtJ?=
 =?us-ascii?Q?JZ4hdhaoToa5UqvJDopWFou4uhIkiaytfF9zRhsv+hDCuRCotNffZ5E3CknX?=
 =?us-ascii?Q?0WTQy7Hig+P8S+eT3cTkcMZhkul16yByorsC/hFctl8deoypJ+hGWIRzuxqZ?=
 =?us-ascii?Q?Wx3jxBr62SinlIAFt5lUgUs49yOeSNliksFwlYeYWFOOU3g8rUDs74jDr6YO?=
 =?us-ascii?Q?F23YGGBFWDRv0RG4sjILxm8ZebbOfYlgaJu0eVA4hVBFnnLhs9APShr6dlBb?=
 =?us-ascii?Q?G0qyHJ3OphESrShz74nJiFtEdFZQ4N/BMzLcp2o5xnfT5EAuIHThmOKirKP2?=
 =?us-ascii?Q?DU6QTbLBjeya6kfV1S7WhJwsE26GvYtfkYx+pyXhvi3d?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aeecbbb-181e-4546-83c5-08dd025c4419
X-MS-Exchange-CrossTenant-AuthSource: PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 14:22:26.0974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MhV5UwHFkWy0myGlalgNUKaK28wGZDZV8sjCSwwi1Kg2F1l00AKN1qq3jEGWAPe2Bgco3j8rE9yxlfDyRPbGP0Wo7rtdH8ZksWOSoteab7QoUZLa74nM+r8rWW27WMSS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB1516

Unnecessarily checks ftr_ovr == tmp in an extra else if, which is not
needed because that condition would already be true by default if the
previous conditions are not satisfied.

Signed-off-by: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
---
 arch/arm64/kernel/cpufeature.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 718728a85430..d9021b1b9cff 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -989,7 +989,7 @@ static void init_cpu_ftr_reg(u32 sys_reg, u64 new)
 				/* Override was valid */
 				ftr_new = tmp;
 				str = "forced";
-			} else if (ftr_ovr == tmp) {
+			} else {
 				/* Override was the safe value */
 				str = "already set";
 			}
-- 
2.43.0


