Return-Path: <linux-kernel+bounces-286606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 819C5951D0F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB6C2B2A8C6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 14:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FAE21B373D;
	Wed, 14 Aug 2024 14:25:10 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02olkn2091.outbound.protection.outlook.com [40.92.48.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E341581E5;
	Wed, 14 Aug 2024 14:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.48.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723645510; cv=fail; b=CzNYyNljHYPD8oQtQiKLprPbbpPhHBsGCy4bFlTH0ycq76gkOZccd6tiUVn/3sjJtmvnDCYju2bi5qFV2KI9ClWizlWbDJ63BH4WUotMaPLzp0a0DbS0SE4uYOW7GQbl7ekxSW52aKa1hreeG8jFO744HZ9/90FlM6WSGbJN4nU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723645510; c=relaxed/simple;
	bh=qXKH1J+wbimp1PoQQnr7oRlt1vCV1F5dVparJR+ES1c=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=CoE7uIchXvlgo8nUy4Am0Bbxu5kggwHTxpA/B0REbuW9mw5GPCG+6+4/q/JqXBZ+iw3AsPnP5FCKfgYeEQZpTqPQjiLBg/hzu7KQ7O7y7UUzaO9r9PHe32+wExZjIZbTdGWjU9F87qsB05ldEk0Z355kYg4QiAQCJHuY/nxd7ZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=outlook.de; spf=pass smtp.mailfrom=outlook.de; arc=fail smtp.client-ip=40.92.48.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=outlook.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tG8n7+1wTcbci67MnH196E8wwJdtlDEnC6vRiuCQZWo678B/4jN831gGxAWvSzP6Fs8miupQrtBacUT31lFRdv7mctcTT9+V+lM6zfcn15rcQX0BcbCuAgJqmpR3Ng411cdWusN+z+X9qXNTieNX8jKlWrJIIYg8arnUy+gmaBJ8UwWCinQT4lqDNcYVd1ZiI4UIXbNnPq8S98IYD1a2XtlNeHK+FsU3PfhSo5jL+eHOr4lkPz+TPEUJhTsjhgPiNbioUJzwfcD+jotWxIY6F6gQvZSTB0xUaa58NCSLg+MLnRaq2l1yvyR7I6K/wRYQCDoh+10SGaiDYw+vbeusIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BFBS/mABT1DRMCsdeHG0M7ugcoC1h+litKjBiYGvrM4=;
 b=RxCcfTHR3TVkdvFto6JLBIyb9IKd/MgTZvLrHL1rr04wuYiURQ6hjgAxaKMqKagQ4ae4hV5YAT4zSC3vgAOuO8MFHMhe9wMHSLhgWrFZJbxSCx4XYXr4WEFJsJB1o6yDYCx2USTS/zwAHIFLsCc0EYNwRYwL3pLQBE6mRHccAgeaBovCrgq6D+ButMnE9n4JyPLYIC8u0VMPw+nEUSZ4i1JnU6opzP0J27ylR7cupcRZWNQWGR4R4ZzU+DXiM4ap3bKfEY7S0b9uIoI3+L1lFl2btGQ7TUlCj2akD6HWzdoA0ODmcpUsoMgCe0bTlKixJm5HFohccIz7x2lYoGqc6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from FRZP193MB2563.EURP193.PROD.OUTLOOK.COM (2603:10a6:d10:13e::9)
 by AM9P193MB0789.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:1f3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.25; Wed, 14 Aug
 2024 14:25:05 +0000
Received: from FRZP193MB2563.EURP193.PROD.OUTLOOK.COM
 ([fe80::a343:f6c0:6978:71f6]) by FRZP193MB2563.EURP193.PROD.OUTLOOK.COM
 ([fe80::a343:f6c0:6978:71f6%3]) with mapi id 15.20.7849.021; Wed, 14 Aug 2024
 14:25:05 +0000
From: Enno Onneken <ennoonneken@outlook.de>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Enno Onneken <ennoonneken@outlook.de>
Subject: [PATCH] reboot: add missing break to switch statement for LINUX_REBOOT_CMD_HALT
Date: Wed, 14 Aug 2024 16:24:45 +0200
Message-ID:
 <FRZP193MB2563F43FFC350926C0B7EEB1DC872@FRZP193MB2563.EURP193.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [ydm0tTHCC389I52XJ3GSpUj61bTAyYuOX1jmq6HT8Nhzrs/yf++9PNHDeA+6hd6W]
X-ClientProxiedBy: AM0PR10CA0084.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::37) To FRZP193MB2563.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:d10:13e::9)
X-Microsoft-Original-Message-ID:
 <20240814142445.7805-1-ennoonneken@outlook.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FRZP193MB2563:EE_|AM9P193MB0789:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ccfbef4-5fec-447f-a4d4-08dcbc6ce42a
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|5072599009|19110799003|8060799006|15080799003|440099028|3412199025|3430499032|3420499032|1710799026;
X-Microsoft-Antispam-Message-Info:
	w2i5MfTp7/75lUNZdOIujVlx2TKFboo0brFtl0IBeM5zO4h2drPE1of577iytLnfcN5SDg/t4xCmwehea0z8qeiBWFgOqlGvbNL69N1LcZjQU8DBLKGQIrKYVOEOeAHes5SVDjdldgvVJT0JrwX+JrGT2tH9M9mcuX1POKYOVLP1K0m570rQ62e/eS5iipSJbvJ8xbAlxIi9AdJkZ+qJBukujTqEXExxL5t15HeOWokfjchyWTrgTspN8/WjOIkeq05CjRkh7mgqHmY80OUGW+TD1S8ad6jjI5hlbxzZ6ZCdBYlocw5EN+OtOuvbJb4UN+2C2IHX4YkcWG/ivN3jwRxlQcY4Y8XcOOmIQkoeq5XaKZ/AbWdvGsDGsEglZ/xEuouC7BfIYWhHrdcGOAat/dE0GGkrSnvk+31C6FulU0i3JRQzAV61B5l/nUMXHaNuN2m0nuq+f6hUI8NN0MSsCGQVAJ7K6AlPk5a5z18z5KW6qWmKAdHYijlDm1JM1hzxwAVSwRZbvXF11ICbwV2J9By9ln43b/IFGB4uPwPwKNgzf3riW/YCfC69y3mmDQejnv2Yau1IAbyFdzPyQvjuGjvRMsqO5hu+/HBq2qO23bmaIT1JmtgWazkpHqwD9SqS2x0tcTCCPSA5XPrirBEv1jKugmDlhkEb07RGBB3UFDcAh+wnZA5+Fxg116Mq92PqfSF16CjTAP+gC2TkUHAZBRUhDoiNS36p0VgRNlPGC1E=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5TEU5Ujk7bTDlOezkgQ3HlXe0Bd/x3hHeIyvCi1NDjSnf0dzlPIXWSs0/qtp?=
 =?us-ascii?Q?+L5qh1LTnWV3+HARSBbpptAgQTHaUGJ6usSj9iEfsbFNaM6/w5/OzlyC3J9C?=
 =?us-ascii?Q?r9PkC9/DwK4yLXWtUifsN6Klut/wJBgNl1uFGwvpiRkmtueRpGI88F37ORbT?=
 =?us-ascii?Q?5jgujK3e+dxKuhOcRtbK/3ATsSKthApA7//bFXuCNziBz3WZrhUPWmv1DopD?=
 =?us-ascii?Q?lFeE0ZJ34+RDB2URq5doRCcGgzpE90FDM1wlvIiWiNoBXmom8Z/DjWTcjmfM?=
 =?us-ascii?Q?mT2BOtAGF/E6G3aKfOTkINNMu6knZa1xYxFJrRth0EqjwMlCbyguYCO5tmRW?=
 =?us-ascii?Q?vqXkJt7Uyj9QQXsBIJIl3u3a992eyxla8igS5XytfMx9goQviX7hsOsSXgHr?=
 =?us-ascii?Q?mBIFnS9gd+OW8sKmEpOoCC0ukB1wofkwpfsrkQeOQeE2Cn8iBXId7BQPTOjU?=
 =?us-ascii?Q?WK23j2mnUrHLfouuWLdI7MLEgHiuNlQHyLHhh6Pcuhx2MXvbxZB+PmwxFNc5?=
 =?us-ascii?Q?3xPIK1nfkf4kXmkKFC8XYer5aSsr0qq162P1jKwklAQu5RXUeFDGyuiKkZ/q?=
 =?us-ascii?Q?OtrI+VRnmJm+FVb6CZnoSusbgqd2/8YHNZ1hREzZo+j+r+e0W/tBhMPAzcq+?=
 =?us-ascii?Q?Zk70mR8RiJg/yDJpp8RB60SnitHkFF+Hp0LobPfErDQN2qIKiZeiXC1tzmUZ?=
 =?us-ascii?Q?c0SyaXaQ/i+UmwKx8SrFipXrNNas7gUQWT+FjctEf3yHmxPvj/eE+ulKhf94?=
 =?us-ascii?Q?xu1pENn844DSAC7gPgB183U3avJ/GS45+Y/0VAPYTL1Sc+Nlli5RqtZC7iYG?=
 =?us-ascii?Q?2cDQrRJhDOS/vI8ovy4mg4Jjb2ye/+4c16dX0dOXFFWfFE7NCSIH3NhmZkxo?=
 =?us-ascii?Q?SwO+qnP0w+bZFpFDgJB6h9Thoi070+dp5aNoPDTmuKw86R8Pu6CI64PTXw7B?=
 =?us-ascii?Q?BnImvETzfE8YuiWFuQFCWM0tmQisVYKw7i9/1O1nXL1+wnXqOdfo2QoJOrn5?=
 =?us-ascii?Q?c6r0/2hVqUVdzafVAKsXnI2LznCFUq81M1jkA3P2kQ1AF4ZKGHBp+3GiQh7z?=
 =?us-ascii?Q?FhTcNylu9tXBg5/LBQAeRceUEP1IFZePmrC+jFKuaOfxIftGSH2gVqXVnUJo?=
 =?us-ascii?Q?PkaydUe/Sf/z8xSILagHwAc0SHRnbDeF+zNVqc5h63vJpmPGREx57spXn7aC?=
 =?us-ascii?Q?5DqtkfHCdfNuxQAip9F1GArNmXQpfKsNiEhVxGPTtUNAr7hZfhjgrRGH2D90?=
 =?us-ascii?Q?fLgU9t1TAUtasAIRIayLzZ/B0x3JKCUwGkv/8x57KW7hVZNDD9Syv585bmPk?=
 =?us-ascii?Q?kKU=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-80ceb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ccfbef4-5fec-447f-a4d4-08dcbc6ce42a
X-MS-Exchange-CrossTenant-AuthSource: FRZP193MB2563.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 14:25:05.4005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P193MB0789

All switch-cases should be isolated from each other due to shutting
down/rebooting the kernel in different ways.
In order to fully isolate this case (like all the others are), this patch
adds a "break;" after do_exit(0); .

Fixes: 15d94b82565e ("reboot: move shutdown/reboot related functions to kernel/reboot.c")
Signed-off-by: Enno Onneken <ennoonneken@outlook.de>
---
 kernel/reboot.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/reboot.c b/kernel/reboot.c
index f05dbde2c93f..05dc02748c06 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -765,6 +765,7 @@ SYSCALL_DEFINE4(reboot, int, magic1, int, magic2, unsigned int, cmd,
 	case LINUX_REBOOT_CMD_HALT:
 		kernel_halt();
 		do_exit(0);
+		break;
 
 	case LINUX_REBOOT_CMD_POWER_OFF:
 		kernel_power_off();
-- 
2.34.1


