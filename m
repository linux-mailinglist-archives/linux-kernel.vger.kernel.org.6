Return-Path: <linux-kernel+bounces-194564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 762A68D3E42
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 20:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9909A1C22203
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 18:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546B715CD61;
	Wed, 29 May 2024 18:21:40 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F113DDA1
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 18:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717006899; cv=fail; b=Rbamh7JZgAfvCXr0ZFSN80kKR3UoDrfEbralFWojeHWDr/wWwQn1nYZOMsQaXog/hrvViQ0KGDzKDiiAYqlqexHgTgQuy9ZCDA4/0NqR15h0pQO5dK1RPN9H+Wy2YrL/AN9I6SS67f+w9IuajDChwzF4xDX9aXYeU/gaap/LZw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717006899; c=relaxed/simple;
	bh=ShD43NCHIO8g5sXcGOGWRS+XmjRFZlnB+GDBAF43mps=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PNtq3Kd+4IOY3TGTEwzrRFh8imUUOLDcYMDxtmPKdkIHZhlxphles5Z6pPngJVVWz9IDGAJM/c8/GO67L+ociq3xkSmla+9dpeDuHxg4rtSbcyJq54HGn8lLPqhxc63ABO827Q6d2jVU52u8ovxnWGM72MONCFAxeuseTZnxy9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44TGYBRB026368;
	Wed, 29 May 2024 18:21:18 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3Di9SgFiuQQgPvVIZ7bkP3Smj0vD5dkxbK45TmjC1zlkY=3D;_b?=
 =?UTF-8?Q?=3DCtA8EIDD2yNJ4lC/BhpLwtK+VSEjhnYdLOQA0MowlRVs06hlQdtJMunJhIO1?=
 =?UTF-8?Q?Xe4blujB_b059Qb1h/Zt2QHJH/1gTKuGi3pYvaer9LSFU0bq93K32s+FHkBm+Eq?=
 =?UTF-8?Q?WHR/PTbf81Mp9K_za8JiyJqXPjja8TfpidYvgizQCINpP/rGNaWdm1zmBPE6LMM?=
 =?UTF-8?Q?+uDoN7Vo0/iNIKII3b0q_CBJuq4+bmJtAzYFi1br7vlWg4ypMpVNSIFFMrjQm8r?=
 =?UTF-8?Q?OYPmC4hoFhD6dVk+I5U80Nsrnh_s75ecTtED1CT/BfdgOCIV/1UMj+VsQGQnhOe?=
 =?UTF-8?Q?z9Eijei6EUzF5r0mp2a9ZXJorRDH0RLd_ZQ=3D=3D_?=
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8p7q8tq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 May 2024 18:21:17 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44TH0dpU026818;
	Wed, 29 May 2024 18:21:17 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yc507jswt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 May 2024 18:21:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=meVAGRdntLWCoo+YF9P50IRaNb0OHqteOgJ+T0QbFVRZ3P2qM1dIqnMxqMpzZesqjGCcUEF0QzKwNtCPvDmg+7Ve3I+MnFNqVKW6KYsWGNnvM2qsQ9LMV5E2LpQvi3up8Yy690Ih6Nx3dRj6LwAQwxVbUbapdUpwrhMxMhJaOZJeERn+3fnpJOdL5s9k3aas9s6B+ZyapIiRDIIAKBYVFyOlpAzXAckbbdsbD1EL7ErfoMtfX9DMFuLq3JUHB7nicLonGA+m3qT6WHNfoPocrSd5NCD2B0EdY4mSkh4TEtLWt3sH/daL4Eq4LMsr8D13ZcFpxVzAklrKktNSYarJuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i9SgFiuQQgPvVIZ7bkP3Smj0vD5dkxbK45TmjC1zlkY=;
 b=CfLDrV5qRxG8z8R5KycHRF7TIWrh08JbNWQBgCWLH3KdWAnmhTRZIVa9d0oPPDYxgHZzU6N5NjWtEwd1vx6Z+aZ8C5XPZQColc8h4Ay7uOIAcp9TYOr6XRJ3m+1RnUN/2Scej6wfDlIKPWA86Xvaq4KQSNwb5F6oY/9Q6v7v0bBZ/jj/qaajmuTSfmbjoYPTlWQDKvcKZPAfi/t+tlCnxyHlswForj2l+HuiXSiqPTC8auyoJYQPCmijaJ3ACVWAYGNIhEMfkBh6+cTMPHuM0AxX612SeRfOdB2MfvfHl2YAjxKCZgcAknM2CmAuaiY2kn888J+pJH59bYHWpxO/aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i9SgFiuQQgPvVIZ7bkP3Smj0vD5dkxbK45TmjC1zlkY=;
 b=khX4tzH13MeRlDOMPWVHIiacN1w9SajpNbZGwesNzRIV3MOOtcWssPKN0VgPshepfN5TlGWrCKdx4Nw5qKaurs7jinb5zBOtLVVATSMvKoWm54fC6lfqhQ1JrHJ+tCNw5HgU1nzPrdHaG1C6KAoAk9WKuTJkkG1Q4ARVLK/9ZqU=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by DS7PR10MB7155.namprd10.prod.outlook.com (2603:10b6:8:e0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Wed, 29 May
 2024 18:21:14 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%7]) with mapi id 15.20.7633.018; Wed, 29 May 2024
 18:21:14 +0000
Message-ID: <328386e6-7cb5-4571-97ae-23a6d266c1e5@oracle.com>
Date: Wed, 29 May 2024 11:21:12 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/hugetlb: mm/memory_hotplug: use a folio in
 scan_movable_pages()
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, vishal.moola@oracle.com,
        muchun.song@linux.dev, david@redhat.com, osalvador@suse.de
References: <20240528220321.144535-1-sidhartha.kumar@oracle.com>
 <ZlZfHNkWHxtpcXhO@casper.infradead.org>
Content-Language: en-US
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <ZlZfHNkWHxtpcXhO@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0071.namprd07.prod.outlook.com
 (2603:10b6:a03:60::48) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|DS7PR10MB7155:EE_
X-MS-Office365-Filtering-Correlation-Id: 9422293f-4b0e-4817-3a6c-08dc800c1fee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?bUp5RnBHNmoxdE5wN3lmYnJZYUV0Z0xQQVNiMWpRWWxwaXJQcXZXTXZEcXBp?=
 =?utf-8?B?NEJjZ1c0RmJXRlNFK3A3aU00bVNRUmRWT2kvQTZtNDJGUm50MG5sanFyVElk?=
 =?utf-8?B?OGkwVG9zaVNnb0N6VU5CM3R0RGJKMStFa2ZjRXN5Qm1jcXlQdWV5VjZBWHFy?=
 =?utf-8?B?ajRsUU94WnMxRmpRRFUvWW1IR3A4TGkvRXdEVXVYT0hEV25MY3RuK0FOOWdL?=
 =?utf-8?B?ekZsZ1RXRjhMaTQ3SEpYSGhuV0hjN0p3OGpuS0M4YzJBZzRlbWRUbjRvQ1lh?=
 =?utf-8?B?a0kybWQyMGtlWURkcnlHbTRqRmZvUFJYdndzYUxWTkFneFdVcHVYUy9PMTY1?=
 =?utf-8?B?ZDZ6ZkRPY3BiMTY5ZHRoZlllWTR2aGVHODdyVllTcTJIMFdEUkZnUEFQb1I4?=
 =?utf-8?B?RHh5Tmh5VWRqZ292VG8wMnkzQW15MkFNSXpwQlhyL1F4VURIck1OUU0vRzJu?=
 =?utf-8?B?MjgrTmVBb0NHVEg2dUZpZFg1YXE0ZSs4c2lwSGxrNjh6OGM4c1c1RlRyRURY?=
 =?utf-8?B?b24vejZYYi9zR3c5NkNwNE9hK0x4RjN0b3hHV0ZNTXBCaDRuOENyRnEycDBV?=
 =?utf-8?B?ZWpkL3N5TXgvRDFFWklpbnFIbkhXakRYV0NTRUJKUGNRd211U2VSTG1xaXBB?=
 =?utf-8?B?TjlSSWdFS1F0YllYa1ZPQnB3MmcwQkFqY1IwdG80KzI1RGVmUDFzMTZmSHdl?=
 =?utf-8?B?Rk1DL2VtNXJVMWsrRElFc1IyUWp2VTZTMmRsQnhNTmh4SktaNUZaRTkrWE5R?=
 =?utf-8?B?TmlnYzNDV2dRNW50SUEvN0NVbGhQd3Z2U1pLblBreXoySTZTSE5mOUZZbFRi?=
 =?utf-8?B?bUhyalZxNWhMcTRNWXVjaGZCd096U3huSlBadXlzeFY4SytEbjFNZnZTRTRN?=
 =?utf-8?B?cURzVXZKd3dWV1RzOEh5ZWphZXNRS0NQT2JvRGs2NjE2ZjV1VjNLRi9MbzU0?=
 =?utf-8?B?VHg1Zzl4c2djT3lBR0RGV0pjMktKOHBLSzZlV1o3RXRzbWFrWXE4c1JhSUx1?=
 =?utf-8?B?MElvbXY4WkRlbkI5WFFCbmk2Rkl1YU40dStaTWdWUGZHb1QvbC8wTkdjdnFG?=
 =?utf-8?B?OXc4U3I2US91Y1lhWERDczNpbmpHZjNjRkN6N2ZQUjQ2MGR5Z05BSmlYdkp5?=
 =?utf-8?B?TGtrUHBVY1lMZHZRZGxBa2Y0anAvTlpuQXZjRzZRK0hvN3lKRGdnOUYrM21X?=
 =?utf-8?B?YS9wRDV1ZHNmblFqL3ZiWVNrTEJ0VGtWajErZWQwT1V5Z09LRUtoR2J2K29T?=
 =?utf-8?B?NHFvaENFNjl1K1ZqRDBzYmYvMTBIb1FnNjE5L3pWZmxnTE1NT1NqSEJCSWtZ?=
 =?utf-8?B?bzN2ZkJjcmZvMkh0QVNnWUJPWXVMYm0xMnZMZVBnRmlBNVgrNG00enA5NkZR?=
 =?utf-8?B?b3FMeXpXTHJab0VQakt5RmdZZnl3TC9acmJkbVU3dVlKZGp5bisyVDhNQ09a?=
 =?utf-8?B?Z2lidjlaMktOK1ZMNjIySjEvdUdNNU5Yam96YTd0TnRGQm55RVEwRHJCeGo2?=
 =?utf-8?B?eTBRZEVGQkJxYTVLRnFTQXdzTEtDMXBXWEpDbnkya2NnbXlRREJCU1lvc2E3?=
 =?utf-8?B?RU9LU2RnTDFCUDcyT0lFdU80LzJzc1hUcWhwcGhKSU8zdThLQWo3UmpOcVlS?=
 =?utf-8?B?R1VObHNxV3RlYmRraUxVcHI2OWtqckZmSlBBZXhOZVZSUUpwbkYxajZIb2Zk?=
 =?utf-8?B?TlZBZ3UxdHpERDE3dVBVNzYyc3J1RVU0dmNhMjdmTklvSFpJOEZJekh3PT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eGJaQ0orZ0ZiVTBCYmNYckZINGhVci9YZ0NGVGpvRDVXTVkxTXZCNWZLWTdr?=
 =?utf-8?B?R0g2UkRvV3pMdWxSWmdNcm0xZ0MxaDdsNG9wSFFESXM0d2VWVTA5ZENqS2pY?=
 =?utf-8?B?K1o3RTVUREowbHRKMHZ6Z1p1NFNPcnhOK05LNDJpbGpyRG1NY3JzTytqQm9C?=
 =?utf-8?B?Qlh1N21yVCs0MDFkSHoyR25KeVcvcUkyY0Qwa1drS3NEWkhQWGgvM0NKYXhS?=
 =?utf-8?B?Q09xcFIwazZXbWYzWUdWbWQwR3l4ZWJvZk50bUdXL1pXSXgwZWQ0SkxZRjFT?=
 =?utf-8?B?OFVsTWJod3UweERxS2RxSnBvM21ITHZSejJvRnI4c3YyTm90UWwycnN1S0Nh?=
 =?utf-8?B?dUFxUEUwZHJwazR0dW5KT3lld1ZndjR2STVuS0RmSnBtb3p4YUVJTnVxWjJW?=
 =?utf-8?B?cXp1ZXh5RmkwRkpOcFN4bER4R21ocHlCVlhaNEpRckx2U3hSUWVuOURoaHQ5?=
 =?utf-8?B?eW5DWEF0ZGduRXZkditpRWtXRGwyUitOVkg3aW5SNHhPc2RsVTNjdDlma29w?=
 =?utf-8?B?OGNoSUNRanNERFFPZG5SOTZiU2VtUFBkUkJIMVFEc3BMOVN2VmZ6bzMveHVN?=
 =?utf-8?B?VVJIRC8yTEJQZHQzOCtkS0dObE13ZjRtQ3VjSjRFT0p0bkh3WGlyVzBMcjc4?=
 =?utf-8?B?Mis0aHdzLzRLMVEvTWdjamY3Q1FNOWpKTGxuZUNqMDB2ckk4aTBBMlloWktN?=
 =?utf-8?B?Z2FweW5TT2RQMURmenhKMG9WNGxzMVVtV0lOc0FnOEY3cmJWY0xRdFh3OEd4?=
 =?utf-8?B?WXgrRVNFTDBSZm1ZY29OaFZJTmp3SHpRUlhYSTRzTDUySzBsVjVpS2lMR09q?=
 =?utf-8?B?a0JIN0M1M2ltbHp6YUlhcW15R0tXYlM2Q3FycUNLZXpUMWdhM2VPc3lCSHAx?=
 =?utf-8?B?MFF6MXRGWlR1UzlJOTgyeFkrM29vRVlLeHlKYy9kbG9RTjFvNE1wakhwN3Iw?=
 =?utf-8?B?ZGdHV2Q1OGJIemxXQ3Fac2t5TkxmdTJ3RWFVMG9sVzhFSDBoVXRGVktwQ2V3?=
 =?utf-8?B?bGtJd2JaWEo2SlJOeEUwSUtoNm41dnFKdDRsVWNZYTFYdG8xT0FrU1VoTE1J?=
 =?utf-8?B?SUhEQzlpLzAwQmFWN2VwdkNmRndGM1EzbEkrbDBFaVF3c2FQQkRTSWR4cU16?=
 =?utf-8?B?QTh0Y2VtcmVLazlKaklVdEM5RE4vYmllUHlDS29ib3BJSXRud1pPS0VxdUcy?=
 =?utf-8?B?anBFM0I2cnYyeUZXY0toMzJIMkV2R2JKUStsc21kQ0lVVlJYQ0NicWNzNXpJ?=
 =?utf-8?B?L0FveitJNFU0VmdYUDRFWGlWRGhpNTBRdEpCczdPRlpEQ0JlbHhLUXVnNWd2?=
 =?utf-8?B?T0QvaEVDQ2JhMkoxSG93V1EvZytJWndDeUVxTWxDNHlzWG96UmdIV2QrOTdW?=
 =?utf-8?B?eVRuV1lhMVdnL29Bb0VsLzRQT2doKy9QVEtITkxBSnNTUlJJOXJTdWF4azh6?=
 =?utf-8?B?c2Z3Q1RseUFFZmFpS0JSUEFXelFBeEpsRFVwNlU0NGxvV2pwT3B0WEw2S0E0?=
 =?utf-8?B?cHk2VGhQRWxSemwvM3hvQnBod3Q5a1QrU0xQWUtWL0RBVTQ2cVRHeGlmL2J2?=
 =?utf-8?B?TC9TUVZoMUZZL2NZbTJTb05KN0FHa1ZxTnd5NE1FSHVBcFBJOWdXbUxsZjhC?=
 =?utf-8?B?R05ObVNvQy9nZFY0YVpISEVKU2tQRlNFZ21Od0xqMGE0VkI5ZU5GdEdveTRR?=
 =?utf-8?B?aU5GWDJWbjhWdHdoN2RwUXdPNUhSUFE0blYrUC9CdnRKWFEvcVBtN1k5OENQ?=
 =?utf-8?B?RnhZYnBYN2FCbVJCc1FzT0FMOW9UN2lQQ0dUVXg5NkFEd2ZHbUFCVU16T2NQ?=
 =?utf-8?B?SGdXZjhjS2tUZ0MyL3k5ZGdHZlBodGFxK2dyTVhDdVBJcngyRUxXTENqQlpX?=
 =?utf-8?B?aEppdDZMaTArek9XVC9kU00va3dGSms3SW41VXVlV2ZnZG04WW5Xc3lTVVd6?=
 =?utf-8?B?MWdEc09kTVhiV1R6WXIwMXBjM2EybGFxOStTTUtyQ1BrQS9aVGE5TmxNMXRF?=
 =?utf-8?B?R3hQWDNPQTVpenBjSnhFakpHRXNqckxkOHk5ZStFa3krNm9LcWRTOXgzRGZR?=
 =?utf-8?B?ZG9VMFZCRkdXelN5b3BFc1Y0VCtST0l4Slh3aGlRMzNzNU85b0NOL1JxcVZT?=
 =?utf-8?B?QkRDeFFCeDhSM2VRUU9FeEplcUQ5VGtubXBRdERLQk1xZ1BNRHNXMTMyWG1t?=
 =?utf-8?Q?EKRz3Mq+prteO3s0PirQ1oU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	AYZmrdOTZSFYrZ/wxBpdWOBr375cetUpWkmFJLqZBfzMUgcDgstEs+n59rpnqT+2aS8JsSUk/KT1B8AKLRaukwNu8005gy1otmOsmbUKq65xcpcaUcseoVsDdm5bUkKGms2zmMIEDM1w/fyA/tRZuDAXo6TtlxJEFmNh9eRBhKtYA6lWX8OO0QIFzF8fEYn6bs3t67qnWHTgmoCpJ0kk1lBgZRi0ZAbPik3YyZouvEg7nQAR2OujAT3rByb7FSYk0ESbVZNoUkR316IK4xC0Zbo/4tVlXGojX5OAlsLBRO1DWjC0YBJ+Hh6jh3ApWrZdnuwSWYL8ksLjyBhzpoK/vZGW+tpPuqMkIf5r4UgiISJ83HjprSvONb1r5pfAictDYySiiFAv2K0CbZRhxl7IMOBSkP+z9sP2X8NF558qG4pwuBHfhCHhF13LnduF4zRwxA4HnMwVr/syh84aKLUYHTI7t0K7DCKRZ6DXVS0rUA3kvrX+gMUhtQXJbPgLTw/dDlQ4eZ05YhoSjdBH7WSoM8y3/LT8ep7huiragn7hqVy7dXDvbpGafQuBIuSQ3Ng7PtdcZBdnDnzzOg5Xmsm07wdzNrKE+tJ0w3Icvk5v6tE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9422293f-4b0e-4817-3a6c-08dc800c1fee
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 18:21:14.5803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GaNrMX3AzBRM5FbFpqqYoXKxoMA+veerN4atNqH9lUdaOeZQrZv8Dh9YE/Vbtm85uU7k/aCfwqdZKvqm9RV3u6twxPwu1pcLRZI3oTYzk04=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7155
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-29_14,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405290128
X-Proofpoint-ORIG-GUID: EKVYs4TeD3vSQtan6OwNDxkIA-QsO2w_
X-Proofpoint-GUID: EKVYs4TeD3vSQtan6OwNDxkIA-QsO2w_

On 5/28/24 3:47 PM, Matthew Wilcox wrote:
> On Tue, May 28, 2024 at 03:03:21PM -0700, Sidhartha Kumar wrote:
>> @@ -1761,9 +1762,9 @@ static int scan_movable_pages(unsigned long start, unsigned long end,
>>   		 * cases false positives and negatives are possible.  Calling
>>   		 * code must deal with these scenarios.
>>   		 */
>> -		if (HPageMigratable(head))
>> +		if (folio_test_hugetlb_migratable(folio))
>>   			goto found;
>> -		skip = compound_nr(head) - (pfn - page_to_pfn(head));
>> +		skip = folio_nr_pages(folio) - folio_page_idx(folio, page);
>>   		pfn += skip - 1;
> 
> Isn't this an unnecessarily complicated way of writing:
> 
> 		pfn |= folio_nr_pages(folio) - 1;
> ?

Because folio_nr_pages() is a power of 2, I agree this is simpler. I'll make 
this change in a v2.

Thanks,
Sid

