Return-Path: <linux-kernel+bounces-409443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B3B9C8CC7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 15:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DADB282485
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 14:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95863BBEB;
	Thu, 14 Nov 2024 14:24:06 +0000 (UTC)
Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazon11021121.outbound.protection.outlook.com [40.107.57.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6A82EB1F
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 14:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.57.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731594246; cv=fail; b=MQdKrgFzmcRbb3sXABexSoJqnVFptoN7XlHWJZvZTwlPYXhWPToW6w6EnM6WXgfRoGzpwD5Puw4dp9gRlfTM7/8XPwmGCbem0Ca2IRkKpv7lraRvIhVAAMtkR+SXvnA8ra6gxAm1V+usndImATl6nzcSI/TB+xs+IboJv9gAr20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731594246; c=relaxed/simple;
	bh=CXffCvbKK4o/Kq2r9z893IuQi7sVmPZDx9oIr9s0e8s=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=paKCvFS1jT3uaSl8tSGBUTSUnM1uCfjyEFJu/FirkGujk0NrKn41nCLWDFT/YuhQuATHK8sgXdFb91bQzswpB0TfMHUaazVccpKiiZqbhWu4dlTFtO4J2jFg6CvvFhDlXKUYzc0jom21E+YuhsXP9lAOyMl6uB/LqapI7R7MlxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.57.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d6YWiusBt2ELW3LVrHXf2PM0hQGQKv24B9zi8S4diqvOF0LlkPBRK3WWQruO7I0Y1siSQycEmbOuLML4OyssvLfIG5G6rhJCBKo+Re87Ri+lAWhR5M2qUU4Q3ZeZ5fvD24ZLpRNJye8daxIq7J2vwF4betgQJPNxzS89sZt8Y0RqROZ8qGsx7bbmY8l1toZITXApjYy8ycvZ32WyYHKn817bDbKuF+ZT4r6cGwwQiZfxAVOU72lFh9pr9edppVANZJq12PFkDPTDdmmsDpAQN9OjEwnCFT+853Km7tbZXflpADWiGnWGMou+8LYvrqmDtPXfyfAnPXHI8G5RCNSbCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MIkk/ugghnBw6fYu2dCC8sqJ6JiQClGOjOXMCnI8Iuk=;
 b=U6SjJGQFjg0S0xtADK7K9eArsTBAm9lM1Pzc6sUMzfVUX9tB6zjgScKKFKfZIk7EFm0OD+F5V6ZZXeCz/8n170WVrdC2++9d5jVSljoS4kN0XsuTdjDGJGUFUovyhoRCJCwyFG9g+iZ6DOReSlQ95/ippcmuqHY5EzX433tf8qyBDVbjXV9WczCq3DuAj8BEBFRlCE7J+A0867wuOl193d4GE1KvNLUbme06flIWcVM0k/wJoEfbzyrvsRH1SHrnconembTZbpdkRDrPvVUg9yXmv9StPIlUXqygOvwEdr8v72CSqYO9ZV5uB2ToM363GLS4Gmph/jLs0FvFKpoSMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from PN0P287MB2843.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:204::8)
 by PN0P287MB1374.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:189::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 14:24:00 +0000
Received: from PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
 ([fe80::1134:92d7:1f68:2fac]) by PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
 ([fe80::1134:92d7:1f68:2fac%3]) with mapi id 15.20.8158.017; Thu, 14 Nov 2024
 14:24:00 +0000
From: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
To: will@kernel.org,
	broonie@kernel.org
Cc: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Marc Zyngier <maz@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: Refactor conditional logic
Date: Thu, 14 Nov 2024 19:52:30 +0530
Message-ID: <20241114142333.18210-1-hardevsinh.palaniya@siliconsignals.io>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN3PR01CA0080.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::22) To PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:204::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN0P287MB2843:EE_|PN0P287MB1374:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a4d9809-b38c-4119-cddf-08dd04b7fb49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jkWiBGgkLvEFtdwCnLpZQ1FhjdWJdETc3bZq+rQ1djJXW2HQXszRv3uzjT01?=
 =?us-ascii?Q?jGpw3ooQdvh+a1C0uYZ0bRIi6vND+XY/820EvcAR7nG2YNK9F9Vx8hFg/S0p?=
 =?us-ascii?Q?Q9xUTM9TuFtrFmN4PwU0TCB4eBM4gAx59oGWW1q6MRTwd7TL8oxM4ok1gMui?=
 =?us-ascii?Q?PW0Pcg+r1Gbe6a8mjeGM0l8v/cud2WLI1yS7hI2P9ZiGxolai/dPZg+8nsvp?=
 =?us-ascii?Q?HoCOqhl86unvWzhnEzGmhty72Q5AGtoYX1iiI6R9GCA+9yabC7nqej+GlF1+?=
 =?us-ascii?Q?sMrDLLXicjBj5GrMVSs0oJgrNHjkIfodfpP7+em+svhfRy+McJp6RrakBueO?=
 =?us-ascii?Q?tVPB1BYZPTV13jRCrPAgmcs0Kavnv5WgmaGQ7iMCVA45yAeGXu1C76k/Kefe?=
 =?us-ascii?Q?4V84m6AvIuWOde3M1Xrb0Fo0DKfhegoaWOjE4haLIX/1p75iAGnNERAzzeSc?=
 =?us-ascii?Q?kbTIIDJjqRKMe8gkpRkG0qck2iyBXT7IxwcFmKxqETtM4PhMc/1BFvkQKO9K?=
 =?us-ascii?Q?1FGZ9yL0dAGvbHLrUBg5/RB9poidmawnmnPoa5EZtM+SgDr54kQ+RlqxYblY?=
 =?us-ascii?Q?1huK62ejsxsyX4gdFCdGU86ydHYeBRW8ZEkBdn9GISXgIKQWXVkSoqW6gllV?=
 =?us-ascii?Q?0DB6wEO2Y9K14dUfyshVHzczghkcfpDORJixPcvipoWzXP/iPuS8e94UrVq2?=
 =?us-ascii?Q?N5iVcKenhG2AoERI/Zm8z2iZyAP5RYnB/L8RmbkwdxdsjKVhlVTfd7gmAODy?=
 =?us-ascii?Q?Zkypj0FxNJCOipYJuelGvomZGgYcUNmkT/OIi1Mb+jJ2CdlKN3FC3rSRYd4v?=
 =?us-ascii?Q?4mhKMHZJWmbpKmxEIABYxCIcUnJHe9CGYLYfowPr0ZfBp0LvJYkGW35vrN92?=
 =?us-ascii?Q?f2AK92Tra93LQJ34VYEWDP7SG0CKP1ZQpWN2NiMnm0xRIlaPDFZWPLswY7MK?=
 =?us-ascii?Q?0wEZg1MuQY5QV35ioSvQHqTpfltgDFrOGLwYU4yQKUog5+ObHYEWI55W6eOx?=
 =?us-ascii?Q?Ql4KVRsXf2x3Bag55tEyqaFEMc6UhKg1J3BdCoGdlEOG1p0N2tQAXfJ5GxFX?=
 =?us-ascii?Q?msQGsMG21VdrEL7vGHtuS2FvrccAOtmSf/3NoCfjHwIOhu5a4cUJZlVD69Bz?=
 =?us-ascii?Q?Nzst3Vf97H4OGoqxKUNL5sAHp+L2K7xpv4c/lWaU7D1F4PJ7IziCP5gdaWUb?=
 =?us-ascii?Q?pupWREjQjzkzz4Tm/fyJqh6k+OCQdFpQgK+bzYSoXQBuXFfm1hKfNylDWq0q?=
 =?us-ascii?Q?9pPxENFn0IC/1QsLBuVI6ZE2p2baJtlJHU1ObyGDE2/GDJm/ROB6KLIjO/q0?=
 =?us-ascii?Q?A9BWQ0/lfMAUShY8AA9Shel4rqB3kATwxuncVplTDLZ+Qlf9Y8i5hVaHcBCr?=
 =?us-ascii?Q?VXcYKE8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN0P287MB2843.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(7416014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X3iPXOmHvxR2f429cVS2iiAGcHDBSGSpDOM0zAOJ2e7i/J2wVLlxm9vANajw?=
 =?us-ascii?Q?MXIoB7bf5DwXPXIJ66LFOe09DASKYo+h33SjzeSnG8fWwit8J84ou4MbWZuK?=
 =?us-ascii?Q?tG5dAYPHHesJaWlex8Sv6d0u1kExMH+pcGYjqNrMNAhKvSG95gtS33WB0eDU?=
 =?us-ascii?Q?AYD5Ed2KVttG7uS5rnBwuldiTdeeaqX6SFwTwIqb7InnffeXi5eINcGvd592?=
 =?us-ascii?Q?9rdEgvmJXo33m7F6ltSJlhEETTQEPqlEh/5HhiuLbVEoTPEV2IwYV/ln1uvN?=
 =?us-ascii?Q?UQQqcaRD9ljlnaG/XpREQmS3XJnGFUoZmQ0oWVcQUa5AJUzQpFB2ZwHTu9hH?=
 =?us-ascii?Q?BlQUoAzhrR6yq/Vch2BctqWvgQ9/fEorVujnaBcqOkIxqwTjuPSdyW2WlpFO?=
 =?us-ascii?Q?LjF92dkPGFxpdXSlGotaYd6otJT1w/SqZo/4y8emjbSUJEBycET4zBHnLUCN?=
 =?us-ascii?Q?a6dcVfojoVZdBwczTtaFyebYZublh3E+B272ctujKvmgT+QK1Xj0/ff/tDLV?=
 =?us-ascii?Q?+xwMIUt5hJpRVuI/Zpz9EKB1J7PVVRZXXDhAvgyl/4wwG6YLrj9a+CqBycJQ?=
 =?us-ascii?Q?BFVITTbJ4OPtaevwuw8rHs25DcKIxjHn2Guyp/Cswn0v1m+fWTfTBk35GRbm?=
 =?us-ascii?Q?MxtGJ4ad7HToxdg0kOTljRGpdIyHCt5QR97gNeeYisi4K+PqBpym2G7mk/GO?=
 =?us-ascii?Q?DBuS+Qiu/lqc1X8rie8j4UtFcukFN4Oo2x//3pJ2t/bBONE8ObTIdBRlQ9pe?=
 =?us-ascii?Q?je49bX0pXd0LU3AlUH1JRB2kNPHsQ0RQ3UgYsV/sUEPFpEbXhBQqlVtI+HeQ?=
 =?us-ascii?Q?Erz42EEPWORC7PWmdLMD3eT711Kf8bxVwEpIUDFl6nnqfbEjHDmHHlkCwG2m?=
 =?us-ascii?Q?p5KbUv0VZX6IiEd5qMVedLfgYj5LBIEJo5R+8DjWgSStmoYMgjSrNxf2t7Su?=
 =?us-ascii?Q?1PKFJ8cJUvPnh8a9WL0zs1iRvtuqUSihmk5IKLxuLRN4e7CENfmtiUoCkTqz?=
 =?us-ascii?Q?OuH0Nx8944h/eHWWm/e9YQliV4WVW+N7Z4VO5GuAB/nq466wF/YT/Y+0cbpD?=
 =?us-ascii?Q?G/0ihiLnE77+U2jqYKB8MZ7TlAGLm8cJguExCWg8R8T11fnAxW51eIli175E?=
 =?us-ascii?Q?dInfWhTkxnafSYBmz4MmFFCTw/x7tFEzAO7T/52wApaeEUZ6wRfzqX4RkxxR?=
 =?us-ascii?Q?s7M71k57gaBbX9h0HnNQDonussoMUDwejggCTW6fhXRam3ynobj/tZXAmwG9?=
 =?us-ascii?Q?nZWFGWxsimknyo67QTmGFrYyxgHli1SDWrNaxys3RVKfxDwQpSSwWSRsDjad?=
 =?us-ascii?Q?sjWPmDCRUIhublEQIk3SQjjEVrKTIj3KUlJ1G1F1OzoiaVlcbzcvEDAgQ4nT?=
 =?us-ascii?Q?iEpT6OcLB/WqgRYps4qxkgOmTkHEwhexuc4y0AOVOYJ0swpjUzcsE7p9c5vf?=
 =?us-ascii?Q?QjDt+XFqMzr3vyGoWZ/T9SB6SO67EQPxqKIGFsXSoNB72LivQ1gERydhPBP1?=
 =?us-ascii?Q?qxaAKkSdErQ2HXN/Iy6dNMAMyWHKi93Y3Ldp/r0DVtmKB0NC0GLvSrGu7gsD?=
 =?us-ascii?Q?IH/YM6ULILwLIvsPLZkeFeURCnTSTAF/Dpy9Pqe24cg5vBUXEkcoGv19vpwP?=
 =?us-ascii?Q?cjefh+Ht8Qn5fsEdZXRDEikestPpP2fgQLQHDyq4lngS?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a4d9809-b38c-4119-cddf-08dd04b7fb49
X-MS-Exchange-CrossTenant-AuthSource: PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 14:23:59.9564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NgCmjB1svzW8Gn3zcSj5bd6isNIjJ57itBY2vK42Vk1wvcbm3HLQ9IsH0Aj8UoIHtYC1RN5lvvzszZH42RRvLIZvRuO1DuIFKJKZ5at1x1vC7j0Tz/MLkebLxyil73Uf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB1374

Unnecessarily checks ftr_ovr == tmp in an extra else if, which is not
needed because that condition would already be true by default if the
previous conditions are not satisfied.

		if (ftr_ovr != tmp) {
		} else if (ftr_new != tmp) {
		} else if (ftr_ovr == tmp) {

Logic: The first and last conditions are inverses of each other, so 
the last condition must be true if the first two conditions are false.

Additionally, all branches set the variable str, making the subsequent
"if (str)" check redundant

Reviewed-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
---

Changelog in V2:

- remove str check 

Change in V3:

- Add logic in commit msg 
- Add review tag
---
 arch/arm64/kernel/cpufeature.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 718728a85430..728709483fb7 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -989,17 +989,16 @@ static void init_cpu_ftr_reg(u32 sys_reg, u64 new)
 				/* Override was valid */
 				ftr_new = tmp;
 				str = "forced";
-			} else if (ftr_ovr == tmp) {
+			} else {
 				/* Override was the safe value */
 				str = "already set";
 			}
 
-			if (str)
-				pr_warn("%s[%d:%d]: %s to %llx\n",
-					reg->name,
-					ftrp->shift + ftrp->width - 1,
-					ftrp->shift, str,
-					tmp & (BIT(ftrp->width) - 1));
+			pr_warn("%s[%d:%d]: %s to %llx\n",
+				reg->name,
+				ftrp->shift + ftrp->width - 1,
+				ftrp->shift, str,
+				tmp & (BIT(ftrp->width) - 1));
 		} else if ((ftr_mask & reg->override->val) == ftr_mask) {
 			reg->override->val &= ~ftr_mask;
 			pr_warn("%s[%d:%d]: impossible override, ignored\n",
-- 
2.43.0


