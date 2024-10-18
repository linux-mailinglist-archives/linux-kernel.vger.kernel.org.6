Return-Path: <linux-kernel+bounces-371317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 276639A3996
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 11:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B435B2517C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 09:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77767192D76;
	Fri, 18 Oct 2024 09:11:18 +0000 (UTC)
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01on2125.outbound.protection.outlook.com [40.107.222.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A669190058;
	Fri, 18 Oct 2024 09:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.222.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729242677; cv=fail; b=Uy7Cp6dyPG396iNyTiyMsrRUNgDlIua9gpl2pozbFRxNVy1aTD/m1ViErc5viVUZP6wsd/ItaOrJHobyMEkdNmQku5q1xfNz+aj3gUx8d0DYmb1cRMHIdAk4BsKtfoNz/YkSTFMVJl7qkVFFK2ytFPq/oDsu92+qicFnYRgRMRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729242677; c=relaxed/simple;
	bh=trVrpI9mAyH5HIHQU18bgCaeDV3E/clwshsjK+fW+j8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MIMYNcZSwCQk+i+98sK/H9qVfntt7uAUAdSlybho0vnmo6aXd5bFKOFMyWbR3L6opPCBF9e9ZPlWHOMjIWd2NRHUcZm2k9v1pPDuDYmsEYeZTTjkFccN6I/RIr8dyeFcBeGKXNBX/wDa9nUHiZxQ2wF4yMswQ7hAn6pE/r/u/hs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.222.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uzOpz/GrFBPSTNZGHhTpJ24KD04uHqRrr38QmqUDta11pzFQetID8FElICxifyUG88pqidDG7LLljoLtFUpSjJHNdEqnkk/84T3Z3KVhkYQCqAYvqe2dnMypY71I6e4K4hWnx4/r6gHcbYGe0D/TVJIWnitwsRAVDJi9D90KGmMcGbGV74y+sAQ6ogUOjGrKLnNojMUC/fu7rBI0Bjngh/+3GuMqUTX2JTK+xWsIIRGPUisijmlCguW1464CnbxvLSVZaS/aSTAm7Ud2Mor5tKvQV6OpVIJp8z4Wn4FPkWYDTSMJ+8CiAvRkLqYMZGrNixyKtO3+Y6w49w9GBpklfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/+yxUPiK2n3VRCUkckt2iypvZ2U4EOfe5koLX6n7u4=;
 b=RxY7beSe3/s2/Gzkc/nHBpXhfyPz/j/so+QMXTpGzAtGyneX6xHhr0lpyQe6lQki1ngAndl7UBAX4kdo/6YTHqTjvvgEeuP+iRlmhIILjz67eUkq+UejAa4gIfirsCKMng9HFl9f+H8/my+25T1BlPxtmIALRBckGqmvfmk1H8te0v/U2eUFVwxK9iCL9BHWI8r58VWXdSSeR3mn76MkO/ixckqUx0btbuv0ghcBkttK0n5sQoYgE+GmIznAMklCEFNKGDVOScTjL7ekQhop2VY8qKJ5RURLJFkri9m8iRM86EFKyvq4crmrZJeTujcJQmNT+ixAa+q9SeH1uePI1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from PN3P287MB1171.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1a1::5)
 by PN2P287MB0738.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:f5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Fri, 18 Oct
 2024 09:11:12 +0000
Received: from PN3P287MB1171.INDP287.PROD.OUTLOOK.COM
 ([fe80::12a8:c951:3e4b:5a8a]) by PN3P287MB1171.INDP287.PROD.OUTLOOK.COM
 ([fe80::12a8:c951:3e4b:5a8a%4]) with mapi id 15.20.8069.020; Fri, 18 Oct 2024
 09:11:12 +0000
From: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
To: shawnguo@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org
Cc: Bhavin Sharma <bhavin.sharma@siliconsignals.io>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Peng Fan <peng.fan@nxp.com>,
	Hiago De Franco <hiago.franco@toradex.com>,
	Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Mathieu Othacehe <m.othacehe@gmail.com>,
	Michael Walle <mwalle@kernel.org>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Max Merchel <Max.Merchel@ew.tq-group.com>,
	Tim Harvey <tharvey@gateworks.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] dt-bindings: arm: fsl: Add Boundary Device Nitrogen8MP Universal SMARC Carrier Board
Date: Fri, 18 Oct 2024 14:39:28 +0530
Message-ID: <20241018091023.29286-3-bhavin.sharma@siliconsignals.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241018091023.29286-1-bhavin.sharma@siliconsignals.io>
References: <20241018091023.29286-1-bhavin.sharma@siliconsignals.io>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN3PR01CA0143.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::7) To PN3P287MB1171.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:1a1::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3P287MB1171:EE_|PN2P287MB0738:EE_
X-MS-Office365-Filtering-Correlation-Id: 35341440-f2d3-4c33-3803-08dcef54cff7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4n7EvCttGN+b8DxjALZkHMVguJx6tiXmZaBWxKUrV73FY/NL1VT090Ptkr2Z?=
 =?us-ascii?Q?NW/vjkwyu/N9WuDu0QMBMsRkoN1uCGVRrj3nN4aScxE05g/1WnrJItet18gj?=
 =?us-ascii?Q?XLXmNNdi9t+mynT+6e2SPF189j8g3wd+BIKPiiUcxtS1Ln/2vG3kTodt76yT?=
 =?us-ascii?Q?cUBMfhQ0vqu1zoVF4Ur5wqiARDCd4BfQ5k0iAi4AM8NVR7M/ppOGy7jUZyIg?=
 =?us-ascii?Q?HanqWplAnwTnFaWvZ9fnOIpe1TkwBHfsuCesqJH4sgqTUJhwNPigNT/ZMNcO?=
 =?us-ascii?Q?N7c1ZYaCklYgKNAyw6uTe3YkvEEw+Dta8jCK5FutW5hqBF990Qft65dBILos?=
 =?us-ascii?Q?0tY564dYxakCKD9L5d+jPiobD2QdgaIjgTnVwoeNDmx+4RK1KQLDRxugj8wE?=
 =?us-ascii?Q?9Q6ANWWgus0YTUx5PM7kAHBKt64CgrXCDun5cLgCjv7VLA2EaCdARDm30KRQ?=
 =?us-ascii?Q?XIu1e/GyLz+ChK2naTUSvX/L3KMTxYY8c+MWTTbmHQzRTYU0gaS9r0uUI/ds?=
 =?us-ascii?Q?Ha3luGVimrDtb4Us1X2/fxFlcIdtIAW0v6TfBFQyMxYTCugPQMDpZJ2lJQlW?=
 =?us-ascii?Q?bNMPtBO5lCS/wGtShMyokJWcT75fbpBgTrh1GKHP3wj4KNy1UKRgDav6XQ7s?=
 =?us-ascii?Q?lMTmckhHSogSgIC8XgmFNfFBRFAKknHPZ+l2MF2ukd4tSvFBMZO4cFO7+9nI?=
 =?us-ascii?Q?ogwUfbWpege+Orf8Hsy8u191JhjbcJUp5OiBzKKzV03ZFILdEaWDtiSc572r?=
 =?us-ascii?Q?69y040xz7zuzHUX+IaYya4bheOwhABZB2RvPr+HJaYfHxU0K4LqMA6jfqXke?=
 =?us-ascii?Q?ruLggL/mooQVXORzucle0Mnv/M1TJM11sTOpY8muUgV6i4RdaFUoFH6I1GYO?=
 =?us-ascii?Q?vI+dK1Kr0fZnTp+NvdrdRNV3ip5CfpfaZJ1uwMJtJD6lfXHHWXTeqcFPkQf1?=
 =?us-ascii?Q?n6b/HomjmZjt9RQrTVUUotJtsll6ZCXSDWbHpFDhA3ERtxyJ9LByToPLL2cd?=
 =?us-ascii?Q?kq3M2r6f9IrGYenbG9FOTBixvUkyrZTMsSVg1xFVQ0F2SxqXVanBPoCYqc27?=
 =?us-ascii?Q?wdyTBah6bRCyflvBP3cfSlc/3iz4zDbWOshiXZrgaYUd4en4qfdx9hi1Jaxj?=
 =?us-ascii?Q?jN0HFBabD1r/b7GjjmrY7Iioya+lDZre7zGxKVm5FR2DRSY+Cd5+EKjwqEwK?=
 =?us-ascii?Q?ppkQgSvJSfHLLH/xDOr30NxCJAlmfdylgGwENsbHv1D11Su3fCj6ze5+fXdI?=
 =?us-ascii?Q?kQ+3JxQZEtN5S048VMPt6sUcui7jvOHu1tuTfxvcTC5QS/EBfcoDIG4gxx8w?=
 =?us-ascii?Q?8nd6M2CwXgPRSL74fh0CV8C7bX/ocgYWA1LQKkn/A8yeNMBjuWpKgzEZiAR4?=
 =?us-ascii?Q?SqgBImA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN3P287MB1171.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7ots0jAGF/9A/XOLuchqXXPQfUBQZc54yM3CzH6KbHPZU1E+GayJW1+JxdON?=
 =?us-ascii?Q?xv05gH8lgauCm91yLbqcdSPia2uH35CqLWNzykMGJzr/pPAs/q/vLyz1RUkU?=
 =?us-ascii?Q?2IhZSc/O9zEFwnR/6tC+EgBjx0w2nEugxcSpYkwEZblH1FVXzcQ4uRTvhxZO?=
 =?us-ascii?Q?66CBcpIO2W4GZIO9Hng9PLIH3k7z9Te0i8JGL5NNyZPe6xbF6txLNiEk1bf0?=
 =?us-ascii?Q?0AMhh0ccC9eeBLlP1u8G0X+VaPjSsf/1QRJkgt2KN6J8LcFFTsuBw2/f7QnI?=
 =?us-ascii?Q?M/xytGF/H8Zrl4DKtlCj30injFb8pClc9at5ve/21fNt3lCRIOkFgzktSRzJ?=
 =?us-ascii?Q?o9W1UMlMqpn4wZWjrsAHvPkdiW5BFThjPFC9otdt07XLE8RUB+Q0IGTu1mrd?=
 =?us-ascii?Q?vCNOP7J66A68OHdu1Pinp1MRNzkherxKzpnCnRBIQvn7EqO6B65KNm98SBYi?=
 =?us-ascii?Q?b5q3Qai2BS0yBnp7/nao7G9Y3TBotRbaokIeIqqecoj5qN5tX82c8nWzkHeS?=
 =?us-ascii?Q?qCebzei/q8Llrvssuvta8MKd20JfoSdXAyBtz1wZLI05IU5NkoZFj21K7vuw?=
 =?us-ascii?Q?jo/u9w+6oleuMqa1xSU+vdJrl8evt6S85QB9gLNcXDBJqxBPv/DbN7mIHnAM?=
 =?us-ascii?Q?cXN1fSoDV9prSJ8HGFrY4kw7osQUNu7B8TfVc2+9bnwpby3+WcADGYTxfpSm?=
 =?us-ascii?Q?8pnwK5wXy+xR83azFAJwsvKg0GqWzsHwZGZNoCENy/+EyjhwNttTbn9pKPTk?=
 =?us-ascii?Q?+3Ujz4xDHFPdn7aYXZAsw/3nNoX9HZh23zfYNTUtBDwi45P38u53u8OSvZzj?=
 =?us-ascii?Q?LH3JFYYqNSdesP0zixGeKp7S1lY6U0HFx4N3eOPqEeL39ifUuZtIMhuHfydx?=
 =?us-ascii?Q?Psv5pEIFD8piRBhZCkH1MFljvz2lDrK3hksLTMC5uk5tO3aCAwfDTJuZm86c?=
 =?us-ascii?Q?Tsj1XNuJeK4mo8CzNHMAxloQLMtR8JXEMLU8FT7jmH9ehl14csdxDV0ojRlC?=
 =?us-ascii?Q?YdUwL4SIyzcg4dVGky9gcBM39tM972uCRgyf+ipaUzUfZIlmBb8nlsF9f57B?=
 =?us-ascii?Q?2i3/ITGSs9z7fGrc9eYBKoY2v31S0rHYHuF82kug1c/qmL9KXmNz2+Zgid8t?=
 =?us-ascii?Q?cnwcneDgdZJaN6hUSJpRhyOK+yRb5OKirUUDNpuYh20yZNQPNJMDPtUlWOtB?=
 =?us-ascii?Q?eFCx+Na3fOxDm7fSbfS9V4prO2PzhrFgSZnkhj2k6HMC11AHSmc1ReZZNZnz?=
 =?us-ascii?Q?fNdErrk9EByMrjZDFwMaHSpz2+4wbFv4swusMBI/HO8jiQHBEKiwmDBJklhF?=
 =?us-ascii?Q?IbAIN/HT4XhWwlEpuFH+7fSyKMAlrWroMLjPl1IEsa191bpgGzvdDIeDf1GC?=
 =?us-ascii?Q?8i3lu7BTpg4DWulPNYh7xoWDdghFtqT5dpWMCPwtKau1N591h/sKFgevmhUa?=
 =?us-ascii?Q?eIHsTwqhhjL9dmXS0wl6+hJn2EVrIakZzKEcgjK+BD09uUSGJ76hhJvD7cC7?=
 =?us-ascii?Q?ywytKszgqjqTs4wktZBBRCOGjAim4bebnzcEtN2zZ/w7poRmwpHpylOLqX7d?=
 =?us-ascii?Q?g2kX0Vf6z4tfX4VK5sY5cu+mLZWeQNeb9Ymrmc1BXEZiLQcY2LHCwb1RIb+2?=
 =?us-ascii?Q?om+iYp+2Tkr75QAeNuXnt2g=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 35341440-f2d3-4c33-3803-08dcef54cff7
X-MS-Exchange-CrossTenant-AuthSource: PN3P287MB1171.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 09:11:12.5921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rzoQ1mom5mixveBd6aElmvT78BNjr8Tb0eZ2rNwlKtaEsTPbklJE7nOSxbELCvgBGz1T80gHDD2AccCyV2PN73h0oq5ufs4zy4CjpujDCV8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB0738

Adds support for the Nitrogen8MP SMARC System on Module and
the Nitrogen8MP Universal SMARC Carrier Board.

Signed-off-by: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index b39a7e031177..58979c030519 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1097,6 +1097,12 @@ properties:
           - const: avnet,sm2s-imx8mp              # SM2S-IMX8PLUS SoM
           - const: fsl,imx8mp
 
+      - description: Boundary Device Nitrogen8MP Universal SMARC Carrier Board
+        items:
+          - const: boundary,imx8mp-nitrogen-smarc-universal-board
+          - const: boundary,imx8mp-nitrogen-smarc-som
+          - const: fsl,imx8mp
+
       - description: i.MX8MP DHCOM based Boards
         items:
           - enum:
-- 
2.43.0


