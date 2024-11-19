Return-Path: <linux-kernel+bounces-414531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F689D2987
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 16:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 320C2283081
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 15:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB63F1CF293;
	Tue, 19 Nov 2024 15:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=BLAIZE.COM header.i=@BLAIZE.COM header.b="H5CaA6uI"
Received: from mx07-0063e101.pphosted.com (mx07-0063e101.pphosted.com [205.220.184.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D539E78C76;
	Tue, 19 Nov 2024 15:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.184.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732029836; cv=fail; b=HMmBoQNTYVmNeCybdIf7VqbFYqkO9F8fvsfioxh6aIzMMwr7sBmtgMIb7ZM2eTQfqnTfwtgDIGS6Y+TT0hHgPb1e8n47RKP+qSGLmi2ZgHpIR06zLMWwTUWeqJrUSB+obp7+Rk7CcKHatO6tFr7DIVZ5DzJ+5F3m0GDcthR3fLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732029836; c=relaxed/simple;
	bh=vKbYwjamaygtLwTAJNJaRqmBMQ6vzW9L/SqK4mTPT9k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UYvzMuTvuQ6kR/Ginb0RCi4ubJcur753FQUV9a8M5x8QegBpt/feqJU5G8EmkPKojB3PlpX6MjFK+zhFL4044jXsvqmS29unS2eDewVfB8AOgg5uaCtjHfRsjY7xdvcI+1OrQCZ1CPOytrbsqxSeh06nLoBMyRDsB8XUCrHg0oo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blaize.com; spf=pass smtp.mailfrom=blaize.com; dkim=pass (1024-bit key) header.d=BLAIZE.COM header.i=@BLAIZE.COM header.b=H5CaA6uI; arc=fail smtp.client-ip=205.220.184.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blaize.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blaize.com
Received: from pps.filterd (m0247495.ppops.net [127.0.0.1])
	by mx08-0063e101.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJFBq88029168;
	Tue, 19 Nov 2024 15:23:38 GMT
Received: from ma0pr01cu009.outbound.protection.outlook.com (mail-southindiaazlp17010005.outbound.protection.outlook.com [40.93.131.5])
	by mx08-0063e101.pphosted.com (PPS) with ESMTPS id 42xhh31ncx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 15:23:37 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hMPhv7iyurTdybMPvMhFb+uHDAPwheln/Cg96JIkn/+hcHOD53djAbFwwzaaZfqtUedjnXsZkZFG+gdWZf62qtlkQqibC2OdjTku2j7NZba8frm+rtu4KKD6ve+zBO/IKMVDWaRuLHEVq1B2bM4TTbZ9VbA+A576peQEqpLOsaPZ51Gyt8ptxs+yWPePTqfeylsg7oNSLX4Gpvwlsz43PHnB5VbGMPlo90qSEHvcXqIpKKn9qakYuGhukmf3Vj3uP0jboJqQqe0433AWNzCrDvSN44YVvXLr/fa61NwYDV6HW6eaE5/kSE426CWev/nVW18lIEtBQ7f4FlOpLFyMdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vKbYwjamaygtLwTAJNJaRqmBMQ6vzW9L/SqK4mTPT9k=;
 b=gxp5OpEaXYE+oaGnTxaW8CHVMZuXguYlDNd5kkynecoHpI6QzomCLylJWI4xMIVOAM1r7jhuUGOq0Ze9eqOUQJNBpiIomzglTFWjatho+CSe/yU9f5jtEz4hdB+zoRm2f/gEO5EK9YMm5bz46n+lFXsIMOU4q4uAG5RGqpCsVahDJbarhg2oGGaGK/oT/MhDYbt2+AsRHC+im/Gxj5/kQeyDgt76XPpg1JqubS6cX247L209+8Darse3/Jw3dadcs5RFHmiUpSePcorhcRFFZaqrlon2X/1zxDrgFUG5eHvdJG64S4YB0koqbS5rsv7Azrl/oCfoom/AP81gjS5REQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=blaize.com; dmarc=pass action=none header.from=blaize.com;
 dkim=pass header.d=blaize.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=BLAIZE.COM;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vKbYwjamaygtLwTAJNJaRqmBMQ6vzW9L/SqK4mTPT9k=;
 b=H5CaA6uIB0dxAL6AYzMWieTJARuhiJuIph6qUBJuGw1xwFMy42nZZMkrHbMswaayGcEnEPg1L49vvUNx8ZX3CJyslarGWeMupOIVkog8VUAFVOBLZkNdz2+lwHYV5v/eVZDdNWgvaG2woiv9cXRLOVOSek8Mi5JA3BCLKyApIdU=
Received: from MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:12a::5)
 by MAZPR01MB8892.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:d0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Tue, 19 Nov
 2024 15:23:32 +0000
Received: from MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::309a:12cf:74a4:5655]) by MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::309a:12cf:74a4:5655%3]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 15:23:32 +0000
Message-ID: <09170fdb-018a-401e-a186-ccd0f5e993d8@blaize.com>
Date: Tue, 19 Nov 2024 15:23:26 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/6] dt-bindings: Add Blaize vendor prefix
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        James Cowgill <james.cowgill@blaize.com>,
        Matt Redfearn <matthew.redfearn@blaize.com>,
        Neil Jones <neil.jones@blaize.com>,
        Catalin Marinas
 <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
        "soc@lists.linux.dev" <soc@lists.linux.dev>
References: <20241115-blaize-blzp1600_init_board_support-v5-0-c09094e63dc5@blaize.com>
 <20241115-blaize-blzp1600_init_board_support-v5-1-c09094e63dc5@blaize.com>
 <c1885e24-8051-4c91-9870-18eb4218a2ff@kernel.org>
 <bc471aeb-e9fd-4aa9-9bcc-a59d3c2e47b8@blaize.com>
 <c866d4e8-77ee-48ca-b6a8-5f56896b072e@kernel.org>
Content-Language: en-US
From: Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
In-Reply-To: <c866d4e8-77ee-48ca-b6a8-5f56896b072e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0094.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::9) To MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:12a::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0PR01MB10184:EE_|MAZPR01MB8892:EE_
X-MS-Office365-Filtering-Correlation-Id: 9da6291e-c141-4e94-c09b-08dd08ae207c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z0xSTWxFd092RFZ4blM1RGVTY2R3Mk1GVWdRRldvR1Z2SXg2SU1wT1hHbk5v?=
 =?utf-8?B?ZVF6RWpZNzgvSlg0K3NFMlh1Y0JiUVdoSG1ra1A4bHRZc1R1WmFnMVNBdWlN?=
 =?utf-8?B?N2pmK0dLY3hJTVpydGpxcHNoTGdRUzRvNlB4WDJjZkNjVVRiSUYyZ01lTTFV?=
 =?utf-8?B?M3h2Ym5iUVpKZnRuTVJwUk5Bcng5K1hrZndiZVgxUm00aWdOMEFTVmtUcUxG?=
 =?utf-8?B?eFRNcDAxSW9kYi9aWkZnMTEzMlFySTZ1STVuRVRiQkN1aHpvcW9sVnV3dDUw?=
 =?utf-8?B?OUh4Ti84T0JTUDBpS0p0bnh6NXVBR0VUWmkzTWZPZURhZzgxWGVLZFNMdkdv?=
 =?utf-8?B?NXkrQkpNVk03VUpVRmV0ODVRc3RPYS8yQ3FYMXRGY0ZsSlI3b01ONE54Uzh3?=
 =?utf-8?B?RklHbk55YlBCNFhkMGRrQml1bldMYlFTZytKNkJoaWFWSld1QXUxZ3lGelBR?=
 =?utf-8?B?azJYeDcyb3JEaDIzNytCUnVVdjBldThLUjZQdko0VmR6OXdkbmUxZVo3ZFZi?=
 =?utf-8?B?b3NQKzU3T0xPb2lPQkRYV0xyeWRaM3EwVS9oSHFsZklqY3pOcmdwMzQya2p1?=
 =?utf-8?B?K2VMM0Y5WFc3UXZhVHRXR01IeExsR2Mxd3pQWGpoRDJGVllvdmlyaEp1SDRZ?=
 =?utf-8?B?L2hESldMcW5YbncxMWJPWkErNDFPQ2tBVzl1NHVZQ3kzSlFZQ2t5anRMZXlP?=
 =?utf-8?B?MGRuZmppRWh0a3NKTmk1MHFzOEdEL2tGZmZkUlVXeEdHdVlvOVY3eTFid3hT?=
 =?utf-8?B?Ny8vZHdnZGczU1FNei9maktUMlNFVWRHajdSczIvR0dwSG5Idi9OTjhBMW9T?=
 =?utf-8?B?S3g5U3FvcEgwSU0yYlNvQXpWaEFtK09acituL2VMekJ2Z05lWHB2bVpyakFl?=
 =?utf-8?B?UTJMaTZibFJNcWZXMTFJMDZJd1FJbmN1U2pib2pJZ0hwaHE0aHQyUXBnbSth?=
 =?utf-8?B?Z3dTcE1lbFpmMnU4Q3Z1aXdNL0xLb2hjZEwyUEdXVld0azZNWGpXMi9abUxQ?=
 =?utf-8?B?eGtqaXN4elN6d1Jzc1hPQmdFOXJlUjVkdXR6bCtqeFNadFR6YVBmMm9HUUla?=
 =?utf-8?B?a05QYk02STFNR0FZaUJ0cFFFZzUwS2VmQ01lZTBtMmt6M1J1WS9tMktzamor?=
 =?utf-8?B?M2pqN2crcFdST2VwbHRWaXRNRm1TTHBiRzNsT2dqWTRlZXA3ZTkzamY4TGFR?=
 =?utf-8?B?Nnl6Ni9DT0NyU01vSFI2MDhkM1M1MUZneUJMRzZkTzltT0JOcFVNaDgrbkVp?=
 =?utf-8?B?cUJpb29IZjV5R3FxZkxHVTBNK0phaTNkVW1OdUJtbGw0bUV1anhhbSthOXJ6?=
 =?utf-8?B?MzE2bmFMaU9CUzF2MzNWYWlQM2tLQWVJWVlJbzJGTFZPL0RycEdjc0tXZlRI?=
 =?utf-8?B?NlQ0aVpmUXRHYUhHTUlmbU42clRGUGpyM2REOGFGbmRLa2xydkRScWx0aUpS?=
 =?utf-8?B?WWhKM2s3dVZ3VTllNFVjTTQ1QWUwRC9TYlhqQ2xCUk9kaVpsT0dUaU40Wmtj?=
 =?utf-8?B?WCt4RlVDZlRBdk4zRlYybUFSOS9SMldOTGpacHlxdXR1eTVRbm1yWnJKakFI?=
 =?utf-8?B?NjM1dEtnRWRhaTFJWVpHTFNPTldYaWo0aFBrRlNBeEV4OVAyZkNiRHZUeEZR?=
 =?utf-8?B?ZXU5ZytzTWdZeld2TzB6REtKUDNlL0FtRmsrdW9DU3p6MlpxdGszVXJISWJj?=
 =?utf-8?B?dVovNm95T3R1ZWUvQzlVNncvWGVWWm9RRUVuNFljTUFjQS9CVGlhQUVXUDFo?=
 =?utf-8?Q?YqRBT+flNjZrUqrJfI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OE9yMHFHVXczM0xtQTdzZml3clNjWi9XMXIyS2lHemdLZE1wci9rcHhXNjdn?=
 =?utf-8?B?aXEwM3lRdTBBK1lWc2ZZRkdrS05CN2RaR3JoVkVRNEdvL2hRZ3FGQzRDMW5y?=
 =?utf-8?B?OHozd2U1WE0wdlhpdkVNUTFidnNYVjluZ3FlNkxSbkxZQUtSbklVUElYWGVx?=
 =?utf-8?B?VWNMSkdwb0llNzZBMExaZFdneHNWbFN5VUNIaGVWcGQwcmNNUGNpUy9rR1kx?=
 =?utf-8?B?MGlKbm9nZVdjeCtRZW1sWlRja2pWK2wrSzdBVk4zUEVuT00rK3VselBVMGIv?=
 =?utf-8?B?clFEUHlyUjhOZGZONUcwblhlL0doS0NTYjZRMnR0blJzKzdQNk56VGRPSUg0?=
 =?utf-8?B?N3NQQ25wckhzOG4wbkdzTzF0cHpNYm1zUnBTMDdGSUhZdFJQcUd2NVlrcW0z?=
 =?utf-8?B?RXFYV2VzYndNeit2YzFDbnhweitadHljMlhsa3E3bEptWmp4enBSajNVSktH?=
 =?utf-8?B?QTFwLytWQmhKODVTNjEvTytEeFcya1RFU0hzTVg3YVhZaUZIc2k2VHdYY0kv?=
 =?utf-8?B?dUhlMnpnNGFHUnFNUUwwM2JQWkJWWGhURE55Y052YVFtN2IxVVZybTZ0d2gx?=
 =?utf-8?B?ak93cDNxNEVVTmNyTmlpU3F4Q1dzVjlIZWtOdytZMnNLMkx4a3NEVGoyZE1o?=
 =?utf-8?B?aExLalNZWGc3UEtIM2FqTjNqelJKZWFyM3NrNFEzSmdFSGEyVk1sMHZlVWMx?=
 =?utf-8?B?eU9IQnVsVktsTTJOWXI4S2ZzdkNCSlAvOVJQSGxCMWV3VXZhS3FLZ0ZwVW9N?=
 =?utf-8?B?OXFRVmFQcHhlZnVTT09XaktyMFZKbytjZ3o1bGxwYTgxZklxVjU2dTVTTEs4?=
 =?utf-8?B?K0M3VGIxdlR4OXVCcjdCZkZKaXcyWG1tNzgyWTUxb0RzQ0pKelE3WEVFNXNn?=
 =?utf-8?B?YitrREVtM1BZMnVua1dYYWVGTktjVFZTYVp2aVQ0eU9SbDR1ekx2WUc3YU9P?=
 =?utf-8?B?VUloMTE1SGM1Z091WDVnNVRhSlZMcG5FM0Znbk5aMnFaNkFJN3J1eEh5c0lr?=
 =?utf-8?B?Zlh3MFNxSmlxRVoxUzRWWlZSMkxQZ08rWTZ4ZVF3aHZESDIvbVZuRjNpT2g0?=
 =?utf-8?B?TVExVStWWjd4ejZmc0JieVhYUHl0YmhZeVlpOEx3WGcwbHdCMTMxQStzZkxh?=
 =?utf-8?B?eHFzYlZ4TUZMUWYzWHY5UnFwc2dVY2xaMmMzYXE2eU16bkZLaHFXSm5BRmh5?=
 =?utf-8?B?K3h6TWJWNjQvYU9ZNGVBUnNiUUpPL0pyRnVBYldaOGdEbVdFb1pEeGF0bUZm?=
 =?utf-8?B?Sjlua0c3cWdwM2s0bFFMZWp2aFVmWnNFMmtaM09YRVhuaWsyS0ZYc0E3SVI5?=
 =?utf-8?B?emNkWnZyNG83dlluWXhRdU9yemZ6SlVibHF0bVlmMm9JRXdad29QZ1dJejU0?=
 =?utf-8?B?OENFK1l3ZXgrOGVkRDZWcVBkNkZVSzdBak9VWEkrQ2FmU2xWRWpjTjExSFhp?=
 =?utf-8?B?bWJhSTVFY0hzM1puMFEvNWZVemlWeThLeDAxRnJXbE0xamVPb0ZUeURTTjV0?=
 =?utf-8?B?eStpVzBxaGEzNmxlM0dwSG1rK1RCaHFUbXVZSWp5akRsUlhEczk4WjUrQi9B?=
 =?utf-8?B?VWE0TjNYcFo2dXZoMWFYN05JNGNoTklVUk1YQ0JmNldMSW96K25uNWFIZTRy?=
 =?utf-8?B?OXJ6OWFvZldoMUVGV0dBdzM3TUx2S3FGeFdzdWRVTUFWWitvVmVDNlI0OEJB?=
 =?utf-8?B?Vk1tQ2l4eC9xYXRvS0N3MDB1RnFBUGhOUnQ0UE5ES2FidFBtQlVVZ1dSOFhK?=
 =?utf-8?B?QmM3cHA2ckp6anl4akdiL0tCYVMvcitGd2lhSjc2ZjYyOE00ODJOMmp1TlBj?=
 =?utf-8?B?YTQzTzNCQkRzQWJGYnkzREhkSFhFTlc2TFhEcXM5RFowMFRXblNGaVNhN1N2?=
 =?utf-8?B?U0hRaFdSNWUrUHgvQVJodVdUWldSeks5QmQ1L3pwdUNCMzZYdVBCR2l3MkVE?=
 =?utf-8?B?NEFTVVVzdlhMSGJtU1lkTFh6SDJZWWR5NkN6YXBBc0lrRE8vM0VqR2VnWElC?=
 =?utf-8?B?OU9uamdlSXFCQmk3Zkt3Z3YxNVRpblFpRnRqU1JDUGdwalRBZTUzaUFicDhY?=
 =?utf-8?B?UUtqMUxZVDRxZjFLOTNpc0hZWWpMRnZMQ3NtcU1ZenZlSDJJSmpsMFFvaXpy?=
 =?utf-8?B?YXp5bVJqV0ZMQ2NWa0V2Y3VxR1VJaG5VTmdONWtWbzRqaDlaWndzOVp6eGZm?=
 =?utf-8?Q?xcGHLfVLN1ToAJ63HmYoAYs=3D?=
X-OriginatorOrg: blaize.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9da6291e-c141-4e94-c09b-08dd08ae207c
X-MS-Exchange-CrossTenant-AuthSource: MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 15:23:32.1624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 9d1c3c89-8615-4064-88a7-bb1a8537c779
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VahPVxa3EEDn3wO/7s6EgynWSkYadVckrO5Mh6lS4S08jjEZ0pYclfFb9ATQitZr+uLWWU24mlJMyS6mqHQCuF9cO1rD9cvElc4p5Qhlpvk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB8892
X-Authority-Analysis: v=2.4 cv=RPThHJi+ c=1 sm=1 tr=0 ts=673cad7a cx=c_pps a=z1DpLKiO5LaG0b/iPMc9+w==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VlfZXiiP6vEA:10 a=4MthsM0t3ikA:10
 a=-5LYVjoNHPMA:10 a=SrsycIMJAAAA:8 a=VwQbUJbxAAAA:8 a=4gp9pEUrXjcjW1gsT4wA:9 a=QEXdDO2ut3YA:10 a=zapPnUM7SFj2ezx6rUw-:22
X-Proofpoint-GUID: G94Ird-tLSPcL6kY4dR_MxTrOWlh8vwu
X-Proofpoint-ORIG-GUID: G94Ird-tLSPcL6kY4dR_MxTrOWlh8vwu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-19_06,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Reason: orgsafe

On 19/11/2024 13:37, Krzysztof Kozlowski wrote:
> On 19/11/2024 14:33, Nikolaos Pasaloukos wrote:
>> On 19/11/2024 13:05, Krzysztof Kozlowski wrote:
>>> On 15/11/2024 15:58, Niko Pasaloukos wrote:
>>>> Blaize, Inc. (www.blaize.com) is a SoC manufacturer with integrated
>>>> programmable Graph-Streaming-Processors for AI and ML.
>>>>
>>>> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
>>>> Signed-off-by: Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
>>> Here and in all other patches - you still have the same checkpatch
>>> warning I asked to fix.
>>>
>>>
>>> git format-patch -6 -v5
>>> scripts/checkpatch.pl v5*
>>>
>>> Your SoB does not match From. This MUST be fixed.
>>>
>>> Best regards,
>>> Krzysztof
>> Hi Krzysztof,
>>
>> Just to be certain and fix it properly, do you mean that the issue that you
>> are talking about is that the 'From' appears as 'Niko Pasaloukos' and I am
>> signing with SoB as 'Nikolaos Pasaloukos'?
> Yes
>
>> I'm really sorry, if that's the case, I will fix it and yes, there must be
>> a misconfiguration on my system. Would I need to prepare a v6 for this?
>> If it is not that, then I am really sorry but I will need more information.
> Just run checkpatch. I am repeating this over and over. If you run it
> like above and there is no error, then provide some details.
>
>
> Best regards,
> Krzysztof

Hi Krzysztof,

That's a very tricky error to pick it up. `checkpatch` on my end doesn't produce
an error. The header file on my patches starts as:
'From: Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>'
I had set the mail account as Forname: Nikolaos, Surname: Pasaloukos and
preferred name as Niko. It is an Outlook365 issue I think.

That said, when I was trying to send my patches, the mail server was converting
my name 'Nikolaos Pasaloukos' to the preferred name 'Niko Pasaloukos'.

Do I need to resend v5 again after this is fixed, having applied all the
additional Reviewed-by? What would be my next step here?

Best regards,
Nikolaos Pasaloukos


