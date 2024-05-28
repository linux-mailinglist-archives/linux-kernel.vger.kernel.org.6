Return-Path: <linux-kernel+bounces-191565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B76E8D10FD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 02:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4D0A1F21C00
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 00:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6985B487A9;
	Tue, 28 May 2024 00:36:52 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1537B1094E
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 00:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716856611; cv=fail; b=epC5qTjPjLLCoqjsBA0pdj3eFgqZ8T51ms6/mDAIq7uI6/LZfeDYutBD9NJIhsH9x8+a5Etbvg/pg5RgqOJTXd632lyTjfMn00hfMjDW24+nvy/37mxwZdkhvAQzCG185nLLmv7mLUVtGH1h5fUBc6Jqm+bNgUfBDs2i48Jh2yM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716856611; c=relaxed/simple;
	bh=nj8UT62IgOQvnIa4xbmupB8pW25l4W5Oc/A/zB1XBzc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=largAaCA5kW4VpWC8xFmcVDlcxRkoZDP23dUnixOBsjhF8XqhHSV70xO0YotxfX2gWz+rZLkjOU8co1560MtKP48WvW6rEAekVd6aKmyOBwD8Tsy/5zqCWiEOQrAUr6MKquAnbz2mCtEo7kp306Dka50AOV9kbg2gOwr/6D14lY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44REtIQN013112;
	Tue, 28 May 2024 00:36:34 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DIHixXRXFyTwkkwfAXk7CsRS3SLlkd7/kYbwlphVhNjQ=3D;_b?=
 =?UTF-8?Q?=3DEK8f5ZKaQMndqygjD4867Jm0XVDPqlfH7LVSWHx8BXeUeFn0POmEAg8kX3Bv?=
 =?UTF-8?Q?tdgWx9DO_g/tjFUE3Xu3VjxVzv2vEA71HKgvA3kAXJ1dusdbxYElCF36gy6KOF3?=
 =?UTF-8?Q?8Y0XyYwzIJ1QPh_ePvtsZMw7OeZg42DJPmOlkp/OpSb24dtbxfAsBJ/na3dG2sI?=
 =?UTF-8?Q?HkOlb3oBJewcy162Wfau_nzC71v4D1SeC4GpHpiGcY1xZe1m0rAjkh3Iegw8tpk?=
 =?UTF-8?Q?SF2scgdCc4Y8CgibSu7FQq0IG2_zX3YYLJ3mQzDqMrGHpKZcp3RUWcRhZxb9SzH?=
 =?UTF-8?Q?ZCN5xZXG4YklxOZ78dIu2xoUrzZzhBEA_0A=3D=3D_?=
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8p7k5tw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 00:36:34 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44RKf1Ru025740;
	Tue, 28 May 2024 00:36:33 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yc50p7xsy-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 00:36:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h6YBMkh9J5b2rjQTG2aKjEjCfNyYVdPTR5U4qB98GBKVVdpyeeNx4snkYN4+NF1DWAsl9QuZlkbyQ4R6VXqU8HX18VhXqqFlDCVa+vYK1suGF6iyMFKwmun0pDNCuVUDmeySBhOM1KetS2ICXJ81zS708ZDJlRiNjvJeFERxqQjA90pSyea/QWtjph88W3xyRPdza2vJhxkQZAh/62KU/n1vHn9g8bczlWGXYorZu+zYcwKIyumgfcVXMpFk3WVbVL0vveDl6AbHhx0reaZI/p70VGLqPo8kPnFZGfLeik1m90TfGLMVt2/RuipETlbyMTlIipUGZa725hWr+cRXOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IHixXRXFyTwkkwfAXk7CsRS3SLlkd7/kYbwlphVhNjQ=;
 b=RjQHNeFWyHTfPA71IjtI2mYRsbnAKGH+7DwArCEhKl8bkZLSLLCvQjcsYUFl5vAiiGbtTYw1ThHSfESJxYcNkmv92j62I4+gyOOLQGrF9e3TI8aSHoXMcJcL8v7fI0IcRqlFEuwmTQPF6Wy2HX6Op0WW+5U7Gy8OPocxqOXZ4hqclpNdi49dL82yfuIWOKhboxzuFWYCl/ZJF3ouxDHn6VDSaG3kIud/8AHu22YUDtTxw472+GG5OzNyek5zVH7eC4ytatZYYwZAw3kZF147UKi9fUl4s+2aGzfegPjLSG9AjLaCGKx8kaBpe0fI/APou8p7dftsvfPhqRaCXOOlxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IHixXRXFyTwkkwfAXk7CsRS3SLlkd7/kYbwlphVhNjQ=;
 b=k73Ie9YvNhLTi6/iicf/fV+aoxmi2PkC8BlfZ8l+TbRHcivclQWEfy4npCJH5qKC8Ae7JxdN199U/orRhk6Wkhxx5xXpF8R5gtP0dTP5bDYI8FIrr79UyDwGzYtDzFKuhfBZ7gMP52Onim881ewyDuozRBu/hlLFsQ6iAfdVceI=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS7PR10MB7177.namprd10.prod.outlook.com (2603:10b6:8:e1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 00:36:31 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%4]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 00:36:31 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, rostedt@goodmis.org, mark.rutland@arm.com,
        juri.lelli@redhat.com, joel@joelfernandes.org, raghavendra.kt@amd.com,
        sshegde@linux.ibm.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, Ankur Arora <ankur.a.arora@oracle.com>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2 21/35] sched: prepare for lazy rescheduling in resched_curr()
Date: Mon, 27 May 2024 17:35:07 -0700
Message-Id: <20240528003521.979836-22-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240528003521.979836-1-ankur.a.arora@oracle.com>
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0300.namprd03.prod.outlook.com
 (2603:10b6:303:b5::35) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS7PR10MB7177:EE_
X-MS-Office365-Filtering-Correlation-Id: db001b31-e4d1-4c11-b09d-08dc7eae381b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?xwfafn/NqB5KHse7KA3gQiwGI88H0LAJhSRfvL/arsK/UWw2D/Wa53EKO9cs?=
 =?us-ascii?Q?n0weXi/+bVFSkfHBLS7+k2nqEiBVcmJs931zw0z3Eun5LO1S37DhWpSbqjob?=
 =?us-ascii?Q?vZPWGJVJ+pjy4nbV0d2h4HJH1ehHIS0MUlm2xUICHrPhr+ZIk8h+8t1dZWU2?=
 =?us-ascii?Q?wfpOCfVzhaenYGXtR6j57A32ru2r/KSopEyIDEC8Tqtj94wxGTvu2hzZ7Pz1?=
 =?us-ascii?Q?XBpShAEkjUja2+ccQzDhQI3v+lVisgjQ8Q/KwkRLUIWbUUIMbY8ZIP6yIl8k?=
 =?us-ascii?Q?sn0pWDQH4tS9sxl4af0p71k+Ub76mcAAY+S3vI6uMgXcJIZcnkwevMIJ3GgT?=
 =?us-ascii?Q?xsp2mnKV+bywgaJDd0szv1OyC+hUvpUiDnxUd+3JVDlXbU8dDeOkgO0NrdF0?=
 =?us-ascii?Q?kIKpO6lZJzPAgn1Hk8/Y9s+lTT6AerjRXgpINOQgLS0UUr1b304MexxdAPbS?=
 =?us-ascii?Q?d0HC1kskkTked/rmEw+LEOy0PeNEijq7Gcllr+wHNAUjCz0Qj+ZMg/Rz57/v?=
 =?us-ascii?Q?el2GP5h7g75r2uxb8TEOy7e8fYhtNr/GhuXpA0GEoXX9j8lAhbWvWOhVcIUf?=
 =?us-ascii?Q?SufL0wVdaxHo99tJi1Czn/G5LCwvlre5UjF6d+Q/ZbQNFpvLXVVSGY6yFg1f?=
 =?us-ascii?Q?Z3ut4973ccxJ1POkr32KF/12wlWHUKpHIO1xe6xD8gd5h9bx28/R99PqmyUe?=
 =?us-ascii?Q?KpP4R5M/G7/TJdgRPhJpwYnYz6WkxONcnJSkl8OQg84QDdPDcgAdjMQMYRDx?=
 =?us-ascii?Q?T/7HjIOgkcJUhFPPRsSWIXSzp3Sp5HLCotpY7tFNKSeNm284e33fXyzZPz08?=
 =?us-ascii?Q?mdmPSdCgqagw841OtdPUioinQ1XHxA8ZxWHawnIvhcupxrpt3y25s9GlKsRb?=
 =?us-ascii?Q?KGDidwBur3k9oCXMq6b2g568wfwUikfEn8p4Zp8lqN4GPChKNE3yaJbs1LqU?=
 =?us-ascii?Q?GPsiOmo2XL5aFAqQmd5Ld2YfH38atCHXNEICk1de+y7Kl2zZCTZCJJCKjC69?=
 =?us-ascii?Q?C8QHsx84tRSu9i4dDBR9YzwYkZ/4MRFD09Aj+Z/UypV1YCbRMsAfvS48b58w?=
 =?us-ascii?Q?aNF5ziNtny2PXHTmvMFeA6heGZKgegCK39KMr8r2gS0IwQFM4YZJ94TfU6eS?=
 =?us-ascii?Q?fkpy0kv5pwz37gL4GvAFI1PhWf72BbcKQGHds8XrNEDXkOtFm58+7tm6ibtq?=
 =?us-ascii?Q?cXHmw8NpHauMQtJl0Z4a0Cw7H1w69rMlj45SZWAJeRCfIIVnu4wYmcxoRAU?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?G/Mvd5OfU4+WeEMChICK8BFGnZiyfvZf9CrP1lzD7MhAU2jk3EuM2gs72H7t?=
 =?us-ascii?Q?VInByyGcad7TAdBCwFOtnKxJnxg+dNghRB2Z9lpu5Rw7bw6VoamfOkc+3FU/?=
 =?us-ascii?Q?cPW7H1ErX/VOLOEIo41dHp6RSVCCxzkoGaX5otgQIq1IwiY3pK/8eAKEZ2Y/?=
 =?us-ascii?Q?DWFLCt6v44x/jFcvD/J55fNNssqqWB+0p1QBKWi1QbkgiZkqGiEP8+QF/oHx?=
 =?us-ascii?Q?jSPci+Q40eEUexKbS7A+k4G/xEUbPFe5Q+dnSd9GWm8hwXKpxu21EwPj0mh3?=
 =?us-ascii?Q?CN3t8VaT9GHXojy+vJVeVOWG6DceoTJNipNlmvErDZwCFMOyYD5GzODOeR0H?=
 =?us-ascii?Q?hIiiNDHh4ZQY9ZDDpKrtGLnf5L8SBk220UEFVh6VfnBy/oHSzf2luN40EAmB?=
 =?us-ascii?Q?0Fx8QfASVeq9APB/+Ov7RZDw0rRodw4HDTx1eNnD0KlMWcE/qZNxNm2KFQfR?=
 =?us-ascii?Q?LcNZ4lOf8vtoPbxv2p10VsvyRMzw/xFRYKwkTd+AjTZI/6OBcxpuTvmOWO3u?=
 =?us-ascii?Q?gfIYxrRzamuzbbOWzYKd5ydYXONnRQiG4N96BvjL7CZOLL84xYdUi4XfYvNO?=
 =?us-ascii?Q?rfwa97NHKhB6n+NtD9HoEmDofObhdjuMkAUOaTG1N9w0CcbkHoMs5DsvFhrE?=
 =?us-ascii?Q?AuI00OHoEB9OKWs3cZp4rnpSw5U0Wn/lNB40eGHcIbTj+jcIfbjfjQeSJLLE?=
 =?us-ascii?Q?c41msq1KORom04r8hePL3LofNl7WUqgD3vTwalwMMSj++c83vG043iJ0d/Nr?=
 =?us-ascii?Q?lIixrXIYx3nAZFSc40i2jsDHF+U5taJyFvJDxIKN5oJ8AH7hR6jKQ67fSJCh?=
 =?us-ascii?Q?FtX6TAm2HDyjqwhUOh/aSH8LjH+5eDacEiRMCG6UyfzTt08ojIQZnZALlzNS?=
 =?us-ascii?Q?KFxN0XyAwsWo8fdQS6c+jRkoq4aRdZ3L8d3zTMc+PC/k0oezFKyZ+RK3gSt2?=
 =?us-ascii?Q?AhK7ori/yUXyvL5n/p3j3mbVJe/e284glqvCJlMjxUZ9taD6TH+uSUC3kx40?=
 =?us-ascii?Q?wUEp0OAhXWgxO1jtTmxDNRNQFDJXAizPh/tb+x0kcxvLCgc/fajs378SJ5fa?=
 =?us-ascii?Q?qN1gxXMmHEwczbwOBs94mjcz6DVXMpOy8BH0yWBK2uHsNMMbX1ediXBEilmG?=
 =?us-ascii?Q?/3PUv6p3JQZ/jByNTAHpMz1SqaJ5R9MO71RgqjXvA9/mYjqDHi0qizOUWhBd?=
 =?us-ascii?Q?lE3o2kH9MJSXzFqINWSOiov0nFQ9OJeQMC7MoKWuNDBFT/0Bs6IyzowO29za?=
 =?us-ascii?Q?iGG/wlsdyWCGzy5sTkFSd3xgSUm6y82o4cYfF9SVVpKGR5b5dNG0ndp0pAk0?=
 =?us-ascii?Q?2cyrUk6tAk3JMtCc2uv6mggKmv5yA7/8mzwoA4gbUE+5bPnxXMyYxefhpQ0r?=
 =?us-ascii?Q?ED2pBOH0KtJV1RsS9TgkXv9VVXf88yhQdsaKvHf77w4A4XkuASSo66XD04H8?=
 =?us-ascii?Q?EVYutSF4rBCMxERlpPmTylqfd4aGptsEII3gp+QPiLCmcXzb0tceHXbGnoOX?=
 =?us-ascii?Q?LmmVX4CL60Ey9O66qnYML1eND0O7RQwaAsV5jYQjSfDy+FX8bSmqJsB57liO?=
 =?us-ascii?Q?rZ4SwUklXaomxKcXFuuudF78jWanx/h38TnuUpUp2EHX4sIzI316OK+TOC6F?=
 =?us-ascii?Q?4Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	za926BJGhEM03IGQxecWXPWtgs2+LytA4AiijLxlLcy6ZCzp87vYTwwHcM4ehPqTPBvgJmLR+Cs6CcvYJesfCWVMTRjVcZPUgSbqJV/LJ1BsoS11rHmLRbNgU27rcO87hY/kJ6dX2xUtBKKLb17IMDk7TDSopFP9ZZL0bf2S29MublzWISuboFPaOYzWM3SVWaMU/MEMZUmYCkSETeLq34R/zeNOyAiN9AOKimJhek+gd1Czd2Ozgb52HTh0nL807QQZHS+Wt7b4MA+cJ6tFxOxbERPQs9aFN665CCMisEU/cFG/VR8/7ome3I9KX/bJ/wiqJ2/yu5q+v7GvIcVi00dJHMlAg3BOREuEuh3owY8KxsMC6h612vdOOcIDx5OQEJWwlkMF7QRq27eYI7UxSznDTz1Ib4r8hCfXeYxTb3Piuz29QMJsOCqVWW1lfL6NQowr2B563C1AM7uRjT7pB4o4cXk7PYdLLMqEiEaMNgM3IyiQVM2e2i3bxM9JJ4pIneXIXKYs0PveKq+XOIHOddxQlr9hGL0UgrGbkeSAU1faN7BAEKBcD1H1AAx2Ing3qZW5deM5QagFY99KKm8S2HU7HQ+pBuTPclKrFcBJjrA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db001b31-e4d1-4c11-b09d-08dc7eae381b
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 00:36:31.1563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i4z5qVetcSWuQjyczfVmB8DCKHaTsZJOxu9f2ZU/fWFlMOQ91FlMdc8wNYDcG0t6PVBfV6RCPVS0WpXGwBRRMFzHadNy3YXI57yiDxNGmu4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7177
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-27_06,2024-05-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405280003
X-Proofpoint-ORIG-GUID: WmDCV3O5eq03Q2rIkM4yb7taqbiTWBkb
X-Proofpoint-GUID: WmDCV3O5eq03Q2rIkM4yb7taqbiTWBkb

Handle RESCHED_LAZY in resched_curr(), by registering an intent to
reschedule at exit-to-user.
Given that the rescheduling is not imminent, skip the preempt folding
and the resched IPI.

Also, update set_nr_and_not_polling() to handle RESCHED_LAZY. Note that
there are no changes to set_nr_if_polling(), since lazy rescheduling
is not meaningful for idle.

And finally, now that there are two need-resched bits, enforce a
priority order while setting them.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Originally-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/lkml/87jzshhexi.ffs@tglx/
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/sched/core.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index df8e333f2d8b..27b908cc9134 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -899,14 +899,14 @@ static inline void hrtick_rq_init(struct rq *rq)
 
 #if defined(CONFIG_SMP) && defined(TIF_POLLING_NRFLAG)
 /*
- * Atomically set TIF_NEED_RESCHED and test for TIF_POLLING_NRFLAG,
+ * Atomically set TIF_NEED_RESCHED[_LAZY] and test for TIF_POLLING_NRFLAG,
  * this avoids any races wrt polling state changes and thereby avoids
  * spurious IPIs.
  */
-static inline bool set_nr_and_not_polling(struct task_struct *p)
+static inline bool set_nr_and_not_polling(struct task_struct *p, resched_t rs)
 {
 	struct thread_info *ti = task_thread_info(p);
-	return !(fetch_or(&ti->flags, _TIF_NEED_RESCHED) & _TIF_POLLING_NRFLAG);
+	return !(fetch_or(&ti->flags, _tif_resched(rs)) & _TIF_POLLING_NRFLAG);
 }
 
 /*
@@ -931,9 +931,9 @@ static bool set_nr_if_polling(struct task_struct *p)
 }
 
 #else
-static inline bool set_nr_and_not_polling(struct task_struct *p)
+static inline bool set_nr_and_not_polling(struct task_struct *p, resched_t rs)
 {
-	__set_tsk_need_resched(p, RESCHED_NOW);
+	__set_tsk_need_resched(p, rs);
 	return true;
 }
 
@@ -1041,25 +1041,34 @@ void wake_up_q(struct wake_q_head *head)
 void resched_curr(struct rq *rq)
 {
 	struct task_struct *curr = rq->curr;
+	resched_t rs = RESCHED_NOW;
 	int cpu;
 
 	lockdep_assert_rq_held(rq);
 
-	if (__test_tsk_need_resched(curr, RESCHED_NOW))
+	/*
+	 * TIF_NEED_RESCHED is the higher priority bit, so if it is already
+	 * set, nothing more to be done.
+	 */
+	if (__test_tsk_need_resched(curr, RESCHED_NOW) ||
+	    (rs == RESCHED_LAZY && __test_tsk_need_resched(curr, RESCHED_LAZY)))
 		return;
 
 	cpu = cpu_of(rq);
 
 	if (cpu == smp_processor_id()) {
-		__set_tsk_need_resched(curr, RESCHED_NOW);
-		set_preempt_need_resched();
+		__set_tsk_need_resched(curr, rs);
+		if (rs == RESCHED_NOW)
+			set_preempt_need_resched();
 		return;
 	}
 
-	if (set_nr_and_not_polling(curr))
-		smp_send_reschedule(cpu);
-	else
+	if (set_nr_and_not_polling(curr, rs)) {
+		if (rs == RESCHED_NOW)
+			smp_send_reschedule(cpu);
+	} else {
 		trace_sched_wake_idle_without_ipi(cpu);
+	}
 }
 
 void resched_cpu(int cpu)
@@ -1154,7 +1163,7 @@ static void wake_up_idle_cpu(int cpu)
 	 * and testing of the above solutions didn't appear to report
 	 * much benefits.
 	 */
-	if (set_nr_and_not_polling(rq->idle))
+	if (set_nr_and_not_polling(rq->idle, RESCHED_NOW))
 		smp_send_reschedule(cpu);
 	else
 		trace_sched_wake_idle_without_ipi(cpu);
@@ -6704,6 +6713,8 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 	}
 
 	next = pick_next_task(rq, prev, &rf);
+
+	/* Clear both TIF_NEED_RESCHED, TIF_NEED_RESCHED_LAZY */
 	clear_tsk_need_resched(prev);
 	clear_preempt_need_resched();
 #ifdef CONFIG_SCHED_DEBUG
-- 
2.31.1


