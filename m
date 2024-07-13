Return-Path: <linux-kernel+bounces-251604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCA29306D5
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 19:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06EF0284C72
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 17:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9283E13D512;
	Sat, 13 Jul 2024 17:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="NE41yHkE"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7864710E0;
	Sat, 13 Jul 2024 17:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720893453; cv=fail; b=B83YBuNODsE9RMXcHfqzsIbC6Z2iP2S47iln0niN5CyonPb2XnQf6iX+oi+js7IV4BGoQXxfOTCyP+mXQx7tUHpuxiQzr2b981xNYDjoiYF+/bvy1iEy31DC9JgptbBQ+8A4nCM3KkIqDtvZWWB+BZYoJt6Cy/EPyonJmxR3XXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720893453; c=relaxed/simple;
	bh=2w7XeVg6sG/z8AelTv6JjxxOwmiEGuN7jdTI9qsCqc8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GsyYdbiZ6pSTXEX0vGt7NswSL62DzalEy8VDzc09GhbZJJeK/HxwY5+NJElHp6bOoc8wgOVFOGe+BZCvh1TCRCZo9Yv6j8grY/5Grs24q9OFL25/doTfWVWZDxGFLbzFe5/sOTniXu48SG89ujHXBpWUz5Rma9LZ7V7P/Ywpdr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=NE41yHkE; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46DESth0010073;
	Sat, 13 Jul 2024 10:56:40 -0700
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 40bs3g0hyr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Jul 2024 10:56:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KMqgkbIe+8UB45pEHm1x1uRK8eYAUIxMxMm6SNJW804MEL03wz0Br8j80mR4sboyNsg7iFR1pEJPphd97XWM8mxF0oEsFvDyYxcLoEBJRGCJgcCATxwUYIIjz2PEqNbh060nol3WHBVpMqxWLAo9BgYtmcneiCLOd41+9L1bmw4m3jN2aCJ+hBGLMq5W3ilPIInglMCGo/r+RWYpmiKfp+2jX6xU3uJ2syqOLiMLNiQhBqlC7y3Sp0XlqyuL4PskVbvDI+WehG4s2EEJ3Q8h7tpDvv0l1BwO1xtMIjjNvkaamMp4IvoYB/GlaRLbONgIFdfAPIbY6dfjq9vcTrnZNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e0U88dyEbCxkVWJzJOfhmnxph8uMaNEsPgrOFhEFjSc=;
 b=XCqDeohRCv++1rERQRY09eM8i5IynIsg/RQg0IzXqr0hMPpduSlQmPOH4ujxlttQmykUKYrpvYPiSUrSO2MuCNf3+iEKznI31xQEDvhQmlA1zCUuEsM66a9QfVuoPaqesW0/358OQH+QkMJZhttg9fVnyTHP1OLfzKNwpfYC5b9BTeCVsfu5CDZYEoBGbzSlzuhbroJV3xSZapeCnEKEtyb3BTVDxkjesGWk8gpfLLn4oNqCIXkpJafpZvfunIHsx5MbKq4j9WIOkWOnms6fXEUGJRuAVg+ppOBhNk09U4U9ZbbKifyYC3Wzb/fZbL/mYWZDli6hRo2Tz/cSPRhuGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e0U88dyEbCxkVWJzJOfhmnxph8uMaNEsPgrOFhEFjSc=;
 b=NE41yHkE1j01MnN6SCusafyufuXRpM+lEGJeKc/RMYSidp3x2OBy1m8hYkq9YUB7vDgW3mlmISvwumBVavky7HW8xfiqhDyFkHLoRc1svvE5qG53lpPDKMYBhr3VMV6h2cIaFDyy8+RzrOuRTl5r29bezc6W4Gwdy25cKD01OXE=
Received: from MW4PR18MB5084.namprd18.prod.outlook.com (2603:10b6:303:1a7::8)
 by IA3PR18MB6187.namprd18.prod.outlook.com (2603:10b6:208:51a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Sat, 13 Jul
 2024 17:56:37 +0000
Received: from MW4PR18MB5084.namprd18.prod.outlook.com
 ([fe80::1fe2:3c84:eebf:a905]) by MW4PR18MB5084.namprd18.prod.outlook.com
 ([fe80::1fe2:3c84:eebf:a905%6]) with mapi id 15.20.7762.020; Sat, 13 Jul 2024
 17:56:37 +0000
Message-ID: <6a216234-06c5-4e14-9478-f1cdb3514a20@marvell.com>
Date: Sat, 13 Jul 2024 23:26:27 +0530
User-Agent: Mozilla Thunderbird
Subject: [PATCH v5 4/5] firmware: imx: add driver for NXP EdgeLock Enclave
To: Pankaj Gupta <pankaj.gupta@nxp.com>, Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Rob Herring <robh+dt@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org
References: <20240712-imx-se-if-v5-0-66a79903a872@nxp.com>
 <20240712-imx-se-if-v5-4-66a79903a872@nxp.com>
Content-Language: en-US
From: Amit Singh Tomar <amitsinght@marvell.com>
In-Reply-To: <20240712-imx-se-if-v5-4-66a79903a872@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1P287CA0006.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::34) To MW4PR18MB5084.namprd18.prod.outlook.com
 (2603:10b6:303:1a7::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR18MB5084:EE_|IA3PR18MB6187:EE_
X-MS-Office365-Filtering-Correlation-Id: dcf3215e-edf1-4d2b-03cf-08dca36523cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?VWlVRkxwRVRXZXdFRm11WEI2TzZLR0puU3NueGUvdTVpL1VJWk5TRmNSWWFF?=
 =?utf-8?B?R0JLOVZCMzRaak9sTURXSzNLRFNQZFdxSDJXNFFjVmlSUm92WXhJOGlORmNp?=
 =?utf-8?B?dVN2dFFFaG5ReHVXRnowVnY3UVhJSnJWOVpPcmU3MmtHRUN1L25Vb3BZZklU?=
 =?utf-8?B?SVVpWTZ4cDdTMkxmei9jeXhjZVlSdHVZeW0wMk1YS0RGZDRIWWJMaG15TGIw?=
 =?utf-8?B?ZWhZYjhQMVljcnBmOFYvRERUelBnWENwckxiSEt2SVdETVh3TTMzQmVNSDd4?=
 =?utf-8?B?dmY0cVNRVmdhVkJPN0t5VmdFUFkyVy93T1lkd1IwTURqSDFzSTJGMkNnNzhy?=
 =?utf-8?B?N2tOQUIzaU1haWUwYThOamlPa1ZGaG8zTmE3cE5xVUYzZmVQbkpMdHJ5SW1J?=
 =?utf-8?B?b0xqVXpNZ1lrcm9lSmN0b3ZoQVFQa3RHYUVqWkVEemNMWWFWa2paV3lJTjFZ?=
 =?utf-8?B?YTFrS0lXczdUcjZKdTRhbGhQeDk4K1J6ajRFZlhpY25pUUVlR21RR2I4QTB2?=
 =?utf-8?B?bnFDUS93SVJDcVFxTU5HNzB4bks0cExXUTQ4MkJDbU51aTRqSkxsSkVXazdG?=
 =?utf-8?B?MjB3U1JsbEZSOEVKVWs4TGZLK053YXJCb3luUUEvWmhxcXFzQUhKS1NDa0dE?=
 =?utf-8?B?QVdwaEw0cDdFZTBXeEFjSEFhV0U5bDkxRG1xd0FINk1CZnlraERxeEJJTktz?=
 =?utf-8?B?SGZIZzArcWdhWEM1VU1JTXhtaGVFZis3N0daMTRpaUM3dm5sZFdEVWJZZHdI?=
 =?utf-8?B?Y3lvelpDa25pbjNBWkF5bTc2YTNINkNSSE5scmpaM3ZjcjVqa3F2QWtIdG85?=
 =?utf-8?B?Z0NwZWVqY2JnOHRoSGswM2NnaTJzT1AzSitMRnNYSFJtdERqT0IrR3Yxc2Iy?=
 =?utf-8?B?R0cwNlFraytKZUJsUnpMM3lUZUhSNlFnTmZiaFkyeTNQOVhiUUdYV3hNcEFz?=
 =?utf-8?B?ZkNJY2loMm9zMlBGRkRDU2twVDBtY0ZQMUNFS0VtbjNoTWtRa0ovTUJGa3Ar?=
 =?utf-8?B?NnhZVENNVUlickZ0WnFkR0N0TDd4dDlkUWZsczNEVHpqQi9senBCblBDeWFy?=
 =?utf-8?B?RXlsZW1Zd0o3K3hqUkdOeHllL2dNYXNZU0pPalRQVlFTWThYZHB4S0ZJU2xS?=
 =?utf-8?B?eVNjcnlKbGxVNGZLek5GSmtnc0w5ZG9YYkN4SVVxQk11T1l3RVN3YUhaS0tZ?=
 =?utf-8?B?TDFsWm9VUTZwT1Fxall4cFEyNnVkN0ZPdDdONUFvczY0T1dnMDRNZkNRMC9X?=
 =?utf-8?B?elNvaUI5WmJ3VUZYMmFMTVZ5NDROaGp1YXVVWkMvb20zYlpacVRReURWcG05?=
 =?utf-8?B?WkcvbUpsUHJ3eHRud0haRkQxeUt6R1BNdlcyL214S2dJS1BVeGFZTkZWOXpi?=
 =?utf-8?B?N2FXbWZLclYzdU1qdVF5YTdLNWhORmV4TjRJMTc0QWRSUE5qMnEvN2pYNmJ4?=
 =?utf-8?B?MGhjeURWdWZOd3IybzhaQzEwOEtJVE5URTQ0amkwSU10NklJRkRWcmJNSEtX?=
 =?utf-8?B?WHNvQ1h3bTIrVFE1cHVObjc4UUcrNmdiZkF2U25WaFQvWGhWVGwyVlRNVlo3?=
 =?utf-8?B?RlhPSHNsU2NzRlN1V0RFZXVVRXQ5ZlpJKzJ2eXNmNyt5Ni9FbmU1dHlhbkFm?=
 =?utf-8?B?dk1NT0Q4dTZVOEFCc3BNdDRCc2JDcXpwaXRJRUFSNE1QL3pkNGcyYy92c1pU?=
 =?utf-8?B?ZzJLZE1aWm01MlFHeUhHRnFuTEs4NThxRnp3b2VSWnM1azBVcWp1TktDNUEw?=
 =?utf-8?B?Qm0vUG9oeHE1MXZiWDN6U2kwZEd3OGJlOGNLSXIyeE8zOWQ2bmZJd3ZHZVUx?=
 =?utf-8?B?am1lTzdVc3NYdjY3clg2cjd3aDZRZ3M1c013SHpJMno3Z0pwdVNGM3BlamYr?=
 =?utf-8?Q?uvB/L9WV+0j8y?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR18MB5084.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VDdEM01rcXVhaURMNEh2YnRRY3RFQ1pKTS9obk1Ebk5NU0txWmoxK3JwaVh6?=
 =?utf-8?B?MHNqcFlqUEJLYVREQVk1L3FQcU1VWlBjZjhaNWROc2d1aXRzMDYwaHNQRTlF?=
 =?utf-8?B?REtSblZuMkJNME1hcUVhKyttZVQzcHpRdERoTnNvc005R1ZyMitZd0RRV1BG?=
 =?utf-8?B?bDMrQ1NQMTVOWUdKdUdpeE1IZWJRaExzN0w4OTRxb24zdmJRVTdVOGtmUkV5?=
 =?utf-8?B?MnR5TFpVNmVCcEF4eEhZc05HWTQ4aFJyWFkzb2JsTUY2b2pvdTI5R1QvbXIr?=
 =?utf-8?B?OFdvYllpNFlPV3VjeDE2UUpFSnp0eTMzNndVdklmK2xJa0pDSXR0aytHL09Z?=
 =?utf-8?B?T1RmdHMxNElFZFRnNEhXd2tMeW95TCt6Sk9kaGxSbG5uR0d1M29mM01tZUEy?=
 =?utf-8?B?eUdWVHNsZ2cwL1pnNzhpTU11NXdYbnJVMDdBYUlLc21zMGNubGpTWWZZekcw?=
 =?utf-8?B?R2lkR2E3SjZNU0MwYk14Q0s4OTMvNU5mQnJwSXVKWFdMWGlHUU40UWJVdXg2?=
 =?utf-8?B?dUs3NGFzc2d6MUEwNjY3YklROURpRWd5emZGeUdITVV2QUJWRENWSW9ZcW1D?=
 =?utf-8?B?UTB6eis1UGdKMDFMRldVT0QrbkdkdExFNzdyelU0blBzRXFiSXlKT0FDM09S?=
 =?utf-8?B?aWJFR0ZvOTBQSmdnQ2ZGZ0RNZjNSbkh4MGNJODh5LzRPejRnQ2pIQlBFYTh1?=
 =?utf-8?B?cTRkQndqTGVxc05BRTdMZzlyaDNHRENQdzhLcldMazBmTSs1ME12RXFJZE5Y?=
 =?utf-8?B?TVlaeWJaZ0FRVE5kdnNhcVAxMTNsWENEMXNQSnBETUI0SW5VTEVic2hlYlEx?=
 =?utf-8?B?UHlMV1J1a0pkSzJTNUxlTGVTQW4rSTNxR2FGUndrRnljUUtiU2JDemZ4d3N6?=
 =?utf-8?B?MjlVaTZPa0w0RWY5a1VzcXowd3QrdnFiSnloNFV2dGc0cy9yVlllUUZGeXRh?=
 =?utf-8?B?RWFpYmlwN3ZLeWFtbmJOTlJIaFlwWXAyRWFUMW8yRzJzVzczTnhxRm8ydVhP?=
 =?utf-8?B?ck1heEdLMWZWTGY4OHhFY0d1dXNrKzRzUVB6SzFpa1FVTUkzSEFsNDhVbUN5?=
 =?utf-8?B?dmY0TUNESHNaUWZSVEoyMkJORElhaFNhYmN1cklqN09yWmtvZkl3QkpNMVd0?=
 =?utf-8?B?OXBKbmlldDhtYW4rMGovQ2w1NEZlQ0xKYWdjRTJRVDRsa0hGQ2xkbWdxWlcx?=
 =?utf-8?B?TnVpUHJqc2VmTWdXZThMWUFZbHpmSkFrNVd6S0Y2OE81VElWc3I2SG9xdm1G?=
 =?utf-8?B?OXI4eUNDZVNva0VrMnpGOFl2Mzc2Z0dPS2hwQjNiVEcrNTE1VHVwQ0cyNjBt?=
 =?utf-8?B?bzB1ZGZ2Ym0rMGg3V2ZSamtnMEFoQ2F3SFJXSjlzcFNHek9LYXV2V0grL1pa?=
 =?utf-8?B?cW5zR2hGalFYcmhIT0wxY25MRVF1ZjJEK0RkUGQ5YXpUckN4UVY1RjlHY1JY?=
 =?utf-8?B?OUpyeDFWci96VlR6bDZsVG9rZW5MaG1qRWZjRGExekFLNGlVZXRjR0dhTzQ5?=
 =?utf-8?B?U2U4OWltWmhKZTVYOWpVcGJYWWhuR1hzU3BDVHBOaEErYXE0R2pLQnB1dCs5?=
 =?utf-8?B?R2crTW92OVo1V0ZEK1Z1SVVzNFNpdXlxSXJ0aGJvcThwV05WU1Eva1RoM1JG?=
 =?utf-8?B?WmVid2tQdTZLSjIxOWVkbmxBREZCQ0FnMmZUUVdIaHZZRkdUSi9iVGFYajRi?=
 =?utf-8?B?SHJnWXFVQWdIV1ZzNHFsTllvZkNDUStFTTRYa3BVYi9sM0hTWldOTnJjbGxH?=
 =?utf-8?B?WGVNdTVsa2hWdFJteDVaVzNkQW1ranU4ektTVFdFSGpUUmtnMENRR1NSaHpM?=
 =?utf-8?B?U3pkMGlOK1NiVWdjUUVqQUg3WG5DMTN0VzQ3V3FlZzhLZlQvQlFaL1N0ekZa?=
 =?utf-8?B?d0thSU56YTF5Vndod3RQcU5zckYvVElyaGxnVmtEL1pJNm5WYnRjKzQwMXV0?=
 =?utf-8?B?VE4wQkN1OVlKNTVQeWNwU29weUhTUmNJN1l1ZjlEcTdqYVRKOHFPZklNdmpw?=
 =?utf-8?B?WWd5am11Q01LZ1NrZHpTTEFsRW5DNG1GSTRxNFoxdXZNNEV1SjBNakhDWGxt?=
 =?utf-8?B?ZlJmK1I2dTYyVlN5azh2VGpJekNqUVRmTk5Hd1pDWDFRVVdHM2Y0S0ZQaHZO?=
 =?utf-8?Q?/X6g6n9YXzWQOe9fP91GyDrcZ?=
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcf3215e-edf1-4d2b-03cf-08dca36523cc
X-MS-Exchange-CrossTenant-AuthSource: MW4PR18MB5084.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2024 17:56:37.0507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uMB76/7Q1jDyjX5fYhfuEmlnfEBmjmLwTOIxrpaWGIH4oxWrKD5FofpcgjttGz0Z1SrnAP3UlSz+BSJQ3geJUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR18MB6187
X-Proofpoint-GUID: JlUZi6bvDKa_oTxF1TbVGKvRPadKpy41
X-Proofpoint-ORIG-GUID: JlUZi6bvDKa_oTxF1TbVGKvRPadKpy41
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-13_14,2024-07-11_01,2024-05-17_01

On 7/12/2024 11:49 AM, Pankaj Gupta wrote:
> NXP hardware IP(s) for secure-enclaves like Edgelock Enclave(ELE),
> are embedded in the SoC to support the features like HSM, SHE & V2X,
> using message based communication interface.
> 
> The secure enclave FW communicates on a dedicated messaging unit(MU)
> based interface(s) with application core, where kernel is running.
> It exists on specific i.MX processors. e.g. i.MX8ULP, i.MX93.
> 
> This patch adds the driver for communication interface to secure-enclave,
> for exchanging messages with NXP secure enclave HW IP(s) like EdgeLock
> Enclave (ELE) from Kernel-space, used by kernel management layers like
> - DM-Crypt.
> 
> Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> ---
>    drivers/firmware/imx/Kconfig        |  12 +
>    drivers/firmware/imx/Makefile       |   2 +
>    drivers/firmware/imx/ele_base_msg.c | 251 ++++++++++++++++++
>    drivers/firmware/imx/ele_base_msg.h |  93 +++++++
>    drivers/firmware/imx/ele_common.c   | 264 +++++++++++++++++++
>    drivers/firmware/imx/ele_common.h   |  44 ++++
>    drivers/firmware/imx/se_ctrl.c      | 496 ++++++++++++++++++++++++++++++++++++
>    drivers/firmware/imx/se_ctrl.h      |  83 ++++++
>    include/linux/firmware/imx/se_api.h |  14 +
>    9 files changed, 1259 insertions(+)
> 
> diff --git a/drivers/firmware/imx/Kconfig b/drivers/firmware/imx/Kconfig
> index 183613f82a11..0f6877a24f0b 100644
> --- a/drivers/firmware/imx/Kconfig
> +++ b/drivers/firmware/imx/Kconfig
> @@ -22,3 +22,15 @@ config IMX_SCU
>    
>    	  This driver manages the IPC interface between host CPU and the
>    	  SCU firmware running on M4.
> +
> +config IMX_SEC_ENCLAVE
> +	tristate "i.MX Embedded Secure Enclave - EdgeLock Enclave Firmware driver."
> +	depends on IMX_MBOX && ARCH_MXC && ARM64
> +	default m if ARCH_MXC
> +
> +	help
> +	  It is possible to use APIs exposed by the iMX Secure Enclave HW IP called:
> +	  - EdgeLock Enclave Firmware (for i.MX8ULP, i.MX93),
> +	    like base, HSM, V2X & SHE using the SAB protocol via the shared Messaging
> +	    Unit. This driver exposes these interfaces via a set of file descriptors
> +	    allowing to configure shared memory, send and receive messages.
> diff --git a/drivers/firmware/imx/Makefile b/drivers/firmware/imx/Makefile
> index 8f9f04a513a8..aa9033e0e9e3 100644
> --- a/drivers/firmware/imx/Makefile
> +++ b/drivers/firmware/imx/Makefile
> @@ -1,3 +1,5 @@
>    # SPDX-License-Identifier: GPL-2.0
>    obj-$(CONFIG_IMX_DSP)		+= imx-dsp.o
>    obj-$(CONFIG_IMX_SCU)		+= imx-scu.o misc.o imx-scu-irq.o rm.o imx-scu-soc.o
> +sec_enclave-objs		= se_ctrl.o ele_common.o ele_base_msg.o
> +obj-${CONFIG_IMX_SEC_ENCLAVE}	+= sec_enclave.o
> diff --git a/drivers/firmware/imx/ele_base_msg.c b/drivers/firmware/imx/ele_base_msg.c
> new file mode 100644
> index 000000000000..3b6ddc2c60c2
> --- /dev/null
> +++ b/drivers/firmware/imx/ele_base_msg.c
> @@ -0,0 +1,251 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2024 NXP
> + */
> +
> +#include <linux/types.h>
> +
nit: Do we need a newline here? If not, please arrange it alphabetically.
> +#include <linux/completion.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/genalloc.h>
> +
> +#include "ele_base_msg.h"
> +#include "ele_common.h"
> +
> +int ele_get_info(struct device *dev, struct ele_dev_info *s_info)
> +{
> +	struct se_if_priv *priv = dev_get_drvdata(dev);
> +	struct se_api_msg *tx_msg __free(kfree) = NULL;
> +	struct se_api_msg *rx_msg __free(kfree) = NULL;
> +	dma_addr_t get_info_addr = 0;
> +	u32 *get_info_data = NULL;
> +	int ret = 0;
> +
> +	memset(s_info, 0x0, sizeof(*s_info));
> +
> +	if (priv->mem_pool)
> +		get_info_data = gen_pool_dma_alloc(priv->mem_pool,
> +						   ELE_GET_INFO_BUFF_SZ,
> +						   &get_info_addr);
> +	else
> +		get_info_data = dma_alloc_coherent(dev,
> +						   ELE_GET_INFO_BUFF_SZ,
> +						   &get_info_addr,
> +						   GFP_KERNEL);
> +	if (!get_info_data) {
> +		ret = -ENOMEM;
This isn't really needed, and would've made sense with goto.
Just use return -ENOMEM after dev_dbg.
> +		dev_dbg(dev,
> +			"%s: Failed to allocate get_info_addr.\n",
> +			__func__);
> +		return ret;
> +	}
> +
> +	tx_msg = kzalloc(ELE_GET_INFO_REQ_MSG_SZ, GFP_KERNEL);
> +	if (!tx_msg) {
> +		ret = -ENOMEM;
> +		goto exit;
> +	}
> +
> +	rx_msg = kzalloc(ELE_GET_INFO_RSP_MSG_SZ, GFP_KERNEL);
> +	if (!rx_msg) {
> +		ret = -ENOMEM;
> +		goto exit;
> +	}
> +	priv->rx_msg_sz = ELE_GET_INFO_RSP_MSG_SZ;
> +
> +	ret = se_fill_cmd_msg_hdr(priv,
> +				      (struct se_msg_hdr *)&tx_msg->header,
> +				      ELE_GET_INFO_REQ,
> +				      ELE_GET_INFO_REQ_MSG_SZ,
> +				      true);
> +	if (ret)
> +		goto exit;
> +
> +	tx_msg->data[0] = upper_32_bits(get_info_addr);
> +	tx_msg->data[1] = lower_32_bits(get_info_addr);
> +	tx_msg->data[2] = sizeof(*s_info);
> +	ret = ele_msg_send_rcv(priv, tx_msg, rx_msg);
> +	if (ret < 0)
> +		goto exit;
> +
> +	ret = se_val_rsp_hdr_n_status(priv,
> +				      &rx_msg->header,
> +				      ELE_GET_INFO_REQ,
> +				      ELE_GET_INFO_RSP_MSG_SZ,
> +				      true);
> +
> +	memcpy(s_info, get_info_data, sizeof(*s_info));
> +
> +exit:
> +	if (priv->mem_pool)
> +		gen_pool_free(priv->mem_pool,
> +			      (u64) get_info_data,
> +			      ELE_GET_INFO_BUFF_SZ);
> +	else
> +		dma_free_coherent(dev,
> +				  ELE_GET_INFO_BUFF_SZ,
> +				  get_info_data,
> +				  get_info_addr);
> +
> +	return ret;
> +}
> +
> +int ele_fetch_soc_info(struct device *dev, u16 *soc_rev, u64 *serial_num)
> +{
> +	struct ele_dev_info s_info = {0};
> +	int err = 0;
> +
> +	err = ele_get_info(dev, &s_info);
> +	if (err < 0) {
> +		dev_err(dev, "Error");
> +		return err;
> +	}
> +
> +	*soc_rev = s_info.d_info.soc_rev;
> +	*serial_num = GET_SERIAL_NUM_FROM_UID(s_info.d_info.uid, MAX_UID_SIZE >> 2);
> +
> +	return err;
> +}
> +
> +int ele_ping(struct device *dev)
> +{
> +	struct se_if_priv *priv = dev_get_drvdata(dev);
> +	struct se_api_msg *tx_msg __free(kfree) = NULL;
> +	struct se_api_msg *rx_msg __free(kfree) = NULL;
> +	int ret = 0;
> +
> +	tx_msg = kzalloc(ELE_PING_REQ_SZ, GFP_KERNEL);
> +	if (!tx_msg) {
> +		ret = -ENOMEM;
> +		goto exit;
> +	}
> +
> +	rx_msg = kzalloc(ELE_PING_RSP_SZ, GFP_KERNEL);
> +	if (!rx_msg) {
> +		ret = -ENOMEM;
> +		goto exit;
> +	}
> +	priv->rx_msg_sz = ELE_PING_RSP_SZ;
> +
> +	ret = se_fill_cmd_msg_hdr(priv,
> +				      (struct se_msg_hdr *)&tx_msg->header,
> +				      ELE_PING_REQ, ELE_PING_REQ_SZ, true);
> +	if (ret) {
> +		dev_err(dev, "Error: se_fill_cmd_msg_hdr failed.\n");
> +		goto exit;
> +	}
> +
> +	ret = ele_msg_send_rcv(priv, tx_msg, rx_msg);
> +	if (ret)
> +		goto exit;
> +
> +	ret = se_val_rsp_hdr_n_status(priv,
> +				      &rx_msg->header,
> +				      ELE_PING_REQ,
> +				      ELE_PING_RSP_SZ,
> +				      true);
> +exit:
> +	return ret;
> +}
> +
> +int ele_service_swap(struct device *dev,
> +		     phys_addr_t addr,
> +		     u32 addr_size, u16 flag)
> +{
> +	struct se_if_priv *priv = dev_get_drvdata(dev);
> +	struct se_api_msg *tx_msg __free(kfree) = NULL;
> +	struct se_api_msg *rx_msg __free(kfree) = NULL;
> +	int ret = 0;
> +
> +	tx_msg = kzalloc(ELE_SERVICE_SWAP_REQ_MSG_SZ, GFP_KERNEL);
> +	if (!tx_msg) {
> +		ret = -ENOMEM;
> +		goto exit;
> +	}
> +
> +	rx_msg = kzalloc(ELE_SERVICE_SWAP_RSP_MSG_SZ, GFP_KERNEL);
> +	if (!rx_msg) {
> +		ret = -ENOMEM;
> +		goto exit;
> +	}
> +	priv->rx_msg_sz = ELE_SERVICE_SWAP_RSP_MSG_SZ;
> +
> +	ret = se_fill_cmd_msg_hdr(priv,
> +				      (struct se_msg_hdr *)&tx_msg->header,
> +				      ELE_SERVICE_SWAP_REQ,
> +				      ELE_SERVICE_SWAP_REQ_MSG_SZ, true);
> +	if (ret)
> +		goto exit;
> +
> +	tx_msg->data[0] = flag;
> +	tx_msg->data[1] = addr_size;
> +	tx_msg->data[2] = ELE_NONE_VAL;
> +	tx_msg->data[3] = lower_32_bits(addr);
> +	tx_msg->data[4] = se_add_msg_crc((uint32_t *)&tx_msg[0],
> +						 ELE_SERVICE_SWAP_REQ_MSG_SZ);
> +	ret = ele_msg_send_rcv(priv, tx_msg, rx_msg);
> +	if (ret < 0)
> +		goto exit;
> +
> +	ret = se_val_rsp_hdr_n_status(priv,
> +				      &rx_msg->header,
> +				      ELE_SERVICE_SWAP_REQ,
> +				      ELE_SERVICE_SWAP_RSP_MSG_SZ,
> +				      true);
> +	if (ret)
> +		goto exit;
> +
> +	if (flag == ELE_IMEM_EXPORT)
> +		ret = rx_msg->data[1];
> +	else
> +		ret = 0;
> +
> +exit:
> +
> +	return ret;
> +}
> +
> +int ele_fw_authenticate(struct device *dev, phys_addr_t addr)
> +{
> +	struct se_if_priv *priv = dev_get_drvdata(dev);
> +	struct se_api_msg *tx_msg __free(kfree) = NULL;
> +	struct se_api_msg *rx_msg __free(kfree) = NULL;
> +	int ret = 0;
> +
> +	tx_msg = kzalloc(ELE_FW_AUTH_REQ_SZ, GFP_KERNEL);
> +	if (!tx_msg) {
> +		ret = -ENOMEM;
> +		goto exit;
> +	}
> +
> +	rx_msg = kzalloc(ELE_FW_AUTH_RSP_MSG_SZ, GFP_KERNEL);
> +	if (!rx_msg) {
> +		ret = -ENOMEM;
> +		goto exit;
> +	}
> +	priv->rx_msg_sz = ELE_FW_AUTH_RSP_MSG_SZ;
> +
> +	ret = se_fill_cmd_msg_hdr(priv,
> +				  (struct se_msg_hdr *)&tx_msg->header,
> +				  ELE_FW_AUTH_REQ,
> +				  ELE_FW_AUTH_REQ_SZ,
> +				  true);
> +	if (ret)
> +		goto exit;
> +
> +	tx_msg->data[1] = upper_32_bits(addr);
> +	tx_msg->data[0] = lower_32_bits(addr);
> +	tx_msg->data[2] = addr;
> +
> +	ret = ele_msg_send_rcv(priv, tx_msg, rx_msg);
> +	if (ret < 0)
> +		goto exit;
> +
> +	ret = se_val_rsp_hdr_n_status(priv,
> +				      &rx_msg->header,
> +				      ELE_FW_AUTH_REQ,
> +				      ELE_FW_AUTH_RSP_MSG_SZ,
> +				      true);
> +exit:
> +	return ret;
> +}
> diff --git a/drivers/firmware/imx/ele_base_msg.h b/drivers/firmware/imx/ele_base_msg.h
> new file mode 100644
> index 000000000000..a037205dc03d
> --- /dev/null
> +++ b/drivers/firmware/imx/ele_base_msg.h
> @@ -0,0 +1,93 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright 2024 NXP
> + *
> + * Header file for the EdgeLock Enclave Base API(s).
> + */
> +
> +#ifndef ELE_BASE_MSG_H
> +#define ELE_BASE_MSG_H
> +
> +#include <linux/device.h>
> +#include <linux/types.h>
> +
> +#define WORD_SZ				4
> +#define ELE_NONE_VAL			0x0
> +
> +#define ELE_GET_INFO_REQ		0xDA
> +#define ELE_GET_INFO_REQ_MSG_SZ		0x10
> +#define ELE_GET_INFO_RSP_MSG_SZ		0x08
> +
> +#define ELE_GET_INFO_BUFF_SZ		0x100
> +
> +#define DEFAULT_IMX_SOC_VER		0xA000
> +#define SOC_VER_MASK			0xFFFF0000
> +#define SOC_ID_MASK			0x0000FFFF
> +
> +#define MAX_UID_SIZE                     (16)
> +#define DEV_GETINFO_ROM_PATCH_SHA_SZ     (32)
> +#define DEV_GETINFO_FW_SHA_SZ            (32)
> +#define DEV_GETINFO_OEM_SRKH_SZ          (64)
> +#define DEV_GETINFO_MIN_VER_MASK	0xFF
> +#define DEV_GETINFO_MAJ_VER_MASK	0xFF00
> +
> +struct dev_info {
> +	uint8_t  cmd;
> +	uint8_t  ver;
> +	uint16_t length;
> +	uint16_t soc_id;
> +	uint16_t soc_rev;
> +	uint16_t lmda_val;
> +	uint8_t  ssm_state;
> +	uint8_t  dev_atts_api_ver;
> +	uint8_t  uid[MAX_UID_SIZE];
> +	uint8_t  sha_rom_patch[DEV_GETINFO_ROM_PATCH_SHA_SZ];
> +	uint8_t  sha_fw[DEV_GETINFO_FW_SHA_SZ];
> +};
> +
> +struct dev_addn_info {
> +	uint8_t  oem_srkh[DEV_GETINFO_OEM_SRKH_SZ];
> +	uint8_t  trng_state;
> +	uint8_t  csal_state;
> +	uint8_t  imem_state;
> +	uint8_t  reserved2;
> +};
> +
> +struct ele_dev_info {
> +	struct dev_info d_info;
> +	struct dev_addn_info d_addn_info;
> +};
> +
> +#define GET_SERIAL_NUM_FROM_UID(x, uid_word_sz) \
> +	(((u64)(((u32 *)(x))[(uid_word_sz) - 1]) << 32) | ((u32 *)(x))[0])
> +
> +#define ELE_DEBUG_DUMP_REQ		0x21
> +#define ELE_DEBUG_DUMP_RSP_SZ		0x14
> +
> +#define ELE_PING_REQ			0x01
> +#define ELE_PING_REQ_SZ			0x04
> +#define ELE_PING_RSP_SZ			0x08
> +
> +#define ELE_SERVICE_SWAP_REQ		0xDF
> +#define ELE_SERVICE_SWAP_REQ_MSG_SZ	0x18
> +#define ELE_SERVICE_SWAP_RSP_MSG_SZ	0x0C
> +#define ELE_IMEM_SIZE			0x10000
> +#define ELE_IMEM_STATE_OK		0xCA
> +#define ELE_IMEM_STATE_BAD		0xFE
> +#define ELE_IMEM_STATE_WORD		0x27
> +#define ELE_IMEM_STATE_MASK		0x00ff0000
> +#define ELE_IMEM_EXPORT			0x1
> +#define ELE_IMEM_IMPORT			0x2
> +
> +#define ELE_FW_AUTH_REQ			0x02
> +#define ELE_FW_AUTH_REQ_SZ		0x10
> +#define ELE_FW_AUTH_RSP_MSG_SZ		0x08
> +
> +int ele_get_info(struct device *dev, struct ele_dev_info *s_info);
> +int ele_fetch_soc_info(struct device *dev, u16 *soc_rev, u64 *serial_num);
> +int ele_ping(struct device *dev);
> +int ele_service_swap(struct device *dev,
> +		     phys_addr_t addr,
> +		     u32 addr_size, u16 flag);
> +int ele_fw_authenticate(struct device *dev, phys_addr_t addr);
> +#endif
> diff --git a/drivers/firmware/imx/ele_common.c b/drivers/firmware/imx/ele_common.c
> new file mode 100644
> index 000000000000..b2be32550e9b
> --- /dev/null
> +++ b/drivers/firmware/imx/ele_common.c
> @@ -0,0 +1,264 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2024 NXP
> + */
> +
> +#include "ele_base_msg.h"
> +#include "ele_common.h"
> +
> +u32 se_add_msg_crc(u32 *msg, u32 msg_len)
> +{
> +	u32 nb_words = msg_len / (u32)sizeof(u32);
> +	u32 crc = 0;
> +	u32 i;
> +
> +	for (i = 0; i < nb_words - 1; i++)
> +		crc ^= *(msg + i);
> +
> +	return crc;
> +}
> +
> +int ele_msg_rcv(struct se_if_priv *priv)
> +{
> +	u32 wait;
> +	int err = 0;
> +
> +	lockdep_assert_held(&priv->se_if_cmd_lock);
> +
> +	wait = msecs_to_jiffies(1000);
> +	if (!wait_for_completion_timeout(&priv->done, wait)) {
> +		dev_err(priv->dev,
> +				"Error: wait_for_completion timed out.\n");
> +		err = -ETIMEDOUT;
> +	}
> +
> +	return err;
> +}
> +
> +int ele_msg_send(struct se_if_priv *priv, void *tx_msg)
> +{
> +	struct se_msg_hdr *header;
> +	int err;
> +
> +	header = tx_msg;
> +
> +	if (header->tag == priv->cmd_tag)
> +		lockdep_assert_held(&priv->se_if_cmd_lock);
> +
> +	scoped_guard(mutex, &priv->se_if_lock);
> +
> +	err = mbox_send_message(priv->tx_chan, tx_msg);
> +	if (err < 0) {
> +		dev_err(priv->dev, "Error: mbox_send_message failure.\n");
> +		return err;
> +	}
> +
> +	return err;
> +}
> +
> +/* API used for send/receive blocking call. */
> +int ele_msg_send_rcv(struct se_if_priv *priv, void *tx_msg, void *rx_msg)
> +{
> +	int err;
> +
> +	scoped_guard(mutex, &priv->se_if_cmd_lock);
> +	if (priv->waiting_rsp_dev) {
> +		dev_warn(priv->dev,
> +			"There should be no misc dev-ctx, waiting for resp.\n");
> +		priv->waiting_rsp_dev = NULL;
> +	}
> +	priv->rx_msg = rx_msg;
> +	err = ele_msg_send(priv, tx_msg);
> +	if (err < 0)
> +		goto exit;
> +
> +	err = ele_msg_rcv(priv);
> +
> +exit:
> +	return err;
> +}
> +
> +static bool exception_for_size(struct se_if_priv *priv,
> +				struct se_msg_hdr *header)
> +{
> +	/* List of API(s) that can be accepte variable length
> +	 * response buffer.
> +	 */
> +	if (header->command == ELE_DEBUG_DUMP_REQ &&
> +		header->ver == priv->base_api_ver &&
> +		header->size >= 0 &&
> +		header->size <= ELE_DEBUG_DUMP_RSP_SZ)
> +		return true;
> +
> +	return false;
> +}
> +
> +/*
> + * Callback called by mailbox FW, when data is received.
> + */
> +void se_if_rx_callback(struct mbox_client *mbox_cl, void *msg)
> +{
> +	struct device *dev = mbox_cl->dev;
> +	struct se_if_priv *priv;
> +	struct se_msg_hdr *header;
> +	u32 rx_msg_sz;
> +
> +	priv = dev_get_drvdata(dev);
> +
> +	/* The function can be called with NULL msg */
> +	if (!msg) {
> +		dev_err(dev, "Message is invalid\n");
> +		return;
> +	}
> +
> +	header = msg;
> +	rx_msg_sz = header->size << 2;
> +
> +	if (header->tag == priv->rsp_tag) {
> +		if (!priv->waiting_rsp_dev) {
> +			/*
> +			 * Reading the EdgeLock Enclave response
> +			 * to the command, sent by other
> +			 * linux kernel services.
> +			 */
> +			spin_lock(&priv->lock);
> +			if (priv->rx_msg_sz != rx_msg_sz &&
> +					!exception_for_size(priv, header))
> +				dev_err(dev,
> +					"Msg(priv) recvd with different sz(%d != %d).\n",
> +					rx_msg_sz, priv->rx_msg_sz);
> +			else
> +				memcpy(priv->rx_msg, msg, rx_msg_sz);
> +
> +			complete(&priv->done);
> +			spin_unlock(&priv->lock);
> +			return;
> +		}
> +	}
> +
> +	dev_err(dev, "Failed to select a device for message: %.8x\n",
> +		*((u32 *) header));
> +}
> +
> +int se_val_rsp_hdr_n_status(struct se_if_priv *priv,
> +			    struct se_msg_hdr *header,
> +			    uint8_t msg_id,
> +			    uint8_t sz,
> +			    bool is_base_api)
> +{
> +	u32 status;
> +
> +	if (header->tag != priv->rsp_tag) {
> +		dev_err(priv->dev,
> +			"MSG[0x%x] Hdr: Resp tag mismatch. (0x%x != 0x%x)",
> +			msg_id, header->tag, priv->rsp_tag);
> +		return -EINVAL;
> +	}
> +
> +	if (header->command != msg_id) {
> +		dev_err(priv->dev,
> +			"MSG Header: Cmd id mismatch. (0x%x != 0x%x)",
> +			header->command, msg_id);
> +		return -EINVAL;
> +	}
> +
> +	if (header->size != (sz >> 2)) {
> +		dev_err(priv->dev,
> +			"MSG[0x%x] Hdr: Cmd size mismatch. (0x%x != 0x%x)",
> +			msg_id, header->size, (sz >> 2));
> +		return -EINVAL;
> +	}
> +
> +	if (is_base_api && (header->ver != priv->base_api_ver)) {
> +		dev_err(priv->dev,
> +			"MSG[0x%x] Hdr: Base API Vers mismatch. (0x%x != 0x%x)",
> +			msg_id, header->ver, priv->base_api_ver);
> +		return -EINVAL;
> +	} else if (!is_base_api && header->ver != priv->fw_api_ver) {
> +		dev_err(priv->dev,
> +			"MSG[0x%x] Hdr: FW API Vers mismatch. (0x%x != 0x%x)",
> +			msg_id, header->ver, priv->fw_api_ver);
> +		return -EINVAL;
> +	}
> +
> +	status = RES_STATUS(priv->rx_msg->data[0]);
> +	if (status != priv->success_tag) {
> +		dev_err(priv->dev, "Command Id[%d], Response Failure = 0x%x",
> +			header->command, status);
> +		return -EPERM;
> +	}
> +
> +	return 0;
> +}
> +
> +int se_save_imem_state(struct se_if_priv *priv)
> +{
> +	int ret;
> +
> +	/* EXPORT command will save encrypted IMEM to given address,
> +	 * so later in resume, IMEM can be restored from the given
> +	 * address.
> +	 *
> +	 * Size must be at least 64 kB.
> +	 */
> +	ret = ele_service_swap(priv->dev,
> +			       priv->imem.phyaddr,
> +			       ELE_IMEM_SIZE,
> +			       ELE_IMEM_EXPORT);
> +	if (ret < 0)
> +		dev_err(priv->dev, "Failed to export IMEM\n");
> +	else
> +		dev_info(priv->dev,
> +			"Exported %d bytes of encrypted IMEM\n",
> +			ret);
> +
> +	return ret;
> +}
> +
> +int se_restore_imem_state(struct se_if_priv *priv)
> +{
> +	struct ele_dev_info s_info;
> +	int ret;
> +
> +	/* get info from ELE */
> +	ret = ele_get_info(priv->dev, &s_info);
> +	if (ret) {
> +		dev_err(priv->dev, "Failed to get info from ELE.\n");
> +		return ret;
> +	}
> +
> +	/* Get IMEM state, if 0xFE then import IMEM */
> +	if (s_info.d_addn_info.imem_state == ELE_IMEM_STATE_BAD) {
> +		/* IMPORT command will restore IMEM from the given
> +		 * address, here size is the actual size returned by ELE
> +		 * during the export operation
> +		 */
> +		ret = ele_service_swap(priv->dev,
> +				       priv->imem.phyaddr,
> +				       priv->imem.size,
> +				       ELE_IMEM_IMPORT);
> +		if (ret) {
> +			dev_err(priv->dev, "Failed to import IMEM\n");
> +			goto exit;
> +		}
> +	} else
> +		goto exit;
> +
> +	/* After importing IMEM, check if IMEM state is equal to 0xCA
> +	 * to ensure IMEM is fully loaded and
> +	 * ELE functionality can be used.
> +	 */
> +	ret = ele_get_info(priv->dev, &s_info);
> +	if (ret) {
> +		dev_err(priv->dev, "Failed to get info from ELE.\n");
> +		goto exit;
> +	}
> +
> +	if (s_info.d_addn_info.imem_state == ELE_IMEM_STATE_OK)
> +		dev_info(priv->dev, "Successfully restored IMEM\n");
> +	else
> +		dev_err(priv->dev, "Failed to restore IMEM\n");
> +
> +exit:
> +	return ret;
> +}
> diff --git a/drivers/firmware/imx/ele_common.h b/drivers/firmware/imx/ele_common.h
> new file mode 100644
> index 000000000000..5ef775a42ab3
> --- /dev/null
> +++ b/drivers/firmware/imx/ele_common.h
> @@ -0,0 +1,44 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright 2024 NXP
> + */
> +
> +
> +#ifndef __ELE_COMMON_H__
> +#define __ELE_COMMON_H__
> +
> +#include "se_ctrl.h"
> +
> +#define ELE_SUCCESS_IND			0xD6
> +
> +#define IMX_ELE_FW_DIR                 "imx/ele/"
> +
> +uint32_t se_add_msg_crc(uint32_t *msg, uint32_t msg_len);
> +int ele_msg_rcv(struct se_if_priv *priv);
> +int ele_msg_send(struct se_if_priv *priv, void *tx_msg);
> +int ele_msg_send_rcv(struct se_if_priv *priv, void *tx_msg, void *rx_msg);
> +void se_if_rx_callback(struct mbox_client *mbox_cl, void *msg);
> +int se_val_rsp_hdr_n_status(struct se_if_priv *priv,
> +			    struct se_msg_hdr *header,
> +			    uint8_t msg_id,
> +			    uint8_t sz,
> +			    bool is_base_api);
> +
> +/* Fill a command message header with a given command ID and length in bytes. */
> +static inline int se_fill_cmd_msg_hdr(struct se_if_priv *priv,
> +				      struct se_msg_hdr *hdr,
> +				      u8 cmd, u32 len,
> +				      bool is_base_api)
> +{
> +	hdr->tag = priv->cmd_tag;
> +	hdr->ver = (is_base_api) ? priv->base_api_ver : priv->fw_api_ver;
> +	hdr->command = cmd;
> +	hdr->size = len >> 2;
> +
> +	return 0;
> +}
> +
> +int se_save_imem_state(struct se_if_priv *priv);
> +int se_restore_imem_state(struct se_if_priv *priv);
> +
> +#endif /*__ELE_COMMON_H__ */
> diff --git a/drivers/firmware/imx/se_ctrl.c b/drivers/firmware/imx/se_ctrl.c
> new file mode 100644
> index 000000000000..a844794d2b39
> --- /dev/null
> +++ b/drivers/firmware/imx/se_ctrl.c
> @@ -0,0 +1,496 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2024 NXP
> + */
> +
> +#include <linux/completion.h>
> +#include <linux/delay.h>
> +#include <linux/dev_printk.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/errno.h>
> +#include <linux/export.h>
> +#include <linux/firmware.h>
> +#include <linux/firmware/imx/se_api.h>
> +#include <linux/genalloc.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/miscdevice.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_reserved_mem.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/string.h>
> +#include <linux/sys_soc.h>
> +
> +#include "ele_base_msg.h"
> +#include "ele_common.h"
> +#include "se_ctrl.h"
> +
> +#define RESERVED_DMA_POOL		BIT(0)
> +#define MBOX_TX_NAME			"tx"
> +#define MBOX_RX_NAME			"rx"
> +
> +struct se_if_node_info {
> +	u8 se_if_id;
> +	u8 se_if_did;
> +	u8 max_dev_ctx;
> +	u8 cmd_tag;
> +	u8 rsp_tag;
> +	u8 success_tag;
> +	u8 base_api_ver;
> +	u8 fw_api_ver;
> +	u8 *se_name;
> +	u8 *pool_name;
> +	u8 *fw_name_in_rfs;
> +	bool soc_register;
> +	bool reserved_dma_ranges;
> +	bool imem_mgmt;
> +	int (*se_fetch_soc_info)(struct device *dev, u16 *soc_rev, u64 *serial_num);
> +};
> +
> +struct se_if_node_info_list {
> +	u8 num_mu;
> +	u16 soc_id;
> +	struct se_if_node_info info[];
> +};
> +
> +static const struct se_if_node_info_list imx8ulp_info = {
> +	.num_mu = 1,
> +	.soc_id = SOC_ID_OF_IMX8ULP,
> +	.info = {
> +			{
> +			.se_if_id = 2,
> +			.se_if_did = 7,
> +			.max_dev_ctx = 4,
> +			.cmd_tag = 0x17,
> +			.rsp_tag = 0xe1,
> +			.success_tag = ELE_SUCCESS_IND,
> +			.base_api_ver = MESSAGING_VERSION_6,
> +			.fw_api_ver = MESSAGING_VERSION_7,
> +			.se_name = "hsm1",
> +			.pool_name = "sram",
> +			.fw_name_in_rfs = IMX_ELE_FW_DIR
> +					  "mx8ulpa2ext-ahab-container.img",
> +			.soc_register = true,
> +			.reserved_dma_ranges = true,
> +			.imem_mgmt = true,
> +			.se_fetch_soc_info = ele_fetch_soc_info,
> +			},
> +	},
> +};
> +
> +static const struct se_if_node_info_list imx93_info = {
> +	.num_mu = 1,
> +	.soc_id = SOC_ID_OF_IMX93,
> +	.info = {
> +			{
> +			.se_if_id = 2,
> +			.se_if_did = 3,
> +			.max_dev_ctx = 4,
> +			.cmd_tag = 0x17,
> +			.rsp_tag = 0xe1,
> +			.success_tag = ELE_SUCCESS_IND,
> +			.base_api_ver = MESSAGING_VERSION_6,
> +			.fw_api_ver = MESSAGING_VERSION_7,
> +			.se_name = "hsm1",
> +			.reserved_dma_ranges = true,
> +			.soc_register = true,
> +			},
> +	},
> +};
> +
> +static const struct of_device_id se_match[] = {
> +	{ .compatible = "fsl,imx8ulp-se", .data = (void *)&imx8ulp_info},
> +	{ .compatible = "fsl,imx93-se", .data = (void *)&imx93_info},
> +	{},
> +};
> +
> +static const struct se_if_node_info
> +	*get_se_if_node_info(const struct se_if_node_info_list *info_list,
> +			      const u32 idx)
> +{
> +	if (idx > info_list->num_mu)
> +		return NULL;
> +
> +	return &info_list->info[idx];
> +}
> +
> +static int se_soc_info(struct se_if_priv *priv,
> +		       const struct se_if_node_info_list *info_list)
> +{
> +	const struct se_if_node_info *info;
> +	struct soc_device_attribute *attr;
> +	struct soc_device *sdev;
> +	u64 serial_num;
> +	u16 soc_rev;
> +	int err = 0;
> +
> +	info = priv->info;
> +
> +	/* This function should be called once.
> +	 * Check if the soc_rev is zero to continue.
> +	 */
> +	if (priv->soc_rev)
> +		return err;
> +
> +	if (info->se_fetch_soc_info) {
> +		err = info->se_fetch_soc_info(priv->dev, &soc_rev, &serial_num);
> +		if (err < 0) {
> +			dev_err(priv->dev, "Failed to fetch SoC Info.");
> +			return err;
> +		}
> +	} else {
> +		dev_err(priv->dev, "Failed to fetch SoC revision.");
> +		if (info->soc_register)
> +			dev_err(priv->dev, "Failed to do SoC registration.");
> +		err = -EINVAL;
> +		return err;
> +	}
> +
> +	priv->soc_rev = soc_rev;
> +	if (!info->soc_register)
> +		return 0;
> +
> +	attr = devm_kzalloc(priv->dev, sizeof(*attr), GFP_KERNEL);
> +	if (!attr)
> +		return -ENOMEM;
> +
> +	if (FIELD_GET(DEV_GETINFO_MIN_VER_MASK, soc_rev))
> +		attr->revision = devm_kasprintf(priv->dev, GFP_KERNEL, "%x.%x",
> +						FIELD_GET(DEV_GETINFO_MIN_VER_MASK,
> +							  soc_rev),
> +						FIELD_GET(DEV_GETINFO_MAJ_VER_MASK,
> +							  soc_rev));
> +	else
> +		attr->revision = devm_kasprintf(priv->dev, GFP_KERNEL, "%x",
> +						FIELD_GET(DEV_GETINFO_MAJ_VER_MASK,
> +							  soc_rev));
> +
> +	switch (info_list->soc_id) {
> +	case SOC_ID_OF_IMX8ULP:
> +		attr->soc_id = devm_kasprintf(priv->dev, GFP_KERNEL,
> +					      "i.MX8ULP");
> +		break;
> +	case SOC_ID_OF_IMX93:
> +		attr->soc_id = devm_kasprintf(priv->dev, GFP_KERNEL,
> +					      "i.MX93");
> +		break;
> +	}
> +
> +	err = of_property_read_string(of_root, "model",
> +				      &attr->machine);
> +	if (err)
> +		return -EINVAL;
> +
> +	attr->family = devm_kasprintf(priv->dev, GFP_KERNEL, "Freescale i.MX");
> +
> +	attr->serial_number
> +		= devm_kasprintf(priv->dev, GFP_KERNEL, "%016llX", serial_num);
> +
> +	sdev = soc_device_register(attr);
> +	if (IS_ERR(sdev))
> +		return PTR_ERR(sdev);
> +
> +	return 0;
> +}
> +
> +/* interface for managed res to free a mailbox channel */
> +static void if_mbox_free_channel(void *mbox_chan)
> +{
> +	mbox_free_channel(mbox_chan);
> +}
> +
> +static int se_if_request_channel(struct device *dev,
> +				 struct mbox_chan **chan,
> +				 struct mbox_client *cl,
> +				 const char *name)
> +{
> +	struct mbox_chan *t_chan;
> +	int ret = 0;
> +
> +	t_chan = mbox_request_channel_byname(cl, name);
> +	if (IS_ERR(t_chan)) {
> +		ret = PTR_ERR(t_chan);
> +		return dev_err_probe(dev, ret,
> +				     "Failed to request %s channel.", name);
> +	}
> +
> +	ret = devm_add_action(dev, if_mbox_free_channel, t_chan);
> +	if (ret) {
> +		dev_err(dev, "failed to add devm removal of mbox %s\n", name);
> +		goto exit;
> +	}
> +
> +	*chan = t_chan;
> +
> +exit:
> +	return ret;
> +}
> +
> +static void se_if_probe_cleanup(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct se_if_priv *priv;
> +
> +	priv = dev_get_drvdata(dev);
> +
> +	/* In se_if_request_channel(), passed the clean-up functional
> +	 * pointer reference as action to devm_add_action().
> +	 * No need to free the mbox channels here.
> +	 */
> +
> +	/* free the buffer in se remove, previously allocated
> +	 * in se probe to store encrypted IMEM
> +	 */
> +	if (priv->imem.buf) {
> +		dmam_free_coherent(dev,
> +				   ELE_IMEM_SIZE,
> +				   priv->imem.buf,
> +				   priv->imem.phyaddr);
> +		priv->imem.buf = NULL;
> +	}
> +
> +	/* No need to check, if reserved memory is allocated
> +	 * before calling for its release. Or clearing the
> +	 * un-set bit.
> +	 */
> +	of_reserved_mem_device_release(dev);
> +}
> +
> +static void se_load_firmware(const struct firmware *fw, void *context)
> +{
> +	struct se_if_priv *priv = (struct se_if_priv *) context;
> +	const struct se_if_node_info *info = priv->info;
> +	const u8 *se_fw_name = info->fw_name_in_rfs;
> +	phys_addr_t se_fw_phyaddr;
> +	u8 *se_fw_buf;
> +
> +	if (!fw) {
> +		if (priv->fw_fail > MAX_FW_LOAD_RETRIES)
> +			dev_dbg(priv->dev,
> +				 "External FW not found, using ROM FW.\n");
Isn't it true that if only one branch of a conditional statement 
contains a single statement, you should use braces in both branches?
> +		else {
> +			/*add a bit delay to wait for firmware priv released */
> +			msleep(20);
> +
> +			/* Load firmware one more time if timeout */
> +			request_firmware_nowait(THIS_MODULE,
> +					FW_ACTION_UEVENT, info->fw_name_in_rfs,
> +					priv->dev, GFP_KERNEL, priv,
> +					se_load_firmware);
> +			priv->fw_fail++;
> +			dev_dbg(priv->dev, "Value of retries = 0x%x.\n",
> +				priv->fw_fail);
> +		}
> +
> +		return;
> +	}
> +
> +	/* allocate buffer to store the SE FW */
> +	se_fw_buf = dma_alloc_coherent(priv->dev, fw->size,
> +				       &se_fw_phyaddr, GFP_KERNEL);
> +	if (!se_fw_buf)
> +		goto exit;
> +
> +	memcpy(se_fw_buf, fw->data, fw->size);
> +
> +	if (ele_fw_authenticate(priv->dev, se_fw_phyaddr))
> +		dev_err(priv->dev,
> +			"Failed to authenticate & load SE firmware %s.\n",
> +			se_fw_name);
> +
> +	dma_free_coherent(priv->dev,
> +			   fw->size,
> +			   se_fw_buf,
> +			   se_fw_phyaddr);
> +
> +exit:
> +	release_firmware(fw);
> +}
> +
> +static int se_if_probe(struct platform_device *pdev)
> +{
> +	const struct se_if_node_info_list *info_list;
> +	const struct se_if_node_info *info;
> +	struct device *dev = &pdev->dev;
> +	struct se_if_priv *priv;
> +	u32 idx;
> +	int ret;
> +
> +	if (of_property_read_u32(dev->of_node, "reg", &idx)) {
> +		ret = -EINVAL;
> +		goto exit;
> +	}
> +
> +	info_list = device_get_match_data(dev);
> +	info = get_se_if_node_info(info_list, idx);
> +	if (!info) {
> +		ret = -EINVAL;
> +		goto exit;
> +	}
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv) {
> +		ret = -ENOMEM;
> +		goto exit;
> +	}
> +
> +	dev_set_drvdata(dev, priv);
> +
> +	/* Mailbox client configuration */
> +	priv->se_mb_cl.dev		= dev;
> +	priv->se_mb_cl.tx_block		= false;
> +	priv->se_mb_cl.knows_txdone	= true;
> +	priv->se_mb_cl.rx_callback	= se_if_rx_callback;
> +
> +	ret = se_if_request_channel(dev, &priv->tx_chan,
> +			&priv->se_mb_cl, MBOX_TX_NAME);
> +	if (ret)
> +		goto exit;
> +
> +	ret = se_if_request_channel(dev, &priv->rx_chan,
> +			&priv->se_mb_cl, MBOX_RX_NAME);
> +	if (ret)
> +		goto exit;
> +
> +	priv->dev = dev;
> +	priv->info = info;
> +
> +	mutex_init(&priv->se_if_lock);
> +	mutex_init(&priv->se_if_cmd_lock);
> +
> +	/*
> +	 * Initialized priv->cmd_receiver_dev and
> +	 * priv->waiting_rsp_dev = NULL;
> +	 */
> +	priv->max_dev_ctx = info->max_dev_ctx;
> +	priv->cmd_tag = info->cmd_tag;
> +	priv->rsp_tag = info->rsp_tag;
> +	if (info->pool_name) {
> +		priv->mem_pool = of_gen_pool_get(dev->of_node,
> +						 info->pool_name, 0);
> +		if (!priv->mem_pool) {
> +			dev_err(dev,
> +				"Unable to get sram pool = %s\n",
> +				info->pool_name);
> +			return 0;
> +		}
> +	}
> +	priv->success_tag = info->success_tag;
> +	priv->base_api_ver = info->base_api_ver;
> +	priv->fw_api_ver = info->fw_api_ver;
> +
> +	init_completion(&priv->done);
> +	spin_lock_init(&priv->lock);
> +
> +	if (info->reserved_dma_ranges) {
> +		ret = of_reserved_mem_device_init(dev);
> +		if (ret) {
> +			dev_err(dev,
> +				"failed to init reserved memory region %d\n",
> +				ret);
> +			goto exit;
> +		}
> +	}
> +
> +	ret = se_soc_info(priv, info_list);
> +	if (ret) {
> +		dev_err(dev,
> +			"failed[%pe] to fetch SoC Info\n", ERR_PTR(ret));
> +		goto exit;
> +	}
> +
> +	if (info->imem_mgmt) {
> +		/* allocate buffer where SE store encrypted IMEM */
> +		priv->imem.buf = dmam_alloc_coherent(dev, ELE_IMEM_SIZE,
> +						     &priv->imem.phyaddr,
> +						     GFP_KERNEL);
> +		if (!priv->imem.buf) {
> +			dev_err(dev,
> +				"dmam-alloc-failed: To store encr-IMEM.\n");
> +			ret = -ENOMEM;
> +			goto exit;
> +		}
> +	}
> +
> +	if (info->fw_name_in_rfs) {
> +		ret = request_firmware_nowait(THIS_MODULE,
> +					      FW_ACTION_UEVENT,
> +					      info->fw_name_in_rfs,
> +					      dev, GFP_KERNEL, priv,
> +					      se_load_firmware);
> +		if (ret)
> +			dev_warn(dev, "Failed to get firmware [%s].\n",
> +				 info->fw_name_in_rfs);
> +		ret = 0;
> +	}
> +
> +	dev_info(dev, "i.MX secure-enclave: %s interface to firmware, configured.\n",
> +		 info->se_name);
> +	return ret;
> +
> +exit:
> +	/* if execution control reaches here, if probe fails.
> +	 * hence doing the cleanup
> +	 */
> +	se_if_probe_cleanup(pdev);
> +
> +	return ret;
> +}
> +
> +static int se_if_remove(struct platform_device *pdev)
> +{
> +	se_if_probe_cleanup(pdev);
> +
> +	return 0;
> +}
> +
> +static int se_suspend(struct device *dev)
> +{
> +	struct se_if_priv *priv = dev_get_drvdata(dev);
> +	const struct se_if_node_info *info = priv->info;
> +	int ret = 0;
> +
> +	if (info && info->imem_mgmt) {
> +		ret = se_save_imem_state(priv);
> +		if (ret < 0)
> +			goto exit;
> +		priv->imem.size = ret;
> +	}
> +exit:
> +	return ret;
> +}
> +
> +static int se_resume(struct device *dev)
> +{
> +	struct se_if_priv *priv = dev_get_drvdata(dev);
> +	const struct se_if_node_info *info = priv->info;
> +
> +	if (info && info->imem_mgmt)
> +		se_restore_imem_state(priv);
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops se_pm = {
> +	RUNTIME_PM_OPS(se_suspend, se_resume, NULL)
> +};
> +
> +static struct platform_driver se_driver = {
> +	.driver = {
> +		.name = "fsl-se-fw",
> +		.of_match_table = se_match,
> +		.pm = &se_pm,
> +	},
> +	.probe = se_if_probe,
> +	.remove = se_if_remove,
> +};
> +MODULE_DEVICE_TABLE(of, se_match);
> +
> +module_platform_driver(se_driver);
> +
> +MODULE_AUTHOR("Pankaj Gupta <pankaj.gupta@nxp.com>");
> +MODULE_DESCRIPTION("iMX Secure Enclave Driver.");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/firmware/imx/se_ctrl.h b/drivers/firmware/imx/se_ctrl.h
> new file mode 100644
> index 000000000000..4be2235d2170
> --- /dev/null
> +++ b/drivers/firmware/imx/se_ctrl.h
> @@ -0,0 +1,83 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright 2024 NXP
> + */
> +
> +#ifndef SE_MU_H
> +#define SE_MU_H
> +
> +#include <linux/miscdevice.h>
> +#include <linux/semaphore.h>
> +#include <linux/mailbox_client.h>
> +
> +#define MAX_FW_LOAD_RETRIES		50
> +
> +#define RES_STATUS(x)			FIELD_GET(0x000000ff, x)
> +#define MESSAGING_VERSION_6		0x6
> +#define MESSAGING_VERSION_7		0x7
> +
> +struct se_imem_buf {
> +	u8 *buf;
> +	phys_addr_t phyaddr;
> +	u32 size;
> +};
> +
> +/* Header of the messages exchange with the EdgeLock Enclave */
> +struct se_msg_hdr {
> +	u8 ver;
> +	u8 size;
> +	u8 command;
> +	u8 tag;
> +}  __packed;
> +
> +#define SE_MU_HDR_SZ	4
> +
> +struct se_api_msg {
> +	struct se_msg_hdr header;
> +	u32 data[];
> +};
> +
> +struct se_if_priv {
> +	struct se_if_device_ctx *cmd_receiver_dev;
> +	/* Update to the waiting_rsp_dev, to be protected
> +	 * under se_if_lock.
> +	 */
> +	struct se_if_device_ctx *waiting_rsp_dev;
> +	/*
> +	 * prevent parallel access to the se interface registers
> +	 * e.g. a user trying to send a command while the other one is
> +	 * sending a response.
> +	 */
> +	struct mutex se_if_lock;
> +	/*
> +	 * prevent a command to be sent on the se interface while another one is
> +	 * still processing. (response to a command is allowed)
> +	 */
> +	struct mutex se_if_cmd_lock;
> +	struct device *dev;
> +	struct gen_pool *mem_pool;
> +	u8 cmd_tag;
> +	u8 rsp_tag;
> +	u8 success_tag;
> +	u8 base_api_ver;
> +	u8 fw_api_ver;
> +	u32 fw_fail;
> +	u16 soc_rev;
> +	const void *info;
> +
> +	struct mbox_client se_mb_cl;
> +	struct mbox_chan *tx_chan, *rx_chan;
> +
> +	/* Assignment of the rx_msg buffer to held till the
> +	 * received content as part callback function, is copied.
> +	 */
> +	struct se_api_msg *rx_msg;
> +	u32 rx_msg_sz;
> +	struct completion done;
> +	spinlock_t lock;
> +	u8 max_dev_ctx;
> +	struct se_if_device_ctx **ctxs;
> +	struct se_imem_buf imem;
> +};
> +
> +#endif
> diff --git a/include/linux/firmware/imx/se_api.h b/include/linux/firmware/imx/se_api.h
> new file mode 100644
> index 000000000000..c47f84906837
> --- /dev/null
> +++ b/include/linux/firmware/imx/se_api.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright 2024 NXP
> + */
> +
> +#ifndef __SE_API_H__
> +#define __SE_API_H__
> +
> +#include <linux/types.h>
> +
> +#define SOC_ID_OF_IMX8ULP		0x084D
> +#define SOC_ID_OF_IMX93			0x9300
> +
> +#endif /* __SE_API_H__ */
> 
> -- 
> 2.34.1
> 
> 


