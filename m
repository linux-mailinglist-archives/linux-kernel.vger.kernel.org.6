Return-Path: <linux-kernel+bounces-196004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB718D55F8
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 01:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4908B25D0F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 23:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9B2183991;
	Thu, 30 May 2024 23:05:21 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36457181BB5
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 23:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717110320; cv=fail; b=a5AmmW1jFjOI5MKKB4owBp/puX7jak11UCHc8myyMJsq3D0vIJLfvN91ZdN8Kol3OCcvbBiivsA+grB9A1ggWMFiN5htt3Hi0rPzfZZfmCWo3sLz6oGZdzx1y0N5JarklHXoSkKlohAOUQp7j/Ubw2Pyuz4HqTDNy3xg0slPTsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717110320; c=relaxed/simple;
	bh=Lk0QwirIP6PXug0WbJlO0d6TnlVifgGUdOUVwcX3YGM=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=QEFl7Rno0vNQ6C7XiTE/qhwBxM5DjhJmlIlVGw8fEXrP53d6TvqQA1z4XTB0q/6Q0mRnB2TjKcQmFbjdHk4bUqJcsME+lrFymEoQRbK2sEFPzTW2sAxTOCIOFh7DHMqUMcPLp+qw8JNPXhZxBoCQ2xcJHo3c0cWEYfWMwQ0ukYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44UFSQgZ005736;
	Thu, 30 May 2024 23:04:57 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-type:date:from:in-reply-to:message-id:mime-versio?=
 =?UTF-8?Q?n:references:subject:to;_s=3Dcorp-2023-11-20;_bh=3DXiC/PkCvhWDQ?=
 =?UTF-8?Q?0U2gAqv28fSuEPzOLrgY0EI8A5zqAzg=3D;_b=3Dig3+VB5UayRIrGSA9LWD2w9?=
 =?UTF-8?Q?bR2NrA4LNVmHlyDTTEvloQ1IZENXvazeXAM8KkE0nQgm4_F+4AJtTntUbTpVA7K?=
 =?UTF-8?Q?3Jk9BSoZQ6JcjN+hE5o547jjFF4S0DYiTWfkwgYKsLZDtx5ASRa_woq/08c2wAP?=
 =?UTF-8?Q?B7niC2EtjFtzRYaV9IAnQblmvsiAPg73l56Q9cnzi0jPBamqnOUHQjthZ_dnDmN?=
 =?UTF-8?Q?m38Wztb9PYfMV4+kIvS8iybCsH0wY0+dtP02OlpWh7PPOOpapFIXnLlBT5oN+/C?=
 =?UTF-8?Q?_nCLCSodwuvSUAtKUUwAd5Q7XmXfeFRoZz4s9SDL6TJVfbdyyDmaVP0ngTeg3MM?=
 =?UTF-8?Q?9mB6Sx_gg=3D=3D_?=
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8g4a3r6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 May 2024 23:04:57 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44ULosD6006164;
	Thu, 30 May 2024 23:04:56 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2044.outbound.protection.outlook.com [104.47.55.44])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yd7c7me51-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 May 2024 23:04:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KdPatPPwNMzak6drVokyS5ZxcoaBot8OrADJ0x6Z2GTgSg7h2EHW1pJ5BkbRUCQCOavhcGFGaBU7k0/DwafcJt2RCqmTD3A7dLEXSZVEKPzwfAPVWizblXHNzE6G4sr2QqgbNysz91vuZCjS7R5TAOtAO293Li4vH9wAtcZM6dybNSoD1vN8E8e3r5I/3FwxC2Sf7CrmcJVlQooNKZ3Jrqw8avozOI+d3Htp+A9AUdNcNdORaLAgB6b6hYWVl2rmQioOf62YTzwNEyRX3e5FHNQgTpPYUHZq1e2WE9EKcne9yY3cWZoYKe0qt670CyB5CwBVMNW5ZzeArZl4PxGuSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XiC/PkCvhWDQ0U2gAqv28fSuEPzOLrgY0EI8A5zqAzg=;
 b=I4B7Gw0SoNv58E9PmmyC7uK//+EwU1v1PI/GI1kM7s/jGk+miBY9jjKI/ZsuNB+Z6m3TeNP0U6dn9gaNAVejEytJnEWzanT2FQ4cC7NgdyWV6CRGUhxcr6ltl2LqiFt7sP+/1hwCYbB4W/85JAfhveb6sWJpzprIqOAyjycCVmKt/I7xxAMpzGmzBK1WA8YfyE6KYLTZGkmEcIppJRsn3ulMpB2xfp0h3rTZCuDqaDp236KE+n+8OBDNwMdH5go53Eux6RMRO07eOlhhs6T6283ntzXjE7ftMxPxNx8G438OwCG/a4jmklA6veAyl9GMYVDHU0lbiFQ9Z7pc4zDzWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XiC/PkCvhWDQ0U2gAqv28fSuEPzOLrgY0EI8A5zqAzg=;
 b=B+xABpX/k6gHDyOVD5HZ21gDOj98RRc0jk8TeDDlCT9JDRIwp5qMjzUvBzFRJGqk6W/rnpxjzZxdTcL6PVEedkizqumsW9XHZGCowKIWk5KBeBvKchrIz6mft6AYpqagZWAEL3qhrzmmP9Ir/u1ImGkteb90Z5sy646bqCoFVIo=
Received: from DM8PR10MB5416.namprd10.prod.outlook.com (2603:10b6:8:3f::19) by
 SJ0PR10MB4511.namprd10.prod.outlook.com (2603:10b6:a03:2de::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Thu, 30 May
 2024 23:04:52 +0000
Received: from DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::e085:31f:84d1:e51a]) by DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::e085:31f:84d1:e51a%7]) with mapi id 15.20.7633.021; Thu, 30 May 2024
 23:04:52 +0000
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
 <20240528003521.979836-17-ankur.a.arora@oracle.com>
 <20240529081404.GI26599@noisy.programming.kicks-ass.net>
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
Subject: Re: [PATCH v2 16/35] preempt,rcu: warn on PREEMPT_RCU=n, preempt=full
In-reply-to: <20240529081404.GI26599@noisy.programming.kicks-ass.net>
Date: Thu, 30 May 2024 16:04:41 -0700
Message-ID: <8734py6gvq.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: PAZP264CA0157.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1f9::12) To PH0PR10MB5418.namprd10.prod.outlook.com
 (2603:10b6:510:e5::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR10MB5416:EE_|SJ0PR10MB4511:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a8e1a7b-e910-4157-7cc7-08dc80fce8c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?6tjxr3v57n+YkTaSQ4OIzcdxU67dsILeVlZq5+Hxzsnk+d2u0abFUfOA4kDZ?=
 =?us-ascii?Q?ULmCerL89m1KDNONJAzqhKgGCRiY9/gFCQx9RP1zwYxyyUHUm6xflx79vDvj?=
 =?us-ascii?Q?gAyEMUvcQl1VfiweeIym056CTh/v3Y/6GGsUA0QspakVv+QGNGvluBAedMsu?=
 =?us-ascii?Q?CkGv9lpQP1ETyRuAO9yuSUB1WuFfMggjVTSSAyShsyBhQv2Bxv3l8gQK/M4/?=
 =?us-ascii?Q?RHWGdBIOX4s0WPrJVhL/mFfAJZiQ5QJbK5U9dRC/oV/ZAZqoCkP2vuU1fxQZ?=
 =?us-ascii?Q?/4U/0gwez6YWw64j7e2x+6tkZhr0no+c399qdkz4KFcneyPBwZgHI47t/31L?=
 =?us-ascii?Q?I1Nw0BQhswxKXDnOGMwFV/SIc1GKkbIk9gXqayPUmdxFCdDYa9ME5TRNmI9q?=
 =?us-ascii?Q?fdkrR5HN8w3VCXxzNQEllIk0Ixo3DzknJccD/obY/dJnWRcnMsLwKv0KpPoU?=
 =?us-ascii?Q?GoVkJ69HYeblMdklmtSSJD0HrXpgJacRomNI0L8uDUkMCnKN6YvZ/mq74Gl0?=
 =?us-ascii?Q?x03Ge1VllBBnMkzK74nZOUexj0u5jTo4+ua57IRPu28AUCfeKaMB7vxSMzl6?=
 =?us-ascii?Q?KcQXfCSfL+F8TP8OURvsfLX/4tA/vC9dEdAmBdEHs2UUVJUWq3HCK7P8nIAC?=
 =?us-ascii?Q?u6E+NXY9ZHYagAZaAPTv+5daj7IDZPkiquMLH5hydafKckwmBw/bjTolsO8d?=
 =?us-ascii?Q?HZKC/XhZlQ4t7RBlNtd94ikuFekpItd3PlAOM36Da3uHHun/H+J5+6mN9bwN?=
 =?us-ascii?Q?5csQeUYJnYy1CwKSiznUZfq0+1d0QOJdSz1QMzNkgzHL32T+0UBges9sSD/A?=
 =?us-ascii?Q?RdfPrYY2DXzU0aZYiS75MMpGXvtPX6IorGz1m0EojnH76Rqj1OQT9s4bVUKu?=
 =?us-ascii?Q?T1zG47xWlgxNl9n7krc1BHxhhLD+00DJBf5MBQcXinPk4aluJ26Jum/UwZpJ?=
 =?us-ascii?Q?hnNxL7cOFfPbzpYsooSNXMpRYLoLy7jTL2c2V5T5x4yEZnVUFuVP74UNIWy6?=
 =?us-ascii?Q?gPBGrjw0HK/qnFictz2Zg0BAt7aPRPnYTZWpKXEqFpHX5yyLvxkesV+WUcWb?=
 =?us-ascii?Q?hWhxcSFhfCJ4B4siXxQdzfiSVtkEonsLDXRY+kYoLDjy5f9aObhVXgd+4G2a?=
 =?us-ascii?Q?OYHtRgvImFrf+N6VT4dHJ1zTRZjYmMc7pgjemgyJQjXAOO7RtjdlUnLjX7PR?=
 =?us-ascii?Q?jHFYGNn0HJIzTg0CMaz2O2ehJxifQl+4DDB87z5NFV3518ILC/64b5L15CA?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR10MB5416.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?N7zy0COAZqi/wSMXQho+7qVdTlXBWk2y/4V5WYnGYgkwgz9Z6Da71LZh5DA9?=
 =?us-ascii?Q?vH4B7BasDzZVpaCwBv6QCYyTA5cr6o2b7+VEiDIszbvwUvIczNhAbJgSVRf7?=
 =?us-ascii?Q?SqxMb1WVYxqoyHshgeFK9faoFj9kZ99gdBIHH1yCSaKmxo9TDPV+FMrTI4LI?=
 =?us-ascii?Q?Xz+nhHzsOgOF+V34ScdUGgS3o8YF5RqHX0H6rab4FCL55cozj1IZXtqyWMCr?=
 =?us-ascii?Q?l3NDzHgKOaYybzvp8CdpU12zVzywInfdQCqMjJUIL+JrFGXFgMo/x299xUBo?=
 =?us-ascii?Q?TuDkL8ZlSD7LAnSxvjiD/gAMr1vr1/7K5rhA0bSoJEiSHRR2M/qQWy0Di8BS?=
 =?us-ascii?Q?qyaekQaNMnb9YNnzUDULec9Tdy484U8E2AT14GzDpHMX5FmLdya5sWYX+QYk?=
 =?us-ascii?Q?GeQCIU9ErinH2lRynY2p0ElcL3U3Qtz3djjnAB4qQdNiRGT2s0l7S9l2v9NA?=
 =?us-ascii?Q?FlddVOKHCWyFrx6ZTT5LM8P190H+TCCmxG9eBfQ3/WnV82YmgzalSGT0FhlK?=
 =?us-ascii?Q?8J65GPGZbUZJF6ghd3+ZCZAMfZZlw2EEU8in3Fy2ppRK6/syfYLDhde9E/ou?=
 =?us-ascii?Q?netcxzrio26SPFHd+uq1bI6qL2f0pzvgYZKgqpcn22vSmxmCx4/7IfxgRY/o?=
 =?us-ascii?Q?2pkNdXLK4dJX0VDKsIQabYc+WZosMqga0K5quaQBXgmdmxA2MgYui3lHGOZx?=
 =?us-ascii?Q?xvtXKhxSd9B9TTtbZL4Fl4F3l1knJBl0Lffao04QeEQQdpwfsuQvV2pMy30H?=
 =?us-ascii?Q?qu3ehqrWZz4PKXRbOEENV7EIb9/xLsc/7TvpduMNgxS12UaMTz0C72fs5GyI?=
 =?us-ascii?Q?WO2NKuuFuHJtLLNfHPubGGzaUvXtG6BPFW/8JsREvsJNFoPnxGMgnJE+LQQn?=
 =?us-ascii?Q?b2og48U5n3/VRNMVQcVvTe/1CMt4muV5hNMg8ex05EBEkfkd516qyZyBoPSh?=
 =?us-ascii?Q?Zqn55HdNPDPwtqg+I7ahaZzqJcFczzPcbyvVL6xjsqEC8QURUKB51F0jrVLU?=
 =?us-ascii?Q?Qm8Qfk20iGSVvLxUqMP9jrUh5tMHyj7HsK3B44WZPVSr/PjeCF0ihTNUgK+7?=
 =?us-ascii?Q?DCxxBOrc+pnMaThTwPCvkonxkFiHgwfdYDDidmNoFX2tmXoaWrf97aTWlzu9?=
 =?us-ascii?Q?bFdRNrjpj42vguvj0Pj1KPubqC8iLdbah1wmmr2Nuer8qDRnz0oqA6qcE+01?=
 =?us-ascii?Q?PlzDyptKm50UTZt3H5qOuevJgALchtXLEPltLn1C4u6CoTLc99oWG9COTPHz?=
 =?us-ascii?Q?CWZEKoMKWSzHqNpCePFNLI1cGybJHzssuhCKhUfMz6mB2RX2xHBZCgnMQN6M?=
 =?us-ascii?Q?yrpgKmYHwK5OBtOCiF7jhef3+6BgvgjFa8f0P2lamFCY6YnSw0oOY0m2/fmX?=
 =?us-ascii?Q?/PirsYkm2FuZJ8Fr3Oz4IrAHFNY87w83u7caXH0DNcVo6VhoMGcQT1HRwq+i?=
 =?us-ascii?Q?GyQ+MU5wZrDUiXv/Gb6KJqnXrGxa2YtrOvtWJBv7l1l2A73dXVIMf7TjRUoA?=
 =?us-ascii?Q?v+mfns5KJ8wEpdEKlChniZ8w5w8Utl5pfX/8rwoFnUxwPjXuF2DPkx9X0bIR?=
 =?us-ascii?Q?T9D0SG4xxR2mmO8aEJEJoizW5e/tOcJMo6U1W17nvnJ30ewmDGX7qrWlygy+?=
 =?us-ascii?Q?bQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	dXW9Qx38nxaEXmpawcI/www3Qhpi0i0A+WQXeknksT+1Bw7LLD7Ik9IKXMxcB7RXpewzYq3dDSMS315FsRkta+KL/PCtuI440khZ07Awm5ne1tEqb3LzogE74Kla/Jd7RmAO4piN77CVr8wckvrtqFeOhYUWC14+JFES2v7wozVJDhzprqwahsho0Y7dNNLR8p7TRHKClk6maEjgc8ti2L5hUejBpQKeXKj1q3mH38sY1qNeqYVPXnTPP7AwK34TQixsagPsMeVi08HZhwTPoNNFGN4nP3FpCeNOYKOrHD+TKq9y8sAJkJSFbfCeBhil+WCTaWMQ5Lq33SbYWRj57uK0nIAeCGVOEGUEO/dqbLyIDkjoUay9NMcagCBNUPZPOi9LauNIu0/NNDuXhMm3GmRuHh0MHdZ4Su04Fw/zdJdsorrzM9fUqK+UQo8CjkYAokN68c7NSWZi2/zEYRbsH9kwXta9mbnNcFU4J2oTq70oRkFSLqc8HEWQDPS+zObYJNJvJxsF0Bfy7PCnlaye8DqdKlVp+7ANfN8Q2HegYEodtPA+Vl5H24H6lhYGaKuNnkMZICyiD8cK0fm3Et9bACfEsCKU5cl620/Cob8bRpU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a8e1a7b-e910-4157-7cc7-08dc80fce8c2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5418.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 23:04:51.8605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rKms9Y3iKAm5IkoLyvBLuwbFSmz017gP7bwNBpNkS3NlojCFDlMFU9bm8cb+slxQ8Z3jiAc6PsxfRrOK9zAjdIarYdTnWeWwVw3BVfWuS1w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4511
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_17,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405300175
X-Proofpoint-GUID: lcMtnKSLmPsmGtXJD0wbr6XyEdnbzV_q
X-Proofpoint-ORIG-GUID: lcMtnKSLmPsmGtXJD0wbr6XyEdnbzV_q


Peter Zijlstra <peterz@infradead.org> writes:

> On Mon, May 27, 2024 at 05:35:02PM -0700, Ankur Arora wrote:
>> The combination of PREEMPT_RCU=n and (PREEMPT_AUTO=y, preempt=full)
>> works at cross purposes: the RCU read side critical sections disable
>> preemption, while preempt=full schedules eagerly to minimize
>> latency.
>>
>> Warn if the user is switching to full preemption with PREEMPT_RCU=n.
>>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Juri Lelli <juri.lelli@redhat.com>
>> Cc: Vincent Guittot <vincent.guittot@linaro.org>
>> Suggested-by: Paul E. McKenney <paulmck@kernel.org>
>> Link: https://lore.kernel.org/lkml/842f589e-5ea3-4c2b-9376-d718c14fabf5@paulmck-laptop/
>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>> ---
>>  kernel/sched/core.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index d7804e29182d..df8e333f2d8b 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -8943,6 +8943,10 @@ static void __sched_dynamic_update(int mode)
>>  		break;
>>
>>  	case preempt_dynamic_full:
>> +		if (!IS_ENABLED(CONFIG_PREEMPT_RCU))
>> +			pr_warn("%s: preempt=full is not recommended with CONFIG_PREEMPT_RCU=n",
>> +				PREEMPT_MODE);
>> +
>
> Yeah, so I don't believe this is a viable strategy.
>
> Firstly, none of these RCU patches are actually about the whole LAZY
> preempt scheme, they apply equally well (arguably better) to the
> existing PREEMPT_DYNAMIC thing.

Agreed.

> Secondly, esp. with the LAZY thing, you are effectively running FULL at
> all times. It's just that some of the preemptions, typically those of
> the normal scheduling class are somewhat delayed. However RT/DL classes
> are still insta preempt.

Also, agreed.

> Meaning that if you run anything in the realtime classes you're running
> a fully preemptible kernel. As such, RCU had better be able to deal with
> it.

So, RCU can deal with (PREEMPT_RCU=y, PREEMPT_AUTO=y, preempt=none/voluntary/full).
Since that's basically what PREEMPT_DYNAMIC already works with.

The other combination, (PREEMPT_RCU=n, PREEMPT_AUTO,
preempt=none/voluntary) would generally be business as usual, except, as
you say, it is really PREEMPT_RCU=n, preempt=full in disguise.

However, as Paul says __rcu_read_lock(), for PREEMPT_RCU=n is defined as:

static inline void __rcu_read_lock(void)
{
        preempt_disable();
}

So, this combination -- though non standard -- should also work.

The reason for adding the warning was because Paul had warned in
discussions earlier (see here for instance:
https://lore.kernel.org/lkml/842f589e-5ea3-4c2b-9376-d718c14fabf5@paulmck-laptop/)

that the PREEMPT_FULL=y and PREEMPT_RCU=n is basically useless. But at
least in my understanding that's primarily a performance concern not a
correctness concern. But, Paul can probably speak to that more.

  "PREEMPT_FULL=y plus PREEMPT_RCU=n appears to be a useless
  combination.  All of the gains from PREEMPT_FULL=y are more than lost
  due to PREEMPT_RCU=n, especially when the kernel decides to do something
  like walk a long task list under RCU protection.  We should not waste
  people's time getting burned by this combination, nor should we waste
  cycles testing it."


--
ankur

