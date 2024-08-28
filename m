Return-Path: <linux-kernel+bounces-305031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3DF962868
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 15:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04B9A283C6D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 13:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AE7187857;
	Wed, 28 Aug 2024 13:17:09 +0000 (UTC)
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2126.outbound.protection.outlook.com [40.107.255.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1F442AB3;
	Wed, 28 Aug 2024 13:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724851028; cv=fail; b=ljl7Ga7Uyq3auW7CC6VvkQr1fqt8wqG6En0hmJkVctSoU/QwESKhogfy4R88v6ngf/r2S/Y3Ze19IPs1l8nzIzeigCenbF9JtOnEUAnmtzjTQ3AednKA8glCSpfmOgjjvaUxQ2zZ/2SxMBpKXWTI7cedxdtdkoQkJgJ14fmM9SM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724851028; c=relaxed/simple;
	bh=Yq2xyUfXUs/0dgPMd0KjgNGAQh5Rr9dRcbRYll1BHBQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L52b9loc38lZGWuf/ak8DMBvzCVrbiT3KghuRYmtEf99GUCx9EjvaNE3BHN0lVr4l+3IHaj50oBDiG/cIzl15GovK0WzuhjYGkt65pcJfIneETyX25cInee5gnGbghcCHMy65pKp9eS5Wi5Ycd35Kd4M/HRFtgiRRhIuiSnuVjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.255.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bxeD9SGmzT5leu5BZrZjmNFljMzH5G2S20ypTDZway+VGOohaMZYj/N0rS5GpdUrSmGezjRsVLi65hoTTXd2fuchxry/naed+M9nELTpoTp/PLkMhVAR/zIlwEV3+nNTWDwVUEnM3wIBl4JntgPNi15VLCHRqROOnTwUeixOk+Up7zjllEbrsKTKt9P0AWAXRDjby07bqMSIXBCdCi/oTr3CNfuyEDfn6z3KJOUx0q0LAX3YFf+a+joyQFMiIR4u0+vtoGL+x0waDfTo+ptPkzhl/NZC2eLBMeCNhICq/8hcjbPrdQVaiSLxsG/MGFTOOQ+n/lNrz0WMCN+Z68m4vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tcavgpqzPnDtcNvLxCMM2Ce4iGTp37baEgXiCECbnE8=;
 b=fJLYDYk9bGqP2ksYLxPLEdBb0M68/ZtFz2H8N86OrMTfYMNdfhYfihWYXuaBpDU8n+MNanfolMrYx09tHl9KDbV1cj9wXyWshbUKr/UplYUSt7ju3jG3ot0pd3xmPhVXSpZ91KwG97+NL/g5bFxK2BH3nutMoPKWMjGhooqZPHozYgZ4/7S47dMh5H7IGx2yW778tkLaNRhiuPoxejrv6ZmytKggiLFGzQJtVQehIw7Qb2c2VkW+1BixUngse1oJeSjx6aTTY01BD9/xhqRDCRDB3CSnlI035XLTyKRRavuyROs650Gi0wZpEkzfLm76x9NTslhaQMZZs2GYw/frPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by TYZPR03MB7676.apcprd03.prod.outlook.com (2603:1096:400:420::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Wed, 28 Aug
 2024 13:17:01 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%4]) with mapi id 15.20.7875.019; Wed, 28 Aug 2024
 13:17:01 +0000
Message-ID: <b6d84350-06fb-4658-acfc-c4ea87165700@wesion.com>
Date: Wed, 28 Aug 2024 21:16:56 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 2/2] arm64: dts: apple: add "brcm,bcm4329-fmac"
 fallback compatible
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 asahi@lists.linux.dev
References: <20240828-dts-v13-0-6bff9896d649@wesion.com>
 <20240828-dts-v13-2-6bff9896d649@wesion.com>
 <faa5f1d0-4300-42b3-a91f-e20fda87dfed@kernel.org>
Content-Language: en-US
From: Jacobe Zang <jacobe.zang@wesion.com>
In-Reply-To: <faa5f1d0-4300-42b3-a91f-e20fda87dfed@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG3P274CA0011.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::23)
 To TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|TYZPR03MB7676:EE_
X-MS-Office365-Filtering-Correlation-Id: 087221c2-8e18-470f-0456-08dcc763b3ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OTJxTzM1UHh6a3YrZHJ2QUhLdHZUUWI5dHZLRExwZzNCSGVMZHhENytZd1k1?=
 =?utf-8?B?dHAvR01aWlZnZ0g3aTBkbVdiMVdzb0t4TitjL3d4a3RDWmNlUTVacklzNGxY?=
 =?utf-8?B?VWZpVlFzUmVKZTVYbXpzMXM1d2k4RmJTMVhlSk1QczhTbGV5TlJGWTIvZjhX?=
 =?utf-8?B?ZEJCZUlwMTZ6dFpuZHZ6REpFSVl6L1c1VXFuek1TN2NJNWJVSXVIQnJRZ0VL?=
 =?utf-8?B?dEZCcHZWM3d6Z1Exa2gwdnJBemJZVEU5b0pEb2h3UllLZDdEUGlpVG1tTmlP?=
 =?utf-8?B?eXdTRkhuc0pSUTdWSmdpR2ZwdGwwOWU4THAwK1c3TzRHREtRV2pTTG44cTJk?=
 =?utf-8?B?eUtRZ0JtS3ZVVW8vWjhiRDRPSnNqMjYwbmxLTHRYY2JBWHNrbXhHK1dvaThp?=
 =?utf-8?B?bFJEUmlRV2ZNY1JtbHE5UVRCYTVsT3V5NllrNVkyTXdHK0VSODJSZmd1ekQ1?=
 =?utf-8?B?UTRVRmpoNk5zM0N4K092VHlxV2hTejhiV1AwZUp1UzhqR1cvL29aMWxEeE5t?=
 =?utf-8?B?QUhENkIyZmlKRnEzdDZuL3NtN1hZL1JJV0I2RDUwWXhRTnZSaGFXdk1VRnBx?=
 =?utf-8?B?T3FSL09YemtGTm00aUZnYzNaRW5qcG0yUWEvTks0VURPSG1LZWNnalN4QmNr?=
 =?utf-8?B?QTRnWTY5Ny84SzBrYUEzMUpVNXQ2V3hGSVVCS1dpWG9FTmNsemhKQnBTS3Zw?=
 =?utf-8?B?WnFMT2lNdThPeEN1bTlpSUxtbVJ6bkNacVJPZFh6ZkFyb09YRGs3SUJiYXdi?=
 =?utf-8?B?ald1anF0MFRmUjgwbHU3M1pRUXllZGkyeGZROGgwRzIzWFJWd2FwbUpCTnVo?=
 =?utf-8?B?VlU5ckk4dG9aQjBVMmpjRGlwdDdNNzUwRVJrMmZ2ZENZN243Z0FGdFVqS0dE?=
 =?utf-8?B?elZ0Z0d4dmNGbEtUQktOL0VHb25GNnZDT0M1TXRndTJZUE92emdGdDZvTGlW?=
 =?utf-8?B?V1ZTRlJnUjN6SDlNNU5nK2F3cllOcmRIWkZCMUNJVjhlc3F4L2M4bUhxNXhK?=
 =?utf-8?B?UHNuK0FVdERmSENIay9SMzhOOHZZbmVSaHZ1QzFHZGNPL3VzZ0JFVk8yODEv?=
 =?utf-8?B?Y0pGOHJ2bHRhUlRXMko5dmtYZys1Sm14MExaNjN3TGhhdGlhbHZlWHEra0N4?=
 =?utf-8?B?Y1g2YTQyWTlYTXJ1OTBsN0h6ZkN6d0VqMGVwb1ZLZXN6a05zd0kxblJxSXlR?=
 =?utf-8?B?NHN0TFYyazdKOWZzTkg2cUNEZTI2Q1FNNTZnUzBuNkRqb1piVDhTaDNVSnJS?=
 =?utf-8?B?YVVKL2ZBV1Vrb0NMMXg1SUZvdXlQcHhhOWIwaWEzcC9WZkFnb3lubG45TzJD?=
 =?utf-8?B?eUFuT2pvaVZ4M1NGcHFMVm5nYkV2YlptVUk3bGVGZjFhRmxEM3I3SC96T2tL?=
 =?utf-8?B?VFlXQ3FzaUxUaGIyMjVWQkRNbVVZMGJWNVJVQ2FBaUZ4Y0pDYkx0UCtieUpD?=
 =?utf-8?B?eXhTK1I5Y0tUcEJuOXlURCs2cENjOS9TRFFiOGVVN3RnNkI4a1VNOFJGRjRZ?=
 =?utf-8?B?Z0FkUW9ETnpTVWFQM2FpQVJPeW4wTUVGWjdkd0E3K2c4eDdBQUhsRWpMRFlC?=
 =?utf-8?B?TmhzU3hWSnlLdldmWjF0VHZuWmFra2RML0pYVUNDYXN1a0J0QTEyUjFQSDU2?=
 =?utf-8?B?ZWxNSDRUenBhZUd5M2hDYklwR1ZwdHVLWjNvZ1dPek5BcVMveEwrV295NEFK?=
 =?utf-8?B?MW5FaE5CamtHOTFHMHM0dDExMkJ1YzYvNUpicm1BWFZZdTJCQURWU0hLeUJZ?=
 =?utf-8?B?Sm1Fb0g3d1pDNm1LZVhVazVFMHR5TEtSSE5YQkFzanVVU2tielFRQTdqbExP?=
 =?utf-8?B?QXV0eEV2RVlOQTB5NFRuZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dnZXWDEzTVlUcGpjN1dzZVhLaUhsa05Ed0lTbENWb2wwVkhkdnBnVjhZK3Ix?=
 =?utf-8?B?ZmVQbHYvOE02SVgrek9wRGJkeTBCSUk2a0haSk44cTZsWmhaaUVsM3QrUjli?=
 =?utf-8?B?cjZmRHhyMzJ2WjNneStiOEFCSUtyTEg1aUFIWW00YUx4aTdGbDhBc2pnZTQz?=
 =?utf-8?B?ank4R2o3OTZIT1Q3MEU3S011VlRVMVBBOW91MnFqZm56dTJUZmhVbTE0MGFV?=
 =?utf-8?B?T3BKZkxhaHhSUGw5NThwSGFLeklGZ3pWK1lBTjRIZ0J5MzY2ZlJCQzNmcFRD?=
 =?utf-8?B?dG5RTVp4azI1Tlc5a1dSL0FJbzl1V3FNREpVVHdMbzR3UGlLeS9tVlFvaGl4?=
 =?utf-8?B?aURXUTkzSjhabEJwenBHbXIxY0UzR2k0cG9BcldRUjdUSzliQzhGZUFJbGwr?=
 =?utf-8?B?MGwrcVJvT3ZBWitvOEpoTUxOVng1WEJLRmIrT1VxREc3MXU1WGhSdC9HR0xY?=
 =?utf-8?B?UFlFVkRXQ2xKZzZhYWhmakhkTHRWVU9XdWxIMUFqQk5tbFFHamVCaHVuV3gz?=
 =?utf-8?B?V0M3Wk0yRXg5U2lFa2xRWHhOSlA0ZXlGMHRjUnl0ZmhodFJmNTlkOE9BUVha?=
 =?utf-8?B?M0xZVnp1azRiSHBJTDR5VGFmWkZ0RW5Da1BoSUU1MWtTMFdoSWk0RkRlUE9U?=
 =?utf-8?B?OGJJaVdKZW54NlVUbkt1OXhRN3YvNzhyZDBQaFBEMmdFZW9rcTlTdDF2VFBZ?=
 =?utf-8?B?SDRnUTFIQXNicU93M3IwL3Rmc2VKOEJXdVZMUzNacm9MZU5RTEFxbzdaWlpa?=
 =?utf-8?B?RXMrLyt0dWthbXEwaHplWUJkc3hvdXBkdEIyOFhlejViUE1BSEEvWTFoZ29q?=
 =?utf-8?B?Sml0ckpVN2YrcWppdlBraGpZMHdpampEK1RGbVNpSUFqZk5YNGI5VnVvYzI5?=
 =?utf-8?B?Nm1Nd3Y2c1MrZVR5RHNWYjFsTm8rVk9BanFTSXQvb0NIR2Q5bHZ3KzZEWTc5?=
 =?utf-8?B?aFlnMXo3NUY4RVB3VEpQM0s4WWlnRTdDMmE5Ri9zRXhlTG9pVVFDd2I2RFcw?=
 =?utf-8?B?R1dIZkJHdnNST1loaWNkRDYyZVBhSXhmbUwySlZoMlVLSlVDa2dqVS9XdXpL?=
 =?utf-8?B?dXNvWk16eVIvYy8wVDlQUEJDZG9ZTlJNeUJwdzh4TklNWUFCZHRjZDRHZ1JM?=
 =?utf-8?B?MU5CckpMcytsajYvcEJGZG1UYXhJNnJ3dWhmYmhsVG9zNnZBbWNMTkd0YzI3?=
 =?utf-8?B?Q3lWM0dzQzYzOHkycER6RzdQdjVWNWRETi9vbW4zejZIdXVFWW5YUWFlaGhn?=
 =?utf-8?B?M0xESFh5RWFjV3VHS2dWOGQydHFiUFBqeVVDdjhtdFdmNjJxWElHNVZ5bnQw?=
 =?utf-8?B?Ym9rZ1pOUVBUSDI1dzdxOE9SQ0dFdEJBdTJGckhVa2h5UnRaQTVaNEdSaG5Z?=
 =?utf-8?B?anBMTU9DL2lLWVJGbzluQVFrTkd0OTIwQVoybVJuSnhwS2hiaVFjcmhQV2p6?=
 =?utf-8?B?ZUM2RkpHWVRCNlQ4S2NPYkU0LzhsRUxQQWdSQU1GNWJhOWVIVmxQNUoyMGlL?=
 =?utf-8?B?elI1bmdhMU1iTkc2Rnc3K2NmR1pUY1l3Q3hOTkxpR1FFZzZjc29rb0Rkd3dt?=
 =?utf-8?B?cWltVlB3OE9yS25NSEsvdWxUMmJscTg4RDZCMUxpZG1zdm9wN2x5dHdLRVRJ?=
 =?utf-8?B?VFR0M1U5WjBKOVBzbGpKQXZGN0RnZ0hPMmY5bzkyR0FJZTlodDlvZzRYVlBu?=
 =?utf-8?B?TXZiU1hZVDJFc2gwMlpoSDVPTUY1N1krYS9Cd3dCSmdXT0puTy91UEVhSFFu?=
 =?utf-8?B?VUlVSDhRblJBNWYzQSszNlBiTUx4dVQ4VnRCUlBEU3pKV0d5QnBwYmg5TC9I?=
 =?utf-8?B?UU9JMUN3ZUdvRklDOERBV1FPVWpWTmk5NnVUVDBHRjlCWVVLY1JRSEV2djBa?=
 =?utf-8?B?YURrSjNMZUR4R1ZVZGlnVjgyeTZHNm9QMXNrdWxlNEtSM2MrYVF6RjZFTlY3?=
 =?utf-8?B?OGlqemFmNlY4NWtLYlZkSzFQS2t3NjhLL3RqYmlNaW5FWmk0ZVpkSkFtcUlQ?=
 =?utf-8?B?VUtqVzB0ZUFNbXNDelNkTVlYeG9DMHVnWU5yWGZzOTZUejNWUysyQ2NvT3hZ?=
 =?utf-8?B?cklra25IZ0kvOGVFeUVNTmhneG9MZlh6MHdLU0xnOGVHNnNlK285alpKbW1Y?=
 =?utf-8?B?dGZsMXI0eDRJQ2hraXZoNzFpZWJVME9VdGlwTTExNkxmazlGZnU0RHNua2la?=
 =?utf-8?B?L3dtSjlVNjdrblFzekRqRlpicHZSMmRCUi9hS0VPeDRxbkdZd3JHWkxyYXFx?=
 =?utf-8?B?VnVpNU1wS3NQaGFoU2t1MEE4L1RRPT0=?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 087221c2-8e18-470f-0456-08dcc763b3ce
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 13:17:01.3441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UTwr4DdD6E4Kz61ZlMK4PJyOyFIk7vH3yDEd9nb8rjuGYws3QymtUVZlU+54wsgYW9JjjYh+g9LHcfRHv1Z2gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7676



On 2024/8/28 21:02, Krzysztof Kozlowski wrote:
> On 28/08/2024 10:45, Jacobe Zang wrote:
>> Wi-Fi compatible in these DTS is based on PCI ID. Bindings need
>> "brcm,bcm4329-fmac" as fallback compatible.
>>
>> Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
>> ---
>>   arch/arm64/boot/dts/apple/t8103-jxxx.dtsi | 2 +-
>>   arch/arm64/boot/dts/apple/t8112-j413.dts  | 2 +-
>>   arch/arm64/boot/dts/apple/t8112-j493.dts  | 2 +-
>>   3 files changed, 3 insertions(+), 3 deletions(-)
>>
> 
> Bindings are being questioned, so link to them in changelog section
> would help the maintainers to decide when to apply it.
> 
> I am not convinced this is correct bindings change, thus this DTS should
> wait.
> 
> Your previous patch also misses link to bindings. Whenever you split DTS
> to separate series, please always provide link to the bindings, so
> people will have the context.
> 

Sure.  I will post the link in changelog next time.

-- 
Best Regards
Jacobe

