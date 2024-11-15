Return-Path: <linux-kernel+bounces-410223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC079CD696
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 06:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F07D12831B3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 05:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD6F17C22F;
	Fri, 15 Nov 2024 05:38:41 +0000 (UTC)
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazon11020094.outbound.protection.outlook.com [52.101.227.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A541547CC
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 05:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.227.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731649121; cv=fail; b=BHYRKWh3p2uGbabK4koKqFUScUJzlBN5GKDRB5WnGLCNDANJb7LAOKhADUMS0Gx7BBxjSHSrJK6rL/f6/uRHer9rW5E5YP9ZNAgmbU5QvO5FidaHuIfItj5uCmy9iOBu6ydIdpWawL9YhUhvSWg+ahrNgKNUpFCU2+Eda7HfDHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731649121; c=relaxed/simple;
	bh=loRQlqDZOltf3awVlj26WRMGGe1Mc0lH/LnfiJscb64=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=CrRvjl0enq79ovlWGKgWDxaglHCPogTDNV1LPY7Uwx3YZoSpSKHpTmslxVV8fWXIpV6Klm3kOkvIZqPDnVR7SYipisQQuP9qh93/53H2yIm6jZbaHjCAauDd0OhFK+TyoLLpr8qHLmrMU9gCls0JOVnsnl+0our0HJXm1LsZp/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=52.101.227.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MxZ8ZTYuIIN8H0GKNmUbI0Q3s0AekLcK4WN02L+C/WzJ5J5XdV2miiHz926y8+zU+//CNRYEi3QqWWjCaU/+v6zpk0nUgXpTicrrXlBAmK2LfjQ6pZL1XNmQjuvgtlRXou+RqJOx5msbf5HIFP/2ba/63dqqMtel4idtSqeGnL/d4tq9katEIqKZColhTtoSUfvPCjqe5XhAWPRFi0ds5H1zwJSujJwwJkNZ+/A171PvH7RF1V4dxAqwDbTDyBmcCJW9Xh7TLbFSdMe6W3bjtJaMyBa/fksao7RLPF+NcCnofvp9k16fIkj7exs9qXKUTxltyP6SOZ5KeX2h58GQqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SVz4AKcMAuwonFvZ/Gp9Ev2rF/JsS/L1xWYm5V4XvyY=;
 b=DaqU8T4d0Kejv8mBUIlg4Lqy2pgoaxcOefi/BgQHC7UcV6q3cBpkQUfuM0VPAVEQEjvhWJUBe4oyhTT2sGkZElrUYJ9Lyn0opWO6xcrjDoh4nXr5HMDX+x6IjqaW1Kf+z3mOIBp7hx7sybvcGX5LHdV3YWOIeQiNNZlCgnDbR54F5hG56iHy23ZhY+39bM07J5PJdWuX86WiPYc5igr8UnFSCtWUYxIiuXHb+oRhffenDmbjQP+cR+6iv3BK8cSDtxAhBEUubyQA9taMmYT0TAMB5fATskfOJORll21Ifvhiyi/wGSanYaqxDGWwQ30POuSS/0zMv/a9mJ3MeWNWuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from PN0P287MB2843.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:204::8)
 by PN0P287MB1589.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:180::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Fri, 15 Nov
 2024 05:38:35 +0000
Received: from PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
 ([fe80::1134:92d7:1f68:2fac]) by PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
 ([fe80::1134:92d7:1f68:2fac%3]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 05:38:35 +0000
From: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
To: will@kernel.org,
	broonie@kernel.org,
	anshuman.khandual@arm.com
Cc: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Ard Biesheuvel <ardb@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] arm64/cpufeature: Refactor conditional logic in init_cpu_ftr_reg()
Date: Fri, 15 Nov 2024 11:06:35 +0530
Message-ID: <20241115053740.20523-1-hardevsinh.palaniya@siliconsignals.io>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN3PR01CA0140.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::12) To PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:204::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN0P287MB2843:EE_|PN0P287MB1589:EE_
X-MS-Office365-Filtering-Correlation-Id: 611c1095-92f6-4060-e250-08dd0537bf9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sSXezjCdTyPadODL68QLivLQtbmdClSTTGSY/2pYHCUxHnuAy9w0etKjqxgJ?=
 =?us-ascii?Q?CG34/cW3z+9RTlvG9Pk68khuw3mAdAfPW/WhmZGz9ElyRoAuoVSIRuDdDQBx?=
 =?us-ascii?Q?UMT4c9BHUl5JX6+q7AKSemyL7/ZFL4yDcMMT0XjtW3zqdmCtr23PO/2mKh+3?=
 =?us-ascii?Q?gxsOkAyWaPnJmmGMy++gaBtaDnPDFnwottOfQRjOIT0bepc5ubAcbcP+djLb?=
 =?us-ascii?Q?xP7hj36W6QZdnGXMjLS9eiv/TdzzOlrhxBT+vxxAWp9c0puSsFVX+Nr/wa7/?=
 =?us-ascii?Q?ir5Ju4XlneRvbfW6+nOp4m8TtAkjDU8Fvkqtk8bQzGzFvr1DWiP7XtUXTVbp?=
 =?us-ascii?Q?81LL4nm8WzqzgbQJQb4YEr0b9HUnmwjsRlm8BUabyrpvED6vcrn43NdUYaNt?=
 =?us-ascii?Q?PDlsXs2DN3Nu0LRa8bfyyi7cw0fY5h6RBVn6SpomFxGlfG6srjiGxrpuCg3d?=
 =?us-ascii?Q?gzbiNR8IUNMkakv0aQuV7AZOj4OsbAm4r0C8RjvNKVZNpQWScGV+cRCcJBe3?=
 =?us-ascii?Q?UqTOdYJu3QSg8rcR2HDOuwkh9MFkaGDfM7dqDswFRXZjdFoKzRqHISAdGSnU?=
 =?us-ascii?Q?dXcTJDInLpTOLQ/RZkodVXt+xdeO0H5UkPo7RsBic7y6wOAjQRmhMe06i6xr?=
 =?us-ascii?Q?BALN09t80kGkNdu9txsB9OPPllX50eJp03+Pp+nfjOBhMTYRQaYoVhv/mBxQ?=
 =?us-ascii?Q?L/DgS4eLFTd8HexDng1r/3o5+Rg/WiXs+Yeya7qgYZT1wYeZatYHSTgxUoVp?=
 =?us-ascii?Q?U9tZPshfDuLH2S1xVpGkqohXwuc9cRxU/ryyJywudCz1QjvlL5oxY5VRU1D+?=
 =?us-ascii?Q?P26okhvMa25Uya/ZjaWRH14dlSZTtS6gr05MAvAGKZN0RR+hLE7Moaau7KMA?=
 =?us-ascii?Q?lQ/GZwOsr84EncFIOu+rEvnkWsEPmFwBkJTKbFKZFhE/Zl3bi7PEcF8rSZjf?=
 =?us-ascii?Q?ZNXK3vMhJTGiowca/DadTFmRY1BCunpgiAG0l142tNRHK6XqcA0eVaTyymGq?=
 =?us-ascii?Q?Pi23v19RFjgu6levFx8zDjQsOcqpitj0Qa1xOcmCDZcU4M7GgAJQNQ6midsx?=
 =?us-ascii?Q?yNXMcae9yzUrEDQujJpWHtbWFhhRTfihRpOlOCWIOk0CckctKRdPhYrJSle7?=
 =?us-ascii?Q?PSx562AWjpb+h9xbjcg1k0Wu9yeoolVWTsTtLROyCtWhVn18BPanz4PhDSAU?=
 =?us-ascii?Q?OCczXvMWn2kTDMQuwJuSa3QX4tHY2NRhw8TNeVHBuqjLOtD1AN0SibwAQ8Ne?=
 =?us-ascii?Q?uOjHphZbmt23MQvOglWpcIkSCIzz5PsSa4JfF/JEKvXV1PsKR+HKQbzvbZPJ?=
 =?us-ascii?Q?TjQiLjJsMLWthbM/0cbvgNHmKkqL/ty6ap2C0Prtfrkuu/xIs6fVG+q2ntv+?=
 =?us-ascii?Q?YcECr3E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN0P287MB2843.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tS6nOd1PySjMeQXcLIb0gHgI19IhLgf12VS4L1CORpzqfNb/7XeB/ctom8rr?=
 =?us-ascii?Q?kC+g//ALO2oDVc2gf+VxU5g309H3qfdZnc1Puf7uL+AhAaYVbxRZeFYVN7n8?=
 =?us-ascii?Q?rrdKriNrwXC5uKWCcjnNdCzNxfVqaDx3TfzmxwPMvWDn6i8iHlx24vmddn8w?=
 =?us-ascii?Q?KSIK1FDOPSagc1yOAB2FhFXeNx94g2ra65zA//gTN0ILHmzzRs04p6MyrCwC?=
 =?us-ascii?Q?71CYzwWGmPs2e8ZOaOZhlSAxe1d7UBNzqX0e+nfmNglVbkpS/oA90OpIWArS?=
 =?us-ascii?Q?ATlyhVYKS1XjWkXU+zudtLX9Sr3GHSgWQybV/O93+8o9F4TO5m7auED9xX2u?=
 =?us-ascii?Q?p+rKk4ehM+BriHllQR6jGIg+y8G+27nWy7PLVgHAcetZFFSRQzbp5+wchZHE?=
 =?us-ascii?Q?wOmPGGSo8gV/pfMAYEXoC33CLh5bPJQczDaCRtv3A92mIm/lB+5n0QQIObnU?=
 =?us-ascii?Q?cRODhYMauVgQa4Yqn5ySfjH6aGrTI6flM+8Qa9ba8UT0L06ERfNZq446M8Yz?=
 =?us-ascii?Q?Ygi1qo7DDmuuvGHN8F+pchsFBLD75Yw46DYZ7xqAFPQiBGBgDcsGawPvfsdE?=
 =?us-ascii?Q?jZjjs7H0a5CxJdyf+aEEinpWbqvaZ7tI6KX7xRH+k7Q+qhOrpkJz2Z3xoqK2?=
 =?us-ascii?Q?m4WBDgnUYmERHEe1emBocvtopjm3B3OB7DFKpfMGf5mbyB0tfy8j1Tyd3W8r?=
 =?us-ascii?Q?4gSiT9KJKIWX4y6X9AvD46EOz2IREXYbyBJ3zE4aBq3XY0R8DS0nXz5L0yfF?=
 =?us-ascii?Q?VZy2Sme8xE/SNM+LzH0cThrFTB1V9VxaIVZoshM2ZJF+yLj3JNw0LqZil+55?=
 =?us-ascii?Q?K4Tn2ZmpWjB7INgbeBlG8t7B/AxblWR5aUnv3fzCtYPasMAgaoRi2Olb/Mzz?=
 =?us-ascii?Q?2zffx+zL02Pg+VEwOUVEq/Hx/UegKejeoBQbYtR8VOfmYYb+dvuFdIPCciMl?=
 =?us-ascii?Q?+WxU416Y8dQJtMi6/UjQrFzwsGbF9GtGovl/oY1yMLvOPBjUplcCBlkDntxT?=
 =?us-ascii?Q?i1cDqwreEVJuDmDGhgGd7jWeqRQiauYbn5k3XkYAtlXphK/AiHtMLbSiDG4M?=
 =?us-ascii?Q?yi9aCd3Ce2xjVxcclpGCmdjdybgAAZ/gf3ZlTEMUV+d4w1MjeHrTXRdW38rr?=
 =?us-ascii?Q?UM55h7aU8IM2BfYac/Q0F00lMVxszw+lYFgernN//MJn1YH/6UpwJcLWwWiy?=
 =?us-ascii?Q?cQT1+pTQsjZ+Nh+W325QeaEfPTx/BSYCa3dyVPehoU41oczgaQ6PMeq983Gi?=
 =?us-ascii?Q?5Hq0+DiRbsvhOhCGgaxVYjGJcMIXb6b0uCB1d9Qj1oeSoBFDaLNN1Fx+gaZd?=
 =?us-ascii?Q?hEsi9necC/N0HrgQIjTzgAQNJ7PPrX/TpY5hmNZ5kZiTrXbWfhOD4rm4UdON?=
 =?us-ascii?Q?RsrnTF7APGluj1oBLz0jEFJXhH3iwo7Sh/0vJunOZVC2q8ZbznNlG+metBz7?=
 =?us-ascii?Q?uNmJlQMYRlj+xtGm30k17qRL11GD28pmfDtylmmd/4wSfk20rkUD97sVioXS?=
 =?us-ascii?Q?13dGUiqxfHMdCiBBI+bx4I9g8HcPZID0ePdaeumMRXOQx+CLqDT1BqQzq8Ql?=
 =?us-ascii?Q?9SHUlWfLJOjmeCEmynpCrK6hB97TJ4Xtp+7ksuWS7j25z1YdQAcwVWbm8pDB?=
 =?us-ascii?Q?SDGawY5mMryc5dSO/km8PBzWHmVTRGqd4oKnOCQ+bLfq?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 611c1095-92f6-4060-e250-08dd0537bf9f
X-MS-Exchange-CrossTenant-AuthSource: PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 05:38:35.3904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YLR2S4L0uYawDQx5qaCKvlZlCC0+G5M01RjZnTUzpYvW1RdagV3/PRFgf6vL9z/uv1qGkWDbVLZDuOerC40ppXhxLUubo4qhnrK09zysW0Vn7wHZHXR1EeN78e4iq0e3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB1589

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
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Signed-off-by: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
---
Changelog in V2:

- remove str check

Change in V3:

- Add logic in commit msg
- Add review tag

Change in V4:

- Change subject line
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

