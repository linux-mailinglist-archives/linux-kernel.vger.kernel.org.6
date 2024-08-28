Return-Path: <linux-kernel+bounces-304567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE589621EC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F2D61C23C4E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 07:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5317915B0F1;
	Wed, 28 Aug 2024 07:59:08 +0000 (UTC)
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2103.outbound.protection.outlook.com [40.107.215.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162A6156661;
	Wed, 28 Aug 2024 07:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724831947; cv=fail; b=TRKC9Dku6Ovli1LAxC9t8bA0Db3Ac0ZupVotlsyKC1iTp+k10csReEyx9JZ8CT13NLmhs7SzlmFV0LWKl3gfTjx3FCgVLWrACKLfrGG7CCjJQW5juDnLxFY5WJ59lPrKh1zUnqM4zoyBFo8c72PVKbtkFBpMWyYLqffzcrEKfqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724831947; c=relaxed/simple;
	bh=KW5MeIG/M5nvcsKi414Zrtbcsoco1mY3Ri3vJRZ5wRk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=M+E+DJuBjlE1D8MueFEZzI0Mb1YNPjKg4km8jT1jI5b7M/epDzQsz9kLmSS1G5nlR5npspBeF0NA6fW0WtyDzfZWZf4GXXzcOpXJkIPNDbaYXQOGvburuTigb+DM59yXsWqmT8Ex3D0s+FxXFpt1uXi1DjTeJNI8GbbJShFYWyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.215.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R1Zs4uY5LA8RPl6IOXdoywYkSLTteTuFPIX4BvNt2GP5S0v+RnXFuLjvep5QhgbHRGSYPFWeQVxTFKrJK8zdW/lfxvhdtbm3WZw2iGW0h+H/0vL1HskiVihSibJnuzOHh3Rqrk4JsV6NZqgu+Nm2Ov6iFBJRysMnLOzFVleNfk9407+tPH+ubqwDrBxI8kUYhvt8gA7/OMuJxg9hJO6iniwpPrGzBjlXatgFf1cHdPhjX2XsjMp4txZ9nQrXn5nNSeDGdYSAVWYRjnEuQw0SqsU2/C4NE6q5QIUoPbQO0Oj2nlhGM/Sp014ToV/zQ4o3q8hz80MEM8wcgYhzmGIVwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ehvlQURtyKhPbgpC86U5gspzkOdWuy/BF52NJA+Rqs=;
 b=gbDzDbqcSPRVe6KYMNyksYieJurczyHW2TSbugO0q+eRo4Ze9g6KXLxFAwWgqkhfcLlwa0UTSOEtY2dFp+EOIpyuv8hDBWzKWjpsCz16+QCwFO6aT6Wysxpu8riHwibvqaYhrGQX+5WxEqEXS+/jtJlbXhJQZ1JKbZR++OfArb1TwVlrv3Tswf+P5tnV5VLU2ZQU7AGC1MdZmFFrqijtIJvKgs6oDuPyC0sg109DIdPiuRQ5xeRwrTbaorBKYSR0vWwBGSobeRWlJIRwd2+DjTJhHVPfAvdBmeO2GTZZZc52qBULjbBz6btgUJAIyiIk5HZ/1RzJNwszMXQva2ZBCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by SEYPR03MB8765.apcprd03.prod.outlook.com (2603:1096:101:20e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Wed, 28 Aug
 2024 07:59:01 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%4]) with mapi id 15.20.7875.019; Wed, 28 Aug 2024
 07:59:01 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
Date: Wed, 28 Aug 2024 15:58:49 +0800
Subject: [PATCH v12 1/2] arm64: dts: rockchip: Add AP6275P wireless support
 to Khadas Edge 2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240828-dts-v12-1-80b6f240f67f@wesion.com>
References: <20240828-dts-v12-0-80b6f240f67f@wesion.com>
In-Reply-To: <20240828-dts-v12-0-80b6f240f67f@wesion.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 asahi@lists.linux.dev, Jacobe Zang <jacobe.zang@wesion.com>, 
 Muhammed Efe Cetin <efectn@protonmail.com>, 
 Arend van Spriel <arend.vanspriel@broadcom.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724831937; l=1327;
 i=jacobe.zang@wesion.com; s=20240828; h=from:subject:message-id;
 bh=KW5MeIG/M5nvcsKi414Zrtbcsoco1mY3Ri3vJRZ5wRk=;
 b=MQ6ukrQzR8gsNw1eL9p0HxaWTQ2FtHmyCsE6VvJzn4ZOpCfCtT1duaaBKacW9dUisxEzbZy4/
 9e0031Bms5uCPCawEQ67KNK7YIywV9MN5J9/ECoB0WnICzrlVbfzlbK
X-Developer-Key: i=jacobe.zang@wesion.com; a=ed25519;
 pk=CkP5TjIqHSwHJwZXTGtadoXZucYvakXcO3HjbR6FoeU=
X-ClientProxiedBy: SG2PR04CA0187.apcprd04.prod.outlook.com
 (2603:1096:4:14::25) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|SEYPR03MB8765:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d42a038-3839-4337-32ec-08dcc7374795
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UlptMkhwYnREUkNXbUNQdUFjcEJSdGhDSGFnSlFPVHJObXpFUzBnZnIxUmpk?=
 =?utf-8?B?V0tZRStjMEhXR1ZPdmVRajZITGNPbWZPVVc2UGgzeldXekhyVW83L3RUa1Av?=
 =?utf-8?B?T3plaXhpTExZOE1TZ1g5RnVZS3FEWW04UUNDUm0wVHd3SUxQazNDb2lvOHVV?=
 =?utf-8?B?LzNWUE5qZzdCaFVNVnJHem51dnNSR3RFRms3VUVrMDVMSGU0c2liei9kRnBV?=
 =?utf-8?B?bDB2OUtsOG9DYUIzRjREeXI0V29udWlkbmZkTTBNZnJHeGsyNkkrai9obkdo?=
 =?utf-8?B?Y2NVTi9tdFRjMzVna1VrbDJud2k1cktrdXh3WTRLM0I1dElZQk5vVSsyUkFE?=
 =?utf-8?B?TUVvbnpaK21ENWQrSE1SYkVOOERaOEhvZHVSMWRqM05qTTk3MjU3eVAvWW15?=
 =?utf-8?B?dDJDMmozL1VKUldTSFJtMGE4TXR0dmRIa01pZ0ZweWxacHF4aE53VDdEelpR?=
 =?utf-8?B?WmJmZys5WCtLbXhjU0EvbWpXSTI1TWFGRVg3TmZ4RE1rSG01aXVRcDl0TURR?=
 =?utf-8?B?VWpLR3B2aVJHY0VudC9sY08wZVBOeHFkaG5PSDR6bzdYaE4xUVZmVE5DYmFQ?=
 =?utf-8?B?dW1aYTEzdEtiQ3QwMnhsNEc2ZENDQm1XTDJPL083UGVYMUw2RzlIelM5eWxB?=
 =?utf-8?B?U2pNYkE0c3Vsb0FGYlVFb2R0V3c5RGF3d0tQaDNEVktjZk03ZWFxL0k1dWF3?=
 =?utf-8?B?VlVDOFZ3Ris5TWRXcW9wU3R1V1ZvZmNxekpYdDdYVk43NG9jOTlBNTYweC9s?=
 =?utf-8?B?c3Q4dFRiQi8wMXdFUUJoZGh1a2RWazZVSjVra0lDNFZnY1VLQVptdzhFQTk0?=
 =?utf-8?B?RHdHNDdpK2JZekp3OWllMDN1eWRuZFFGVmN4QzFObWpyWE12dWFPeEFrTEs1?=
 =?utf-8?B?TVFQZXNnVkd6c1FKZ21WMDBjbEZpcWt4VktSQXlUS2d2MEMzMnBPRVVodmRR?=
 =?utf-8?B?MkV4N2ozNEpyZmJDaHgyS1BqYnRuaUNid0hkVklFS1BBREhVWTV2YTE2ZlpT?=
 =?utf-8?B?TkJiRnlvZExvVXk0QjhOR2tFdFVLY3dsSUZEaHh5eWlmMFFwRlIvQlhCeFU0?=
 =?utf-8?B?b2EyeGM3MVJCdzdWNTlRVzBjVVI5Yk43b3M5am9tenNiRUJxVGpVSTJNckw3?=
 =?utf-8?B?enMzQk9BVnpXcDVzMzJHZTdyVCs2SzdaN01HYm9DcGxjQkNaamhobzU1VXM2?=
 =?utf-8?B?THh5S1c2T1R4ZDlVcmJBblZ6Tm5pVU1HRzhWUTNacjR1RFFMSVJ2YzFBTkE2?=
 =?utf-8?B?bi9FQ2dSZWtQMlpLRG9CVkVrSnc0ZitNOTl2N2Y2Nk96eVZHSVlUS00xbDJ4?=
 =?utf-8?B?aDJRYVBwYnErUkxhb1ZpT3N4R01YdGZNRSswV3ZuMkhSRHY3a2xNcFJXMGdo?=
 =?utf-8?B?djhwRm9wU0JhcXpjdkUvaXhIdmxqQW9hallwS3VTQ3BzY2FCSHByR2xCNWdz?=
 =?utf-8?B?dWdwMC9PNWgyYWNpUTZWSEFSMFRZd3RSMFlYNFEwUGJoUFB3aGFEK3pVSjlI?=
 =?utf-8?B?cHdjR0M0RGExWmlxdlg2d0tqVUtzT0tXdC9IejRLOEpPWjJVZWRTVVhVY3p0?=
 =?utf-8?B?dVl4RU8yL1lPYm9XVFZ3VXpWWEtsSzRzQlNoNnRGdUlmSUpjMGI4ZDhXbndT?=
 =?utf-8?B?S05ZZ0NyU0xzZlA3TjNiSWJycVg5V2ZCbUVBYXNZZkdmaExZbGY0WFhIYUFx?=
 =?utf-8?B?WHFDbnhJMmpldWIzMHZRNFI2RHlKU1NvRUVJM1kxTGJCYnA0UFhRWUZBMUpn?=
 =?utf-8?B?YnZlZ2w3VGQzRkthVUdwMFZSQmlJSFE0MjlmeVF4WDh1Zy9Rb1didUlKU0Vx?=
 =?utf-8?B?ejUyQ3FkUG0rMTVGcVpHSk1oM1pMSU84eVdrN0I4bUJxdkV5QS9DQjRoOUcv?=
 =?utf-8?B?TG1UeWV2aW9UZ0d0ZEJ1RTBoRW5ONTZJU0l3ZnpqbDM3S3c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RktRaTIrRjNlV3QvbTVicWc0eC8xT3Y4QzdEYkdHS3c0SmtIaHFpKzA3WlFL?=
 =?utf-8?B?NmlDejFkdi9DTlFQS2orTTNsMUJmeXVNOUUzZmhXNDRPbXIvcm1uNmZZek9M?=
 =?utf-8?B?dzR4U1ZRdzlVcUlNaklPVXhDUTM2OE0zUDRib0JxVlVOb2sxQ2VXZG1vekhE?=
 =?utf-8?B?ZXhQVFduR2lUV0V0YVJoTHBqb1BiRlRodE9zTDZkSklXcWQ5UHpTNjU2ZGll?=
 =?utf-8?B?SkdJaDdSckI4Ty91NDF5MzhTeWlXdUthK3BSaDlReGNnaDEvR2U5MDROOVc3?=
 =?utf-8?B?NzhiUmhSbDgwengwOHFYWVoxZGplY29oSktvY3QwNHVidTRUdWRNTFRPSUtH?=
 =?utf-8?B?U3NsblFnOXAySVdwS1JmYU5wdVBabUFvYlliZnhNa0xGMjAvZ0t4VjZsZ1VU?=
 =?utf-8?B?Z3dVNzFXZnFsb2gxNVFwNXJpMmUwcXlEVzlGdS9DNUZFK0pIU2JYbWZYRjdi?=
 =?utf-8?B?WS9ockhXUHBiY1FrZG1MVkNheGhtKytWN1FJK29OMjJWMkt2Ti81V3Q0TFo4?=
 =?utf-8?B?Y25sa0FNeDczaExoUHczbStvSG1STDNwUXA1cm5xbURRa3R0ekcvdzFYMXlE?=
 =?utf-8?B?c0pBZFh5TlROVDNaY2tVeGRyYWYyWFY0TWs3SldVcGErci9LRzhzY0YwTlYw?=
 =?utf-8?B?T25Fa3Yzd2hKRDhVbXo1M2xrbXFhY3NMT0pGZks4dXlHTzZsRS9ZRUZ0VWow?=
 =?utf-8?B?eXhFbEVES3BablZ5M0Z2RHdIZzBVeU8zZXpwT0l2cHFtcGlhbnRqbmI1Ri9U?=
 =?utf-8?B?SHZHQzhRSWpwMmpYbkt6WUFld2JiYmpoaCtCT0hqQlBpbDF1bkkxODBkRWNG?=
 =?utf-8?B?M09RaDArQkJDeTJhdFZ5Rm52OE42WkZiSE5oTTFqbWtERldiQ0Z1RlVaN2Zm?=
 =?utf-8?B?Mkk3ZDJlM09ldmVwNXpYOTc0T3Y1USs1MSttTytXa1lmNUVVTFlLbDBoZTZ1?=
 =?utf-8?B?VUV1WDYrT0xkRkxsbzhOeVBrY3Z3SkY1bVFSYkY2ZTFKTHFqd01QV3c3aWh5?=
 =?utf-8?B?QTV2b0ZndjBjd2ZCbks4NldXZm5ibFdTUjM1UG5wREZVVFZYTldPcHVYb0k3?=
 =?utf-8?B?NitOYVNNL0dDcno3V05XQ1VaRTdTQXlXMmROcmVNRmttbldxVDhxYnY0S3Zt?=
 =?utf-8?B?SGQwd1V1NVZmcXhPazh1Rk03ZDlIQzdyeE9IUzdIYTJhYzN0Q2NYczY0d0xr?=
 =?utf-8?B?bytpZW05R09CandSUnB4ZlRVVTBaZkRoTEU5TzgvMVVHWTc5OXVzVWJLSis4?=
 =?utf-8?B?OWdWTUNRcDFHMzJiZkhZWWxSTjBjNGJlVW1UbHVpeXdOSlBqSGRrZzR0Q2VD?=
 =?utf-8?B?SmI0WWFNWU9Hcmx1SmtaQ3dTeFN5dnpuZCtuYlVqRE1KTzlIN2dzR3BIOWZ3?=
 =?utf-8?B?ZTM5VEhFRDhyNHk1T1JWRGNCMlNiWVpENDlaM2U3YUVpc2pWdVlJUFNpYlNB?=
 =?utf-8?B?NTFnaTh2cGxrUHA1U0h6bm42RDNyL2RJZTB0N29IZlIrRDRPVFc5ckVpeFNB?=
 =?utf-8?B?dUp2TVl1Y0ZueUQ5TGFCeXJsTHYybEZ1ZDFZek83Nk1qR2Y1QmxoM01XbjJN?=
 =?utf-8?B?dDdJc2RjM00wTXVWLzZFY0FKVEZKNElkN3Yxc1lUR3hYTTJlUmlJS0VqVVU0?=
 =?utf-8?B?dktxM0I1cytXNU9EMHFKOE5pNGEzZGN5bFhsVDdaSEpsVzlhRi9IbE9XdFlI?=
 =?utf-8?B?WC9jQXd0NGdWZ0xlNGIxeGdtTEpYWmhIMkc1cXVZNDROUGVMTW5ZU1BQL2U3?=
 =?utf-8?B?RmNlUDU2YzFaWEs1Z1h6RmhZejJRV0llaGIyc09NQzFadEtRUnBvYmh0WlU1?=
 =?utf-8?B?ZERMdFFUNkJpZlNsbGZmUEVLMjFwd1FnbXBxWDRiRVM2Z1NOQzF0OFJrQU02?=
 =?utf-8?B?V244QzQ3QW11WGJHQ1RFd1piakxsbHIzejFMbDd2QXVyK1FHQWhVekRGbGJz?=
 =?utf-8?B?TEZoczFuZzdSbDdGTXNNTllBWVQzby84TDFRc1NwM0dpMDBTTTlhWnNQYUFv?=
 =?utf-8?B?ZG5MeUFIaElBRTVLTjdmZEZyaURueEdNWHlQc2pyWGxtdThhZW56blJXY0RK?=
 =?utf-8?B?TXdzSnh5OTdqdEgwQkxVMXFkTGYwdGRUNWQ4MlBHYjZzVXY4N0pXYUNURkhM?=
 =?utf-8?Q?jXTucOhDxR4LQP/MGqtha/RXn?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d42a038-3839-4337-32ec-08dcc7374795
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 07:59:01.8649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +YmBHYZRuuZvOLy2Dhd9G69Wc4Fl4p8upkH6caoKIA+hQZ6xBCzvlPqO4/an2WTd0/PIdmZG3oDWoc5RNpA4ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB8765

Khadas Edge2 uses the PCI-e Ampak AP6275P 2T2R Wi-Fi 6 module. The
pcie@0 node can be used as Bridge1, so the wifi@0 node is used as a
device under the Bridge1.

Co-developed-by: Muhammed Efe Cetin <efectn@protonmail.com>
Signed-off-by: Muhammed Efe Cetin <efectn@protonmail.com>
Reviewed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
---
 arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts b/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
index dbddfc3bb4641..3d0f55c123d92 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
@@ -283,6 +283,22 @@ &pcie2x1l2 {
 	reset-gpios = <&gpio3 RK_PD1 GPIO_ACTIVE_HIGH>;
 	vpcie3v3-supply = <&vcc3v3_pcie_wl>;
 	status = "okay";
+
+	pcie@0,0 {
+		reg = <0x400000 0 0 0 0>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		ranges;
+		device_type = "pci";
+		bus-range = <0x40 0x4f>;
+
+		wifi: wifi@0,0 {
+			compatible = "pci14e4,449d", "brcm,bcm4329-fmac";
+			reg = <0x410000 0 0 0 0>;
+			clocks = <&hym8563>;
+			clock-names = "lpo";
+		};
+	};
 };
 
 &pwm11 {

-- 
2.34.1


