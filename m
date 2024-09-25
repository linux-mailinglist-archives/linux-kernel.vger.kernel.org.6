Return-Path: <linux-kernel+bounces-338365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 181C29856EA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 12:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BAD11C21342
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 10:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDCBB15C131;
	Wed, 25 Sep 2024 10:08:07 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2098.outbound.protection.partner.outlook.cn [139.219.146.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACE514AD19;
	Wed, 25 Sep 2024 10:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727258887; cv=fail; b=ZB7Q+1dDAYjrHkM/uyH9ZRLIAq/jWDxPvY/nyp6ZnqF6HdKHyhDxmUuLRL/7ehI/J3AvS0405pN3GSUjI3lXT+BvKztEhPRmA3jeVZTH0/KYIW+0eMAhvY5NxXpGWblrgTXr8jGeOPvru5/ZEFZF2fGQ2QCrdcVXJ3uCU60QzYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727258887; c=relaxed/simple;
	bh=apIs5UMNKnU//WmOOjaQhdC+ouFfr0lSQCNXbj3mlLI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=RDxGZtBMCYnSu+6Ftwf36O2d56S79OlJ3vp3efTiW6UkIdKGGqUyHiO0lnV/I5XuHKujMmU0umX95Kg3G/xJfhw0ZWbl9Z1EbeHUxZv5kkZ2ULd7cH5W57MD2BHSzYxNBZEc/8kKDo+KoyvU70wqqVWbiCOPVFUhqqDnpUTU/to=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LaL/gxD9wK5r1/v1cfvcQarRkiP/e78bd7Gb/qzxrghTJCksGcmySlSscVhMAo4q2VvlHZiQAmcMp1QDnJWtmD+BkG+wtBPcFLcO7Em+GQ7ZFbJ4vomWn75d1qbowUfU0ZENJRV8rUSUxvWpxKbp5Do2xTPuSdLU1O+ZpJ2l7sq2uZwENN1hToEWNjIeAaA1JXhxMPHXpdoBLOEJilmeOOQGrOxbD9VFEBFXC3XAlCOWXt0Zg7Hnw8bodlYKSoQUj6EQG7Laa8mBGcjPMhh7UyEr6WlfHZhLL8HIzPZq0EBnVA2gv3P7ZYpNAL7DT/lwBMIngxATFxHOFFwiVyGt3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V6VxDSO8iqhurxhynfKhByJdV1L3fDOUmJ2X16Da6qM=;
 b=mLQ6GwVa7ft8A8rX7ou34iEP3N0K9IEvz1CABCI5jNhe2xxdg6An+AIoaQ0wMY8sBlIA1c+zC5f42s5NdMLW7sLDhJcEqVyEImByrdZtSSl5dkCdTH3c/48i44Xk42UoFx7R9VIDEThfXJbt10uLl12MRva3gsjeoOZao3wqJCt78qrJCLGSLLqBNaLLPy1RNc4Dz19zozgO320IBGJsDu9hp3buKy2QvOMDrz1vN+0YWi5d2q/IhmqwBpLQm323/jVLlAzrcvShmocxjrWzRg9hMdTSSU9W0IrycPNBuKzF1/szUEZXRkLUPp81jda5wHRFGACy63xb+oBBcoaI2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::9) by ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:19::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.31; Wed, 25 Sep
 2024 10:07:48 +0000
Received: from ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
 ([fe80::64c5:50d8:4f2c:59aa]) by
 ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn ([fe80::64c5:50d8:4f2c:59aa%5])
 with mapi id 15.20.7962.029; Wed, 25 Sep 2024 10:07:48 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Douglas Anderson <dianders@chromium.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Changhuang Liang <changhuang.liang@starfivetech.com>,
	kgdb-bugreport@lists.sourceforge.net,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] Documentation: kgdb: Correct parameter error
Date: Wed, 25 Sep 2024 03:07:42 -0700
Message-Id: <20240925100742.1730576-1-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJSPR01CA0001.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:c::13) To ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB1302:EE_|ZQ0PR01MB1208:EE_
X-MS-Office365-Filtering-Correlation-Id: b8e8abab-7486-4876-5b4c-08dcdd49e8cf
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|41320700013|38350700014;
X-Microsoft-Antispam-Message-Info:
	4XExc37jW4SxfkDieMvhXooZqwHoqwIkhOt0MZ6u8ZPkMZF8AHPJp4ReRCCKKi+ppb3HL/PzVVAcbda3pvQqkpRby93K2eXms1tiuk7GyOS2yrvtSuVqEM7BAxG3RG7CboHQrM03a4rhiv2AkOCGcGSWOL5vfnIJJqi1N581G6yQQlcU1cN0f4k0GFJEGrC1fYTxa5/dKkeXWukwIhCqBTVrie/T+6jlL8TdrnslR4Ao65QdTNhxIDHLiZT2RKCwkOQ/kp3mupKUEr2JqhCulczhefOb3ZWvqZS0ZB+hFdBFLmAT8e9x07UhcxAkC23oRNEt6sfuE7ibFDbAa5XSiq31hkr4C+6yU+SmzoxNijUjJlA7stVg1pXhJ8mLb+fBAAXW+nxjD2qSfpqtFGHTuXiV5iq3TKgvdwlkVQ0xtQVN3+cp/59hZYuGj7MygtFqyU71oe8eOV6dK8wmVNZ0XS5yzZnbculLYvErwORunb0nalZLsoOW0OvhN7h3GvJx+DSS1PMTMKy2ajv9olwFHmwoZwi4LKAiH4WVyIc7oCGeMY2EELSZYakuMjDfPRd+hX6mjC3kvZ2B19u6D8qBmoe8N7HHCpth9WXG7XftsKmf1zMx/j3VJ3GZKdr+4Gio
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(41320700013)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KCJI6xeMlRTHP4zj1LQLcTVR2iMvN3VPFw+2WHhFzmTWBihqYJuPqJ6bAB1x?=
 =?us-ascii?Q?LC+OOfFzz4OlfUVr37gDluygouS4UBL6Wg92V6DIo+tHuOYWXBdeU97EkQfv?=
 =?us-ascii?Q?kD0t8FKUzLCAw9EH4w1pu0wk/4hm4x3aGr0aGU2n3vcBKPP8A+8senKLHcYn?=
 =?us-ascii?Q?BERcIg+LmYjRwRZUhlKh+o8t/fR6LfasXRlMSISdM6HOl8UH1J2a0sqgiTgX?=
 =?us-ascii?Q?BCou2kCVMdWJB++7bYyF+UOAe66v5iSJUO7xTXmgkO9pjEGODId+iBNaf28I?=
 =?us-ascii?Q?r+ctBi8b31zJxty7L+K8uHN0LO1gACxpxuEoB3j4tS0t7/cQjnq7FvU0WNRq?=
 =?us-ascii?Q?HlGgg8hNmYwNT6TZI2C3/5Y+e0AKVOvqOEnppWX4EmuHvBZA3fpPLXXWQust?=
 =?us-ascii?Q?pq0sP6LJyX6xsWwvn9tu8LeNyjZMwLJZ9DqJbCNsP/USwiOrvuqHPIwnFZ3x?=
 =?us-ascii?Q?SBDdQzZCpi/MyWJBdse9FFVohzLwGLzWobjcCs+IjQuRmuMnWhEvWHxv7/KT?=
 =?us-ascii?Q?JJGJxSNW9DcOmphEOzOM5BBCdKeG+4QsUkkkWiQC7YZ1jmaXAy9uesJprsx9?=
 =?us-ascii?Q?utpTy6TSNv+d425pND3Abtg++qQRQJvpQs4A0VN+NDnAJnhl1Xt52Ly3HcU9?=
 =?us-ascii?Q?I2VWTlc4SyD5TwB/owHRIWnNup6uRmNMa1AsdHV+auyvwTY9oTB0scfbPFqS?=
 =?us-ascii?Q?dj7nd0e1m7Nu7n45m9Ah4qJGg1DGeCHcWgzFyW7h/L5qAmlWevdu3b9GLEq8?=
 =?us-ascii?Q?eyx/CQL/ccmpLp4e0JsJxsxKrwRGepS9w8etezhxfzwdDKm/O4h6xi4lyO22?=
 =?us-ascii?Q?EE3Kh5dsbMJbQsI25swNylxipxzu0RMXT2BJPODFz9MckBlLzLdcxLwgu5mt?=
 =?us-ascii?Q?aoyju+wYoz66ab5IYxa6K+KZo2Oz18DxK4fLlHORS1RycHJTunhJ+Uoc1fsr?=
 =?us-ascii?Q?eoWh1y//UBgEUeyCiHncOBFbLorX6XwXopUB3Ty6IgkRljG8FSsDC1LcCK5V?=
 =?us-ascii?Q?XmHGLNoyLJqd8EbVJ6wLF9R3rVaFAF6fyrfzPWYHtvcB0nTi9PLe60hNXeed?=
 =?us-ascii?Q?P2odcWKI+r8QK8wSnltksIlG0In8/AYBD1H/A1RcSKCmiIAibnd99jfDuKzZ?=
 =?us-ascii?Q?JozdAkCANwefiVvNzfpcfq94ixhpj4HkkRmyKFMR+4zy4XbUJdQB2YBZoBM8?=
 =?us-ascii?Q?hr6VGdOYKt1KCwGGz461PIGVar8rs6WqNC39CBBac4G57g8cwTyx+iiEYQHO?=
 =?us-ascii?Q?Gxw4JyUxDuzMAGmL2dGpI1uHn/0KzNvyZ+XDv9MG8hVYhlXt7sgQSZSa7fQU?=
 =?us-ascii?Q?LanHE6RYUA3Z3J6TPU0Nb0NgngfLyHnT0XSXGZr5zkwDyZVwBj1bBnb4T+JA?=
 =?us-ascii?Q?ocZKd0KsDevjCpx/1uff0w/CWmhC+7abdPOJsM2L/oFxqFnPSH02SvRM0anr?=
 =?us-ascii?Q?fc+/Hk4137EfgYttHzYpgibDImF+UYmpyDDT6aqL3mfbR8/QAtk8O7BgUvR0?=
 =?us-ascii?Q?+bJf+1K2Zu/doPmcaLfQ9oQUntUI/o/2BIre9eTN3GqJd1eYXDlMwrbcI4xR?=
 =?us-ascii?Q?Vn5FSaSukvc00yjd5QjIJy6Lk3uz6W2aMEDT4pORo8vp0JIflQLKsmR0N49x?=
 =?us-ascii?Q?k+z3hE57UTM8vsfqa0aB6NU=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8e8abab-7486-4876-5b4c-08dcdd49e8cf
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 10:07:48.8936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SV8Rg3cqHucv72jAbioXvsxui854pCliVkzMhlroP1LjqNo5YJLtJd6jX4alg+EBkLewy0FRqqkz17P2rRcrm7INGjr6DjTJZB+foASoN1HehG44xfTYvAMKaYwkT8nd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1208

Module kgdb had been converted to debug_core since commit c433820971ff
("Move kernel/kgdb.c to kernel/debug/debug_core.c") be added, so let's
correct the module parameter path.

Fixes: c433820971ff ("Move kernel/kgdb.c to kernel/debug/debug_core.c")
Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---

Hi,

v3: I wrote a error change log in v2. Now fix it.

 Documentation/dev-tools/kgdb.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/kgdb.rst b/Documentation/dev-tools/kgdb.rst
index f83ba2601e55..a87a58e6509a 100644
--- a/Documentation/dev-tools/kgdb.rst
+++ b/Documentation/dev-tools/kgdb.rst
@@ -329,7 +329,7 @@ ways to activate this feature.

 2. Use sysfs before configuring an I/O driver::

-	echo 1 > /sys/module/kgdb/parameters/kgdb_use_con
+	echo 1 > /sys/module/debug_core/parameters/kgdb_use_con

 .. note::

--
2.25.1

