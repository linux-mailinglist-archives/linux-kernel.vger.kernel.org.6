Return-Path: <linux-kernel+bounces-519795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F19A3A200
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33B6D7A24CA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895DC26E630;
	Tue, 18 Feb 2025 16:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aOi5tJO6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VGAa3dQJ"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E9726E154;
	Tue, 18 Feb 2025 16:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739894528; cv=fail; b=MYOYr2/tXkZ7/xjZhfWV0M9Gplw5gozhJy8HmmJOwaSQYnQPifqaL84XgLGsv8c6rY5m/D3cJ2GZ3AiaEWdZ/EW9Vljf1pXgOdRqFaq/w62JkJy/WQXDSxmKOVM8rSVKaAKhCG07/4Ida6j9FJ9p8+8g+O6rYkQTrGJyRIOLiJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739894528; c=relaxed/simple;
	bh=7SxqzWusjQ9EqMl3WLaqhthxbbIpvsiBgPB4R9vKpWo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=C3v+FREPVgfA7FskMoxUirwU+e7DSO5TZo/wdeHJ0wwnH1bZUv7Zyu6NNIha9tH/VXsZvmg4ypgkq5wyUIvKQB8wZpvf354XhLgCan4AyKgvXRbggJNOP6Asbfk+q6Civ+Ooxqjh8WvMdqHQk4lO59a2V+HKR/rShcURqqq9BFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aOi5tJO6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VGAa3dQJ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51IFtaos025759;
	Tue, 18 Feb 2025 16:01:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=t0TrabwC5APUyQ4jdm8r7MPRsqTbXqK+YCgmoU6ly/k=; b=
	aOi5tJO6WfK4u4irBh9VtS8K6BaBNnY5faGivn74b1sX+/a1zujSsbfeEPwBzZXX
	cMtHvBlHCnGFYcjdvVhziwYtSUb0C7aN9rXJ2E4Jzi2MB0tKK48CYVoxPt86G6Tn
	FjxrAwqtJhHQRdQn4exPE/B4JdPbXdM+z9KoIGT2HFSIgdNIstp51fdX60Wp/NGH
	A5GNAQepk2HeVVJJqasEVZJRrQ/K6VmKfn/DTvqMJgJCAO3S4LzeZRL+aV33uHCb
	hWma14ZsDIfD0WWv0AUnobXo7JdVcntIhK55yV4XrfnGxSXUrbLzol3aBlbgPtLc
	0M0jNyVQFMXALXKsJ3fNQw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44thh06wjd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 16:01:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51IEhsJ7038836;
	Tue, 18 Feb 2025 16:01:23 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44thcaghbd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 16:01:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IpX0DfdXVXL8duSRMPPDb7G2Fs9p2evDkzn89dHO9mWhM9/uMI/pZYW4bF/tx3h4MIKFtO3eS6DHs4LvymPS9gWqlv7ZjXZz1ucEkHPnMJCGS/AwKekCR9Fi0zjUse5lJmJFS6thSLBg1/CBiBsbJtR+vlyiFwPXfHd4YN7H4m3aNKNo7wBzMK3lx83qlHskwJaHmeED66fgUvRQB/Jv9ejk0xfGpLWbJ5A7e7IaHzMjVVw5l9JHhJfCl0GwO7nU2wlPLXJhnKUN/qFJW4gTQL0CORedyqxdjvbFkbTTkFDsX202iJUCnl+iCcHZVwAvleOMFkRBaGQULt0Rk8ItGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t0TrabwC5APUyQ4jdm8r7MPRsqTbXqK+YCgmoU6ly/k=;
 b=xqRyCH487mTq37sxXI2/ipp+7lJ/sP6+YNYNIZdtAqMKCUjz1Vyf95XR+qioFYkd6uyuC4XLjibpGdhUiMx6QusHFdfiVT5N5MgBiVfuytiHXX2ZFmrOyau/TxLhpdBwWly4jVANOXcYQNSZUESO8WvjBnnZbX5yXjBU7iQksFOnZ2OnRdfOupyObcqBleJQ4xs+hyfc+ZU6qudqDsTXLV3pBrOOiS3xRky+AV/CjhuSHFmarOF4UIlkCJJBkCj/xukYYtS1UmAw3/pz4mQmjg5GkySTAAkQEndzVj+peM/XBmkHtehJhPG6lKHaHD1jisCUw8te+5v2XrYI8owaKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0TrabwC5APUyQ4jdm8r7MPRsqTbXqK+YCgmoU6ly/k=;
 b=VGAa3dQJJsBqN3J9y6/D0rOE+sqcPvnXnujn0SziMVMJmqZSktV64qlMv73O+w1l/CNkrrQg4JOHi4xl4RtnQhv/yVkuKXV6SiIpdBffFyVm2fPAa8l3zwQy9vtkNzHmWSRPQVnT6DJIS/79gMTpeygHZgJRiIPnjUJzd7UwsxA=
Received: from DM4PR10MB6886.namprd10.prod.outlook.com (2603:10b6:8:102::10)
 by DM4PR10MB6912.namprd10.prod.outlook.com (2603:10b6:8:100::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Tue, 18 Feb
 2025 16:01:20 +0000
Received: from DM4PR10MB6886.namprd10.prod.outlook.com
 ([fe80::bdcc:98f5:ebd5:cd38]) by DM4PR10MB6886.namprd10.prod.outlook.com
 ([fe80::bdcc:98f5:ebd5:cd38%5]) with mapi id 15.20.8466.013; Tue, 18 Feb 2025
 16:01:20 +0000
Message-ID: <6c965dbc-9f01-414a-b218-2fa88155eb52@oracle.com>
Date: Tue, 18 Feb 2025 21:31:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: apple: rtkit: Fix use-after-free in
 apple_rtkit_crashlog_rx()
To: Sven Peter <sven@svenpeter.dev>, Alyssa Rosenzweig
 <alyssa@rosenzweig.io>,
        Janne Grunau <j@jannau.net>, Asahi Lina <lina@asahilina.net>,
        Jens Axboe <axboe@kernel.dk>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
        Dan Carpenter <error27@gmail.com>
References: <20250212085853.1357906-1-harshit.m.mogalapalli@oracle.com>
 <0e609fea-48b0-4b39-aae4-90395a782ed8@app.fastmail.com>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <0e609fea-48b0-4b39-aae4-90395a782ed8@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGXP274CA0006.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::18)
 To DM4PR10MB6886.namprd10.prod.outlook.com (2603:10b6:8:102::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6886:EE_|DM4PR10MB6912:EE_
X-MS-Office365-Filtering-Correlation-Id: b23cce8c-a1be-4c1d-83fb-08dd50357bd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZDhMZXlHWkl0OFZabCtyRFpIZ0txVkkrNitZUzJLVDFQWkJNQk5HOUZvcHhv?=
 =?utf-8?B?bStBdU1JMEU4U0FQZFYrVFh4ZGZpdTVEOUJvaGdQR2d6Z0RMaGI5WDNXSkZL?=
 =?utf-8?B?MXFkT2c4REFURTJNL3ZSeG5LYTZyOEJ5ZlJaeGVBN051cWlmdW9TS0N2Y0Vh?=
 =?utf-8?B?enJhdW5ZOXlnSVIyRVZtYUtkdk5nZmxHSUpXRWNvTFRWbHFKc2JBcnpDekV0?=
 =?utf-8?B?d2VBRUI2aGkvTmZhd3NzQkI4OXJMVXg4U2RyVFlxVHZkeVhvVGU3ZDgvVjI4?=
 =?utf-8?B?dkRSaktzZkU1a0swdzdjUGhDRWdIWkRLM2p1cDhrdEFPM2hNalBYTUlGZy9w?=
 =?utf-8?B?Zi9hNnBCU2tUblI2QklGcmRNcmtwOHVPdTg0bzVwVUpnQUhDUmRxZmRrL3U3?=
 =?utf-8?B?U1lDTWVyL0R3Ulo5ZlRyRUY0N2hQenNveEM3RTk2WmorRzZQa3IzQWlSVjJF?=
 =?utf-8?B?bzZWY0svUTlXTUNvUEpSYisvcEUyaDB4UnljMUlqTUlXWU9nUFJqM1VjMkRX?=
 =?utf-8?B?NXZkeDIxQ2RHeUh2Y241Y2ZlTGJjMU1QWi95TDFuK0JHSXdVZThhR29xMlJ3?=
 =?utf-8?B?MHdXTUZkSXlyYkRTRXpLV1BWdDZDR01oRXlSSDkvT2EwdS9qZFpjWndzVVU0?=
 =?utf-8?B?TjZ6RTJPeHlaMDFGSEcxMzdSRTZrbHhOSXU3MjRRdTNKa3FBM0VNUWtPcUIz?=
 =?utf-8?B?S0E0U0Q5UGpPa1FuUDdnTzBWaG9yWTRmK1ZGS1NVa1dpeGNNaWMyc1duL1g1?=
 =?utf-8?B?N3Jsa3lsZW9ORm55L1VaUElkUDlhOUhCU3NPdEdTMGpmVlRpR0R4c1Y5d1p1?=
 =?utf-8?B?bTVETjJXc1NQVlBVR0trc0trWHd4a0NoSlVOaWdSVzNVcmJHcG5QQzl5blRv?=
 =?utf-8?B?UHc5cHVxNnY0enVuNVMxZlhwU0ZxRnpQNS9la09NRXJ4TmVVeEZsMTZzYUcy?=
 =?utf-8?B?WVFWbzJyVDFIbituMVAvcVRDY1lrMmNyZ2RCWU5MNmM1V3g4Szc2RGloYTU1?=
 =?utf-8?B?YW1ZUUQ4M0V3TjRLMTdmRU15Yjk3dHRHd3BVWHV5T3ZNdkNhWlg3QlVPR3Uz?=
 =?utf-8?B?dVpJZFluR0Fma3VpVVRJTEFWMW1ZUCtlOTV4d1RUMm9FTG43dG15S2dxM1A0?=
 =?utf-8?B?dGhRaWJsS245TjVnZG5Uc3U0QmhxRVlUaDgxYm5obmZ2d1dDc09FMHRXdHlh?=
 =?utf-8?B?Rm95RjZVeVNoYlpTbWc0c2VxaGxTVFZTOXRhSFlQVElBSGxqbVBSclFrMDhq?=
 =?utf-8?B?VkRza29CTjVQYnN3aGdMNk4xTHc4eGUwUUp4SU9saUJyUVNxVWdoSjR1cXRn?=
 =?utf-8?B?Vm55LzFEemhMTDBXbG9sczE1bGtnakNrVFU0YXM4blZkd1pJcm5xTGpCUk43?=
 =?utf-8?B?b0kvOTJOM2hocDJEQUthamYwb3NJUUcraVpOOGtKOTBGeW5FRm1WRFR0VHh2?=
 =?utf-8?B?R1FCQ0dWUEhYUi9QUm9iaEFCb3cvTnNrMithc3FJSXVMQm43WGRqTTRHVk1U?=
 =?utf-8?B?MkhSbHY1dW5jVnY4b09iNDVrRDkzTmdJUjFMUnBIWFZMaDUxUTdmNTJ3L244?=
 =?utf-8?B?RkhoRkVSY1NVTDVHcEtNOXBBSXNuSVNvbXc5RHpYNmdkMDhJaEFRcjBTdExG?=
 =?utf-8?B?SDNjZHR1OXd2cUNrRGdvTVRkNkF2aTJSZnlVNU05SGczSXFCZUx2RkVRdUZx?=
 =?utf-8?B?RFFpeWd0YXRodll3TGNKOWU4UUxGVGhSelFmYzVxcEpibVdlcUNVU0JMTU5N?=
 =?utf-8?B?U0lDaC8yNjZjbDZZL2YzbHEvZnd4VmlhUUp6NEg2d3dTOFdPZzVoUnlhWFY1?=
 =?utf-8?B?TXQ2dkpsaHpyS0hLTUx6d1NheW1GS2h2S1dWbWlmMzBwdmdQOTRzNERrTEU1?=
 =?utf-8?Q?wTZG4kxJWwIyn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6886.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bHdIclZIdmwxRHpobmlxWFcvVWdrbTNEUnIwbXhjaEw0ZFlORkZVWmdaeUxa?=
 =?utf-8?B?UzR4RGxSMVBwRlN6dEtFQzRDOFduMndKWnI1QVY5YmgzMzFlRmRKazl1emlG?=
 =?utf-8?B?ZVlTbThENXA2NEZxTTF4dFdVRGxaZjI0NkVGZVlZeUtnZ1FrRWl3MVRLZEJE?=
 =?utf-8?B?YTBiN0QvUFR0ODNEaDQ2SE90ODVta1ZjNWlSL2hVMDkzTHBiMmVoRlRRWDBQ?=
 =?utf-8?B?ZTdheXREN1BDaTNJc1VRVFlSTm1hRnRubU1iK0JIV29td0wweHZBOVB3U0Ra?=
 =?utf-8?B?SEg5dmk2QUhlSzlEMDN0MDE4bnVoZ3hqR0hPcDE2YndpL1dEU3NZdmRRemZq?=
 =?utf-8?B?VmZORFRweENnMFRqY0RNR0Fmd085N0xYQytxZTJtZ2pqMjhKUjA4U21TeElw?=
 =?utf-8?B?OWZSYm91QkxGUm9hVTFQL0ZnUjBTd2VZOCt1amNRNFNQbGJabGxZaDdVMlBN?=
 =?utf-8?B?ZWpma3RXV1hyWTQ3ME5zL1pGR2tLdjJrcTdFOFVmei9nQXRtUUhpYmxFcHJy?=
 =?utf-8?B?TldoYlpUc243eXZMMW0vU2RaT1FEVXVFc283Q1lVU2pEbVk2ODA3L281VHFX?=
 =?utf-8?B?ZmFyaDdBUm9Lelp0UzlvOXhXaUNQTkVoekNlUm54aHprKzNYY2dtZDZuVnNO?=
 =?utf-8?B?aFVBWDRoR0R4bitQazdRbFN6ZE5YUUZweGh0blptY29RUXJaUjFQa2NCZXd5?=
 =?utf-8?B?RDdaOHJSQWY0eXdHYVNTUElFZHVnanl2UjBmcnMyUlhlQndqSGVMY3Ircmoz?=
 =?utf-8?B?TW1WV3pZTUpEVktkVlpIMWhGSi9UY3F1cFJvM1BGUTNRYXB5N1hXODV3bHYv?=
 =?utf-8?B?bkJiTFB0QW85SndFQ2R5aGpRTGRLWU5pSWR5VUZhOGlMcmtqdXJCMHpETU82?=
 =?utf-8?B?Q2VmYjdzekhPTVB1S1E0WXVCRTBsT0lwL1FtSTNtYkVKS1pMbTR1d1JsTEQ5?=
 =?utf-8?B?dDhZQ1ZFOTgvRTV5SzYxNU1ibzBOUEl4cTZFZllRZmFGRVlYN3V4dEN5Y2dk?=
 =?utf-8?B?U3A0TUVFYkhFdmRWcHhKTUx4L21CbHdJMWprbXBWVzN0Z0N5RUQyVTR5STR0?=
 =?utf-8?B?bVZ2ZnlnMnFXZnAvYSt5L0pXTE45OHVYbHExUmpwTW9SRjRUL3NHeUUzZXRI?=
 =?utf-8?B?bDBJSXJQVFdRUVlXTVRrK0IvVkFGbVZPS1ZndWxlMnpmbDZkckFORGl0MG9G?=
 =?utf-8?B?TG5JUHgwZnhjOVRVNFZwMlpIRGtoVlZzdG1FUVdTS2xid283M2pTQ0E0bUp3?=
 =?utf-8?B?UzFCNVhIS0FBcXhkd2ZudndsYlg1WlEyY0lrQTJ2UW9Ka1V5UEVtc1JRT1R5?=
 =?utf-8?B?OFRoc3pjVlJOVldBalF6ZTI0ckZGaGZLUHdZeGJKSW5jaU9ncnFhSDZJamJ1?=
 =?utf-8?B?cUlNaGsya2tQbzhWd1ZJSy92OTlEZzJJVGI4L0srMFlTb3crSU40U1J5eTlv?=
 =?utf-8?B?ZURSd294Zjh2VFVTOTd6dUN2WDFtVkc2blZtL0h0c1QxM1hoRXN5NWtUckpa?=
 =?utf-8?B?WFpVdnlWNVF0bUpwQk5ONWRqWklZWWdJcVNKZWFXMHlOeVFlb3hXUGZsTGR6?=
 =?utf-8?B?eWJSMjFIYkMyczhSYlRNMkZEeHQvK01vc2pHcU54b05xTG8yNzJrdFVRN211?=
 =?utf-8?B?U01JUWozcUt6dkM3Y2Nobk1tamZ1VS9CVnRhMUJ1NWFrTm9IV21pVCtkZ2pv?=
 =?utf-8?B?VGUwWFpTbzRDem5LMU1lb3AzUWtvS2xBTFVIazMzYjd2dlpOMkdSd0FxZ1I3?=
 =?utf-8?B?YnplMVpJaENBTU9VREZaRll5OVI2QnNWT3NYd0RIdUdNRGUvZmVIbis0UE9P?=
 =?utf-8?B?N1ZTK1NNSnBxc2RIWEhOcjQxTzFCTHF3YnpHSStObVlQenFyb0xQZGZXY1F0?=
 =?utf-8?B?eU92cGZrYVdudXVwWkdBOVpnaGhUUnljSHZ6RFZqRSt5UURwS3lMbFJ6Q3Bn?=
 =?utf-8?B?Y1ZrMXNJRWZwWDk3dU1zMmFNOG1xaGtCV3ZSU1lxdGdtT0tZWkNvVWtSZUR4?=
 =?utf-8?B?V0YxNTVxTWI4T0dCbWxJM2NxREhoVUVLbVJKcERJWkVIUnBHZU1HK1Z6NlhK?=
 =?utf-8?B?a2RwcTVZTVBJVzY5VzNINXoyeVhINEVRbk4xTkVUeUMrNnJRbXViRC95K2J5?=
 =?utf-8?B?ZFhsY0hOM2cwQUorNG9kRm9VQ1FrN2R3aU55dHdNNmVaRXdYcVlFVG5oV1gy?=
 =?utf-8?Q?Ds/gjPclbDAhjqU3zWsBhc0=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qJIwYWDTGSLtICbKyHUXzS0UAddticrwD6bGLFM8c4Bmmt7eK6lxl+GpjKCJP1Ei0BARR8f0hiHtgPt7IqkrHIygEtIN1Q3aYrGu5U8kq08K9u5S5Le3c4tDUBhpUg0kqu1tXdVkx/zBT6K2VZfT1bvchrXhJ8a+MlDEnLvV90XxwJxoCIvM4fljh7vQlmWzPq/wSc3PpS9Qo9S9OfCwUP1Uxkp6GKDt48l7mlU3MzdH6aBCqZkvKcbiNYuc2GYpSpAA3VhFqyo6eHMnDeRFKq04yQViKvuESekO3gJ3srumI1baLJAjGKYifvnRLKJvz2sYFXOBKU603iE9QEw0ee0560xBSfBAje2ZjGx5PJvrScUS0KRFSOqnFCdZ5JgtCZnd4LahTo1o78/+5fN+rEmxL1+nw67ROUrPgzBqXYQfKO/Ooc12qSrQuNMyfRWiJXKG9C5x0C2ZXd4yAxBRtUTV7uOjlV9KaMVxEUiHK7FtIh5Z922ChT80necW3xKqWcUGgG4grA9lNxcv+5VNKNz6bfB6SEpND+lqPRoExbwW17PnXQ31Q+nl2eDpZbaYe6S9i3dOK4F0qtnz6fooa4R1gk4U8m0LRBqHgRdiczA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b23cce8c-a1be-4c1d-83fb-08dd50357bd0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6886.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 16:01:20.0604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n3P+FCs1FfxDaq0aLr38F/gp6iAMNsnXWyQhxxCFkLTGE+eSxkxdQUYPWLIeOpXeIrykOUxSwq1GtLu/vDavmygcS1NSxR0xBff+cvLfTZvnaPvROLEhW270UMGxjJ6S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6912
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-18_07,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=777
 suspectscore=0 adultscore=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502180116
X-Proofpoint-ORIG-GUID: gCw0zkqQwgj3T_8SHgJeSsvVigdPuxH0
X-Proofpoint-GUID: gCw0zkqQwgj3T_8SHgJeSsvVigdPuxH0

Hi,

On 18/02/25 21:04, Sven Peter wrote:
> Hi,
> 
> 
> On Wed, Feb 12, 2025, at 09:58, Harshit Mogalapalli wrote:
>> This code calls kfree(bfr); and then passes "bfr" to rtk->ops->crashed()
>> which is a use after free.  The ->crashed function pointer is implemented
>> by apple_nvme_rtkit_crashed() and it doesn't use the "bfr" pointer so
>> this doesn't cause a problem.  But it still looks sketchy as can be.
>>
>> Fix this by moving kfree() after the last usage of bfr.
>>
>> Fixes: c559645f343a ("soc: apple: rtkit: Pass the crashlog to the
>> crashed() callback")
> 
> This commit isn't upstream yet afaict, did you mean to post a review comment
> to [1] instead?
> 

I made the patch based on linux-next, linux-next has the patch merged.

Thanks,
Harshit
> 
> [1] https://lore.kernel.org/asahi/20250202-rtkit-crashdump-v1-1-9d38615b4e12@asahilina.net/
> 
> 
> Best,
> 
> 
> Sven


