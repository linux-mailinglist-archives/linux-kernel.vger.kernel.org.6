Return-Path: <linux-kernel+bounces-181760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 440EA8C80E5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 08:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 678691C210ED
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 06:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9348613AEE;
	Fri, 17 May 2024 06:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="V4s7C6oz"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D30A13FE7;
	Fri, 17 May 2024 06:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715926927; cv=fail; b=UIumYAk87SXvQ5C8l3jhnianQoTf9Qz5+AzHGvGwv4z+fnvOJrhVmggx9i5S6Wbivz+D9W+pzxCpKEKXXThwkaIX4LTDuJDXDc0oMx9/4j0BGRW1NdcWqurbxJlOyd2iTPpCrSMC/JXFxzPcYUcvpIw71dCFNCnuomi7Uj9d01U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715926927; c=relaxed/simple;
	bh=M7tWDXtn7tMfZ0ikfh/F1WlcRP5QqYHyEwIycjxRUhE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jsqlytDt622jiOZx3FzNMmWbEL6TQ0uPBFGYBSAJX+xNLyc7wsrzZmQULCxn5C65zJ0L40OBo0J08/EEE1BfO0LhOBiwjR/VHmtGE6cmj5ZwAXlbmPMvNd7SaXHf0FuULyuMiC+Cn9R8WD77nKUidGurWXn92eZcs2QP0eTXZjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=V4s7C6oz; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44GLTcxj006304;
	Thu, 16 May 2024 23:21:42 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3y579bcsg5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 May 2024 23:21:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dy3aihksh1o9kX1DNvsHeNrJ82RTKWw2Fn7YNsrxN4Mo6h8bVzalL7Mo8lxALDb+914Mfrsn3dbpxqb3XhhzIopHz/OqRoKBCfI/kvZNI8vUYvDk2caPfZN+n/ER42N3nC3ERg4Pn/bWrVS4XnpA/Qa8sI2K6H/QGaQBxV7K2qRhAES2Yiu8TjGaDQNzp3nkTYJ1sPZXodJnuqai3azCJ9iHphms/s3zhZAjqLipf2rtGsCQFkaPym7N0KD77Wj9DOr5/0xfAAhGnxvh5/nhLc2XyZSFgYjUIlz+5mu0tXDliP6hoFveT3CvGsmNaImVX9zNph0cPLQeyumesEMwQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PP7R099u0TNcKrgzw1JsLcxpewLnqU+bVAEyZpGqf3M=;
 b=XyOcNzYJMmSreWrZ1GNjx4PJuBN//4cyPdWK3XSMh/X23scx0Wybm26OMXMOD0SBe6s9Y0nOnqfuVSbFuPfLn7dEIA9NKsZFH9YIZfolhcFyKqZpToJdSaidF9dLlsvSAdxZnuKwox+bAVqp9GPwrWADvRKwsAqB/3RPOQEKMQ7iqriWh1FzEaSzVfjJPeQVRem+qLnjU9TILmpqAnoCEpuTscUywxQCkl6Uw/Ac7g8WOz/o81+mRLe69tPkZjRshAxHCCCAz80VFAlOAEP3cLgKXh/ilIGG3DBtJwCho0tz9/olys+604DEs1BUpbM4IxM4fqBN0h69x7YQbDTVcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PP7R099u0TNcKrgzw1JsLcxpewLnqU+bVAEyZpGqf3M=;
 b=V4s7C6ozDXWl9iwAjdMQ+WE7WYO04kh8VPenJohdAv73WZtk0TiUBOhd9O1JNOylTFy/aNiIDvnQGuSQWaO5BKo5Mq5zryb3hbvzFKZNb+gmiBXS03ls2WTrQ6cCche8yMv/oHLnxAewNdk5YigOXut4eezH2Ba3kQteK+PvMyI=
Received: from MW4PR18MB5084.namprd18.prod.outlook.com (2603:10b6:303:1a7::8)
 by SA3PR18MB5297.namprd18.prod.outlook.com (2603:10b6:806:2f5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.30; Fri, 17 May
 2024 06:21:39 +0000
Received: from MW4PR18MB5084.namprd18.prod.outlook.com
 ([fe80::1fe2:3c84:eebf:a905]) by MW4PR18MB5084.namprd18.prod.outlook.com
 ([fe80::1fe2:3c84:eebf:a905%5]) with mapi id 15.20.7587.028; Fri, 17 May 2024
 06:21:39 +0000
Message-ID: <ade33946-bb94-4357-bc6d-a354661b50ca@marvell.com>
Date: Fri, 17 May 2024 11:51:30 +0530
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/4] reset: add driver for imx8ulp SIM reset controller
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>, Liu Ying <victor.liu@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc: laurentiu.mihalcea@nxp.com, devicetree@vger.kernel.org,
        imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20240516204031.171920-1-laurentiumihalcea111@gmail.com>
 <20240516204031.171920-3-laurentiumihalcea111@gmail.com>
Content-Language: en-US
From: Amit Singh Tomar <amitsinght@marvell.com>
In-Reply-To: <20240516204031.171920-3-laurentiumihalcea111@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0156.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::11) To MW4PR18MB5084.namprd18.prod.outlook.com
 (2603:10b6:303:1a7::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR18MB5084:EE_|SA3PR18MB5297:EE_
X-MS-Office365-Filtering-Correlation-Id: a6b68e46-b89c-45df-ab1e-08dc76399cbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|7416005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Si92MkhZV3dJT1hwelJZRUd4dzMvTXZqTWlCQkRveWY0Vlphb2ljMGRrcXNQ?=
 =?utf-8?B?cWJrVDlPODdVM1R1cXE1RjNidEdvU2FrMUVIMTdGWm43MmNmWFRDVnBBclFD?=
 =?utf-8?B?S0hmSEplaWRwbVZXdTBIL29iSC9SOU5aNnFTSm00RXhHTEt4NlFZcTJrZ3Fn?=
 =?utf-8?B?bnpyRmUwNTZqeEtrTWQzbUR0WXQ4ZkpsWjZvRDcvZUFTemdVQjdETzJBZlhn?=
 =?utf-8?B?clZUY1VCVGlSSFV1ZWlSTFlad2kwNjJBOVVjY0Y1NmlaNHVjTmhmR2dxc0N4?=
 =?utf-8?B?MklBNElXaDJZTHRFWExndWhZY3dnNXZnb2dUa0ZsRmdrY3NURU1kdEhSdkhU?=
 =?utf-8?B?T0ZvY2ZiMERGYnhYbThKV2wybTNNN0hTSG9UdlZOK0xQTVV5NHhKQ3FXVlZv?=
 =?utf-8?B?dWQ4RCt0c0syWlZkY0oxbXplbk15d2lpNCtHbC9PK3pFK05CbVAyRHpMQU1N?=
 =?utf-8?B?R09qUkxvb1c5cmVROURlMkowQTRBQkEwREx4bWNTaFlOVVRnRU5PeTJVZklZ?=
 =?utf-8?B?bkZpbjdBc0VGZmlFL1VGVmkyYVZ2Ti9rK0QyL09IbVRMK3VtSDhnSktHeVVX?=
 =?utf-8?B?Q2d5MkF4R0xpQWJxVFl4L3RzTGZKeDRTYXhDT2xKQ2MwdnNFT1k1ZzBtRlhn?=
 =?utf-8?B?WFFNUnNadU9vVjd4ZHBkMXRUQzJ1RWw0YVY2a2lvdDg2Ym9jRFRvbWFUVEk5?=
 =?utf-8?B?NWFIUjdDblBjMXZkcm5NRFVCVldxaUlCb1pjYmdsOGdrb2VuaWlZMWh6UlBo?=
 =?utf-8?B?V0VrMm5jYXl2SGNwdlBnWFM0N1hqTklCZk9qSHlrYlZOMVBIYkxXdWsrQmRE?=
 =?utf-8?B?Y3A3dlQwUUl3M0JycmJ0WkFRTFg3cUQ3TXNhU2dQVk44VkZEZ0dVbWRkeFpl?=
 =?utf-8?B?ZFFUYUQ5cVl2Ujl6dUZXSTc4ZW5LUWtBNHZXNFRCN3R6N2UvUkppOFVXeitj?=
 =?utf-8?B?RkM2REU0dE9HRkhjZ2pYYWFmaTJPUjFuUzRWYk4xT3BWSmtyTkdTbXY5MFNk?=
 =?utf-8?B?cWhhUUFwbXh2aHBPdk9paTE4RVB5M2crcnN1aFdhdDN1RXQ2dEdzL1Z5NGVZ?=
 =?utf-8?B?UHkwNnd0ZUpwZ0VCSXNNVmdkVkRPanFCWWZuc0FxaERNMEpScFVBN3ZXUE9O?=
 =?utf-8?B?c0l6ZTEzVlhuRzBiWGtxZ3VkbWJ6RzluQktDMmE1QzErUlJCcFhmVDFESFBn?=
 =?utf-8?B?ejFTSEVvMkwrSHRVQzNtMnRCRWlEZE43S251Y1djUkpTSXRxYUxaNHVZbU0y?=
 =?utf-8?B?dDZ3Sk9vQmFrQldrM0tMTmxUVnZoblhSZHhoTzlETFFudXFPS1VXOHR5SWlw?=
 =?utf-8?B?djUvUkFoOE9EbHp3MnkzRFF2T09HR29seElZZWtHeUp6cVVvTWVTcG11U2g4?=
 =?utf-8?B?MlhpemNHMmhhU29ieWpXTmw3YWp6Q0dmeHlTQmJTblB3OUx1Z0ZzU2ZIMis1?=
 =?utf-8?B?NWxZZWs3OGdQeWF2NzA0WTAvUkJmMnJuL2lnd0FsRHhSS0ppbFB3MWlPQlpG?=
 =?utf-8?B?Z2VaOTdQVEN3MkJUcjlJRUQ5eTZ0TkdITGhZNG5iajJlQ2V6SjJHVnNBOWg1?=
 =?utf-8?B?YUE3V1YvK0VodVZKeWFqRmFjUEFBODhUajNiMFhVb0U3azd0NzRBcXYyT0tj?=
 =?utf-8?B?MTNxaVdudWFUVlhvYmU1eFlIb1NrbXc9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR18MB5084.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(366007)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YzVpTFJOeGJ3bFhDSkpCYTNZL3ovMlFmODRWL3IrK1pMSGp3b1dSN3JRR0dO?=
 =?utf-8?B?WHhiUlJYTTFJS05HbUNlWDZwTTJIYUZUVG1ibXRaT1hzbTFjWnQ0RXR2b2Zs?=
 =?utf-8?B?aGNvTEM3TS9NdmQ4WjNLeFVsL3YyUHVMRVFqelczUHVPbDdGbXhYdlFCVHJK?=
 =?utf-8?B?WFdjRXFEWXFtamo1cFhuUVhPVzUwSVZROWIxVnp5VjdlandxNWtBSW1COGcw?=
 =?utf-8?B?WTgzcVhoeURKbUN5YWsvdDQ0azRwRG9hQXl1VVJ5REozdE9KdUl6M3VpVm54?=
 =?utf-8?B?UnRDTFFGVFdONWhXbkNoNFFMcGhOUTVaYU02cmFoQkNXTU5ZU1FiUW05ZjQ0?=
 =?utf-8?B?MFZFNTExcXIyQVVvNUw4V1BFZ1RyQ2FlL2xvb1BSaXpoQ3hkWHNmclRlNFVq?=
 =?utf-8?B?TXdhc0laVUt1VW9WYWptVGxRRGNOSTBkdFU2SVBmNGlSdWVpRVhPdzZlOXM3?=
 =?utf-8?B?Y2xncnR3Y0JOOUhHbWl5VzV6Smw5aVAyWHF4TUk4UE5sZ2t6blVaK2pGd0xh?=
 =?utf-8?B?YnRWSEQxNXBmbE9DdEV6SzIvOWUxVjdTVTRJVDFaSVN6M2V0eURqRG5PU1ZE?=
 =?utf-8?B?QW1jV2pwWXZ5M2Q2SFlWOTcrMWJwV1h5Y3A4WWFCdTBjbUVzMFBlempiNGxw?=
 =?utf-8?B?eFZqSnpxMVlWUXp1ZnBOTi9YTE5SSzJ6WGVGcTdJR2REQ1hjSWg0cFMvYzVS?=
 =?utf-8?B?WVpoZ2p5T3lVM2VvbmczdGVsbVJIcnZTZmJLVXZWLzJBMnBhZTBIREIyUEs3?=
 =?utf-8?B?NjlQVUtKemo4RWFDRHlwbmtJTExWeTVkREJSaHNBTkd4R3pMd2dYVVFUNElp?=
 =?utf-8?B?WndBbHZHbHZBcjc1YzNycUxqekx4UFpKQ1JmVFBiek1OQjlsRjVhOXVpK0tN?=
 =?utf-8?B?d0FtLzc0TUMxK0hyaUwrVkxKQlVEanVPWTRHRHk4MVZ0bCt1MkRnSmdiQ1Aw?=
 =?utf-8?B?UVF1SDE2THYzdUlmTlcyV2FRRjRnaTI5OVRyUGdLYUtJMTdiWUJhQUlYV2w1?=
 =?utf-8?B?ZGJCdXFKK1p3UUJGaXNCa1FoRTJzOW1lbkRTdWNXeXQ1Mys5Nmk4MVZzVTkx?=
 =?utf-8?B?K0l2cmRySDVraFB3a1l2T053bFRZd1ZqNzg2a2ZVcWhYYituVUw0SXNvbnBY?=
 =?utf-8?B?MjVKdUx1QW9JcUtHdURIQklYdzJvZ09TVkxyS2NwLy93NFNYczRST0I1V3Qy?=
 =?utf-8?B?cDROd2FzcTJUWGExRE9IbXpPdlNsMEZxemQ2a1JNdkhNZDBoUndKaXQxMEsx?=
 =?utf-8?B?TmRiN0hCMnhjaTRDc21wdm9JNTlZNjBNaUVIMnFoNTc2Zmd0cklpek5DZity?=
 =?utf-8?B?TkZCZVY4czF3NU51OWxGZVFzWDFMU3crTVV5TWxHNHk4RmRQa1Y0TisvSEx1?=
 =?utf-8?B?NDZLMzV0NWhKUk9vbW9rbDZEMnYwQnMzOUtKYXo0V29LNkxTSXZoNG92T0tn?=
 =?utf-8?B?YUp4NDh2TTcxNjU0ODcyUWNXUkU5WTh3MTJiWVJHMktOdnVrbUcxL0JyOGVL?=
 =?utf-8?B?QmJ2UFlPK1VTcHI2VVJDVWRzemhzSFlGdTNid3VEUGZtVnI5RlBDV09lLy9R?=
 =?utf-8?B?V3JrMHlKWVVhQk1ObmhLVzM5RlZFMmRTTllUWVY4WGxZVS96ellxRDBEbUo4?=
 =?utf-8?B?aVFRUkk3cEhCTlpqNjkxamFHT0lxa0RUY0I0eDRsdjVtTXhPTENVS1I0ZGUz?=
 =?utf-8?B?ajFNVXByL2dNaHNkeHdnUy8xVkQyR1dFVlFqUEt3S0p1MGFQdkxRb3kwMUlL?=
 =?utf-8?B?dndra3laQ0FmamYyMUc4Sk50ZmV5QkNES2ZOTkR1WFEvZHdFNlVxd3ZFclAx?=
 =?utf-8?B?N0oxUVp1K3ZkQS9OdXk3cnlsV0RleHpWTVd3ek9lc3QrQlpMbmFBcEsrZ1Jx?=
 =?utf-8?B?RHN5cDQ1b1FaeTUxVEVGSitONWdBd3lmMEx0OXVIdUkwWXM2S3BJYVBjTUlr?=
 =?utf-8?B?amg5ZFRjRHhycVhvUDRsNlFpcE9YcnRnU0tIRzZERWxXMmRIWmtWSmVZc0VM?=
 =?utf-8?B?OC93aUVUNTg1QkFlTmJaRG5Ma0p3MEpXY3RaeU1LMkErcmluL0V1Z3ZLNFVR?=
 =?utf-8?B?QUFWMVpML0MwOW9XUVpLWm9UaW9weEcvUG5obm5iOVk2MFl3Mm1tSGY0MTMr?=
 =?utf-8?Q?IDjaEBllvJPDiqstG33KuemC3?=
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6b68e46-b89c-45df-ab1e-08dc76399cbf
X-MS-Exchange-CrossTenant-AuthSource: MW4PR18MB5084.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 06:21:39.7688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tw6ueqj2bgoKGHZmIXGPCOvdMO3gOyuPTpjKtwTYokzL4DFdSOnKe2V7bt8lQ1QdA3b04gYsHo33bRvgg53DbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR18MB5297
X-Proofpoint-GUID: 6-Dm21TrpjI7pRQ_GBBQV4TslYhsOHIR
X-Proofpoint-ORIG-GUID: 6-Dm21TrpjI7pRQ_GBBQV4TslYhsOHIR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-16_07,2024-05-15_01,2023-05-22_02

Hi,

> ----------------------------------------------------------------------
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> 
> Certain components can be reset via the SIM module.
> Add reset controller driver for the SIM module to
> allow drivers for said components to control the
> reset signal(s).
> 
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> ---
>   drivers/reset/Kconfig                         |  7 ++
>   drivers/reset/Makefile                        |  1 +
>   drivers/reset/reset-imx8ulp-sim.c             | 98 +++++++++++++++++++

Just out of curiosity, can't this be accomplished using a generic reset 
driver?

https://elixir.bootlin.com/linux/latest/source/drivers/reset/reset-simple.c

>   include/dt-bindings/reset/imx8ulp-sim-reset.h | 16 +++
>   4 files changed, 122 insertions(+)
>   create mode 100644 drivers/reset/reset-imx8ulp-sim.c
>   create mode 100644 include/dt-bindings/reset/imx8ulp-sim-reset.h
> 
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index 85b27c42cf65..c1f4d9ebd0fd 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -91,6 +91,13 @@ config RESET_IMX7
>   	help
>   	  This enables the reset controller driver for i.MX7 SoCs.
>   
> +config RESET_IMX8ULP_SIM
> +	tristate "i.MX8ULP SIM Reset Driver"
> +	depends on ARCH_MXC
> +	help
> +	  This enables the SIM (System Integration Module) reset driver
> +	  for the i.MX8ULP SoC.
> +
>   config RESET_INTEL_GW
>   	bool "Intel Reset Controller Driver"
>   	depends on X86 || COMPILE_TEST
> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> index fd8b49fa46fc..f257d6a41f1e 100644
> --- a/drivers/reset/Makefile
> +++ b/drivers/reset/Makefile
> @@ -42,3 +42,4 @@ obj-$(CONFIG_RESET_UNIPHIER) += reset-uniphier.o
>   obj-$(CONFIG_RESET_UNIPHIER_GLUE) += reset-uniphier-glue.o
>   obj-$(CONFIG_RESET_ZYNQ) += reset-zynq.o
>   obj-$(CONFIG_ARCH_ZYNQMP) += reset-zynqmp.o
> +obj-$(CONFIG_RESET_IMX8ULP_SIM) += reset-imx8ulp-sim.o
> diff --git a/drivers/reset/reset-imx8ulp-sim.c b/drivers/reset/reset-imx8ulp-sim.c
> new file mode 100644
> index 000000000000..27923b9cd454
> --- /dev/null
> +++ b/drivers/reset/reset-imx8ulp-sim.c
> @@ -0,0 +1,98 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +/*
> + * Copyright 2024 NXP
> + */
> +
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/reset-controller.h>
> +#include <dt-bindings/reset/imx8ulp-sim-reset.h>
> +
> +#define AVD_SIM_SYSCTRL0        0x8
> +
> +struct imx8ulp_sim_reset {
> +	struct reset_controller_dev     rcdev;
> +	struct regmap                   *regmap;
> +};
> +
> +static const u32 imx8ulp_sim_reset_bits[IMX8ULP_SIM_RESET_NUM] = {
> +	[IMX8ULP_SIM_RESET_MIPI_DSI_RST_DPI_N] = BIT(3),
> +	[IMX8ULP_SIM_RESET_MIPI_DSI_RST_ESC_N] = BIT(4),
> +	[IMX8ULP_SIM_RESET_MIPI_DSI_RST_BYTE_N] = BIT(5),
> +};
> +
> +static inline struct imx8ulp_sim_reset *
> +to_imx8ulp_sim_reset(struct reset_controller_dev *rcdev)
> +{
> +	return container_of(rcdev, struct imx8ulp_sim_reset, rcdev);
> +}
> +
> +static int imx8ulp_sim_reset_assert(struct reset_controller_dev *rcdev,
> +				    unsigned long id)
> +{
> +	struct imx8ulp_sim_reset *simr = to_imx8ulp_sim_reset(rcdev);
> +	const u32 bit = imx8ulp_sim_reset_bits[id];
> +
> +	return regmap_update_bits(simr->regmap, AVD_SIM_SYSCTRL0, bit, 0);
> +}
> +
> +static int imx8ulp_sim_reset_deassert(struct reset_controller_dev *rcdev,
> +				      unsigned long id)
> +{
> +	struct imx8ulp_sim_reset *simr = to_imx8ulp_sim_reset(rcdev);
> +	const u32 bit = imx8ulp_sim_reset_bits[id];
> +
> +	return regmap_update_bits(simr->regmap, AVD_SIM_SYSCTRL0, bit, bit);
> +}
> +
> +static const struct reset_control_ops imx8ulp_sim_reset_ops = {
> +	.assert         = imx8ulp_sim_reset_assert,
> +	.deassert       = imx8ulp_sim_reset_deassert,
> +};
> +
> +static const struct of_device_id imx8ulp_sim_reset_dt_ids[] = {
> +	{ .compatible = "nxp,imx8ulp-avd-sim-reset", },
> +	{ /* sentinel */ },
> +};
> +
> +static int imx8ulp_sim_reset_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct imx8ulp_sim_reset *simr;
> +	int ret;
> +
> +	simr = devm_kzalloc(dev, sizeof(*simr), GFP_KERNEL);
> +	if (!simr)
> +		return -ENOMEM;
> +
> +	simr->regmap = syscon_node_to_regmap(dev->of_node->parent);
> +	if (IS_ERR(simr->regmap)) {
> +		ret = PTR_ERR(simr->regmap);
> +		dev_err(dev, "failed to get regmap: %d\n", ret);
> +		return ret;
> +	}
> +
> +	simr->rcdev.owner = THIS_MODULE;
> +	simr->rcdev.nr_resets = IMX8ULP_SIM_RESET_NUM;
> +	simr->rcdev.ops = &imx8ulp_sim_reset_ops;
> +	simr->rcdev.of_node = dev->of_node;
> +
> +	return devm_reset_controller_register(dev, &simr->rcdev);
> +}
> +
> +static struct platform_driver imx8ulp_sim_reset_driver = {
> +	.probe  = imx8ulp_sim_reset_probe,
> +	.driver = {
> +		.name           = KBUILD_MODNAME,
> +		.of_match_table = imx8ulp_sim_reset_dt_ids,
> +	},
> +};
> +module_platform_driver(imx8ulp_sim_reset_driver);
> +
> +MODULE_AUTHOR("Liu Ying <victor.liu@nxp.com>");
> +MODULE_DESCRIPTION("NXP i.MX8ULP System Integration Module Reset driver");
> +MODULE_LICENSE("GPL");
> diff --git a/include/dt-bindings/reset/imx8ulp-sim-reset.h b/include/dt-bindings/reset/imx8ulp-sim-reset.h
> new file mode 100644
> index 000000000000..a3cee0d60773
> --- /dev/null
> +++ b/include/dt-bindings/reset/imx8ulp-sim-reset.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause */
> +
> +/*
> + * Copyright 2024 NXP
> + */
> +
> +#ifndef DT_BINDINGS_RESET_IMX8ULP_SIM_RESET_H
> +#define DT_BINDINGS_RESET_IMX8ULP_SIM_RESET_H
> +
> +#define IMX8ULP_SIM_RESET_MIPI_DSI_RST_DPI_N    0
> +#define IMX8ULP_SIM_RESET_MIPI_DSI_RST_ESC_N    1
> +#define IMX8ULP_SIM_RESET_MIPI_DSI_RST_BYTE_N   2
> +
> +#define IMX8ULP_SIM_RESET_NUM                   3
> +
> +#endif /* DT_BINDINGS_RESET_IMX8ULP_SIM_RESET_H */


