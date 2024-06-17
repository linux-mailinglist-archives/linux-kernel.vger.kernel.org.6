Return-Path: <linux-kernel+bounces-216638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE5390A27E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 04:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70D801C20B56
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 02:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17481177999;
	Mon, 17 Jun 2024 02:36:16 +0000 (UTC)
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2091.outbound.protection.outlook.com [40.107.255.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B090642AB3;
	Mon, 17 Jun 2024 02:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718591775; cv=fail; b=MZhnU5lPRnXzPqxwGgMvGP/N8PkAjsX1c/Mu0+Ml+exj3M2YiFmUoen7YfBMHBPb/5LNbcqqQLC8FJCLMpK9hewYufMTyawdn4RbZrNAbcvqXlbaDOXw5x8t0KmU3Gk9LOSJeKzJNspooMJGw4D+lEX7k54gD80S55gDMI74Caw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718591775; c=relaxed/simple;
	bh=iuAv1n12ADnhA0flSKBNB/cRdG1MERe2qAe8rsSfXdQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=e52zdvzan+m+t50tYGeuN1BL2itcBt1Z+NJnyA1LxDoZF/fcJm+8qFtymq1XFl5mkAk5nJHeZ+8ddXAyR80ow5zySlY+pyjHcU2UGuFjtd316/JHR1+YZBud6ogqyODDjzhfFHn8Kc75l9kLDOT4PAdAXsCXyMQJ0DD3Xnp5NRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.255.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Alv/SK1DHuGTf14GnGiRGn2pNz5ORkY8bOexrdYlz4PGfqlBQPqqMe7BKc+Ozu3VZckYu5gd7QVuONmEqHfBZTy6r1MCmeNQB1XV9ofbWnAstUl9+Tj+jC8IUyO6sfxGNXQm32nM75vILaWzuAFJWxQ04q2zvN9ZyNIC3axhNg0bwlpVwavvCLw8pME6mVKhqfJ1haf3Vg/K4MPIbAPn9Lku55o0CEnwRpPROhfSzeZmThdfqzarJza2XBI24Q/C8G1HeVW3GwQwpiUOx5bGtrIx/h4DtzWSpG33U1u/S8aDMMp8aHztnjgJHFOTs2BYWQ5MUuMJKCeffQ0DHKsVOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gMrj5aKuC8vzW7qv6cNfFcD0nKtP7tUvaPJT/+ceZ+4=;
 b=TgiwDRzmkLKgw4YZrKs3Wg3wJ5eO2Mv/FgrS5vh1bCCWDHiG/aV+CglAzMtMGkdAL8+RlkTMYMGo7jdIxxMIodfqdoALpl12TUKN17Bin0rN9uiN5S7VY3HQHbE1pDM/avs4yVw3TzQZ8iDKUu2RW1UQtAlebuqDq6BbMet0niTpCKiAEporoBcyFGDRGKctC51D04NwKFpyHQ9eR5hbNVs04YdTKpWdkgkPCiE6hASbOB+io7Xnn7R62HUcCNFrcw7ham4EvJEHNVghhsIiG6Rx7k3onRZHgoVajNaxqWyftPnVBbfyQHIBG/gTQtLtsw6ju1Gkrc3jjQEu3kMoDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by PUZPR03MB7044.apcprd03.prod.outlook.com (2603:1096:301:11c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.29; Mon, 17 Jun
 2024 02:36:08 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7677.029; Mon, 17 Jun 2024
 02:36:08 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: nick@khadas.com,
	heiko.stuebner@cherry.de,
	neil.armstrong@linaro.org,
	macromorgan@hotmail.com,
	sre@kernel.org,
	hvilleneuve@dimonoff.com,
	andre.przywara@arm.com,
	michael.riesch@wolfvision.net,
	linus.walleij@linaro.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jacobe Zang <jacobe.zang@wesion.com>
Subject: [PATCH v1] dt-bindings: vendor-prefixes: Add a pci14e4 entry
Date: Mon, 17 Jun 2024 10:35:17 +0800
Message-Id: <20240617023517.3104427-1-jacobe.zang@wesion.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0121.apcprd02.prod.outlook.com
 (2603:1096:4:188::21) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|PUZPR03MB7044:EE_
X-MS-Office365-Filtering-Correlation-Id: 220c957a-43a8-4d8d-ffa5-08dc8e763e36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|366013|7416011|52116011|376011|1800799021|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cL1H7chYjyL5IdMIsBQu5x+q3NlHsxGahkamyNxy3J8OAxNSbsprAgnDDQd1?=
 =?us-ascii?Q?wFRYkHXdQUCc+dLeSCztuE7fby8Uv72NEmNMGwDJr0BItCh8C5A5Z9nOmbKm?=
 =?us-ascii?Q?RWcP4EJbdDK7zUDttDTPsZx+DfBcYhpj+790igCAjTC3QxgW+2NP4PkWCGJn?=
 =?us-ascii?Q?w40z5q0kLo8WHNRB0Adk4hBGXvyaXJEnUZz63NLOayBd/c7bYZ0r09wyTyJr?=
 =?us-ascii?Q?9igAdjBFXPqQpBQtL12rMCjDcizlunrqzb0G6SpQGeP57A4iT2/APmPNLVoy?=
 =?us-ascii?Q?wk30GBs7BI5u+ul3WC1pfOMeqk19DpamderdsXeMzxy7v5/W4OQM2mtHFvjA?=
 =?us-ascii?Q?ksdMMz4p4NEXN8mUbO0mosyVdwRYeQxl63hBb1oLnP6rbU71ZtxSRn9RhKZK?=
 =?us-ascii?Q?WBa5hcBQ9ujOKPkjVFD3+p05XozF409/Rr7eoPsr61nEVxm71SHVyueCUt5A?=
 =?us-ascii?Q?eS7DN16iZsDOI4tuSi0d1AFakwnHNISaqCqUVMJXcuSpAEEdisiqlIpJWMQj?=
 =?us-ascii?Q?mGNsr/oU44Lbe1RJQhZ5reV8nsdvcz1AZHI76ykml1zKw/CYduO9jTnn6won?=
 =?us-ascii?Q?7ZIg+09dXx8U8DmTBiNRUHQENJxU8t81cUThUYulsWTXxhSfG4x1Gjeu27uy?=
 =?us-ascii?Q?ZJ4Dttku8SKpbNJ6qV3qIyp3S6rd8/P1k93HtCEfEAwqCvBQRkizFyYeX+5F?=
 =?us-ascii?Q?dVEIYuo6kihnQd6GGWj7PBUKBaiyNP+37afc7DuTcIDHdFO76OY60Ps+7x4O?=
 =?us-ascii?Q?mnGZpcrda1ohwnFBdscuHOyoL5vsLMdc8TpUYQ1Ak7r+Sca657jGwNvCgcak?=
 =?us-ascii?Q?+Pq796iUKkiZwC58r8SR4HXpF1q0FmTDC1HnYeL+s3e4oDndzRpjTJDri6Nl?=
 =?us-ascii?Q?HfbqHqXLLppoyqRGJ39/XkXiW/XihkmVhoQ2kG+WeHOrGUX96aG2joPjygQG?=
 =?us-ascii?Q?tdtpqUPEJZ6P/ByYPTjzW8g7Cg2NXZbxHt6f7FoZtW+s4v8d1bCEvvlzeJSG?=
 =?us-ascii?Q?8b0q2/GbVIO7i+A1/0ncJp38iu9uLwxn+DU1eLSyPwRu7lPIR7aOfEEqgZeW?=
 =?us-ascii?Q?odnFINZxGLYML5NokVJzcJip26EArHyKhr9WpAu6n9Vpk1DKCcX+4BV4U3zR?=
 =?us-ascii?Q?W6pbZ6pFMr3+G0pXm8twkxaHcviPsa9fBkMdct6K6017EmbO1iCk0j9oKFF5?=
 =?us-ascii?Q?qPMb5BgoIqZucPD35B1R0wP/7hgJGzOkG2UjZf4v2BzrDU2KCX4pzxIGNN7D?=
 =?us-ascii?Q?G90TENw5vnK7TzLlTKL2fJGDmX3wkcxCyetxdSPE/tJvayVZ1hsN/0NTWECy?=
 =?us-ascii?Q?MjUYJ8nBeaMd8E4noTrFfloULbSpmR3+ibDEFPqanWNRFq6PC6H/WeRdoGhG?=
 =?us-ascii?Q?MgJNHHQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(7416011)(52116011)(376011)(1800799021)(38350700011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2EUXL+tQCtxLriLShi3lSAjQKFFPqz+placaSVm7irIBjX3c9hRC4VdrH1np?=
 =?us-ascii?Q?i1lplhY40KAevxgVo2RWC75EXRUkH7foJLkn7zGVpYNEHBCXTcdYPZDPLqZN?=
 =?us-ascii?Q?eV0GRLGBlroLfrw5UNNajFS7e/vS+vnKzMtWQKgNGuIDnv91HkIrytRXxVND?=
 =?us-ascii?Q?U9j6Xsy7i8zsx4D9BpyxRxdWIr0XgoVvxrbhG8uL8pmbQIvDJ/MT6qL4fiam?=
 =?us-ascii?Q?Z/vRFxpA0wWmSuV6oJM94m/wplwoQ25UEMdmzi9ccqkxSsmhZyuC3V0lnFEi?=
 =?us-ascii?Q?9Fye4UmnQk9wfEnmjGWoEZo1LkJJ/1L96Wu1NdK7eyY2zeLV5XhiZHExQo5S?=
 =?us-ascii?Q?DoXXOtEoQUBBDU16294wAYw/ZCPhYfjcDzcMHOEW0wvdZtV0++w9YmMy9pC2?=
 =?us-ascii?Q?Z/zGhv0LzjpwLklibvkOED7ht+lGcJ1hQZt00GIyxs2IOj3kH4XUWgAGq0Je?=
 =?us-ascii?Q?XYdxiWisFgxoz7IwgZorCnXKJ5wA94LqzvX7XSXoqHjP2p2lRoTg2+0smXax?=
 =?us-ascii?Q?9Tqwak8ZTS6Kn+C/mZjX5uSPE9OpmDg3WNDFPpw5hugrIGadeacwrfO6A8Zu?=
 =?us-ascii?Q?eiPYVW+jGUfXDW26QFvDnfDZsHcT7bIDI27xsMmWJBnysTGNGR9kGCNfUiNs?=
 =?us-ascii?Q?9d2+daYyp7NdO+Ra+6MK9niNjYQ4yAafog81PniAy4c+eHN/EqnpfeJetFlK?=
 =?us-ascii?Q?U/wOpxLAneZNBwgjKup8iYFzakwUTtPY6CjmcDX1VQSoNzPjHxpC70fLYnBt?=
 =?us-ascii?Q?IN6G07EO+pLYm1nqs0qs2kGYAY+AUPjXQqkXgtDXffE9WnKEFJXg7/RhmzB5?=
 =?us-ascii?Q?xqp+1ItYtS64fOQcnyHudAgt27muIym45o4H5tK1tbGtuATuLXmUYmq9mPN9?=
 =?us-ascii?Q?s7tTIDN0oZGxXOjLFMDZcOFNyk2p3LuI2rVDZiNCyFZuBgAO13Ix3EMKyV/8?=
 =?us-ascii?Q?2bd3zEcOywtRHY/Ea1+eENSbYzOjhSk/hHfQv0KyPHCohBjzQHf2+5z+OPZ5?=
 =?us-ascii?Q?93ngvfLEWHdcnmBz0thZborUOy6VTw6nGYJrz4Nkm5dWTfdsGKwBmsFkPo6W?=
 =?us-ascii?Q?eGTS2xjwOZ2TPSUj1xWuFuF840RGz1n1dkNBUukBefVdeQITuKYHvrjtr+8G?=
 =?us-ascii?Q?ArESOg0hKVfSsjTZY9W50A1DR5EeLiNEBtlEUjNQZ9Y/9Kx4OFnWB47vmhjJ?=
 =?us-ascii?Q?JLTXybP1B8MTPxNKYUry3sj/rp82uwyQewgQj9NRnFwmScT6k47uFPHXpwh1?=
 =?us-ascii?Q?Q2SZdYH5+BmC5ih+yBLQ8kdn4PozboQLbH6FIR/Cfe0dF8xnalS0pNo+gJOQ?=
 =?us-ascii?Q?0r3ST9pZRpHL5bbI0aIdlZG9AVJfAosdKtPc6rQEGxF3TOH+sZKVF5/xK2q8?=
 =?us-ascii?Q?gth6uyxwf67KtTUuDYpC/8m+jeZcgBJWU4gbauWVT532GvhNqVTQHQokPzTG?=
 =?us-ascii?Q?lsvtCoiOrio2KcdrdS+t7YTigYq0WcZShhAPf8FkbNIvu6pJivKGfh4CvVn5?=
 =?us-ascii?Q?UlRjkzRMYS3jbrDIxp5R11bw7MQBqkC9yy2c7HPcpm1NPnb8gUOtpdsQJvA3?=
 =?us-ascii?Q?KZJQnIM6LCWNfdWiMyuz/HqtebH9xs5zV1acTY2KaRyiQ5ei4to9u8gV0ttA?=
 =?us-ascii?Q?qw=3D=3D?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 220c957a-43a8-4d8d-ffa5-08dc8e763e36
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 02:36:08.3734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dVslC6rRc0Qy/oV9pNGZl1DavA2WsAgyVAEXBxgeze9mfE+W+0Z/JywGtgXb42BklWySZ1JNl67a8qatOiEZ2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB7044

Add Broadcom pci14e4 prefix for PCIe Wi-Fi module in dts.

Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index fbf47f0bacf1a..d0db6df57bfe5 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1112,6 +1112,8 @@ patternProperties:
     description: Parade Technologies Inc.
   "^parallax,.*":
     description: Parallax Inc.
+  "^pci14e4,.*":
+    description: Broadcom Corporation
   "^pda,.*":
     description: Precision Design Associates, Inc.
   "^pericom,.*":
-- 
2.34.1


