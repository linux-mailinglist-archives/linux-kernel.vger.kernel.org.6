Return-Path: <linux-kernel+bounces-304612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF40A96227D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 10:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 769D22858C2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 08:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC43D15FD1B;
	Wed, 28 Aug 2024 08:47:21 +0000 (UTC)
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2111.outbound.protection.outlook.com [40.107.255.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F84715E5A6;
	Wed, 28 Aug 2024 08:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724834841; cv=fail; b=tewcuTUIuxavpzJthtleaLaYpK8aJwT6/bxOoaandFzpy53+U51TXq1vE8LBubVYL9D6mjndpb8hB8NA8NEbcR02JETx+B2R5FuJfbjXBDAngnGCn/F9dzJOXR7/VqL6tydrVOG3i+zLV2cTUI5huqqs6qbF/kcjY2g03q9kepQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724834841; c=relaxed/simple;
	bh=LaLu3quqGEtYiHhIevE9m8Vrk5cGprDYd1V9ZIbpPsY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=U+N+1USaXcKSB0kFE9a2hjSOqUL809Kc7bW88KvT9ohCjidx1aj1OC8d2qWV8V9VpSxOh0sq5kokf3d0TpIBQeV7/LCbs6BeHTbOdwRcnWXODkb8lmXh0ImMvQ8h+d1iSlqnGfTS82X60zrJ/4NCPdHHDHRSQsHjh4FR5nzCSF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.255.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qrwg2+ZAFshtPgYqZlfvfs5yMOkYYDIkmHNt1G1u+mclpf/94Lqxi37auhBvp0CbectGqtQx7LpBzjniLy55KuygHSciVMMS6JciQ0V3uXbxj2hmi6mKAZSzluC1MDPhnUh7WOYuKOzJS8CYj9vxB65winNSLjFZ0O2FlHyjxWh6fKDrrLkbHMf634p8/crJ5XMytmJllSnQ5HxEhUG4M/YE+Dyyl+oyrevIe/SPBaWjtL66QdaQShZ1dtpSRJpL0sgnTJ14NWAHdC0dGkRnj9UqzEi4jzq9wFRHRUbYUhTgB6VWvfDcPAHkFaZqg0FNZfhPZAW0Ijy+mWjqr7zn6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DDkoga+CZqogSQrYJu1qtK7EDMPF+U6ZVL0L9vt2D44=;
 b=UL9KLyi6+1fwzV6yl1+W4oPkpd9D8H7VUBKnvVxT2wfYRG7baSKKKIJjCYBRHNyTMtWQ9GfSIOq5YjsHxwZD20rQ0kqWmZveAN74tS0ERqQ6Xzbiu3hQp+KpPpUPD3Di6VpEAyk4CaQqxi8BcIiFB/656owmFnJoEpcW4k2dY8T8nHsioBY7I03nrmH+LIvZWNuUfPB3tSTiw4tSgnRB+h2KGHSGEuAXEDLvVlTTsTNZZeNlDuLGH9uwhHcIy/ra0hE+tjjqkSvdtjlXklZ/O3bPVFPrEIyHBI9DXiXrQSovxLYh2Iib14qhKdTmbOoRkbBrrPX3WfP/zZw4L58rBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by TYZPR03MB8412.apcprd03.prod.outlook.com (2603:1096:405:73::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Wed, 28 Aug
 2024 08:47:14 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%4]) with mapi id 15.20.7875.019; Wed, 28 Aug 2024
 08:47:14 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
Date: Wed, 28 Aug 2024 16:45:41 +0800
Subject: [PATCH v13 2/2] arm64: dts: apple: add "brcm,bcm4329-fmac"
 fallback compatible
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240828-dts-v13-2-6bff9896d649@wesion.com>
References: <20240828-dts-v13-0-6bff9896d649@wesion.com>
In-Reply-To: <20240828-dts-v13-0-6bff9896d649@wesion.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 asahi@lists.linux.dev, Jacobe Zang <jacobe.zang@wesion.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724834828; l=1983;
 i=jacobe.zang@wesion.com; s=20240828; h=from:subject:message-id;
 bh=LaLu3quqGEtYiHhIevE9m8Vrk5cGprDYd1V9ZIbpPsY=;
 b=czW5wBnzDsG9oK6ichqH08lg7LtkWwySihoERQNAd9r3r6S8HzWXKGfw1vOSLA2ZE8+YYW4xm
 aCYxIOqzTPGBI/yTmhN0ztpXz77H2DDxjiuBkByLvgW/ZadlQz9VQNm
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
X-MS-Office365-Filtering-Correlation-Id: a47fcbe7-9ef6-47d0-f3ea-08dcc73e03eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|366016|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bURHN2RQc3BxSThBcVRldnJWVFNSZE5tbFRIeTBJRk1TR21FVFA5MWNuN0Mw?=
 =?utf-8?B?YW9LQjVXNG4yUkt1MzJnQ2xxcnZNOVhxR2JyU0EwdWhkT3hZcCtjV2w4ZkxE?=
 =?utf-8?B?TDQ0K0ZwK1lOZnNLSHdDOHhHUFZHaGg1akFKMUZDeGpuTTlkV0h5M0k4TUFH?=
 =?utf-8?B?U1lxSjdwSWthRkZwR3pFRCtncjlyaHFyUnB5dkxhNDEyVmkzZTBmWndmMnJX?=
 =?utf-8?B?K0xtMHZkUmZTaDRYLy9BaG1IOFlaaTljZnhmRzdrZDZZS1BmMEh2VnNlRGZs?=
 =?utf-8?B?Wk1PT0JPcEwyend5cFNYTlpVVXE5bTA3bkpiakwxdkVsTzBKUXc2N2RXenpk?=
 =?utf-8?B?em4wRkdRK1NVcGswSTVPOWUvRi96bnBqM1l2akFaUmxtcFJmcXVDcmRFMk02?=
 =?utf-8?B?RUxkVWtreWxHN1hIUDBrWlR6VURGTG9PbDQvaGEySmUxaVZKbTJmS25EaUNS?=
 =?utf-8?B?elF0amdBOHhnUnN4bGdqVkpleWEwZjFpTWNGbjdDeTJtYzdzMlIwMkVvWS9O?=
 =?utf-8?B?bnZLNzgwTU5XUmdWaU1HRW9OQSswYzlOOGUxRFUwSzVjR2hqeEhzSjlRWXBx?=
 =?utf-8?B?RDZ2ajdLWDZWQ0lNTXJ2ejQ3cDRnU1dvWU5GYURvWnJuZ3lDaGNZZlpNbm4x?=
 =?utf-8?B?THlsNHdpWTVkemNtNjhzRVhUZy83Q1oyN2VjelppTTMwTWpLaXVJMDZFcDlQ?=
 =?utf-8?B?ZFZSOHBhQ2RNOWQwUDFVVTFTZFRTMGJYaGtmd1EzcVlLLzMwVUd6VXpYeVlK?=
 =?utf-8?B?TzB3OWFYN2pZRlBxTTA2TWdwOENCbHI0UW4xdG5aeVZEY1NLRlpEK3U3MU9i?=
 =?utf-8?B?L08yS0NkT3BRb3REdkxFeXVoV015a25BUExuZDBWclZlLytXNE5HeGg2UzhW?=
 =?utf-8?B?VUxlZlVHY3B5enFhOERuUkloK3NJODFEdjVXY2tTb1J2MklOczBPZ1l3Z0NI?=
 =?utf-8?B?Mk9QSEk4cDZ4LzNxR2R2WTgxbkQ0bkh3ZTkxelRSMkwxYzN4RmxRd0JEN0dm?=
 =?utf-8?B?UWRVeGQrZjMvTW5ROVBuTzBEOFRMaVlwQWtndVZaOTI5Z0VMeEIwd1NoejVC?=
 =?utf-8?B?cjlPZXZKa2NwNmtnVFpYSFJVR1FLZFJrSEZWNitlZnVET0hHcWJNeCs5UnpX?=
 =?utf-8?B?aDVKaE5mcGRlSXpuRFhiNnliK2Q5ZURwRHJTOXhSWGZrMGo3Wk9Gb3c2a0Ni?=
 =?utf-8?B?S1l6VHMrMGl3VURlTko1WkllNE83VE9IZWxXN2Z6MC8yTlAydTBybHdyd0JK?=
 =?utf-8?B?d09HcVREYWYydTA4QVhmYStMZXAyNDh4NWRIVklZdHdzenhkK1M3OU9CMnVw?=
 =?utf-8?B?RTlnWE9XYTNBK2xtRG16NXB1em10YXpBR3hrRkNMaHE4dU0zOFFtSWRSbUZp?=
 =?utf-8?B?V3QwU0NGSUc2b1V6THBRZWh5NC9lM1dmNitqaitvNEFYdHduMVpnOEVsYjV4?=
 =?utf-8?B?aXFOOTdpNCtFdGlDMXk5QU9mNElkRC92SjdhUlg3UllhQ2xRRUFKbnB4TGZP?=
 =?utf-8?B?dVZJQUgyWFVMQzJNMzhxSzdwWE1LNE1Sb0FMQ0JkSzdZU3NEU3lrZzBudE5l?=
 =?utf-8?B?M1ppUlhjUXdtL3BaUXhFR25jUHdqeS9RY0RnZERxYWdkck5HT3dPOGkrVVE5?=
 =?utf-8?B?bGRFaDZac01HTndIajFDQ1dDTnYrdHZDV3NsZ3RnVGFvcW5wUGtUcmgvdW5p?=
 =?utf-8?B?SnRBN3QwR1F6czVDLy96THlMRUM3VmJ3czNFbVB5YS8xMjUzRVlnakhXNENw?=
 =?utf-8?B?K09IVWRWelVCejdPSVlzSWZtK0NmM1JidUM1NjltMFpUV0xQUkQ2M1FRa0NT?=
 =?utf-8?B?T042ZVVJNFphUktCejlWOU8vREJmMVFIZjQreE00c004KzZvZlhzV3FJRExW?=
 =?utf-8?B?M0NwelI2OHZLWTVRRlV0K1R4d0w0eXNNSk1veFdyMmVab0E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(366016)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGxyY001N3VLYVZzWEZkZ1g2dkJ1REVuNTl0NzBtTG9IZ0ltZUU4R29OdElr?=
 =?utf-8?B?TTB6emU4Mm9adFRHM2FVUEZRMlh4UnY2RjMvQTlZZUlRckJybitEdWcydjAy?=
 =?utf-8?B?bE5GYWxSL2VqOGtJWFcwR29NTVk1VTlTVmxlTHRqZ3hkbkZxUUFOeUZIcmdN?=
 =?utf-8?B?OGxUN2swSmRGR3k2K1gwWlFHYTBaM0dHUHdBOVo1bk9sZVhIWGVGQUpzVGtp?=
 =?utf-8?B?eGM4RFgwUDNGSVdUUElFL1ZyRWx2VStnOU5OeStiSkVtaEtmdmJSN2RhbXFL?=
 =?utf-8?B?cS8xWnhtNzFuaFJIVkwvN0p4Y2FFMkt6MXBvK0xRbTVSOEtaVjdsU3FRdld3?=
 =?utf-8?B?cmIwQUhCeVNtdnRsVk0xWDc1OW02YmFHV2Y0V0ZVdkg3KzdRVlhDL1gzODN0?=
 =?utf-8?B?OUR0dVpCb0JQZ0hLWjBUVnB1eWJQS1J5N29oMHJCNUJUdm56SHNIczJiUkJ4?=
 =?utf-8?B?ZFdsRnFrSFo0RDJyZkF5M1dndHhDMy9SVEVvemYrU082ZVdGQlpoZ1o3TmJ4?=
 =?utf-8?B?Z0IyL20ySmQxYTE3eTJGdXZIZU4wREdNeHJ2Q3RhOTJUcUhEMnltdElnMFFX?=
 =?utf-8?B?N3cxYnRKTEpqaHAvZkdheTZwZW1mdTBuMy9HU1d2dmhRVm93V0tabXJwNkVp?=
 =?utf-8?B?OE8zRTFDOWNYTUZQQ21yNDdmWVVRenlZYVFuYVJzS0hxSUJoaUF0ZzEyVmh2?=
 =?utf-8?B?cUJtcG9aTUlSb21HblFVN2doaHFscEpyV3F4L2p6SjY2RE5JN3kzdFAvN0pF?=
 =?utf-8?B?b25pWW1hanZCKzBJbThXaC9Ucm5kQ1JRVmxYTS9WOWpGbFBhVWd3bzQ2czRy?=
 =?utf-8?B?cUMwZEVHTEpyaVk4ODZYblVDakVyQ0tMMkpDNkg2ZFJ5TEo0YVV6Q2Vwd1Vt?=
 =?utf-8?B?c2lKRlZ1cjFhRGEwaXdFQjVoM2c2OWgxR09mR0dNeWdhUXZuLzVqZzcyVm5Z?=
 =?utf-8?B?MklkbkFkK01HZC9iaTN6YUNMdUhCN0Y3eU92eXExU1J3bkFoRk9OMHJQa3pI?=
 =?utf-8?B?clJyVERFb1pUa2RSNjlMb1VneWxsOUVnNzRRaW5VVjhpdEpBTndaZ0M0dWMy?=
 =?utf-8?B?Y3VxQW8wcFpwNXQ1alVYQ3RwYkxBVkdtZnRsUkw3aUFxazhScFl2bDVUUTF0?=
 =?utf-8?B?a3hCQncwaWo4WlovTzFCME9GYmlFbEhDTms5RmRFUFNJdmlYaWIzaTZmUFVO?=
 =?utf-8?B?SHRUM1gyT3BaeThPY2x6ZzY2QUlvL2xwRlY3ellBaHAxRzhyc2ZXOEdMZjdJ?=
 =?utf-8?B?K0NYTnUzekgwRGxYOG1ZdUZ0eUo3MklLTXd5Wmh4bG1kL3pLeFF4aWZOWmZD?=
 =?utf-8?B?ZWJxSW1lNXFVVElCKzJqSlFFMlpUMjZvT1VuZDVXNU9oaEc5Q2dDNmZ1Z0V0?=
 =?utf-8?B?c2ZqdEc3VXg2a3BBK1krQmdveFNvV0tkbFRFbTRQUG5jVW5TcEllbzhHazZM?=
 =?utf-8?B?azFNSVB4WjQ4RnJiREpHUkRNQUp1d3lkMnlmSklGV1R5RGduNDZUblp1OFpi?=
 =?utf-8?B?YmJwQlJDczBDMmpFOGR5cld0NlR2aDRlTkRKbUZkbEFmcGovOVNsTjNCSS9H?=
 =?utf-8?B?Z250NGlpaVRJWkwyeVdya1BNdndVcjAxVlpMZTZnYWx5enBqOXoxR3lyZndh?=
 =?utf-8?B?N25wZUhaa1lyOGt4WFFZOFRHNDNNcmdLWFZ0WlRPQzhMUmZKNUxHa2Q4eC9L?=
 =?utf-8?B?S3R0ZnBwa0paRm1mWjNsMlI0aStpdjJzbEFmeURCd3lHWHVuQjlBWHdEK3la?=
 =?utf-8?B?YjhUbzBaZkFKcVhxSkdBQ1NFQVhtTG5UVHgwRFRDb1NpWHpJZVRxcUx4eUVO?=
 =?utf-8?B?M1ViRUVzNVlBc2w5aVNGZVNhNS9UdTljNGttTlJKNDB2Y0RaeGhBMEg5M2cr?=
 =?utf-8?B?OU9kUEV3S01SdmFSNkF3UXFWZlRQKzlzc1N6aUxCdVJ4YktnRnpRTnRzZ3JI?=
 =?utf-8?B?N2NKREZVcll4MDNlN2MrOHBjUFBPclBKQUE1enVzOWUrejZTcytUS0JaKzVB?=
 =?utf-8?B?RC9YdWtEU0lHa2JOWTQ2NnRHRDJTbUo0NkY0OFBFYi9OUkl0L3ZXS0dTaXJk?=
 =?utf-8?B?U3U2cHk1Qzl0aTdCVHlCR2lLNlBBN2x0cE1VNUNvK3JGWE1rNlptVGpSSjdE?=
 =?utf-8?Q?Av4JGNr1z4NBytAECvx1TuR+U?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a47fcbe7-9ef6-47d0-f3ea-08dcc73e03eb
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 08:47:14.8109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jcb7S2x+XMVjrIbzt3tBuqeLO1fejSl60bOogBTBSiFbekTqqqlrEcHICu3A9T1UeFoiIV9RqDFE65Ju7r0tYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8412

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


