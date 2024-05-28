Return-Path: <linux-kernel+bounces-191548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A238D10EB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 02:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C3611F21C9B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 00:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1027AEAEB;
	Tue, 28 May 2024 00:36:06 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4558F48
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 00:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716856565; cv=fail; b=YgaX69dLeY2/1El+jyvsxPAId+VjH3nHP4q93NqYJ2ido+Xtj5QYPurC8/Pn0wMEOTSSO/SddVwRbW5XJc8rX2nFtbMxxzot2Jta+78PxMvyHvLFI59SEDee6lzyTo5SxGcWPIIjulqcbN6dfBSNr7f5Mr8zxQRWaADIHWWrBDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716856565; c=relaxed/simple;
	bh=8OE9K0DmTCAvJF/4RkpmXLEUXS6juMXHvI2cb+F40uw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AyGsJEZ4loIrhr5ULogYeCl3rBwcwDDlADpEodG5OoY7GDexdPgeSVHRGW0o81G2j11oauwMEsthqOU+dAiZTx3uFolTE+jgW0o8uK5nG+1EeNwhb+GaE9ujc2Jd/5ax0dX6tviNPaS6Fdcew/ZZ6MH8e3jK7eg6zrun8bBe6Es=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44RNl01J022022;
	Tue, 28 May 2024 00:35:46 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DzAf+f1zKciofH/Sg6L+tAS+6whs23BpJstbD2khy6i8=3D;_b?=
 =?UTF-8?Q?=3Df0n8B01IMcHDpcftMZSx0DP2gfYB075IC7Y3ViRsZe72ovb4BxyJIM3MzaGT?=
 =?UTF-8?Q?wfuRdZn6_TfuDzRQrmiXw+jxMx+jjpEE22uk8vDpf+iKAPLPdjzEH5mCfXDAl59?=
 =?UTF-8?Q?l//Hdn/30Q7Sgn_i5fL73jraLt1snqoo2PSohZqpd9MFfmBuzTcCw/9eJkJnzxK?=
 =?UTF-8?Q?mA6Th5t7kv/zibI8H2WV_20A0osBCqxa4vRA+I6h399dW+ETK6cIEprJoEyhX9d?=
 =?UTF-8?Q?pnJK52QieOc91B+ukFDMJfP/sU_Z3FArwQu7hqXrH8s07COyzBCCJPyBWz70l2L?=
 =?UTF-8?Q?XbqKUYDuQlLfFdYFaXPHrxigBsawffk0_KA=3D=3D_?=
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8j835q9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 00:35:46 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44RNFf56016169;
	Tue, 28 May 2024 00:35:45 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yc55vtfan-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 00:35:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jTq7LCwbmJacgk1Q0UDnpWR5B2vhJKXN5cK2X2TlzJtyj9v/Dv7Pu2s6Za27uqIAQAxcNzfSguLLX+SwiYxvU6LHBMhw3kH63JltAsXQZNMp7k9KUAUr4etGoczo39uvEK5KgheqUPMI+CFOLnsyr8MxCCzwLPYv5IFrr3XCJj4xBHHNuIBRgfwNycviwL5CtWI3MMvIEJTjNbGdhWHcNOdQuCN6dRBCLjcug+WF4vFSJHezDi9bEMof9xV9BWTvO1v1M0PUhmtoKXMjEXxhThheLtbJdGCOfVX9IqktW0Aqkd7Y9Mv6OjPlVPxfrjV8qdialK0LE9yKBohQgZCtxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zAf+f1zKciofH/Sg6L+tAS+6whs23BpJstbD2khy6i8=;
 b=bTWG5nk09J6tiZY6/XSaHPpvKG8B39C1Dx7xWMVcFqbWksSRPlC7p3/XuSzbs+uSY4LmaEk8gQQqmotFfQCikqTw2nUvD4Ekai0ONI6cvROh8vrrYzzXaExPKTHPZgLYWZh98XW9UL28ZVCs9AXLdmioFsnDwBrHGUwHdrMIWGRctLz2Q8Zd5GVofEvyqqfzJINiRpz+b1x4wtEBOkfgf7TGYIIV/gwOnKF9CLXA/nnxOCuo3Emi+nktXOKP9f3c1csVEZ1Js6dzT4uliu9tba3AQH2gQ/fWYAUeiRpsAWHklksj0FbLx80klVAAjiNgkJu9dSRQ5XVFHAjLLN1Cag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zAf+f1zKciofH/Sg6L+tAS+6whs23BpJstbD2khy6i8=;
 b=yoPHo74JUJv5wlwarDFIjM/GXxQ1pFqj+YUHdhtONilNJeh5Cxj5H+ROb52ZmG1Y4/ofEbjQ6iiS0UyT6sU1lLuHtTNt6Org4S9ksRktuqq+zlRspVekakeTAD8Ckulw6gjC8zxbe+W34NHFstmgxTWUUAC3p4si4SLe2cm7rLs=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by MW4PR10MB6510.namprd10.prod.outlook.com (2603:10b6:303:224::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 00:35:43 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%4]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 00:35:43 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, rostedt@goodmis.org, mark.rutland@arm.com,
        juri.lelli@redhat.com, joel@joelfernandes.org, raghavendra.kt@amd.com,
        sshegde@linux.ibm.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, Ankur Arora <ankur.a.arora@oracle.com>
Subject: [PATCH v2 05/35] thread_info: selector for TIF_NEED_RESCHED[_LAZY]
Date: Mon, 27 May 2024 17:34:51 -0700
Message-Id: <20240528003521.979836-6-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240528003521.979836-1-ankur.a.arora@oracle.com>
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0154.namprd03.prod.outlook.com
 (2603:10b6:303:8d::9) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|MW4PR10MB6510:EE_
X-MS-Office365-Filtering-Correlation-Id: 63967a97-de86-402d-b81c-08dc7eae1b73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015|7416005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?QZW/fIlc9mLzvI1jpgbVNcVpMC88i1sHMCwJYVExIctUpT9bt6rPuFUmHeBO?=
 =?us-ascii?Q?uEawu/zEywkdAkQ+0ktIwnDtCCIskkFtDYJz6LF2tKLu2jhhL1S4Wg3z3dmP?=
 =?us-ascii?Q?PjnBs4dFPMY4B2C+AnKx1RLLIxD5dbg51usR8PCvoLHlfMEpRfJ5bEN3R6vx?=
 =?us-ascii?Q?I0KTkbddM/1oiO8K38epCtNEDJIKORkKYoErfKZ6YGV/g03q6WdEdUPVqa7g?=
 =?us-ascii?Q?0CjtjupgSNyO3jpg2R9dvfbfZA9g0hanbmk4VnK7oQYxXPHBg32JafPtLC0F?=
 =?us-ascii?Q?V9EsWOtrwmcDRXg0j7C0XCD5jBR1PvplMAV/XVBBuYCESxNGisXRKJzUTsCY?=
 =?us-ascii?Q?Q/dBwxvqa96Kot8pHlXa7UkI3fs1yrEL6rxMCZEJjOFd8Ttrfyw6UlaOiptK?=
 =?us-ascii?Q?iZCVzIM3+escc9dodYA9PVvgUxDo+zVhB/U+YJeVYVErE5u9VYM2O9WvL00C?=
 =?us-ascii?Q?VWoxJAw2YGT5tL4bYUQYHtO6pEn+lHOWuu4uKVPtqzKO5cZ/I6kQtDwuC3tK?=
 =?us-ascii?Q?8jw5hvs4kStPNaelQQH3F/lsTbNeW1cRdMv39wX/7ERfcJTWZnF5+YQ+v409?=
 =?us-ascii?Q?h479Tb849PSNR/cnUSVRAendXY/X4D7frd2PYxjbupq58t+VX4GG708XGEfy?=
 =?us-ascii?Q?4EZ+kVUImVJcZWLmV4lgwSP65bdXtSDe4WLUcsBWT04u3oNiWKhoJBs1aG+G?=
 =?us-ascii?Q?XTm+3x6Xf5FwtrMUw3XryxpMy3alIwaYcW7LFy+g0l8uBXa8ZKEnaWb8QbR7?=
 =?us-ascii?Q?z9xCpYBllyUzsCc08dnrIRlLgPX/yChCSY25YV+o68d3nOHaAuVao1wiHM9y?=
 =?us-ascii?Q?pLlwC0IyMYYVuR7sBOgupBy7y2KuD6ohu0E4APnBllMw3ozavm5TNlRgaFVw?=
 =?us-ascii?Q?hj3C2YETPFDwIwxkFj3yAZTZ6yiE8hvM1wvmQeWWUvPe8K7dCRDN2r4iPIjF?=
 =?us-ascii?Q?gaaJdAqZiF7rN4ysOSzKaq5v03q8+itI7IxjkEz2EGNCkz86szh6ARTJr+iB?=
 =?us-ascii?Q?GwrY4IjZkA7pq7Zyu+kJOhRZlVMfkjesx4FjymRhTG39mDuLBo+Kkmp4F9eu?=
 =?us-ascii?Q?28JxkmnhePUF9lnUaDugj6Xbj8Iui/pYYOrEGk6i12ZHYgLVi5KL1SwQGTSs?=
 =?us-ascii?Q?OX9rEK2lc6P72Vx23q8Oqs2q4MCdrbKqwP+Xnf1IoAW3xWZsCMqEYseZ0NbO?=
 =?us-ascii?Q?Qee65zRCrLcBIuqxTaaOOznBjivj/YvZ8QhLziUrVG9jUkm8Mj1g6TdrwIY?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?2KqIJr4xvkUmaNBY2jE59vrY/NvKvLVNTwEiBKvgboVU6tJ2Kj+Cpo4BfNnN?=
 =?us-ascii?Q?yUbyhLbozE7m81jX65xqSAq5BNI5uCeytontdPNDk9Bhvh+h2k9zaEBPrzRY?=
 =?us-ascii?Q?dxN1A6cMsm4TbNxc+pYMReX9aOwEBIsQ9SFzk1zOHMfemozlU9fIzAzoiptA?=
 =?us-ascii?Q?ntNRRZgW5ai1mJK+2Pt88J04ftkUoIxlJgBf391ulwoierK4+sf/hYAVERil?=
 =?us-ascii?Q?P7RyYHDbOnHSgBMOT5MgTjWCq2Z+iXX+Pv5jd78vyfmAnErK1NojSG1FZNiI?=
 =?us-ascii?Q?xSNERKMn5iCnvWu1Yh/o4aYqhJvtagHc42B+W4LMNjR9XPVadmw1z86QAujZ?=
 =?us-ascii?Q?or1ABAWgaE5WMBFCrswnflS20vnWnyz0OuK94FnFQPU9vrqso7KyMNSVUP5g?=
 =?us-ascii?Q?sPBwvoYglRUrlDcEd3M13uMyiGBUJIGYr4APVIs1ZYp3wOUAVzFMaWetPsoX?=
 =?us-ascii?Q?Jd+eBq0wZdexWPKKyN53Xf4V/+Td9ZR8RbY8p5JcJADYeIAFVrdz44o3Whe4?=
 =?us-ascii?Q?sEB33cGT+MQ1/XebIsAdb7DpPHXaZstynBSFbJOYj5BjwlLU5J4PzhLJG3Ct?=
 =?us-ascii?Q?iyTSPmaeRvMzZuD2ThRaCew8cXBoFg733NQ5OSa7Qtf1SymdJs3AKjYMf1Th?=
 =?us-ascii?Q?dSuR6NqK7sloDdmuuecxePj8gmow5aE0/4xY3ijr/gZqNH+wixElOq8GHbS8?=
 =?us-ascii?Q?B/oVU8hwMV9GdLNFclNQNmGse/SByi3zMzpDTvuA6cfWnws7f2dqutfKuk2v?=
 =?us-ascii?Q?PO1EOFVNqq36HFtuvxkEduspvR/0jC4SVPQUcgZBKbAelMugnTd0AQIbKDwd?=
 =?us-ascii?Q?Ff8UpEAgiI22KPCxVaEeK2EgON1WKVGV2e75lw0VWywF1RXmnNHvK0b2uYoy?=
 =?us-ascii?Q?gq1EHxKn6Gm8CdVQ7+ZY54YUNIQ7m4UySzUGmQihNkgh0v/xZIM8Hx2MwMSF?=
 =?us-ascii?Q?4sSGU1XF+gYNGFW/PqWgdbwQt6vdFoXubIE3lGzoXvhadZ/VUY+zABs4js3I?=
 =?us-ascii?Q?Msamc5kln6EYc3ClJL1NuhinHx0I2bqbdfCHWFWJg2dlFmQV1x7YzQWu6oV9?=
 =?us-ascii?Q?+LPx8pTnmAxk0uuF0MtbthUIy5celsLv6N++UzLReu4UIjzjbxwLbZfdKDDV?=
 =?us-ascii?Q?rzbl5h6DYcKHPbf561d6vswrUGeCbUpOAYz9F+76C+pY7qtW4v9P0Xa1d5qr?=
 =?us-ascii?Q?MjTue0f0KjMfnWE73+hHal70cMCO9BrlDXfize4loxMsPW9mXhemXTcyUk6K?=
 =?us-ascii?Q?2LNm9EYmFUaj+lWgxl9pYSnn202C+uOXwleO3JQ8TX3RmOb/bAEO4+CU0ve5?=
 =?us-ascii?Q?RuMtZS9op1a8V13xGocG6oWQ6Dhr5vC2VwcoskPvZjOJBjpNNyCwN72xS4cA?=
 =?us-ascii?Q?X25Mb8BMe7a5QijW3U0CtJjciEtSu273n/oHFkYLmTAqUacEw/tIVg8UYvwE?=
 =?us-ascii?Q?t57R+8ThG9O50+17jE+Tk5CccizyvQpCowKwDCFKeHTIOXZ3r04TUUSrTvFu?=
 =?us-ascii?Q?t8cJ/xpgUeyyFlbeDJ85dqjRj8f932e2mRCk3g6UHSvlspPVshI+rAgdVMS+?=
 =?us-ascii?Q?ZRx3dI7eJjYGkSst2yi04JvUIrpIEORAn1dHvCJZqbfNrpmc8A7tgdVWeWrD?=
 =?us-ascii?Q?Zw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	mkYomvbKTQSny/5DtHo+XmTGzOs6DUxeRuBHTouCgEDAasm/qCT/xhAuuDn4BM10V4n21KsiossgpgjlCmmDH8zgAFkntQ0T7E/leNwkhJ3zj24docinN5k4fYC3DjpxuZBkXCX0oBGB00iUrDEkhwcrCDBv+U6dkzuF+tK6QvVcaABR4rlubSYc1QFTVn/KIkXLXOjzlp1SKegAYE1/b3DfgMwnPZsQLGORNhf8nfqHd9OnPHyhNXylckfulRVlUISx1WryQPKv1zlE29O0Jtkj5OBZopr8MksjLhg5lgDuBO6b7XYC7IL4Em35fgkNWkVekAmN2Z++T1qLjecdm5LLUdJoapTi4awsVHhf01pUAs+iI6dSAwsrBqAgLTiokoyOXh0UrJaVavFmZneLATGP2AmFor3u8f8QaUoy/69nutZ6UtI+sXh8k2VhTNPSdVbQ6XJ3T4INFHR6WUG0X1pI4JvcsKdrsqu4WiVqUMxQCZ5+cerz7iLT0QihXeAZghyGR7yGI8lpiy+CDFzCpIdoBb7zlA+H1ECCxUE/RZSH+2FOK2xPyFUi91+uCm4YnOwCl3mjqMFTkH+7x85XkKFs/24zvomwpN73eGv7PJQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63967a97-de86-402d-b81c-08dc7eae1b73
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 00:35:43.0478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SqRW4Hvo321tHpmVsIcRPJTuAgOOUuN5zH6BqPxasK2c39MFdWHdStQa02N0N0ekmdDOz6Yv2kjzKQsNBJVSKRYWUAdftXEimfLruOFtUDQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6510
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-27_06,2024-05-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405280003
X-Proofpoint-ORIG-GUID: ihoVAeVCkfAGiLw6R_YXFoTS08YLuPpi
X-Proofpoint-GUID: ihoVAeVCkfAGiLw6R_YXFoTS08YLuPpi

Define tif_resched() to serve as selector for the specific
need-resched flag: with tif_resched() mapping to TIF_NEED_RESCHED
or to TIF_NEED_RESCHED_LAZY.

For !CONFIG_PREEMPT_AUTO, tif_resched() always evaluates
to TIF_NEED_RESCHED, preserving existing scheduling behaviour.

Cc: Peter Ziljstra <peterz@infradead.org>
Originally-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/lkml/87jzshhexi.ffs@tglx/
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/linux/thread_info.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index 06e13e7acbe2..65e5beedc915 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -71,6 +71,31 @@ enum syscall_work_bit {
 #define _TIF_NEED_RESCHED_LAZY _TIF_NEED_RESCHED
 #endif
 
+typedef enum {
+	RESCHED_NOW = 0,
+	RESCHED_LAZY = 1,
+} resched_t;
+
+/*
+ * tif_resched(r) maps to TIF_NEED_RESCHED[_LAZY] with CONFIG_PREEMPT_AUTO.
+ *
+ * For !CONFIG_PREEMPT_AUTO, both tif_resched(RESCHED_NOW) and
+ * tif_resched(RESCHED_LAZY) reduce to the same value (TIF_NEED_RESCHED)
+ * leaving any scheduling behaviour unchanged.
+ */
+static __always_inline int tif_resched(resched_t rs)
+{
+	if (IS_ENABLED(CONFIG_PREEMPT_AUTO))
+		return (rs == RESCHED_NOW) ? TIF_NEED_RESCHED : TIF_NEED_RESCHED_LAZY;
+	else
+		return TIF_NEED_RESCHED;
+}
+
+static __always_inline int _tif_resched(resched_t rs)
+{
+	return 1 << tif_resched(rs);
+}
+
 #ifdef __KERNEL__
 
 #ifndef arch_set_restart_data
-- 
2.31.1


