Return-Path: <linux-kernel+bounces-377731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DAD9AC333
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 11:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2522C1F2432D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 09:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81DF17B51A;
	Wed, 23 Oct 2024 09:13:09 +0000 (UTC)
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01on2112.outbound.protection.outlook.com [40.107.239.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B6817BEB8;
	Wed, 23 Oct 2024 09:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.239.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729674789; cv=fail; b=YW764ABeyGJ0hLlJIA8aDJRJ2nYTAOhGnIy4HmU5JlGEq1WJahOi2hNT7N57wFPyXg3ICt/a7kLJNpBZOhUI6XgeEWuCdkva/7Lb3SXBAW0lOht8/MdOkp1LrTSofBJQJNXXn6JhyD3kxu3edDawGSwN67FmzdF9FuiNmMvzLGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729674789; c=relaxed/simple;
	bh=Q3ekbevtguKrMLZvpwVb2lmRzCmhIsGdvIi5GBTdHtU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=YUnrE2UuoH8OAhy3SVqny5pFumky79u8eu+frZHCxoFT6qa9jvYL2xHDAEOhOP29YLwfsAYAXvTVXzpRu/ZnDcEQpNRj9lHJ6v5v+5zxYfhA0QCI7g7Q3mq1gU53ozLwFKcI5nfgqNpqtRRmsUoB/Irg6q9QP2fJ/NMb1RBQ9Cc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.239.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MZ64wUCj3MmQxlcMMmhM9pXI7+X1k5ZrZahG9HD+Gynne0KCVxf0CnEwBlRxvUy5ewuJ18Md8KZ4SmYSGSHOsfibjpMYOCk6kei7pYHRfBBtxaq5Nf5VrrtUA+TSGH/eE0We1CR7Emn3NWUQ5nCT3M78TiqJ18v88mocHh07QY0QhEsKV1DH0JHQvhjq49xD2/1hXisEDA1g+TmCMTc+L1EdDsWIWFdNSqUcmizChE9ZAyt6jOFG4Z8veBbE1+FvNG4XRqMDIZopphQ0RwE3zzI61Jbk2GoiRVj80rJBphaiahTF9fhOUkuaQLI2g1ZPGXO/VmIc1lTp3ZI/QEU8sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gZH+rif0kKRsM34iFZf3VnAhz4oLAlC2r6iRuaqw6Ns=;
 b=DTzUuMVVDikd98Pf6TfuxM+sZ9qn/ZtV9suTLUm+ii059qaeHF6J9q/kFDTqm54ITEXbwJvUmQ+aAJSZaJY2YK2oRzaKZb9KL1Y6fn3pjTWth5/QSfhQYgI6Sbq/qzKvSocgUMDZY9TZfNtEyEorrglEdjmfFw81PpymvnJ0/K9RJv+U70NGeRpU40cEAyymB27vhn5Vuri/Ln7Z/bHvjkM7D+xO1wtlgPG1qHCyS4yT+QPabZ1QIgBW/+6TH8VVDZBJSpbPTg6KMkIG4gMxabU0zv8gUbAlNSm+IKEGL/rNoE0WN84L89p+JeKvVCt4O6IBJlDIbQjGz7pgiM5iRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from PN3P287MB1171.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1a1::5)
 by PN2PPFDCD372071.INDP287.PROD.OUTLOOK.COM (2603:1096:c04:1::153) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Wed, 23 Oct
 2024 09:13:03 +0000
Received: from PN3P287MB1171.INDP287.PROD.OUTLOOK.COM
 ([fe80::12a8:c951:3e4b:5a8a]) by PN3P287MB1171.INDP287.PROD.OUTLOOK.COM
 ([fe80::12a8:c951:3e4b:5a8a%4]) with mapi id 15.20.8069.027; Wed, 23 Oct 2024
 09:13:03 +0000
From: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
To: shawnguo@kernel.org
Cc: Bhavin Sharma <bhavin.sharma@siliconsignals.io>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Peng Fan <peng.fan@nxp.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Hiago De Franco <hiago.franco@toradex.com>,
	Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Mathieu Othacehe <m.othacehe@gmail.com>,
	Michael Walle <mwalle@kernel.org>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Parthiban Nallathambi <parthiban@linumiz.com>,
	Max Merchel <Max.Merchel@ew.tq-group.com>,
	Tim Harvey <tharvey@gateworks.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 0/2] Add support Boundary Device Nitrogen8MP Universal SMARC Carrier Board 
Date: Wed, 23 Oct 2024 14:41:13 +0530
Message-ID: <20241023091231.10050-1-bhavin.sharma@siliconsignals.io>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PEPF000001B4.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::6) To PN3P287MB1171.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:1a1::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3P287MB1171:EE_|PN2PPFDCD372071:EE_
X-MS-Office365-Filtering-Correlation-Id: e2fd8d60-faab-4024-118f-08dcf342e608
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Jm7KRZFYtyBFw9n1JQGjDUiggz8cQVdLUc8PxrjR4wFOx4Cft1EXTDNt0nUz?=
 =?us-ascii?Q?o/G1t7NmwwJFNPo8FbWF+qmAPkIG7T0l3w9gHUkc/coYlyJ/fXcUThWn0uYX?=
 =?us-ascii?Q?iJBT4duXTb3N1Fx2gXznaCcJ1vU5VOhF+TvixiS0aveVHjlzMdwYS6ouaKPo?=
 =?us-ascii?Q?Bczi1VkT53z4R+490jpviFNFBZqRrN1dI/MIOnbfqYYjhGd2ixfXa/egBsKn?=
 =?us-ascii?Q?FlFLDIG31BOxlJ2oxVrbPybblhilbH7S14qJUoKMZdQ7ph/bCdj7MHOWCVUF?=
 =?us-ascii?Q?WID8JPomctNyIFVninEp2n9lSnlWCohha5hcbLAfov6x1fY3Y9s8AJZdMkza?=
 =?us-ascii?Q?g2mT53VFMMDFzaZbOnugjZJ3oNGGmhHqAGjFe9XjMfp4rJDdiYCOGHhVW+Yi?=
 =?us-ascii?Q?xNpsU+vWfOcniHQAIR0hFSz9b9rRY4j0arDbhd9Taa+KFcZK+sEmr7dKVTAb?=
 =?us-ascii?Q?si4O6wE1hB9iZBRcBGih7hcpQBy3gPiM17YAIbAXxEdQXAYcgFOQzl4Z2Cop?=
 =?us-ascii?Q?eIGh1XiyVYiORBRrSjsL70AFF/DSg3fQX/HUMwSRXJmrxhHl+lXJ8bGSjCvr?=
 =?us-ascii?Q?7XOpgTmMcORomDXDJ6/7daxnl/0DruuLboIBPc7g1YKXH6iQAUVF+3uXnpEo?=
 =?us-ascii?Q?NSWkw1DYrsffQMK7OgUcnu9otUTy8574HPNHBQmyYCHxMwZPtVAzgDO8i24c?=
 =?us-ascii?Q?QbPoVqlAYsuf1Otp61iKyf9By4s0AawSr+89VvHzVAWSZupy6quIozfW8Y8y?=
 =?us-ascii?Q?6mPsyfixVdwfxzfXASC/aTcRCGe+s44UP9v4XwmkEcy6Qk3ko9oHS33gp6EX?=
 =?us-ascii?Q?W5Xh6P5SLFVpQOkFmZf/co7+/Ahvl75rahN8d/0ndOGPBEQnAZ/nya85SeXN?=
 =?us-ascii?Q?wTSamTAQGbmTQmspCYEAsqGS34JXziFLedE/ofUhJHfHFy0VpMuzLInZlJUj?=
 =?us-ascii?Q?XbIyA7uPL5OmxEmZlC51r6eGvskMVyNc6hB+Nk/Zes4SUoP+lqZ1qUV4IpsY?=
 =?us-ascii?Q?lIeewBOVXz0pjhwhpzurDC7BUHLgAQUtQu0Xgbm+9xjHswLx36Cqb12mrOKt?=
 =?us-ascii?Q?O6BcjWQxiCbyP4SwfOi5t5iUxdSTNdcLi/c/cf8dltw9aMD2yJTGL3lev0GD?=
 =?us-ascii?Q?wN4CByd51Uc5zRMGySZnaH1hdti2pQZgUQzUT+QE0wlMoHrNrXjLDXkzVQbl?=
 =?us-ascii?Q?tk70YtS1B8ICbb59YqpRypTav8dZQfn7IJ3NRRrdZyiY6+j7x/f2PdGvMAwI?=
 =?us-ascii?Q?Y3nedv0lxnT3WCbSaaSW6V3WvizKL1dHUULOpS0J8oQ3s7+WTHUA/55hLm/Q?=
 =?us-ascii?Q?TojjRtjhjxknZi6EaREPzUC/ptRLgTNIuuiYNPgGT8srHmbS1HD9j9hoPeFf?=
 =?us-ascii?Q?uq9dT2g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN3P287MB1171.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ca05jao7i0NPfT1xQU5sOtHtWx8yO4hJd01IG7GeT1P1uLOpo2kCEGOm9Fts?=
 =?us-ascii?Q?fIT19NvyPa4ZNeQGXgoF5PJ9Kmn7d2Nerk7RJXzmrbkgqoAO8zb0S3k+lExU?=
 =?us-ascii?Q?76AvYDjDOPktNxw94wtSVsORiIAyAT9l8lJ8bEaQMOx0u8/Frtll5q4DZ/F+?=
 =?us-ascii?Q?Q8Ne1zeH5NaeGrA8+eRgaZnUudWxMffhklmkmjCIht6Jw8FOVx+48dqjat5+?=
 =?us-ascii?Q?OtEBnE5d8ljZPHUfbVMo7Ae81VzwbR7hysSQ9PxXNrAOTox4zpG+7BWpafE/?=
 =?us-ascii?Q?wJ4PgHHvdA6W5mPgbe7OEmlhNRDt4Hof/PI3A043QNXeKYCVep3r7a1Wj9Cv?=
 =?us-ascii?Q?0MnjaGDYsy6smEQDOno5Ye6phfkxZGz0AQAAkJYrxHq1MBiaZ+Xstxr9OHYR?=
 =?us-ascii?Q?WbGNJXwbv9NfwOwm4y5KRrCuH1ViWzMz770draCEQiKVj6jiDYGauVCoskuH?=
 =?us-ascii?Q?098lm9/P+lyZulQ2afcjkMX2c4mV3nUxco2S/ceS2jwF59yKV5L6SRcYNtbw?=
 =?us-ascii?Q?AN9VtUsMBQfbDgT1WVe2USYGUg4zbvcOpNEuUDyXcjPN895BTtmqVBTIG+X4?=
 =?us-ascii?Q?N4L+NUrM2n4BrPh4vPJGuT38OYs2GjklBsRPBprmzyZqic2UnLo0puT5HWwZ?=
 =?us-ascii?Q?EMvSPTTXSUubAsNmMjVYPEeuw2hNKtTrc2U3zDhrSJ92xfSVrQsJPRcfSLvS?=
 =?us-ascii?Q?0RpMszW0oUx60gGv4utZWsd3+6kORVIeCQhPVesQzHHVT8Ebs53TS7OUEwJF?=
 =?us-ascii?Q?P7jROsQaM1fjtD4gGfbi3F89FNU3bbhcedj0S0B2QG2Pv48UFefsyQFTCFR4?=
 =?us-ascii?Q?3AwbVeBGa+A8qaaZ0Duv2pFXoFVaWVKNG1OCklwUavGE0sdk289A/dtHFfy/?=
 =?us-ascii?Q?rpkPmxFRzZymnEbJSZlSqsf7oYCXlfHeSnpHxR3AUXAGXhPuXsWSFT3CAVZp?=
 =?us-ascii?Q?/fcDNOvF6P5Z8FBTYU5piU1mL9PfD5b0WTj4m5TnLmisDUyVP4t3K6DiH/j8?=
 =?us-ascii?Q?Fhpm8mqs9YYgPLTXusTt86446q3hHP2gezwPvSDMKgcW3+wnzCp4miWLWHY+?=
 =?us-ascii?Q?JMZX+EPcYtylwQdBlCvQCBLQG6ScLp5c3IdEtpN0Kw81oFvnr5+M2rcmsrz6?=
 =?us-ascii?Q?W8XDLvsFF4VWioOAIzZiOQrxpf/c6ICIUmrbCPADng1Awzg8YsZ/dmBsNOuy?=
 =?us-ascii?Q?V1M/ByCvSimutonPM1B1eBkHo6OfvrmosxH3TLaTSD/EHQox3QgNFwaqGKI1?=
 =?us-ascii?Q?BRqfZEBnTS71qy0pWzSrOXCfDEh2XpcHt/vwvEv7Vrgot2BfDXJTVvLmEGe4?=
 =?us-ascii?Q?A5hy4cIDvlUDlD0Si6HRqyPDYPmfmtn7uykYpUVi9QQ6VFg6c0VpjEl6Hz9k?=
 =?us-ascii?Q?2Fnnnd/li7ZpB0p55zXkgVAisdqqZN5UHlkZtRv1PIfrQEpGQZu+QnHgEPt7?=
 =?us-ascii?Q?4p8a2XEQJej9g85rMFN+JTJ1+RT6RFlI/fhdrVzEmeshhgFdT6iR7DkTYSO7?=
 =?us-ascii?Q?TY0vgKiTpqSKF/simhuZNe7L+GIc296yEPTW6EdKSM+qDANiYS9mjVMRS+0R?=
 =?us-ascii?Q?ys2z7aFYzMPtexkq03XozUmcwQM1/KgKcymCB9wobpgWFxxCv75whAgDA/z1?=
 =?us-ascii?Q?en/jyNogffkctOam+B7JHLM=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: e2fd8d60-faab-4024-118f-08dcf342e608
X-MS-Exchange-CrossTenant-AuthSource: PN3P287MB1171.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 09:13:03.3362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CwfwB2icZgOXA3AzrM5zJf4KIUVHJGeAOUdEf1vBRMc994jvSkt+mL4lwNOUHEumQRg6YGs3ZofAIuwK8XokIjVqMm5nR4KlirHmU/tqWSg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PPFDCD372071

Add initial support for Nitrogen8MP Universal SMARC Carrier Board with
Nitrogen8MP SMARC System on Module.

Change in V2:

in patch 1/2:
        - Drop Unneeded line
        - Correct the indentation

in patch 2/2:
        - Add Acked-by tag

CHange in V3:

in patch 1/2:
	- In version 2, I forgot to add the Makefile. Adding it now.

Bhavin Sharma (2):
  arm64: dts: imx8mp: Add Boundary Device Nitrogen8MP Universal SMARC
    Carrier Board
  dt-bindings: arm: fsl: Add Boundary Device Nitrogen8MP Universal SMARC
    Carrier Board

 .../devicetree/bindings/arm/fsl.yaml          |   6 +
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../freescale/imx8mp-nitrogen-smarc-som.dtsi  | 348 ++++++++++++++++++
 .../imx8mp-nitrogen-smarc-universal-board.dts |  17 +
 4 files changed, 372 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-nitrogen-smarc-som.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-nitrogen-smarc-universal-board.dts

-- 
2.43.0


