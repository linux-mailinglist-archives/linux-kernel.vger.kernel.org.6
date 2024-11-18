Return-Path: <linux-kernel+bounces-412885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 958009D109E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 13:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C6141F23180
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 12:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D41199E9D;
	Mon, 18 Nov 2024 12:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="H4ZqyJLp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MAULocd1"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B13194A70;
	Mon, 18 Nov 2024 12:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731933385; cv=fail; b=LfVWJ5E6lgg4qq5+MhgHza5iBLTQalwA7mBEtPMZLv5Mk61/b1BIIFRcT66vUiuyVBqW75AJvNq3MZd/CaqWT5HtCKNpZruD5dhFZXh53CZAl26RkG6jIdSBfJH/UE3NK1RTc6cV63LcE+nJsc02sJVvi8vCcJvuE83SM9yK3BI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731933385; c=relaxed/simple;
	bh=7TpMQaU9sMSu/kJGpPLFz6Y+11nAamgU/I0TykP6fWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OBBKbAEISsHqf/wuyEZSFPux3LLq0P845pil1EXkQgOOkkrOaUV0w+w/0/dcff8LyjkP2/42qn5Zw74lVhsNskgnwHqDaIZvMZpUVYIoJMwWnNcfDxD4MZqSE43rE9O+lqkQhwtaxjY1KDAmJHRyisodgRx7cRCpPc3gPQ+F+t0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=H4ZqyJLp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MAULocd1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AI8QXYU009325;
	Mon, 18 Nov 2024 12:35:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=XatxqI3T14XyfcaU8ZnX4sdn+iEwBq8thVvRIb8E+yU=; b=
	H4ZqyJLp8GCiMvjMpHu/Vm8qqk4VvF27VRc+JUkP9KIi5YPJnAjqS1qTHHqXbTxm
	3zO8yXoxTJhDTwBWFqWCieTaR35+eB+fr31kZw+KTTRmJUHzIo5fztMLx3ADBAIi
	4yqEE4GJKZd89bJxs2grujECj4Ac5yI5uLCd5bmTTRKmgxDVBbcMSxKtwrNHqOiK
	3qsQjGD02BphDu3s1bJXE1fXT97iyVzGxvPa+SeXrzUrA1NfhfOp1lCNmtTX5ops
	N9a3ohfDG7aMIS1lqJD5CedXcw47igC0jcaiLAwAxVEMkBpdy8754AaJqF+1DpM6
	c2c+VP5CQFqG2btdt2Vuuw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xhtc2k6j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 12:35:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AIAxK80023125;
	Mon, 18 Nov 2024 12:35:42 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42xhu7crqm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 12:35:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=swmFl/X22bfcfgyhdXfju/grCc67V5PY9efKpxUOuEc91P3PFCq9cIECk2LYbCnTzhgW8vkBFn9hELyyLvV20RcxB1Ln2z76klAJ9KTErTVO3x11HrXp1Dl+zvKebk4Vl2bNa+bGATNvxot2sV5Dk5w4HZsJj/4jJtOhtZw+gILiC5xZbl/AF/2Rbd3ZE7KWrvsBPW8UKst1k4/FXAcXX9zL/+pIZgUlVxhmrUZ/W2pc8n9PF4MpzQOhBdVwcUK35Kh1pYuTsFwjkQFJaNOBCqFzTRPABSg6YDw15VWMUT/SeK5wEB/4lOcERaU2/PxwYmyMW75wlTp5NNWhmNBoZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XatxqI3T14XyfcaU8ZnX4sdn+iEwBq8thVvRIb8E+yU=;
 b=o9w5iXPFI5uxFQa1ku3LXRwhc0hwbXx8I38Ci3LWFUuMMsKFw96mMVRq/bGgA8J4AtwdxINzH2HeTJi2fv0+Z+TxrGDIQ3CyLufSsgXm8/1QeKrYoRMoQkRBt3W1F5dWywhF8llfkM+3OMgGntM+DVairTfGM3yp0DwYD6qwZz4xSMQ5fMIyQnxrKpFeQvZD/5UM6ux2GSz0pitutWCqsbnjue9kkzXXYSa+i/TL+cuaChWLLN3nLNMhocxozGrRuiPqDLgGNPKCT/xd4nvcoYaZIjMbTS7u0jkd0gme93hEOxWGVCQmOAKHSAFr+S+gL8kQ3C5NVx2uNIGBxpfasA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XatxqI3T14XyfcaU8ZnX4sdn+iEwBq8thVvRIb8E+yU=;
 b=MAULocd1ZvC4rePj5wh6ECxhoYL1k1QOG2XZd0TSvzjT4NyEFtgwIkHrlXBToD+12kUCMYzIQE6GYt2NdNtCCMnhh/NzbKnaJ+oPVCrqdtZ9g6SVSjEKNgoK/MKdR9YzJHSqysyx8JDiHP7K6zcx2ifYtuMN94a/XNbH/em1TLc=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SN7PR10MB7075.namprd10.prod.outlook.com (2603:10b6:806:34f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Mon, 18 Nov
 2024 12:35:39 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8158.021; Mon, 18 Nov 2024
 12:35:39 +0000
Date: Mon, 18 Nov 2024 12:35:35 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jann Horn <jannh@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Alice Ryhl <aliceryhl@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Hillf Danton <hdanton@sina.com>, Qi Zheng <zhengqi.arch@bytedance.com>,
        SeongJae Park <sj@kernel.org>, Bagas Sanjaya <bagasdotme@gmail.com>,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Matteo Rizzo <matteorizzo@google.com>
Subject: Re: [PATCH] docs/mm: add more warnings around page table access
Message-ID: <2b0fea4c-6b01-4bac-8ec8-01fcce4fa12e@lucifer.local>
References: <20241114-vma-docs-addition1-onv3-v1-1-ff177a0a2994@google.com>
 <61f84216-75fa-477b-a9df-6f24476ecd8d@lucifer.local>
 <CAG48ez31XxOa=OJO-H8b4cEeSGjx50403+BejPvDFwvV3vdpMw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez31XxOa=OJO-H8b4cEeSGjx50403+BejPvDFwvV3vdpMw@mail.gmail.com>
X-ClientProxiedBy: LO2P265CA0080.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::20) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SN7PR10MB7075:EE_
X-MS-Office365-Filtering-Correlation-Id: dbb4dce6-9198-4220-ed19-08dd07cd8208
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cy9zV002Qk5yMlBKbWlDU2lJbmdiTE5yQldkMVhVZnRQQ0tha2J5Rm9zcXFG?=
 =?utf-8?B?YXQzT1o1Rk1YM3RqVEc1YUFndU9udjNONTVidGJ3anFrMHZFd1ZHRmQrWENo?=
 =?utf-8?B?bFM1eFM0YjFWNG5BSnVSNU5HRjRJUnVKbkIrYUt0c1R0a1NIRjhNclBhbXdR?=
 =?utf-8?B?UXdaMDkzcUplVStTNXVNdkdmSk85Q1RhbkkycU1iZkxmZU1Ec0VHODNIWDM2?=
 =?utf-8?B?TVhBUmhSVXpjRDNBaGEwN0ZuYXN6Z1AzRUNnT1djb0ZnQWhwZmdVNmpJVmow?=
 =?utf-8?B?b2xuSTdjd0pJUEZ3cjZ5cTVYRUM1NUkyUFZ2dFplL0FMTC9xRUVoK2Vkb3Vt?=
 =?utf-8?B?NW5Zd2hsOTg0NnFLT0c5dE1vYzluRk5nVllyT29sZmJ4eE01OXJFVXF6Ulox?=
 =?utf-8?B?cUsrNXZxSnVzY21DVjdPd0szaDdJRnJHUTFTNmlNRkpJM1N3QUhKWFhteWlS?=
 =?utf-8?B?aEVhUCtGdkl4L1dzK3laSmhNT0lQbzZBS3dMSTFjRHZxOGt2eW4vTHRkTGdY?=
 =?utf-8?B?VFFsWXlRMkJDT3ZwdWRTYTlsVnpHMTNpZG9weG8rbXNNd1hpVmdTMVdWVVZ4?=
 =?utf-8?B?TldaZE0zYVNVSDdNWlQzem41WXJDQUNicGFxOGQyQXlWUFV3dGN1a055ZWpF?=
 =?utf-8?B?YkdqME9ybjZqamtEd0s3MVlxVTFKOG1UY2tHRHNEZ3FWdmN2azlKR2pMSS9B?=
 =?utf-8?B?SHFBaUpUM1lLSG5ma1AvdEIrWTAycFJTdXUwWW5zN0V3a2xKU0MxdWdvdWVs?=
 =?utf-8?B?eWtJMFgvWjh2TjFBMm5wMWt1bXdTWW1LbHhscGtubDJ0YmdBOGsrYmt5V3lH?=
 =?utf-8?B?UWZiOUZZM3ROekJyWThMVkRPNkNFd0RkUXlldXc3M01ZRTY3akVIYTQvcHIz?=
 =?utf-8?B?SFkrUURrNU9lelVJWmZZKzB6ZU5tQmlpaG9ERE9xM0w4QUt4YXJ2dTNWY1Nh?=
 =?utf-8?B?eHZRR3RuaGdBQm9idEpnRGNYNFdoVGRlcXEzWkJURHlLRzhzTFRKS085MGlU?=
 =?utf-8?B?UHNDcXFEdExHY2Q1UXhub1NqNnowTFZGc25jNDVhVWJMU0xoOUZTenJvQjJi?=
 =?utf-8?B?YUJEaHJvUTNuRSswV2NlM0dzemd1bWNSTEtrMk5OeGxHamplcW56dFJadUpm?=
 =?utf-8?B?UU5YTTZDRkhGeWFKdU9IVXVsM0pEanZTZE9KZWFmWnF1aGdwd2FvY0FrQWhD?=
 =?utf-8?B?VXZiVWZLWXQrUVhNRDU2bmxJN1Z4dFNTWW4wenltNGhiSnN2dWpxTTBuZlRa?=
 =?utf-8?B?dmdUTkI4Qk5vYVhvUkZhQ2xuNStkMmlXTUVhQ2VEZENKWUJpRldYcUQ4MW80?=
 =?utf-8?B?R0xKc2tEQmxtQjgrM3RpMkhOSDM1Z2tCUk4wb0xVcXNtZENtWTFMUW9zZTNt?=
 =?utf-8?B?TEtQdTlMdmlJRHJDMVFES0RwdzA4R3hDUTVjNGhiaWpIbGtxWWZUSndJS3Rs?=
 =?utf-8?B?WGRadDRROTZJMVVuaWV1cFNIcUkycTNUdzNUSEE4RlhnenN1SnhqUHJoQTFB?=
 =?utf-8?B?Tkk3VVhVZnR3TEV6eFBGbXJVM2IzZG5BdlVLcVVDV1ZhZlRXUjNOeTRiWW9v?=
 =?utf-8?B?SlZoRnZTY3FiRm5wUW13ZFoyZnBJWWlCQWZvNDI0N2tLdEFNTWlka0lJK1RP?=
 =?utf-8?B?MWVTQ1JCS1g1ZSsxTFU5akx0M0hzMm1qa2wvRDdXWStFSDk5YUJqWmVpdTlP?=
 =?utf-8?B?N3BzWmk4Mm9qdWVFREF0ODBGYnNwOXZIMDU0RzNqRHlBTkNUcHdONDcyZ3Fz?=
 =?utf-8?Q?GbPVHwDr5ZOC/cpzQPFA21GqIRqe6We1vE4XfNd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NlNoKzRUUWhYTWVoQXJmcVZMdXJvMDdCRVRBSHF6eXVlanhOUDZDYzRwUUh0?=
 =?utf-8?B?aEI2NzVTbElFUWZwSWl0b1dCdXA0OHlLcS9DNXpPQTdGbWU4SEZGMUNRSTI0?=
 =?utf-8?B?bHhhekw1YkNsVFBXa3l5WTJaUEtDcWk3QWhPdlRLekkrUDRoUmVQYVYwSlA0?=
 =?utf-8?B?Z2p3am5PQVQ4TTM5L0Q2T2JnaHJWbEk2dkhoWGFRN05TWXhkSVMxa0JMejhZ?=
 =?utf-8?B?czhoa081R1RTR3ovb0VKeGRjb3ZQRXk5aVhsQW9jUFhjMmJucmxIdm5MNTNU?=
 =?utf-8?B?UkUyOG5oN2pCNGgrSTU5MGcyTWRPQTR2Y1UrN1MvVDEwRlhDMkZOdm1tTW10?=
 =?utf-8?B?c3U2WVUzTDJuUUphbWJJcXlQTXBjYzZsa21YWllCZjJYeU9HeGRXR1Z0M2Vi?=
 =?utf-8?B?cHZkMGJHUkwyVmljanl6ZXlKUjREZmlzNWc1NEFMRHR5N2IvNlZtM0o4ZUtP?=
 =?utf-8?B?dkpPazE0MTVqdWFHcjJYaXBVRFFnZlpTWUVHT0NETDVIMzhraHZKTzV4eWRQ?=
 =?utf-8?B?S0lRclJlWlE5c1E3Y2p0K2dhbmFJTlF2SFUrc1pIeWVMRFJ5ZHJ1R3Fzb2pn?=
 =?utf-8?B?MVVjc29jRklKWXo1ZVk3YXlOdGV0NlIwMlV2VnFvNEMyYWJmK3lacE5hd0tZ?=
 =?utf-8?B?NEU2akt4NWRKazEwMno1NEpRWnF0TnNvOEFweEJZNVVlSkl5Z3ExalVtemN6?=
 =?utf-8?B?ejhOUUtXUjFmNHlVZk9LR0xlNkJnNFJGclRlb05wRjIzTVJLWnhkWlRWM0hU?=
 =?utf-8?B?ZmVyVDRWaTdrazd2ekRvT2E1aC9XcjFLMHRLd3dVbE5Xa1dtS25rRzhIQUtu?=
 =?utf-8?B?ZWtoWDlwRHJyMUFUb2RRQVRYZC82TiswSzl4bi91OSsvVmRMSDVZRjhSYU5j?=
 =?utf-8?B?VEtkQzlhY3E4UFRzMXV3dGpocXNZRzc3OFA0dEVVbnQ4Q05EdGtMUS9FTFZS?=
 =?utf-8?B?RE54UG5CL3B1TUVWaGlIMjlkRUgyK2dyczM3WVN6RUJIK1l4UkUrVFhUYnNp?=
 =?utf-8?B?WG96YWhNS1ZveEEyOEk5U3BwQ1dQdXZlM1A5YTl6MnpRdTlTelNJWnhKcjhl?=
 =?utf-8?B?ZkdUc3pqcUZFRUdLeGlDOUhraTJLcnlBOVBKM0pSZ0VRUGprSGF0WmlWVWln?=
 =?utf-8?B?OW94YkplMVFPQlZUTms4NlRXNGUrWCtrQ3p2eUY3SkJJSDhGbmZQclZyYjhl?=
 =?utf-8?B?cjVickNoNnB2NTFWYldQS1hVOUF0TTNrRFR2SEl0ZnF5NVRla1RUdEs0YTJF?=
 =?utf-8?B?OFVnOVVKVnBHblhBRkVxaXM0bTU3TzgyLytwaTNsWGZwS2QwTXdtdlJEZlNX?=
 =?utf-8?B?QkZXRWM2Smw4alg0aGlvL1dTcFo5VHB0Zy9UTkZ2c3g3T2RkWnllcEd1eCti?=
 =?utf-8?B?dHhjV3duU052T0JtaWs2WkhkSjFjZy9SajVhNnZCcG9uMVVBc2g4SG9PMnUw?=
 =?utf-8?B?aWVHRzByWW11UHlWSGN4MTY4Qk93WHRUL0FBWlM1RlpUS0VLV2pGR28vblF0?=
 =?utf-8?B?VkhXQXljQTQ4NWJtSS9mTDRuRTgwQmdGeXpBaHhhYXVxMTVnNGJ1MEN5ZTBW?=
 =?utf-8?B?ZEtUOERhTWlaSGdZdTdOVVNzd3ZwZDhYdVFpd1R1akV1ZyszdXBpQnlFOXpX?=
 =?utf-8?B?eFJoT21lSXBIUnFkbm96M3dteXF4QncyaFpzMWY2VTM1Sk5wMGU1VzJSazlP?=
 =?utf-8?B?SWdPajFoZXpXSDBNK1lLeTVjRnhqbjM4KzU2c1R3ZFlaUzdvRkNpRS9HK0R6?=
 =?utf-8?B?YTEzRU5uRlU4YVpVckJrdkx6YXpxMldVbW1BZTlmUGNrRlNUZXBNODdpUkoz?=
 =?utf-8?B?a2dGaGxScHIvSjJwOExZMnNIcVVtNGlCMC90WGNmWmIxa3FkU3BEd0c0NVh0?=
 =?utf-8?B?OEZvQkRXVzRHZ0RBNlZ4dWU4Z0xQaGd0ZHpkUkhuRkoxcHplYXRLbmJKQ3lp?=
 =?utf-8?B?YlNlT2lhVEQrdk5qMHpxTGFKaW9QNGYyZm9QN25OYkpwdVI5c1Yvb1BFYUI2?=
 =?utf-8?B?L25PV21ZaWkvQzhmbm9QVWVPUCtXbytMNWZGZ3BNZG0vcGRLWW1JUzFHbTla?=
 =?utf-8?B?bFJWeFFIU2FLMzErOXNyYnIxUHRnandxRWFOdVFxL1BOdVVRL25KZFNUaFVz?=
 =?utf-8?B?cXpLNEkrSDJNR3RBTStHcXFxalhDei85L2VJQlhuMk5TZGJIZ2ZMdUIrdk1Z?=
 =?utf-8?B?THc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HZ9Zg5NLTzqoyTnteyaybj+RknAAHQ+9pw4KC8wU31ZRvUfDsqjsA+iZKoJTUG71a53Mi+tc4G2MokjKKfwQLAcoQvu2Xrq74mMSn3ZE2KHMIFi06xbaYQuoTXNEBBNGPFuHyOOkzy7gQABVzgBuLmTQT6ngfN5Mc3c+Y62zcxO1mbv1Wy4h8wLNxiQ90osP/H9tH9lUl5YangTJlUeFEwl4AP6kRUQpSL+h5I13yYgtEUvDjI3Dd3Ml/4RxqgsVIV8kOuHzDwFMnR9b2rm3VahqYKixcecttBNclGbCsVN55XpnxLbLVDkuQT8UElFktlByfVZ8jc/lshtKMz6+zFIBAoKpOvvhwwuh4clt0hV912qFIXUJ5xyhzkyUInF3DZShpcDeRP4SMydRwbkrI8ZziqPiZoI1Xk48x87sBHi0bwXinqfyc/6mfLi4X1yJQDGv8a3z0dKhdAUJhdCkkyKPeth+g9UkfovW2ZYNivpG9sXpSnnBoCMX+q7wZ/h2SNZ2zXNCeRQmPCt6n7lRErNrKgERwnfuam+AHrSNgiOmOgw/k8K0GyGvaC1HpcMGdQobCGvkfvKeAIvaTfeZGnwqKa2cmUl+O5VILssLqcY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbb4dce6-9198-4220-ed19-08dd07cd8208
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 12:35:39.0658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x5WcmHaIMcIgIlq3EOzHRQN86Sot2S852mIXTpl8S2EayfsykYT7mIZ8VSYv/xRGWz4Vy6ImSCQb+DRXHlMVi+Jdm8hjjCkDFRI0M5gPAog=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7075
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-18_08,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411180105
X-Proofpoint-GUID: 8ttIlyN1RS-8ojQFC-8-X-U8NSiC1HA5
X-Proofpoint-ORIG-GUID: 8ttIlyN1RS-8ojQFC-8-X-U8NSiC1HA5

On Fri, Nov 15, 2024 at 08:04:52PM +0100, Jann Horn wrote:
> On Fri, Nov 15, 2024 at 7:02 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> > On Thu, Nov 14, 2024 at 10:12:00PM +0100, Jann Horn wrote:
> > > Make it clearer that holding the mmap lock in read mode is not enough
> > > to traverse page tables, and that just having a stable VMA is not enough
> > > to read PTEs.
> > >
> > > Suggested-by: Matteo Rizzo <matteorizzo@google.com>
> > > Signed-off-by: Jann Horn <jannh@google.com>
> >
> > Have some queries before we move forward so would like a little more
> > clarification/perhaps putting some extra meat on the bones first.
> >
> > Broadly very glad you have done this however so it's just sorting details
> > first! :>)
> >
> > > ---
> > > @akpm: Please don't put this in your tree before Lorenzo has replied.
> > >
> > > @Lorenzo:
> > > This is intended to go on top of your documentation patch.
> > > If you think this is a sensible change, do you prefer to squash it into
> > > your patch or do you prefer having akpm take this as a separate patch?
> > > IDK what works better...
> >
> > I think a new patch is better, as I'd like the original to settle down now
> > and the whole point of this doc is that it's a living thing that many
> > people can contribute to, update, etc.
> >
> > For instance, Suren is updating as part of one of his series to correct
> > things that he changes in that series, which is really nice.
> >
> > > ---
> > >  Documentation/mm/process_addrs.rst | 21 +++++++++++++++++++--
> > >  1 file changed, 19 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/Documentation/mm/process_addrs.rst b/Documentation/mm/process_addrs.rst
> > > index 1bf7ad010fc063d003bb857bb3b695a3eafa0b55..9bdf073d0c3ebea1707812508a309aa4a6163660 100644
> > > --- a/Documentation/mm/process_addrs.rst
> > > +++ b/Documentation/mm/process_addrs.rst
> > > @@ -339,6 +339,16 @@ When **installing** page table entries, the mmap or VMA lock must be held to
> > >  keep the VMA stable. We explore why this is in the page table locking details
> > >  section below.
> > >
> > > +.. warning:: Taking the mmap lock in read mode **is not sufficient** for
> > > +             traversing page tables; you must also ensure that a VMA exists that
> > > +             covers the range being accessed.
> >
> > Hm, but we say later we don't need _any_ locks for traversal, and here we
> > say we need mmap read lock. Do you mean installing page table entries?
> >
> > Or do you mean to say, that if you don't span a VMA, you must acquire a
> > write lock at least to preclude this?
>
> Yeah, this is what I meant with the "you must also ensure that a VMA
> exists" part. (Context is that I was looking at some non-upstream code
> that was trying to do exactly this - take a userspace-supplied address
> and walk down the page tables at that address. Upstream also once had
> a UAF in pagemap_walk() because walk_page_range() was used while
> holding only the mmap read lock, see
> <https://project-zero.issues.chromium.org/42451485>.)
>
> > This seems quite unclear.
> >
> > I kind of didn't want to touch on the horrors of fiddling about without a
> > VMA, so I'd rather this very clearly say something like 'it is unusual to
> > manipulate page tables wihch are not spanned by a VMA, and there are
> > special requirements for this operation' etc. et.c otherwise this just adds
> > more noise and confusion I think.
>
> I guess maybe we could replace this entire warning block with
> something like this?
>
> ".. warning:: Page tables are normally only traversed in regions
> covered by VMAs. If you want to traverse page tables in areas that
> might not be covered by VMAs, heavier locking is required. See
> :c:func:`!walk_page_range_novma` for details."

Yes I prefer this.

>
> And walk_page_range_novma() already has a comment block talking about
> why an mmap read lock isn't enough to traverse user virtual address
> space outside VMAs.
>
> > > +             This ensures you can't race with concurrent page table removal
> > > +             which happens with the mmap lock in read mode, in regions whose
> > > +             VMAs are no longer present in the VMA tree.
> > > +
> > > +             (Alternatively, the mmap lock can be taken in write mode, but that
> > > +             is heavy-handed and almost never the right choice.)
> >
> > You kind of need to expand on why that is I think!
> >
> > > +
> > >  **Freeing** page tables is an entirely internal memory management operation and
> > >  has special requirements (see the page freeing section below for more details).
> > >
> > > @@ -450,6 +460,9 @@ the time of writing of this document.
> > >  Locking Implementation Details
> > >  ------------------------------
> > >
> > > +.. warning:: Locking rules for PTE-level page tables are very different from
> > > +             locking rules for page tables at other levels.
> > > +
> > >  Page table locking details
> > >  --------------------------
> > >
> > > @@ -470,8 +483,12 @@ additional locks dedicated to page tables:
> > >  These locks represent the minimum required to interact with each page table
> > >  level, but there are further requirements.
> > >
> > > -Importantly, note that on a **traversal** of page tables, no such locks are
> > > -taken. Whether care is taken on reading the page table entries depends on the
> > > +Importantly, note that on a **traversal** of page tables, sometimes no such
> > > +locks are taken. However, at the PTE level, at least concurrent page table
> > > +deletion must be prevented (using RCU) and the page table must be mapped into
> > > +high memory, see below.
> >
> > Ugh I really do hate that we have to think about high memory. I'd like to
> > sort of deny it exists. But I suppose that's not an option.
>
> (FWIW from a quick look I think only arm and x86 actually have this behavior.)
>
> I mean... we could try to just make userspace page tables live in
> non-high-memory based on the assumption that nobody nowadays is going
> to run a 32-bit kernel on a device with significantly more than 4G or
> 8G or so of RAM, and probably most memory is used for stuff like
> anon/file pages, not for page tables... but I don't think it actually
> matters much for code complexity now that we need RCU for page table
> access anyway.

Right, I just am not a fan of 32-bit kernels :P not your fault!

>
> > As for the RCU thing, I guess this is why pte_offset_map_lock() is taking
> > it? Maybe worth mentioning something there or updating that 'interestingly'
> > block... :>)
>
> Yeah, and not just pte_offset_map_lock() but also pte_offset_map() and
> such which don't lock the page table.

Could you update that 'interestingly' block then also?

>
> > Or am I mistaken? I wasn't aware of this requirement, is this sort of
> > implied by the gup_fast() IRQ disabling stuff?
>
> This is to protect against khugepaged/MADV_COLLAPSE deleting page
> tables while holding only an rmap lock (in read mode), the pmd lock,
> and the pte lock. So a concurrent call to MADV_COLLAPSE (potentially
> in another process) can (via retract_page_tables()) remove the page
> table while we're traversing it, but the page table will only actually
> be freed via RCU (thanks to pte_free_defer), and so this doesn't cause
> use-after-free. pte_offset_map_lock() ensures that on success, it has
> locked the current page table (holding the pte lock prevents the page
> table being removed in the future, and rechecking the pmd entry
> ensures it hasn't already been removed), so we never end up installing
> PTEs into page tables that have already been removed. pte_offset_map()
> does not ensure that you always see the latest page table; it could be
> that by the time you're looking at a PTE inside it, the page table
> you're looking at has been removed, and a new page table has been
> installed in its place and populated with PTEs. But removed page
> tables are always empty, so the only possible consequence of such a
> race is that you wrongly think that there is no PTE at a given
> address.

It'd be good to include this detail in the doc also.

>
> The fourth paragraph of the comment block above
> __pte_offset_map_lock() sorta explains this.
>
> > Please expand :)

Thanks!

