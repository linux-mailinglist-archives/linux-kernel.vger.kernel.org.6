Return-Path: <linux-kernel+bounces-332191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D036997B6A1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 03:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7A5AB248D0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 01:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B0BE545;
	Wed, 18 Sep 2024 01:51:52 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B2B8F5A
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 01:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726624311; cv=fail; b=fu4VpXRLknAw4Xi58iNrswbDZbDKwTvCT4+c3HYLIyFmmXWKq5z5wpbmvk5irSc3Py+ZIcq4auNMOr6jaKPNd5MkmD+EBH7KZrlc64X+3XUF94uCLfbpC2hWXvbarre2MuAq+LDhLjmf9yCZDzVUOU/zUx1vxoIxBsV1qjnQ4QI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726624311; c=relaxed/simple;
	bh=OsP+i2iULQ5THtrytZuzOgEFsQRdQUVwH0+R6f28t/M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IYkOv53VVjE3hY+5ww0A+03aeXKUfBT78X95ar6Etcg7YVR/z1wLM8/EstuBmrT/yZTxlBBKiP/lypnTb01zBt6bfk813bg1FA/3zB9qZyFcImaJlbbJXCJ8iK2Sn4nVs/QuQ9yr2xDAxrgZScv0/uP3vvlurevYNLKi3IFTMPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48I1nUQ5022916;
	Wed, 18 Sep 2024 01:50:52 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2048.outbound.protection.outlook.com [104.47.70.48])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 41n1f9bm0c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Sep 2024 01:50:51 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=grHeV8fgFQsSu6nqY1asPXyfR+b0DmPQOwKQ4EboLDIV8svUyQO8VxpFL3xq4NPWIxF5BAbv34T4Jk7xsq5jDseoUcQVHx/lUo0LI1VFZC1BSDpn/ZwifsbHQz8luwOLF3tEFP0zqmFlmLqJF5qZ11O1RXyA9wC9Ty7V+vQSoudIcB+dLehoCW7OU1f/6sjTnV4ZoHI1iDarzXNVQ4Lu6tx4rPJBJY77Fu3y2qyBt19AM0JeyXDpgaL4+xGaZUkj0mMUBr1hYRi6/eB+zLGsW14CUpj42Zx6NShTH8CsDAZ1baHIMPqjo/yN9v+MVFjdKH9B0k1Ztb2xxADC96xRKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1uK93ic6fVQH9NkgdM41V8q96L6ZwFnU3tgZ1CC6ES0=;
 b=sd3GW+Cxo4AUxHRjtVMjg5JgBNR6r26Xc0o+2xFv/At0dau7FKymOZG/ilNlhBaJl+sb5WA4M6SJ9VmOBr9MCZZJzvscP6gnQvxU/yJvjBE5Ok2Vhz7c18mXERX6HCu3CloY+rvmSW4rloVS/dD7ljnEDBCM1xkPZpzTz8TAkkM0yG8tEV3gKWmx+qGLWnmYI95le7bLl4mnV11cXW/qyzBnp1MsUSgdNXC0cmvROMAoXDCxaLsi0yeA5sPbdOCdcTOVnKHHb5+FfQSus1ECklRbLjGf1amHrZDZnDBDhHm8+4fdcgehoufLK2gGtLz0UFmQsdM0s+6xsY2+hheFWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SN6PR11MB2671.namprd11.prod.outlook.com (2603:10b6:805:60::18)
 by MW4PR11MB6620.namprd11.prod.outlook.com (2603:10b6:303:1ea::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.22; Wed, 18 Sep
 2024 01:50:48 +0000
Received: from SN6PR11MB2671.namprd11.prod.outlook.com
 ([fe80::3e06:cc6f:58bb:3326]) by SN6PR11MB2671.namprd11.prod.outlook.com
 ([fe80::3e06:cc6f:58bb:3326%5]) with mapi id 15.20.7982.012; Wed, 18 Sep 2024
 01:50:48 +0000
From: guocai.he.cn@windriver.com
To: tglx@linutronix.de
Cc: bp@alien8.de, henning.schild@siemens.com, jan.kiszka@siemens.com,
        linux-kernel@vger.kernel.org, linux@roeck-us.net, mingo@redhat.com,
        peterz@infradead.org, guocai.he.cn@windriver.com, x86@kernel.org,
        xenomai@xenomai.org
Subject: My branch is v5.2/standard/preempt-rt/intel-x86 and I make a patch according 
Date: Wed, 18 Sep 2024 09:50:23 +0800
Message-Id: <20240918015023.146637-1-guocai.he.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <943dc66e-0266-4f2c-8154-5a4510fdb843@windriver.com>
References: <943dc66e-0266-4f2c-8154-5a4510fdb843@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0235.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c7::13) To SN6PR11MB2671.namprd11.prod.outlook.com
 (2603:10b6:805:60::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR11MB2671:EE_|MW4PR11MB6620:EE_
X-MS-Office365-Filtering-Correlation-Id: 14b5a903-2cac-4585-c632-08dcd78450d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k2lK6iTvUQUUfcoLxLs26PNaJ9tFt7mNJo13dHU9Got2zt6X1dobQcGXLet5?=
 =?us-ascii?Q?eGyEHcqyvnH1sJ9f/OTt7uvMpVthYkPoU7kxqY5oI7sM66/LhvZzFEFSXG8t?=
 =?us-ascii?Q?Uivd04ys5lD0vq7WJmrKo59YrK4HHr5fC6Kln89aC/Of5T3YZIEjKIwYhTXD?=
 =?us-ascii?Q?VJx8fMekALWqWTJy3dpUx5Umwf95ZbNJXO0YKZ4nsFvMZpQx44+OI5Xg+3N7?=
 =?us-ascii?Q?V//yY180MifZinthEvDAqvY+tIIYFva8WbGkL5oARzwHdFJkYdFLNoPgBNoj?=
 =?us-ascii?Q?rEjUVCES8Z64VVG+vbRuQ2FrL2PkdlPYOtr0GqxTNe7bY1frQXojm0WmTPQw?=
 =?us-ascii?Q?a83Nu8PWLxORiTi4hVbmY3/4qofuFryL/8FDU89tCQX+UI8d2/jtlwAhl4Rw?=
 =?us-ascii?Q?ViUU/OubgBYB5yghp1d4zau5fudd5fyGjBR9QBltepuS9MgJx1bZVdtCKWcJ?=
 =?us-ascii?Q?O0iV+gIzvlO4NeRL+GSrnu+jrw5O/cFaHU2hymd88BJq1oGC7bQmPdF+xLlX?=
 =?us-ascii?Q?RUVRrYkh4zPsLodIQwjZqCVza3rICVFFOPScmChRV34HccJoPbDdQiCK20+D?=
 =?us-ascii?Q?EUhD51u2lIdg5zdzvjFqlveelZR/CtVLIqMlXftp7gBLAAUgBv/sGc0QRFtH?=
 =?us-ascii?Q?zrrKOg5wgaYvX3V4JQXosVn9v4hF3YOm/be/VxVBbJ9+5U/p/6j6mLTXvxn8?=
 =?us-ascii?Q?ecpcDr4ZpEuDDU7Fd4BZuKqdo9cyZfTBNDbQOO4QZiWoWOOQpMqyqAMefQxh?=
 =?us-ascii?Q?jGNpgz2pHQ7NA5q14H0YpH0T9FmehcEPYC+jsgGY0G61dIsG2iuSPYJzV/EA?=
 =?us-ascii?Q?4DgSxcM+TLlDneJxDkZFQDbU9Qkurr1GbuqTOG8I0XM54cVfMrXlbLkaeux2?=
 =?us-ascii?Q?p2FaCbnQq25wq3BwNan3t5U7mzjvuy4zcITfTL5SPCTjdCqp8aUh6+6EmGQ7?=
 =?us-ascii?Q?bsBsOEYCNyYo0JFTAdJfU34Wn1F0dOwtodcHmIcRV0lCJeWGonzxhHT9bDwq?=
 =?us-ascii?Q?viP2MkF9ei/jtDKUZfzzO0JmvpWb0w45F4+6XRG9luPcmJ+lMg8WsgZockxr?=
 =?us-ascii?Q?N+oday98i7u4ynL5ZjlqO+iIHWy7MGHd/9zZjmzXvOIzkPYDhjDWoG8iA/Jq?=
 =?us-ascii?Q?HiZfUm5w602WvcT7nqDdv+FJE9tptfSLrxXcZzuyZYicupKuvEkcpbU0O5Tc?=
 =?us-ascii?Q?kZ4QQHWL/aQ6Be9gDjBGvURJLqFk1EWzosAqL0CPHHTGH88AmCLtOmbK068v?=
 =?us-ascii?Q?VBjCN906WrzFWYrsf0rH7Act2hPAVZqxeT+Byc5W8J5yNB1hcdwA1Dd1T7eu?=
 =?us-ascii?Q?0WYBfbPB5LSUxYQNYDwFRTN8NWkJiaBy0ZqdGwZhjMmY8Bnb/uxSwmv9bEtB?=
 =?us-ascii?Q?9obBqi8fhs65H+eVTFd0WlLgAWyQE3c9r6q6Y1nvJlSlf/5JbQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2671.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hmW2nPJszjscQKiWldi+bjfBbLapB7bJbVilzCNi5rcY+ne27Sa21ttcSHQi?=
 =?us-ascii?Q?qGQoWw0fgK0ytYrhk6zxqWQwnlOZbB2Z5VT3U4t4F0EozmNR64EqUzXExC91?=
 =?us-ascii?Q?0P9Amh58B9lI23A4pUxSwM0MI4IOgIsjznl8JNTSBYoSJaKjKgyWufdWe1Uv?=
 =?us-ascii?Q?1CDK9Sl5TpDDLp3yMSximsFZxP3FyUUGX0njflBjtkyfmwku6LH5y41tIl6L?=
 =?us-ascii?Q?UGzmvbhHV4+G75PWpVH9N0QTPPJD+dwtgAUjfAcVbUOn0J0hCq56mcGkjbTa?=
 =?us-ascii?Q?1EN45Rez4whX+e70L43SmCU267F3xd9FeqLa7HHyRqWkilx643VWnVvMDrCL?=
 =?us-ascii?Q?rmN0ZxOmVX+nzoy4XRdHOUERY628CG1bfS2IhtKL0dbLar+hhcxZH02n8tbO?=
 =?us-ascii?Q?xSkFlheerxeYNHfVkMePzIvtV55eJfkxIIUcx8h4VwfnvGHnlppnNJYuTCK/?=
 =?us-ascii?Q?iAe0ZTJ2YOPmeJ1eYD1TP22y3/H60CvDiZXjD4OBi4Z97Sam9k8u5zGPRd+z?=
 =?us-ascii?Q?B+WH+jxrxWcMEG4DvSfOWFoV+WvmKy0ThDIngx8v5in1WVUPYEggS3evacHm?=
 =?us-ascii?Q?PbDfklxF2i9dvcx/5VGXvMde1PCo2GXXqxz5X9AAMBAgHX9xp4Wrz41XwaKI?=
 =?us-ascii?Q?gnnTvLaBE6FDKuwm6emJqgh0d4O1mv8sr8kOSrRjZfGX9ekXEHivDV5GAaaF?=
 =?us-ascii?Q?TbHAPPMSz5beYVY1JeO1O6FQwQhl+7EEaH/cPqFz7ePLm7WtkwJxqKVF657Y?=
 =?us-ascii?Q?dBOZ5AT/vZU6f49ejFx+sqTH4oyDl389A07dLp5WahLMFv3EBa7JL/2LZr/k?=
 =?us-ascii?Q?kXDqVUs45ZVBW+uEROBQLo6MJVic5fGpw6WYsnh/sGMueccCjWPO9ILqHYQ6?=
 =?us-ascii?Q?Rhhs3Iks8gvZBQCpM2aGDfw5V74OzNnVO9ztVUC4ruinpUoPhu448WHkV1Uo?=
 =?us-ascii?Q?iznfzt+wnI51j/4xZHT4Nks0f/PmCDF/6Huz1klSHPoGNs26uwmmpy6HSdqm?=
 =?us-ascii?Q?6i8U+EkzLfEHPWQj0zb/CrdruBvwD4ZxDhtmuy9yJMjbAD4528FHyAGqpkpd?=
 =?us-ascii?Q?6q9sszx0S29kxpqXw1UzbtxYh34fR7AQeLevGf0UER8o4yoWoJ4P7aywoln9?=
 =?us-ascii?Q?5q5WpFbuEgv8dK5KQ3HBK6jCnyiHRPOR/lmRdKvBw7+F3MWFPuFHXWlLzsyw?=
 =?us-ascii?Q?3qozFSpY8dI33tjCYvsOdpkS6egxWo+IF/r1WwdIpGktV/M8iBws1DayuKmJ?=
 =?us-ascii?Q?JoXlnl4MFF7mYKOmDwrAaJ8LFvqqPKR+p+UCm8bGg1i/zA9A6dbKLuy9/50W?=
 =?us-ascii?Q?0oVsPsrSFUle677fvaYyL2pBAlJAvv5RdgBn9gGVt/tI+rbtI/Eazo01IG7m?=
 =?us-ascii?Q?49yKsJoRW+hLNv2DohbzbNID5pFOC7/KiBSax/1fV36kmo55y8n6HWE/CZqi?=
 =?us-ascii?Q?9POUFBDJsq9u3KHRwunttg9uZBsnu+oXl2mgteqxrM0PdTdEn+X0cCITGL3g?=
 =?us-ascii?Q?N+QY1XTMgx3vnezPuadwmJGnailyDCFFLewjAG80nUHA8HchfDvvqjcJywdC?=
 =?us-ascii?Q?h/fImb7lEODscM80KHr0EFordOi8WLmXLzu0WjUf/Xu3yor/2+nQe8z+H7tQ?=
 =?us-ascii?Q?Cw=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14b5a903-2cac-4585-c632-08dcd78450d3
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2671.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 01:50:47.9777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wtI1Sr7KMg9mOIQVfNQK3Tg7dED2X/oiyZbo0bleW2p7YJ/ysprwMfNaKqlQ1dDGsvxjDvPh3QVpJpsDnhyze6vvx8H8PkezKbq3RIor6uY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6620
X-Proofpoint-ORIG-GUID: UV15wTU-O-sSs0GO69PuuJe_IiQnYUhH
X-Authority-Analysis: v=2.4 cv=afUzngot c=1 sm=1 tr=0 ts=66ea31fb cx=c_pps a=PK5aExQQjalka8oDlC/sVA==:117 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=As1ITySPTL8A:10 a=EaEq8P2WXUwA:10 a=bRTqI5nwn0kA:10 a=t7CeM3EgAAAA:8 a=9LNUUUmxV8S52ES7YG0A:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: UV15wTU-O-sSs0GO69PuuJe_IiQnYUhH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-17_14,2024-09-16_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 mlxscore=0 clxscore=1011
 lowpriorityscore=0 spamscore=0 mlxlogscore=545 suspectscore=0
 impostorscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2408220000 definitions=main-2409180009


From cbf1606332c48b32c4bb8d61ac6911e3064e79fc Mon Sep 17 00:00:00 2001
From: Guocai He <guocai.he.cn@windriver.com>
Date: Wed, 4 Sep 2024 04:45:26 +0000
Subject: [PATCH] patch for poweroff

---
 arch/x86/include/asm/processor.h |  2 +-
 arch/x86/kernel/process.c        | 14 +++++++++++++-
 arch/x86/kernel/reboot.c         |  2 +-
 arch/x86/kernel/smp.c            |  9 ++++++---
 4 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 5f4e79d14613..4c1cf610807a 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -975,7 +975,7 @@ bool xen_set_default_idle(void);
 #define xen_set_default_idle 0
 #endif
 
-void stop_this_cpu(void *dummy);
+void stop_this_cpu(bool sync);
 void df_debug(struct pt_regs *regs, long error_code);
 void microcode_check(void);
 
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 2243af6530f8..35d5cf73716e 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -590,9 +590,21 @@ bool xen_set_default_idle(void)
 }
 #endif
 
-void stop_this_cpu(void *dummy)
+atomic_t cpus_stop_in_ipi;
+void stop_this_cpu(bool sync)
 {
 	local_irq_disable();
+
+    /*
+     * Account this cpu and loop until the other cpus reached this
+     * point. If they don't react, the control cpu will raise an NMI.
+     */
+    if(sync) {
+             atomic_dec(&cpus_stop_in_ipi);
+             while (atomic_read(&cpus_stop_in_ipi))
+                   cpu_relax();
+    }
+
 	/*
 	 * Remove this CPU:
 	 */
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 3f677832fc12..389643727e37 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -742,7 +742,7 @@ static void native_machine_halt(void)
 
 	tboot_shutdown(TB_SHUTDOWN_HALT);
 
-	stop_this_cpu(NULL);
+	stop_this_cpu(false);
 }
 
 static void native_machine_power_off(void)
diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c
index f2a749586252..9dee65b96115 100644
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -112,6 +112,7 @@
  *	about nothing of note with C stepping upwards.
  */
 
+extern atomic_t cpus_stop_in_ipi;
 static atomic_t stopping_cpu = ATOMIC_INIT(-1);
 static bool smp_no_nmi_ipi = false;
 
@@ -162,7 +163,7 @@ static int smp_stop_nmi_callback(unsigned int val, struct pt_regs *regs)
 		return NMI_HANDLED;
 
 	cpu_emergency_vmxoff();
-	stop_this_cpu(NULL);
+	stop_this_cpu(false);
 
 	return NMI_HANDLED;
 }
@@ -175,7 +176,7 @@ asmlinkage __visible void smp_reboot_interrupt(void)
 {
 	ipi_entering_ack_irq();
 	cpu_emergency_vmxoff();
-	stop_this_cpu(NULL);
+	stop_this_cpu(true);
 	irq_exit();
 }
 
@@ -192,7 +193,8 @@ static void native_stop_other_cpus(int wait)
 
 	if (reboot_force)
 		return;
-
+    
+    atomic_set(&cpus_stop_in_ipi, num_online_cpus() - 1);
 	/*
 	 * Use an own vector here because smp_call_function
 	 * does lots of things not suitable in a panic situation.
@@ -256,6 +258,7 @@ static void native_stop_other_cpus(int wait)
 	local_irq_save(flags);
 	disable_local_APIC();
 	mcheck_cpu_clear(this_cpu_ptr(&cpu_info));
+    atomic_set(&cpus_stop_in_ipi, 0);
 	local_irq_restore(flags);
 }
 
-- 
2.25.1


