Return-Path: <linux-kernel+bounces-415435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 226289D3613
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 09:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A90BB251B9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 08:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFAD18732C;
	Wed, 20 Nov 2024 08:57:29 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2132.outbound.protection.partner.outlook.cn [139.219.17.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544B81487C5
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 08:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732093048; cv=fail; b=R83QMGWrLEf4TYgrPTSATaWRu5bLiSPWUdtlv7fEkhtFEp3DmyU4Kt8XwsQqB0Yxl8h2SwiIwv68hGYoqXP0C6lJCNsywiXY2CJ8kH/fr2SU5o+FjKdUJH9ynCbLcqzZSA1L7awklG2qMR5KaNaV/YonWSyGAGVdDqf/TK34b0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732093048; c=relaxed/simple;
	bh=Ois4q5BTim3qYVMUAq/uJ2Ii9gwOZ2kejxBK+PDpOFw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=swMBkAh2P6HcQRcUvnOBxPHn8ejNTOwI61QNyXPOFIzV8CjGidC5bMatHx2YZG0yd8fqa+MghIWC809jIrqJY0JecHIwE2xESgmI8m+fXIVif8X6pR2AvCPpJuXVQvwrK6cneR1GKaBKl2M7mIKDIVUDFUjcmoLCau+pjuQJywg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lx0GitKPhXuQH3AqMsIqhf9xsYwpZWbKR3Ff9nZhiOAM1t3S7ojy+tbLka2LZPahFa9kM18BPa4u6suyy3BRrHDPGAuOfuwRlYbQtLh7uXnSmsM9p7T3wgb48QPxUsZbObfc6gWCuMpp2Ktr59Xlwzbeq14lhDL7T/L5BwjQM2z60/zJrGxdbWNf+HpC7f2wQU9AWOoP/T0OmKlqAg3rxAnpffrYyogJfa8UbMjy7s5T4qHnA4lY6Odqp0XR/iozX9Ftcg66EYk0GRle6MLdSNiCcCgU8mJwvLuWWA4czcAPZsy6zPuTMBtDrL68lB7DBepDAbdqGdOql0i9uS99HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0t1lmd822ykozpn2HkxwAFR08kaDIfHW57MvTFIT7bs=;
 b=YT5Eft87l7YJEXY4tJbuAcolvxm+dCUThFlRjZOooBByNjGtbEdiE2ibQ4yJeb8IccLmEMOYlvH3/4DZv+ufhmF29DTWlX7rTyDyyQslvksflweBWUnqza159aq7Sn58iskWCBKrKZ3J9QreDXBUF3qxSz6bx0oOsk2LxjiMsoWBGOy0x5ep5HU3d1PaLhvEVoJ9KC6BN1GfHUux4yYctbu/MCMoBinVgnt10mJ8uKhPmdh3w/5XH1CKD6QYF+E3Z78Z6Gpa4XP9XcFks/NxG8OI/bmmmb3iaegHgrgn9tEHw5/fvjK4Ufs8MmVxdD7hBwxEjo4QgC7KS73mA3gyhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NTZPR01MB1050.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:1::6) by NTZPR01MB1131.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:1::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Wed, 20 Nov
 2024 08:57:34 +0000
Received: from NTZPR01MB1050.CHNPR01.prod.partner.outlook.cn
 ([fe80::512d:38d7:ed9f:dfbe]) by
 NTZPR01MB1050.CHNPR01.prod.partner.outlook.cn ([fe80::512d:38d7:ed9f:dfbe%4])
 with mapi id 15.20.8158.023; Wed, 20 Nov 2024 08:57:33 +0000
From: keith zhao <keith.zhao@starfivetech.com>
To: konstantin@linuxfoundation.org,
	linux-kernel@vger.kernel.org
Cc: helpdesk@kernel.org,
	linux-phy@lists.infradead.org,
	keith.zhao@starfivetech.com,
	jack.zhu@starfivetech.com,
	chensy123@21cn.com
Subject: [PATCH] MAINTAINERS: Remove Shengyang as JH7110 DPHY maintainer
Date: Wed, 20 Nov 2024 16:56:09 +0800
Message-Id: <20241120085609.199586-1-keith.zhao@starfivetech.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SH0PR01CA0006.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:5::18) To NTZPR01MB1050.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:1::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NTZPR01MB1050:EE_|NTZPR01MB1131:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b577cff-76db-44f8-1b57-08dd09415f3c
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|41320700013|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	NT0bb2X6+FZiJhLSJaA91hJC4WtAuXeoSEEiXpM3Wfi8aMaPrS4Q8bQE39P12Q8DdKUB8F8KzXggnJqOUSD48GuAwE0QwCZ8vopT+h4po4H9/LTtNvgs3B848GZiVGBv/Do8bKCjOuKEI/YqZwmhCNMOCa9/HzmHIJlvIz18BL1xPqsFUjwhpGYxWYV6oMQoXL8zOynIh3SVJUV2kmWfs6u7xvn9liXliIi6TOAIzFA50DGSjHEnCig/Ecrlpapm6VFmDg7+A8zgnkvhn8lBaxPnyfawAexOq3axwA8Ee/fKu4AbJUD9cSTme2mb5N0k4VrmnGVrgO9NHfH7SKsVEGZw2EeJ9IjNo9oCT1XoZC9obtR2YTBqPbg5cgswRKyrsq5EMNiPVpag6kMDJlM/eWfDmnIUKjdrc1zw4RG40vqcU8/QtzMDW8Bf2L4POs9fINmpJbJBY/x2WhRGKRZrB66fdWACjJ/TK1oMHjBztT8oSS0SgCNRJVx3pwYAMolFOTG7Li1o+jy/PI/Io/hPHTKpU7Fg79/qUtVdDjvR/7WjEE4Dt+uG1ss5EbmKSWwx+WeZaZWSci1hzgpND/TD8rvkRpujLpQUCS5fXaN0uBFUgdcojnksmQhaS8dR3+xC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB1050.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(41320700013)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fo+2l+GH7g3oatXbzDuh6bAJYd88IrpczCPKSuRm/+9ZBsDmjDFWxetNaKU7?=
 =?us-ascii?Q?JVzQuUDlPBQ+kWaGClfPaRlgnWljKWXV2WvvAFy5M+x1zVErTX9p6ImECWmh?=
 =?us-ascii?Q?hoSdjapi8/zonnYyfi5qyVBY/vzwGF0+b5ZwAlOw5PuGzR7MxLs7vzE/hkM7?=
 =?us-ascii?Q?mWMHkizSrggm9HyIKYgMe2MgPWCEn4872Cs016wLntx3zeFBqeqa9zqVLEEb?=
 =?us-ascii?Q?YTroR+2D7LfYmLhY0685JbRchgXvPnSxk+aezLyMfLFPHKLGkJWwHxLOa4fH?=
 =?us-ascii?Q?8rsPCtnddvQ4Mz0XSfNyApIqAG1rfMqil9Je8zwM2NEH+XtChtx2tp6iXTtq?=
 =?us-ascii?Q?TPvuxyvXhhCEgH2CbiD0C0foeTjk+nttDmFSrqZzQ7mm6TmUqCBCPacJMhlK?=
 =?us-ascii?Q?acFhhwLQfivENi6VSSRgqYW2QTcrcgAC1mqUuXwu0rMY0+Pr6d1dCZVdLMER?=
 =?us-ascii?Q?Tu8y5JyGImkqvXVUUdO/g/I7mNiEv8QM0bcC9eMLcNeK1goXXlnGqPKyc2Ky?=
 =?us-ascii?Q?hc7t0G/9f+qcKaBAjyreFJj8gyN7bDN9iyma70Sf5HGW/KGzOm6YWyE0qR7p?=
 =?us-ascii?Q?eKrpp6jspumvg3yLWFbB3qnjRTTnZeuDPWUh6cE2LHuMyKId/T12RgqBlNHN?=
 =?us-ascii?Q?H8SKL46qr6Wo5Aw/4uQhGv2yaZjhMtp0KT/zZeLoSQ99lYrxiRf3QyV0bC2I?=
 =?us-ascii?Q?/+2SvjObehuTyddlmYNmcT6uIUJ9BZSd+ayD24x/W7XMOaiuu/ui7nL4n65t?=
 =?us-ascii?Q?5D9Uw65TAppX9vcpB4DvHnLRP+T9eTpQDuYRjEEO0W7Ia5rae9vI11thdFI9?=
 =?us-ascii?Q?tCmq8lKSyrzMeK89gKTqT9FmPyvnp3NJk4hkkpUjuVe0P0IAI5iSYz+DhTjr?=
 =?us-ascii?Q?NluLOwJmXBsR1Wk95aoLpgWBf2IUk8X9uFu5Pm2Erzg7/873sJPw5ryMWbbt?=
 =?us-ascii?Q?ffraHZT1+AyrIWthflOcgaBmWFVkdkJouV27ALs2aJeZ2u7qlQf0d06iG0cn?=
 =?us-ascii?Q?3wVzfUdkUf6Q4CsjXTARkCWuQOijtsGJA2xoLwipCcaapklNHT0x+K6zE04/?=
 =?us-ascii?Q?2BvOd++FNC9H2y7otja98yhJI54iSvJ8IU+BKsnafPvxqeW4bLNhO8QrgKB0?=
 =?us-ascii?Q?7TWgE+Zv8ImfayAJgM8fHlfqRMurJITnBknUqfF78MJTTX79IdbzLZg4jfv5?=
 =?us-ascii?Q?6X6M0rUcPRSFuOgHq1IHkeqxkqG0qvXe+v8Ff3AegUbhRhVVLGkAw37RBJ0B?=
 =?us-ascii?Q?vVBx8ykZwBYr5RIT6p36rG5sedXfnJBQbK0ZByU1P0Fd/SKwYTJtxjzlWns+?=
 =?us-ascii?Q?4v2PVJ0LztDR7HYxAuq+GQrLF7ZEEp3Gg7lMeVs7n846/wDsFcPzVeiP/nBU?=
 =?us-ascii?Q?51QtBXuuRTunoU+RCds55U3NGOXPG+zI6JMQvyMOLv8ZnHTZ/2giG/vPet3P?=
 =?us-ascii?Q?hg3LFi0WbwuCC4aQd/qFBjHsolRHVaUywUuz5S/e/Rkc8t19tzSZO09w+GqJ?=
 =?us-ascii?Q?Lqm/ODKWty6+ovINdPNX0F4NkgFsQ0sLJmi7/3dzDfSPDkarBXmaNso9CZHt?=
 =?us-ascii?Q?ezshG4UcD+cL730MAQEC09s2gX90e3jMxqkR0CrpfX7qT5TkQTq8tuKZZLlO?=
 =?us-ascii?Q?CA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b577cff-76db-44f8-1b57-08dd09415f3c
X-MS-Exchange-CrossTenant-AuthSource: NTZPR01MB1050.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 08:57:33.2875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SI2gI/9he4laEQosNbq6YpiO3IKrRuJq9e7XK9ESvOX/NK7mfCoqdk1jZlLLgMQX1PNn3awbpTtcixPQrAv8vQOKARL+i+ZnAU/U2vyMR2Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB1131

Shengyang has stepped away from his duty,
and this email is no longer valid, so removing
the email from MAINTAINERS.

Signed-off-by: keith zhao <keith.zhao@starfivetech.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 20df6282d1d2..a1d09c0fcb14 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22295,7 +22295,6 @@ F:	drivers/phy/starfive/phy-jh7110-dphy-rx.c
 
 STARFIVE JH7110 DPHY TX DRIVER
 M:	Keith Zhao <keith.zhao@starfivetech.com>
-M:	Shengyang Chen <shengyang.chen@starfivetech.com>
 S:	Supported
 F:	Documentation/devicetree/bindings/phy/starfive,jh7110-dphy-tx.yaml
 F:	drivers/phy/starfive/phy-jh7110-dphy-tx.c
-- 
2.34.1


