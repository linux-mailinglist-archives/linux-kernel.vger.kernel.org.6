Return-Path: <linux-kernel+bounces-249302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C644892E9AE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 15:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45AD01F210B5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 13:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E4C15F3E2;
	Thu, 11 Jul 2024 13:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BuPr3TE+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Y8VCYd2E"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568C414C5A4;
	Thu, 11 Jul 2024 13:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720704983; cv=fail; b=FZMXl0XXLub+oCizS+XgYZf5n0+e86xufxA8D/R0VvH7+piusg9wS6+tcKlw8f5L+clTA5EaRvUOcJ0lBpRvZd6PBRRXOp56Ru0yDrGpvNTdO9deH2Tp6zbjduwpZbA1rYBgb0n/RfOYqbU4pra5i81iecF+BNnA8FQ6LMsPhLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720704983; c=relaxed/simple;
	bh=hcWSHkx3NWWXmLC7TlGYIC6r0eCDUPJ7GEU3BUAVS4k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AVvkmDeFIn1wH4CtBFtbXLa2KEfBzzfGpsUCYP8gFJTs2BGRYnL/6zJO5iQGrTo4ArJJa1p0NUWlSRJAjM7A5CpNp6aWu/8ulyPVE/vMnH6i+Yf0ilqnZrC6/+VvsVo6GFdvCKAtcZ7hr5ao8qp1fRBVikKVTE9glHwv341hoYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BuPr3TE+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Y8VCYd2E; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46B7tSuP026752;
	Thu, 11 Jul 2024 13:35:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=hcWSHkx3NWWXmLC7TlGYIC6r0eCDUPJ7GEU3BUAVS4k=; b=
	BuPr3TE+plpnBJz/tGA/0APXaTzl8cXv5/8ZCKoRtTJe6KFcfrWF3NmaARskVmN2
	fxps3UnU2AULaWaVsQBy9qt6/Qe2hBdg/7zhFck2PRGu4gatlapP3a0l0KdWawGi
	uG7i2t5aAJEA8BiMGSdIjT9Bt/mxUL14CDsXiVYYuryrLdJYE/olAWsx1JSxdDkf
	IM9xB6NY5iTzoEyKY/Dhc660qjsVgRRA/M0oGFQhzSO1Obu0fvzWia0GNhrpEmd0
	xQeg2Xtjv912uQofu+kNEQPEYtWTIyMLkW1pjz/MQAmHr9uBlcl0OG5G8IWj9xU6
	cNuPrp4eKZRmgQrjukeUVg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wknsmea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 13:35:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46BD8P2B011075;
	Thu, 11 Jul 2024 13:35:54 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2043.outbound.protection.outlook.com [104.47.55.43])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 409vv5rkb4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 13:35:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y1550WzKrxlxS0ul2HCiP7nbfX0EW3Y+7hCgIa65e+qGGE3mqGnQgAyGRpVIE8k7LyGQG5MNIME56QVBH8oHQ8IdlXijUF6vIOWH2BxuAT1tl7bK8eXobzynQDkv0KS4yIGQoxGf+UuNW4xA67rWkD1livxB3Rn6nTq3YMgE0CpmgwlEJeMNF0XY1movN90e8MMusdi8qA23uF3x0LfXsMkXPxeENiYSa2EEuKtRhJDSlM4p9+EDoPxuuNX6eTh+K2rEfjKq9vsrovlNzzGrZngDVBV4hx5nsR+Zn0/XhXIZjdep8HeIJ18IgWC4B7f73/SusxSD2n0mbqjDHTATeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hcWSHkx3NWWXmLC7TlGYIC6r0eCDUPJ7GEU3BUAVS4k=;
 b=pG33y/1I04BBH9bEiGLUtuo34tgUECFr8RT1xgs0BhAZ8V0gQFt6LgZrtAM0RDI/OrrF9BuoL11UVoYBOiOs97QhJT6/UgSGv978NnAPSQuUg5DLeujkiSROKVyTF7KLKDa2BS5EcJusuHa8CHjaqj6gBNcYs+apAIbs8AzgWV35qg36BCP9sgEz8M3xK03GLZ31PTsPt3sNKKnPRa8VtAxITYq/dEJyyvOd2tebxO8bREZAkSWw6vxbwAf8Z/638jBjAlqOadjdJBLaMJ9VrkdueRuyk6Dte1J7EU1cjCr7Zrosyl3WF+6rZLiAn/lQWfShyX5Y4d1uQDpbUeo+tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hcWSHkx3NWWXmLC7TlGYIC6r0eCDUPJ7GEU3BUAVS4k=;
 b=Y8VCYd2EMBCQVMzIHLoeelx95RYgoNM75JieeZUELBt1QosUl/Ov5V6f+ZoSqEfuCRUAHBLkq6BHcu/KSXZJoQZCWFibNteA5fIh+qYn6Pj0m5WSbBT/3hGUuqtqgv8eBeBdBW/KEBB+8ZoxjR37JgNcPDXocAJAu3q2yTGAtSM=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by PH0PR10MB4407.namprd10.prod.outlook.com (2603:10b6:510:31::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.34; Thu, 11 Jul
 2024 13:35:44 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::a088:b5e0:2c1:78a0]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::a088:b5e0:2c1:78a0%3]) with mapi id 15.20.7762.020; Thu, 11 Jul 2024
 13:35:44 +0000
Message-ID: <cffb2a74-6f1d-4178-9f3d-e5e92442b03b@oracle.com>
Date: Thu, 11 Jul 2024 09:35:39 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/xen: remove deprecated xen_nopvspin boot parameter
To: Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-doc@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
        xen-devel@lists.xenproject.org
References: <20240710110139.22300-1-jgross@suse.com>
Content-Language: en-US
From: boris.ostrovsky@oracle.com
In-Reply-To: <20240710110139.22300-1-jgross@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::23) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5009:EE_|PH0PR10MB4407:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ade48a3-a0a4-453d-8c35-08dca1ae5d89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?T1lQWkJISXkyWCthemhFUFlTQVBUeExmYk9MSlpPNERJbklpZXRIQXhscVl5?=
 =?utf-8?B?WWxsOUhYS1lvTC9zYW9hdk5IbkhOMFBMRUl1U2R5RU1RN1F5T0NNanY1eWda?=
 =?utf-8?B?YXkrd0gyelhqSkV6Q1pkeHlkZkFsYWRwalBiMWN3TXlJY3BBenpRRWMrbWk1?=
 =?utf-8?B?cGcyQTRNUzN2UkxYUnh2bG1mSytnTGFXcjFpUVM5eFgxQUh6blRjRDltcHlQ?=
 =?utf-8?B?UDhRZ0NCd1liT2dUaFd0cE91Z2w1cEVsaDFNTnBWay9pYUFOd3BEcFhoNGJh?=
 =?utf-8?B?Y1BkK05GMUxJbmlzcWJzQVB2cGp4TU9DZDYrWGM4VHVSbng3cnVnWnp5QjJK?=
 =?utf-8?B?TXlKTVF1eElUR0R4WGcrYUxaVXFsYzA4MitZcVUwdWtyRGMrNDJIbW1WL3F2?=
 =?utf-8?B?VlZRa0RmYjFqNHlsVFZicFpiR2ZtQm1hdkxGSjczaENvMmc2UE9jVnF1OU9Z?=
 =?utf-8?B?TEQzLzVJaHN2TUhqV3F0WXIvQ0kzMXZwYnJMTndVbHJuKzdudFJCL2F6VWFo?=
 =?utf-8?B?UDU4Zm8yV2RPMkNRS0VoOERqbzRGc0ZiVm1hSUl3YjBVNXNqMlFjNXl1djVj?=
 =?utf-8?B?Y1Q0OGlJUEpHd21pK1VmMmZ5MXdpYkVDWDlibm5Jbm5xS2d1ZWF3dURWTHgr?=
 =?utf-8?B?ankwRnFKYWh3dmNFZUhIRTZYT2tuWjVzUDgrUE5adldnWkFnTzdOMlV2eWtN?=
 =?utf-8?B?dGlXYzdqZlpWUFFSemg3Nmo2NFlLanNjUGdIVk9IY01nRmFXeW91SGhoa1ZF?=
 =?utf-8?B?S216cWlSS0tYR0s3WlFQZnRqdFhWTlVBNS9nQzBoZjhsTWNZZzhSUXlFWHAr?=
 =?utf-8?B?TVQzcHdzRXFwdXRZbmNDdGF1c1lWZDk0Q0dBQmYwNVV1QUZCWHNndTFSdnhP?=
 =?utf-8?B?SmQ4dGxMM2Y1UkZ3bGRienRBaHpwNEE5OFg4RVpyNVozY0gvY3BPcThITTRT?=
 =?utf-8?B?TkQ5MjRraHlVWFBjZmVFZ01YNXpPZ1pDVnMydUFvRVBTUG9qK2lqTWZVaGZn?=
 =?utf-8?B?WUNuSGFRLzAzOFFQejcwRzd4Mjlqa2V1WERqcEUrbFZUbnBaYWlHNThGQmJa?=
 =?utf-8?B?aGRoYUp6NzFJUjhzQkhISVJ3T01oMW1lNzdHdVZpaXNYVGZjUDIvWVNUSFR3?=
 =?utf-8?B?T3lsZTFwc2UraUFVSzhSRWR6T3ltMVEvTTdldGpvWUJ2MEU3UXZMVmFVVnhF?=
 =?utf-8?B?L2Z4NFpSRWFaUHcwMlVWZktZVjBUbzlENndIYVdpYkJPSGdXaUNxa2RXQkZE?=
 =?utf-8?B?amZFaS9uOWJ4QkRWdzJrUlA4QUF1MWNEbWdKNy9yQ0t3d0pid2ZoU0pjNWJt?=
 =?utf-8?B?c2VZR1l4OVZYMlpZbzJaR2ZSbmtPbmp6K0dVSDBrSHFKMnVWOXNJSEQyaHFD?=
 =?utf-8?B?TWFxV2x1cWxvdW5abnpLVERON0FMd0JteDRmKzRKTGxVNWFaZGZraUVzdmlj?=
 =?utf-8?B?TkxoZkxtN0JrOFNkaXAvWTJkWWdXZm5GbjFmSGtveGdpVThEa1RRNXdqb21J?=
 =?utf-8?B?Ynk5K09TZlZzOFRsNjBFRXo4NHNWdjRvNmFFTXZOMXMwWnRDeldVNGRPSVBh?=
 =?utf-8?B?MEMwb2VnWEp2RjV4UldMNEJwVjRPTjJKNmI2dmtxUm5xRHRsMnp2NU5QUVFo?=
 =?utf-8?B?R1R5R2FNTkY3NGFnTEl1MHJzMUpJZDBJdVpZUi8rOGEwcWFLZUJyZVJsMEZ0?=
 =?utf-8?B?cGp6QkRDWk12L2xBdS9CSU01aDBYZUxNNXBPL21ieVB1dU9YdHJtMyt6UFhh?=
 =?utf-8?B?RFRYS0ZGRzJqMFVaQjdmTDRxTVh0clQrNjAyQ25EWmRCZGlCVW9yaWlPZ2FQ?=
 =?utf-8?B?NW54SVFzQjR4M01Sb0Irdz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bTZ2anBLQm05empNd1BtbGI3U2JwTmYwRUJ3citjSGFNVHlzOGVscXRRa2dT?=
 =?utf-8?B?N0FhZ3kzV056YTNqbXNiZmQ2Nmc1TStlNzUremovSzRYcHlTbXVCdjQ3djlZ?=
 =?utf-8?B?RmtER0lpQkt0M1B0VEFEanJTUSt4b3l2dEJ6TWJ0NXkwYjNIVER5QW9WR2Q1?=
 =?utf-8?B?bEVnNTJiYVFNWUtSeC9PVWFkMGV4KzE0Y2UrVkFhRzAxWm94ZzdlNVpCTUhv?=
 =?utf-8?B?bXZtTGkydGFsVTJFOXl0TGl3Z0tqcWRsTnpBNVJNalByblRidG1kdXNjWGtn?=
 =?utf-8?B?SWtVQUlIdTJYWXFJeU40Z2R6MkhTRENTYjlIWkhHTkU1RW5Bdy9JbStNTGJL?=
 =?utf-8?B?Yzh2TlV1YU45Y3RUSWxNS01SSVBGdmVsN2c2MzhzZHhWYVkxSVFJZEJEMk5B?=
 =?utf-8?B?UVdKdk94K0tFZis0aEN6aDlCWXN2cE96dnZPOVVENTlVUGFBbUlIYVN3VFp5?=
 =?utf-8?B?WnVwOEx4aUN1Q0ZJMnR4YitSUUljZzltYmhwczhpOXM1cnZIT1lXOU9KY0Yr?=
 =?utf-8?B?aDVpaGNwaVh3THkzd2xsVzdCSStaaFBoMWdWVkMzWjRSUXpRTmswclRFZTZU?=
 =?utf-8?B?V0prN3hiVGVOYTA4bnVVTFlId3NQemluSjFlSHg3VXJYbFl5VVhxTEQ2bEpv?=
 =?utf-8?B?bnJtc2NzbEpBUTdrbnR6eCszaUZVUmozVjJLNlhRVTVTNTNKNGM3SGE5RXJN?=
 =?utf-8?B?NE9EK3owTnhONWRwd0Q3NGMyai85TFQ5L1Z1RnBEUVowVDcvM2hUU3pwNVZo?=
 =?utf-8?B?cmtRT1RJNWt0TkZRUVp3eVg1NTFuTXNSNityazhhckRZT0F5YWtLY1RuTEtI?=
 =?utf-8?B?cWJ1OCtzOWkvekswZjFoK29JajRUcStaOTZCc2F6SDlUYUtmZzF4ZDA5RTh0?=
 =?utf-8?B?TU9VRkVGTU1NUWl1QUxTU1J0cXY4YUptK2F0d1pqUWFybW1PMHVCdmtQM253?=
 =?utf-8?B?Y2dUeFQwdzg3L05IVklsNjl3MHJaTEhBTFhKeUMyZWZkLzZXa0w4U3M5T08z?=
 =?utf-8?B?b0M0V3B5Vm1zWnIyKzZQZndTNmNwenBqRWNQTyt6R01vTnJYelJOaHZlVGFU?=
 =?utf-8?B?cEFPMEk2dk5IVk9TNHRRYjhvN1dBeHVwZmEyZ1dSelB6enllcUE4Qk95bS9V?=
 =?utf-8?B?SW9RcHZoaWY4Uk1yb2JYN0Vib3pRenI1KzgxeXdhU1c0dVJIbW1NcU9UcDdq?=
 =?utf-8?B?NXFLUjB0ODNOaGxvaXU3UkxDM0o1dXdLMWJSQnY0ZDdVZmtrMXBLbHhMVy92?=
 =?utf-8?B?d2hhNmdsYjlPak5HUUIxMFVBY0RNV3ZCcHd4b1dNZnhXRHpnbnhlQUNKSzM1?=
 =?utf-8?B?akV4WDNQSEtJam9BaU9GRlZHWkxIWitPUG1sbVVNQjlxYXF3VDJYZVFxWkFR?=
 =?utf-8?B?c1pGcFM2OEpKR2JjWUMvenpFQUw0ald3UUJ4TmJ4a2lsTS9wSDlFK0hRQ0VF?=
 =?utf-8?B?UVZJQUhEckZja3ZxV2puQ3lGTm1BSEZtZERWQTdFd3hOdjErVVJTakxkNFV3?=
 =?utf-8?B?SXZXclk1VlN5TDFGYUNqb0o2N0dndW9OdjNzTFF0NUVZUkRSYm1oeU9EdDVl?=
 =?utf-8?B?YnU3R0NsZzZHeEo1U01YcDZnT2lLSFlkUWk4c0JRQWZNZGNDZUI3SXRIZHJB?=
 =?utf-8?B?RFM4cTh2dHFsTG1xKzdYeHJRcnE3MVJyZzI3V0krQWpjWTFXeWIwYlFjbU92?=
 =?utf-8?B?aVNKWXV5TEY4Wk1UNE0vM05qU1JrOXhzbko2ZmNxSjA5N0doeXFIT3JkOU1D?=
 =?utf-8?B?KzVKM2RzYkxxNnZoTkpKVnR1WEZHSzlpNzBqZlZzWDVRN1p5SXNDQzM1RlNr?=
 =?utf-8?B?RUtDSnl6dEx4aXZkVjZIbkFlaEczaE9EWUphZmd0VW5NMHNMY3p5NkR1SUQ4?=
 =?utf-8?B?d2VuL1hSdHZkdHI1SVFTcVdNUWY5OHRpK1JBZldVY0NXbzNkUWVlSEF1ZENH?=
 =?utf-8?B?a2tIVUJydG8vRkJ3Q0hub3VCRXNqQ3VNbmJEWGdIaHY5UFlOTVJPcXZNSXU1?=
 =?utf-8?B?YjErK3hDdVZLYVg3Z00xRFluTGZhZDlyaGQxNjlpd3pnSk5QY3pUWVdsczM4?=
 =?utf-8?B?TlJjNm00NWFIeEtqSXBLTHN6YURDVUdsVm5NR21MbFdlMnZxbkpIVmFGYWNL?=
 =?utf-8?B?bzA4UzRXZG9ydW12czdLUWFGL3o0ZmZkYkdDNjYvbFNXRk9QMVd6a2JwZzgw?=
 =?utf-8?B?T3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	hMjTs89fgxc8EP7neA86ETLELu8eC1g+u3FB9u0fpBQNKRWh5QB99ukjVfE/Y+tVidHbS6ZwnS/X2PlrTqfxTh6/IPUyXB9ZuSiyXmwcGhkX8uQuBnJjXVTz/gvkpbzKS0W1MOjrX3FPyxcuuv6Wy3HDk7c3gaS8IMHXyRPdVpcO85+MWiqVveCbZJP/ziaq3WZWrFkzSCCSqolVJ0sCKcD3Ck8YJYofR+B+rrpL98J5RUpB7vbjbOI6Po/t0nqMKOkSNFX2vWtzvyLZ29fHrpBlRttyFgkCg4swCsyX6h2Fd0zpi+5ART+JIKpZs1Lxv/ZiOKuxW1Pgg37v4bTbrtKypqD7MaR3P9e+UtUfXxvjhaLPK8kaiNMmxDnNkASevILvXKejQU3cTOPDFv9dSCce0mym1NyS4WkTgQ08GN38WJkSt6qQQFaxspnCqGU5Muw1PoQDGug0RprXIHQAH+dxYEgYNrKbl0wLpd2JOSd9DcvUQjKEMsncv1LP7axrsNRVnPFmUc++kRdyu9YEGjd5r9UJsJVfnwWvkC1GN9emD8BMeeUpH8yktp9Ma+hj0y/FUX/iOlnnVrmiZockYE3LXOU9tBv9t6PRGH6ZduA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ade48a3-a0a4-453d-8c35-08dca1ae5d89
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 13:35:44.6923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: amS23zx2ojGOR1qxzjgETNN+92WSKbbeg10e2wMxdP2il4yw2Zf7Uxyw3aRZwGQbC1Fg43aUhAW0qptbkZbz9amLwCaj4jTXP94WgmxA/HE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4407
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-11_09,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407110097
X-Proofpoint-GUID: gh92Pm0qNf1X9cI32ijEZOr-BmKvKQfP
X-Proofpoint-ORIG-GUID: gh92Pm0qNf1X9cI32ijEZOr-BmKvKQfP


On 7/10/24 7:01 AM, Juergen Gross wrote:
> The xen_nopvspin boot parameter is deprecated since 2019. nopvspin
> can be used instead.
>
> Remove the xen_nopvspin boot parameter and replace the xen_pvspin
> variable use cases with nopvspin.
>
> This requires to move the nopvspin variable out of the .initdata
> section, as it needs to be accessed for cpuhotplug, too.
>
> Signed-off-by: Juergen Gross <jgross@suse.com>


Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>


