Return-Path: <linux-kernel+bounces-191572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7568D1104
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 02:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B255A1C21746
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 00:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A57F132494;
	Tue, 28 May 2024 00:37:11 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67FF6F08E
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 00:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716856630; cv=fail; b=c5kMvigwyAk7fFeekbNFQZuutuIHy2EhsEKbVNvcS6hjTNVq4aMfYfr3Vz0kfvnVCDTpvwO0xcNYiJjJG8btj7QW2VWyPX/qedIxD8QsM8fK8D7mh9iomJVn9jUWOAUDsnK8jPqoi+Ojceeqljvm8du56ONXBjbx1VSstIh3UR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716856630; c=relaxed/simple;
	bh=hXHkzwWWOUuAqPF0DyTa+EsHAXTodmn+MHLeM+Ijy3Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pifLk1Hpv9nDYjvhY7PjgirKE4q7zY9AfELBLCDIN6Xddo6mjGO8BEy1ffpy36ryapgTMtPMJB7dumULm8dGjo4x6ulb6udc5WD1PqQaJZ/YdJYNZJkoz3l7NeEKuudAqsooxysQR/iajxfG7HEjowpC7zM6Cfi1zCqr2SdpTp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44REO8XC025939;
	Tue, 28 May 2024 00:36:50 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DJMn2ecYYBoWtIlbNIVynYrtc9Wkxo+prgoaPHIFnEv0=3D;_b?=
 =?UTF-8?Q?=3DYe05VhHSXLQSeB6LBeY2zQ9OPa0K23e9l1Ep8Ab9qPqy1YhUtI5iuNqJUeEj?=
 =?UTF-8?Q?rAHpfWNb_h5pKEWGJZt4nyjzagVsNzX4N6XtuxzboBSu6npb2mvaZyTl2ygFiHK?=
 =?UTF-8?Q?378IWzcfPh9342_IF5WuLF4wJgkyIQY1rMC1QmuDymngViOo7KQKfdrP7tFH8WP?=
 =?UTF-8?Q?rhY75bLvrbx/3NTshcF4_VadYmQ/iwj8Qwj5jAhIJUcprPUDXyYWnSlHwge7IQN?=
 =?UTF-8?Q?0MXL9Fq6Y/PxPrnVuC7tSoB9nr_GjDN+tiVkBXYoqn9dp4saQfAgcZspjhyKVmm?=
 =?UTF-8?Q?gqJdOGK2bzLiXzTWrjR4otZ3yjGUjn46_4g=3D=3D_?=
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8kb37rh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 00:36:50 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44RL5YJc037288;
	Tue, 28 May 2024 00:36:49 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yc534rdy3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 00:36:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CgEtQVuFinjhiKNyWipzw3BteK8MYQitp5s8ljQsd5xqwF6HY4ozZfl9KZaXXqAHwkwGhMNIlb6xMVtaRPlHqnZtKNEOY4bIBtMAgmNuORahpOFGj1apV52uS3DiNFqIMTVvKrhQihTtVcctmIACVIFFNhCbUQ42L1wwss+iB0ldWHOVES/vf3E1roqhq14G9loViORqXPHShC+X+d16p9i8TVWZagz537PmIvBBWeQ4JxK9gBx1ufpqHcWi/ttWPKso8WRqTVvbziq+jNpvOvDv8D124T43D6nIMGqoAMxV6nDb967+iLvUIoHCgmDpHgD2q5hVAQYuzifLszJQNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JMn2ecYYBoWtIlbNIVynYrtc9Wkxo+prgoaPHIFnEv0=;
 b=OWxj4TIDSmMMrA21Z9r4yIcSJ4jRDfD70kKObYJvfblBzJcFcWabb03F5lHRIPwSES5N1NsaYTom6aUL1+0z20Ug9UiwXWhfJ6X6NIVZtHM1+x3kllKn/FJ2Wl5Y46q/3eJkSgRAZGcp1oj97sVJSBQkEfcvhaW+SZLBoiwEi7SgUshae2pZix2BSTKvY6HWdQ52YSCWn6YEXhUaHs++dR+ZQUXkTnYGTqWMT8DPQ3lEJ/u9D5PjsjQJVqp0S7V3F4YuoaO3EEueP3p9I76ieLTYfr+KEct9NvNBm2nP3Q/UuqMHk+Bu0BOmR5V2Zc90Fc2lbE6icGWB4/IoUv4uEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JMn2ecYYBoWtIlbNIVynYrtc9Wkxo+prgoaPHIFnEv0=;
 b=r87R9hXTp1gsC2u8f3YFaftK5GtLqI1dfHl6v3ptqBDwuRLyiz0a0ExLKhfUF2XEXXDfyOiFkoXvnWWclhZ0hpOD5WBljoGUopwc9WzcmPAwGBKa/JqD71KtlLybRUgtTIy/6JyDvwte+R6sbhQTMDSli/jYU+ypAwCJby9sIv8=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS7PR10MB7177.namprd10.prod.outlook.com (2603:10b6:8:e1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 00:36:47 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%4]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 00:36:47 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, rostedt@goodmis.org, mark.rutland@arm.com,
        juri.lelli@redhat.com, joel@joelfernandes.org, raghavendra.kt@amd.com,
        sshegde@linux.ibm.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, Ankur Arora <ankur.a.arora@oracle.com>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2 27/35] sched: support preempt=none under PREEMPT_AUTO
Date: Mon, 27 May 2024 17:35:13 -0700
Message-Id: <20240528003521.979836-28-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240528003521.979836-1-ankur.a.arora@oracle.com>
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0233.namprd04.prod.outlook.com
 (2603:10b6:303:87::28) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS7PR10MB7177:EE_
X-MS-Office365-Filtering-Correlation-Id: ec331fbe-be2e-4bb1-c293-08dc7eae41f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?fu1zVSJL0z185NBgtEWNJFTpigkIyG+Vj0pN2YD7iSVUNP85n5Drt9UL83Bu?=
 =?us-ascii?Q?obTgxE+5Dtq0bkMOE+V1JskRUXvoY3tljsHCUxugEQhbn8mMm1/DYk7uYGzL?=
 =?us-ascii?Q?urIZuFQVJ28x8RMQn5IX6+F15M1S6lpRHbnEEBoaVipuYVdyS+sSCDoYxGNH?=
 =?us-ascii?Q?Zwfh8ODe9jg7od/4XhWXT8J3Bytva4JY+BbuA8bd2TQfDlueMWi+pP9QyqIK?=
 =?us-ascii?Q?ejuZixJ58P42Ttfn4gSouLqbCym/fYqvB9uFRh4oW2CfuCgrQLv5agFjl0Oa?=
 =?us-ascii?Q?kHRUdUb3xxM1qS3ost+Umihf6JE/Eh3JPtcKgDb5ZEC0X2V0ZqyDl3YP2FjX?=
 =?us-ascii?Q?h2dmP0cvzEBqQUg+RiZvyr+16X8KebAQlk3t7IN4fyBgXZ0hSGOh30GQi1Br?=
 =?us-ascii?Q?uh/zFl3F1yDv0l5HJeCdeSONvSlsHFBn7tKmIl9FfaJEu6Scxlgm/d0zE2ld?=
 =?us-ascii?Q?zMUz33gDkIdJeXzBU9nJoDr8//S4PKpVyQWwS35P1sYDssEJoJIpjDuSOqE9?=
 =?us-ascii?Q?zeRpdzuGJ2hm+9MnIKcY0czQ4WLXO/9LSPMyTdLbNWOaYOSKC0T76VOeUfAc?=
 =?us-ascii?Q?3ZKAizEYP27PQs/B4pY7T9T5fpxFpT7aOl+Zcj3Yb/75Tnt4ZJ9h8SJRLLAD?=
 =?us-ascii?Q?w0lEc58SlLiaLRbZRmUI8plEuNS/s2t/mMBfZJMqBUSFD421Jj/p4DDFxnLO?=
 =?us-ascii?Q?mnvvKA0H6ATybmISoW4OcI1R9mNa/WumQgDlRzAqcPKDcLuq9uZdjLb3Pjsp?=
 =?us-ascii?Q?fU1uo0EvSTVLVq1hyy8VY15nGfvz2EpkPz/8KL/mIkbSU9eTJWk8ldVL8Wu/?=
 =?us-ascii?Q?4/5zW3TtPdTlXrYjYWw4HvFseBfxYwPwW2zoyAE/HeRHd3AN/0a+xGr0Q1Qu?=
 =?us-ascii?Q?tPEwDbLM5omSDwXfdDgFrdaGVmo2iA/+xx2s77gtLlG5lT2tNvOg6TjTYRa9?=
 =?us-ascii?Q?CQZrPphiRj6+AXXKdKULjt7gIk4Rvsn6jH2X3XYIAYf/0MhsJ7M4Jm1XtgqB?=
 =?us-ascii?Q?z7zPnFryQAa0lwCppbw4uIpMNx0aGxltPw70i+PDB9HYk+WQAxRPQmDGQ9CG?=
 =?us-ascii?Q?3YeGgzmcMoS8Sh1I8hrlnJWeGdyJWZjlkcxErbCVV46XNZWZkHpynDEXiJvJ?=
 =?us-ascii?Q?dvTdfcc2zXQMztMXVhU1vqbzzJF88O+sOLhZX/rMqwg1hB+62jJx79mGBlPt?=
 =?us-ascii?Q?vuJ3ABPusoCLqkPVEhyJFVqKTkR+yGEMWwz59g=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?uvODp1dGEtgPYAvbJ/XrB6Rd3A8y1WngNW2PmxHMmzyTMxw4TA+vrsYNf/Kc?=
 =?us-ascii?Q?n9rPehDILyDbl0Nhn4Jd7Spbl7qUxq00Phycd5Z+eC56q6my/0gyxzzzf5bC?=
 =?us-ascii?Q?5EDkWM8s/ke/fYTkS5fB1kHsw9rpQ9dgkMGSSCc8oiFCK7G6cXrlzrf7ZJT6?=
 =?us-ascii?Q?++voxryM+nuWRX5fDxByt9QRHck5EVQkwmn/XxL4aVUacFptzsfILLSAsqKB?=
 =?us-ascii?Q?EO7+4v4LDKSSlyi8nnSn/qK6zxZ2bQ9XlF5mgiPtVJWuzv0MdWoZnSUHcD5a?=
 =?us-ascii?Q?w5Et/UUUdIUGfekEfB/yfS9trcXdsFuGX+bF0wQahK64oMBV19rlbk8Ase6x?=
 =?us-ascii?Q?AObH2oD0dKE/0Kc5GljTB/3DVPdORU3xG3rTwhURZUaRYEoQ3RVNX5ykVG5p?=
 =?us-ascii?Q?avQ36r/EG91JDsDEw/KXctjo1ragBWfnnxdownqPNs8cVY2LSehvuAGHAblL?=
 =?us-ascii?Q?H7KHoDdcri7ooBOhdUFBJmHlymMhP2Nizr87cbShRig8Ewpvy60IooD2EPyv?=
 =?us-ascii?Q?vBb7KANEbB15X3DY8rTIX/1OjuxFOTQdgYboUaXCbOExgDgT5k36vkdOieMi?=
 =?us-ascii?Q?mVGQy6I6XnS1qH6nf74mVmnqlVVJnlTP6Wdj4ZmFlpZ0gQdsx6HoRxA3I4Xm?=
 =?us-ascii?Q?5JO7xFb/fn+xPdCuq6ajfPvbZGrnTW8Y2i3KSN6phajvr7J1KU50wlDd/wB5?=
 =?us-ascii?Q?c4Tq6s8cSSmHHD2H4vV2TRwKdv/7hqwF92SAe8H4zFaD3KWdEi6ehUBwJNnZ?=
 =?us-ascii?Q?Wn8f6KxtLFcIMMSVlZAZM0kVF8PI6uKNDsoFR8ZxGc3d7CqzomlYC+hBCNh7?=
 =?us-ascii?Q?0ZrQ1HISlMP8d/ohlxs8xAjyEdZHeBgOkstyLMgEx7RawYNLjBjeknOrvrnc?=
 =?us-ascii?Q?mdr21DbDdagyKxmvMwJTkCe9ETICjtyc0Au33RULR327/6ibMMkOA/QGb457?=
 =?us-ascii?Q?TA+uW3YmIAzCjif9LVFZGrWEExVQlFFjqq5Y6nwFBgqZgVcR7dpNLugx5JdD?=
 =?us-ascii?Q?psDFDEc6VRBg003sbUYnKUQUQJiXvqAOo488XaoTopfnWGHWWbWtHcsFWxSL?=
 =?us-ascii?Q?DS1evS5ZiK3sPCU+3PbjNw98/eAIYKyQ8kumB3ndaasPnHlMkD2M5DTsK31X?=
 =?us-ascii?Q?mpvFvVxwv78gAeXBAZ01moXLwFe53U3t8Nkk7hFHwe8f3FqrZ6A5rxR2pHG7?=
 =?us-ascii?Q?WJVIBndKR0RWBOeElQCmVaym3wZd5uZpsdPjOIaM+2ZpJK//CIdik04BGoDT?=
 =?us-ascii?Q?GlyFF9+py5P2jC3i9lIOn4yW4IbVpusSVG6tkqD0zaBm4R22VZxGd5Y0Zd+I?=
 =?us-ascii?Q?BC1eSF9iqewlGTZFlseH7a37GwVNK59cFxZk9b/qnLN9FQsiT/+VoOzd+1iV?=
 =?us-ascii?Q?jPEcyp05Durvt8OE+9ARPVB68L8V9z4H/SN+8lehVE1rwZGDIlhdixyHdqjm?=
 =?us-ascii?Q?b4mUGo9wYWwEBiRE1qhI5UT8BqfNtKp6EXrzmNfOyF1my+j8zVkQkD91NBuD?=
 =?us-ascii?Q?k5p67xhRcGGGXej0m6MTyOUbW0UZBHGgkSpXtDkKDRLyq75mUOs85aUpoxRn?=
 =?us-ascii?Q?euaafhNn7LJPYOyJLUAjuOqNve+kNf0omcyb+Dikf84XOel9DfVZBkQ5qtbn?=
 =?us-ascii?Q?Mg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	URn4w6lNTUszi5N4/XB1QQhY1S8uAChdmUSnnGQTlGHghY6CgcOFr8ixNeO7MQbPc4jUCkefr3oLVtkz7Y0wtnonow9SiDpilejU8GLeZyXiToQp9JzcinjewXpxS3pfnrcleeHv0O6TF8PDkfDz92a2gk8VrWUgN/3yYfZCNzp2YiWd2VZeroMz8gMBBjyk+/vcfzeYwbGKq6DHnp/lLoDILVemY4+9zJiFPwV6etja3lIA4tQRfn42TxT8zjZUc53QuvgHkSF7Ed7kFr1403Qo0N6BzIz7sLvHRseqzpFigWwQjUHv4cY8sDv7f9ZDBC9Kd8Lr9A+eSHbj2IkEgJBTobwQjMfzz7rtfZdf0Y5DnMWuN8wbJ4F/3tyb4UPNwwqcUOsfDO1IH0i0J4y4ew+eETTbw1EnOA7/gSy+ZFRbWjA8plWJ8j30gV7RjRpqX9K4ryAldIRbBZrlwCuQ29+DapGgeTTSDzDn/K5uqUpK9fF96tEnbOrjiMHCwp304lYf/ufCtf7BihxWuIpAcrm00tvxzIfQWZO0qR+g5xiIToFrAQrc9I7Y5laqFSP4cljjrY1UCGL+jdJcaT2VLYjs3XpHKy2dTqBuqxBNKG0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec331fbe-be2e-4bb1-c293-08dc7eae41f0
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 00:36:47.6857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b+cWVn8aGU2d3GeFTKI66FUoK/sLq8uTHCyQn60If0aZ1PvAG/W+v/A7W/5F4t4cyaLRHMpYRewaO3XHFkVHFq5N6fIJatEXHkz4yJOCtlQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7177
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-27_06,2024-05-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405280003
X-Proofpoint-GUID: slSKCrZ9TwzEFCoomCc9P_MakVGV_Go0
X-Proofpoint-ORIG-GUID: slSKCrZ9TwzEFCoomCc9P_MakVGV_Go0

The default preemption policy for the no forced preemption model under
PREEMPT_AUTO is to always schedule lazily for well-behaved, non-idle
tasks, preempting at exit-to-user.

We already have that, so enable it.

Comparing a scheduling/IPC workload:

 # perf stat -a -e cs --repeat 10 --  perf bench sched messaging -g 20 -t -l 5000

 PREEMPT_AUTO, preempt=none

        3,173,961             context-switches      ( +-  0.60% )

           3.03058 +- 0.00621 seconds time elapsed  ( +- 0.20% )

 PREEMPT_DYNAMIC, preempt=none

         2,942,664      context-switches            ( +-  0.49% )

           3.18924 +- 0.00483 seconds time elapsed  ( +-  0.15% )

Both perform similarly, but we incur a slightly higher number of
context-switches with PREEMPT_AUTO.

Drilling down we see that both voluntary and involuntary
context-switches are higher for this test:

 PREEMPT_AUTO, preempt=none

          2286219.90 +- 39510.80 voluntary context-switches   ( +- 1.72% )
	   887741.80 +- 20137.63 involuntary context-switches ( +- 2.26% )

 PREEMPT_DYNAMIC, preempt=none

          2125750.40 +- 29593.55 voluntary context-switches   ( +- 1.39% )
           816914.20 +- 13723.46 involuntary context-switches ( +- 1.67% )

Assuming voluntary context-switches due to explicit blocking are
similar, we expect that PREEMPT_AUTO will incur larger context
switches at exit-to-user (counted as voluntary) since that is its
default rescheduling point.

Involuntary context-switches, under PREEMPT_AUTO are seen when a
task has exceeded its time quanta by a tick. Under PREEMPT_DYNAMIC,
these are incurred when a task needs to be rescheduled and then
encounters a cond_resched().
So, these two numbers aren't directly comparable.

Comparing a kernbench workload:

  # Half load (-j 32)

                         PREEMPT_AUTO                           PREEMPT_DYNAMIC

  wall            74.41 +-     0.45 ( +-  0.60% )         74.20 +-    0.33 sec ( +- 0.45% )
  utime         1419.78 +-     2.04 ( +-  0.14% )       1416.40 +-    6.07 sec ( +- 0.42% )
  stime          247.70 +-     0.88 ( +-  0.35% )        246.23 +-    1.20 sec ( +- 0.49% )
  %cpu          2240.20 +-    16.03 ( +-  0.71% )       2240.20 +-   19.34     ( +- 0.86% )
  inv-csw      13056.00 +-   427.58 ( +-  3.27% )      18750.60 +-  771.21     ( +- 4.11% )
  vol-csw     191000.00 +-  1623.25 ( +-  0.84% )     182857.00 +- 2373.12     ( +- 1.29% )

The runtimes are basically identical for both of these. Voluntary
context switches, as above (and in the optimal, maximal runs below),
are higher. Which as mentioned above, does add up.

However, unlike the sched-messaging workload, the involuntary
context-switches are generally lower (also true for the optimal,
maximal runs.) One reason for that might be that kbuild spends
~20% time executing in the kernel, while sched-messaging spends ~95%
time in the kernel. Which means a greater likelihood of being
preempted due to exceeding its time quanta.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Peter Ziljstra <peterz@infradead.org>
Originally-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/lkml/87jzshhexi.ffs@tglx/
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/sched/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2bc7f636267d..c3ba33c77053 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8983,7 +8983,9 @@ static void __sched_dynamic_update(int mode)
 {
 	switch (mode) {
 	case preempt_dynamic_none:
-		preempt_dynamic_mode = preempt_dynamic_undefined;
+		if (mode != preempt_dynamic_mode)
+			pr_info("%s: none\n", PREEMPT_MODE);
+		preempt_dynamic_mode = mode;
 		break;
 
 	case preempt_dynamic_voluntary:
-- 
2.31.1


