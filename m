Return-Path: <linux-kernel+bounces-204283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B218FE6AE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 14:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FFF8B24ADE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 12:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0778195991;
	Thu,  6 Jun 2024 12:39:37 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C2013B28A
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 12:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717677577; cv=fail; b=IjfSPMbU695xrtaMC3ScK00SQP4hWEa2tZoKFN/yoTTVzmOOskAfO98Pdxcn1QeYBl/CM9T41MMO7cKN6wYohn7G/1bIUWCPUS/G1xhq43mybSfk0n8MUcRtJx5q/pLTdeQoEWrpDgiMhHqUFx8hQQwVnR+XnT+fTKYXgwlY2js=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717677577; c=relaxed/simple;
	bh=q/CYn8jtoTmT6OX0PJ/k0uZUn3d6l+RsnN3U16+pveo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=C4u29R5Pbf7P1uxeDXiZAnBO0wKXG9+4EZAdMCLIVfm3TvM4sPJcxbm61Zm0ltTbme5k5EpILWlUpKS55llaHKa2HEVHbeUqo5Dp0ebe+tH1rBNjYL9uhkL88RSh3dtpSri+UJJR75tC+ljsCSgp15jtMmofBqvupA9ksah5dL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4563mMka021165;
	Thu, 6 Jun 2024 12:39:27 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2045.outbound.protection.outlook.com [104.47.70.45])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3yfruxd8ux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Jun 2024 12:39:27 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XsfnGSHWdG9CUF9n8MPcizih7bYsr6KAMbXkdszHULH26w3hlrnNpDoSlqVst4gDBPZpkGLDSfWUf6Flgyy1+ZMWWINDOjB+OUSPyhpJxOPDcwIkgdRf/AWyGQ30LbH3XWBfgEpL/Me95NIx7D66rY/me7fCSeJztsp7XWo3JMY8Aw4UfC3jsKAD0wheKZkZsO7mpaaQ78KDgJh6QW1bbvtQ0bGXbUYbOJS9eQ4hjYlGP/IixUPjMFdkZ5/j90NWVWsmpaNKSrtH+iv4z4tWviIyHp1ACHJX6ZSAdLQPNK0vJHbOzlO5kqAwx7d4Ri3qH58M/IRKYFquINdWUrOTBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sCdeKmv1OqCIjbA3GqAcpgZ0v/n8j8GWEev3otKZd44=;
 b=A5ys4CCOD1ErU0nubUuAR11egJjoUHZD6Gk/QpI+lE9ZAnVlgHb/sfeKBTGQcDxhQdADgXDFpZzDxXgCYzHjpkk9d+b8Wd1+ldVKysK0bmn+HfQhghZx20EcFrMPcQ1l3pHHwO+zsXsH7pwOVGcS4llclQDY0jF1v3pDFfgvgfl45Bf30njLtvdGStCiQB3atxPoRfXJxklTLAB8+QNMqq9P7ylaLnZapnQfo7kov348k39xWJbq5t1L/SdCMwtUvl0HtrtkQtdg7b4IRLTr9f6KW71N5gx+eakBA0fy6bLfSPdq0fk58GwJmT4rX2Cs9eMPhvtDlpr2GaaLlomV5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SA3PR11MB7527.namprd11.prod.outlook.com (2603:10b6:806:314::20)
 by CY8PR11MB7393.namprd11.prod.outlook.com (2603:10b6:930:84::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.32; Thu, 6 Jun
 2024 12:39:24 +0000
Received: from SA3PR11MB7527.namprd11.prod.outlook.com
 ([fe80::3133:62e0:c57c:e538]) by SA3PR11MB7527.namprd11.prod.outlook.com
 ([fe80::3133:62e0:c57c:e538%7]) with mapi id 15.20.7633.021; Thu, 6 Jun 2024
 12:39:24 +0000
From: He Zhe <zhe.he@windriver.com>
To: clemens@ladisch.de, arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc: zhe.he@windriver.com
Subject: [PATCH v3] hpet: Support 32-bit userspace
Date: Thu,  6 Jun 2024 20:39:08 +0800
Message-Id: <20240606123908.738733-1-zhe.he@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::17) To SA3PR11MB7527.namprd11.prod.outlook.com
 (2603:10b6:806:314::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB7527:EE_|CY8PR11MB7393:EE_
X-MS-Office365-Filtering-Correlation-Id: 7be2082f-9caa-4187-f6a8-08dc8625b266
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230031|366007|52116005|1800799015|376005|38350700005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?dP1uX0Jqi0xFR/J66hHyCyvdwePS/DaY0c+BIZLfzsTPaQXcLICBljP8LXUs?=
 =?us-ascii?Q?oDM4LpCOAsYEwTp176//8RILt147v+HEG7GL17Lsz1SnlrDHz0Mfq4qJ8p3V?=
 =?us-ascii?Q?Alol97QtD2asLc1F9ZFnPTnAzk24c0AiCUWFGhxlTPJnzvkX5/AoiiUE8RSJ?=
 =?us-ascii?Q?GaIhTYPvdbGDJE+kkjbABS4Xw3p2nctvjGWQ/YKBC3w8rnLZQqWOSJa83/4Z?=
 =?us-ascii?Q?A7MvXchi1ELYQJCop66Ke6AjZBXr1OUSXqMBh3QWdjUCgSVRg1LVVgbPHMji?=
 =?us-ascii?Q?sgyhf1/rTEuOfqqBSjwP0eb7PSX4JOxuSGs/IVt4L2NNQUFMl5XeZOhCCkR1?=
 =?us-ascii?Q?/DJbHwr4VCSp3h9ddiOV9Xi7fpPdlkMKHY8j6wcDIcuOVHZdSLCj4njVyc8u?=
 =?us-ascii?Q?IPprsFkQCobu9LM3ZuopJmN16vakvGyNuM9Uddbm2OqTl4PFZrQ63XqqlsCj?=
 =?us-ascii?Q?gAogoCDnQTL9AYDhG/PUVMKGOTb2031U4xtzUKsk3D1WjMROUkhfCnhUxSpd?=
 =?us-ascii?Q?gw4SqTZJYXyDfTATMcYP5hr79cWbR2YdbO5POCeJOJjSgKOqoBGTi5m0v3XT?=
 =?us-ascii?Q?vsU9uHDe643/P1A5sHsa8rlEPI6y4qpH/ZQlSSQ+hHAVG3fR4zHlEXYIidaR?=
 =?us-ascii?Q?2DdnJCtqmbt66PD+21ox+6G/fhjn1zJ7aIF1h5ayU3B68HmHuTZThq6rlCnQ?=
 =?us-ascii?Q?B6WFZEbqyRneC0Ljw/xJlvnosCFHM+ZG9cUAMqwW1vikESI8oVkz4eJG5xrl?=
 =?us-ascii?Q?zpFJJFOy9iNgC2H1psxF4amh2osn307P3W2zUIAVbiGUxjuIxZGGbq3VraAd?=
 =?us-ascii?Q?dXn6bVfHdOOtsVC7H9Qo+ZWqO5HYg0FPLJ2xNZw2Q3v4QZ+ac6IVytaXrRq5?=
 =?us-ascii?Q?b6skEhzO5Y+oUkHPruDw6+m2Enp4p+5lOb27CPpI45S32Hr6NZRRa+Ac6kIc?=
 =?us-ascii?Q?dNFNA421DOExzbg7rdVT+kjcUWxr7Tn68d0XvwdwgfXdwS8NqeVCy/vZ+RUd?=
 =?us-ascii?Q?Q2TXfdPwkFux1k3s0dM8wfPlb9HMazxzZJS2cV+FdmF2irQGCL60jOYD+xlW?=
 =?us-ascii?Q?GNjMT4pSAXM8aEqO18rqGVkPGioyQHoYdbWMXtj2sL60QEekp6PSOhS1TOLd?=
 =?us-ascii?Q?1+3oZQhCtdvjQfHZdYHHUSkfRevU/JYLBXmlmERPiIMGrfLq4pKrICMp5F5D?=
 =?us-ascii?Q?P2vbiPK8/5j9WN51Oj9pq4B3OPUP2oeGNt3PimLvVc9MnPLrVpSKn0JiDb24?=
 =?us-ascii?Q?g6BIPY7YI9whYDDTxiokiGXfdz8zrMmfYTGtyFdx9WjcNOScVlD7WFqmIMXc?=
 =?us-ascii?Q?30MNwNsa2+r6bPFDlNS//VINrkSnJjPcsOCfFjvIw+2Ovdr4s7KyLan+nab0?=
 =?us-ascii?Q?PrvqE0M=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB7527.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(52116005)(1800799015)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ciZOmxRALYJUaYJfpiA4mBWtvZdbano4KrVLLIRQve+uQFPqkjFD3mm0JqrU?=
 =?us-ascii?Q?Lqbi92HEDS8JT+UYi75pPzAzF2fxUJrymgofERZDhOTHwPXXpCfN0kuutChY?=
 =?us-ascii?Q?ZVrNRmT1P5b2GkZWjL+2CEa13ZeaoB+ThRFTVkqTG5tvqex+Y7RmryNSBEEj?=
 =?us-ascii?Q?/oh7iEQ1ecVEW2Yw+FIVFVqUbfKd233G30E3/NgF70I0WqPTC6GBDKnAqtdn?=
 =?us-ascii?Q?VPrQ4FXsuUGn7h2nvrcCq5HnNv3hV6nVi5AXpA0Q+iTutOuhHrnkfznnMXq4?=
 =?us-ascii?Q?ILiFxJfdTQItSUccw+5Sx3ebvlY/2J2/sds4qmzfEUVCBf+PaD0kkevu4+UF?=
 =?us-ascii?Q?rM+pO3Z3U5lSuk5qbR0gTsROk9FOSZksJ6HR37/U4qL17c1R5DBWyw+tYXR+?=
 =?us-ascii?Q?q8fDjbNx5f8cnn/AJEKbSVuPk5Mo7jvJ7m9E7zfN5IoGK/KMZDJ/ccpEMF3B?=
 =?us-ascii?Q?SNp5ZrwSZ8/QIAxfbEnI5zdW1GMRTk+TPOjIC4pX1bgRQDxtKIiGbU2I/YDo?=
 =?us-ascii?Q?kO2YO8gMJ4svCxdArC7tc5j9lmAIxqKj5FxkYhAWgDKv9dPctUy3V/LABlke?=
 =?us-ascii?Q?ieEULsuUXZxuMLUA4grIPbEqEoU19xG/2z7UVG9TX4SNnQ3TzuihMl9jVwXL?=
 =?us-ascii?Q?qi/8Wh/Wty2jFxiwi1TZABvTDoQ8+RdSqr7iYEgeNtIribe3l4NMdNoyr/Uz?=
 =?us-ascii?Q?rVLs/bvHK9eefgglQnN54u/TvpaFjWWj4TpKd1lcLMIw4Kh8KGdhdi7xABYF?=
 =?us-ascii?Q?j6fLiRlOA29XtiJlgJvXxqxqBTwZ5k5QadcuwSDZz3uDo6QQkJjd6lQpoCDq?=
 =?us-ascii?Q?zsmDJAhaZo1Kp4f7Z+TTSTCoFL2OPglbTYOgXR+bThm2oZuSNuuhSWA2Uv6o?=
 =?us-ascii?Q?g23AsHuWc98Hxndy2NxSMM6SWmpNIYwflJwtsvUEZW5WsMx6s7LAEBToqjg9?=
 =?us-ascii?Q?xkxOmMrmeCisIpTkujEeqqKRw4zXvdIPritk/oAFoSqbqxprsoRnPFYU48/g?=
 =?us-ascii?Q?XyqLrDZYpZDz6h9KaCtORYRsyvG5r9MVhqr2Y+MZJA9nAFrwsvTkrak+0tEo?=
 =?us-ascii?Q?AJuOlTE6WEN1eqxiyJprKwcfn/FFbfsD0ISx/pguvmKY7be32A+m//jQCEei?=
 =?us-ascii?Q?Y1Tw9dA5UOR5gHYKBbk+vbN84lP3PB8cBAzXzSnN1vXu8cDeaVdX5auZXGp/?=
 =?us-ascii?Q?QbzOEe8KjqN5OZ/80vaJwJRNpclCXI1apnGIgBIPHIhheJDLNT2tqJVRj3jB?=
 =?us-ascii?Q?A0N+qmRN8GwSe94GkDw4UaDO7t87yeGHkC/+KeJ1dX6AQBrcpkCsXTjd8X3C?=
 =?us-ascii?Q?YdEXiOd7ViT/JdIa2MV+4lseXSZA8pUduKeYpN2jbvJfQ0fqZ7vmiTqIv5KO?=
 =?us-ascii?Q?ZUyXpnfAnkmkW7fSCHkyaF/p0l/KAb0CU6mlAy1S3EMaLMU4WdkfGoLbel0h?=
 =?us-ascii?Q?/miwZx06VlxE3N2LwIGpbNzlqnejZxCzhm9ZrQbfiVadm25GhxYBhpA998+Q?=
 =?us-ascii?Q?A/s5N5T/98PXCZOi+PFfwBuNOxJVYANcU7JTv8HMJt6Od+HAxbIK4AMMRqvb?=
 =?us-ascii?Q?AMVhFeYgIK+8YBOUpW+qsp036BWgkWlh/Xlz7U/a?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7be2082f-9caa-4187-f6a8-08dc8625b266
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB7527.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 12:39:24.6329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g6VJ/IrV+dGcSWh3L9yF79HveaC4uCcRGBsfylquyHLXKBLpXky7Wqi8+J0L8TZamuhKEReVvXVPwx6pLHnqxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7393
X-Proofpoint-ORIG-GUID: uiNV1t4ANwD2UOmPWStSZNIOC6_YZn5_
X-Proofpoint-GUID: uiNV1t4ANwD2UOmPWStSZNIOC6_YZn5_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_01,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 spamscore=0 mlxscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2405170001 definitions=main-2406060092

hpet_compat_ioctl and read file operations failed to handle parameters from
32-bit userspace and thus samples/timers/hpet_example.c fails as below.

root@intel-x86-64:~# ./hpet_example-32.out poll /dev/hpet 1 2
-hpet: executing poll
hpet_poll: HPET_IRQFREQ failed

This patch fixes cmd and arg handling in hpet_compat_ioctl and adds compat
handling for 32-bit userspace in hpet_read.

hpet_example now shows that it works for both 64-bit and 32-bit.

root@intel-x86-64:~# ./hpet_example-32.out poll /dev/hpet 1 2
-hpet: executing poll
hpet_poll: info.hi_flags 0x0
hpet_poll: expired time = 0xf4298
hpet_poll: revents = 0x1
hpet_poll: data 0x1
hpet_poll: expired time = 0xf4235
hpet_poll: revents = 0x1
hpet_poll: data 0x1
root@intel-x86-64:~# ./hpet_example-64.out poll /dev/hpet 1 2
-hpet: executing poll
hpet_poll: info.hi_flags 0x0
hpet_poll: expired time = 0xf42a1
hpet_poll: revents = 0x1
hpet_poll: data 0x1
hpet_poll: expired time = 0xf4232
hpet_poll: revents = 0x1
hpet_poll: data 0x1

Cc: stable@vger.kernel.org
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
v3:
- Remove unnecessary CONFIG_COMPATs
v2:
- Use in_compat_syscall to determine if we're handling 32-bit or 64-bit
- Drop unnecessary compat_ptr for hpet_ioctl_common
- Add comment for COMPAT_HPET_INFO and COMPAT_HPET_IRQFREQ

Signed-off-by: He Zhe <zhe.he@windriver.com>
---
 drivers/char/hpet.c | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/drivers/char/hpet.c b/drivers/char/hpet.c
index d51fc8321d41..da32e8ed0830 100644
--- a/drivers/char/hpet.c
+++ b/drivers/char/hpet.c
@@ -269,8 +269,13 @@ hpet_read(struct file *file, char __user *buf, size_t count, loff_t * ppos)
 	if (!devp->hd_ireqfreq)
 		return -EIO;
 
-	if (count < sizeof(unsigned long))
-		return -EINVAL;
+	if (in_compat_syscall()) {
+		if (count < sizeof(compat_ulong_t))
+			return -EINVAL;
+	} else {
+		if (count < sizeof(unsigned long))
+			return -EINVAL;
+	}
 
 	add_wait_queue(&devp->hd_waitqueue, &wait);
 
@@ -294,9 +299,16 @@ hpet_read(struct file *file, char __user *buf, size_t count, loff_t * ppos)
 		schedule();
 	}
 
-	retval = put_user(data, (unsigned long __user *)buf);
-	if (!retval)
-		retval = sizeof(unsigned long);
+	if (in_compat_syscall()) {
+		retval = put_user(data, (compat_ulong_t __user *)buf);
+		if (!retval)
+			retval = sizeof(compat_ulong_t);
+	} else {
+		retval = put_user(data, (unsigned long __user *)buf);
+		if (!retval)
+			retval = sizeof(unsigned long);
+	}
+
 out:
 	__set_current_state(TASK_RUNNING);
 	remove_wait_queue(&devp->hd_waitqueue, &wait);
@@ -651,12 +663,24 @@ struct compat_hpet_info {
 	unsigned short hi_timer;
 };
 
+/* 32-bit types would lead to different command codes which should be
+ * translated into 64-bit ones before passed to hpet_ioctl_common
+ */
+#define COMPAT_HPET_INFO       _IOR('h', 0x03, struct compat_hpet_info)
+#define COMPAT_HPET_IRQFREQ    _IOW('h', 0x6, compat_ulong_t)
+
 static long
 hpet_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	struct hpet_info info;
 	int err;
 
+	if (cmd == COMPAT_HPET_INFO)
+		cmd = HPET_INFO;
+
+	if (cmd == COMPAT_HPET_IRQFREQ)
+		cmd = HPET_IRQFREQ;
+
 	mutex_lock(&hpet_mutex);
 	err = hpet_ioctl_common(file->private_data, cmd, arg, &info);
 	mutex_unlock(&hpet_mutex);
-- 
2.25.1


