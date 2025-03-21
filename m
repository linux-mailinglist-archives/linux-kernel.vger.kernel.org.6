Return-Path: <linux-kernel+bounces-570961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1AAA6B6C5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 10:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEF891895B5D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 09:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7568C1F03F8;
	Fri, 21 Mar 2025 09:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XEgrjFZ5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="smv3UT66"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F141E9B3D
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 09:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742548271; cv=fail; b=vELwnkiJwGClVAD2xVwvWhHxqgHvu6HpFQGMHBtfs4Lq+fxeYy9enxn+p8Pv67Uln9FPQS/YQ+rbOXPu5hBcrJQqcgOVKRL9NiwpKBnSqDbbVarW3aCyrRnwSUnnIBNKOxP+vOVU2C/vHZPHxWtMzRLxjoftqP9MMWhM29jk5eE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742548271; c=relaxed/simple;
	bh=4zA+9C/KgaErtEfsTQ4tSYWnYG6Cw6vRmkVKu2n+M+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mbcNOl8nT7dNy8oIVM3Xx9g9+pH9OugCSqcE900ycBEFgiFrFuH9apSXLLab8sN6OS5ylELOzaYDkVWPiGTVdbN4o0RvTwRAur7j/LjcGRB3eEUbDVo8oYnJ9R7tPLzLI4K70tH//OSqthROjK3ewGabIT9ZvqLgCtyn989Q2L4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XEgrjFZ5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=smv3UT66; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52L4uAZb021620;
	Fri, 21 Mar 2025 09:10:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=uuq2XRrdJc8hv/0mduZqLqu1IL1Vi2GKZKzu88SAc08=; b=
	XEgrjFZ55ZHu8t2ryfFQm5YobMW2pm188c70ah5Sl9Uo72Il0QqNlVZ2Fp9FBaGC
	K+WaTrYpSbX4ke2zgwao4wcAF03U2iEW6Z+3YdFLF53vKPAYEePS+c9HALjCzIok
	L0kswzmjgHTdyI3AEkIhQIaRlZpUraP4GhU47Gq4YY0rDkNs/VvmRrircLT1GLnz
	KaxvtCyJcxma+ggByn2LTieyjFBCAyuoEnmIejjRhwy2oVHtbnz1DN4+LnaUcnr0
	akROneCcu5PH4uma3SYZ50Sgb9kTt/eHtJ5JdNpvQ8YqSaaRG82PNm9SZdRZu3y8
	cMuZtkg4wrw52/51lmjmHQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1m1800s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Mar 2025 09:10:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52L8ssfQ009444;
	Fri, 21 Mar 2025 09:10:52 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45dxm3uh82-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Mar 2025 09:10:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ARPmZ2UOGLVnGGpI6lvcWcWXI0YE3/Y8zqvsNjmalQviaN+PqrB/jK90ZHkxLIwynunoPR9JNrO13HE0zTdJvGtvTzW1ldnhdgB5U6MtXmY9rdGz0Tn3RcJcP2kyMfM4t7eNfNzmZoDe4ass74upD2KwMzmP3n7i7o6Jy0N2sb+MOFsLtW09rCFZO77ioy/BxYpdB3rU5EiGmteUUFF7qZ6Jl44mu94j61If4dOop8XXfzuMLvijEI4eaRLSbFNxDwK/FfnEiYxJCYHN5l+1gRLcrt7AmCDOtt9AhkTfMBf5WjuiROhGw2MCMmFlddDO6O3aUZATjbID71qpaDI/mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uuq2XRrdJc8hv/0mduZqLqu1IL1Vi2GKZKzu88SAc08=;
 b=XAXBs9h0vbC9/uPEn16CY5GhOFbSDC2HpZMdPF7PVD8+pjxCLnvlIdwDG4m3LACvApaXdkb7wUDQjWv5zVNIQqmWb6qFy0JWLDjXfSs4qH1uj2ElCdFRmJmPgFws8Itx6LF4O84Oat7zqfMINIvo2EhbX+SVssZ1f5t5BBXbyxkDFEmlXxELDFiM0ezfVYRehJwEQXTzO1asNXY2EwVRQxo3RTcLlsogG3areYKJLh1cLYLMxpBp7hlWw06NAmlnwHfq5IfdLwERawESltv2nWLeFVYMLZp0fQ1upzBwjm36UVSCxyz5PvAU7yb0cQLcse0yYKpYUSEjPpNDiO/yVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uuq2XRrdJc8hv/0mduZqLqu1IL1Vi2GKZKzu88SAc08=;
 b=smv3UT66oizRZNvETmDdDCQOxgH64ACGwdJEjaieFtUXnpo1ZQyjeJXXbfmRB352sElb1hnjuiWmBNPPQiRGIVyDx7RcAqs1g10GJZ/gva/LoFZ6HJPMs0Q0JuYGafF02C9otGPdhQFYKzXqUM27f+A7yFl92NZ7XRnoFNWs608=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH8PR10MB6526.namprd10.prod.outlook.com (2603:10b6:510:22a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Fri, 21 Mar
 2025 09:10:50 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.8534.036; Fri, 21 Mar 2025
 09:10:50 +0000
Date: Fri, 21 Mar 2025 09:10:45 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jann Horn <jannh@google.com>
Cc: Pedro Falcato <pfalcato@suse.de>,
        syzbot <syzbot+20ed41006cf9d842c2b5@syzkaller.appspotmail.com>,
        Liam.Howlett@oracle.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Subject: Re: [syzbot] [mm?] BUG: unable to handle kernel paging request in
 vma_merge_existing_range
Message-ID: <ea5b69b5-9aff-4a57-ad31-2feeb436b876@lucifer.local>
References: <67dc67f0.050a0220.25ae54.001e.GAE@google.com>
 <qn7ncujf5gkfmohf5qp3fdakrymhoapkscafqp5t2gulmgdqai@tuhu2igx33k4>
 <CAG48ez0S4hJyqY=zZB_AWqFKtD7KjipR22F_wz1QvWNY=3RDWA@mail.gmail.com>
 <332b3149-0e84-4bf8-9542-89d68b0a9680@lucifer.local>
 <CAG48ez0JUBPrb5Mh13Z__OeQ+w+uuhfEmj2FRReCpCT-2O-uyw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez0JUBPrb5Mh13Z__OeQ+w+uuhfEmj2FRReCpCT-2O-uyw@mail.gmail.com>
X-ClientProxiedBy: LO2P265CA0192.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::36) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH8PR10MB6526:EE_
X-MS-Office365-Filtering-Correlation-Id: 195ed2c6-4b06-4d8a-a9bc-08dd6858468d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V00xWFlES21PWDF4N3hxcW1icFBzbTZ1cFc3eUdOeGk4dCt0TEp1TzJ0UDZq?=
 =?utf-8?B?dUNZTWZzUGxuRVIwM1kzb0dhUmRuRDdob0ZaL2ZjbkU2QWJBM0FOc3RscXNU?=
 =?utf-8?B?TTY4M21Ib0dFNVRtVTc5WTJvZzErUTRkaHhOYmVuN2lIcE95U1p2NUlnTzVP?=
 =?utf-8?B?cWl0UWQ3QS9XK3V1ZzRPNkViUW5qQTdWeGYvbzE4RTZqUlFmRWNlNHY4V3M1?=
 =?utf-8?B?VDA5Y0dFd01yelN6R3BOQTF5cjVIZlVXaHFhS3pJeXF3dDZJN0p4elYrRTVK?=
 =?utf-8?B?Sjg4a1RQMC9NZFVIZGVBcDJBdVdlMUkwKzhkUE8zZnprUlJTT0xEYmRZSWZX?=
 =?utf-8?B?SkVEY0h5T1FwTWd1aGdXNnZheDFUVlU1YkJpUXhlSlVCMEpGMEhsRkl4OVlF?=
 =?utf-8?B?Smd4VTdlWkYxRHZ5QVVjSFNlaXYrQU1jK09MeWVlUlBEMFRmenhaWnluUFVs?=
 =?utf-8?B?SXJZeHphVms4c2lGMHhjTFNETHZzR285SEZ2Y3dvbk5CaEFIRnZKRFYrTi80?=
 =?utf-8?B?RWVTTFkxMlBuaUwyOEptMnBMWEc5bm1DQVIyRHNvZy9RZ2ExRlJOcmdzRENP?=
 =?utf-8?B?OUM3N3F3QVo2VDdZU0xzWFkzaEdWNWNzTGNxK21YdUhNa1NIYWdSbmNRV2NQ?=
 =?utf-8?B?ZWsveEo2NlVyOFdQWlAyYTNZODY1YlNWTmRJa05TUm1XckVScm8xSjlETHRw?=
 =?utf-8?B?QUZPTGhTUDJYZTdGSUwvWnpEMEMvRmFwMlY2VVRnYU1WMjg2WFJoTGVoU2Jx?=
 =?utf-8?B?eWJxNy9QMmVqV2VwOFhHVzQrdlBDZ3FHbm5JY2RBcEh6SGd6d09Ldmo0N1Nv?=
 =?utf-8?B?QWoyQ0oyOFUzOFFCdUZSNEdFRlc0RWZINXdjemFBbitvaGFiZjI3RHBnS2Ns?=
 =?utf-8?B?Q24xSTJDS29SS0taMkVVSDJmUDd6TGVUd2R0d2tjV1ZpKzRkdWhlRVVJdm5y?=
 =?utf-8?B?WVRYT1puN012VGp3cFdxbDVMVEptWk9YUkZ0QkhQN0krZGQwcmR4c0xvNU55?=
 =?utf-8?B?M1hkd09ZNm5HN0hrU2o1V0dWQm5Hbkg1WGNnMW0rSGtsZVYvdzF5VnMvbXlX?=
 =?utf-8?B?RUZvSWpOQmpHcDFIbFp0ZC9iRHg5Wkl4bnFTU1lETEhub2dvWFlKMFgvM0pE?=
 =?utf-8?B?TEFvZmF2dUFzMXZqb25BdG1RaUk0YkY1UDNOTXhyZW0xaDBicHhwS2toUGw3?=
 =?utf-8?B?RE5vN2tSU0kyQ3dzQlZxNHFVSkU5cnNzb1FkUVN6QVU2L3pleFdUL1N3N3Ew?=
 =?utf-8?B?eW5sZnBVTk5FeWZHZzVPUEVnMXhqSGZDRHVRUlVlUDlSeDhkb1Irc29rQWwx?=
 =?utf-8?B?eGdQUGVheUpRek5XOWU2ekY4WUJwa25UQXpvU3QrWGZQSSsvc2ZZRGtZbXlD?=
 =?utf-8?B?N052ejBjSmlYaE5tUTZNUU9FbkV6ZDdyeG1mOHV0RUpyV0puVlZGY1pHdXZR?=
 =?utf-8?B?bklCQkR4dmFDMm5PclhXTU9vUC9mSW83MEs0dkNLc3g3QkdvR3lJaHAzaXJk?=
 =?utf-8?B?WEN5QjNQSWhOSU5jZ3hwbjJZSjdXS1JGbitZbXdTVDJISFR4djEvOVBGdjBq?=
 =?utf-8?B?MFFmbkpZVFNsSFZLa0laeGU4MVhQTXZnTXBwZUU1a1R0Y2tKOVZDMElDQkZD?=
 =?utf-8?B?WEZJcnB4bjJMbEwvV0tRQlFZelZpRkd1dTZBN2szTE4wMUhoTjN6VGZWb2NS?=
 =?utf-8?B?eFNTNUdySzN2SmR2TkRzTWwxQXlyWmhGcmtXbDlLL0lIVnJsQjNrSUNrZFlZ?=
 =?utf-8?B?cTBxT3NvcHhFSXkzdmpHMWVVcDB5ZEpWc2Q5MkhCZVgwYitZaThiaDE3RlBW?=
 =?utf-8?B?WndqTVVwTm5qY0hZd3cvUW9XU3kxL1BDZkFHd21ITzlLSk9veGF6a1FheWNI?=
 =?utf-8?Q?tdP2fGx0I4FCE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VkwweEp5OXE0UFZzMUx1NCt3ckQwQSsyOERwWElsaHNYZmhaN0c2bFkreEhM?=
 =?utf-8?B?bUdwVWp3N0ZrODB5TEYxMDNKKy9NckxOWGsrL01jaEtmUEJHT0tsd1B3eEpJ?=
 =?utf-8?B?ZWFLTHVZbnBDMTdVbTVhT3NsRk5VYlFZYlMxeDdxdFh0c09CSUh0cnBwR1Av?=
 =?utf-8?B?Z0ZmOUZmcWpFOE9Rb1JVdzZtK0l5OG5ia1dJb3dTZWRGVWxRa1lTSkt3UHhj?=
 =?utf-8?B?R3gxenNkUEo2bUVNZS9PempUYXJqWmhxSXdoYjU1NXZYTDhaVS9oVkRBb1hy?=
 =?utf-8?B?bUdEU1gvZGxUQks0eXdQRkQzbEhrdnM4ai93bmxhTWpSNVVOV0x1a2VlaHdS?=
 =?utf-8?B?V0tINXhvcWlycDFUU3dDd3lkQ0d1RlJtZWVrQ1FzQmxQL3FFZ2NnN0xDNWRs?=
 =?utf-8?B?TlJWdEwwNjdNbUlRVW15RUVRTVEwUnJYVHo0d3J6T1lDWHFoMW5JdnJKUU94?=
 =?utf-8?B?NGt5T3lUcGFvdWZHVm93YU5EOHlsemVwY2dJbDFIZjRwT1NXV01TaW0wS2Fo?=
 =?utf-8?B?MGNoQUhmcFd2RzZ6UG5SRDZxRkVMcmhQVkVqaWd3T0hsOHdTNzZGWk5LVlht?=
 =?utf-8?B?Z0pmR2xkdGVGd1cvdzVDU3ZjcVhtaVBwYS9IQ1Znd0tjYnRaM2xNMTd1aFI4?=
 =?utf-8?B?K2l0bWhjbVdZdU42SU1MckdlTS9ScWFEV1FZVGt1NWJ5STBiZkhpaVVaalcx?=
 =?utf-8?B?dlppZzFUWXQvTXgxcVNoVUFyb1Y3bENZaFV5dmNKNTE2N09nWkNKWVErSE5Y?=
 =?utf-8?B?Qm4wVUwrZTZ2QVQ3a2hnRkREWkJmRktuejdVMFhHdGhDK3RhenVHYTUzdTBV?=
 =?utf-8?B?NFdvVUppY1RzSGpHUmMycnQ3UC9DNnRzMTJDMUxYRUF6QVhEOXA1UHJRSEVZ?=
 =?utf-8?B?M2xRM3M2ZStOMHVnZGcvL0FEWk9xUW42cnZ4eG1xejZNQ1JTa25aSnBsM1kz?=
 =?utf-8?B?NXliNkNhSnRVY21WTndzTUZWbHlZeVlaVTU4bS9BL0ozY2ZKZjM3Z285VzN1?=
 =?utf-8?B?ZGZyQnFkSCszcjk1VDNvYXl2S1FKN29uMUoyRkhzaGpoVUZzOCt1Yk5jZ3Qx?=
 =?utf-8?B?THB3bFF0YlhNaU5kdlYvcFpxL3BwalhiTmVQa3ZuL09wc0R3bitISmdJM1hO?=
 =?utf-8?B?eTVyNGZ3WHdRSEY4cWV4aXhpSlRsY3d5N3Nza3FVcFpMNHdSWXR2R2ZLT3RG?=
 =?utf-8?B?U0pYQ05lbzhYbHVvRGMycEszcnF2bDh3cjdjendWLzBxcVU1R2taU1k3UGxB?=
 =?utf-8?B?aGNwcE5IOS8wN3h1VnU2RlpOOEFuckZOOXJFaUhleGtLUXFCWno5MUl3dkJY?=
 =?utf-8?B?T0N0bEMvaW1zVnU2aTFXS0NMRDdabndobC9FNHFVNFFjWjRJYVRINlJQVXhW?=
 =?utf-8?B?ZTUzYzZlSjVybUVodzEydHZCdmNCQXRSd3lKZ2oyK3dBTHROMmRGL3NKeHBs?=
 =?utf-8?B?dHJGWlBWZ1c3R0RsbTRVOU5hbzlQclp2aE1oSjBMQ1Q4eWNnUDg1bk1LdmQ4?=
 =?utf-8?B?eFpzREhid0x6RTFVUHM4NFJEVzBDTHhvNGZKdUMvY3dLYWR6blVxTnFmckVO?=
 =?utf-8?B?NE5paGRtMldMV3R3ZW1yZmdKK3gyTDVIeklCZ0RxbkpETzJYRmJzWWROb3ZZ?=
 =?utf-8?B?WDhoeERTbDNvNXFnZVpudGlMRklXajdodEhEcXVtY2ZEQ0xmYXhFQUtOdFl3?=
 =?utf-8?B?NkovOVp5V2NCYXMyVDRETWkwVUU5c3RSS0YrOUZtQ3BqZU9VWGtReXFoOWtn?=
 =?utf-8?B?RXhjN0NOL0ZCUzU0ZzRXMXNaejIzUS9vY1Z1cjVCWlc1SGQxcGhCVXkwUmps?=
 =?utf-8?B?c2VxbHpicytzdUEyTzROS1RDdDZ5bEV0MEI3aXl0RnV1V2NCOTZpNUNZMVVn?=
 =?utf-8?B?a2FXVC9rck85NzV5SjRrSGlwWTQ4clUwZy84TXc2ZXY1OW9pRitEYXJlVTAy?=
 =?utf-8?B?MytRMGhhaFZnbTI5TFFzWXAwcllKdnVWdC9rbmpKUndoYUtuVDQvZXRlR21j?=
 =?utf-8?B?K1F4R1pJSlRpL25JdGRyUFlBVEpTekFjRVVPM2J0TmZEOVNiRzRSTnVsOWpY?=
 =?utf-8?B?MWg0cUtDb3JkZHlZZnhoMndQdGdrTk9zd1lHZ0ZDOUdOdlh3bDFZZlVPNGMv?=
 =?utf-8?B?L0k0U1FjTGY2bzhLRCtHWU1DbThqSmtwb2RUSGprTzZqeFdOWitrK2hLMi9K?=
 =?utf-8?B?SlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	c/jeX++r2RgSHhp6Q+nfqBmnbiN8xeIdGY/rJ+m/289031YF6UH65MwEFjkQj0PeurUloqvSa8Q06JFa/3OWm/nbAvhR3tju19z8giZcxvBHTnwDXLtjArEoOjb0rcXWCTH0HZQppiInfMqK03yXOtHKLjTULblbUKOUHYhNmcfDjIYlREAD+nwucXtvzjGQvfu/NXl4AMU04KIs67j7gUGCG59NDgN8aYpLY+MLeWaxmjoNG+tzUyaF2uwhjPJxXIjg6qip6Oc4lodQ+QstAp3cd3sxNMyXPfCNIZiQKuhKPlw50jRG++BYu02FadJ/Oz4ThvKod7BXZadNPFSlFDY2advmfPus588qE22o5kT0VjvF+OICBb+PQ4Fs5B0oudbVhJmmqPzamBqU1s2r26RAc2AofNknNRp1bX+5pKBzAHSabhpxDC58lKzGhm3TcwTyBWz8x2JMQUhkd6XQTf+ePfdapzUbMCVvEtqClSJb6kSw6J9KxNn3FDi5viJxRv+sJcoUXlge5Uw0b5RD0H18O7fk9C/tOlwhFdkM6XJ8WSafpieYdXfZAri13YTEEj36Vop8FJmjrVHTG3VNaPOzVDhwjlJnHrwY9ixRiQU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 195ed2c6-4b06-4d8a-a9bc-08dd6858468d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 09:10:50.7707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9/8/VHi5+QaGsg4uUBhdlLwoP5CFNnfTTR+8B7VbSyL6E6jNMRjx9Tbn5v87wrEoVOpIl4Z3vacOcBsn8s4cYwpG8uDiNpezO/kOKXslkYM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6526
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_03,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503210067
X-Proofpoint-GUID: hlEhWvHNPJcuC8FpUvYyrJQWlQpi3azR
X-Proofpoint-ORIG-GUID: hlEhWvHNPJcuC8FpUvYyrJQWlQpi3azR

TL;DR: After actually sleeping :)

Original clear all implementation only tried to merge, so the split bits of
vma_modify() for it are no-ops (we iterate VMAs explicitly and try to clear the
whole of each VMA).

So we can simply go with a mix of Jann's and Pedro's suggestions and pass in a
flag that says 'I'm fine with this OOM'ing on the attempt, if that happens just
give up on the merge and let's reset the VMA in question.

I will write a patch for this shortly.

Thanks guys!


On Fri, Mar 21, 2025 at 12:04:42AM +0100, Jann Horn wrote:
> On Thu, Mar 20, 2025 at 9:53 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> > On Thu, Mar 20, 2025 at 09:11:33PM +0100, Jann Horn wrote:
> > > On Thu, Mar 20, 2025 at 9:02 PM Pedro Falcato <pfalcato@suse.de> wrote:
> > > > On Thu, Mar 20, 2025 at 12:09:36PM -0700, syzbot wrote:
> [...]
> > > > Ahh, fun bug. This *seems* to be the bug:
> > > >
> > > > First, in vma_modify:
> > > >
> > > >         merged = vma_merge_existing_range(vmg);
> > > >         if (merged)
> > > >                 return merged;
> > > >         if (vmg_nomem(vmg))
> > > >                 return ERR_PTR(-ENOMEM);
> > > >
> > > > then, all the way up to userfaultfd_release_all (the return value propagates
> > > > vma_modify -> vma_modify_flags_uffd -> userfaultfd_clear_vma):
> [...]
> > > > diff --git a/mm/vma.c b/mm/vma.c
> > > > index 71ca012c616c..b2167b7dc27d 100644
> > > > --- a/mm/vma.c
> > > > +++ b/mm/vma.c
> > > > @@ -1517,8 +1517,16 @@ static struct vm_area_struct *vma_modify(struct vma_merge_struct *vmg)
> > > >         merged = vma_merge_existing_range(vmg);
> > > >         if (merged)
> > > >                 return merged;
> > > > -       if (vmg_nomem(vmg))
> > > > +       if (vmg_nomem(vmg)) {
> > > > +               /* If we can avoid failing the whole modification
> > > > +                * due to a merge OOM and validly keep going
> > > > +                * (we're modifying the whole VMA), return vma intact.
> > > > +                * It won't get merged, but such is life - we're avoiding
> > > > +                * OOM conditions in other parts of mm/ this way */
> > > > +               if (start <= vma->vm_start && end >= vma->vm_end)
> > > > +                       return vma;
> >
> > I do not like this solution at all, sorry.
> >
> > I mean I get what you're doing and it's smart to try to find a means out of
> > this in general :) but let me explain my reasoning:
> >
> > For one this is uffd's fault, and the fix clearly needs to be there.
>
> I mean... this worked fine back in, for example, 5.4 -
> userfaultfd_release() would loop over the VMAs, change some stuff in
> some of them, and merge them where possible, and there was no way
> anything could fail. It's the VMA subsystem that changed its API...

OK you make a fair point, actually (after some sleep :P sorry was running on 3
hours yesterday).

On reflection adding an option to the merge that says 'if we can't allocate,
give up on merge and return NULL' is sensible, and we can add a parameter to
vma_modify() saying the same thing, should split fail, which is another error
case that must be considered here.

So this code path is going vma-by-vma so will never split, we need not worry
about this.

The original implementation just tried to merge, I made it so we shared code
instead of duplicating all over the place as we do the same operation only we
might be within a VMA in userfaultfd_unregister().

So this is really simple actaully we just need a 'ok best effort try to merge,
we don't want to know if OOM, if you go OOM there, give up'.

But for aforementioned reasons about implicit assumptions this _has_ to be an
explicit flag.

Which I will add :)

>
> > But also, we _can't be sure_ vma is valid any more. The second it goes off
> > to vma_merge_existing_range() it might be removed, which is why it's
> > critical to only use 'merged'.
> >
> > Now you might be able to prove that _right now_ it'd be ok, if you do this
> > check, because vma_complete() does the delete and only if either
> > vma_iter_prealloc() or dup_anon_vma() fails would we return -ENOMEM and
> > these happen _before_ vma_complete(), but that's an _implementation detail_
> > and now we've made an assumption that this is the case here.
> >
> > An implicit effectively precondition on something unexpressed like that is
> > asking for trouble, really don't want to go that way.
> >
> >
> > > >                 return ERR_PTR(-ENOMEM);
> > > > +       }
> >
> > >
> > > Along the lines of your idea, perhaps we could add a parameter "bool
> > > never_fail" to vma_modify() that is passed through to
> > > vma_merge_existing_range(), and guarantee that it never fails when
> > > that parameter is set? Then we could also check that never_fail is
> > > only used in cases where no split is necessary. That somewhat avoids
> > > having this kind of check that only ever runs in error conditions...
> >
> > Yeah hmmm, again this is _not where the problem is_. And we're doing it for
> > _one case only_, who _must_ succeed. Right?
>
> It seems to me like it is... theoretically very reasonable of
> userfaultfd to expect to have a "reliably change the flags of an
> entire VMA" operation, and if the normal VMA code doesn't provide that
> because of maple tree internals in the merging case, then it would be
> reasonable for the VMA code to provide an alternative that does
> provide this?

Yes.

>
> > Buuuut then again, we could add a _feature_ (it'd be something in VMG not a
> > bool, hey what are helper structs for right? :P)
> >
> > We coould add a special mode that says we __GFP_NOFAIL, we do that in
> > vms_abort_munmap_vmas() and man that was under similar circumstances (hey
> > remember that fun Liam? :)
> >
> > But at the same time, it feels icky, and we probably don't want to
> > proliferate this pattern too much.
> >
> > So I'd kind of rather prefer a _general_ no-fail unmap that the uffd
> > release code could invoke.
> >
> > Perhaps we could genericise the vms_abort_munmap_vmas():
> >
> >         mas_store_gfp(mas, NULL, GFP_KERNEL|__GFP_NOFAIL);
> >
> > And make that available or some form of it, to do the 'simplest' thing in
> > this scenario.
>
> The userfaultfd release code doesn't want an "unmap" operation. It
> just wants to remove the __VM_UFFD_FLAGS flags and set the
> vma->vm_userfaultfd_ctx pointer to NULL.
> The VMA code then sometimes sees an opportunity to merge with adjacent
> VMAs; and this merging is what's failing.
> So if we're willing to tolerate having adjacent VMAs that are
> mergeable but aren't merged after an allocation failure, then instead
> of using __GFP_NOFAIL for the merge, we could also just ignore merge
> failures, at least when some "never fail" flag is set?

Yes agreed.

>
> [...]
> > Another possible solution is to add a flag that _explicitly asserts and
> > documents_ that you require that no VMA be removed before attempting to
> > allocate.
> >
> > Or we could make that an _explicit_ assumption?
>
> I don't think I understand this part. What VMA removal and allocation
> are you talking about?
>
> > And then the uffd code itself could cache vma and take Pedro's solution on
> > that basis?
> >
> > void userfaultfd_release_all(struct mm_struct *mm,
> >                              struct userfaultfd_ctx *ctx)
> > {
> >         ...
> >
> >                 for_each_vma(vmi, vma) {
> >                         struct vm_area_struct *old = vma;
> >
> >                         ...
> >
> >                         vma = userfaultfd_clear_vma(&vmi, prev, vma,
> >                                     vma->vm_start, vma->vm_end);
> >                         if (IS_ERR(vma)) {
> >                                 BUG_ON(vma != -ENOMEM); /* Sorry Linus! */
> >
> >                                 /*
> >                                 * OK we assert above that vma must remain intact if we fail to allocate,
> >                                 * We are in an extreme memory pressure state, we simply cannot clear this VMA. Move on.
> >                                 */
> >                                 prev = old;
> >                         }
> >
> >                         ...
> >                 }
> > }
> >
> > I mean it's going to be dirty whichever way round we do this.
> >
> > Thoughts guys?
>
> I guess my main thought on this is: I would prefer it if we keep any
> code that runs only in near-impossible cases as simple as possible,
> because issues in those codepaths will take longer to find.

Agreed.

