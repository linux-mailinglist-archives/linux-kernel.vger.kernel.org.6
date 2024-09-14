Return-Path: <linux-kernel+bounces-329285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5EA7978F8D
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 11:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DABF91C21BBB
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 09:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448F81CDFD9;
	Sat, 14 Sep 2024 09:37:43 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2122.outbound.protection.partner.outlook.cn [139.219.146.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8179A1448C5;
	Sat, 14 Sep 2024 09:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726306662; cv=fail; b=LE00CJ6Fnu8ZDmPHh0lZ9XIhbr0QsJYrQ4h+DeLDredsyWHbv0KBgiEJUr8jPHB0oZpjkVqhBEZUSUMSrXfADWMUss+YO3dGfb4l7bz/EyylycfNmFzKbUdcTMGdgZMSM9B8N6lSqWKky9MbGJuDe7yfYEusR8w+FTJ2snN0WlA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726306662; c=relaxed/simple;
	bh=OY3SpyJfqTYsMM0PWUAxhLuOFnCIg0MdQFD0JyQddc4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=IKJf9gxJW2oXKC4anVt/XChRgh8B+QXdYrbSw0U0jn10tehtx60Lvrum6nvaCO6+UrJHB8wLlbjYXlv2p/igjZ5+5kGqDHS/1Ybzu8Il7vva8Iu/VWt02SsYygtiCTMj41NTyWcgMjhQ3ryk2mPF8ehVlPpkaqcoz++zNy62Tb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N0I/99MZ16AZWXhSHdFQeUqm8nHm/6rRSwGTmJqoWWDwjkAS+pRDxL8HsodE0WgAaN00vmOd2QQ1flHkBPNEQpljVr3/sSxOGm0zimwfxzvgpV/3pPa2iy+t3PqHRg9S9ioWbn0iNk2OCRBnoPTZczb2s8gmTerjdJ0eyBK4S7OiEvjjiiiMxN27ZtyFjsa55v/dbL65QKS8FLIPrZdj3S8SudbUrJvu3RA8PxYEIJ3HNp45CVNEuSZ/HZnCnnqrBoO+z/0g0Z70+Fw+9kaCaKOCsz4aP8c4qM9WcV1wizLZPavjB98jk8vHxnDTr+z4XiW8hTaSBbFs/N1/nu4xfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vSxLiTUURtcy50pZGnqkVxPloTuH+xHAc0uVezjfdOc=;
 b=QcPsxJ46aec4wzpCfBqGoUBF6m6YvQgymTQyfguBMQrzMr4fX3CpzDly452kTLM3p0tfOOjElmEh73wcMWUR5HNot30RomHtmeKxbvrZE7RE/CeRkw+QecjN8yqalXnmGHrqKAFKV7LvTg9Dsk26w1SrsUnLDobZh956cRnN6G5e35Rw1QyxRVF4UEj8DNUt5XE/s9HauRyJPYtmD0RJK+sb7p801973DnlzOt7gLx/wLCCMNjvJQnm8PwYDfRmVczmmEq999LfW1yjTIVzu2Sl08MchrKIstuPXZtSBVi+rGz0jNeDVDhBYeisZA+oGgu6MaTlTWHaWIDSCB0TkOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::9) by ZQ0PR01MB1301.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1a::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.21; Sat, 14 Sep
 2024 07:03:08 +0000
Received: from ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
 ([fe80::64c5:50d8:4f2c:59aa]) by
 ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn ([fe80::64c5:50d8:4f2c:59aa%5])
 with mapi id 15.20.7962.021; Sat, 14 Sep 2024 07:03:08 +0000
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
Subject: [v1] Documentation: kgdb: Correct parameter error
Date: Sat, 14 Sep 2024 00:03:00 -0700
Message-Id: <20240914070300.42936-1-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0020.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:2::9) To ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB1302:EE_|ZQ0PR01MB1301:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fd1ccd1-24f2-43da-926d-08dcd48b498b
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|41320700013|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	C1tEnaS+Gn78YYxaA5Do0eLkoZqTM73RAH7OVP/mYDh+knrYhTyjAB07eJra22CiFovNNqIC3keQZ98wYh7AQsYBlstr64rZv5p5AIEq5AB8T733ZGjr+3NujCeHPb9DtkKUMWv7toI+cKNnLpPexFwJfUohtgcbHqV17H++7ZGFOXbIfYdNzM4y11lrGisAUoR/b4kuNVKH5W9ADBpqRMkusVKQkhlYjpru9aEyFXB87jSq3RSXM36Q6LS/6W3yzEMEflGblfZRRG6p23pqrwirmR4UKR74ixRp/mRTFMS7VCVMqEIy9xUdQp9PbMxyEsFFRtPcJdjGXWRWojNs196qCws7UmT2EQ0FTnNJiC0XbqZFxe4HRSa3SMW3iORPJWiI1FmUXe1dhalBK2Fz+74+zIpCptPgn1NOcPq0v5N9COk3LBMui3BPRX5qTQTzNA8ffqCAIFSngufbHFXKCa+4zsJNHvcTX2MceDqKILpDihkbQv2Ow82qLf0WZa6FP8zuhFNNz5BgrVRie1WbZ2KyBcCQG/mdV5MJqkRtCLVLoKzIiRD5ugrvizZNzi/5F3ucD2LfYk00PalUkI2fpbFF40paClOFxeGSkbwnyWUAadTp3kQ/iU8RREAUnQc1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(41320700013)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pD27BJyFd3X5C95AU1PZPP/ZMrVBe8NW0JpKm+FkXO06P8Dda4yHNW1DCAdy?=
 =?us-ascii?Q?k5XKdHpthSgtuzfmCHQAA+C4tYrqgleySsTYuW+TrKb7rlPxiYU31dY/z7wv?=
 =?us-ascii?Q?5FunuRf+LJy+MmZBMUsbAFHREFPfn2grbDbEbRgLhyVghaf0gBW/6ZnR+Nkf?=
 =?us-ascii?Q?bdwDDkbXcb/HjUvOVp7cxlKNbrMDcyoFvdsHKj6V0s05Q05aAw9BeazOK0iW?=
 =?us-ascii?Q?4JhQjBqtChQF/gJE3Oy9f6Gy+Sz2gZ/qjfCJaQY1n0Ut2GjKMhu5Y15kM7qc?=
 =?us-ascii?Q?rK7MGmquzcaYQaUEcefjZhFJ6hSYpGrGH+LSrtSSMwX5g2bf2eDOIwhqM59C?=
 =?us-ascii?Q?9C259Ygu2CNw92B6FfpLQp1iGA/JOjd2HqsWoLI6N2FAPPVI4xHPeit++5tY?=
 =?us-ascii?Q?uZlX3OeTCOId59GBCxWneNU5FSD/fQdgNEFnFfYA4ZSBqWIa7W0oLTtXp1dt?=
 =?us-ascii?Q?2nEFWFaDZLIgGPG77FFJ41EH3XypdydiE5NtrGasxn09cyIkhyKu9bYH18+5?=
 =?us-ascii?Q?4a42S8H1ok4PNEi68mHqh37HzcORoEMTTPKQEuUv72PDIgPOJ7XZUZ1qeoZ5?=
 =?us-ascii?Q?9SWMxcbdqonLV4Jg+4M10ck1ZUF/3y7aYcIEKlgW2Ixuqk52BCm+kzBogRBV?=
 =?us-ascii?Q?tCTJQ4ayLZwyZg4ZdHz3MArZipSqu9df0ZJRdivynqSOQ6Vg9wcXd55UA1nK?=
 =?us-ascii?Q?csyyxLtqHZDRNCK968qoVMhoCUVzUGQxqkEypUwTKBJVnwsLr/JVbfYlu0i+?=
 =?us-ascii?Q?5GO2pSgPjo34aht0dvT0WDr0xLCxPOmM7a5Q4alNHd4uFarsxBz+jEe8TK6h?=
 =?us-ascii?Q?VnRVhNwzGh1d4fM0oiBKu4X0QYz+3ut1AmCeiYQGk30/i1gUg4XAEzAzji34?=
 =?us-ascii?Q?GdwZfMAdU/24nOpJTtL520bsg8TkZNYP4dgLF0rCu3XwzN4Vl3//ktY7KzTN?=
 =?us-ascii?Q?nchYGvlPIwEs1V4f3YW2Z0dz0lh5UucVl3qHbH4ZEYbbYfalxWIE9bZopLpV?=
 =?us-ascii?Q?Rg9GbmTll7nBJEkNIJDQRp+3s4B3u2eyCnCvUSBnddJteoBc3fwp3rwWSFE/?=
 =?us-ascii?Q?ExQG1QJg/UqfseyRFKyv7ON49ht3/1eZkWn4j5GiB5dqcueb8T1UpVVU5gvS?=
 =?us-ascii?Q?1+y7fBZjCRufEwZROqsS39/BmUqLUshPv8e6euAEGFL0FIY5rHFZZU/UDto5?=
 =?us-ascii?Q?xHJrybPd5fepr6mQru8GeqEzo7IzoPxzHOFmcAtGuPn4ZdAc7r0QSES06ZNQ?=
 =?us-ascii?Q?OcskdoVYSFqsiC+EDJdh75I5Hvrbew0ICPnDsrTnBgz4EfpfRMmI6d26rHEP?=
 =?us-ascii?Q?vlJBVyFYrkwD+AB8A+/+ik9z1OGLZV2Squs6cZAIzZmvw04K4uER6lglcBEP?=
 =?us-ascii?Q?woTMQt/G0uD6wenG9fefjMT8CBAhloW2lsBYrgSd/s1872g+5t4qj2us8Dmi?=
 =?us-ascii?Q?fk1DRC/gfWfVsi/0sv8PzkIY8do9hEy37HM+L5caupQ9i5NoBbhKlr9ajezo?=
 =?us-ascii?Q?K6L13b+OZTxMk8DAb27Z58GSNqE5Vyxk/m5eOQvHrlAUIJa0z+hlKHHphAge?=
 =?us-ascii?Q?LTwt05U0igUEGydUREBCjWSRcCOoQyTLZLoCf8LX28MvLPmCutgB0jMlJJYg?=
 =?us-ascii?Q?5m82US0BSjdAm4aKaTyFYtk=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fd1ccd1-24f2-43da-926d-08dcd48b498b
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2024 07:03:08.0632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HdGLjrBFjQfc5AVXDqvBV5PTgSklkQ+GZZwzL/yD0+mkXSdhGBjB3FmqNls7RUYKVHSLbmQo3+dPjJOX26oqhfqPBvynNZwt/GT0KScaoy2bYEd7r4ruaEAeIGz2OKCs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1301

Module kgdb had been converted to debug_core since commit c433820971ff
("Move kernel/kgdb.c to kernel/debug/debug_core.c") be added, so let's
correct the module parameter path.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
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


