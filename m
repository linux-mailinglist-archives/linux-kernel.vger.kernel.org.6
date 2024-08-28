Return-Path: <linux-kernel+bounces-304611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6E196227B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 10:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ECEA1C214A7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 08:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD3B15E5D4;
	Wed, 28 Aug 2024 08:47:20 +0000 (UTC)
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2111.outbound.protection.outlook.com [40.107.255.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE33815C15C;
	Wed, 28 Aug 2024 08:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724834839; cv=fail; b=Bg7BZl/MOaKhQxrXbg5yQ6IFad4bkW7zALnC4LUbewTyk+jpE1s1NBEpBxKs+8lKRBV9IG2RQxbn2N2+WfBuYQoO9+iJS1JLdV1HoKv+Nm+c4fjdvJajYwoNR4MMtfm22pniKjuW/qnUB546RK9O843AyJesnf4EVdkJbLAZCtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724834839; c=relaxed/simple;
	bh=T2TipthrP7yT9YeT7YfA/IS5EZ/bFT/wUSU78tNXuZk=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=QubUlSOy2gEiUuBn9owJ1SQgeUYHP85Wh/qPufTgUeef/dWI+bfWhE8Qk2wZSIHRTd93YwB/YkSJOFh8W4dorI1rVVtlhC5YLnkS9bzkH06Te+AJ/LGmhtqDy1W596QhuIWbFsJ2gk3hvOJuOPu7okxmYhb8FFE166dvqbM39Jo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.255.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ghGFXDThtw0OItptbYdr7Yfy/Mtfb3j6bcmTvbWUdE4kK0I6SWlo10fSqJ1geiahA5w+oL/7EbPpPNvgscXaqBctR99pPimXIKqQfm0KuliwhkzEfAAXKwF3QYcfpC0XFHaL2TED8tttvApTLwTgDTu4DjxfmPtMj8YQeX6XA9qE4otwdLJ3udFeC0H/siBn6uQnjN76C0fGPiQwMxMbzp5buy+3GlOkttyS1RTQtlItaStGyJO1+FaQHpctnCQqadx7Dlvd+1IM6jeCD8PHb5KcEd1fitQM2NpiRtAiFZGr1prcJbWhQet2ovaA2Uz6ApqwUsPKxA6sFmENcLM5mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JAL24uZdpHiio82cADQ5ty8yVqfJhKgETfGVgJzIXVw=;
 b=moooPqHMSB7qYKc7Nteder1BFR3LWDMhQj9duQA0CwcS/lvDtYr82xP1675uYwOwIJ2EqtsZGKRO+yu0zB3rDnKA5fUX/zgZy23+ORmhFeGv89/vZ+5iYexLHdM1NdKBjDwKWdAUC5X/2DDbRnkB0LXIRxK857ZtSqMxtvS1TMLxAJ/3qBDw/R9qRr+ET7oFsb8fS26qrA6m+9P5QJEvpeA/YmQchwp4hJTGqbYEAXHxEVoHkmtENkGqhXvyBs/FMR4jHonOtuIIiwKYfs0bJFNriyF2kg4cWmLXrGYwZqruqGHWC3+qTC+9zzu3ltd+XJJNH1ZYpMNscLVb87UH8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by TYZPR03MB8412.apcprd03.prod.outlook.com (2603:1096:405:73::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Wed, 28 Aug
 2024 08:47:10 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%4]) with mapi id 15.20.7875.019; Wed, 28 Aug 2024
 08:47:10 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
Subject: [PATCH v13 0/2] Add Wi-Fi support for Khadas Edge2 and fallback
 compatible for Apple
Date: Wed, 28 Aug 2024 16:45:39 +0800
Message-Id: <20240828-dts-v13-0-6bff9896d649@wesion.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALPjzmYC/1WNyw6CMBBFf4XM2po+sFRX/gdhIWUqs5CaliCG9
 N8d2Lk8JzfnbpAxEWa4VRskXChTnBiUOVXgx8f0REEDC9BS19JpJ4Y5C9Ura0xz8fXVAy/fCQO
 tR6btmEfKc0zfo7oovev/AEshhZO9DWyDbcL9g/v32ccXdKWUH5+azfSaAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724834828; l=3580;
 i=jacobe.zang@wesion.com; s=20240828; h=from:subject:message-id;
 bh=T2TipthrP7yT9YeT7YfA/IS5EZ/bFT/wUSU78tNXuZk=;
 b=Be4cPiEfL0Pea3joCNsXC68FTd7O+wyX+p3oRQet0pfpFt9KY5q92R900wHl6kszcM0KDueBB
 e1Gnb+sO7LiACpvvyuXUxbzgJij9ldHDx4ggumvnJM8vDamqUDoTNkL
X-Developer-Key: i=jacobe.zang@wesion.com; a=ed25519;
 pk=CkP5TjIqHSwHJwZXTGtadoXZucYvakXcO3HjbR6FoeU=
X-ClientProxiedBy: TYCPR01CA0082.jpnprd01.prod.outlook.com
 (2603:1096:405:3::22) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|TYZPR03MB8412:EE_
X-MS-Office365-Filtering-Correlation-Id: 56eff77e-76f2-4d3b-92a3-08dcc73e015a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|366016|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bkloKzFpWVE5SENXVDZyTXI1cFZ3R1NKZFVKbThJTFpVMUJFZ3JXU2pWQlEr?=
 =?utf-8?B?TS9DTFFzUXdVYmVTR294bmJEbGFNZk12SFFIOFpWeHFpZ08wU0txK1lDeGFa?=
 =?utf-8?B?SnNVeHRMaU91Z29IWmpYTWJNVGthRUFLODErSzlUVGFPUGx0T2RGaEovWXJw?=
 =?utf-8?B?cmZoanlwTkpmbWpzY1M0M3VydlJjQkFMK1VjZWxnc0Zmdk9WQ01zUmx5U2cy?=
 =?utf-8?B?Nkc0cm5SWlF1YVBqdnFGd0hlcGxIOVUyZFgvZEZPZjN5RTVTZnUreW4rR09j?=
 =?utf-8?B?T05TOEpOVEFkaEN3WGVlR2lob0dvaG1SZCs1eUtuV2VOaklMaG1PM2ROeSta?=
 =?utf-8?B?YmV5elMrVCtpeDVnR1A1eDh0Q1dLUTBVdGtDU0YzOFBIRXpzZWxUNVdTNFdK?=
 =?utf-8?B?Q1lBUkIyaGp1S2k3OEsxU1B2VmdSemN5c2N6NlF2Z1huVXZIZ0NqL0ZkUlo4?=
 =?utf-8?B?eTB3UnlVS21LSjlERjhySEdyZ1Rxekg5cTBqdFJVREJNVHRwZ1hSRE5kVmFZ?=
 =?utf-8?B?dTFUUWVTRDRxYXpucXpJQXYydDFOTE0rOEo2cThiZlY3bWpleDRVQkFST3hq?=
 =?utf-8?B?cStpVytjM0wxN2hEV21acDJJT2JVK1E0YUNYVGtWWDBvTEVTWHZwQlVWSXlm?=
 =?utf-8?B?MUhxMkpKOW1SendLb0drblR1MEhsR3FkWDlOVmkva0FaRVVaZ3ZJSDV1OFli?=
 =?utf-8?B?MVpSQS94c0hzM0FQVExQSHI5RjB4UVlvM2NLTWVDM3hSTUJCWTBzS1dZSEFq?=
 =?utf-8?B?Rkg5endKaGl3dm1sa1dXQmpxZ3BiOGZXWUJzcHhkY1FWRjZBOC9HdkxweSto?=
 =?utf-8?B?dlhpYTdodHY3UWhkeTNCeWlIYmpONC9IbnhJUGtxSmFRaW9oNGJOVzdpMm9K?=
 =?utf-8?B?d3UzQWt0S2JFVjh2ajdxZGRiSFJwQWcyaVVJdEcvWC8wUjdRN01GYmhmenJL?=
 =?utf-8?B?c2tLWjJLQ281VVJvN29OUmluZXZVWG9ZQUE3aC9iOUxTVnNtR2syMXAxYUt0?=
 =?utf-8?B?b2xxbzJtUmZIOGxtd0RlcjVQdnZEekxpVjhEdjdDZkVJa01kV3NXaXlKbUlQ?=
 =?utf-8?B?V3FYUEFPTk55SHN3V2d3dHBLMzRPUXI2alJTQTdIeU1HWk5XaEtwcTJxY0FQ?=
 =?utf-8?B?dzcwYWZhYVQ3VlZFUGhpN0Y0dU9SODVDK0FMcDBWNnc5NkVDOE9oNlR2SHdZ?=
 =?utf-8?B?b2xwYkdwT1F4SlY2dWZUU2VBVnN0ZHhCNlN2VFVIMVFmZlNYTHJqNU96UmpE?=
 =?utf-8?B?OFFVS0pMZVBwdnh5YmIwSXY2c1l3VStVazBNNUhXOFYzYXhnQXpIN01mUjFm?=
 =?utf-8?B?Q2hIYzRIb1BoWGdVYVBFQWhzeDJLRk5UdWtCME5DZHZReFBjOFBxVnNucjFy?=
 =?utf-8?B?Ty94cDhCbFMzd3VLQ3YwVFlHOGZsRWRzbUd6UERBcW1HSVpZU0U2Q2VNbjh5?=
 =?utf-8?B?NWZwNXMvN1MrREdKb21Jenh5anlCZ1pjUjF4OUh1YTNCL3JqQnkxYlJXb1Fk?=
 =?utf-8?B?TU1xZVdpYncvNWIzejMybllabzBaR3AzWk0zQ016cTdSK2ZSNndWdVJ4UEFr?=
 =?utf-8?B?Uk42V0pTRmRrSVVONWhjVEFQbi8vL1N2M3ZYUDYzYkovVTJLczVZR1NYWmpx?=
 =?utf-8?B?UEJoVmFlY25KL2J1T2dOVUNRQ3BLSzNLekRKRTdrMDZDQncxcnI3azEzZTNs?=
 =?utf-8?B?cHA5d1lGNHZjcS9tZ0tSQndpQnNRSGFJaW1sbHVJNzRBVlBaRExKWnBETGFR?=
 =?utf-8?B?cGdrc2FoTHhCaFBTVE93RWUxZk9BaXYxZEFLaWs3VCtaWi80WUhQMkM5NG01?=
 =?utf-8?B?QmNVZ21FazlMR3NyOVJTNnpjdDFYTytyUmdyK0F2K3MvS0ExeUZuenBOL1BX?=
 =?utf-8?B?OGtmNGJFQzdLNTVmTnFLQWlkalFQV1NrMFRHdUp5b1ZBQmc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(366016)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QW1yNENHN2VnNEhWU0FManBDbm4yTW16aDd3NkxzOURmQlZheTN6QmZ0d082?=
 =?utf-8?B?Yy9jSTN3MEhDSTRQemhJM3VwYXNzQURDS2tvN3dQVlhtam5BY05NRFQvZTUv?=
 =?utf-8?B?NWtDRUxJREFDdkIyMWZNWHZvdVNFTlFTZEhBTlpaVlF2eHQrMExTL3RPdnRZ?=
 =?utf-8?B?ZHRiWFJ5a0d4aFZUSS85MDRicTNreHhrL1ZHYldHa0tOa09lS3pZajRReG5D?=
 =?utf-8?B?MkpFR0FMZkhHUG5ESDVFRFg0OS9rZ0czY1RBc1lPOWJDdXVqRlNyUWRQNURU?=
 =?utf-8?B?cEpBMFplc0R5Z3JSYTZubzhGNU9RREtSVmllSWhYeXJ0SVZMYmRybVVoRWN0?=
 =?utf-8?B?QU94SnY2blZlTXZZU2VVYlNubnEvTUtKVE9FbjlBc244VkVzU3pwOFd6OHcz?=
 =?utf-8?B?d1owTHgxcVdmcTN0U1pMK1NGNkdrRkhUSHUzS3V3djJQVjBwRGsvem5jcDNQ?=
 =?utf-8?B?ZEhLVEhWNERURFpaSE9GU2diVWl1N2VsdVlCUiswN0xrNS9xWFkyM3FDM1Nv?=
 =?utf-8?B?T2ZqYnJKaFMxYXJlVTdoMVRlSHZ3UzNQY2R3SmZLVVdJQ0VvY0dGZ1VUQ3Bl?=
 =?utf-8?B?eGQxdGttSmhKM0hUN3RMTUVJZkRlZWNxaFpvb3pzVkhNMHlBUlVxUlhIWGdG?=
 =?utf-8?B?a0MrdkViRDRyRkxZdU9RQ044ZGdOaGtaWnYzYThwV0lyVWJvUFY2bFI5QWJI?=
 =?utf-8?B?QVhCM2FNQWp2bExzUkxWc25vY3VoMkd5aWhtckFCaVdkQzdqdzJNcGxHR2J2?=
 =?utf-8?B?d0FtY0ZOVVJxNndMQ05xUFVDZkQ5dVRJUEl6UlhZKzFwaXVheldSREFPV2JX?=
 =?utf-8?B?Y3VGQlhYZHdXVCszK1o3MDFDaGlkRERuZFBacFJZbU1Nak5rWUdMZmUyUkZT?=
 =?utf-8?B?Uk8xcWxOM3ByZEZ5TzJqcTVWZklGekZ2Um9JcG5kcFBEWm56TkRmc2FpYVJx?=
 =?utf-8?B?M0lXRVlmeTVPaHcwQXdJc083b0E4Z2xpU3FFeG5SVWR5emVUYzgvdDNrNm1C?=
 =?utf-8?B?MTRNRmtNQU82dzZycnFpU0tRdENsZUpaT29EckFBNjJrY2taWnNuRzZzdTU3?=
 =?utf-8?B?c1dhVVBHVWwvVFFzRmxyc2lYaGdtQ0FTM2k0U0k5QVVRV0orb29pNFJTS0lX?=
 =?utf-8?B?QTdtb2x2YjFwR0pBSmlLUVRMS0lZTEV6SGtFT3Bnc2dieDNuWG1TbTlMZVZk?=
 =?utf-8?B?MkovRW9IS2FxcDFpMHJXanA3ZzFHWmwvbUdxRWE4M3JWeGF4dk5YcWFTUitl?=
 =?utf-8?B?Sm5haVM2Wk9QaTBHNXo4N2RXTnRmZnJKQmkrMUJERjkySk51OVdzNGZJYWVt?=
 =?utf-8?B?amFKODZtNVBCYmJNV0wzWElyUXRnaGdMeUt4TGFTUEdEbzFrQWlFdzd0azhQ?=
 =?utf-8?B?YjB6UDRVTFJ5QTA2djI3WldwbG5CeU5RTTBvVG5Zd3BRakVEVy9qOXhTKzRo?=
 =?utf-8?B?WGJ5OHRKNHdYR2lNMlZTNXVicXFiVnNTNFJ3Y2JiNmVNQlRLVDhBTzk2VFhW?=
 =?utf-8?B?Q0xOcUdGMTUvSy9rTWUrU3VlNWRnaUtUK3YzaFhJMHBvU1V4ZFhBbkllZEhL?=
 =?utf-8?B?QWVFc0ZoWXkrM01USHU4M0k2eU42TmwyTzJFNGdQcyt0Wlo4TzFWdnJCdTZE?=
 =?utf-8?B?blViYWhqaDNDQVNlbmRuTVRpQ1NkaklNYVUrNWowem5MNUhhUytLdldNSmdR?=
 =?utf-8?B?NXJ1ZUhLUGdSZkhTZllzKzFPbXVHM3grT1pDZEo4cTliNlNXdU5SWjloSTdG?=
 =?utf-8?B?YWpLZkFBanhtSXhTR1huSG4vVVE1Ymc5R1FyenlkTjM0OExkZTdTbWNvK0V6?=
 =?utf-8?B?aHhNaWcveUU4UXJHMG9KZkxhaCtES0kweDZtem9tQXhEUjRjSWUyd2l1QzBL?=
 =?utf-8?B?eFlHclIzUzVuV3Mvc250OFQ1V2ZuMnBMUW56UnljMEg4dGF4L3gvTFVJYUgw?=
 =?utf-8?B?VnhRZUNHaVcrTmZUNGhuS1JWUHBiNDhQcnpOSytMK3IvVkliSE1oRDNRMUc5?=
 =?utf-8?B?QTRtd3ltRVRWcGRUQVBONTNtOUdVcDQ1L0lDeGJJVHpEMzM5SndWWk9JMXRD?=
 =?utf-8?B?aEZGNFovc0YwbUpkVFZDbUozdDFnYTFlZHFDQkJ5RDZtci8zOW15Q3FQWGY1?=
 =?utf-8?Q?AFoVcChwl/QEilvq0VNT03Rub?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56eff77e-76f2-4d3b-92a3-08dcc73e015a
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 08:47:10.5241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5CQ314r85o1jcXX26BeU1cWlQJ3hwDEshaLw3eEagUKEltVwaef5lwqQ+sWEvE54k7oQ8zeMNLvlrY0BCxGIFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8412

Add basic Wi-Fi support on Khadas Edge2. Wireless driver need to check "brcm,bcm4329-fmac"
compatible so add it to Apple's devices.

Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
---
Changes in v13:
 - Change patch 2/2 argument from driver to bindings.

 - Link to v12: https://lore.kernel.org/all/20240828033953.967649-1-jacobe.zang@wesion.com/

Changes in v12:
 - Add fallback compatible for Apple's devices

 - Link to v11: https://lore.kernel.org/all/20240816015214.1271162-1-jacobe.zang@wesion.com/

Changes in v11:
 - Split DTS and submit separately

 - Link to v10: https://lore.kernel.org/all/20240813082007.2625841-1-jacobe.zang@wesion.com/

Changes in v10:
 - Use ret instead unused probe_attach_result in sdio.c 

 - Link to v9: https://lore.kernel.org/all/20240810035141.439024-1-jacobe.zang@wesion.com/

Changes in v9:
 - Add return -ENODEV error pointer from brcmf_sdio_probe as the default for the fail path
 - Add if statement for brcmf_of_probe in common.c
 - Retain modifications to of.c other than the return values

 - Link to v8: https://lore.kernel.org/all/20240805073425.3492078-1-jacobe.zang@wesion.com/

Changes in v8:
 - Add appropriate errno's for return values that will be
    send to bus when error occurred.
 
 - Link to v7: https://lore.kernel.org/all/20240802025715.2360456-1-jacobe.zang@wesion.com/

Changes in v7:
 - Change brcmf_of_probe prototypes from void to int, add appropriate errno's for return
    value, move clock check to the end of brcmf_of_probe
 - Add "brcm,bcm4329-fmac" compatible for wifi node

 - Link to v6: https://lore.kernel.org/all/20240731061132.703368-1-jacobe.zang@wesion.com/

Changes in v6:
 - Move "brcm,bcm4329-fmac" check to the top of brcmf_of_probe in of.c
 - Add return if clk didn't set in DTS

 -Link to v5: https://lore.kernel.org/all/20240730033053.4092132-1-jacobe.zang@wesion.com/

Changes in v5:
 - Add more commit message to the clock in bindings
 - Use IS_ERR_OR_NULL as a judgment condition of clk

 - Link to v4: https://lore.kernel.org/all/20240729070102.3770318-1-jacobe.zang@wesion.com/

Changes in v4:
 - Change clock description in dt-bindings
 - Move enable clk from pcie.c to of.c
 - Add compatible for wifi node in DTS
 - Add random seed flag for firmware download

 - Link to v3: https://lore.kernel.org/all/20240630073605.2164346-1-jacobe.zang@wesion.com/

Changes in v3:
 - Dropped redundant parts in dt-bindings.
 - Change driver patch title prefix as 'wifi: brcmfmac:'.
 - Change DTS Wi-Fi node clock-name as 'lpo'.
 
 - Link to v2: https://lore.kernel.org/all/20240624081906.1399447-1-jacobe.zang@wesion.com/

Changes in v2:
 - Add SoB tags for original developer.
 - Add dt-bindings for pci14e4,449d and clocks.
 - Replace dev_info to brcmf_dbg in pcie.c

 - Link to v1: https://lore.kernel.org/all/20240620020015.4021696-1-jacobe.zang@wesion.com/

---
Jacobe Zang (2):
      arm64: dts: rockchip: Add AP6275P wireless support to Khadas Edge 2
      arm64: dts: apple: add "brcm,bcm4329-fmac" fallback compatible

 arch/arm64/boot/dts/apple/t8103-jxxx.dtsi             |  2 +-
 arch/arm64/boot/dts/apple/t8112-j413.dts              |  2 +-
 arch/arm64/boot/dts/apple/t8112-j493.dts              |  2 +-
 arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts | 16 ++++++++++++++++
 4 files changed, 19 insertions(+), 3 deletions(-)
---
base-commit: dabcfd5e116800496eb9bec2ba7c015ca2043aa0
change-id: 20240828-dts-1b163375c49c

Best regards,
-- 
Jacobe Zang <jacobe.zang@wesion.com>


