Return-Path: <linux-kernel+bounces-195177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D8C8D4883
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 11:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 461901F24B9F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 09:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459C6154BEC;
	Thu, 30 May 2024 09:30:24 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7A11534ED
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 09:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717061423; cv=fail; b=QC4ouvpKJcvI7hTRuNnajPFv/NfkEyyIdD37UtUN64yy6H5RAPOKz9M9QuKND4woklScLH7GO9demYsYdI/o5T8Odp0A0H926yd7tP498R8Ue6hd1fslb2vmklNpNKDmnKQxOmNqOtjjCbNDnuFQrVDttA7ymJ5C3hg9xC+0nFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717061423; c=relaxed/simple;
	bh=4GyKA2u9Laz7gXMW1cB/ki1uGSmhyaYne7TdnSPo+Es=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=Mo9UhbWtYv2R2sZhio2SCe9CBZznugh/S4DDhncw4mzvYudpguQpuKquvba1cTKSEuFT0m27r0tMVe8+7GDuBkYAYIvHHnxRW2knngPoHm2DmhLhId3NyEIg6LM1LjvzFOBsqYMrXKxDJoBEgzvitZUioYnYDmm0bFOzLjP5mn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44U7nYsf002189;
	Thu, 30 May 2024 09:29:57 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-type:date:from:in-reply-to:message-id:mime-versio?=
 =?UTF-8?Q?n:references:subject:to;_s=3Dcorp-2023-11-20;_bh=3D4GyKA2u9Laz7?=
 =?UTF-8?Q?gXMW1cB/ki1uGSmhyaYne7TdnSPo+Es=3D;_b=3DWJLj6lTmevtm4GEXPpLsIWv?=
 =?UTF-8?Q?e2lBcvhEzSKWdTfRnxLuftzQuGNlTU+QRgB8NCjFPhn83_bHaPsaIM8QaCycIpv?=
 =?UTF-8?Q?nRNKIIEnD+rZ42xci2GKuJkDLOKiW/bMUHJoKlLDCrCXxYESvpU_1ygTkcAMsNk?=
 =?UTF-8?Q?5jJaeGdTM7omM/b0+uaAgPKnVpWOmdHXAiCqLDGMziKtkyy1DH/Yy4YYW_9Cfsg?=
 =?UTF-8?Q?PENFKK0kHeDKSmZksNw6rFbzKTv/+e1rpSfy7mtAJJ3dw2KlxZ9i1dfut2vt9er?=
 =?UTF-8?Q?_UAo4HiUzqDE1nwJPws1nnsrLb+s0FDnv4z0difuSA0UJOsyLu91AuvDqkA+sZl?=
 =?UTF-8?Q?uVuHsA_YQ=3D=3D_?=
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8kb8k5b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 May 2024 09:29:56 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44U7RgPO010772;
	Thu, 30 May 2024 09:29:56 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yc510c2sm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 May 2024 09:29:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aKXtuGNSdmJKAoMfCClCvJDrSBR16mDT3MgbIgBeAFB7JHeXfMv4ymePMD6wopqV8nQl3tcIK1Zz+MNZvGkufyLJ/NS2oMX65In+pmIWxRIUcmat3U1KtSJb22n9i5KMQsWo8Ss0UFcxPqh0jnBgSgbdf+kSF19iOeiPlqj8u30XWaUYT06oVOuu0bNRFJVJMxsMm2IiOT93keqCiRbuZ8td7AEKy+tm6J5qu6ELw1+k3Mmb/AIpfVB+RSCFpcSW6mTYcZre7xk6AbTeN+m0uP1pQVqHMYN80aar3xdPy0hTdtIyrAhO9YYbmBbsXnkdzR9PIdBym3vJF9oncWTTdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4GyKA2u9Laz7gXMW1cB/ki1uGSmhyaYne7TdnSPo+Es=;
 b=DdKi6V2Y0Po5DCDdaXhth5xnZqmId42/Knmgd1cBVFbrql2kuS31Cx1pnPtdjUvVuZ64QVUoatzgqTVoqadzfT30G+FxOdPvfq5RlL1SWZoQJgzXcj+q715qCMkTLchWAEJa4sA6pVhPAm3YC3cKnV5Sz4Tam0nsZ9fyeH9ZVMDVb7u6qIFddaaS7r/gM0ngRcGQPdbm31XUO0WQuXBBSXDZ4rWD0wl1wnIwchtikSOzK8iLhFDxgcF71kgrrcIMdB4vlSt3XaMRKF9khzVA6qaWJWqpRiBOhC4vomKKKBP1VNk0vP9vLEyplDus28Rl9iD0WkBy8lL//ukGKJy61Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4GyKA2u9Laz7gXMW1cB/ki1uGSmhyaYne7TdnSPo+Es=;
 b=zab/BuwoRigCosMup8iSxv4nOSg0neN/vlkys/cortzMpQq9XfkTyrO5Q9dOA5ogW4TLPJiRXMznKy9BDiW0IpIwn9/iiaaEGQBv845YzeL82Vfu7FwLZdq2lqW76uj7FuVQSveIo8W1pvqNjXrbkY/t1QVAOJHxGgRZTe+SCM8=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS0PR10MB6823.namprd10.prod.outlook.com (2603:10b6:8:11e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Thu, 30 May
 2024 09:29:53 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%4]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 09:29:53 +0000
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
 <20240528003521.979836-14-ankur.a.arora@oracle.com>
 <20240528162725.GH26599@noisy.programming.kicks-ass.net>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, torvalds@linux-foundation.org, paulmck@kernel.org,
        rostedt@goodmis.org, mark.rutland@arm.com, juri.lelli@redhat.com,
        joel@joelfernandes.org, raghavendra.kt@amd.com, sshegde@linux.ibm.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Ingo Molnar
 <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v2 13/35] sched: allow runtime config for PREEMPT_AUTO
In-reply-to: <20240528162725.GH26599@noisy.programming.kicks-ass.net>
Date: Thu, 30 May 2024 02:29:45 -0700
Message-ID: <87ttif641i.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0163.namprd04.prod.outlook.com
 (2603:10b6:303:85::18) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS0PR10MB6823:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bc31b6e-755a-48ac-54a7-08dc808b0faf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?qs4MJoNpsN98HuKWGuCc0UAtscuzwapUqzpwDUCL2F1GvHmEdYZA0I3qo0DY?=
 =?us-ascii?Q?xdXiCjiZUITAcSPsr8ST7wL7G5ehPZcuo+ZZdI0FXrfA1wk/lS8ebfdnDTbl?=
 =?us-ascii?Q?ubidHN/HmQ3/C78cMxVZ8vukUmX34kIZGhswhJMzpk3LarUcbKSZh8ZWKKDb?=
 =?us-ascii?Q?XJA5q+xrvz13ZcILbgeCCdznFCM5QxoFSOg5XWlhyWFBahHurD8mTvKzHtRW?=
 =?us-ascii?Q?GA2f3kmJgJN1qUa917GuVAzPc6oVPXlvby377zbZjWVFtBQtgIjbTwqmHZG4?=
 =?us-ascii?Q?v2MsYUQCz/gK/Z14avrc9hu6+MkVSfVlhX30Al9SyVq+PVA9BgKZWpPmKmL3?=
 =?us-ascii?Q?07G3j4/BAs168/1zRAi7YOU+i2iZKBLMoKAw3K00gd2kUUYCMb0664jZ7ZF/?=
 =?us-ascii?Q?yfl0vl4qlXr/Y9mElBexq+1czrZJ4urj4WHYK83x8MPnH6OdPiioJkjNqKx5?=
 =?us-ascii?Q?AUtoPDobQI/O03Nn+XDmXNuMr0ecwOnLznrRlieNKBm6NjpPYhPRjek/J6WG?=
 =?us-ascii?Q?DzmUQtrF+PlOrnA3yXVMG7lwMqy1UhsBuVMqVhN/QpnYmfhPfCzhhTZGh+pA?=
 =?us-ascii?Q?z7fP2RCp28naErCJQzPx4TwMGc1azI8qfw2UZAXo5Mzp6Uhio2uZpPfk52cs?=
 =?us-ascii?Q?ZXL6zo4t2nA0ebtxNqPmXwWi1+6ForsOaG2MOtrcwbeph3r1VmN0oqdT/mPE?=
 =?us-ascii?Q?Bzo96B2aApk9/EGkPqD9+mKB99kCHkqy/fRZGdxw5kuhDqBH53c5kWSEFXFM?=
 =?us-ascii?Q?FvSIH0BToZmsgK+kW/yETg5JNgYaH8Mof6DM6yk6jEuol00jXOwjevPHxQTh?=
 =?us-ascii?Q?0SYBV8h841TtEqRVDYZ/rjdECT+FegDKSjUUDOU7XIUgZgAtCON7eul06a96?=
 =?us-ascii?Q?EHxaz2u6Vy3EXWgc/rp/GtsJhPAIYidP4gr9xa57NmNgke6Fin/S1GxVaSjf?=
 =?us-ascii?Q?7WOon16B/edg7skn1hDhLkkkXaLuD5PT8IaQ3p/9VJr9G0WQ7ijajo/QiT73?=
 =?us-ascii?Q?vFF/8Y0SNj4lLG02alcOzucwnV0i0/RKemwb3Yc2KMARLudsOpd+lBU3h+te?=
 =?us-ascii?Q?XYloYhi14hZQwhVOMbpp/6A++1DrSccrHcoEo5gXXgGs4htlOmTInePoOGKj?=
 =?us-ascii?Q?eyL0jCJZwUGjDoGKRaKc6Y3IAQGJC8dMbLbf6aSxkpRT8lID8HJaFeeDn2+b?=
 =?us-ascii?Q?0N4xDQM8P4LVHH0h8l5jxDcyUs6KK5Q4gmLo1Rhyh3z3E3jHK75CEbgQE7PU?=
 =?us-ascii?Q?jEFRO57rZI23ifCdUd8PuHaVwYUdprAGE2oRPodTFg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?uTF6j51fRnH1nb9H3GerQkbKjr5cvPg0g24Q4LfMQMWa5bulgxL8DRjeL0H2?=
 =?us-ascii?Q?rplKoZG4wHe4Y55vJWQyn+pieOzntGqQYX0AVPbWML5K8x6A7n6twS/9IZfq?=
 =?us-ascii?Q?QH4dna1zWNIe4cG5Il7diTMBC5QzPOx7Y7c4Vb6ky0n+s0b1qxazTsDUU8NY?=
 =?us-ascii?Q?nJHlNHG2spbS8wWvdRkmqelksJZ3l9gZQZYdboeIqSLYRMMz7HaGR5PCcm8h?=
 =?us-ascii?Q?Hs/BTZmyWm/UAxgfC5r9zr6ClGNaOoecgUVtSyeQLMAS8NAmKgKpeG/I5Urv?=
 =?us-ascii?Q?4bhrcFq7qDfZe3CfTVfRTO8OO7tec5jOoaTPHzrKI9AR//3NePn8CGfEPp/L?=
 =?us-ascii?Q?AkmTtxjlL5JRDsd62yE+K30hjdBQ++M66qTtRp6wS1GKw79uACKwbNdO6+ky?=
 =?us-ascii?Q?tUqHOLHt/NTyg4oWKKITtIz43Ncj0uWRcAf8Edqh7u9JoF4dxglDXYsT0kJt?=
 =?us-ascii?Q?Q5X4Dj+Fm6YFVdT6hq/Fx3dGm2c4cSS3Y2vxTTbtcPcrDEvYvMiUo+OeG6SD?=
 =?us-ascii?Q?rzzLW9Eqk26NjMsYpC3k/VDG+U+Fr7S9gq637Zsq2GNdA51oDX2X4QDyxsfx?=
 =?us-ascii?Q?aU4YybrtE166q1KYGXIZKPUozr/Zgvq7onwf/r7nzy37233DJ9mUeQg99JLj?=
 =?us-ascii?Q?yVE+NKtwc/Gu13cDILOtG3O5CDGGR+vvkg5vt/fgMQX35pr5whTjoDb0BgA9?=
 =?us-ascii?Q?H7rhDEDnhn6OGQbbXUhDk/izKm74I8yXVGnT2wsoYdiI/b9JXDORsyXFnTqE?=
 =?us-ascii?Q?oDec9PKHdqWqoMHAtxawcBtwqFmcUeU6HicWMo7z7/yjGk5/NVU6ODT9EIEV?=
 =?us-ascii?Q?uoHVktovepdCPYfIkd3YmX43SWoFr38rMZMCNXHAJxSdaup49Ua5XzM1c9kJ?=
 =?us-ascii?Q?Gzt+SD+bfXr7o8+E+uQ85sXvUBC63swu47Zpxd01pGnH4BFf9ND+nclK/YFy?=
 =?us-ascii?Q?AMBSA0Tp5xA5YC2T4x6AjfHq3E2YqpXF91yRT250t65gi0DjxdJ6wBYtrA5q?=
 =?us-ascii?Q?YDR9IYeOXXbq0LndoveuVqPKfa7OnplA6n1Uqp85cge7khDO2pkpU/arRxJ7?=
 =?us-ascii?Q?Hs82do9DsgMDX6oX4e/FjAg44QdaAyFq9Uyu+NjxsZncc2MVD2/0Ka/s3sW7?=
 =?us-ascii?Q?EXkyUO66dS5pmrm+l6rXQGuWOK4YUiIiKcrIMzxmg/WfR59M4oakB9gef7Rl?=
 =?us-ascii?Q?c1JnVdp83JXCvCMstFp5aGn+A71jmJFdG84yi4Ox9sGWg1/Zei52KczDzIhm?=
 =?us-ascii?Q?Eog9Se++bh8y1g6NBsuiALXywBeAZY+z5Dcs93z5r6m9yv+Hiv17DSzJ7Ij+?=
 =?us-ascii?Q?3p6az4j1SKpR44xJr18EHW33cTIoqiFbGmK1uT3yK57Q5mVU7bDQy1eEPGOi?=
 =?us-ascii?Q?CFW59lS+cK89anr7u7WKC0DIT+DQteJbfeXrXDLnluL5mo+F4qX+hkzD+LWh?=
 =?us-ascii?Q?aJUbLHtpCsBHxiyhk1rP3sqGiGIUiX1qVcPHurqOW8vuKj3Y3U9VZ7QYBFww?=
 =?us-ascii?Q?vd9IihCxcsSLx+qoL4wyH+wAYq8hdoKWvl+js+x7ZWFj2glfmOMiT+covdzA?=
 =?us-ascii?Q?DOhDnyznVvKWO4M1pBvRANSorswJ68U6EWGQ2GWooO+Xi5TwTB+rlDJv9j4k?=
 =?us-ascii?Q?Tw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	MwuagVnig/4MJeQuu2JAh1F8OJ7N79yL1/FboxpJ1gHYNtrZaYI+5dPdnXzubKHUkjjmqJWX5SgQgsr+Xvy1gIF6vw5xgV9v+Vz/xKsl5L7bQI6x8+T0UYEyTMYtjzxZt0XUmiNRqvl/Qzf+8xNlyddB5HpTyzhvTINYZlTQKajeoTJXP7IfBfogkZzvS5PaUiMARovERaUst0i/+RXHvZA9Eli5/Hpp0FkMf1NJ+XeHLtmRfjfQxJ9TABJmKBlC5I0dKgzFwoQOqwYuPOK1uOhk3UiTbGWE+QiYiRTkGx4bCC9lZh/F4o5PugSCaJ5vzMoyUFZDW+NqpENBFSCRLgfpJ/A8ah+pgGVRLL3W7pn6KXHeZKlxOCefNr/QZb2Jt10ctgDmTilvK28EmXWZ9ozZhbJLH4HD0g9TQwV5UxVt4F0vs1SxAaepN2U0KGlppEldTRvfepVucEf/hsB77V3nPLX9xR1p76e3dbnRfvtczB3UBKsNEmusJVuJ+CpaCyG8CUtyRTfkOXQV61w1rueBE8fXF4AI4fkHCKY0iblHMPKF4/nWUzXglq/hGFekJ8hAuwpz+w4oXI7FFcTRaOcgnkmLA3D/cm4Tp8TXQW0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bc31b6e-755a-48ac-54a7-08dc808b0faf
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 09:29:53.2770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NQuiyF0Jd7vhE1IK6WTzYX6LvI5Zpb/COGCH4EcHbd+M0bdTERtAvaby43ADM+T8F1lNG1vVu/TAHMhrqJGdRWMk/J5O6eboru/mjzpOBBU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6823
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_07,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=863 malwarescore=0
 spamscore=0 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405300071
X-Proofpoint-GUID: QAs47Is0OZS3hWL0NlVKwCHNmlNBhzw3
X-Proofpoint-ORIG-GUID: QAs47Is0OZS3hWL0NlVKwCHNmlNBhzw3


Peter Zijlstra <peterz@infradead.org> writes:

> On Mon, May 27, 2024 at 05:34:59PM -0700, Ankur Arora wrote:
>> Reuse sched_dynamic_update() and related logic to enable choosing
>> the preemption model at boot or runtime for PREEMPT_AUTO.
>>
>> The interface is identical to PREEMPT_DYNAMIC.
>
> Colour me confused, why?!? What are you doing and why aren't just just
> adding AUTO to the existing DYNAMIC thing?

You mean have a single __sched_dynamic_update()? AUTO doesn't use any
of the static_call/static_key stuff so I'm not sure how that would work.

Or am I missing the point of what you are saying?

--
ankur

