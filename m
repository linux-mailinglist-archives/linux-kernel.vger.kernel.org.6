Return-Path: <linux-kernel+bounces-546672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C9CA4FD86
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 12:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94673188695E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C920226D05;
	Wed,  5 Mar 2025 11:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XtRCxE1k";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="V+mdldkD"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D1A1EB5D4
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 11:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741173818; cv=fail; b=ZgFG5ogMhD9VeiLR4UtB7HL8M9tkSSLC2qicAOprMOlRuWrWWGpbBY9C9fhOtj+0ni27Mi1la/CUqO6sRPnhIJNQaa+4snreDTrhVPljvZfuwvFBfpC4qBsUBPhJCm5gDDXy+oz63Mt+6AsyJhomEb0yVg8YXeSYNTulr6tv3vA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741173818; c=relaxed/simple;
	bh=mbLNa/H2lBZH5lS8VF7hiDmer/2PB1032tZwOLSIgLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qd5oljCQ8dDwLkaH+bBP5u1ap3ThIh4KZpQU/vgmcInGW/eGPmTSj40N9dnAozghWovlYiVRWk95jCfMxASN2fnEswjFDBEqAwTZ5Ma+3P+ulsKdBt7xm4XXMlW0CWW1dQV9J4nvjnRO0f7nq9zcOItFWFvQisTGkPDtf4g3swc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XtRCxE1k; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=V+mdldkD; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5255N4W5007030;
	Wed, 5 Mar 2025 11:23:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=hzCsEuzKyV7oo8zhpyX4K2rSvf0e7Wp1RDexXBNTlGQ=; b=
	XtRCxE1koLIUYYGeHsva6oAbwpu/ltm+ZfROHSx+QMg1ytVB+JC5Vfrivqq6lyyW
	gIROUxb90KgpTMqt58RO/rnbNdmh1+g8ZjhhZbBLw2KI70Qs/vVjAEFMGLgSsPMA
	t/NGXIs9vL6IobzAzozXApJUUaG76MOJA3YdOW9SweTfuB64msATKiFO7gXyOG1Q
	F2efgfQCK1biDPeq0RqQvE81GVHkui6vfj1Lo7YaUj7EjlNLDa30Ej5Mcs9wgt4F
	GcT0XVBA9+hsp3yTuaBBBY8ZOdFX4R4reSh+elcahjckeqmZYi/RlcBq5WtuP8Lr
	gbg2cloQ3bvz+WJTArI2wA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4541r477gm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Mar 2025 11:23:27 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 525AEvY9001246;
	Wed, 5 Mar 2025 11:23:27 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 453rpayw57-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Mar 2025 11:23:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lMUBp9bSyhx9B1+AERzRIsZSoEb657txr3yMuv2wpkInQOK8vfijhPnmj5BxEkplWUAbi6xtmzkZPZlBMSdRSLviWKfbBsuwA0FV6FtWo+mM72CXJ0kpUP1ku2zIukKt78TM3ITFj43rTSHrYRBw+doDdA0egT6OjEZVMepW7zNwjcAtJ9w0Dc+oMB0g189z16nUzR2SRQRJeQeNCtdjloWIrBYGLLvN3AlD/B/WYYShzx768U1tCIXjQck2AC3hcpQDzzQtWvzFljkKLCR1/oJKKUT50w6DrPuuG3aXnVbQNOln9Kx/a+nVKKr+oCOx3FwcoIZR5KBQNb2W9LePWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hzCsEuzKyV7oo8zhpyX4K2rSvf0e7Wp1RDexXBNTlGQ=;
 b=E+wgaX61TdPblVk9K/kPs7n3okTDSYcDhuBLvTysnpdGRG5rKYPVNyi6u8wb3xhmyzgK6TJpBez0wkxTKl0dFY4DjTmbef/O1npkknptrIbg2qDBydWCQftGbaxroWi4PDbJ5XQXnnx9kgWHiS3i6keRwGZTFzYXkCfaCVYtyxk17vVLheZzRucqbpvcomR89XXmYh8fbbkWQ/6BVDrM3HuAoRSk6zCxPC8Qcc049HcsSt17m8aQTY/frHe6OAso2cqde2+OvuBTzgxEqkrm4cqGvFfpt1525RIcXN/m0gFeUzau80M6sUpO9kfjehulshb2oSyKeeJAA+UWN3zaJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hzCsEuzKyV7oo8zhpyX4K2rSvf0e7Wp1RDexXBNTlGQ=;
 b=V+mdldkDoJ1aqEPjLWeMvZmltp1By0mzA/dKAf1xq59sd2RzG/dMS64T1CIi3LJinyfZNkWotAEnbKzRJVZYkMfJ/w69lm4lc/9DCjaVLrdzWDTaYVnP3o8nfPEXtBsGK+IZW068W2u5LEn/eWmZKGDvSx7gA+pzi5Yoqk4Ene8=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by IA1PR10MB7446.namprd10.prod.outlook.com (2603:10b6:208:447::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 11:23:25 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Wed, 5 Mar 2025
 11:23:25 +0000
Date: Wed, 5 Mar 2025 11:23:22 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] mm/mremap: refactor mremap() system call
 implementation
Message-ID: <914d2224-d659-4ee6-989b-b6917fc97298@lucifer.local>
References: <cover.1740911247.git.lorenzo.stoakes@oracle.com>
 <e6b80d8f58dd2c6a30643d70405dec3e9a385f7f.1740911247.git.lorenzo.stoakes@oracle.com>
 <Z8etTsy49fIjqVe-@harry>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z8etTsy49fIjqVe-@harry>
X-ClientProxiedBy: LO4P265CA0142.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::16) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|IA1PR10MB7446:EE_
X-MS-Office365-Filtering-Correlation-Id: dedf76e4-8795-43e6-fcef-08dd5bd824ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MlM1cTNpbS9pK0Fjd3l5UDRkazFGeVZxRXMzUStzS0ptb21meHZHMGN1R1k2?=
 =?utf-8?B?WEFGYWQwaERYS25lKy9ZdmhGaStTWGJUYml6ajJGMUIxbDErT05LVzR2WkV5?=
 =?utf-8?B?ZzQ3K3hudHczZ2JDTDZGN21TU0Q2c251N2FqaTFXbUZZekpJRmhtNjhSaVU4?=
 =?utf-8?B?SDdaak04UVA0QUZDVDZFMmhtY2UveHh0WGkwMUVidC9nbmEwUTd1eFlzYk80?=
 =?utf-8?B?aHNOMkpOd0tBNXZpQ1dBUWNVc1lmaE9zbjR2WWZVT2pSemdnK0pZc00wZFRB?=
 =?utf-8?B?bW5MN1UzUFdVSnhvWXFtSlJNSWRmVDdoRTlzQ3ZFT29hZHBZcE1PZ0ZIU1F3?=
 =?utf-8?B?V2diNVZsWUNnRTNRd293Unc1WHhYckNsZjJGY0lBV0drN3lIS1FMMVVRcnlI?=
 =?utf-8?B?OEpqMzNScmozdzJIdVF5bEwzU1pFQjduem5USzJ3UTFjTy9zL2pUU1RyTGR0?=
 =?utf-8?B?ZW02SFc0UmExcEwzUzNoMU9EdjRrSVJEWm1RWndGUXMwSmV5S1JDMnNoL2hp?=
 =?utf-8?B?NkV2M0dCZVJEMzJiaTVycUdyekV5L1VyN2hNVHlrZ2UxQlJ0Sm96YURMc3l3?=
 =?utf-8?B?SjgvNUtnQ3dtNU1hY3Z2VlJvb0I0ZHBxYmVKZm9VaW5kZDJuU3VRTkNxR3ZU?=
 =?utf-8?B?bXdNWlF3ajhCN3NsamI3T3I5Zy85ZC9JNDQ2UHpoMVhUcGxrbFgzNGFQczVa?=
 =?utf-8?B?UVpHSWRpdUNsSkxCTkxDNkdyOU9yb2MvZzVoVjRoSDdOYkRHT0FkNDdIR2pq?=
 =?utf-8?B?Nzlyd0I4Qmk0NENBSDRhMlJZaVUyMUwvRDM1VUJDTDFMenhkVEFpRU1JN09V?=
 =?utf-8?B?NUx2QUF1TlB3V0NwK251bjBGMFFxMy95eDlFYWVLbFp3ZFd5Z29xNWRnRjg3?=
 =?utf-8?B?cGdtdzJENGxTRk1ROUt5WEdZaktIb2xNaXFyTnIvUWFXOEhBdjlqV3JzMFJX?=
 =?utf-8?B?dDlZMWxObi9oOUlmZlBNYUZZdHVwS1pyR2lSM0dzUjhtTjh1UEloL0o1aHRs?=
 =?utf-8?B?SEZhSDJFMlVPZVdCVER2U0ViVGlUb2hhZm9hM3lUOEsrbDZtZE85aTJmbkd6?=
 =?utf-8?B?aWZNTVJHTENHd3o2TGdFdlV1Wkg4K0FYOExhYTF3djVwSXExTElLUG5XbURh?=
 =?utf-8?B?OEsyMzRmTzQ4SEROeXpjbloxMXdFbTd5VVh3WkdMa3ZHNkNOWFRkNmZ0b1Az?=
 =?utf-8?B?bzdGNkxLdTRsSXRHSGJvYzhYVUlreHZQS09QbFEwOUZONUxDbFhQayttdHV1?=
 =?utf-8?B?V0Q1bHhQakxDdGNKSlRpU1NvRVp3NXdrWm83dnVtYXhESkEwL0hKR0dqUVh1?=
 =?utf-8?B?dXVmZ053MTF5eGtSM3J1dlFwYWxZTnQ0Y3paR2Vjdkt5S25oVXl2M25SSEdY?=
 =?utf-8?B?ckpDckMvczNGUStIOCtDbytIalpidVQ0allJbC9JZ1daWG9yNmZnb1RpOGox?=
 =?utf-8?B?SFU5UjI1UGI5UkprdlhJbFArVUxNLzlTWjd3OVFHbnBjYnF3RjBVYi83amNn?=
 =?utf-8?B?anJXN3RGd29oRU1mQkZmL08yR1ZKK3BYNWg3VjNqdm9zVS96bGJyWXRzY3lG?=
 =?utf-8?B?TCtNWDlBcXhjMGcwODg1V2hEOEVrcWhrN3dHU0JXaUgzUW8yZjNtYTdESW1F?=
 =?utf-8?B?K3owanVaSHgrZ2tSeGpJOFFjbW5xNWhIWUtQMkllK2toKzBzUDkxdVFEaGMr?=
 =?utf-8?B?a3JtaGg0aUJZbEI2WG5ieDJwMnlHZmhDT0l0WFUzU2ZreWcrRVhyc0Nkbks3?=
 =?utf-8?B?YVVYSG1uZWxTZ282ZGRnTEoybUU0RG1xdkRUV1VqZmdVcmFGQ3YvUDV6Y2Fy?=
 =?utf-8?B?UDJzQVRyTVh4djVydUtwblpWV3crcW5GM0RzVnp3Ukp4YjlzM2tDUUMwQTgw?=
 =?utf-8?Q?OELFhVnbLBaah?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZVZHV0tFUFEyeEZFbnorWS9ya0dCOVpIS1Y1SXhPcTVOUmJobyt2MW9XVHJF?=
 =?utf-8?B?WjNXMlJkUDFxb3hiMmwzd2kxVkR3NDVlMUpyTWhaYTRDZ05EclNRVjRmQ3FD?=
 =?utf-8?B?NEpPUVZzSCsyQnJhWk1sSmVxd0F6YTR4aCtMby9tU05ZTXp3NmdHb1l1cS81?=
 =?utf-8?B?WndUY1l0d3poQ2lUWDFhUlRCSkJQaDh0MkZtZ2llUFJwSldMQ00yeFhrMXhT?=
 =?utf-8?B?ZzduWE5vUk1VRnVsU2Ivaks4NzZmT081QThaZVJLS0UwVE9OWVRjUU8wVTVV?=
 =?utf-8?B?Y0Z1YUtpY2dWbjRrS3U5U1lFWFliVERrQlk1d01Jbm1wYkVlVi9Rd3lndUYv?=
 =?utf-8?B?ckdwN3NEL2hPbVA0Zmh4Vm5leEpURnNTQkY1R0lUUTRxa1lIUit3ODg1ZkIz?=
 =?utf-8?B?TC81bkE0K3c3c0RVYmdtS21FWXRhempTZnAxMkd6SGRhTk9vN0t5dTdPdzhN?=
 =?utf-8?B?Z085Vjd4L2NqTVVDb3UwOExjVk53K3ZWeWFiOGIrN2xtZDdwSFBjVkdYS0RZ?=
 =?utf-8?B?TlUraitsSEF6QWxoRjk4UnRPdFppUlQwR2psSTJLZHBpNUNqK1VsU0luNnpx?=
 =?utf-8?B?VGFmSkYvaFJTc0tRWVpLU09uVGVnVmwxLy9IbTBIc0xPQlNzd0VMWGdzajZo?=
 =?utf-8?B?c1J1aGdBQjlWcTU4VjZKT1oyNlJHaWFYSWhYbG9wNnZzdGNFU1VJRGczOE0y?=
 =?utf-8?B?QVR3a3RJT1lWUktTWDBieHJ3cURpWmxkUzh2TVRlSU4wU2oxZTlCNHQwaGJK?=
 =?utf-8?B?R1Jta1pkREI1L3RqMU02VWN4VXUrVDhnRzI0UkZFbllLQVdNdjJ3SWdvejlw?=
 =?utf-8?B?K1htVmV5TEVJRjNrdHB5Vm5Ka1cyM04wbkQyM2dyNXQ0UUxnK1E4UlhYd1J4?=
 =?utf-8?B?RTJ3WkZRZ0NRVjZBclkxNS9XL2dabC9aV2NtRXE3TGpTeTNlU2lQUExaSHJH?=
 =?utf-8?B?QkxnQUdYQ1VlQSsyd3Rxemtta0RYSjBQSXMvVmxzUGRxQ1dGUXowUGxpa1Ay?=
 =?utf-8?B?anliWGM3V3BQQ2FYUnRNUi9QTm1EcHh5ZC9BL3JKRDVKSHpEUkJHeVJpU3I3?=
 =?utf-8?B?L3NRVFdGSmxXWlc4QnRERFBLeHFmVXh3K3RySGVlR3NZMEdKYWgrYkZtOUpv?=
 =?utf-8?B?TDlGOHJYVjFSQnZGUDl5S3lNZHhlVDUzK1dncURrcE8wc09EN0ZsRUhZQlBN?=
 =?utf-8?B?aSsxVGh1UHJJZUt3NVh4RWpobWU0SkdJZE5sNVFMYVJKOXBpWFRlODJjZkpT?=
 =?utf-8?B?WDlFbjNpalFDUndHTDlxVklJZWtMWVNHM3paaWRvRWhWK0NqT2pacGFFa1ps?=
 =?utf-8?B?RFNaMHdFZXNaQnpXeUFpK3h2U0FYamxuSG1NcWEyUFF0YUM4ZjJoaHBUbk5S?=
 =?utf-8?B?RE9zeThNeWczdzAvZk5CSm9Lc3RXSllzSFlydzhnRHFHMytrSGhtL2RnS3JY?=
 =?utf-8?B?T09yQlNZMDFpdGkwaUJsaXI5OUhyZW5Sb1NrQXN1am9ZZkNxOEdwemZKWVBH?=
 =?utf-8?B?TENHZXlNS2E3czhrVlBkbTNWNHhmZEtJZEpqcTRKNFc3bUNnSnMweVR1allW?=
 =?utf-8?B?SFFYd0JHV2ZzcUI4WHJ3VkZiSE41RzBiTXUrTXNMYWZNR3VIamV0Q0kyQXdx?=
 =?utf-8?B?ZHlIbmR1akRzQ1Z3RUYrNU1pMHBlKzhicjBPcUpBV0ZYcmpWamcyTjVaREFZ?=
 =?utf-8?B?cVZSblNzLy94aWFRb1JmeGFTRXRtWC9hWmQzVGNjdGdSNGttUTNaVjU1YTht?=
 =?utf-8?B?R3NOV0VtcVl5djJKM2VXZEF5YlRvYVJJdlMwR25mTDJabUc0WjVJcFA2YlhK?=
 =?utf-8?B?K05zSjN5dXRxQnhnZnYrWFhhWlorUGRWb3ZaQUoxOGcvcm1ZY0gxTmlpR2tK?=
 =?utf-8?B?eE9xSk82WlBKbWpLMktGaUFiMURGVTViUWg4djRmYTBFU3h1Wm1Yc3Ewbkp3?=
 =?utf-8?B?M1ZScWJGZmlmcjQ2aitkcGhZUU0ydmtObU05SW9CNExIRis2c3hjS21ncC9i?=
 =?utf-8?B?TFIxcjkwN0d6SktHOXBrZGdxYm9GNmJoVWJJc1doNjRRZmpMV0MvRURiQ0g0?=
 =?utf-8?B?dGRIU0ljMThaK2FCczZvSno1eUpYdmMyWjFyeEtndnorOEZnM1E3YUJkb0pI?=
 =?utf-8?B?SmxNMGtSMDFaaDVTQ2dJMG5naHoyZzVTQTR0NXhzUjc0UXNwMnRTRysyS21q?=
 =?utf-8?B?VFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BPMdZXicTwbjfZUKkPQAfWZzT7fVD+pe+svNlgBLk0c2LsdL/Hzib6aMnPtmLaQIo+ZGcBRCDG7nr7bOfRK+Nvvwx7nwwJjt0ulEaun3eDwm2go21R/tpowLo2IJl215fiTKb7ubLpcUnpv21/jEtkWduQgVh5GzCAFE86OvzGd9G8xmLMNml8KHVFu4jPpbLZYeIUN3WwDsw1IDp42pdz9LQ0ZZKE+eDCODP6GfipGzsJnq2pbCgR6WnqEwmhm2K35jC0YWG1wHXBUmHIjJ8gT2VKY14+6NIlXssNcZXqa8ZpZlhP9dGpuXW0KkAph/YALrx3HpkTfR1SEDoRqDFbo08m0PfdpjGdpoDoILqyBOOJymGm3Rr01krN5GN2P/MJ8fwOmwqNMK8lEBl+d+XpUqVU0W63F1PC48e3c7Wbq6aaSNEujT3O/uUf5mEg1tw9PbNp7lqZ47X2ett4CaKM0YpVljyMt+DYc3dCA623kph5WwtF9hxsxuJwMXnIKGS33Cq4ZgKxrGM82lQOaO3rp9kea/lcR9+qMVkgAjLOTL19a06fHz+v5xqHhx5wfqtHhnKOFlBRk5OHta0wB0e+rS7bBG/x5ppT5mXtRG4NY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dedf76e4-8795-43e6-fcef-08dd5bd824ef
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 11:23:24.8880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qTMv+E37VRdFo/RzpNokwcmE7sCYEZ0rEcuPcpdWdnTZu5EJOjYk0y0RCxJ92TjZOaAXN1Oz0hLJYV1SaPyD1rvmVH3tbDDHR+IFrxpMH+M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7446
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_04,2025-03-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503050092
X-Proofpoint-ORIG-GUID: -M2kMIxKScDardj9HZsR14c__7Ekrn6t
X-Proofpoint-GUID: -M2kMIxKScDardj9HZsR14c__7Ekrn6t

On Wed, Mar 05, 2025 at 10:47:58AM +0900, Harry Yoo wrote:
> On Mon, Mar 03, 2025 at 11:08:32AM +0000, Lorenzo Stoakes wrote:
> > Place checks into a separate function so the mremap() system call is less
> > egregiously long, remove unnecessary mremap_to() offset_in_page() check and
> > just check that earlier so we keep all such basic checks together.
> >
> > Separate out the VMA in-place expansion, hugetlb and expand/move logic into
> > separate, readable functions.
> >
> > De-duplicate code where possible, add comments and ensure that all error
> > handling explicitly specifies the error at the point of it occurring rather
> > than setting a prefixed error value and implicitly setting (which is bug
> > prone).
> >
> > This lays the groundwork for subsequent patches further simplifying and
> > extending the mremap() implementation.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
>
> Nice refactoring—reviewing it was a nice learning experience.
>
> Looks good to me,
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

Thanks!

>
> --
> Cheers,
> Harry
>
> >  mm/mremap.c | 405 ++++++++++++++++++++++++++++++++--------------------
> >  1 file changed, 251 insertions(+), 154 deletions(-)

