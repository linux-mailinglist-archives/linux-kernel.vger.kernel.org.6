Return-Path: <linux-kernel+bounces-191560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE938D10F8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 02:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 706831C2175B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 00:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059B610A2A;
	Tue, 28 May 2024 00:36:35 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90B0446DC
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 00:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716856594; cv=fail; b=qgm8vW6bIjSOhsIubd0/VXs+OeGvVeQ3iODooP6Yz0byp0XF3jJWCqMSykIpmPdDqaaRvJb94OH/9WUSQoSUXcvQDhufTZ3MKM7NmTQzw+f1jnqkqW+Ib3IVzeo8aYfi6cGwzL3claDrAMb3R6gnV4Ga5qwSqBRWhA0X7/rgNCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716856594; c=relaxed/simple;
	bh=GJqiYwoAIuNvmvIwhRut329Jg/nRaGIIDy9QD8bgqBU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tFI1H7yjH+t+K2TCGDlj5hSStZaRYZKlyaWLe4obSirYi/r/WFiOpap3yEmYhtwXvlisTC65Mjb1QGdHoKtqyUk68Q8lbIXodam9FUktGOGQE3rM4g/XuwjqtaNaN/Newws8nUEK18j2J4OyHjSNfMf15CMdLem/AkX9b1Q8ao0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44RMulJi022228;
	Tue, 28 May 2024 00:36:17 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3D1oBBDMs4uDHKnlauz8aqndzdR6p4WisYnzokQGLMDVA=3D;_b?=
 =?UTF-8?Q?=3DAoy6J6nK1dWDsPpH/SBRr261ePxgO+s6zxhR9s5N1uCfrCYVym8ouxIYabNt?=
 =?UTF-8?Q?StiSa9aa_g/9vjS9+frrFqVeT9XiQqJdqg6cqaVyMqcXz9SBU3VUcsdkPoCGNLp?=
 =?UTF-8?Q?4nbAns8tUeNtrx_zvkmSZAySnEluFF7r8FKwlrZPm/d9UEFT9Eh3KtcyypSArtq?=
 =?UTF-8?Q?CggzwwTQq/4PteNuhbkN_yERI7TcmBLCeiPuHnUfpAV20lGf9F3Q8Qw8LORnZ92?=
 =?UTF-8?Q?NfizzP6rusMhxGYnWb6yqlyoYd_OU9S4gr+WdlJt3jwQHaBO5qYWNXQF5awDpNq?=
 =?UTF-8?Q?DfmhTnX7GIMbFCdn9/yBYcpZS9Oab29q_WQ=3D=3D_?=
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8hu39dt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 00:36:16 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44RM0RZm025868;
	Tue, 28 May 2024 00:36:16 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yc50p7xpy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 00:36:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UugXgDUAwm3sWNpz0QYBQ+aB6HnmcFVPO0f7ABpGIbB/xr/CBRrSGGtIH9s+a0dowSwH/WCz1J+4ei42vsKdy93YP84uQ2hArVMQX1EKx74cldZ9UHPOFJ7gpvQ8eWNCMstrnHZjjPwDr5E8OQb2bha3QlpjtljypCDwq9lcVAv93Jxp3yrvJk2IjaQvilEYjNK05ZJj2kXNhVJ0CXueDaUBKc2hzX/3fOkKp1GPsbZZJh1dOmkXzr/XlMveQfOzHj9EETHJh6igkmy8uC3BBVZr2wjSF2yzcztKDk7oV8ecWi2E+RmAwJMWAAYMmjxvaiQMF2hmf5NnTYRaIcVw8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1oBBDMs4uDHKnlauz8aqndzdR6p4WisYnzokQGLMDVA=;
 b=WB5SDPFemPI5+nROBUVK/TwOQw4pVeI5qo/DM6+t24IpDvNYZddSEmUBObh1MrwYllhOPXQ1b/sP71++3N8adQPLYoejcw+iDRDE6D6XCUaQAIOHYykV6FZSj2iI/+Cpu46dC1SLdZsjh0GH7D1M+mdTUyiTxJA3tLoJnuAV4dpE5e4fZXiGWxILTapja22fzQt2PkY/ZXFT0zQX9IXfxME+MCGJ2zFG1UwLnzpEceVYZTj01+p57bxRQqUXL8uKCNeo4kDzC4lb2UgI8/kfzlQ8QdmnsAtUxLnhpSfpiYtRJoMocjWbKuwO9IS5lC1nWN98yYvNOs+6xMxH6ITmIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1oBBDMs4uDHKnlauz8aqndzdR6p4WisYnzokQGLMDVA=;
 b=TzSHe+cwfXiVpi+GiG2t064Rrjwc0mh0mkFUGGO9jZ0hR9pds4Qb3EataSTrgORlRlHGWWLwZk88zCFVvqSnk30RjmeqVqsEkagN3XnxWsgF6wFUPdRD5I/aXK/YVCzG3BfWBkNhRW4GwBPwkBE/taedlY7L60i0skPmXGPue4Q=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS7PR10MB7177.namprd10.prod.outlook.com (2603:10b6:8:e1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 00:36:14 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%4]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 00:36:14 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, rostedt@goodmis.org, mark.rutland@arm.com,
        juri.lelli@redhat.com, joel@joelfernandes.org, raghavendra.kt@amd.com,
        sshegde@linux.ibm.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, Ankur Arora <ankur.a.arora@oracle.com>
Subject: [PATCH v2 15/35] rcu: fix header guard for rcu_all_qs()
Date: Mon, 27 May 2024 17:35:01 -0700
Message-Id: <20240528003521.979836-16-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240528003521.979836-1-ankur.a.arora@oracle.com>
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0170.namprd04.prod.outlook.com
 (2603:10b6:303:85::25) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS7PR10MB7177:EE_
X-MS-Office365-Filtering-Correlation-Id: 4984a1e8-89aa-49b5-829d-08dc7eae2e18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?RAk7puRw7zr7XRYdA6ZXt99khjN1H3jBCXAw2l7d8TEk2W8eTBfcH8jxTlZR?=
 =?us-ascii?Q?ewFc2TyL5k7PoKjFMkxJCOy5jUu4wBDNFsJ1Ut+sdZzl+x8CbmmtA9RcJ0P6?=
 =?us-ascii?Q?C/4tlyt8CxyiRr/LgQ3Gy0ZQ3qcDUO7IyNlj4gWMYUhy/er3b8nw4bSAbg+l?=
 =?us-ascii?Q?95NyZ8SJJ9eqY19Ff/VdxtU8D+VAkWJGJZ+8/SFGFUfczgrR+shDyt9I1z7U?=
 =?us-ascii?Q?Yew5mXDijKWIVeNUmYVcnZEMrLiEWE1HsaHlCJtnvLZpvF15gGbeLj3fxfBC?=
 =?us-ascii?Q?GnTFsqK7K2no1MRW4O206bmxzpTwmcw0mDPUH6vlmKsZTQ/7BWRyAeJwcoXn?=
 =?us-ascii?Q?MTS5KT9acqU1gAb0sM0S0k6Gddh8ogR6U4v34hn0Nuz36wYtMe4EfPAAJvEp?=
 =?us-ascii?Q?yFWSDfdQvQ6cz2k8REIcRo6bZxkE4CO1N/a7TmBB8PZsiJCBPoNkQYFSCcQo?=
 =?us-ascii?Q?WNWftjheSH9mqqM4TvFIsFzvaTclZ9ADyhGhQbTFnhUFrxlMW8Hq6ZUwW7c2?=
 =?us-ascii?Q?ZI5eUNNgsPA5ob+7VTJxjBWjX3Ok9vb4spsxY10TSVUvq5zHEPmjTnyKB4+V?=
 =?us-ascii?Q?pFh9G9frHVFwEGnvCU1FZqZbpDckiAwckhYSqG3DAJRSgDKVbsgQhOg73EFZ?=
 =?us-ascii?Q?3cvnGBLM7GoqG3bApoXsLBjmXe+NBtMZ6aHM+WmO8I1L0nBHjNQ0nn0mhTFF?=
 =?us-ascii?Q?O9drDewphDkIscbOrzlJxGl8J2UcNcm7ApaQRFZ3u+Ta/n+mPhFsLtAeNA6E?=
 =?us-ascii?Q?PNazmmwfzj7xM/qSkoOSlhZ04Dz9QQgOq8/GKTBfR8PEIRaXgrBdicuRppBo?=
 =?us-ascii?Q?cJXt9S1oOo++ILGxN1pt8Lu3UvJgACqOGA63rcs3pP0uFSFbf9+dieEnJTos?=
 =?us-ascii?Q?ZPK0Q4ZEMQYU1ifIQe2Oylxk0m4pVo15uRlkvM1BswpEIQBXZhSTsF87TW0y?=
 =?us-ascii?Q?mIG9LjbemnztcSVStL6JLU1H/ZYbUoqZt/57M9D6YXHoyp6V2HMYRkMSytu4?=
 =?us-ascii?Q?unudWRyz5PcX/TLSxSJIbXgT0gQwoU3WJouf+WteLjCphjPByNXxPmpeKbxF?=
 =?us-ascii?Q?yUpccu+p1uK5aYbKdRupExO8AK1KOcsqLJcteFi6PMF6Iu0OaCRzo1AE0duL?=
 =?us-ascii?Q?r9YEno+EyJyhD/Q7JyNKT0acAHZ8WddhE+tmZ7K2kLwEuv6T/+d2xxaQYFJ3?=
 =?us-ascii?Q?d2/CjGonuguFZh41UlgOOCHltpmJ+bx3GfwVzeBrdUVx6dIZcC8wVm5DWavD?=
 =?us-ascii?Q?6mPY065dzvIuk/cqHMjiXuUpOqAnbGloaRp3Ik0k2Q=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?5toMm9k2AWe0TXEazkI0/AWU11D4NRIhbhQQd/wJrumLkWcZv5/VgZ6yF2xV?=
 =?us-ascii?Q?IQHzVMXlSxlBXLJzx2hsYZT/AitGkGlNuhqR4dlb9uck8UoASOL7FvjWt7+3?=
 =?us-ascii?Q?lYLvQtHwmGYBWPGFvYHLbhkKJpT8hW5FOZwYVBiXlFrWYjJ7IVjUJE31oDet?=
 =?us-ascii?Q?l+c5hHcdAT89607Gvg6QC6rwaN3WN3+8RC8vz0sPPBrWYjX5nkD69GfJsKTh?=
 =?us-ascii?Q?Lf1YDA1JmOc/Fm7wMxg49fBBqyNMz7JO9YmReVpOfS0PWcVeUXJ6bn7VUbvS?=
 =?us-ascii?Q?mngs0R0H689TPvmLaVX3ntvBsEjyaCZYqixwht6Zl5U62ogWuKnDPN9roCvD?=
 =?us-ascii?Q?39+VnZ9/Xsd63xNkku8kQQWC6mASFN1yKqmXGQ6ls3l6LCKSZoTBZuF5BsM9?=
 =?us-ascii?Q?tkXdx9l9ZJICH/rTvnPZnqw+oCyU1oL2fY1frL1YkkTz43KkV7NoXiDfXwpj?=
 =?us-ascii?Q?0/ZdtB1qOysHFBdZImBrHaD7nhfvWwpQnJ3pYT1O3Fqi46KPFAko8VfuPKEG?=
 =?us-ascii?Q?OLRZjwuRxIxKwaW5SAbJipI+Zw0OZ0SzV5bA4UkShjOi0x3koPJP7cEl3ww+?=
 =?us-ascii?Q?s4hwUWHoGmVYFFLAwkpjtHrL/DI0RbxnH6wgY+JVH2SM9VjexqN6I7fRV1f9?=
 =?us-ascii?Q?DjWWkqt9RHLg3hWYYpNND0Q6RnR8ll0jf0w2CgD04i8Zx6NNg32PjP+6+Jfl?=
 =?us-ascii?Q?i85T/yvsHXCLnXE16wIfUoB+9TCPuGh+P41Q+8FVQh8ra33z3pcUcy6vYmb0?=
 =?us-ascii?Q?ld1Ylzm9YIWADr7aj4g/wvRaCt1CRXciyxYyTQJGjlmbzRAFHkCkAEifG5XR?=
 =?us-ascii?Q?WaXTd+jNsw3XMCP6Nuh0ewEqAjUeEeMfiCzluynmHN5Tjm7VWya126FYVEkD?=
 =?us-ascii?Q?j/TeEA4dlekbsFqpvj5UCfy/UbmKEgBBNwTshU7BqqzPyxUSIkGcoCqD7ZPv?=
 =?us-ascii?Q?zDzzAKt7+krQsWd7OwWzU3AN91j/sLGr/2uDDG46KZvhgLyEaJRBR1khitH7?=
 =?us-ascii?Q?EUIqBNkl0Pm1eW2NnwI5lggia/yBvnCW+Ou0XA39GUn/PSJF14F5UVPh+YcD?=
 =?us-ascii?Q?FRwkfEhYYuirJWyxt/ZHyWYk7cZSbhQUeCyQTPh37bqfeluzP/VcJHv0iOgF?=
 =?us-ascii?Q?7W6Y045tl4KNcn+qwCb6+X1psU1b3Fyzvc6GddkCVqfgVDRV9aeQr/FrsZ5Z?=
 =?us-ascii?Q?CGpRreO5fOpD05E9EW0gdgccpKiqCwZcRHMaizcLYfOHcz72wOjJl4t23vjy?=
 =?us-ascii?Q?xtwlyRJq7W6vOK7wQArcuftTT8kzO8bD9JvsCBQwA1eZOEP3E6v0ERzVkOI9?=
 =?us-ascii?Q?AoLs3ZuI1cV2YpnuPiX3/+S5tiobltV67ZyVJzUxKDNf1j48YMUpgXYckphK?=
 =?us-ascii?Q?yErpApXUXA/Dh2i0lPjt5SW4fgGZn062ZzT4Dh3ijGUhMqLtuWc30BU82N/P?=
 =?us-ascii?Q?/uVQT8Um8qwDzfZZweAJPSSUooNwJk1uTf5puj1XW5/DG79nJL91Zm9rSvQZ?=
 =?us-ascii?Q?Fn++LdYZpuV+DZukSEAWHVKSuvmfJRUVuDEOjhuER/Mm4Tyoc8fznfZF0DnE?=
 =?us-ascii?Q?zku9l7Pox7LzdL9nbtXYNDbvMxSs3jpfHjxf57zw8U0h6ucLwsxcGbm6u6c9?=
 =?us-ascii?Q?6Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Uh/Jll4DjYvtJ11HEdb1jrVxv1RcuvrWtoHuuPeMKFbCdlSBywYgSpm5wK0pXj+1weFtcjL2YG8ca1FNVy3TM4mg7zcc1/yZZoVLjwqH1ikX2PddkwBvOE4X0GptgXFX1sZgFU0MXJZKD88lX0owHZ8F7VJXJWoR1bzjZLAG3W1AORkSDZwG1aiJZ3729j9YySoytckwGM7SPBHS7UatR/mZstJ5ZIW65RAsmJ3eJNeftdjymfNHQZ3ka12gAvVZSMOrpAnFO4AKqI9uDOnjs+94WBh8bCEbZlgp91YXrcd7pO0hZeUSUokRBnnyZ9JV64dua0mReJule2NPTTCcdSZqV1p2Rw//MBKHent3oK/14mleliV20idaVCK6/c3m/ZFuKchw7gyNSdnLzDP9tJGJwAjr3NnFD+Z/BCg2PcBozU8i2tv9KUU/hERtm/68U7rPUpjxvTABO3Ybg/1/SV/EAReiwCwgqaECBKndHanY5/g2t951bW2t0Hr0PQxj39inpQtghUUuV9L3XACY+4vvSrgCqI5SsBVgTNTjpqf9vIMwRUwZrKzJdbMaGmx+tNpE7KI9zHtWxJVdDJocfyAl3cohnz//OPtXa/kdN04=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4984a1e8-89aa-49b5-829d-08dc7eae2e18
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 00:36:14.3258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PZkTmb7x7zeTfqKq6zlICXkztXglfE2f68WRodLzDg3tE+SP3MDpTnqrvyj+3rD2FiKHl5dGBl9cFzfmn0wTjjARIdPWpv/YCForn+uGm9Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7177
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-27_06,2024-05-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405280003
X-Proofpoint-ORIG-GUID: QzSvQFYmhBcXGnW8Ia31a1VwneNLZf4q
X-Proofpoint-GUID: QzSvQFYmhBcXGnW8Ia31a1VwneNLZf4q

rcu_all_qs() is defined for !CONFIG_PREEMPT_RCU but the declaration
is conditioned on CONFIG_PREEMPTION.

With CONFIG_PREEMPT_AUTO, you can have configurations where
CONFIG_PREEMPTION is enabled without also enabling CONFIG_PREEMPT_RCU.

Decouple the two.

Cc: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>

Changelog:
  Might be going away
---
 include/linux/rcutree.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 254244202ea9..be2b77c81a6d 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -103,7 +103,7 @@ extern int rcu_scheduler_active;
 void rcu_end_inkernel_boot(void);
 bool rcu_inkernel_boot_has_ended(void);
 bool rcu_is_watching(void);
-#ifndef CONFIG_PREEMPTION
+#ifndef CONFIG_PREEMPT_RCU
 void rcu_all_qs(void);
 #endif
 
-- 
2.31.1


