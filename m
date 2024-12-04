Return-Path: <linux-kernel+bounces-430753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1D69E3503
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 09:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47C1D282D1F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 08:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4C7187858;
	Wed,  4 Dec 2024 08:11:56 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EA418DF73
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 08:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733299916; cv=fail; b=ugDYTTga+9v5I7QfaCH4Dz+P2/dMGuLSAjo7Y37k90+QPGYUas0p0ZN1CyVuA2WJIV83jeRflEWKT5XLUETyvSv0HJ+2mdFIfct9sJuNhDRqfyuDvMhGwK3cPgQ56cQPIACj6p7b6pLNqIARSll7Y5KHS78OwC79jwb6wVb50y8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733299916; c=relaxed/simple;
	bh=6YZpI/DJsKh3EUbmMSsi98LrjochmVVQU+s8P42MvJM=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=rDL/n+FzUzgmlnGDWuM2o9ReowgdZKWPNIfNB/mwossMdwOrjyJeNT7Pb1TuASC2Bo58QGAmHk2n9NGqiHDSKMA3HvUl1LXxP3Z8/0ExAod9/U/b8YISGY1A6mzc29jXBuV+NFGGjv8wb9+lHGxtcSn81s5KeOGmvmJhOv+bpDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B45jhtB016158;
	Wed, 4 Dec 2024 00:11:17 -0800
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 437xv7v9mq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Dec 2024 00:11:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OSQEr1kTMABQh1tMhF95QHWQKVZfqhLM0ThvBkgeMZtUPz1rVjh9XUzi637FQTtVGrYjPtS4iD83cyyEJJGJeIrcmEiIii6jvaaZxvlppIP2mqsv3CCfd7QLnN+OCj0lLMK34R3cX+vAVG6lE/T0KDAyFkuHe0qrHhBwLXzYfN2rPBYmVkrAnuC5bRhzwi//GdEAS2OaC1GsMjFeCjq/jmeWwji6DuerdpfDFQ9Yw/B50ABTCW9suBoeVi9lOpKeEVmfcMKtOMmrkMKKarn5ho1Nc+G7JHUuWUXthOSCiwXpHbKZncR7Z+ccbtayEFII9MGMQ6eDLndvH7BzfcKbKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kAijzlo6fZfHuX2jNkp6T2qcY6IYUzyGH2FWRTqjHrM=;
 b=c7Yy+4dJG/Zb751bnuBTvvpQdiuDif8oqUm67mgpKBynA5obJ0JehcihrHWqR3MT6BRoGUk6mSi7pqx4iVs/eCisLpBS+DNNpQ5LWJxbjfYRks3xeJFR6oRbuLT6hYJK06pd34Pta31SxE3mCz8pwMJGv/So1xe3e0RyVZQEPEQ52ppA+lzOS5mQn0zJiAR20wJkH655/iJK8yTRC8d//3PnudFum+Z3H50Ql34dnyINj/fRE4/xsKe7GbELoef9Rh2wUGoBvdmsZSLjmbmEPyrK4LBqvmMEyBcEqKkf/ASCV4+y52PfJzca2VyHYx9Rr4dyG7KqpVD0kVxWMFVHOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO1PR11MB5009.namprd11.prod.outlook.com (2603:10b6:303:9e::11)
 by MW3PR11MB4634.namprd11.prod.outlook.com (2603:10b6:303:54::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Wed, 4 Dec
 2024 08:11:14 +0000
Received: from CO1PR11MB5009.namprd11.prod.outlook.com
 ([fe80::b03a:b02:c24e:b976]) by CO1PR11MB5009.namprd11.prod.outlook.com
 ([fe80::b03a:b02:c24e:b976%6]) with mapi id 15.20.8207.017; Wed, 4 Dec 2024
 08:11:14 +0000
Message-ID: <b10f3774-5542-41f6-8c9b-f9fc6decd4da@windriver.com>
Date: Wed, 4 Dec 2024 16:11:08 +0800
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "tony.luck@intel.com" <tony.luck@intel.com>,
        "bp@alien8.de"
 <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "He, Zhe" <Zhe.He@windriver.com>
From: "Yu, Mingli" <mingli.yu@windriver.com>
Subject: [QUESTION] Why there is additional info print when run "mce-inject
 uncorrect_error"
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYAPR01CA0227.jpnprd01.prod.outlook.com
 (2603:1096:404:11e::23) To CO1PR11MB5009.namprd11.prod.outlook.com
 (2603:10b6:303:9e::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5009:EE_|MW3PR11MB4634:EE_
X-MS-Office365-Filtering-Correlation-Id: 602b8563-766d-490c-e2ee-08dd143b38d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TFBidEtrbzVGSmNZOVNKeStsdExSL2RLbVovS1poSDlNY1NMc2dGT3NBVlR2?=
 =?utf-8?B?M0tweHBiM1BZNG1YSG8rNUNNZzRFaVE2UVFlR3dsY0ZHQlB4QmgxNWg4Zjhk?=
 =?utf-8?B?Ly9aeVEwSFNlbS82ZzgzR2ZYeFd6WjBuODc2NzhNOHpsZE1CTWpzNnRVYnRO?=
 =?utf-8?B?Zzhqc1daYmgwUTQxM0h2T0VVcDc4UnJzbVNOem1UWncvZTlyeDMzMWl2Z0xy?=
 =?utf-8?B?R1hZaThuSU5hSWluWnArWG1sN3BqR0FrR1p3RG4wd2xRK0NaNGJWU0F3a2hJ?=
 =?utf-8?B?ellNNUZiVUFnTUJYVk5BbFdtdlcvRHFLdDF6UDBlMDFLVDZveUgxR0lLQ2p0?=
 =?utf-8?B?VytBSlFod3lqSnQyUkZpeWpSZlVCUGxDa0J2aC9VWnJmR0hGbGxBUDFtODFy?=
 =?utf-8?B?SVlVbG4zLzdYd2FhdHZEMFgzUXVHNDFtTE5HWUtnWUY3ZzlXV3J4K2dKOXhy?=
 =?utf-8?B?ZHl5MkM3WkEraGtuYlpYRnZxSFg4ZVRINkJFa2tTU1NuaFBYVExHM1BVU2Iy?=
 =?utf-8?B?bVZhZEZNOEhVd05XS29GdGNURHRLOUgwK0pNVG5lclI5OC9tbk5xTnRtUUxl?=
 =?utf-8?B?Wmd0UWUveUovbmRycFA0dE13SHhmVlo1ZW50aU1SejFaSVJoQXIyOXRUZTM1?=
 =?utf-8?B?ZjZ0OWRKQzdWSUozV1kvajU0dU1iYk4xQUtTazBvdmVSOGN5bXdsRnBDMmJS?=
 =?utf-8?B?b2RCRW9OazBpZlNDWWtWZThVVXZkTlNwWDc1TVdZOGhyRE9ZTzRPZktSY1ps?=
 =?utf-8?B?U25FTW1EQ1lwa2NqSkhmMXkyMnd5SjVDTGhMNjFzUzg3WW1RdldPWEc2bGJ0?=
 =?utf-8?B?R2FzMFJOMXhmL1hDRkI2Wkc4QWNocndGS0VLWXhpUURWYUZBMERLQUNFUitk?=
 =?utf-8?B?M0FtczBWREYzaFlJRTFoeVFsZWpGdVBhb0ZNTFhud0tCM1YxRjJTNTdPcTFI?=
 =?utf-8?B?V05nanlOSFRCK2VRZnR5TVo3ZENpMkpOSXhTNXRjUTNpcUhPQ1duZlR0OG5T?=
 =?utf-8?B?bFZSNXNwVExFWTF6cVpjVExvamJjZDg5RUlQdjFIRE00Z0ZNb1ZCaUFZazRC?=
 =?utf-8?B?K3A4OVdWSmRzUnc5Qi9jZTIvRHNQOUYrNnUwQkl5QXI3S3JPRm1YZmlhdW90?=
 =?utf-8?B?MUxqcjBqL1c3bFZ5Q2d1cS9YcEpCaSsydHRPaWRabWEzVWw0Wis5OVhBWWpJ?=
 =?utf-8?B?Qkg1eTkvRHZMUG1oTHhsL2c4WDIzY1ZRT1k5VFZYajZJVGZzNE0rc1RsbEJ0?=
 =?utf-8?B?d1hHUlNrUTFzOEdUMkw2aGpxZGFzTUpLQmRTeFFBeDR4YzZzaWViclorWjRX?=
 =?utf-8?B?UiswMDVTbFRrUmRYSXVoS1FVVFZadlQxc0VLdnFQUXRySDJjOVRaMkJBNlFU?=
 =?utf-8?B?MUsrUmo1Z1RKU012R1pVc1FLU1pmN0pRanRxbVlWc0ZhMG5IMGlPQ3h5NWUy?=
 =?utf-8?B?c1hZRUdUSFVqV3BTUWxKVnFialgyTnFCcGduY1dqVEdncEFFZzc5WlM3TzNY?=
 =?utf-8?B?cGd6UFBYaUpIUk9paHJ0ZTZRN0g4VVJ2ZG1HVm80MHhMMHpEL1lra3NKak82?=
 =?utf-8?B?ZTV4cFNKZXRmNlgxaTh1UkY0WDl1anFJd2xqeHF0eGQvbzZVczdpdjIycHlH?=
 =?utf-8?B?TFVhZ2Q1bjdWVjEyUUxNelk5SHpTWlhVK3cxc0phdVZWQng4Y3NXUVRGUHJq?=
 =?utf-8?B?OTJ6SEZEMzBmalBzcmVwVS9WRmo1REErNnhkQzFzUEtSUWJyTHFuWEhLREVn?=
 =?utf-8?B?WEk4UEI2SUMvWUNJVm5NL2ltU3EwKzZTck91YjJuamRGcForZW94ZFVoTjM0?=
 =?utf-8?B?ZHJ5emlvS3kwSkpFNEdIdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5009.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eWE4YVlwVUdhTWI2azZ5cnptZzVlOGkzbkFpUnpBenhLODlhTmFWSkM3T3Rp?=
 =?utf-8?B?c1drSGZNSWFtbXJZNWZMc3M4ZlYrMVkrc2o4ejVrZDVxNXFKekhsR2tYVWlk?=
 =?utf-8?B?OVBPSWVJZDRleElPSVd0cUo3WHV2TG1lNThZKy8zVnhMeDdOTWVqT0NkNjRU?=
 =?utf-8?B?QXZNK2l5cFA2QWE1SDVnMGlqQ21vQjI0V050akNzN0lJZ1RReWtNMHpNcnNl?=
 =?utf-8?B?TXRtMEpxWmdkcy8xWnpVR2VON1NhU3pGM0crMW9tdmV5UlJCK0JONExXZ2Vu?=
 =?utf-8?B?Nlg5RHRZNUZIS1cwMVZ5ZlR6NVhpdm5NRnFoTExKdE1SdHpMdU9Bc25ZVlJP?=
 =?utf-8?B?RmU2ejVMREVVMkVmL2RUUHRBa1V2YWk5NVhVTGlqR3lrcUJxS1dWeWZSZjdF?=
 =?utf-8?B?c2ZTKzdMMklKbXNjNlZSZWRZbXl3aXQzVkVlZDltYWpPVHZldGExUktMbHUz?=
 =?utf-8?B?cE5qTCt3QWttK2hkdGE2cWVhckJGL1BEd2sxdm5EdThDOUZnNFFpWVUzRTFT?=
 =?utf-8?B?bzlnQkZQNDVLa29lK0lvVjVWR0g0Sk85Y1Q1K3BDUGxRMTB4MlNRcUo1QmZn?=
 =?utf-8?B?d2NMM0k3SUZCYmd4MzJ2ZUpJWm9INnJHa1E5djg5UDhUQndqRGRCWjhKVjFl?=
 =?utf-8?B?RVptNWdXS1hjRnJpOWhVWEFJRzRuV1FQWmIrdG51eUo0T0RkbytQczdaREdI?=
 =?utf-8?B?TndTbGN1azIwWVlGK2JDM1hTUVk1VHdISEY2aVBoTVRtV0t3WGY0eE1EZGJR?=
 =?utf-8?B?N3Z4L1pBanZob29zOXNSc1Mwbzh6NHFZb3RNeUEvWXhhdkowbC9wL3dZZ1hx?=
 =?utf-8?B?aTJwRFkxSkV6UGdiTXh0MnYwQzlwSXk5OEhIZ0lMK2ZQRk9Jc0RWcWxVTkEr?=
 =?utf-8?B?RXRkTUgwS1owNFc4b01VOGFXUnJWaFhYaTM4SnpMU0NMSW5CakpJbmcwaCtv?=
 =?utf-8?B?SHZ0RkhjWlRtWkdHdndmSFoyZFdvMXI4dHVSNWszN05ZS1lnTkVzRzVzcGVv?=
 =?utf-8?B?aU5yNnVQKzU1eml6Y21Jek44SDk5TkxGT1dyQVdENGthNzJlRSsrNnFmS0d4?=
 =?utf-8?B?a3NrNUpCbGRmZUIzK3hyMk9MQ09QTVN0WHJ4UDZMN1ROVXJJOGFsQ1VXTzlp?=
 =?utf-8?B?NHhmMEV5U3dRZGU2VEJqMGREY050SEJ4aXNRdGl1NkxTcWkyUXB1cENNcjdP?=
 =?utf-8?B?endSdCtuWW5sb1BzbURYM2VqS21rdGxzODIxQ3B3ZmgxUG1yUGRubElIRGFT?=
 =?utf-8?B?RTFCVlk4M1BnbzFtQ0E2dVNrQ1NTY2FFVEJQdktKeE5KbVJEbnBTa0NCUlpS?=
 =?utf-8?B?cFdVQm1jN1lNaGFxTFZXbUVnblpLOVVnbVJjZGxCOCtFaGZFOWFxd2l1QTFJ?=
 =?utf-8?B?ckduNEdvVEhzSUY1R01qcWl6d0dmcUJISXBxb2x2N3VOVldtYjZEYloyOHlp?=
 =?utf-8?B?ODJiQ0VpRlhOZ3FrN0tJbENGQ2pmeVRJd0QyNVJYSUIyTW4zQ0xQMHBweEo5?=
 =?utf-8?B?U3FrbmVYVzNSQkZGTTNzRFlGUU1rNzcwSFgzVXJKTFViT3lYdnJ6a1ZSU3ZO?=
 =?utf-8?B?TlJQMmdQRy90NHZsSGZPanVPd1g0WEIxSVNMSWFOU3NldkdSV3NjbjZmUS9R?=
 =?utf-8?B?ay9BTHhzUHFqWStZYkVMbmRjWFpwV2lVQkV2WkdTcUh4NWJabDZjbDZRSm9t?=
 =?utf-8?B?UDBpUTVqVGFOQzJQNllQaVQ4RHdHTEZuUHdrYjJEeTVGVTNDVyt6a0hwWlUr?=
 =?utf-8?B?UUJJalJEOHNQb0wyM1UyZGQ3elFzY0hGN3JCRy9UeVFOY29YeWRPNFNNOXZI?=
 =?utf-8?B?VGMxaFlqTGM2RjNwSENvTzM4amRRZWxwNTdnTFZGZFRPendyeVNqNDBoMDR6?=
 =?utf-8?B?cTNjbEZmREJja2diM2Z6N01Kckdoc0h4YmFHaXoyOEZUQUZ6M1ZPTjNOcStn?=
 =?utf-8?B?NjVGNmhMZG91TEFYS2dEMHJQOU82WHNIZld3VHhQZFAwSzNHSzJCOEFWYjFI?=
 =?utf-8?B?SFg0ZnVYVWZucXJyNERkcmFlcXFkdmo5L1RiWXU4bUR5bEZuOXJ2cytya2U0?=
 =?utf-8?B?ZVBVYnc2MWJkWkpZcVlkVTV3dklneThFN0FRQTZzdW5JSjVrRm15dXRuRVZn?=
 =?utf-8?Q?NWo+JgLWgC1X2dQ/Ls/gZSAOy?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 602b8563-766d-490c-e2ee-08dd143b38d7
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5009.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 08:11:14.6943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 27HRIJpvfLbO1rur4w2tJS+C6UjKGwgVEbLlK8810TVq0/q2rtXcsW1pcEQmIC+rkmbf/qmLQ6LaCpa4Xt347A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4634
X-Proofpoint-GUID: 4RbVO2NL7e7IqQPBQHm69GF-TCyqN1u3
X-Authority-Analysis: v=2.4 cv=RpA/LDmK c=1 sm=1 tr=0 ts=67500ea5 cx=c_pps a=6H1ifQWhBrriiShMtbI+RA==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=RZcAm9yDv7YA:10 a=bRTqI5nwn0kA:10
 a=P_w0lqFH_8aCQdc8d4MA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 4RbVO2NL7e7IqQPBQHm69GF-TCyqN1u3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-04_05,2024-12-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 spamscore=0 bulkscore=0 malwarescore=0 adultscore=0
 phishscore=0 mlxlogscore=976 clxscore=1011 suspectscore=0
 priorityscore=1501 mlxscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.21.0-2411120000
 definitions=main-2412040062

Hello,

Have noticed some additonal info which seems unrelated to mce when run 
"mce-inject uncorrect_error" though add "quiet" option to the boot 
paramter. Confusing about why there is additional info unrelated to mce 
printed. And the additional info gone after add "selinux=0 enforcing=0" 
to the boot paramter. Don't understand why "selinux=0 enforcing=0" 
affect the additional info printed. Could you help to explain more? Many 
thanks!

# cat uncorrect_error
# this should just kill the process
CPU 0 BANK 1
STATUS UNCORRECTED
ADDR 0x1234

# mce-inject uncorrect_error
intel_rapl_common: Found RAPL domain package
intel_rapl_common: Found RAPL domain core
intel_rapl_common: Found RAPL domain dram
[00] BAD 00 ff ff ff ff ff ff 00 04 92 19 02 01 01 01 01
[00] BAD 15 12 01 03 6d 00 00 96 ef ee 91 a3 54 4c 99 26
[00] BAD ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[00] BAD ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[00] BAD ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[00] BAD ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[00] BAD ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[00] BAD ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
fbcon: astdrmfb (fb0) is primary device
Console: switching to colour frame buffer device 128x48
ast 0000:06:00.0: [drm] fb0: astdrmfb frame buffer device
cfg80211: Loading compiled-in X.509 certificates for regulatory database
cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
cfg80211: Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248db18c600'
8021q: 802.1Q VLAN Support v1.8
8021q: adding VLAN 0 to HW filter on device eth0
8021q: adding VLAN 0 to HW filter on device eth1
8021q: adding VLAN 0 to HW filter on device eth2
8021q: adding VLAN 0 to HW filter on device eth3
pps pps0: new PPS source ptp4
ixgbe 0000:07:00.0: registered PHC device on eth4
8021q: adding VLAN 0 to HW filter on device eth4
pps pps1: new PPS source ptp5
ixgbe 0000:07:00.1: registered PHC device on eth5
8021q: adding VLAN 0 to HW filter on device eth5
pps pps2: new PPS source ptp6
ixgbe 0000:08:00.0: registered PHC device on eth6
8021q: adding VLAN 0 to HW filter on device eth6
pps pps3: new PPS source ptp7
ixgbe 0000:08:00.1: registered PHC device on eth7
8021q: adding VLAN 0 to HW filter on device eth7
bridge: filtering via arp/ip/ip6tables is no longer available by 
default. Update your scripts to load br_netfilter if you need this.
igb 0000:04:00.1 eth1: igb: eth1 NIC Link is Up 1000 Mbps Full Duplex, 
Flow Control: RX/TX
IPv6: ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready
igb 0000:04:00.2 eth2: igb: eth2 NIC Link is Up 1000 Mbps Full Duplex, 
Flow Control: RX/TX
IPv6: ADDRCONF(NETDEV_CHANGE): eth2: link becomes ready
igb 0000:04:00.3 eth3: igb: eth3 NIC Link is Up 1000 Mbps Full Duplex, 
Flow Control: RX/TX
IPv6: ADDRCONF(NETDEV_CHANGE): eth3: link becomes ready
mce: CMCI storm subsided: switching to interrupt mode
mce: Triggering MCE exception on CPU 0
CPU: 0 PID: 1727 Comm: mce-inject Not tainted 
5.15.169-rt76-yocto-preempt-rt #1
Hardware name: Supermicro SYS-E300-9A-16CN8TP/A2SDi-16C-TP8F, BIOS 1.4 
01/29/2021
Call Trace:
<TASK>
dump_stack_lvl+0x38/0x4d
dump_stack+0x10/0x16
panic+0xaa/0x2ed
mce_panic+0x27d/0x29d
mce_timed_out+0x80/0xa2
do_machine_check+0x29b/0x684
raise_exception.constprop.0+0x61/0xa0
raise_local.isra.0+0x67/0xfc
mce_inject_raise.cold+0x26c/0x331
blocking_notifier_call_chain+0x68/0x90
mce_chrdev_write+0xc2/0x110
vfs_write+0xc7/0x300
ksys_write+0x6d/0xf0
__x64_sys_write+0x19/0x20
x64_sys_call+0x47c/0x1fa0
do_syscall_64+0x3d/0x90
entry_SYSCALL_64_after_hwframe+0x6c/0xd6
RIP: 0033:0x7fb4274c728f
Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 69 ad f8 ff 48 8b 54 24 
18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 01 00 00 00 0f 05 <48> 3d 00 
f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 bc ad f8 ff 48
RSP: 002b:00007fb4273c6d70 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000558b0c4ffd40 RCX: 00007fb4274c728f
RDX: 0000000000000058 RSI: 0000558b0c4f84a0 RDI: 0000000000000004
RBP: 0000000000000000 R08: 0000000000000000 R09: 00007ffd77a1bf4f
R10: 0000000000000008 R11: 0000000000000293 R12: 00007fb4273c7640
R13: 0000000000000000 R14: 00007fb427455820 R15: 0000000000000000
</TASK>
Kernel Offset: 0x2c400000 from 0xffffffff81000000 (relocation range: 
0xffffffff80000000-0xffffffffbfffffff)
Rebooting in 30 seconds..


When add "selinux=0 enforcing=0" to the boot paramter and then run 
"mce-inject uncorrect_error" and there is no additional info printed as 
below.

# mce-inject uncorrect_error
mce: CMCI storm subsided: switching to interrupt mode
mce: Triggering MCE exception on CPU 0
CPU: 0 PID: 1727 Comm: mce-inject Not tainted 
5.15.169-rt76-yocto-preempt-rt #1
Hardware name: Supermicro SYS-E300-9A-16CN8TP/A2SDi-16C-TP8F, BIOS 1.4 
01/29/2021
Call Trace:
<TASK>
dump_stack_lvl+0x38/0x4d
dump_stack+0x10/0x16
panic+0xaa/0x2ed
mce_panic+0x27d/0x29d
mce_timed_out+0x80/0xa2
do_machine_check+0x29b/0x684
raise_exception.constprop.0+0x61/0xa0
raise_local.isra.0+0x67/0xfc
mce_inject_raise.cold+0x26c/0x331
blocking_notifier_call_chain+0x68/0x90
mce_chrdev_write+0xc2/0x110
vfs_write+0xc7/0x300
ksys_write+0x6d/0xf0
__x64_sys_write+0x19/0x20
x64_sys_call+0x47c/0x1fa0
do_syscall_64+0x3d/0x90
entry_SYSCALL_64_after_hwframe+0x6c/0xd6
RIP: 0033:0x7fb4274c728f
Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 69 ad f8 ff 48 8b 54 24 
18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 01 00 00 00 0f 05 <48> 3d 00 
f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 bc ad f8 ff 48
RSP: 002b:00007fb4273c6d70 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000558b0c4ffd40 RCX: 00007fb4274c728f
RDX: 0000000000000058 RSI: 0000558b0c4f84a0 RDI: 0000000000000004
RBP: 0000000000000000 R08: 0000000000000000 R09: 00007ffd77a1bf4f
R10: 0000000000000008 R11: 0000000000000293 R12: 00007fb4273c7640
R13: 0000000000000000 R14: 00007fb427455820 R15: 0000000000000000
</TASK>
Kernel Offset: 0x2c400000 from 0xffffffff81000000 (relocation range: 
0xffffffff80000000-0xffffffffbfffffff)
Rebooting in 30 seconds..

Thanks,
Mingli


