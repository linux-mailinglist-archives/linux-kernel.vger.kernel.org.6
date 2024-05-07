Return-Path: <linux-kernel+bounces-170792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 116A88BDC1C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 09:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1128FB226AB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 07:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD10913BC2D;
	Tue,  7 May 2024 07:09:01 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2135.outbound.protection.partner.outlook.cn [139.219.146.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BDF13BAE2;
	Tue,  7 May 2024 07:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715065741; cv=fail; b=Zi44B4bdoJJhZ2KLYrgTqXyNda4GJwcj0TMtuRQfiyp5IRTNH/Ok7L7lSvlVo/rt9QGJt32q7iz+W6oOLY0F3CADiCD+WrErbG9agxYXmh9w+KhTtv9Th8dRD1Xb9iABSGNaNIzi+vI1hoMMc1lqQJhRbgl11ISiFc9GgxlRxF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715065741; c=relaxed/simple;
	bh=wmsQZvYLM7v74/KxwcGkXba8pASVV5O1uDSdV18OGZU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ebFBSyTMXym+o2G38hT/OY46VDihAWQWN1Mydbn/xwqEXdVsxoxdH3YhYXCTusrNBkIu1Woa7AINPlhYz5qd8jO22MJV8V0vQ+ymT6V3chctjXFZeEfR9rJjlIAaBta7SvxgWb6dYV7b0Ezj35A9guFXRgNSUrL7b8GKZi5oNrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n4/p2ykm8Gzk4FTkkuG+S5XckYp1GFNpVnHnOvEWMnlGPK5eW8wACDwyRjM/fD9CzjFbX438ehyYwlNsXpIxh+j16tXV3H3NwLzdp5D87fL0kWdN9ca5jaLMHTAJLgbjHif2XqECnZelJSGoKJu4O6u/1/ePTS1nyUHox86axNijgml/vFhfcoF9yIn4YNpXmg3+Pz/yrbx55ylUnOQKVyzInGNW9vIcmS0pW9G86G3GWpseA4t6sCFEbC4JFBxiG+BJI3icFwtBBrozJKKGleXlgbTBDWiMs7qehNz704EzUsjFHplHlG+UYV5IwEaj+6cYs+PzfUgkGHEDJyy0sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rPgA2XoWyccVJshY4J0NiilpptzwP1FKo3U4f0T4ofU=;
 b=EqTT6qjs6PmQC/UBRmcbSMsloLBgtg6+U4Y93aJwDtbZrCvv6nnpwshF5GzWDzyu2PJVziFr/nrwgq9YeKT8ylFMtFfJyZ2HEH+bYhHlb6KMo0OTWHeLzpTjA4e3lYzTm2FIhQ2DhJdnibdmeNhLsZYy6KIFURbiy0HeNA2pyjQo0bzGtK3PqYzgYUJs/4tYMpIke6ndzUnUkNqc7pyiXUngpGZi0dOz6o98jOz4lg7KQbTE4430aIiOPOdDT+JVaUCmau8HHYs+TQ7OTkyg3fgavI+jOJ5ZfPDbi7t87tReY0gEqFU9RsgmxHghCLwHDEBJ7E+/qrrYLI7F0dwdeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::10) by NTZPR01MB1100.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 7 May
 2024 06:53:26 +0000
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 ([fe80::e903:99a6:10b7:304d]) by
 NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn ([fe80::e903:99a6:10b7:304d%6])
 with mapi id 15.20.7472.044; Tue, 7 May 2024 06:53:26 +0000
From: Xingyu Wu <xingyu.wu@starfivetech.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Conor Dooley <conor@kernel.org>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Hal Feng <hal.feng@starfivetech.com>,
	Xingyu Wu <xingyu.wu@starfivetech.com>,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: [PATCH v5 0/2] Add notifier for PLL0 clock and set it 1.5GHz on
Date: Tue,  7 May 2024 14:53:17 +0800
Message-Id: <20240507065319.274976-1-xingyu.wu@starfivetech.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SH0PR01CA0020.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:5::32) To NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NTZPR01MB0956:EE_|NTZPR01MB1100:EE_
X-MS-Office365-Filtering-Correlation-Id: 152807ca-7b4e-451e-8105-08dc6e626514
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	M6Sr/ThJJsODKblb6b8Y/WDxPd9h9hNzEQP0u+SP55DgdeCtHU+ZWeUOEzfJlKMfHs12OZvhqqAN8FiAfj2exfcoRAKh/5+bPduLfHk3g7SMVT275Xw1N1CtiTNu8RFM2Ax9oqO+N6cIqDjwi49XRgtlABEZOv4Ucj2hMrHs+Q8sPxFpTqTfxhmHc+0CD3LNZhQqHoiVB5e41bqLE7ZumwKw43edXxmV2ackak9/K0KMFMuqb62X9Ouw3ujqUE+GUeagjMdr5V7BcwJWrZD7a856l7+eGgEy/2m1RNRCLM41+AEv3rdusiZHdcEpX3za3YU8h+4cg2UfqUUcaeH4rOesSkQWIsTBpNu5EPvz3BxcwRx25obD4Wf+LKdkEF/V67zGeMCwrkmDkfPJHgsSUg+g0F4nMjEKmXxNE7l/6MZ9iYpm3ihU3Z1f0dG13W/+RnCy6RK0UGslLVUXzpq5C+mLeiPUQ8q5eSutKju6gFpw7vpnU2D7KaF7bL+5ZiC8LPR16hLaG23yG0ItW7R/VnOpxF1LQ4Eha8tP/TRDlauFrbvaerAIqcHj0gQcUojMLB+/Uhy1ANlLNvphr4HuXeIh97T+YByImwBS5TthiVPCOvWfPwVBbv6ZQIKQ/yGj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(41320700004)(52116005)(7416005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iNalNqVJw99VuuQQphg10/oqeAAZHJGvNb4R1pDAY2T2rr+FGTxp1dImFiWx?=
 =?us-ascii?Q?zeJdn6CsQA1QdvuT8ldSGM1pvVNLTro9CXNOctygI7Av/OVTz63uAZlOdm2T?=
 =?us-ascii?Q?5Gai6eA17MM3K/CrVYH9/cSW/2JV+cVfZWFCPGRBlN7PGbhuotUb/KVIEQYO?=
 =?us-ascii?Q?AkqL3cFGNo1VK9FhbnVuxH0cWHQ/TfaIsYoVPNmxVkXrrpuoGqmJEFvmhPUi?=
 =?us-ascii?Q?Ketgl/rT2/pS3bAHzSsL3GJ+96mgzc6VNdY/Tw8rcdLzWiuX/D6qpKyKARRw?=
 =?us-ascii?Q?dzdLWFA2mCg5dDVVVoApeoUxs9h42BU5K2/V6QzUGAIzdAPg6FKSHJ1BqTpa?=
 =?us-ascii?Q?3KfRz521lFBiYi1CDQnPutY25lND1UrUtcmm2UkFK1jvjjbDG79+QhHHN4jo?=
 =?us-ascii?Q?4laBYICHsfwaHPgXFlDqFnhyic3JB2QNwibnt+w9OIreQ8kGEGU67s1Mo7Bx?=
 =?us-ascii?Q?Q6fMjA8VvZ12yRikXNmlggIVbx6h6hK8A6ZlJHa98rbSwrUOyeS/UjHmcviE?=
 =?us-ascii?Q?KVbbiq+ZWNdqZQjserTbdRTwEuQaqT6E03jax7qOEzKN3Jwjd4VeF0vHWc4e?=
 =?us-ascii?Q?swZM5lR+his2poAmUTqKCe4GJfdC209CUQK3K/D8J10P1ximYJrprlSGq7XM?=
 =?us-ascii?Q?/j7/9P0cf2D/zYzsj9aRmF0m8a7ZaCqod/OO3gPa0pbJEXZZ8ZiliTGikhyA?=
 =?us-ascii?Q?9gJRwcFnW8U80gimdMWhN9Y2LYstc1zSEqiBE7CORBMtft3WtJLRoR8PErts?=
 =?us-ascii?Q?gTVXnuVfHwiDlIi/XBNlbcx+DVMrbBp0iFvHatlghxnDSPxlCyNF9IeqX6eI?=
 =?us-ascii?Q?rmAU7xZrXlfLxCUpz17VFUvV5bJR3lHHYWibElHUs6ID04/BZTsiiDFCXYCe?=
 =?us-ascii?Q?xnMCwT1m5T5CEqhycIjNepMmOhMHlMPJYm5iJM6EJDaFe7gZOODTru+PO1LI?=
 =?us-ascii?Q?7w7ixjR+yAlhIWqM5t2yiapxDYMjhkajQ0USEKP4UqVROUoEfUigcIrv3FMH?=
 =?us-ascii?Q?HQLJf02NM5ayjHLNs76UwDDhWxGp6AXrMYiWu/DQSUf65t0OhEttHWKFpPzQ?=
 =?us-ascii?Q?jg4CrAoUHrTtbDGBFsNg59O6d4+PAamJS3Le0NZDTzIB5V5FYMXv4O6aq9wW?=
 =?us-ascii?Q?EmQS7ZfLFMlqfHbbUST8hbzCO+/QPzkkfp+2XlFVPw4IJQEhtCuu4nrB0ME6?=
 =?us-ascii?Q?USpbqe+W8EN18N1RYRdyDcp5WgrbKd99yEMTLvWi6VThBGk/Z3UH+Z70wpDi?=
 =?us-ascii?Q?PrR1cPybw2i/z5jAV5i9+hrhKo+VG8TBlMzN6S9syl/0xuhvslcislleW9iQ?=
 =?us-ascii?Q?tt6lUjBAVMcrtP305+srpYIpmWhUzR6cy+47KtKXjocDNYLiuttHqkYLA5DK?=
 =?us-ascii?Q?WRoR4Avd8pDLoBQek6EbgsfuBHX1H8TRxREkdGlKuBLwLAdi4XCeo/AKSREl?=
 =?us-ascii?Q?P8I5ZOKW9awfFNY/mOGPxWnHPDsNMlnSqMwdhsiYnzlbfyFONpwZuIRgObMr?=
 =?us-ascii?Q?Bc0c6Yp5zbENH7ov1pvzR2KDQ8JKmPrv8EXowj2WMmTqymrOC0gXpSgxdFKo?=
 =?us-ascii?Q?Qs6vVb2MtnOFa6d8TvfZhHfdN3U2gsbHIzhNDn3IVYcd/6+NvZPqboMb/0na?=
 =?us-ascii?Q?Jg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 152807ca-7b4e-451e-8105-08dc6e626514
X-MS-Exchange-CrossTenant-AuthSource: NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 06:53:26.2788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6zVqLdz08ABdYP00WHRKKWdpyDLSYoY+pYQvIr+suHQf5gi7jwK252/hNso6W9wzEtN6XQAvKrrf1WuyKrcitnfGts+XZe8HRhfhpDuiSN4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB1100

This patch is to add the notifier for PLL0 clock and set the PLL0 rate
to 1.5GHz to fix the lower rate of CPUfreq on the JH7110 SoC.

The first patch is to add the notifier for PLL0 clock. Setting the PLL0
rate need the son clock (cpu_root) to switch its parent clock to OSC 
clock and switch it back after setting PLL0 rate. It need to use the 
cpu_root clock from SYSCRG and register the notifier in the SYSCRG
driver.

The second patch is to set cpu_core rate to 500MHz and PLL0 rate to
1.5GHz to fix the problem about the lower rate of CPUfreq on the 
visionfive board. The cpu_core clock rate is set to 500MHz first to
ensure that the cpu frequency will not suddenly become high and the cpu 
voltage is not enough to cause a crash when the PLL0 is set to 1.5GHz.
The cpu voltage and frequency are then adjusted together by CPUfreq.

Changes since v4:
- Fixed the wrong words.
- Added the Fixes tag in first patch.

v4: https://lore.kernel.org/all/20240410033148.213991-1-xingyu.wu@starfivetech.com/

Changes since v3: 
- Added the notifier for PLL0 clock.
- Set cpu_core rate in DTS 

v3: https://lore.kernel.org/all/20240402090920.11627-1-xingyu.wu@starfivetech.com/

Changes since v2: 
- Made the steps into the process into the process of setting PLL0 rate

v2: https://lore.kernel.org/all/20230821152915.208366-1-xingyu.wu@starfivetech.com/

Changes since v1: 
- Added the fixes tag in the commit.

v1: https://lore.kernel.org/all/20230811033631.160912-1-xingyu.wu@starfivetech.com/

Xingyu Wu (2):
  clk: starfive: jh7110-sys: Add notifier for PLL0 clock
  riscv: dts: starfive: visionfive-2: Fix lower rate of CPUfreq by
    setting PLL0 rate to 1.5GHz

 .../jh7110-starfive-visionfive-2.dtsi         |  6 ++++
 .../clk/starfive/clk-starfive-jh7110-sys.c    | 31 ++++++++++++++++++-
 drivers/clk/starfive/clk-starfive-jh71x0.h    |  2 ++
 3 files changed, 38 insertions(+), 1 deletion(-)

-- 
2.25.1


