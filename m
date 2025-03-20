Return-Path: <linux-kernel+bounces-570366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 287C7A6AF6A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 21:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BE7D7A9424
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 20:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F29229B1A;
	Thu, 20 Mar 2025 20:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hDEOYc4v";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ze6D3InQ"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848FB22A4CD
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 20:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742504040; cv=fail; b=F7AToXYEVVDPWYBAdOQbOVZi6lQ/JU0rvvgltiblhLr6djO6bcX5A4GddCww9hud7/UiTuVHUxOBixSIYBQMtCnKaCTodFxKeItzdfF6M8IW2BnmH8awMe+lGqQO7MJyXAmSoXxp4zZB1ma5k8EjOxCFPBco9cJurcfPvQTgNfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742504040; c=relaxed/simple;
	bh=w7e/GTSEhA+wd02aAzTwATbLRH/VftJQBc1M7O/XE8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Rdwnen+qQ3LESER2cEf1T2dGxL/F/fyGmJCSCOIlvnUli0KGFmHa0PGp2EYXv09ue0QRChBkOXFSIaHCKSXONOBlvjDigkpJj/aVj+KejwQp13KBoJxMN17RCnfpzDp4O/bp9D4OWFEySu2/gEsEBKAnP5ySX5AWW6PsojVqDsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hDEOYc4v; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ze6D3InQ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52KJNCcV002131;
	Thu, 20 Mar 2025 20:53:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=I9bTkki/7sFUrM0zHpQG3Tgr0+WVMHade7yTYjNttZ0=; b=
	hDEOYc4vZfb2J098GUwfaXGvkUvOFTqnwICZlZx9BSC9Yci/145QAWGSjGFDFpWt
	ppajvioPl1mQc5uLQFMoZgr/WqKJ8t9IKD0j1w21MRLids3HhyqEY5PRhmVnxob4
	+9XFvxNdK+6hyodL4kL+JNdCjiB+3vN/GH4FJkbO2GDXjQIgetfABi2Qk3VK0xEa
	xGSxPBzN2hok/WNRjOcsP8I2eMjwIdryPG0txqlYbwxiK3tfbtPEj7Snq17Aj/Mm
	dAJUiXJ0cFI22M0tFPQ24kay0d4YqdlzkcEEo2aytm0QiVgWBNfvG7KiKuATIyyX
	YEYhAQ0GTCBinXW5Epp+Ow==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1m3xx20-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 20:53:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52KKmlwH022354;
	Thu, 20 Mar 2025 20:53:38 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2045.outbound.protection.outlook.com [104.47.55.45])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45dxc952w3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 20:53:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=op0q2alxCzyngT90j1Bu+OWvLydS6BxaWJdPA7EPXL29yTUA0sEodEe9dQaeUiwiEzvtaIv3Oj8CK5UcwIr+0EHtOrdaI0Ldt3MnWiJlbuFz6DdIAm4GRAGbwTOePgUjnOb3G7N5iUiWh9OYUNOF3ZduN4knfcwUoao2TtmpcDD9sL4BgVN9CkLhiUx3IF9NTVnDZoCnKhHet/iqjuEsQfasuzEUWP78mubfJP78W+SyocHJNewA0ExE22BONSh1gzsP0oOtDIuduz1ZZezgNUrBqBdJ8s8tS6KFRljH33qgqN0O7T11gQp5SVsv0Kwe+8AtnfPAOV0prb+9/ZOafA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I9bTkki/7sFUrM0zHpQG3Tgr0+WVMHade7yTYjNttZ0=;
 b=tgcMk7/MIRurfGyyDOdNiD8225v3ieUF7gKj8NtKJSyii3xzPch3/L3J5uv6qIiGSQ6ODlBn911KHRZEQtLxsVjdvWndfpy/20T1NuM9OHSSrfYOV7Cd8AkI4dg+Fo5FcNDfcsYVn7aZif7ZQpKnEMSFS1N59/YEJS8zFwKeZV99c80CEOqalNo2jmP1TCkrCChpmW/aJUprdmJwimwz7oiyjpMzUw8a4MtqkpazhbvIGcEW9f5xWcrZG8X8Zji7L4p7xUlP2M5rmjQNzEPsQcVAFp9NMhd6l10q8TW+pEroC0N9zCfEVe9yvmoO1Q+nOkJ2Sdl6Kfsfhf3mPxxfxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I9bTkki/7sFUrM0zHpQG3Tgr0+WVMHade7yTYjNttZ0=;
 b=Ze6D3InQIDQaSvol8oLM1WpiDuQ8+7k4BEhMaHe3I4+yGnN+7f6XG/DsY2bT8TjhCOUKgHFIgwEYoNYOWaOeId1MHwS1DzVExKNFWru1amsTmrjwTZFJsI3bsh3lrXBLd50gllWWnS1vxWHGJ9KySabOKl1Lsos1xHsLWjqv2Ho=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SA3PR10MB7021.namprd10.prod.outlook.com (2603:10b6:806:314::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Thu, 20 Mar
 2025 20:53:16 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.8534.036; Thu, 20 Mar 2025
 20:53:16 +0000
Date: Thu, 20 Mar 2025 20:53:13 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jann Horn <jannh@google.com>
Cc: Pedro Falcato <pfalcato@suse.de>,
        syzbot <syzbot+20ed41006cf9d842c2b5@syzkaller.appspotmail.com>,
        Liam.Howlett@oracle.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Subject: Re: [syzbot] [mm?] BUG: unable to handle kernel paging request in
 vma_merge_existing_range
Message-ID: <332b3149-0e84-4bf8-9542-89d68b0a9680@lucifer.local>
References: <67dc67f0.050a0220.25ae54.001e.GAE@google.com>
 <qn7ncujf5gkfmohf5qp3fdakrymhoapkscafqp5t2gulmgdqai@tuhu2igx33k4>
 <CAG48ez0S4hJyqY=zZB_AWqFKtD7KjipR22F_wz1QvWNY=3RDWA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez0S4hJyqY=zZB_AWqFKtD7KjipR22F_wz1QvWNY=3RDWA@mail.gmail.com>
X-ClientProxiedBy: LO4P265CA0319.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:390::7) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SA3PR10MB7021:EE_
X-MS-Office365-Filtering-Correlation-Id: 62964a02-a728-438b-ceb6-08dd67f13c92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TDdmYjVzUVNWRTdRNXBMRmwxQmREZDVhcDBJKzhyWm1WOUFPTi9rSkRZbzAy?=
 =?utf-8?B?QVVKaXI1d2ZqaG1EVW9WRHU4V2FJOWo5UFVoM1I5L0Q4blM0Y25DR0krQmw0?=
 =?utf-8?B?SXpreWQ3YkJESkV6eTVTYk02cURoU3E2TG1BaGJoL1c2NndXdmE2Q01uZlJQ?=
 =?utf-8?B?TTJKNHBXOWlnc0haUVNQK1NZUEhaSnBoNFB2cDNJV1VXRksxTVFOSktUcDlY?=
 =?utf-8?B?aGU4ZDZxWTc3djJBUXA5MVN0a1JYc3FGVG0vQ2hvQ1lpT2JSbW5SVEJubkNv?=
 =?utf-8?B?T3N4WkJ4REVENmttTEFTOXBRKzZ3ZXVjVEl6YVhRdHp2Zm9vb05MZVpEbUNJ?=
 =?utf-8?B?dlJSeWdLRDVqVi9kWDV6TGVxWUFIMWtKRko4S1FVdHRNU2ZHTzF2VVZHdlYv?=
 =?utf-8?B?UElDODJ3Z0RqMEhpZE91aXBqYUgvRyt2SkZiSDhvTlBFajBGQmM5Rnl4MXh1?=
 =?utf-8?B?Q0VPZGR0Ym84R3hoeFRWR3ZqTzczbS9HRitxYXZkaTFwUTQ5bmJJOXNxN3BT?=
 =?utf-8?B?VWtJN25zNkhtdXdFN084YitBMUpRejQ4U09maEdIYk1SZllSbGdIQUU0czV4?=
 =?utf-8?B?VjFFVlpvUVhYSHR3K0c3bEV0alVNamZSMUxxZTJlVmpHRmpQSVNlN09FUWZh?=
 =?utf-8?B?SWp0Vlc1eStFV0cza2dDZWxXSjByUzlDV1ljVUR3dFhnR3BhWTNQM3JzYW1o?=
 =?utf-8?B?VnJObXgxWkZvbmxNTlhYdFY0d3QwTWxESEY4SGdvTXdMTmhLQllROHA1SFFr?=
 =?utf-8?B?cE9tUEtnRUMvWXBITlVqS2pRZ2N0WE1wZWxNdVcxRDk4VkJrUC9ocnpRMk9P?=
 =?utf-8?B?TXptL2JPQ1J6U0FoemMrWjM5a21IV01FMXJIYlA3RjZqM05MQ2dpYkFtYU1B?=
 =?utf-8?B?TDhmV2E5bjhKY0xmZjQ4SHdsYXRnd0duU1FXS1FLbnlrTlNGK3RseURpTnFT?=
 =?utf-8?B?MEd5Yit1K0ltR1dJN2MwQWptZzMvVlZPQnJiOWVraURwNjJQMnNIdnpiMm5h?=
 =?utf-8?B?cnQ4bEYzVFFrU2FFVkc0TTI2TU5GczE5bWh0cXZqSDR3bzlZeDd1U2FudWt3?=
 =?utf-8?B?emtONmpzOFcxbFI1M2taancrWERnSkZ0UlA1eVRtZU1tTnZyNTBneVdMQnNu?=
 =?utf-8?B?dG10WE9hZjhUQURDZ0h5eU1TcW5UV0pZczJwYzIxM05zTXBhUUJWdjFTeFdE?=
 =?utf-8?B?STRxcnAvSTY4S3ZOK29OK1dqUnI1UFBCQlhOdXR0NVl2Z0RncnRMWlVISVJi?=
 =?utf-8?B?Zno1WG9BMW83cXc5cFlWTUEvSDV3UDBscHBoWGlpVHVaZFZDNkkxNDVuT1Jt?=
 =?utf-8?B?YlVLdTA5b1N3TEdrdC94aFhJTFRBd0pxY1pKWjRuQm9TeVcvNGhRekRqK0tH?=
 =?utf-8?B?eWlPeUpOQ1IrQmU1eHlBcVlRcno5bWswcVRZdCs3ays1Ung3ckRaVlpFc1p1?=
 =?utf-8?B?aGZTV216ZmFxMGFjSGNWZzRvQTJvNGR2a05lTTEzc2t5OGZ5aUhwSDFnTE1X?=
 =?utf-8?B?K25Jby96eUFPSXpYMnNsVDZDcUdzbkhmd3J0aHNFOWN1Y0E2dDZ6cXZvSnBz?=
 =?utf-8?B?RmRKdUREYWRic3N5N1VMMXo4aG44SmNxTm1yWUtvNUVHc2FyclJnSjZ6a241?=
 =?utf-8?B?QVhPaG9HbjMzT1daU3U1aDkxWVBQeWN2dGxIZUFsWEtJeWpTRjNGc2cxQjNa?=
 =?utf-8?B?eEc2WXhSSkpwTWRJOXRoQkRTSTdhZUdZS2JlOU93YWFhOE5HOWpiUDFBcmZK?=
 =?utf-8?B?SXRMaUtzcllmdTU2b1FZS0xJM1dGVWswM1l5RC81RStDOVB0eElHajZMWXV4?=
 =?utf-8?B?eml3bnJUYno5SmFWRlFpQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eTYrbStkczVQaldzK0YxN2UzRUdOREdlcEVTZGNzNTZCOGZHRWN3U2JZWmg4?=
 =?utf-8?B?MStMTlNIV0g1V08rMThZWGVndjBYTmV5VTB0UE1XckU4Y21jY1hBZy8wcm9M?=
 =?utf-8?B?LzBuelNGS3d0L1lOSGJrdmtpUU84WElycElWSWRxendnZStJRkU2WEZKUlBN?=
 =?utf-8?B?akNNVVJPOEhRYkMyd0h1WDFLOFlpcVJxL3RkNjdCVExaL3J4YTJlUW41bU1h?=
 =?utf-8?B?V01PaXA2eEdpZzJWalB3TGpvazRma29uNDlmM0dVQVBzV01uUXdhYlg3V3Rx?=
 =?utf-8?B?WG1HTmpDbGs3bFBtaTkzNVpYLzlISEMzWmIwaUpzaWIyWm1pdDNxbHZyYVBU?=
 =?utf-8?B?eWhHM3l4TkVneTBrT0VGSGxaVG9KYmtRT00wWHZ5RDd4bE0zY2o5N1lRNHBs?=
 =?utf-8?B?U0NHUDB4QklOSU9VaFhCVDVuTVRoZzlYMEJ0VHVLWGVYSU1mMjV2Um82TDNF?=
 =?utf-8?B?cWJGVWplbjd5UW4rWXR1aGhUTzBwcWFZMUs4STlvWkN2aHk1eHcrdVJrNzcr?=
 =?utf-8?B?ZzM1ZWZVbXdDeTVBTjFKdXltVnAwNDdKZTYrQjRNWkdhSkxLVG8wVGE1QUdT?=
 =?utf-8?B?MTMwd0VER3oraTRwSWZrTUhsaFhUNmZPQnpJMThjcW10dTdzOGtzR1hlaWZK?=
 =?utf-8?B?VGhoeGxwd3BqZ0twdnY4Y0ZXbndhUUFhbFZUbkJwdzNxb3IxWUNuWEdRaHR1?=
 =?utf-8?B?aWZZV0hwWDhwMHhxTlVXRHloaUY5U2x6bmVBTkNUY2hxQlQyTUpTb000bVRN?=
 =?utf-8?B?S1lCd1ROcHNLMHF0dDdxY296ZzF6SktReEtTd0pTY1c0YmM4ei9vTEZob2sw?=
 =?utf-8?B?UEgyQjJQeFFQZkYyWHg3ZWF2ZjhHcEhveXI2UDhpeTMvNmVtbjVISGFFQWt4?=
 =?utf-8?B?ZHZKSDBCeFlGZ1FvMUx0cXVsdkFQdVplRzkwRHVmM3Q1VTQ2dWxsdExkL2E2?=
 =?utf-8?B?aVNPSEpqU0kxb3E5T1loeUxLdDZkOFV5Vll1dzZVYkNiR3RaWEU5anBQMDNz?=
 =?utf-8?B?SmhtV1hnU1dOaEdvSGUvNWdSNVNjaldBZFljaHQyNjAwQTBHR1R1MjFlMTl0?=
 =?utf-8?B?NWxOMm9FYmxmVURSMndZdHZaekhPN0s4Q1RCMXRkRmo0OE5jVUdvNVY1Rml6?=
 =?utf-8?B?enI4ZzZVVHF1cW41Q1RxRXlnQUY0eDIvYkpXRTdUMkxDbkVlK1JIcy9hQWRs?=
 =?utf-8?B?cGJYWjlqZjhHc0xsL2hKQXZmRXdRSGloMHhSL0dvMmlwbCtoK3pudmJ6cWNn?=
 =?utf-8?B?UHlyQ3g2UWJKQm1Ob3p3RjdqOUwzZmFOV1dzYW5zaUVNYkJWWE5Bb2hGTFhm?=
 =?utf-8?B?TnRGTUxDNjlqbVNIVFJpM0hlNWtpQ2tITVFjV0lVdUp2NUQyT3Nxcm1OdGY3?=
 =?utf-8?B?akpCbVE2NGtnUkVWa1Y0VkZNQ2NBbjdxc0pwQUtWRlYrbmVid2loZUtvdmVP?=
 =?utf-8?B?a3JuVWVHMHVUTjdMbU02dGpnZ2JKWUdtemQyelM0aGlick5NSDJWL0dhUXpN?=
 =?utf-8?B?ZTJNSTV5bFZFai9JRlQvQ1Z3NnUvTEx1QVZidks4UWZxMDgvRitWNXFEeEkw?=
 =?utf-8?B?bGplRi9uZ1pxeUpoWE9Fd1YxUjR0RWNWZWRsK05uU1gyTFNEekJpTk9UV2to?=
 =?utf-8?B?TXpvTlh1OGF5TE13NmdxeEg4NlRuS1Ztd0VFdElvOFg3N1BDWDZvaTBvQ3lx?=
 =?utf-8?B?bzJGc1hiSmxDMWh4ZURsZUZzdys0QXFoWCs3MFlnOGJyczRSeXJPaG1kdWJx?=
 =?utf-8?B?WXhyVlNNQ1RUVC9uTHNwMmxsY2MwNUhqak5QVTR5MjBFMFppL2w0TnJ5Njkr?=
 =?utf-8?B?czVjL1BSRGdGbUhlRWJLeGRTd2V6N3V4dlVnbFY4MktTTllGYjhYY3JDRDRC?=
 =?utf-8?B?ZUI5SHU1S0JYakdDRFd2VzgrbVJZOFpmNURRV3JJVWN0YXFWVmNnRG0wekpT?=
 =?utf-8?B?SmMyL1ZKY3ZMTmM5NGZHVVZwNjZ3dzlPQVdRZXliT2tNK2lSNkdsZkhHS2xo?=
 =?utf-8?B?Y0FoWm1yb2VzS0RiUmVvaDVKS0wzTUFkei9XMHJHTGsyY2QrcjRJMmxWOEYr?=
 =?utf-8?B?Wld3N05TRTNaWjE4MzJHd1lXVTRicjVVQ2lQand6OFhCV1FaVGlNV1hiOUJH?=
 =?utf-8?B?VkFsakF1Wjg3UXdCWEdpbWo0b0lZQWR0ZmRvL2tOSFBadEIvUCtqd1ljVm9x?=
 =?utf-8?B?cEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aCMW1FdGuXJJZyyOBbMW0xRsuaYLMXxnQZh+gBw42h/rTn9xqnSNvI8gn4lha/pCQWMHsvXtXgy1ITL71SjfXw/QRzXWwBCtSxizMc2RUO0zu9FWEestbemw/TtwjNiauNergeJsuZbg2PiQtygNKara9tjkzQrXKobAS44ZN7EtYLqaw/pyDmT3x1xkuADUdB03gtQ06VXMtnFKx9DLl3mkqXawWHC/q+RFCF+mCIrR6boyPBvQ0Jc9H7PS2cUtjkhnqTC/51Cjtu0uAJR6lyx/+2rRR0qMdT016LpSsUQXjcOGBbtesVs6gCfGdl/W6VnCn+bOn+ww3sEqRFPj/F7OvyXIs9n2k7W4+3hXcwhU5VKK0+Ely2cvp+/rzGhVsY/JxMC/SeZGO5TsHao9vVlsaV3rFSf7t2tLnR7uzsMjWLk2e0xe7QAR18aNEF1VP6FyO2pZQTFnLPvas9OKIunnS/IBkj3q7tF/u2mZ+dxIaUwIuzT6TcglGWE/RZzk0YBkTTNjDL2HCFrI9ylu8vQp96oFb2OzUJxoPicO3nKL1oLNUtGFfqw/1jXpGC+foiTeXLliX3dORcpAUtRrjfoK2XqfhSoWSFdHYxVWu0s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62964a02-a728-438b-ceb6-08dd67f13c92
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 20:53:15.9540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZUz6CYIf/r87I17++nxt6WmM5m+BRIsk8zZEs77wmKXKNT9xuPBpUd9ftoUzjzSRGTP3v3rUbQgdC2EeddKGmOtyCWW+m+Oy9tw52YTpDUM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7021
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_07,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503200135
X-Proofpoint-ORIG-GUID: 26h4Wd5FE6r1UsMQ7hD02Iui4n2lv3P3
X-Proofpoint-GUID: 26h4Wd5FE6r1UsMQ7hD02Iui4n2lv3P3

On this - urgency is less as vmg_nomem() really can only occur with fault
injection afaict as it is a 'too small to fail' scenario, so we won't see
this IRL.

So we can relax a bit given LSF timing etc, and do something for 6.15rc1
I'd say :) then we can backport as needed obviously.

Also if this did somehow happen under such extreme memory pressure the
process would soon be torn down along with the system...

Sorry Jann, no security flaw here I would say :P

On Thu, Mar 20, 2025 at 09:11:33PM +0100, Jann Horn wrote:
> On Thu, Mar 20, 2025 at 9:02 PM Pedro Falcato <pfalcato@suse.de> wrote:
> > On Thu, Mar 20, 2025 at 12:09:36PM -0700, syzbot wrote:
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    eb88e6bfbc0a Merge tag 'fsnotify_for_v6.14-rc7' of git://g..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=11e6c83f980000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=77423669c2b8fa9
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=20ed41006cf9d842c2b5
> > > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> > > userspace arch: i386
> > >
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > >
> > > Downloadable assets:
> > > disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-eb88e6bf.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/ded0ce69669f/vmlinux-eb88e6bf.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/6e6fa3c719e7/bzImage-eb88e6bf.xz
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+20ed41006cf9d842c2b5@syzkaller.appspotmail.com
> > >
> > > RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> > > R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
> > > R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> > >  </TASK>
> > > BUG: unable to handle page fault for address: fffffffffffffff4
> > > #PF: supervisor read access in kernel mode
> > > #PF: error_code(0x0000) - not-present page
> > > PGD df84067 P4D df84067 PUD df86067 PMD 0
> > > Oops: Oops: 0000 [#1] PREEMPT SMP KASAN NOPTI
> > > CPU: 1 UID: 0 PID: 17805 Comm: syz.8.3237 Not tainted 6.14.0-rc6-syzkaller-00212-geb88e6bfbc0a #0
> > > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> > > RIP: 0010:vma_merge_existing_range+0x266/0x2070 mm/vma.c:734
> > > Code: e8 5f 25 ad ff 48 8b 14 24 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 1c 19 00 00 48 8b 04 24 48 8b 74 24 08 <4c> 8b 38 4c 89 ff e8 9f 1f ad ff 48 8b 44 24 08 49 39 c7 0f 83 db
> > > RSP: 0000:ffffc9000319f988 EFLAGS: 00010246
> > > RAX: fffffffffffffff4 RBX: ffffc9000319fae8 RCX: ffffffff820cd3e5
> > > RDX: 1ffffffffffffffe RSI: 0000000080c2a000 RDI: 0000000000000005
> > > RBP: 0000000080ce2000 R08: 0000000000000005 R09: 0000000000000000
> > > R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000001
> > > R13: ffffc9000319fb08 R14: ffff888025eddc98 R15: ffff88804eec0a00
> > > FS:  0000000000000000(0000) GS:ffff88802b500000(0063) knlGS:00000000f5106b40
> > > CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
> > > CR2: fffffffffffffff4 CR3: 00000000614d6000 CR4: 0000000000352ef0
> > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > Call Trace:
> > >  <TASK>
> > >  vma_modify.constprop.0+0x87/0x410 mm/vma.c:1517
> > >  vma_modify_flags_uffd+0x241/0x2e0 mm/vma.c:1598
> > >  userfaultfd_clear_vma+0x91/0x130 mm/userfaultfd.c:1906
> > >  userfaultfd_release_all+0x2ae/0x4c0 mm/userfaultfd.c:2024
> > >  userfaultfd_release+0xf4/0x1c0 fs/userfaultfd.c:865
> > >  __fput+0x3ff/0xb70 fs/file_table.c:464
> > >  task_work_run+0x14e/0x250 kernel/task_work.c:227
> > >  resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
> > >  exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
> > >  exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
> > >  __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
> > >  syscall_exit_to_user_mode+0x27b/0x2a0 kernel/entry/common.c:218
> > >  __do_fast_syscall_32+0x80/0x120 arch/x86/entry/common.c:390
> > >  do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:412
> > >  entry_SYSENTER_compat_after_hwframe+0x84/0x8e
> > > RIP: 0023:0xf7fe6579
> > > Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
> > > RSP: 002b:00000000f510655c EFLAGS: 00000296 ORIG_RAX: 0000000000000135
> > > RAX: 0000000000000001 RBX: 0000000080000180 RCX: 0000000000000001
> > > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> > > RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> > > R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
> > > R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> > >  </TASK>
> > > Modules linked in:
> > > CR2: fffffffffffffff4
> > > ---[ end trace 0000000000000000 ]---
> > > RIP: 0010:vma_merge_existing_range+0x266/0x2070 mm/vma.c:734
> > > Code: e8 5f 25 ad ff 48 8b 14 24 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 1c 19 00 00 48 8b 04 24 48 8b 74 24 08 <4c> 8b 38 4c 89 ff e8 9f 1f ad ff 48 8b 44 24 08 49 39 c7 0f 83 db
> > > RSP: 0000:ffffc9000319f988 EFLAGS: 00010246
> > > RAX: fffffffffffffff4 RBX: ffffc9000319fae8 RCX: ffffffff820cd3e5
> > > RDX: 1ffffffffffffffe RSI: 0000000080c2a000 RDI: 0000000000000005
> > > RBP: 0000000080ce2000 R08: 0000000000000005 R09: 0000000000000000
> > > R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000001
> > > R13: ffffc9000319fb08 R14: ffff888025eddc98 R15: ffff88804eec0a00
> > > FS:  0000000000000000(0000) GS:ffff88802b500000(0063) knlGS:00000000f5106b40
> > > CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
> > > CR2: fffffffffffffff4 CR3: 00000000614d6000 CR4: 0000000000352ef0
> > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > ----------------
> > > Code disassembly (best guess):
> > >    0: e8 5f 25 ad ff          call   0xffad2564
> > >    5: 48 8b 14 24             mov    (%rsp),%rdx
> > >    9: 48 b8 00 00 00 00 00    movabs $0xdffffc0000000000,%rax
> > >   10: fc ff df
> > >   13: 48 c1 ea 03             shr    $0x3,%rdx
> > >   17: 80 3c 02 00             cmpb   $0x0,(%rdx,%rax,1)
> > >   1b: 0f 85 1c 19 00 00       jne    0x193d
> > >   21: 48 8b 04 24             mov    (%rsp),%rax
> > >   25: 48 8b 74 24 08          mov    0x8(%rsp),%rsi
> > > * 2a: 4c 8b 38                mov    (%rax),%r15 <-- trapping instruction
> > >   2d: 4c 89 ff                mov    %r15,%rdi
> > >   30: e8 9f 1f ad ff          call   0xffad1fd4
> > >   35: 48 8b 44 24 08          mov    0x8(%rsp),%rax
> > >   3a: 49 39 c7                cmp    %rax,%r15
> > >   3d: 0f                      .byte 0xf
> > >   3e: 83                      .byte 0x83
> > >   3f: db                      .byte 0xdb
> >
> > Ahh, fun bug. This *seems* to be the bug:
> >
> > First, in vma_modify:
> >
> >         merged = vma_merge_existing_range(vmg);
> >         if (merged)
> >                 return merged;
> >         if (vmg_nomem(vmg))
> >                 return ERR_PTR(-ENOMEM);
> >
> > then, all the way up to userfaultfd_release_all (the return value propagates
> > vma_modify -> vma_modify_flags_uffd -> userfaultfd_clear_vma):

Oh lord... thanks for your analysis Pedro! But also, oh lord.

Yeah this 'pointer actually is an error value' thing is a thing I've seen
(and *ahem* caused) before.

It's funny because userfaultfd_clear_vma() -already has handling_ for errors...:

	if (!IS_ERR(ret))
		userfaultfd_reset_ctx(ret);

And yet...

> >
> >         prev = NULL;
> >         for_each_vma(vmi, vma) {
> >                 cond_resched();
> >                 BUG_ON(!!vma->vm_userfaultfd_ctx.ctx ^
> >                        !!(vma->vm_flags & __VM_UFFD_FLAGS));
> >                 if (vma->vm_userfaultfd_ctx.ctx != ctx) {
> >                         prev = vma;
> >                         continue;
> >                 }
> >
> >                 vma = userfaultfd_clear_vma(&vmi, prev, vma,
> >                                             vma->vm_start, vma->vm_end);
> >                 prev = vma;
> >         }
> >
> > So, if uffd gets an IS_ERR(vma), it keeps going and takes that vma as the prev value,
> > which leads to that ERR_PTR(-ENOMEM) deref crash (-12 = -ENOMEM = 0xffffff4).
> > This situation is kind of awkward because ->release() errors don't mean a thing.
> > So, I have another idea (pasting for syzbot) which might just be cromulent.
> > Untested, but thoughts?

Yeah that seems to match the values, I did wonder about this 'underflowed
u64' value and whether it was an error one and yeah.. sigh.

> >
> > #syz test

> >
> > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > index d06453fa8aba..fb835d82eb84 100644
> > --- a/mm/userfaultfd.c
> > +++ b/mm/userfaultfd.c
> > @@ -2023,6 +2023,8 @@ void userfaultfd_release_all(struct mm_struct *mm,
> >
> >                 vma = userfaultfd_clear_vma(&vmi, prev, vma,
> >                                             vma->vm_start, vma->vm_end);
> > +               if (WARN_ON(IS_ERR(vma)))
> > +                       break;
>
> If this WARN_ON() was ever actually hit, I think we'd leave dangling
> pointers in VMAs? As much as Linus hates BUG_ON(), I personally think
> that would be a situation warranting BUG_ON(), or at least
> CHECK_DATA_CORRUPTION(). That said:

Yeah indeed, agreed.

>
> >                 prev = vma;
> >         }
> >         mmap_write_unlock(mm);
> > diff --git a/mm/vma.c b/mm/vma.c
> > index 71ca012c616c..b2167b7dc27d 100644
> > --- a/mm/vma.c
> > +++ b/mm/vma.c
> > @@ -1517,8 +1517,16 @@ static struct vm_area_struct *vma_modify(struct vma_merge_struct *vmg)
> >         merged = vma_merge_existing_range(vmg);
> >         if (merged)
> >                 return merged;
> > -       if (vmg_nomem(vmg))
> > +       if (vmg_nomem(vmg)) {
> > +               /* If we can avoid failing the whole modification
> > +                * due to a merge OOM and validly keep going
> > +                * (we're modifying the whole VMA), return vma intact.
> > +                * It won't get merged, but such is life - we're avoiding
> > +                * OOM conditions in other parts of mm/ this way */
> > +               if (start <= vma->vm_start && end >= vma->vm_end)
> > +                       return vma;

I do not like this solution at all, sorry.

I mean I get what you're doing and it's smart to try to find a means out of
this in general :) but let me explain my reasoning:

For one this is uffd's fault, and the fix clearly needs to be there.

But also, we _can't be sure_ vma is valid any more. The second it goes off
to vma_merge_existing_range() it might be removed, which is why it's
critical to only use 'merged'.

Now you might be able to prove that _right now_ it'd be ok, if you do this
check, because vma_complete() does the delete and only if either
vma_iter_prealloc() or dup_anon_vma() fails would we return -ENOMEM and
these happen _before_ vma_complete(), but that's an _implementation detail_
and now we've made an assumption that this is the case here.

An implicit effectively precondition on something unexpressed like that is
asking for trouble, really don't want to go that way.


> >                 return ERR_PTR(-ENOMEM);
> > +       }

>
> Along the lines of your idea, perhaps we could add a parameter "bool
> never_fail" to vma_modify() that is passed through to
> vma_merge_existing_range(), and guarantee that it never fails when
> that parameter is set? Then we could also check that never_fail is
> only used in cases where no split is necessary. That somewhat avoids
> having this kind of check that only ever runs in error conditions...

Yeah hmmm, again this is _not where the problem is_. And we're doing it for
_one case only_, who _must_ succeed. Right?

Buuuut then again, we could add a _feature_ (it'd be something in VMG not a
bool, hey what are helper structs for right? :P)

We coould add a special mode that says we __GFP_NOFAIL, we do that in
vms_abort_munmap_vmas() and man that was under similar circumstances (hey
remember that fun Liam? :)

But at the same time, it feels icky, and we probably don't want to
proliferate this pattern too much.

So I'd kind of rather prefer a _general_ no-fail unmap that the uffd
release code could invoke.

Perhaps we could genericise the vms_abort_munmap_vmas():

	mas_store_gfp(mas, NULL, GFP_KERNEL|__GFP_NOFAIL);

And make that available or some form of it, to do the 'simplest' thing in
this scenario.

If we called that say vma_emergency_clear() then we could do something
like:

void userfaultfd_release_all(struct mm_struct *mm,
			     struct userfaultfd_ctx *ctx)
{
	...

	for_each_vma(vmi, vma) {
		unsigned long start = vma->vm_start;
		unsigned long end = vma->vm_end;

		...

		vma = userfaultfd_clear_vma(&vmi, prev, vma,
					    vma->vm_start, vma->vm_end);
		if (IS_ERR(vma)) {
			/*
			* We can no longer rely on VMA state, we must
			* unconditionally leave a gap.
			*/
			vma_emergency_clear(mm, start, end);
			vma_iter_reset(&vmi); /* Probably? */
			prev = NULL; /* Probably? */
			continue;
		}
	}
}

I mean this isn't fun either. I wonder if we (that probably mean sme)
should go audit cases like this.

Another possible solution is to add a flag that _explicitly asserts and
documents_ that you require that no VMA be removed before attempting to
allocate.

Or we could make that an _explicit_ assumption?

And then the uffd code itself could cache vma and take Pedro's solution on
that basis?

void userfaultfd_release_all(struct mm_struct *mm,
			     struct userfaultfd_ctx *ctx)
{
	...

		for_each_vma(vmi, vma) {
			struct vm_area_struct *old = vma;

			...

			vma = userfaultfd_clear_vma(&vmi, prev, vma,
				    vma->vm_start, vma->vm_end);
			if (IS_ERR(vma)) {
				BUG_ON(vma != -ENOMEM); /* Sorry Linus! */

				/*
				* OK we assert above that vma must remain intact if we fail to allocate,
				* We are in an extreme memory pressure state, we simply cannot clear this VMA. Move on.
				*/
				prev = old;
			}

			...
		}
}

I mean it's going to be dirty whichever way round we do this.

Thoughts guys?

But key point being - this is not quite as urgent as it might seem :)

