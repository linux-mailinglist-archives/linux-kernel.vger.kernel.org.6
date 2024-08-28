Return-Path: <linux-kernel+bounces-304569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C729621F0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E5051F25F7F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 07:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D35C15C133;
	Wed, 28 Aug 2024 07:59:13 +0000 (UTC)
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2103.outbound.protection.outlook.com [40.107.215.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4889815B55E;
	Wed, 28 Aug 2024 07:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724831952; cv=fail; b=KPIynvN2tZiDk0Mr5vJGppflF6CJ29qKegMaePZrlX9G+7JONorbYtYq7YPJTREkO/LFjsYgkEMyFXBWnJ07VmkXnzJPtjMTb27wLyJkoMbXTclOp9iCCkb1ofCx0FZ15W2x6Lww3fa659HZCZsCRuYuscY9yFDZplIxc5Lmdyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724831952; c=relaxed/simple;
	bh=LaLu3quqGEtYiHhIevE9m8Vrk5cGprDYd1V9ZIbpPsY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ApDd8crx6GB6yZgVw9+qfVfLWRNJRTHWGc7rRQso6ixKgA5tiAFI16/+DP6vOLBVD5mVsUcEgXIXZ+tjWK0G9xiaRnTaqK/1GJfoOQPCirIC3Ws3cQdLdof1Ka2E1Sp3sgGCtaE5F3DC2m7RaRTsU5MnYpFB0Io3U8pvXKMMGmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.215.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S1c0e0Voi8viX7ESKYFQhg+ImIlg7pcddZ+Y/UTkv9aeGme6fYcDPZ7mwv5HI9MjR/yNMrOODic8a16IGd7U5aPMHYNhvn+6/HCh42uEUx0+mASio7thyPqow1ZNoa33eWSyuBxizXLBdj3mEiL37ksY9q9WGHLPaA9gcOW8BvO1gbYSgkfHRC2g52dPTjFaqGh3lQ3hTiK2Iwu94YLLMeurJxo3juD+4QcEy2tgWwkKrIr/O3OaKgUPt1KC4FeKOjuMVJ9iVOCJp8igIDNoFftjMhJU6U4D2eRp8Q34fYnQNqKNP/joTTT3m9JLx/Kqr3HexXFdNhvQcqI86ndxoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DDkoga+CZqogSQrYJu1qtK7EDMPF+U6ZVL0L9vt2D44=;
 b=jqrjsAkwHismcIg8HAQjoP8NoMCiXbAChN9AUeRu6/4HaS4OvKNT0toks+VM9tVEwDUCBwGXfDTxT/c1EburcenOYY08yycHvaTBlP5mNo+abUCztOXkcy+O7UF9RKiCrpd/JoN5gdq1Am915IvYnA1ZBM32NVcJUZ4JOXWvck+m8UXt/NlvOwiWfgirpM2Y2C4huarboiiTHPqhUpyVcr+Zm9BVMTBhNMb5z44+NwaGlx7WYTnXd+Dg1Z5AH841mCHFk1EYdwaXgskPj7Ye9MkCVdbqH0nOtMAeD9Ca1jz0MIexbYIuG6dsDWAHskM73swDq3wUE0Ufz9tnj4/H5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by SEYPR03MB8765.apcprd03.prod.outlook.com (2603:1096:101:20e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Wed, 28 Aug
 2024 07:59:04 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%4]) with mapi id 15.20.7875.019; Wed, 28 Aug 2024
 07:59:03 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
Date: Wed, 28 Aug 2024 15:58:50 +0800
Subject: [PATCH v12 2/2] arm64: dts: apple: add "brcm,bcm4329-fmac"
 fallback compatible
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240828-dts-v12-2-80b6f240f67f@wesion.com>
References: <20240828-dts-v12-0-80b6f240f67f@wesion.com>
In-Reply-To: <20240828-dts-v12-0-80b6f240f67f@wesion.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 asahi@lists.linux.dev, Jacobe Zang <jacobe.zang@wesion.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724831937; l=1983;
 i=jacobe.zang@wesion.com; s=20240828; h=from:subject:message-id;
 bh=LaLu3quqGEtYiHhIevE9m8Vrk5cGprDYd1V9ZIbpPsY=;
 b=VcmHWmmoQObFPcqCdXJLq3s8ja4FmTeLG2j01pfmCgMbv/BK7RUBRPQ8iVhnhUU0Ezj5pYokr
 ZdO5f7CXek0A0BQp7pk9tPC4ToSrJBbUoiBD1uaN9n20sERCrUi9vWp
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
X-MS-Office365-Filtering-Correlation-Id: 497c14c8-cf3c-44b9-a814-08dcc73748cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eWFNWkF1dW82aGZFdW1lMnhNQXk2U0ZvbDJ6UUs5VkdYdnBVdzVmYitUc01U?=
 =?utf-8?B?eThNNTY3OUlUTU1RSTdtMGJ6UmVrblpjNzNJaDRESlZYVUN3ZVBWN1JPMy80?=
 =?utf-8?B?Y1E1UVhPSzhpYk5uYkNRelpPM0p3WXB0RTVhbys5U1dpWDBGdGJzcWpQUWVh?=
 =?utf-8?B?bUF1Yld4UVpVZk5PeGU2U0RWc1V5cHpYdHRQZldNRlBQVFF5RW9zYjNzV3dh?=
 =?utf-8?B?eElWeXc1Y2ZuOVJTcFArZVBOdWsxS2E5ZzhyeDhWSENua2E5endYcGtwVUFZ?=
 =?utf-8?B?b3RldUJMMHhaaWJzZnJnQjVWMjVZK2xzSWVwMnMrU3liRklLTWZBRzlrSTMz?=
 =?utf-8?B?a21YU2J1bGsyY2prVXI3Q2pmN2hFM2hXdXVtcW9heHExR3ZFNjBLSG8xc011?=
 =?utf-8?B?TytuNm1SWHVwOXhNaUpPR2lSUjJaNUh0Y3dXWkpERllJZEN5TFpQeFV3M2VH?=
 =?utf-8?B?Rm9hTDd2SDhLMm9PVFVCUDVhb3ZINzd4NVY2aG1EUUFuVG0vRGNTUTJlRTVo?=
 =?utf-8?B?SlBQVXVIRFRGQndQcWU4YjNvdGFlY0Uzc0FoVk01THJpWUo5ZnVpR3I4eFdx?=
 =?utf-8?B?amcyMVUrTHVNbHlvQnZTeU9YbHRtbUtINEVyZmVHNEJGdlBrM01zMVBDWThs?=
 =?utf-8?B?OWljNHBpeFMwdldFd1N5TDlaelZzcURHRURkMUR4YkR0TnpLREhEY2ZLdUc1?=
 =?utf-8?B?TXUyOUNlNk9vd1lHamxhblVRUmtoQm1BS2tydlBRc1lCSzZndDRKTWRRdjFZ?=
 =?utf-8?B?cVowdnFlcjlwcWJ6MGhjVHhuTVovS3pybkg3bm5ZcXoxNEVWS25IVE42bVkv?=
 =?utf-8?B?WU5YVTA4RFM5L2pjdUVnVGRJcXNLRnd5OXJydU9uOHZoeWpJR20rM3U3K3F2?=
 =?utf-8?B?TlBSMXNHTHY4VW84MU5XTzgvMitvUFg1MXp0Y3EwcnNDYWlFWldtbHpVT2t5?=
 =?utf-8?B?blFJRWZKV2pDb25neWtZSy9OSmRuQlh6NWwvL1NBekE5U1hwY2dXVUEwSWVk?=
 =?utf-8?B?VTZTcmVjWTRmRDJsdFVOUEhiazliaWJwMGxFQXhEdkd4dlBaK3BONzNFWXRm?=
 =?utf-8?B?eWE5czk3dUxmQW5YelBKejRxTVl2VzBwbnRISXdEWStOVVhsOUkwa0xQKy9a?=
 =?utf-8?B?b1VkSEN3NlB1VHU3NEUzcHFXREJNcUtWNlgxODFZOE1VZ3lFS3E1U1Q5d21s?=
 =?utf-8?B?UjZJZUxUVU5KTiszN3hxZ1JHUTVEbkZwZzBJVWYrZlJuOUVVZU5SdkhsaGds?=
 =?utf-8?B?bXBMaFZhRWJlRHUwdm1aeTJEdCtZYnBUZUJMc0ZNTXpOYjBWUi9XK3J0OVNE?=
 =?utf-8?B?RGdSM1gzbDUxQmdQQno2YmZRTmsxbTduSDE3Q3M5d1NOZkkwcmdvb21Jbmdw?=
 =?utf-8?B?aVNMYlYvTTVFUDBwYnhLWlZ0UDM0NTl1YmNrVkxMaXBUdTlkSWJyQ2pmZmpD?=
 =?utf-8?B?UEhKT1NLUDdSbzhMUnNCbWFqeS85dVc5eTdLY2lWLzRIRTFTazU0Y01ndlRF?=
 =?utf-8?B?VU14RThETmcvTjZESTRKeVFuTlJKc3VmZXhSamJXaThVaGpWY1R5MFpsa3Zv?=
 =?utf-8?B?WTM5RlpnZnVtUER0QmxGb3BnUXBzVFB6RXJjMlhjQ2JhYTBnWVAyUSsyTkVi?=
 =?utf-8?B?SzlVOHV4L2FrbkF1dWViVmthMmhuczgyYVZGRWxXQmVxYVZMSEtlcHgrSFFi?=
 =?utf-8?B?bHRMT1RucHFpOXFodEt1dVpHRU9zVTU3Ymc3MjJzMHRlcGs2dHBOYi9mdWFC?=
 =?utf-8?B?bVFGbzRrNVFLczlvU3VKQzZGSGdtQ1MzTkVOMHVWUk8wdUNjVWEyWEhQMUF1?=
 =?utf-8?B?NjVYQnVZc2svOFlabDlGUWNmU2tnNEhmclJKdkhYNTEvejVLVWdtZzlOeG45?=
 =?utf-8?B?c0xlUVh2bmk1Ri9COTZyTlhERFk2Q3k4dXlTK2dxekFBd1E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b1VGR1BDZFpEaVM0OEkwcEt6b09QdXRFNDdtRXV4VDRLbnpHL2gyK2xaUUcx?=
 =?utf-8?B?VS9YVDlicEVjbFRPRXdxVFg3UVZnS0RQckgyRGVtQU96YUtxN01VdWZHdU1U?=
 =?utf-8?B?Y3RYZDJLeTIzZURmeU42aitQL2lhQU9LeExZbEppWFNGakl6dlVMeTVLMTUv?=
 =?utf-8?B?eGxlWlI3eFlURWp4dHk1bE5yRmNNVHhhalZxVG9DNGxUbGpNRVRZekwzdEhI?=
 =?utf-8?B?NEpkVVhPbVVYZVdFc0o0azlDcDRYTy9KN2lJRW1wQlFlR1JUWmEwdGR1bTlG?=
 =?utf-8?B?Vzl0WHhVdnlGZ1lxSUpINXk3aU1sZHBXN2tmQytIZDkvNE01bXlaWEJkYWY2?=
 =?utf-8?B?L29MZWN6SDZkeFZsSmdtc2NkWDlFQzJUQzJEbkh6dy81WHI1ZENhaFRac3k0?=
 =?utf-8?B?dXhXNWxpQ2J6bVJVb1hMbll5cVJmZnFXY3VNeEZoZHlYQWNHMGd5TWpEdnZ0?=
 =?utf-8?B?cEhEZ21paU5NZmZyajZVRE1YWVloYU1mdzYxTjNiYXo3VS81MjViVFRtOURw?=
 =?utf-8?B?VWMzRTN3RlMrWStOOVNqQU5reWFjckNwdWNkeU9sWDZ4WGhSTE1nNXlWdmJM?=
 =?utf-8?B?ZC84a2FObTcrcDd3VjZVZHJQUmJVMW1EMy9VZXU5VC9uNmkrdGhEOEpwc3VE?=
 =?utf-8?B?UzhpVXc5WEQzRmxlbTc4d21RVU83d0FJVmZLQ0dwazZ4N3RjSmJ1ZlBvOGh6?=
 =?utf-8?B?N1B1RzZxSlVxNWZkbHRiU0V0TG95K3hzL1diTjhuSlRrOTRZSGluQ0E3SG5m?=
 =?utf-8?B?NGp3ZTJmei93QmJGME9QVEZpL1ZxWWpkWE1sSitpZkFNMDNnby9PUVdvb2hq?=
 =?utf-8?B?Ulo5eWRLMWlCTHFjMG9TVnhhREViN0J4bG9QVFMzTG9SeDlDM1FGQzdBTVN4?=
 =?utf-8?B?MEU4UFo5LzM0T2RDNWdFWEtzbDJzcDFGM2FTSitrSWw2QWlLaE9Celo0N3o4?=
 =?utf-8?B?UEJyS2ZGcjFaZU9DN1pDZEI1Wk05aVVabEJLNFdoc3o2QWFqU2xxQnFvNHh3?=
 =?utf-8?B?eXVVcVhrTTkwL280bHdpc2cvbTNjQUFPSlNjT3NDSWJaY25vRTM2eU1DOXdu?=
 =?utf-8?B?OER0OEtjSHVXL29qT3JvS1N3Y2RzaXBTOGpJdWRucDhkd000cVRoeUI1T05I?=
 =?utf-8?B?M0V6dS9pbUs2dGdDcGs0Z1hzMCtuMk1JOTVNMGdkRVRsN1NDWWhUU1I1VFM1?=
 =?utf-8?B?WWdNS3lvWDM1czljcTJJTW0vbGJsd2ErSGVwNFZIQVBmUWtHZldUSjZXU2Zw?=
 =?utf-8?B?TlgwdjY2WnVzN2VRY25nUFNGWk9hNGh4MElQNTVKMFEzMDdrR0UyQlVHeEM4?=
 =?utf-8?B?MC8vWWxXU2dPWTZnZXJIMFFSR1dTVWx2Y1NTQnlBNmlabW5kTFZaR0xqeXhr?=
 =?utf-8?B?eDBDR3BNMjE5WWVNQkMxQTRpeW1XQTBxTkUzL0pOeHRKaHVwcHVXb3ZGWGZJ?=
 =?utf-8?B?OWluaEJGeTJpVWZMR01EdkM0ZFJjZGtZSmp1dXNEeUxYeE1HOGcwdyt5MVkz?=
 =?utf-8?B?L3BUYXFUbDlIcHBndDErdWdTeklBYU9HeUhtYjI4WHI2YmVCc3UxZFh4VlN3?=
 =?utf-8?B?UVo2OTZZTE4yVTFIbkk3cThuWGVKOEdTelhrc3c2NkVVUGVTZ0Y1OEZQK0FY?=
 =?utf-8?B?cTFwcTkrbFZDdWtETjVISFNOZldPcFR4bi9SNWs2VFRmTk1tSmRrVVY2eUxt?=
 =?utf-8?B?TGlDWEtWYXhBQk9ScTRHdlJYdVE4dkdSRjlYNFM0WTIrMjlIVTdvcWo3eWk3?=
 =?utf-8?B?K09oRWpWV1ZQNHRrU2NaaExMbFBnNDh5S2xUV2t6ZXg1ZGpWZTlHRjZYa2pB?=
 =?utf-8?B?Rm5zMU9LZmtUSWJGa2tWR08wcklCb0hPQWx6blR6QnJTc0dCdlFLc1B2cnlP?=
 =?utf-8?B?RWxSVTFld0F3SFdMVURpaFhCUlRqMWkxQ2JzSnZ1aG45bmFLN0I5Y3ZiMmFx?=
 =?utf-8?B?dUdlQ282ZmUzN294MVpJTW5yVENqa0E2S0k3a0tzYjJTczFPdVFjYnMzSXNa?=
 =?utf-8?B?cFBMbnUzdzFVTXBTajVHMS9YajYwcEU5YmxnU245alZIUDU2UXN2blRnTlNV?=
 =?utf-8?B?bDlGOVFKQ1lBV3NYU3I4S1ErRFBzRFhraEJqUU94aWhVdnREd05wYnBxUXdW?=
 =?utf-8?Q?0vJA7jNlbbROnjqJctilqKWHM?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 497c14c8-cf3c-44b9-a814-08dcc73748cd
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 07:59:03.9137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tc1wECD2/QLwnYLLwDkH0Kq/cIL+2ODlIP8DnVTpMWG2hibHl/8eBrwxsU9lFIQ+NJT7y2t71+uP93JGnWARCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB8765

Wi-Fi compatible in these DTS is based on PCI ID. Bindings need
"brcm,bcm4329-fmac" as fallback compatible.

Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
---
 arch/arm64/boot/dts/apple/t8103-jxxx.dtsi | 2 +-
 arch/arm64/boot/dts/apple/t8112-j413.dts  | 2 +-
 arch/arm64/boot/dts/apple/t8112-j493.dts  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/apple/t8103-jxxx.dtsi b/arch/arm64/boot/dts/apple/t8103-jxxx.dtsi
index 5988a4eb6efaa..4b021626d4692 100644
--- a/arch/arm64/boot/dts/apple/t8103-jxxx.dtsi
+++ b/arch/arm64/boot/dts/apple/t8103-jxxx.dtsi
@@ -72,7 +72,7 @@ hpm1: usb-pd@3f {
 &port00 {
 	bus-range = <1 1>;
 	wifi0: network@0,0 {
-		compatible = "pci14e4,4425";
+		compatible = "pci14e4,4425", "brcm,bcm4329-fmac";
 		reg = <0x10000 0x0 0x0 0x0 0x0>;
 		/* To be filled by the loader */
 		local-mac-address = [00 00 00 00 00 00];
diff --git a/arch/arm64/boot/dts/apple/t8112-j413.dts b/arch/arm64/boot/dts/apple/t8112-j413.dts
index 6f69658623bf8..df2a63d8dd5e9 100644
--- a/arch/arm64/boot/dts/apple/t8112-j413.dts
+++ b/arch/arm64/boot/dts/apple/t8112-j413.dts
@@ -43,7 +43,7 @@ led-0 {
 &port00 {
 	bus-range = <1 1>;
 	wifi0: wifi@0,0 {
-		compatible = "pci14e4,4433";
+		compatible = "pci14e4,4433", "brcm,bcm4329-fmac";
 		reg = <0x10000 0x0 0x0 0x0 0x0>;
 		/* To be filled by the loader */
 		local-mac-address = [00 10 18 00 00 10];
diff --git a/arch/arm64/boot/dts/apple/t8112-j493.dts b/arch/arm64/boot/dts/apple/t8112-j493.dts
index 0ad908349f554..5f3453e109b85 100644
--- a/arch/arm64/boot/dts/apple/t8112-j493.dts
+++ b/arch/arm64/boot/dts/apple/t8112-j493.dts
@@ -43,7 +43,7 @@ led-0 {
 &port00 {
 	bus-range = <1 1>;
 	wifi0: wifi@0,0 {
-		compatible = "pci14e4,4425";
+		compatible = "pci14e4,4425", "brcm,bcm4329-fmac";
 		reg = <0x10000 0x0 0x0 0x0 0x0>;
 		/* To be filled by the loader */
 		local-mac-address = [00 00 00 00 00 00];

-- 
2.34.1


