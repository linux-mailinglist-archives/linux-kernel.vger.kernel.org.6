Return-Path: <linux-kernel+bounces-191549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5C18D10EC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 02:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3352282067
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 00:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713D214F70;
	Tue, 28 May 2024 00:36:07 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C98B677
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 00:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716856566; cv=fail; b=b5g8Nf/53gpwMePVdShKPgisFa4xP8czMSea82xPpm7ZliaRi4fiQqddxyzyG3hw6G+3TGSNmmrEKXiuYLewppgYY+6oi9pWU9yhQgW1+zZRr7jutLVkKf+kVZadt/FuXtOcTHraSScTXU4Lz+9QrrPQVFFKXjf5sjY0mZ+ZkD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716856566; c=relaxed/simple;
	bh=snarRsXQS1FAPmvgdH09AD07uKuHTd85iIVioBJacBI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=efoTqA0W+shbQiCr6M6cwpBfaBHfb2vMhYRraXFfwLl+patjBLRwnE0g8WuXFjFXL7yvnU6TuHx5D/Kr5Zfwpe+Gxwi3M4XHiS0EQxPZ5c2mGX/VZroMhtQfnHFkKFjboxHH2dr0AMij1PKDiBMUb6DoiUxsFNr4VBPjptl5sxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44RDI41b025151;
	Tue, 28 May 2024 00:35:45 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DH6Mb6y2pMWkUal/7okOvDEZ8FCrKr1TLLm/tgE0Q9MI=3D;_b?=
 =?UTF-8?Q?=3DgmOLwkGT6MvQDaRLmteQKyJu18Y6iqzmUeQPs2mYUpTglMzf7eu+tQ8/cv9S?=
 =?UTF-8?Q?xJfCQKlx_RJLciUzeAyGRupf9HZIEIeMJlf/i9RYyNn1Ix9ckZwISvLYo0ikQts?=
 =?UTF-8?Q?660RwXy0J04pV1_uogp/TPlKbyUl+DZv+7PuTOtf8xr40fiZip2pInD7JwYKCfX?=
 =?UTF-8?Q?ckRvM8SS8C4sys7UKq2C_WNMyd91UNfsXgDhMfWTMu0/g42rbF7tkAdfc4AAzZy?=
 =?UTF-8?Q?5hw3mvLW9D4ivjUnd0QCz7bHrA_hBqkbBhJ/BFgjaoQ31t16Gvn8nrt5w7dkj/C?=
 =?UTF-8?Q?hKRX32+xxl2pAl1RAe06kWXZ3lXHmLeM_LQ=3D=3D_?=
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8hg39at-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 00:35:45 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44RNFf55016169;
	Tue, 28 May 2024 00:35:44 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yc55vtfan-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 00:35:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OarwYiPO3SRPD40vn4JORN0VpOMKcmAVpNFbb08NFxTuDulGNbFhGyhu7La7SncM4byfmH+Cl198y9g4OHiSuW9+nyHEoAYm0TW+LtzcCkoNLwyyNhpSsaUzJnnURLQTf96/vk8tyOQyTLFmFda279vMAVfutwghuj1T4m2EEnE94KA/cljR3EIHnWA62GT5ROP9kMZFuDajY+0QFyj3rL4I4yE/lBIOJI/Qr2kK9RKTvEL/0DNuWS2eLa5G/Jog12QVi/jbKI/fqzsG1wDPx6Cv8Uq7d7vGQyoL5PUOYU4dcNKmh3C7oE06C+Jeezj1Y3ESgMtY8Wn7B9FAEVZBBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H6Mb6y2pMWkUal/7okOvDEZ8FCrKr1TLLm/tgE0Q9MI=;
 b=YBr9lhnyYlAZtQL2JvsKXKg7j8pZZ82IP09xHkWl/+ucd2gYB7Gps7st2J42MAeuQu78TXfz/c0YP43OLtZ2k7rXpduc8EXovSmRiglehLz5DEGdvIEc8d8Wd0OK5PuAHyuOwE12oFblUE/tsS14d0NtdySKFcbWgh3XoCdePJMKB9HbIjDcZ/gQrrR5GzAhbYz0AuEtZXwM4bnu7Vj6jVfe1AzNP91xF+c9ICzyecgpDHK4nHwfgA1EuTsSZpo0bste3iRJPau1/TOHVXTETnpjS+lY+Vd7P+N5kN32klkZvVJK4k6mbrKJfBYKq21vYrDK3LtFeJEX/RRbsuQpaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H6Mb6y2pMWkUal/7okOvDEZ8FCrKr1TLLm/tgE0Q9MI=;
 b=QAPzUxeFU+a53T8uv7ZFfohhVg8CAZv6/MdQ+9xKv9ubkh8q8O8kbrRdcArWbnY5Cvyi5yAlNeAspEbMia1BegFLDnDtU79jEvq60d9uJa1/gmelbcOSOwsK6gR/JlVTOrKCra0Q5m8GDnmpcQXe+/rBZrQ3daTG7uX5A9sVxL0=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by MW4PR10MB6510.namprd10.prod.outlook.com (2603:10b6:303:224::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 00:35:41 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%4]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 00:35:41 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, rostedt@goodmis.org, mark.rutland@arm.com,
        juri.lelli@redhat.com, joel@joelfernandes.org, raghavendra.kt@amd.com,
        sshegde@linux.ibm.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, Ankur Arora <ankur.a.arora@oracle.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 04/35] preempt: introduce CONFIG_PREEMPT_AUTO
Date: Mon, 27 May 2024 17:34:50 -0700
Message-Id: <20240528003521.979836-5-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240528003521.979836-1-ankur.a.arora@oracle.com>
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0287.namprd03.prod.outlook.com
 (2603:10b6:303:b5::22) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|MW4PR10MB6510:EE_
X-MS-Office365-Filtering-Correlation-Id: fa62f423-971a-4a3b-f7ff-08dc7eae1a29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015|7416005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?QdfTF4cCXIPOmnSgGmcUKo0IoKoquGP0Hp6y+OuHh7+jxemrNT8ti0pWhFvu?=
 =?us-ascii?Q?raCaqjku3rkV7E/Lp4LegeCUVWMplSJkJKU0ogSaIRPbB7w9IN6jXqP8JvRA?=
 =?us-ascii?Q?RwXYZ4E5joZmG2F/+SDbGCdRiu7dPg502kJwCQBGZTEUNAzrSX6RDEr4fWYx?=
 =?us-ascii?Q?xKrDyv9WSmEIylaMjX8KXjWyfSK4aulDbK9nBhxvuItTyO8zJXNij1/Y2QwM?=
 =?us-ascii?Q?kKHQm6yXddME2ElbBDCxCcCwajB+DnuOnanMauxdKzRc+iuL10hP9D7S6Lgg?=
 =?us-ascii?Q?j+uS4f46rpwAZr1JUOhislYv2uHVlb4JiIiEqMUf5dZ8xogPsT7tHq3S5wL1?=
 =?us-ascii?Q?UdUqdN2oP52OvqSNnjrd5yJgxVOTsGH7p2ygAKzGDNNKS/xXMUyAGVhlj+mZ?=
 =?us-ascii?Q?UrJ26C+xrVfM5h9xehfhYw1RDENr1j1aRupCkiHL1g+u1nFAORcvcCGDA8vG?=
 =?us-ascii?Q?zPrl/cNJdsn9xTzhNN+9s1MRH42KSxk7w1zbvc4DSaiRbadEhlJKHKgo71is?=
 =?us-ascii?Q?Qbwv2RUV2/+3rCt52Dyhzdz2Hhf5egdt+7E88MQF1da7D5NIF/JwmN5QBuRR?=
 =?us-ascii?Q?GuYBKDFD8n9eRx8f08K4/3jMB1VPm3A+yc8iIfqmM7fOniTQk5kvkJquAWhd?=
 =?us-ascii?Q?/2yx7gViD7NBwCPkREA4p/M5f0Jqu8ZJ+SyrpFMz35Bn5eFt2wwVqTXx2uWa?=
 =?us-ascii?Q?vZ7GJUAeJAA8rOwYR6cvm6oxCmVMj9PlS+5J4goMYgpXeAzgg5mYTgj8ZzMl?=
 =?us-ascii?Q?YsBAsA6HF8gYgguh2YrD30xSZF3CH1IhmSpdkUjKqOxbFpSrgDMUiPZZy4Fv?=
 =?us-ascii?Q?fQmX6eTudvtuzSMD3kzMLrCBOGwPCBCwwZdBlMWNnA/OuFe9BQ2fK2eSusbe?=
 =?us-ascii?Q?BhfoVQQNfAQIl6pXQV+lFivQbE2KjR/tZY6teepa6oTFzLzYAQ96zvDVYH/L?=
 =?us-ascii?Q?dbuyM/AyJZNnv9AjoJ5IYndveuGYNkCouj7HXMN01dhnVLR0QqzoLO/IcQ5B?=
 =?us-ascii?Q?bu3jKsHNMt98NE/2fH3bE5pgDzzPURf87cSJXVInSGIASn2YvGbfcOECuvXf?=
 =?us-ascii?Q?Jlc8sVfHWZILkH9mDohwcXMUDqnJkjzJkSkBV1TiBPMcnhZzqeap8pkjuu7d?=
 =?us-ascii?Q?4ulqtVSwavYTWGl4N+Nj4/mYEZH3LnYNcuBAe/MPEGoQAyRABhIEZROKh6vW?=
 =?us-ascii?Q?T7oysUK5waKXjPFMb88tv4anZelpFAzPpZVosA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?tc9nBio8pm5K9oKsW/ZkWrGQL7+oaiFx8uXbEYW7ZSrK+Bu9s9/ik9cWC5Fk?=
 =?us-ascii?Q?7BTWRPdF7VrPdvHjZChfZHfHWOKhUFcMaDN5HjuqWJPtvsxRduPgOkUkIo7Q?=
 =?us-ascii?Q?hla0+1qhVxPPUOjndpus/Mqr5HLJX35tg3JFVbFeKmaV0+0dxvAVW/O0jSbU?=
 =?us-ascii?Q?x8nqBVbkNM5aXLskiDNQzAYuejk1zhCxvoqQ7xutH8QqKC1WDjkRc2r8ZkZz?=
 =?us-ascii?Q?f8D6IMAAqh/2WTyDhbrdATab10/M6q4W6Cph6IpU+7eIAmbrdtpU0D4wnzhC?=
 =?us-ascii?Q?wau9Zbz+uWxDgK7ULHQRhrFDKwco8AWmD8oxrU+vb6nzhOuvTd7uNK2tqZ/5?=
 =?us-ascii?Q?pjsPxNAUA9Xeki3kTDIbyhtZgswSUBewDw16T39HliR9uIplqf3SK3q6NC8i?=
 =?us-ascii?Q?dhWEzZis2qBBEWFFQiL5/kYSuqLrapE/Uv1evZ37OpJxxntJoC0tKU4QVcv1?=
 =?us-ascii?Q?eLbLeEQwuuKC03TO9XSvyh42o7nKLchewm94eInaSeD5W4HCXhi0DaYdZ1SU?=
 =?us-ascii?Q?l1374bBYQ5OwmpQocmccgnqygla9U5146abtShWRy2XxlYJJtFJot4itO0XB?=
 =?us-ascii?Q?xTnWWwMLdKEz9jkuo+2Lacly85/EZEkAzJoQEeZUXQ/wvR1F/EwJ/OGRevCD?=
 =?us-ascii?Q?Npeak1s58Pr1h2suJfeZOkOW9ZreDTQgyD9wDCZ7wl5182Xe1Bd356yoHRdY?=
 =?us-ascii?Q?EoxEDFvYuM7XmAyStA1RQFO9q7JMjos0dE8/QRMY/ebTh3AvWoQkm1gVa86f?=
 =?us-ascii?Q?R1M4aURXZsE8kp5GFpH/tmktIpQgZ7apH/HrKJPllEeZ8jQMFla24rkqzOTp?=
 =?us-ascii?Q?fcO8F6lkJ6xVGuL/KabEhXAg+yBCSDKhgExoT2USbLikA/gpIeufzyZPlCjB?=
 =?us-ascii?Q?FUZbZS1mlLzQzIo8YuHgahbWqSpi/fVxiTe95wLjGpk3UosLE4TUs3kHX8fp?=
 =?us-ascii?Q?ZvjCtVLHq+87psvQWU+h7xLzFqQDkJsDgOrnhaRV0K1hjNYJAns+eeDK7h03?=
 =?us-ascii?Q?wzdGkJ8+kXaurllqWkyfqF0O9v1uyRaxdiPApLvZhMZUoHdGXOqOfQ/2kcyt?=
 =?us-ascii?Q?QMljzaWD6mzqdgjBtKkAg7XdKA3uOWL4iZsamhDhpUmwiRj4TNnNgN5Ykknn?=
 =?us-ascii?Q?ozmsgR58BhrNIRxd57q+awKaq0rdwyaJlXCrq5FZhzUi+wwc1MHpdQjTUdY3?=
 =?us-ascii?Q?SoCD3RCBl4iIbJWisHwWnCvdPUJz9073+SvOsZXZ3Iy5u9vH8foIR3kIqijn?=
 =?us-ascii?Q?XUM/GxPhlWqL0ojuxlEyl/wL/w66RM8+HLWn7rAhQmsZjIgf1GhVbVSffcUA?=
 =?us-ascii?Q?/7K2o90a0KrQyRW5cogGPwqcjPwuoV3RDtYrzBxPjNCtBbF8c+9BS5ouwdap?=
 =?us-ascii?Q?qdpstzcDT5WZDrOMheS1aIsfx95kZyDiKUQylby3AknWMrSMGqXaO8uze9lK?=
 =?us-ascii?Q?H79Ssb/KhDnmZ3WoD5lnTlpeSk63xPAnCEjQKmWfgQ4Q5j9xqDjdA71pYTkg?=
 =?us-ascii?Q?kqaZP7RFRqamTF5Orn/JlANU7ytQ/JA0+6MYphjV/wYxwL28uDHfc63G7egp?=
 =?us-ascii?Q?+Y0edn7/UKZGd53isclRZpSFykPQ8CR1iXfem58kaNLXJC55eGzD9T/DAk09?=
 =?us-ascii?Q?fg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ZMqdVvejaO5kym75SR7YL2iVqdHxLzyMamumcZH40EzLrUqkAkDYhpHlcc3mHVPuC1mQjO2d6Jt6tcXRtygU0dUiC64N1PkWk4DDjqXTv2XsTDeuNnEYgvCKxYqxJbw6qpYhYUNvNdFb1FZhnSgwbS2vC3e84eTftGivQ0EkZj4aFuxcmL974PkgCSZ0pqRpoAavUmY+ynXaEQosySrxV6wx2/Oz4itehValrLzwFyXPaIGGmCSCdgISwlMoH3JbVcaoLv6DjE11kdeefH8NkVP8Rjg+g5npojVbmIU/0AOEmtelZ+1p9T8p4XwIq61Hak9ARW2WR3cotQfYajU70rIhbdhvOfqc4GXE0ElzQ5Mr3iTFmio5ehT0cN2jZEXxoSYZTZY9s7qoYcnWhTXv26iMOEmlsb/qOkV4PnSllyMAfi/y9ru1js2m6RJ56K6lk8opdgsYfALaTlj+tDXEU5KxduLTHxIgqRpDTS1zFwKUPhjqH2IV2Fe2DzJbJaMqkO6/1u6X6z3FjWi1kb7FHc4PywKgB+8+hOjzlTRGJW4FAwctr1OO5OYN/Ts7yZJlDMlX6BK0DQ1s+XiBLtmKCvFqB7iTKCKFfvfPl/pi0BQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa62f423-971a-4a3b-f7ff-08dc7eae1a29
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 00:35:41.1796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NKgHd6mIl7c5AUWYJDAmw0K5XUEPo89DJ+TgGOpzAwz4Az6cfIK4lV2OP12BdehbUKEdXXweu6UAdqL8AVtWOaBGKQHqxyIx3ElHc3LfjVM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6510
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-27_06,2024-05-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405280003
X-Proofpoint-GUID: Lpjw5r8VutAW0AgLxThqcJb6wcpFCC8d
X-Proofpoint-ORIG-GUID: Lpjw5r8VutAW0AgLxThqcJb6wcpFCC8d

PREEMPT_AUTO adds a new scheduling model which, like PREEMPT_DYNAMIC,
allows dynamic switching between a none/voluntary/full preemption
model. However, unlike PREEMPT_DYNAMIC, it doesn't use explicit
preemption points for the voluntary models.

It works by depending on CONFIG_PREEMPTION (and thus PREEMPT_COUNT),
allowing the scheduler to always know when it is safe to preempt
for all three preemption models.

In addition, it uses an additional need-resched bit
(TIF_NEED_RESCHED_LAZY) which, with TIF_NEED_RESCHED allows the
scheduler to express two kinds of rescheduling intent: schedule at
the earliest opportunity (the usual TIF_NEED_RESCHED semantics), or
express a need for rescheduling while allowing the task on the
runqueue to run to timeslice completion (TIF_NEED_RESCHED_LAZY).

The scheduler chooses the specific need-resched flag based on
the preemption model:

		TIF_NEED_RESCHED 	TIF_NEED_RESCHED_LAZY

none		never   		always [*]
voluntary       higher sched class	other tasks [*]
full 		always                  never

[*] when preempting idle, or for kernel tasks that are 'urgent' in
some way (ex. resched_cpu() used as an RCU hammer), we use
TIF_NEED_RESCHED.

The other part is when preemption happens -- or, when are the
need-resched flags checked:

                 exit-to-user    ret-to-kernel    preempt_count()
NEED_RESCHED_LAZY     Y               N                N
NEED_RESCHED          Y               Y                Y

Exposed under CONFIG_EXPERT for now.

Cc: Peter Ziljstra <peterz@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Originally-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/lkml/87jzshhexi.ffs@tglx/
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 .../admin-guide/kernel-parameters.txt         |  1 +
 include/linux/thread_info.h                   | 12 ++++++
 init/Makefile                                 |  1 +
 kernel/Kconfig.preempt                        | 37 +++++++++++++++++--
 4 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 2d693300ab57..16a91090d167 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4719,6 +4719,7 @@
 
 	preempt=	[KNL]
 			Select preemption mode if you have CONFIG_PREEMPT_DYNAMIC
+			or CONFIG_PREEMPT_AUTO.
 			none - Limited to cond_resched() calls
 			voluntary - Limited to cond_resched() and might_sleep() calls
 			full - Any section that isn't explicitly preempt disabled
diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index 9ea0b28068f4..06e13e7acbe2 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -59,6 +59,18 @@ enum syscall_work_bit {
 
 #include <asm/thread_info.h>
 
+/*
+ * Fall back to the default need-resched flag when an architecture does not
+ * define TIF_NEED_RESCHED_LAZY.
+ *
+ * Note: with !PREEMPT_AUTO, code should not be setting TIF_NEED_RESCHED_LAZY
+ * anywhere. Define this here because we will explicitly test for this bit.
+ */
+#ifndef TIF_NEED_RESCHED_LAZY
+#define TIF_NEED_RESCHED_LAZY TIF_NEED_RESCHED
+#define _TIF_NEED_RESCHED_LAZY _TIF_NEED_RESCHED
+#endif
+
 #ifdef __KERNEL__
 
 #ifndef arch_set_restart_data
diff --git a/init/Makefile b/init/Makefile
index cbac576c57d6..da1dba3116dc 100644
--- a/init/Makefile
+++ b/init/Makefile
@@ -27,6 +27,7 @@ smp-flag-$(CONFIG_SMP)			:= SMP
 preempt-flag-$(CONFIG_PREEMPT_BUILD)	:= PREEMPT
 preempt-flag-$(CONFIG_PREEMPT_DYNAMIC)	:= PREEMPT_DYNAMIC
 preempt-flag-$(CONFIG_PREEMPT_RT)	:= PREEMPT_RT
+preempt-flag-$(CONFIG_PREEMPT_AUTO)	:= PREEMPT_AUTO
 
 build-version = $(or $(KBUILD_BUILD_VERSION), $(build-version-auto))
 build-timestamp = $(or $(KBUILD_BUILD_TIMESTAMP), $(build-timestamp-auto))
diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index c2f1fd95a821..fe83040ad755 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -11,13 +11,17 @@ config PREEMPT_BUILD
 	select PREEMPTION
 	select UNINLINE_SPIN_UNLOCK if !ARCH_INLINE_SPIN_UNLOCK
 
+config HAVE_PREEMPT_AUTO
+	bool
+
 choice
 	prompt "Preemption Model"
 	default PREEMPT_NONE
 
 config PREEMPT_NONE
 	bool "No Forced Preemption (Server)"
-	select PREEMPT_NONE_BUILD if !PREEMPT_DYNAMIC
+	select PREEMPT_NONE_BUILD if (!PREEMPT_DYNAMIC && !PREEMPT_AUTO)
+
 	help
 	  This is the traditional Linux preemption model, geared towards
 	  throughput. It will still provide good latencies most of the
@@ -32,7 +36,7 @@ config PREEMPT_NONE
 config PREEMPT_VOLUNTARY
 	bool "Voluntary Kernel Preemption (Desktop)"
 	depends on !ARCH_NO_PREEMPT
-	select PREEMPT_VOLUNTARY_BUILD if !PREEMPT_DYNAMIC
+	select PREEMPT_VOLUNTARY_BUILD if (!PREEMPT_DYNAMIC && !PREEMPT_AUTO)
 	help
 	  This option reduces the latency of the kernel by adding more
 	  "explicit preemption points" to the kernel code. These new
@@ -95,7 +99,7 @@ config PREEMPTION
 
 config PREEMPT_DYNAMIC
 	bool "Preemption behaviour defined on boot"
-	depends on HAVE_PREEMPT_DYNAMIC && !PREEMPT_RT
+	depends on HAVE_PREEMPT_DYNAMIC && !PREEMPT_RT && !PREEMPT_AUTO
 	select JUMP_LABEL if HAVE_PREEMPT_DYNAMIC_KEY
 	select PREEMPT_BUILD
 	default y if HAVE_PREEMPT_DYNAMIC_CALL
@@ -115,6 +119,33 @@ config PREEMPT_DYNAMIC
 	  Interesting if you want the same pre-built kernel should be used for
 	  both Server and Desktop workloads.
 
+config PREEMPT_AUTO
+	bool "Scheduler controlled preemption model"
+	depends on EXPERT && HAVE_PREEMPT_AUTO && !ARCH_NO_PREEMPT
+	select PREEMPT_BUILD
+	help
+	  This option allows to define the preemption model on the kernel
+	  command line parameter and thus override the default preemption
+	  model selected during compile time.
+
+	  However, note that the compile time choice of preemption model
+	  might impact other kernel options like the specific RCU model.
+
+	  This feature makes the latency of the kernel configurable by
+	  allowing the scheduler to choose when to preempt based on
+	  the preemption policy in effect. It does this without needing
+	  voluntary preemption points.
+
+	  With PREEMPT_NONE: the scheduler allows a task (executing in
+	  user or kernel context) to run to completion, at least until
+	  its current tick expires.
+
+	  With PREEMPT_VOLUNTARY: similar to PREEMPT_NONE, but the scheduler
+	  will also preempt for higher priority class of processes but not
+	  lower.
+
+	  With PREEMPT: the scheduler preempts at the earliest opportunity.
+
 config SCHED_CORE
 	bool "Core Scheduling for SMT"
 	depends on SCHED_SMT
-- 
2.31.1


