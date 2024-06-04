Return-Path: <linux-kernel+bounces-201211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A46D8FBB01
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 19:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F15F284C9C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 17:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4571D14A088;
	Tue,  4 Jun 2024 17:53:20 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F70813D52C
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 17:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717523599; cv=fail; b=DL/w3R09MaABl2ZkTbhN95Bhc6kgl9g64yVRs3/Jh2MRUPOiJiPsEQPATDKD5xbVc2i3F3FMRDd0Y00K2IxOqm1Pf+1vPdgF4jkiNzgEWAUNtoh+E9QSpuYpjq9zZqU8pfZ6R7WjE9aa9fLP6UU2tr5hQHagXl/Mtb3ktjca1QU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717523599; c=relaxed/simple;
	bh=mJcQEjN3m7eKAsSRR4CgP5thHk/z6dmYH26yHzS3lWw=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=TacTk7TAQBpqC1R8ulwO6nOY9ZARuCrkgNK5MhbXXFaQCDh+JIddugVsR5meprx2wshWkC4i7kDgiGMnP2tK6oVbneVk1xddCtRRY2NLMwlj+97DcnqclYYY8BLCw1Mu+RsN6colUsAC/3i5PKoKNdbAMHqppMs/3PJe9whwHNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 454BnaWG024276;
	Tue, 4 Jun 2024 17:52:56 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-type:date:from:in-reply-to:message-id:mime-versio?=
 =?UTF-8?Q?n:references:subject:to;_s=3Dcorp-2023-11-20;_bh=3Dar1zAe5xV3Wk?=
 =?UTF-8?Q?gDskWLwtK2yR73TKmHme8jle94lvkT4=3D;_b=3DLa7GwQvY0W+3qSGD0edMjA8?=
 =?UTF-8?Q?l4TYkD4Xj5fLPBQPWxzbOJ2ho93K/b6VyLBKG0AUKYEcU_SgrfvnwJ/tdCGG/w1?=
 =?UTF-8?Q?WM62Sc22rv1XOhlfGSrjvb20gHttiyFhRZBHUtyJYHKTxuNiWD+_MD9y/lfGoBU?=
 =?UTF-8?Q?bqV33D1LQp3rxzXYlJvy9kgLRhcCgDZRvRIUNDZ59+Q+37/Vj9fCAzJDt_DeYAq?=
 =?UTF-8?Q?UJWyCg6JPVu3JbuxDx2c97pmR9jRH+8qQMZb74oFfj3W3DNcDz9pWI5m1BQe+ok?=
 =?UTF-8?Q?_xCLWRI642Hg9ZJcGyz95nRGyX6ZKJSgnyHdMsmQfGndu3C4V2erMvWLo2Q/rBw?=
 =?UTF-8?Q?NixyjB_VA=3D=3D_?=
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yfv3nwjj3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 17:52:56 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 454HJigE025210;
	Tue, 4 Jun 2024 17:52:54 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2044.outbound.protection.outlook.com [104.47.55.44])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrt8y9kf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 17:52:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CWGG6nL3q0ps4m1aJzQa+25qwSxTV1Rk0mm/qIjIgNykHj++kO28KYnCEzfFa6Nq05Yhe10D7UmZTEY39DYcS5siytTFvKz1Lj/+5ZZiC1W/r58pS+AI5XzpnPNyqOplAW2K7tfjfHa/ACgfMpiykIYJAup5j//gj8OzoFm1sVWnXAfiFkiy9rp0AlfJH5eWlpx/ph4LXKjfE/ZThVxA6OYUw/PDw8s9iXUq0QzxI8fGYTIQglaCeXykfErg5uz8cRAiouXflZpV0oWCZ7FVurgivWcSENanjkX7T++98z/X62VwkGFObHoDW2FKShKDzn8rn02WfCwEEkm1IG8i9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ar1zAe5xV3WkgDskWLwtK2yR73TKmHme8jle94lvkT4=;
 b=n0bG6RcBZMZop3gHrrup7KZSLFuOh9Ha9ivrISuzAwDg5YMtsGwwJQ2xcPh3G6pT2ZmxvUk8hB2Y/rkPWGEw/mgEmKsksr7k2VUz1JMfVCNq2ZKCyfcAKdBy87z+aO/Pm+u+VyKoWZH/MkAR1dWDYzTiwLWusjwAvtC30J17BdyoHhzBjWzJ0fOGg7JF18k0RxD+WE6DfAop2K31fKTw8OMxMKvQI+H2ctdU0iYPXzFjIx7h1GFY6vLpsNRILNU7iG+DUKIJO9340KhMBSg6FmFzQj4ec04jKoKm0l7LdkLjfGqD6EdzKWQDJhv6AfIismfYxUBgCmwRnTO7M0TEpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ar1zAe5xV3WkgDskWLwtK2yR73TKmHme8jle94lvkT4=;
 b=m7+w4XoCeMHioRzFrV69hB9/sf0GEHQrWsVk1/gdK3UnQc3RyLC2tPyuhe8FN33G62lmW3RBO2yM+vEYlVOgjAJiHTsSRJa8TWgU5BEfIEIZA0zPfuVEuYFK3Wo4bn6U/zfE5lHEB+4zEsLR8EqwRQxU315qPK6yBxKKioHYZe0=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SA2PR10MB4796.namprd10.prod.outlook.com (2603:10b6:806:115::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Tue, 4 Jun
 2024 17:52:52 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%3]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 17:52:51 +0000
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
 <20240528003521.979836-5-ankur.a.arora@oracle.com>
 <fa715df1-bc7f-4abc-8554-947484b2c0ae@linux.ibm.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, tglx@linutronix.de,
        peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, rostedt@goodmis.org, mark.rutland@arm.com,
        juri.lelli@redhat.com, joel@joelfernandes.org, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Jonathan Corbet
 <corbet@lwn.net>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 04/35] preempt: introduce CONFIG_PREEMPT_AUTO
In-reply-to: <fa715df1-bc7f-4abc-8554-947484b2c0ae@linux.ibm.com>
Date: Tue, 04 Jun 2024 10:52:49 -0700
Message-ID: <87sexs389a.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4P222CA0013.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::18) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SA2PR10MB4796:EE_
X-MS-Office365-Filtering-Correlation-Id: 340e1793-6070-445c-6249-08dc84bf2748
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?K5UYvRA18Kc9VeiLV3Ba75qIAxZxJQSwz6X51b6atSHr7EGP0hZFRtuv+09C?=
 =?us-ascii?Q?Apt4BOTEC9cFfd1iY9AfWVziltEXoAN+719PdiMFqxCd14eNB0mVyED44aCG?=
 =?us-ascii?Q?20xjsbE84GlVHPCaCDtiGxZexla5Yuq0C559OcXiZXVIckgJuGFR6XVAJG/r?=
 =?us-ascii?Q?wZADz6hhvAsaa+x37UeGQaWl6nZExDSHFzTDFrGX7H1G3dk+neJJKCRQo7Ts?=
 =?us-ascii?Q?hMdzwhCtM7wY+iaVpaaHYNWEZNDYRSe2CpMjNQB4AUVoEt4LMELoN0/VPV2w?=
 =?us-ascii?Q?dsoZpFztlRw8ApsFDZ3kqViHhvpgMV+SSNWAT0DWf15aZH16asxmiTwbZx1H?=
 =?us-ascii?Q?7QiOQjbauxIZGsDStdZwRnB1CHyRGh5dCNoj5/FKPvmfbENKJ23OTHG+769t?=
 =?us-ascii?Q?GBKUc40X1AuUjqReVoPXDEqJg3Ow6vPddkMuBXMp3w6HVnvPtsLsq8nTVW3K?=
 =?us-ascii?Q?q6GKmofWKtiJvfMfmz4LRDDq1n78+fs9xasw34G0ah3PjLk29+RcqVWnMxt+?=
 =?us-ascii?Q?hYz3IpOQY6AsPctcgQIlt/o2QqYHV2cTvpdFVlmdGEFiga0wEu2n7Ib94fr2?=
 =?us-ascii?Q?XhPhOiDAIonfx1AACYMc+SBNKtglMPmnL3Tl+5UVTWNEBEpVGg+GiswYyKa8?=
 =?us-ascii?Q?vCiAK/Y4MLFqmj0naXpNk9x0s35g2vd0FpXg6uLyhJm57l+7f+v/70HFxE78?=
 =?us-ascii?Q?6bN4LDP4Hx3+ds1sCOFnQCC+ZtYb0lIYFq4gSWWbG/Yf6vReNY7F+JFl3z+a?=
 =?us-ascii?Q?Zsm7BS/M0aYOLTgKvZBQbTGbsvj4aOfF/hhGIcK0dTrYvDW3dl39E5LW/Bs4?=
 =?us-ascii?Q?B7vvkywCUdiSy2N9jKPS0//ohd3VRysKkC5EyUU4XK/nkPX6rogiA2R6c6jm?=
 =?us-ascii?Q?ds+PNNCoNSy9kxMIWHFG30oweq+8uAoMu/XOeXh6MpnEMSeA8PAkICOHqIlw?=
 =?us-ascii?Q?X771uO/GqJA7VluLh1xJOdhyVjFxvcmuL0gGXsmd9Y5LS6T4p7SrbLy1Pz8z?=
 =?us-ascii?Q?6dlmh7FriKuZwpYiHqw8X7r1NwHQWajCLOQeGPtYuxjZ8dIZid8dZCFTZlmg?=
 =?us-ascii?Q?uvqR+7P3ctxLv+iCUfpbIx48zbEJQ385V5lBsyXrki5P289M2+zx1QVLPE4F?=
 =?us-ascii?Q?DR/Hz2trHVkG+C2JsjYGKc/62RM/YOvbWIB/lfBI5S5AZoTwedX7Betvw5Dc?=
 =?us-ascii?Q?/kRujww6bifee5ugphnKACb+mvqnRIs3zMedxOU4eZ+aFUIGz24duHJ+x5gq?=
 =?us-ascii?Q?qFqUtIEMpFqjBci3fY0c4ynBtPPN9LRngpjRbHyBrg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?wA7eVFKfMGp9wmHrL0kucVYdvXf+eNOwiREA6TxA/C0JUmXNGRryZRfbGlKJ?=
 =?us-ascii?Q?Bbsbeern34tdgINVVkzmEXvp5JpJzxF/nZuttPVhc6fgF6Gjb7XPI+Ix2tHq?=
 =?us-ascii?Q?i1t3Ht/6x3QcwFJVjYkbHZOyb9FIWfZrh9lEj6hVUyhqFr1oDMeg5uZxz0m0?=
 =?us-ascii?Q?GAE85pz37MrqSWFPMimexP9b/mc5Qnh+c7FsjvBLM/NVqg5XryMYd1vm+yk7?=
 =?us-ascii?Q?rH8wllASJnaUVnGsUkv2SabTFzy7RM+MNqO5mQ1yvFjisn7viNHOFRSsYkQM?=
 =?us-ascii?Q?Ac88KDShUVmdyu2tEZNi8dDVFrEyjrpxAsQ9obzhV+RG7K0OWPHEX6slxyqf?=
 =?us-ascii?Q?IQM8faHq2g7vRUtIzwLAYeP41I0IcBbgxP9f9hPE0JVqAQiKpOnPbwCTu/aO?=
 =?us-ascii?Q?VqYO4x90ib5FPtn24i3Zw5VNlzzcsnOQOxse0BCDSeGuRqVcMjQNdlvf+qgN?=
 =?us-ascii?Q?YeYS3+0KDJFgwdgsOXizj0s+GWyGMaPpzpk5GMeSOyc4uI/ML9nrx+7rHNzb?=
 =?us-ascii?Q?jnsFHyKAoxD49fMRmJvAIy7xMRXhVE99x5QB7A8GXMVfIVoMl84NYiUtOtPQ?=
 =?us-ascii?Q?3uIyBn4igL650czftisNk8wqwLSNBGOig8peDLKcD84MYZsta/HBelHDuShd?=
 =?us-ascii?Q?XrobM+HdT2mGGLdGseRrcuObcRXjv/OcmOzRSi/AqajPwASW/d7xWrlkP7c5?=
 =?us-ascii?Q?9rNFTRofDgua8WVopzgFtiTR0IYfnubtuOLdRMGLe3lWnhC9sxtDl6IXZJKL?=
 =?us-ascii?Q?Yz1zUfQl7IJKwwN95o2K0eXZC1ZkEFGeOWzWqB3r815ynpWh362bt2Md8xsz?=
 =?us-ascii?Q?d/zOExzCN+/8K1ebkIfg8I1q59FT9Ijyn+MFDDEIYxJWMdrLtjqsmPuwOo3T?=
 =?us-ascii?Q?6s2jvrNQi57GaNYr8JlyC6phr12JfVZ7/sVn+FZoQqrfq2Y3KYrwm9gDHiem?=
 =?us-ascii?Q?lCQL6P4cmNVjGCRxjTiqqZyqHvKmVwbMoIeUK/AT5x8/JFXd3cQ+gVPAQ/ru?=
 =?us-ascii?Q?UyCUq1tDVtV7og97DAbs9+aLN0IYjkQWdsj3CWpjtg1NdcK5nXiWpHAuk+GY?=
 =?us-ascii?Q?Jro0Qj9SzcJDroELF1glK9oo2heiGN8//OLhm9keNqBWvgkolOBKbNWzBNMX?=
 =?us-ascii?Q?9iW03gxWtP2wdJVxQ+J8ENv+06yB+0obzd87dUO8/wwk8C3iOa499EtsEVQ8?=
 =?us-ascii?Q?fRq0q0FhjUpRq1c586IXyxmfszCvlLnCoFhY4oAmRJ1EPvy/HtdsXPNX0BtU?=
 =?us-ascii?Q?N5RH4Q7zGM5AJzvTiP2RJer2gUwTvJ8JMuNJR4L+FQ7PEvOhcaVWMdDhndRW?=
 =?us-ascii?Q?nZr/r1t+UvnIHIXVV0HWkQa634ESjHAPix57RM795tnYuhy4CG3/HJJxICYp?=
 =?us-ascii?Q?uSVYeri8Ut38V+h5NZYquObf0rDmZLsLNOi/Zdf/2yfnOGfBrTS91kvpcQc/?=
 =?us-ascii?Q?YIk8JMIJ5hSsQiF8Eqo2BytX2oph8r/swJo0h3oB3DRjB7RepP9CqPw5HHpf?=
 =?us-ascii?Q?yw+NdtIWlEf0aAXbXtL85fhio1zBuF3qmnCjOD+Ag3kggWsq9wz599A/rRc0?=
 =?us-ascii?Q?muxEjyc1u2YYQKKrrpzhPC9LaDfSUUpClrmWmfXFhCKEF1lK4P9hgtRneW2P?=
 =?us-ascii?Q?oQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	iqs9xv0iKo9Tylz3PvJTrPK/5JsDneMoDzcME0dvnV4ZC6BkqDC24vnQXXu8Vk21ILG7Viv5WLEsGAxnU8Xsx1xI2fE1p4e7zha1SOLBzJL4+YBTpb9JdkgXoBOXQlDoXIMK2yS230YHC+4v6bnsUY2+SacDDuH3ui7gC+FuNHZ7Z9IL6QZ/L8e3zXki6a6pkL0sIC4rG9bQx17xgJlqtbVSwUrlPoWUpc/lnfHMmSGyQ6CgMp9qPNepLDJr99h+7fyGI3H4D+RR3W2cMiYsm+KmhtSXnVQxkimPZU+Tn+lJXYtBWbtqPue6mVUoRtNCYtYpuonQOjIMD0HVGBZjt5VMDn8o2NZClYOeO5RwrYKVfuJ1shmZnTi5zw4cv6K+yi0Ne2LON2tSYfPLDQOig7yHaLBr9gvxKCmDHSA5PHoTo61StpIUYdZqebbFXzMjCS4TQKB31nRhawgGjPWmQ73TKB6HudwmyPqq5BedLqpr12oRDsR4yFO0xe5MbSZAmnIEfej2AppSbqJlEMGaaX8oFrHF4sdt+xwKXQ6YqW/TC3sKJWL2+cQ2V/Cjm1qpnO4CV1ZGc3wNqihzCbvOlhxKy+g1XBYJ98qNTzZe8lc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 340e1793-6070-445c-6249-08dc84bf2748
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 17:52:51.4001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jdsNuhwl5ULVwQyWBpxx1gbZsAHe1W3aOJ57bzdtjH6aaJSYjExeTqrQWr7P3FjaLB9IG9jTGDb2Qmc0kufVyGBr62jlf67ukx+Bw0KYXUE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4796
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_09,2024-06-04_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=919 bulkscore=0 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406040143
X-Proofpoint-ORIG-GUID: XKbMdzvDxn-0ihDs6YXx9nwAwYm1FrQJ
X-Proofpoint-GUID: XKbMdzvDxn-0ihDs6YXx9nwAwYm1FrQJ


Shrikanth Hegde <sshegde@linux.ibm.com> writes:

> On 5/28/24 6:04 AM, Ankur Arora wrote:

[...]

>> diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
>> index 9ea0b28068f4..06e13e7acbe2 100644
>> --- a/include/linux/thread_info.h
>> +++ b/include/linux/thread_info.h
>> @@ -59,6 +59,18 @@ enum syscall_work_bit {
>>
>>  #include <asm/thread_info.h>
>>
>> +/*
>> + * Fall back to the default need-resched flag when an architecture does not
>> + * define TIF_NEED_RESCHED_LAZY.
>> + *
>> + * Note: with !PREEMPT_AUTO, code should not be setting TIF_NEED_RESCHED_LAZY
>> + * anywhere. Define this here because we will explicitly test for this bit.
>> + */
>
>
> Is this comment still valid?
> I see that flag has been set without any checks in arch file.

Thanks for pointing this out. There is a typo in this comment.
Should have said "with !HAVE_PREEMPT_AUTO" instead of "with
!PREEMPT_AUTO" above.

So, an architecture should define HAVE_PREMPT_AUTO only if it also
defines TIF_NEED_RESCHED_LAZY and whatever else necessary to support
PREEMPT_AUTO.


Ankur

>> +#ifndef TIF_NEED_RESCHED_LAZY
>> +#define TIF_NEED_RESCHED_LAZY TIF_NEED_RESCHED
>> +#define _TIF_NEED_RESCHED_LAZY _TIF_NEED_RESCHED
>> +#endif
>> +
>>  #ifdef __KERNEL__
>>
>>  #ifndef arch_set_restart_data


--
ankur

