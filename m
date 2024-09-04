Return-Path: <linux-kernel+bounces-314442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 506DF96B349
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 09:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74C161C22EF0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 07:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C88A14F102;
	Wed,  4 Sep 2024 07:47:58 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B886614830D
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 07:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725436077; cv=fail; b=A7XxcIRvHmSlPa5Eu8pOg9KPVAGdbd0Sbc1ykNEFa6kez7dMWnQxwXjabYtmn6/1QUPJMXiCg4eXOZZqRVEEpIGjxogzDzfX7e+RJJBKPyBQ715keArT8INm6JAqoOA7bdrKj2Hbzst2yHPtPJuL39ZTP9gpYgWII8V8iVOaRlQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725436077; c=relaxed/simple;
	bh=zQxe/6XU1PuJ5LMKTa/Ih1vVX9Je1JpkVTht4gm9C9I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Slp9Fj9G7SXKIdZfXV+yjm886AKUEaxPZQNtOl4Sy75W8MULX7E5XkbxwxhN9/DAtF/lF1+Os7ZV/wAIMJnXhF8n1yBjv5sfTOP9DO3ktKboBUIHPp8gZ+cgTZbnNMJcrBLoApZ/b7V1SKODOw3mEUG7L4f3tzANgIO5BFLQdv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4845OX3I031439;
	Wed, 4 Sep 2024 07:47:01 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 41edxkg90f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 07:47:00 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VKx0JirVl1tRD6Ybq7qMe/0Ywb/ZIZZXIT2hbjXdcjKwBrP49MvprpiJWWJ2Yt06+Wb7csVWHXAOcAjPJY+bonTxPcguxYwf3CC18j6vYO++1WUag7IO0FRZY4hcsqCO3IzSIpPR9cc7RkFMj34jeDOe0ewViwmKNkONwPuqjZkE91DbL9zC7AT7eUIFIsUyPenb/pltVGQvXjil7vNOWu+4XJVBTfO8QTd0zxdQ+72OfqDvLPvbB1Gy6a5PaAB0+gyPL5Wm6ZYYkNya3/N97P4UIWTUSuZXDqzUWvuxH8ubtf4guPXbPg13VEsuV2GQ/Dyny4GEKaAvM2vBE/76Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZLrZopRDj+kdTuYJpIygIYim3YRQnS/cw1LNaWQ7LQE=;
 b=KFzTN1I+2OPUV0IjNbJnt+sBhrSWV8WrhlUfUNEwmjxqNz3GJy6KJYY2BAlHBmkvp7KCiSN1NKTt20kHtJUmbqBH39uoFBjthhYvn0brAXi5zOfaRgnRHyZ0MPl0qtJIAeVk8yVD0FbXBEm4jzC4BYJMHUdvYd6zlta/qR0dMZzbRU2jPE6uYwiObWuN7cnopwab+wsM7y4ztLs/Jx8kG/e87FUjVH20Wu618KW6DzUlGKTy/n8vW9ZDNdyFVNA4b1CUDMEcH5AVVLT4tVIsPanj93WUFjVIA5eMCKOfF7ZSagrw2g0l6iAH/o4hzyjvdkmlzPqoUxO4x2E6xH09Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SN6PR11MB2671.namprd11.prod.outlook.com (2603:10b6:805:60::18)
 by SJ0PR11MB5200.namprd11.prod.outlook.com (2603:10b6:a03:2df::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 4 Sep
 2024 07:46:57 +0000
Received: from SN6PR11MB2671.namprd11.prod.outlook.com
 ([fe80::3e06:cc6f:58bb:3326]) by SN6PR11MB2671.namprd11.prod.outlook.com
 ([fe80::3e06:cc6f:58bb:3326%5]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 07:46:56 +0000
Message-ID: <943dc66e-0266-4f2c-8154-5a4510fdb843@windriver.com>
Date: Wed, 4 Sep 2024 15:46:47 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: sched: Unexpected reschedule of offline CPU#2!
To: Thomas Gleixner <tglx@linutronix.de>, Jan Kiszka
 <jan.kiszka@siemens.com>,
        Henning Schild <henning.schild@siemens.com>
Cc: Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, Guenter Roeck <linux@roeck-us.net>,
        xenomai@xenomai.org
References: <20190727164450.GA11726@roeck-us.net>
 <20190729093545.GV31381@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1907291156170.1791@nanos.tec.linutronix.de>
 <20190729101349.GX31381@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1907291235580.1791@nanos.tec.linutronix.de>
 <20190729104745.GA31398@hirez.programming.kicks-ass.net>
 <20190729205059.GA1127@roeck-us.net>
 <alpine.DEB.2.21.1908161217380.1873@nanos.tec.linutronix.de>
 <20190816193208.GA29478@roeck-us.net>
 <alpine.DEB.2.21.1908172219470.1923@nanos.tec.linutronix.de>
 <20210727100018.19d61165@md1za8fc.ad001.siemens.net>
 <745f219e-1593-4fbd-fa7f-1719ef6f444d@siemens.com> <8734mg92pt.ffs@tglx>
Content-Language: en-US
From: guocai he <guocai.he.cn@windriver.com>
In-Reply-To: <8734mg92pt.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:196::10) To SN6PR11MB2671.namprd11.prod.outlook.com
 (2603:10b6:805:60::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR11MB2671:EE_|SJ0PR11MB5200:EE_
X-MS-Office365-Filtering-Correlation-Id: b4f7d736-5671-4083-1013-08dcccb5c01f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RnFKNXFQa0VRT2hXaE9NTS83a3o3K3hYUmc0SFdYVjMxKzZHakczZEZyWHdP?=
 =?utf-8?B?M1d6TFdldDQyNUwxajBYWXEvdGFJV1RGSW95aTNyaHRjNWM2SzlLWThpbThy?=
 =?utf-8?B?NVdFVFErUXdMR1lFSUl5ZmMwMVJtajd1YmIybkRSaDkwcGFCdmVMb3BRVHp3?=
 =?utf-8?B?TVBFTUdPOFk3WjlDdFBBUzN4MXNTemUxM3djNHNwVXdkR3I1MTlrdytIZWdQ?=
 =?utf-8?B?K2NCUmFZK3ppMThGSDVnTmgvUWJlUmxaVDNhZFBGSlZXOGFxeUtSZEhUMTBO?=
 =?utf-8?B?NmE0WkhPNjNJRmF0bGRWNmcxdGRCcnc0WW5jTEx4VWNtQkxlYytpdnNrWXFt?=
 =?utf-8?B?VVl3a2E3TTk1OC85Zm5IcnJDUy9LdFpHUm9Ha1ZLUFpVcWRONzU5NU5Iek9L?=
 =?utf-8?B?YVphbjBiVUVnb09iVkwwL1JvNFptbDJoVjR2RzdzdFJ0ZXRieDdDOFVVbmMv?=
 =?utf-8?B?YjdTMWFiYU15dldsRE5XUnJCR3g5Zlg4d3R5S1BSRjFEZCtwTkZLdDJrVThD?=
 =?utf-8?B?bHpIdTdFVnNDZUZncnI0dU9WeXdWajdFWG1XL09hcUxwNTZOWTkwY2s0MGlI?=
 =?utf-8?B?aDhQQk9zbXVWT1M4Rm1oM2s5RWZOdjkvdno0aUdsNWUyMnhJSTJTcTgzOUgy?=
 =?utf-8?B?ZGVZb2g2YjhnTHA0dGtNNi9XN0NQV3pORk1Xa05FRUVjNkpuazF5YmQveFJW?=
 =?utf-8?B?R2ExcmxCYUdZV041a2RzSlVhMEJZTzVRd2tXY3ZYL3p4RzJWWFRBMWcveTl6?=
 =?utf-8?B?NXQ3NVMwVXlCRHhmZm12UCttamlHZStxTVVoR2Fhanc0cUg0TzQya1BvMlgw?=
 =?utf-8?B?ekhNWWo1OW1LQTJuMmUrNmFWOUFXbkwwU1RFS0I2MDBnSkVBVmoxQnZ6SGcw?=
 =?utf-8?B?dDZiNjlRTUIzTG5VNi91RUEzQWl5S2RFa01BVlhnQ1J6bWtYUVUxNTVGdm9Z?=
 =?utf-8?B?UDVaVUhna3RYbm5oMmRzZmd6dmhGQlFST0g2OXpvYllBcVBUTkhGZmhtd3B3?=
 =?utf-8?B?SEdGcW9uVTFicFZBS3lBRmV4Y01QMG1NMkVsM2JPRGp2dWFsdzZidmdMUFN4?=
 =?utf-8?B?R3IvZGN2S1NZcXI1Uml6MVd5aHhIVElaclNRUUhjUmt4blpyODVrQ1ZmNkZm?=
 =?utf-8?B?Zi96dWE0RHRpS1U3b2l5dkZ1UnpzeG5aeVhEQURxTE0yU01lZ3IrenMwbS9j?=
 =?utf-8?B?c0Y5bk52NHY5VUQwalJ2dWRCcElicDdDbW84d1hSRWtlNm50R20xd2VNM1Vz?=
 =?utf-8?B?NXhGZXlPdk5xUXhhbHJ3Ukt0Ui8rdWlXZjhZd3Q4ZzArdzVmTG9BS0EzVEhC?=
 =?utf-8?B?U1hZdlI1UXI0ekt6Q0pkRjVBWFRLcERTU2ZZbHhSZnZkd09MMTZ2YnJGVXUr?=
 =?utf-8?B?bmZtVGJZa3BOSTVaNE9wRFduSWlpc051QUhOQ3dHOS9KYWN3UTg4SU14ekZ0?=
 =?utf-8?B?SDNDVzBrenZQVi95QXlEVU0wM3NKZ0p6ZHR2ZGRla2prSUhpUXV4N2Q0OTJM?=
 =?utf-8?B?VElMcW9GUVJJWFlDY1dYWExmT2hvVGl2bXh1Zm5saVlCQ3A0MWJZYmVPb2pk?=
 =?utf-8?B?OGROVDRWTkM2TGZtWTkwN3NtOHRZNGVyNkp4anMzaU9CbmN3eUtYYWR0bWNP?=
 =?utf-8?B?eGY2N1Vueit5SXU3R2Zpa0ZPV1IreWxyWUxLWjVJTUhmLzB3SmZ3d2taamh0?=
 =?utf-8?B?T1N4ZFlyMGEzNXYrYlJWcGxUTFU2YlovLzBVWE5XcWxQVVY3WTJjODN0TDg4?=
 =?utf-8?B?N2NDQW1rUGZEVWVCZ0RmQ0oxRWtTRW1NN0FoREJIWG85cy92TFZJOWNuVzFq?=
 =?utf-8?B?WVVPM0poODFTdHd1ZFp2dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2671.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QWJwdDRXSDZPSG9mN1dpUkNQK2h3c1pBNTV3cTdpd0lDOFN5M0hXS3JPcjZ6?=
 =?utf-8?B?YjFnUUN0Nkx4cWUzM1JHSVFJbDF1aDQyb3R1b1NwVExmUVZwSUJleFd4VlBK?=
 =?utf-8?B?RzFzRkpSVVhVWXd0TG1pZmRXRnlaWHVvZlQ3T2pSK3I0TTdyMnlEU2JNYUZX?=
 =?utf-8?B?QW5uMlI2Z2t0Rm9pV1dHcytiNEFlWXVGY2x3cGRsUVNZaExJMy8ydE5KR3E0?=
 =?utf-8?B?TjIxQzROc2p2UjNIekZZVnFFNU0rNVIrQU9yTms2NDcvVDRDblkrRGJ1M3FT?=
 =?utf-8?B?dVppd1V4V0JYc0NiZUdjNC9RWUxXa2trZGk2VFljaDBNWVZkL0FZQlozZHkr?=
 =?utf-8?B?QUJ6WTFJOGFZWFNkcDhnVHlXYjRRWGVpMWFoL1pKaDB5RCtuU1ZKb3dCSzFM?=
 =?utf-8?B?UTJmK3VOb05aTDBlR1lYc2xCZnhvaVJpWGF5bmF4N2hOZXhLbjJzdFJBUGJ6?=
 =?utf-8?B?dmZwc2tiSFBvdDd2UmRlL29Ldm5zZ2JDKzZPbzVTZVJaNVRvSGFIbGVWUE9l?=
 =?utf-8?B?T1Y2TjA5VkFhQ0wyUDZUOEpza1M1bE9zTWRJTU44cUZoT0hPM2VRSE1SZmsy?=
 =?utf-8?B?UUxiNXk1UGIwOFpoMUZNZWcwb1NVZCtJQ3hmeW40R1A3ckFMWXVnZmZWS1Vy?=
 =?utf-8?B?Z2hYTzJFV1JnLzV3ZTN2U2U3QVF1d0JWOE1FanhsVVFoL3JBUlgyL1gvZ0w5?=
 =?utf-8?B?dnliMkF5NmFISXUrbWJYcnNhNk5ndzBTa0lzUVJyRVhLeG01S2g0Wk5vOXhK?=
 =?utf-8?B?RDdBQUwrZWZXUWNmOUhPV215SXFhR1RCVk5hU0RNbklxaXl4NkRnYlNDZWxk?=
 =?utf-8?B?SnZ6Y3NYSVRjbURRY0V5Ymh1WVRHaEVYUndyV1pubkR2ZmRaMGhNMk5aMDd6?=
 =?utf-8?B?Rk1WcURFeW53MjlTZW5YWTNGUTN1LzcxWGNyS0pZRVhzbE5yZk11RXRwazVQ?=
 =?utf-8?B?SkVnVk1SN3h0dTJ6cmwxcXQ3akw2c1FLQlZGNmZaa0VPK2NwTUtJM2t6a2dC?=
 =?utf-8?B?ejBSWWlBRlNHcExkTzJISlNSbktMZzZGQlgwdGY1bmpBaGtMRGRWNFQ4Y3dw?=
 =?utf-8?B?dVBneGV0RjZTandWODNycWpreEFuMUdKaFBLcFpBY2V4V3l0d3pGNVZPck9O?=
 =?utf-8?B?Mjc1QnJ6M0l5RWRoVitMYVFTSnJ2bGc4aDE0WWtFRHY1aHVpTkRlQTlSSkZn?=
 =?utf-8?B?WGdsSWNiT0dTMmJKZHU4ZXl1VW1RYklQcUJnNnRYSU9kejlkc05wYnU0TG1u?=
 =?utf-8?B?R3o2cTZrWStmK1d3dzRGTk9YTlJ4SkNBdXZydVY3SWlaOU5NZE41TFhwb1JE?=
 =?utf-8?B?WGs2RU9abnZxZnRhZWJjY2NwSEJaQ3FJTlhrdVRjQ0wyNmJRc0JBdldXdlBI?=
 =?utf-8?B?L1ZqTVVvMi9SWk11bHNpWElpQmlWbUFCclhQQlhaU0R1UzZZQmQvQTRwQU5Q?=
 =?utf-8?B?VTFwZXlmV01GTmpMVTZHNjljVDZTT0Y5U0Y4czBZd1h5NEYzdjBscXp5K2V2?=
 =?utf-8?B?SnFjVHlWS1dPOENLY0FPMWJybmhkc0UxbDk1ODJwMnhod1pqY2w0VkN0S3RC?=
 =?utf-8?B?ZDJGaEJsa09PWk9nbU9mWU05YWJoc3VTdEoxR3loL3BOc1BmZ0hiYkFURjhh?=
 =?utf-8?B?NU14NFI1UnoweURRbDZkcURLNENUQkNsVXZTZWpxSzhPWnA1Y254cVluZXRY?=
 =?utf-8?B?MnBlNXQ3SzdHeGlOY2pyQzJHeFJhTXppdEtXYm50OUJoQUxRYVdNQSs0QUQ3?=
 =?utf-8?B?ZEhyQVQ1d2RwNXN2cy9CUWo1UlNraFNPVDdXbHVHblpRQlk4R29hNi9RbTdO?=
 =?utf-8?B?UWxBbUJFVC9hcFlMU0JNSUYwQkhnMDhKTzg5UkQxWmkrSERzTktDUzF0QjNB?=
 =?utf-8?B?NVJnSzFxZjBCNFhnUmxHbEM1TW1vQmoyN3RyN1ExeTk3ZGR0U0RmNlpWMGxY?=
 =?utf-8?B?RjRwZTNkenRLWkM1c3VQU3d1K3hxN21zNFI3MEQ0YWtlcXMvbHQ2MzVqTTdU?=
 =?utf-8?B?KzJuYXBFU0pvUDZOZk1Fb0g4V2h3TFV5bjFIditkMzZaUFBZN05NdGNtaVJ4?=
 =?utf-8?B?U1FaeU5CS1ZIODh3eXN6aldsbk9JSEhlSFNNZ2xTWG1xbXg0dHphUUFYd0hJ?=
 =?utf-8?B?a3lMdEFNWExWcFg2eFRWQzJvYndOYkdJSDloSmFoT1ZDdUhwNmlQQ0Q2QkFq?=
 =?utf-8?B?WkE9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4f7d736-5671-4083-1013-08dcccb5c01f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2671.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 07:46:56.6754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SNbeLwiaGnjjYIvcuzQVkQtQt/eBVvD6OFpH30vELRUyVs+Xem7cRKvWKbvbFoiZ9ZMgm4pzr8CcMdveMtSP/5RVh7km1v8rl5mNFfu4qWo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5200
X-Proofpoint-ORIG-GUID: LeFGIWZJafX7usICe-DzO3mc-Cv867vc
X-Authority-Analysis: v=2.4 cv=UfsDS7SN c=1 sm=1 tr=0 ts=66d81074 cx=c_pps a=nskeBUqQUen4dZUz4TdP1w==:117 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=EaEq8P2WXUwA:10 a=bRTqI5nwn0kA:10 a=W6pNjswgMLLF6-RXySIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: LeFGIWZJafX7usICe-DzO3mc-Cv867vc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_05,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 mlxscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 mlxlogscore=972
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.21.0-2407110000
 definitions=main-2409040059

Thanks very much.

I will let our customer to try this patch and let you know the result.


-guocai

On 9/3/24 23:27, Thomas Gleixner wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> On Tue, Jul 27 2021 at 10:46, Jan Kiszka wrote:
>
> Picking up this dead thread again.
>
>> What is supposed to prevent the following in mainline:
>>
>> CPU 0                   CPU 1                      CPU 2
>>
>> native_stop_other_cpus                             <INTERRUPT>
>>    send_IPI_allbutself                              ...
>>                          <INTERRUPT>
>>                          sysvec_reboot
>>                            stop_this_cpu
>>                              set_cpu_online(false)
>>                                                     native_smp_send_reschedule(1)
>>                                                       if (cpu_is_offline(1)) ...
> Nothing. And that's what probably happens if I read the stack trace
> correctly.
>
> But we can be slightly smarter about this for the reboot IPI (the NMI
> case does not have that issue).
>
> CPU 0                   CPU 1                      CPU 2
>
> native_stop_other_cpus                             <INTERRUPT>
>     send_IPI_allbutself                              ...
>                           <IPI>
>                           sysvec_reboot
>                             wait_for_others();
>                                                      </INTERRUPT>
>                                                      <IPI>
>                                                      sysvec_reboot
>                                                      wait_for_others();
>                             stop_this_cpu();           stop_this_cpu();
>                               set_cpu_online(false);     set_cpu_online(false);
>
> Something like the uncompiled below.
>
> Thanks,
>
>          tglx
> ---
> --- a/arch/x86/include/asm/cpu.h
> +++ b/arch/x86/include/asm/cpu.h
> @@ -68,5 +68,6 @@ bool intel_find_matching_signature(void
>   int intel_microcode_sanity_check(void *mc, bool print_err, int hdr_type);
>
>   extern struct cpumask cpus_stop_mask;
> +atomic_t cpus_stop_in_ipi;
>
>   #endif /* _ASM_X86_CPU_H */
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -721,7 +721,7 @@ bool xen_set_default_idle(void);
>   #define xen_set_default_idle 0
>   #endif
>
> -void __noreturn stop_this_cpu(void *dummy);
> +void __noreturn stop_this_cpu(bool sync);
>   void microcode_check(struct cpuinfo_x86 *prev_info);
>   void store_cpu_caps(struct cpuinfo_x86 *info);
>
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -791,9 +791,10 @@ bool xen_set_default_idle(void)
>   }
>   #endif
>
> +atomic_t cpus_stop_in_ipi;
>   struct cpumask cpus_stop_mask;
>
> -void __noreturn stop_this_cpu(void *dummy)
> +void __noreturn stop_this_cpu(bool sync)
>   {
>          struct cpuinfo_x86 *c = this_cpu_ptr(&cpu_info);
>          unsigned int cpu = smp_processor_id();
> @@ -801,6 +802,16 @@ void __noreturn stop_this_cpu(void *dumm
>          local_irq_disable();
>
>          /*
> +        * Account this CPU and loop until the other CPUs reached this
> +        * point. If they don't react, the control CPU will raise an NMI.
> +        */
> +       if (sync) {
> +               atomic_dec(&cpus_stop_in_ipi);
> +               while (atomic_read(&cpus_stop_in_ipi))
> +                       cpu_relax();
> +       }
> +
> +       /*
>           * Remove this CPU from the online mask and disable it
>           * unconditionally. This might be redundant in case that the reboot
>           * vector was handled late and stop_other_cpus() sent an NMI.
> --- a/arch/x86/kernel/reboot.c
> +++ b/arch/x86/kernel/reboot.c
> @@ -788,7 +788,7 @@ static void native_machine_halt(void)
>
>          tboot_shutdown(TB_SHUTDOWN_HALT);
>
> -       stop_this_cpu(NULL);
> +       stop_this_cpu(false);
>   }
>
>   static void native_machine_power_off(void)
> --- a/arch/x86/kernel/smp.c
> +++ b/arch/x86/kernel/smp.c
> @@ -125,7 +125,7 @@ static int smp_stop_nmi_callback(unsigne
>                  return NMI_HANDLED;
>
>          cpu_emergency_disable_virtualization();
> -       stop_this_cpu(NULL);
> +       stop_this_cpu(false);
>
>          return NMI_HANDLED;
>   }
> @@ -137,7 +137,7 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_reboot)
>   {
>          apic_eoi();
>          cpu_emergency_disable_virtualization();
> -       stop_this_cpu(NULL);
> +       stop_this_cpu(true);
>   }
>
>   static int register_stop_handler(void)
> @@ -189,6 +189,7 @@ static void native_stop_other_cpus(int w
>           */
>          cpumask_copy(&cpus_stop_mask, cpu_online_mask);
>          cpumask_clear_cpu(this_cpu, &cpus_stop_mask);
> +       atomic_set(&cpus_stop_in_ipi, num_online_cpus() - 1);
>
>          if (!cpumask_empty(&cpus_stop_mask)) {
>                  apic_send_IPI_allbutself(REBOOT_VECTOR);
> @@ -235,10 +236,12 @@ static void native_stop_other_cpus(int w
>          local_irq_restore(flags);
>
>          /*
> -        * Ensure that the cpus_stop_mask cache lines are invalidated on
> -        * the other CPUs. See comment vs. SME in stop_this_cpu().
> +        * Ensure that the cpus_stop_mask and cpus_stop_in_ipi cache lines
> +        * are invalidated on the other CPUs. See comment vs. SME in
> +        * stop_this_cpu().
>           */
>          cpumask_clear(&cpus_stop_mask);
> +       atomic_set(&cpus_stop_in_ipi, 0);
>   }
>
>   /*
>

