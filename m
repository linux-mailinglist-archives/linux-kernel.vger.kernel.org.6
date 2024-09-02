Return-Path: <linux-kernel+bounces-311433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B66968919
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 15:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71FF8284490
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 13:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3AEA20127D;
	Mon,  2 Sep 2024 13:46:00 +0000 (UTC)
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01on2106.outbound.protection.outlook.com [40.107.239.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AF7C13B;
	Mon,  2 Sep 2024 13:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.239.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725284760; cv=fail; b=IHguQHcXmFJOsgSwdB2MycWfMhAKfHBev7z9YQ8BLe+96FycLvZ5Z3PfCXGE3LL29ExwcZI9lVdFQrhiRmth43BqzLtyra2i34FHUxWQ19yKqJSywHH5w20NekFtClFpvJXy3reWa4lfzVL7r7Au/Ul4RkmW+jc5gmALyY1VkxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725284760; c=relaxed/simple;
	bh=sIhdH3atbRgUvQb5w8fjubJPmeyd1bXNNaKK8zFXGck=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=t/NxE5tVuHY5ldGaHskv+bTw3rYyMt2XkKieVa6a2yzOCm93Alu/0NslTps9Zj6X4qCkSK8pgjaz9soqBT1ICxUOIv4DJEIBFCDCeiJgIgAfowW2GHqMTt9LSSVFr+ty/py7B4eCc5bOIcs5DvtS8Q+wXCtoqWU+3PWwpcs/4fk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.239.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GsdX0Qf11k8goUHzOVLlfxB4OmA7M4VWfVZPuO33Aym8/ci1OQLWWii39vHMuIJwhyGPJkm7n1s5jTCeA5GHLFWMsObFCoFiq9glmJFMVlGV1JSeA97Awi+4+bRyxIWL0A52sgRK5cnkittZA5aI8KenKutH2JZAUT0v6MEuLazSB3wr1wwwgDadWYfhhmfVnF1t08gGoZlTq02wX8xn9To7bLTkmHQ0828TYQbwsHZYYr+++s5Zy9y7uC3JHVqB7ht8F5ljh7jB3ilS9IP1RouH304Kl7WtZJgA4wva7+u/rjvhSncR46XAINl/P3ZvqdEaLhAYPuMTGYvnldCDSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ct12Ddtsn/tYsTAc2epp1HSsWolUkL4NbbGrycT09cA=;
 b=a1shbqdMT0T9/GYuUwdwg07q23tFbP6Yo6UT4I4fYTnEt6ul+rw0dfvTOS0BN8dOAKpLSuGNUgx7F+vlMdyNRAborcgMI3sEMi7id8LJqhitIpyW5ulx5iyJQiTBfDp/NDhF7QeDaYcgqgOzAAISbJpmpQ5LK5VqUFMc+EeqMW1vxRhf1ZbSZtle6m3VvttilOMgHu2XaLaeft4hjE+Ndy2AgTIDIr52ODx8oGO0752ByYkpUHz/Cb75jVbeoxa0SlI8Ur4FkZXBiIOp5wzi7+spI/yWLxDF1g3vFv1n3NtIFyPTKu/LVMt7k+vdERIsYWJeGgRXBa+fpaZPQpE7Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from PN3P287MB1829.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:199::7)
 by PN2P287MB0597.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:15a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Mon, 2 Sep
 2024 13:45:54 +0000
Received: from PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
 ([fe80::58ec:81a0:9454:689f]) by PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
 ([fe80::58ec:81a0:9454:689f%5]) with mapi id 15.20.7918.024; Mon, 2 Sep 2024
 13:45:54 +0000
From: Tarang Raval <tarang.raval@siliconsignals.io>
To: shawnguo@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	festevam@gmail.com
Cc: Tarang Raval <tarang.raval@siliconsignals.io>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Hiago De Franco <hiago.franco@toradex.com>,
	Mathieu Othacehe <m.othacehe@gmail.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Parthiban Nallathambi <parthiban@linumiz.com>,
	Yannic Moog <y.moog@phytec.de>,
	Josua Mayer <josua@solid-run.com>,
	Li Yang <leoyang.li@nxp.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 0/2] Add support for Variscite Symphony board and VAR-SOM-MX8MP SoM
Date: Mon,  2 Sep 2024 19:15:06 +0530
Message-Id: <20240902134512.16717-1-tarang.raval@siliconsignals.io>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PR01CA0249.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::9) To PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:199::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3P287MB1829:EE_|PN2P287MB0597:EE_
X-MS-Office365-Filtering-Correlation-Id: d4046c82-b512-4a5a-34cc-08dccb55910f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uqHrc3mIehv9asyoGfQm5cwTkL+tV74DvpqF7AOamnDuMBRsrCkpkGYzo/pg?=
 =?us-ascii?Q?AmeID7rwkLWdUS+3vdDxG4+fMhUVct8Ke8t7McwTjHhzXj/gLM9aDgpfNSPs?=
 =?us-ascii?Q?LaJtjw/wN28zPUgf5iPlOatkRdSvat/10ymCb+fZJbdUovZqhKn2H3vxyaZe?=
 =?us-ascii?Q?HAyiv79FaxPs8XrL/NGG00V+U6P4StWoxh8cO8B4pxS2WiVSuUzwD0NEVlxd?=
 =?us-ascii?Q?2hw8vBB0fNt8AjOAN8/qQ190AEtMzDPxKn11INkVIE3aE/1E2ZgevnldI5lm?=
 =?us-ascii?Q?X61slFSwLieB2hAUGrqPjuRMAh1J+vYakypZb7uiRKoJEl2xVxdMLuRQ+Y37?=
 =?us-ascii?Q?KYiimIQSEsm2ugi9SKmFehHhOieLYRqXxTzOdSVr21wcUIE69/hCiiNlp2H9?=
 =?us-ascii?Q?SCcy2t4mDuofn+6hsckGs006n9ke03t1BtBdHVeuwib6NZUw5G30/Dn73fuG?=
 =?us-ascii?Q?byso/NxUrmOx78qhnz/nMLW1CVDgrPIw02S6iSxLOWq0XE4USEUNclymTDEw?=
 =?us-ascii?Q?MSlAhe4Nl3qGZgA7oER1dNjcWK3Tui/2FdMaHaaC8RNvqahmMMPYx7oO+3Ig?=
 =?us-ascii?Q?g338xzWLCeVMPBUPDuKwGRDJx5uG3edk4xS2rV2ls1I5zJsrEarl86ObMJkW?=
 =?us-ascii?Q?5Q2hz+TkwRnkoZ2Xy8/EsgZfaJHVh1PQacagCLnCTSM2sU02IY+2/fVaa7w8?=
 =?us-ascii?Q?mVjr0rsy8gcqn4fo8O+90graBSsdJOGAWruZvFGCAYPjtH2bk0XwaP+UuZVb?=
 =?us-ascii?Q?IH9ciZW0yWE/umnHpPttLBVF1hOa00eMD/TPn3gcTdma7hEqZ4Vfg4d7GQOu?=
 =?us-ascii?Q?izHpeurSAV+9aW7Jvp2BdvEsUalhZHZ7dKFaQa2gurlkmrLGzuL0ELr091QP?=
 =?us-ascii?Q?LCJzJs39ERaXAGmYWovfUGd6YouU8EjLREfZHq9qBBylaXwueX4MlBnqWVCE?=
 =?us-ascii?Q?n82MvblKKciuFp+QifKJagApQC0yaLpiEEx4jv66I3rLOo+mYcN6MYA9pFT7?=
 =?us-ascii?Q?BZdZMmdnir55gfvfiq17kKo+tHhqC9vUrDa37mmpTJucxokqW8i6LN1yrzCc?=
 =?us-ascii?Q?xcz6JepfTfQRNMPo9zRv0FBJ2d3yqR4q4A/hzvj2PxEAHakv3scityuJ+pI6?=
 =?us-ascii?Q?TwzaHe9E4dz+IxOo4Yo7pXhxuC3+k82plJzPpKFmHqNskOfUwBfoN8AVz5cN?=
 =?us-ascii?Q?g99ezraAC9GQBuZo6k80SepyAeqtFEfm4D4o7cp1ZlX94TwOJ5/r/dfdLqwD?=
 =?us-ascii?Q?Ebdry9ZBilWHVfGyHHkUoPV6NiIX0D1Lyn0uksz0ei/BXK0uVPsXugPTu+uz?=
 =?us-ascii?Q?aZhKFOLcLcqQQgz1QlRKox0MuVaF3JTR797x7z5x4rN3InqJBNof3m0hidXc?=
 =?us-ascii?Q?RKSMNAgBsKtDzwJ5mFW5fBe0VUR7E1T5itRTM3kye2lDJ6ib5Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN3P287MB1829.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xBtR/bfvQxHSQw2Xk8AytQuEoOSfXyf4Pj5JNI1v0htg7vU8Kpo3MulJX6yp?=
 =?us-ascii?Q?13itQqj1QARieo4chxiUEoXFJaPMKcEiT7ueXe2SAbzdUnUbDcTJQHTJVV+a?=
 =?us-ascii?Q?AhGIngFHHE9JrlbeOecc+GGclsnW82tfyWC/xqgCYNwY6yNo/4N1wZbkafBq?=
 =?us-ascii?Q?Lumr6mGn4HBOflJZbCF+gaCh8fvxUNkes33/SbKi+XtsW0iYHmuR6gyhRK7e?=
 =?us-ascii?Q?rlZfBcjMNueP/12MaFWo9/OdYdYMFXPexAFXkp4g+2NDuyQYIixzS7nw+j72?=
 =?us-ascii?Q?M97C+/QP6Ra/Yi2rj0CiTHnxIFyFyDoxuuHcXC388N5+2wGKIZkEwxoH3ZNy?=
 =?us-ascii?Q?pzCgukZcxVN56vg++I68uI8LsNHLQHRg62oYjNwGx1FZXS+z+u9HPQY7FcIh?=
 =?us-ascii?Q?LRnvnPTopvId9PKDT13DhbULqLHqKGHc7L3fAyatenYVxU6bWfqEO6ta5lAT?=
 =?us-ascii?Q?6+8m7PKB+Vd1XJEqjv9hGiqV5h66T2YL1N81gcuH56bvUYyPrQGqnv3xi6DZ?=
 =?us-ascii?Q?EYZPWIekSJQBaj9vqNkVT8dQdrwiiHEN8LCX75ubnraZxs65D4rQTotdHI45?=
 =?us-ascii?Q?1G5HWJbUEzlr4jjOtfLR1puhEiGfeIqniYAtUyGZKR4aIa/J6MJ/2MEmdDd7?=
 =?us-ascii?Q?WPQ5m2MOYrWdHhleMy4owFk9AHq9OHa0z1Um080n7tfVchLYBI5PFbY6qldr?=
 =?us-ascii?Q?iRIudqTdDz3EPzD8tCxXIDUGW4bI6f+3QOF1bJQL8jlpzryeurAkDr0Q5/Z4?=
 =?us-ascii?Q?f7UJ9hPOeIshML7+8BhgqGZZ01XGQ627hBTzDvb100CF+AiiReB+ge4/ajjX?=
 =?us-ascii?Q?3i76vbs36VxKwswtWZAeeQ6UXBPtEWYyxB84y/v/Q8MdIf379imHilzxAPDg?=
 =?us-ascii?Q?e+UM1trpNdYVMlwhPU3rQVRP+1DmpOPrqNo0qBCeEaP7DVD6WB7gAoxMxFyr?=
 =?us-ascii?Q?ca4IXftyK4PCbGY9iujcm42Xv3Z4FgBgo6t23zQTIPTeqG20rvG3yu7C2Rn4?=
 =?us-ascii?Q?yK1YX4HbNFiAm/UOO3H2/TmvHjDIX2wj5v9o6B/hcfVE24t8s7roJinqumws?=
 =?us-ascii?Q?N/i9v7bMfZ2H0M8APXFNu1l2utdR1kwo1yhoablqH5V3XD9RivIix+H8HjoN?=
 =?us-ascii?Q?mBcMIspNBXN5sRokycG1EO6DjooCylMAFkox41iDxjGcOQWtJtIdqEF7FMCS?=
 =?us-ascii?Q?++H3iwFZ1rjzokRaJFprk/OYLJ/hAy9D3d4ugw6H3v2seTrZScOMt+HSINjA?=
 =?us-ascii?Q?uBdAO8XEMYo34akchNnL36qIyE98n+mvJrajVLBA8evn+hLFJlYpSd06Ibch?=
 =?us-ascii?Q?g2BpXtjXqKI5oToYWFMr++zYK0EAQFKxy79kb/eccJ8dCSXFRauzm9SIn2bL?=
 =?us-ascii?Q?MRT1tnqn57IDKZUFaAHdbbcdJfQO+08z/Mu5lLycVLiru31qR13cIFTICQfH?=
 =?us-ascii?Q?EY0A+9Xt0VnX7jq457s+CG1bZzrBvvZDhGc1jwdSEOTKWqcHSocPPu9mCTtz?=
 =?us-ascii?Q?w7ZgIyH+W9TJU5P3W6jyYg23oc1WBWXoWMOzab8F76d+A4G1qBiA0XB2l/k4?=
 =?us-ascii?Q?sXJzK83o6iIq1iC70875WkYXXXuGOm1iJLA5ck0kUxCAEawa6I69dictcTDl?=
 =?us-ascii?Q?1jn2K0elWcFY4AuatmKLbgE=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: d4046c82-b512-4a5a-34cc-08dccb55910f
X-MS-Exchange-CrossTenant-AuthSource: PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 13:45:54.7221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xwr5YYWQutZ+TskgViTUWWkyYk7DlSGjjnxL8TOuZ/qksOonY5kPD7x6xU0YMWsgC7D9stq5FcRd0MvGR2+NBwqv2HjpFiIpx39hM7M8jbI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB0597

Add initial support for Variscite Symphony evaluation kit with
VAR-SOM-MX8MP System on Module.

Change in v2:

in patch 1/2:
        - Removed unnecessary property: "status"

in patch 2/2:
        - Appropriate board name instead of the SoM alone

Change in v3:

in patch 1/2:
        - Removed top-level compatible from dtsi

in patch 2/2:
        - Drop VAR-SOM-MX8MP SoM compatible alone

Tarang Raval (2):
  arm64: dts: imx8mp-var-som-symphony: Add Variscite Symphony board and
    VAR-SOM-MX8MP SoM
  dt-bindings: arm: fsl: Add Variscite Symphony board and VAR-SOM-MX8MP
    SoM

 .../devicetree/bindings/arm/fsl.yaml          |   6 +
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../dts/freescale/imx8mp-var-som-symphony.dts |  11 +
 .../boot/dts/freescale/imx8mp-var-som.dtsi    | 359 ++++++++++++++++++
 4 files changed, 377 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-var-som-symphony.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-var-som.dtsi

-- 
2.34.1


