Return-Path: <linux-kernel+bounces-570372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D214A6AF83
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 22:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9DD0189B828
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 21:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1BE229B1F;
	Thu, 20 Mar 2025 21:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="F59ii4UO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TragtQ0b"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64999209F4D
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 21:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742504452; cv=fail; b=Z0/FATyKrRA+VKTKnaVQPTD/jAZuA6xk0/rWw2+hL0F89O/7N5eIyfROeKgKlh+xrtm1tZGicVR0rY8BpmwTAq16cQKbYW+zfL5PHBfHUv5zneRzq0pQqi5fRU/RzENP9FkRZKAETXZMbGMlMWQrMlW0fbBZFK/8IwwePqTS8HM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742504452; c=relaxed/simple;
	bh=xFI7CMH6oaX3KgmVRcXTGgdpTolBsA3vj3nfRuqE5+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gLdVPwuF0fB8/fQeSCWKSi40l8sJUc0hxF/FlALOoBIWuXtMSnvt07RzhkSMoDk3fsWrtIf4qpfq7WYX9P4Eujr7kb9DBTr3Akk+a3Qd7vNltIQnMjJH5VCvPtldDXoKcGU47clJsT/A24XfOBP+xaw8WY3TcjwpcYADcmzi8/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=F59ii4UO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TragtQ0b; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52KJN5LF009388;
	Thu, 20 Mar 2025 21:00:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=HNJdtC7t0VvH/weRoRxhTP30QzR3dLvKpJRQ2oEBZ30=; b=
	F59ii4UOm3A7uCBwELq50AP+mxq4QISAzXSfw9hUDeI9XC8SsJD1bcdYUE0ADnQt
	XyAumvhi4zAsQtDX20ztF1Mgl3vSlg3g5hN8+dKThKuzPm3gZTcUipx7a3hwRdIu
	rTgYS58vfC4u8t75zBNQEgy9KEfLCgmfyFDjnzlZEEWYNpXArsq5aEKnsv/ruOCX
	Iog7/xmvFnHaF6XfN8pWOpkFrRVzS3PyeaQPyTgDHx1UPN+uhydSE/7HjYZp/EuP
	RqfS3HcF5wSBIVvRI9wyHb8MlEkTn+GenI7mri0R/IOL3JXsxyZP7JVK4w4L4zIa
	Agzk4kuxLIeNjJ8Jii2T9w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1n8q0ms-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 21:00:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52KKjqvi022430;
	Thu, 20 Mar 2025 21:00:38 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45dxejx1dt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 21:00:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p5HHeDir1tLBpFM0r//sHvcuBZnr8IHxs0qSvETRx8dKQMKhr3YOHXY9V5cWvvQP27IzH9uCynoau8ulipddr1oLXGpkuM6gHsI94bY+gXL6fi8CYleJDNKyTx9HEc13bqw2IIdZkLZIVqPP7uWlQ0z79SJSVSSHYTTBkaomVfy6jVh9iiUEkNjEmAhLqwmixknbKjKDGr3/Gh0wQK7hU7UOEUUkTff6/j4TUn+OWJ9ouXwp2IW6ju7id+cW1qI1R/GL1t+y8eD2hFPZCB8e0AObKqC5x/aDzcgh0yoe8+paX9dL3QShHTMXKizdD14MOw3ltp4Z7vSAPXBfn5wYzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HNJdtC7t0VvH/weRoRxhTP30QzR3dLvKpJRQ2oEBZ30=;
 b=A42L7cDNvE3cQWUeCaVGIZd6f6NTcWG5/m3VQck5HNIGsD1YaKjKWWLLK3E+H1dJ3l2Cmx+EAHYxNi3LwPY6MNBi272ap98d/5UOLFB7CfGGBvEgC6hDvSsnbPIEUDY9b9i7sxG+62NtT72NXQ80NALEvwFCLv3tkA4dEIPDNTBzTjsMFDvxLEtWkul5qk1U3LnM9hxVcg6rOgcZIaj5yPqysrlqAZqoRyhwtjxdF1fcWLrnRjxKMGprScQwoXW26XC3OwzHdJ5Xr29KbtaU22VSyxZaQDcWmK1IbDPrp2yeslGeWdvoPTM0utFfo5h1GLP+UKdQiz+GK1y8FgpUtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HNJdtC7t0VvH/weRoRxhTP30QzR3dLvKpJRQ2oEBZ30=;
 b=TragtQ0bvqtwy41t6SI3rZGTMsTRoay7SBeom2FkhVC606uQTIm7UetU7iRqGWx1zaKmtb6e8WhWcJmkQ0ci29KZHm863Dwqrk0MArPPaF/oOtpah+K6RLNtBW39TictMv/id0+UujUAtGFtKM5e4wjMJHFI7Ibu2GvhM4a3P7A=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CO6PR10MB5539.namprd10.prod.outlook.com (2603:10b6:303:136::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Thu, 20 Mar
 2025 21:00:35 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.8534.036; Thu, 20 Mar 2025
 21:00:35 +0000
Date: Thu, 20 Mar 2025 21:00:33 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jann Horn <jannh@google.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        syzbot <syzbot+402900951482ab0a6fcb@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] KASAN: slab-use-after-free Read in
 folio_lock_anon_vma_read
Message-ID: <fa59cd55-29a6-467b-add4-751944f0cb5e@lucifer.local>
References: <67abaeaf.050a0220.110943.0041.GAE@google.com>
 <CAG48ez1X4TMPAFO4DLpMJ7JqAXRPMeTy5_BEGQ6nW1DJVi0biA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez1X4TMPAFO4DLpMJ7JqAXRPMeTy5_BEGQ6nW1DJVi0biA@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0348.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::11) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CO6PR10MB5539:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f4396c6-6456-4fb0-de0f-08dd67f242aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QUs1aUNieXV0bWxjZFJNTHloeGptTHZ2dlRTNUxEUndjdlczQVF2V1pWQmtS?=
 =?utf-8?B?dnpnQ3hzQ0psVWNTK0ZiamRSSEkzZzBuVDBTL0JKQzErRE9aNG0zM0s4ekFw?=
 =?utf-8?B?NWo1WG1HYVVEMVByMC9KZW54d2M4V3djc1E2YkNrYVNaSTR2MXl2a0pWelg0?=
 =?utf-8?B?WUFzLzY0UXU3VXZaZXZLbm9Vb0lwRm9VaE1ncVNFZ3FYQkxYRklRbzNEZGVo?=
 =?utf-8?B?OFRrRVh3eGxhUVY1NmdNdkdIU3M5M1J4eTRXV1FwQkVGM2IvUW1QWmZpZThr?=
 =?utf-8?B?QnFmd1lWS2tMbDRtL21GZHZWN3ZqODBxL2dPaGVmTjNDbUZ2MHdhZThGQ1ZU?=
 =?utf-8?B?bWxWbEhNb0pkbnVydjh3Wjg5Sks5U2laTGl6ZEFlbHF0cFF2OUxlSHpGTDFs?=
 =?utf-8?B?VDJYNmQ2WmFLb2pQa0t5Qk9kL2k3ajRYY1ZpdlM3dk5tMndtdXdqR0l1RjQ4?=
 =?utf-8?B?T2J2QXRIdlpsWGFVZElCeGNkbjRHTjdpdU0yTSs5UEtLN1hsRzdYWC9mMFFF?=
 =?utf-8?B?SkxQUWZ0alllNmNhcC9ra0RWQXV3MVA2aTkxazd4Q0V1RWdTdE81ejQ2bjhT?=
 =?utf-8?B?YldkQWE4Z3U0d21INmQyZzlxaWJtWFJSbzh0NDNidTRBVXkxaUlkc0VqZS9i?=
 =?utf-8?B?Q1AwcEY5U2hFNmR0TkZhN21XMVRGSS9OcEdPeGR5bHYyQ0ZNTGNqNFpCLzI2?=
 =?utf-8?B?QklWODlBcXBCOHZZbzRPaHVoamsxSnRTWXlQZjNxMnVCR3N5Y2w3dnlFUDAy?=
 =?utf-8?B?Z2FPaXNqNU1IUlVjbHVQM3F3WDVRai9TcXJrbE56VXpoQ2pUcklTa3JuMTVD?=
 =?utf-8?B?M1JZbS9sZU1yR1d6TitHbHE0eDR4dlFLM0RYbGlYQWJkOWtlWXVGY1dqTUVl?=
 =?utf-8?B?dUNQZzRuZ2FoeS9xalIxVjQxdkgrU0ZFR0piejFlcTFoUUlDY1JSY0VjcWUx?=
 =?utf-8?B?eFlQaVF3Y3VDd1lUc3RXaUk5ZGxJTUtScS9DQm9uS2w2Yks2Q3dqQnM0S3Rk?=
 =?utf-8?B?T1FyRzIwVDdCQWFmaXp4Mk10RnJPcXgzWWJ6R29Rci9HVG9jSnVhTzFZUEdp?=
 =?utf-8?B?bS9hZTcyWVQwblhGYm9WR0NWTCtweHRmQjNRdXdSL0FSVFBXNGt3VUdieldn?=
 =?utf-8?B?S1NaSTFXUzZoYWhmdysySTEyekYzRHpydFlKS1ZZUEFEK0NWckVnaGpjQkpj?=
 =?utf-8?B?L0QvWGNKL3R4dGJxRUxaVllKUzVuSWFkOGIzbit3aVRkcStmUW9lY0w2Qjg1?=
 =?utf-8?B?YkZ3ampTS2g0UVowQ0N6QjY1WElnYUpFUFYvTGZXbE1UUHNYQWZ2cXE3Rml1?=
 =?utf-8?B?bUhMMEpQWE10QnE1WkRtWWFmOTdoUGIvOHhHdGlPV2RHc3Z0K3NEczhpeHJr?=
 =?utf-8?B?UUJ0c0N2V0ZyUW84cEUyTHlUd2FQR0xTUk8xVktyL05sbmlPYmdUWUhNbnRB?=
 =?utf-8?B?WXNDYm0wYWlvZnlOZkdTNFZZbnJKNnpzZmZrV0xZZGF1ZEFkdE1xeUgxVUR2?=
 =?utf-8?B?R1FaNXlGeUEzOHRkNjdvTjRKQ3pkczdYc0ZqRWd5V25pMEQzTGtITEM0dDZF?=
 =?utf-8?B?RFRuRWFJTUdDMncyYlM2WGY2M1laQUZEdGphSVNDUnkvSVEvSk1OWVRBeFVP?=
 =?utf-8?B?VXVVOEt5Mit1ZFRETkNpaW5XRXFJb0JVajU4Y0Z5TWRuV041U0ZnM0o2Yis3?=
 =?utf-8?B?SFhSYWFwZ0huRWIwQXBEWjFzeS9oR3hVTTBxN0Rsc21zclpBbmVNZFo5bXlO?=
 =?utf-8?B?YW14b3dCampvSW1hZTNtald6VHR6N0F0UEdHalhvdGl1ZnZkQ3FSNkR5VXNR?=
 =?utf-8?B?ZjZySFV5RytLVDhFclNIUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VXhyeDdHQzR6MDhJQytjSE5YMnZjSW1JNWFXN0NaK0xENGs0ZURuSzhEMmVi?=
 =?utf-8?B?L0ZZczZTNm04anlITG0rQWRHS3pIbXpCQm10WjNnOE9IRGtvcDBnbFI3N21Z?=
 =?utf-8?B?aEZHd0I2VnlYWDYxSzBoaGFVdUtmS2ZscXVsNFlkZmx4ZnVBMGpNY29hTkw3?=
 =?utf-8?B?cEFBeHpDUHM2aXF5TzFnK0wrSTZxV1FveW9HOGpEbEFiUDJFbG1kYXZ2bER3?=
 =?utf-8?B?d01BT0RpdjRZNk5tTksyVjl0SGxRYmkxcHM0VzBFa2ZqMHo2a0RiVFBNUjl5?=
 =?utf-8?B?M1puZ0lUQk9pdGJxLzFrU1FkZCtqTis0Zy9haGdYT0JUNmdjamFseWtGTnZH?=
 =?utf-8?B?NHQ3b2hPOVZBY0pRUU4wRnZuZE5SOVh2ZDVhMmF3VFFobGxqejVSMWlvSDVT?=
 =?utf-8?B?VWJHVUdOMHpzOXhBZ1VmUEJRd3RXZUJlZVFNSUxwRGQ3aDhtMGpFc1kxMkJx?=
 =?utf-8?B?T3NBeTk2ZWd4WlMrOUdiVEdCTkt0RGJJelA4WFdOeUpxMlZuRnVQUTRDeHJY?=
 =?utf-8?B?V0pndWQwbmVZdDZqZm04eTA1d0ZlejV1bHd1M0ZOUlhjb2JBRURWd1Z5NHVI?=
 =?utf-8?B?US9RRmdUZlo4UktWdnpTYXlTMmdXcjVXVllnbVpiazJXY0cwdDYzUm93dVNq?=
 =?utf-8?B?YlUxN1hXdWpVUHlvU3pUSEdiRGNqOTluMDhqalVjb0FhelRMdWdmdE1Ecjdo?=
 =?utf-8?B?amZZYys1ZjhyYStaOEJiWWQvUzNHTFNhSTZiY1FWcHUxR0lHcmNrbHN2TWtD?=
 =?utf-8?B?YnF5T09TRjNabS9QdmRieGRiNkhlb3NqSm55cm1GODNENU4yWU5WQjY3Skht?=
 =?utf-8?B?b1RzNXZ4QytXUVhnb005WHVER255VmRlOU9UZ0lGU2h1eWR4Y2FxbVN5a1lC?=
 =?utf-8?B?eGpMNUJiYjdFaE9BNnhuNWRvQVVmQU1NeWlFbXZ0YzgwM0c3eEw4SHRrRXFI?=
 =?utf-8?B?Q0RlaDRhZVAyQS9oMVdCQ3Vqa2dKTU54YXJNamNES1BGRzM2Nmx5WVdyc2s1?=
 =?utf-8?B?by9kejZpcExaUjdYMzlJRnBOdjJmRWdmR3ZpYjhwd1JuT0w0ejFjTDZGMzNC?=
 =?utf-8?B?Wm81bjR5YTlYMkxGdjVLWmovbVBtVVNNeDQzcCtWK0VxZlYzSThCaUUzQnZS?=
 =?utf-8?B?ZEJybjJYMVNrdXlBTWpDeGROWTRLR0xmaXk1WStjaGJLV1BxY0F6TDE3QjZC?=
 =?utf-8?B?aVFFdjRneldOemIxd1M1OWdjb25LS3dDTjFuTzNKNnNBV0U3UWZXVzhlV0dq?=
 =?utf-8?B?ckthVTJMMHl5SWdhTEJBczRSRWVjRURUbTlOZG5kSVUyYnVCYURzMnRNTHg3?=
 =?utf-8?B?K0hzRUY5b2JaVXVmTG5Ta1RDdFZVODRUclErRWo0N1M5N2NiaWgyZmQ1Y1VG?=
 =?utf-8?B?ci9ncVRzMlBIUDJ5Ynd2S3QwUWFqcXk4S0R0b1FmVmZTMEt5ZEtuZnpwaUt4?=
 =?utf-8?B?YStxN3hROHpnVWRzNEYvOVF3N3ZNVkFrQ3h2VkVJYUQ0SGNCSjRpcFJZOHhM?=
 =?utf-8?B?ZlJCOVlkNDc3Umc2V3RaWEY5aXFmeWlBL0wxZk5SSHRQb2xSeHYraHJoOWZW?=
 =?utf-8?B?L01WbGxhbTBJM2s0TUx1MXYxMXUrclRrNUx0OFhLNHdxb2xEWlF2empuU1JH?=
 =?utf-8?B?ZDVVNGhuMENEZkpKUjcvS0ljMC9DNmpSWGM1bWRTN0xoQTdkSzB5eks2bU5l?=
 =?utf-8?B?bGtWRzUrbnBNWnl4RGtmSzdic1hLSEZ1enVicWpvNEJuNkVVNlQ0Ry96TmtF?=
 =?utf-8?B?d0oxaDlyZGxBcE52c01IL244dzRJcEtIdjQ1VHhGc2NXU0UzL1dXazN5MFJU?=
 =?utf-8?B?TWdoNEJqdXd5UTlSdU1wQytiMzB3blBZQWFEYTVIUUp5S3BlMEhYQlR4MWtS?=
 =?utf-8?B?SVhlMUowczJKaGFTM0QzWjFqY1grY3U4TFVUVCtqSHRlcWJqU29HNkVMRjgr?=
 =?utf-8?B?Ump0bTRLOWpwQXZSb3ZZV3paYWdZblFPRE8rcnhjei8wdmZBYXkzbUVlWS9s?=
 =?utf-8?B?ZTVhcUtoeFpCTnJ4c3N4SW1BVkdjY2hlNitzcW1oaDJHdVd1RGxwNC8wU0Rr?=
 =?utf-8?B?MlRUNVpaM0JNVXJSNmNSVnBvcHJtSE9QcDBrZS9vRkdyc1RINlg4ZG90SFF5?=
 =?utf-8?B?czl5VFR6eFQ3cmtOTVRmdUJSU0ZXekNaSkZtTEVXY0J6VmtWdUV6R01mSXVU?=
 =?utf-8?B?Q3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Y0x1Lce/1GZEsBmpwl0czT8W5JS7KypNEWS12j+f1CRyvrJEZqS24yG1cAp3993sHZZHFNWTn8teP0Hi+PEa+I7UpY9Ahtq+gL6ii8Y7XWQ71X6Wc9h75nQTQ1XOwkZgBTSJN3Btc66t1T8zoVzdXZCi2iH2P7rnugRo43RYQf1H9cWPyLKgxOFWvq9QniN41ZyvIel5n9KAd+jg5gK/9kK64c+0Q6zMEwii/4Hx4u3j3cXA+IlwHC/+md0R5OqmaHyjJgE/5wTREKN31o2BZG2pKlArGBfP0T8PCEpMqXegBuUdrMH3V95BShw8vkK0LT8Yew3//yVjRwYHiFHdpv230wPbI91oLPMYvMMdxgNi1KvktB9b0PT+PuawcnE+auC/wg89T2fza94pCD9a2Au84f1Znd0nwdMgFTRxD1nkOvzU9eaSGgqSxA8jHSytQtXwrH/X9kqRkvrc+brgbtg+5/NvqyHduAsu2WPQds82xpUpk6rRSUQAX1lsglBwAYilUkjzdGVAQF2fof8xBAky5Y3t26vIk2XbkzA1yhap3xmtkrM6hVZGZ4ue+uyt5ZHkGZJ5za8reqOunXALPtDTa88q6MBFMPhSlhrLd/0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f4396c6-6456-4fb0-de0f-08dd67f242aa
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 21:00:35.6470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 75lCrwkYAVo14Tx7kvfCDo8pqDVAzVcC/a8szmgqhP4Jtq06zEzLXkzrmNNaIQvQNLfcC6pOJGLauw4nuao7ZW0ISZ7quSNzQHWcfnT+Xi0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5539
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_07,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503200135
X-Proofpoint-ORIG-GUID: QaMIHeLDp-3XqJQDysvLfo69E8Jiczz2
X-Proofpoint-GUID: QaMIHeLDp-3XqJQDysvLfo69E8Jiczz2

On Thu, Mar 20, 2025 at 08:39:43PM +0100, Jann Horn wrote:
> +maintainers of Memory Mapping code
>
> I was looking around on lore and stumbled over this syzbot report from
> last month of an anon_vma UAF. I guess it kinda looks like we somehow
> ended up with a folio whose mapcount is >0 and whose ->mapping still
> points to an anon_vma that has already been freed?
>
> (Note that this was caught with participation of the
> slab_free_after_rcu_debug debugging mechanism that I introduced last
> year - which I guess means there is also a chance that this is a bug
> in the debugging mechanism. I don't think so, but I figured I should
> at least mention the possibility...)
>
> There was another bug report similar to this one a few days earlier,
> see <https://lore.kernel.org/all/67a76f33.050a0220.3d72c.0028.GAE@google.com/>.
>
> Syzkaller hasn't found any reproducer for this yet, likely because you
> only get a KASAN crash if the shrinker / compaction / ... happens to
> run at exactly the right time. Do any of you have a good idea of what
> bug this could be, or do we need to figure out some debug assertions
> we can sprinkle in the code so that syzkaller can find a more reliable
> reproducer in the future?

Thanks, how strange. Two in one evening like this :))

and I caught one like this in vma_modify() (but then broken another like unusual
case).

rmap locking (or lack thereof...) deeply concerns me.

I'll look into this in more depth when I have time, thanks!

>
> On Tue, Feb 11, 2025 at 9:10 PM syzbot
> <syzbot+402900951482ab0a6fcb@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    bb066fe812d6 Merge tag 'pci-v6.14-fixes-2' of git://git.ke..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=170aa1b0580000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=c48f582603dcb16c
> > dashboard link: https://syzkaller.appspot.com/bug?extid=402900951482ab0a6fcb
> > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/988222f4ae63/disk-bb066fe8.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/41a93a7bd0c9/vmlinux-bb066fe8.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/99bd53f622e1/bzImage-bb066fe8.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+402900951482ab0a6fcb@syzkaller.appspotmail.com
> >
> > ==================================================================
> > BUG: KASAN: slab-use-after-free in folio_lock_anon_vma_read+0xc4e/0xd40 mm/rmap.c:559
> > Read of size 8 at addr ffff888012dd7ee0 by task syz.0.7085/4643
> >
> > CPU: 1 UID: 0 PID: 4643 Comm: syz.0.7085 Not tainted 6.14.0-rc1-syzkaller-00081-gbb066fe812d6 #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:94 [inline]
> >  dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
> >  print_address_description mm/kasan/report.c:378 [inline]
> >  print_report+0xc3/0x620 mm/kasan/report.c:489
> >  kasan_report+0xd9/0x110 mm/kasan/report.c:602
> >  folio_lock_anon_vma_read+0xc4e/0xd40 mm/rmap.c:559
> >  rmap_walk_anon_lock mm/rmap.c:2579 [inline]
> >  rmap_walk_anon+0x485/0x710 mm/rmap.c:2627
> >  rmap_walk mm/rmap.c:2724 [inline]
> >  rmap_walk mm/rmap.c:2719 [inline]
> >  folio_referenced+0x2a8/0x5c0 mm/rmap.c:1015
> >  folio_check_references mm/vmscan.c:896 [inline]
> >  shrink_folio_list+0x1dee/0x40c0 mm/vmscan.c:1234
> >  evict_folios+0x774/0x1ab0 mm/vmscan.c:4660
> >  try_to_shrink_lruvec+0x5a2/0x9a0 mm/vmscan.c:4821
> >  lru_gen_shrink_lruvec mm/vmscan.c:4970 [inline]
> >  shrink_lruvec+0x313/0x2ba0 mm/vmscan.c:5715
> >  shrink_node_memcgs mm/vmscan.c:5951 [inline]
> >  shrink_node mm/vmscan.c:5992 [inline]
> >  shrink_node+0x105c/0x3f20 mm/vmscan.c:5970
> >  shrink_zones mm/vmscan.c:6237 [inline]
> >  do_try_to_free_pages+0x35f/0x1a30 mm/vmscan.c:6299
> >  try_to_free_mem_cgroup_pages+0x31a/0x7a0 mm/vmscan.c:6631
> >  try_charge_memcg+0x356/0xaf0 mm/memcontrol.c:2255
> >  try_charge mm/memcontrol-v1.h:19 [inline]
> >  charge_memcg+0x8a/0x310 mm/memcontrol.c:4487
> >  __mem_cgroup_charge+0x2b/0x1e0 mm/memcontrol.c:4504
> >  mem_cgroup_charge include/linux/memcontrol.h:644 [inline]
> >  shmem_alloc_and_add_folio+0x50a/0xc10 mm/shmem.c:1912
> >  shmem_get_folio_gfp+0x689/0x1530 mm/shmem.c:2522
> >  shmem_get_folio mm/shmem.c:2628 [inline]
> >  shmem_write_begin+0x161/0x300 mm/shmem.c:3278
> >  generic_perform_write+0x2ba/0x920 mm/filemap.c:4189
> >  shmem_file_write_iter+0x10e/0x140 mm/shmem.c:3454
> >  __kernel_write_iter+0x318/0xa90 fs/read_write.c:612
> >  dump_emit_page fs/coredump.c:884 [inline]
> >  dump_user_range+0x389/0x8c0 fs/coredump.c:945
> >  elf_core_dump+0x2787/0x3880 fs/binfmt_elf.c:2129
> >  do_coredump+0x304f/0x45d0 fs/coredump.c:758
> >  get_signal+0x23f3/0x2610 kernel/signal.c:3021
> >  arch_do_signal_or_restart+0x90/0x7e0 arch/x86/kernel/signal.c:337
> >  exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
> >  exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
> >  irqentry_exit_to_user_mode+0x13f/0x280 kernel/entry/common.c:231
> >  asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
> > RIP: 0033:0x4021000
> > Code: Unable to access opcode bytes at 0x4020fd6.
> > RSP: 002b:000000000000000d EFLAGS: 00010206
> > RAX: 0000000000000000 RBX: 00007fc4c91a5fa0 RCX: 00007fc4c8f8cde9
> > RDX: ffffffffffffffff RSI: 0000000000000005 RDI: 0000000000008001
> > RBP: 00007fc4c900e2a0 R08: 0000000000000006 R09: 0000000000000000
> > R10: ffffffffff600000 R11: 0000000000000246 R12: 0000000000000000
> > R13: 0000000000000000 R14: 00007fc4c91a5fa0 R15: 00007ffdab469bf8
> >  </TASK>
> >
> > Allocated by task 4636:
> >  kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
> >  kasan_save_track+0x14/0x30 mm/kasan/common.c:68
> >  unpoison_slab_object mm/kasan/common.c:319 [inline]
> >  __kasan_slab_alloc+0x89/0x90 mm/kasan/common.c:345
> >  kasan_slab_alloc include/linux/kasan.h:250 [inline]
> >  slab_post_alloc_hook mm/slub.c:4115 [inline]
> >  slab_alloc_node mm/slub.c:4164 [inline]
> >  kmem_cache_alloc_noprof+0x1c8/0x3b0 mm/slub.c:4171
> >  anon_vma_alloc mm/rmap.c:94 [inline]
> >  anon_vma_fork+0xe6/0x620 mm/rmap.c:360
> >  dup_mmap kernel/fork.c:711 [inline]
> >  dup_mm kernel/fork.c:1700 [inline]
> >  copy_mm+0x1b7b/0x2730 kernel/fork.c:1752
> >  copy_process+0x3e6d/0x6f20 kernel/fork.c:2403
> >  kernel_clone+0xfd/0x960 kernel/fork.c:2815
> >  __do_sys_clone+0xba/0x100 kernel/fork.c:2958
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > Freed by task 4644:
> >  kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
> >  kasan_save_track+0x14/0x30 mm/kasan/common.c:68
> >  kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:576
> >  poison_slab_object mm/kasan/common.c:247 [inline]
> >  __kasan_slab_free+0x51/0x70 mm/kasan/common.c:264
> >  kasan_slab_free include/linux/kasan.h:233 [inline]
> >  slab_free_hook mm/slub.c:2353 [inline]
> >  slab_free_after_rcu_debug+0x115/0x340 mm/slub.c:4659
> >  rcu_do_batch kernel/rcu/tree.c:2546 [inline]
> >  rcu_core+0x79d/0x14d0 kernel/rcu/tree.c:2802
> >  handle_softirqs+0x213/0x8f0 kernel/softirq.c:561
> >  __do_softirq kernel/softirq.c:595 [inline]
> >  invoke_softirq kernel/softirq.c:435 [inline]
> >  __irq_exit_rcu+0x109/0x170 kernel/softirq.c:662
> >  irq_exit_rcu+0x9/0x30 kernel/softirq.c:678
> >  instr_sysvec_call_function_single arch/x86/kernel/smp.c:266 [inline]
> >  sysvec_call_function_single+0xa4/0xc0 arch/x86/kernel/smp.c:266
> >  asm_sysvec_call_function_single+0x1a/0x20 arch/x86/include/asm/idtentry.h:709
> >
> > Last potentially related work creation:
> >  kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
> >  kasan_record_aux_stack+0xb8/0xd0 mm/kasan/generic.c:548
> >  slab_free_hook mm/slub.c:2314 [inline]
> >  slab_free mm/slub.c:4609 [inline]
> >  kmem_cache_free+0x166/0x4d0 mm/slub.c:4711
> >  anon_vma_free mm/rmap.c:137 [inline]
> >  __put_anon_vma+0x114/0x3a0 mm/rmap.c:2568
> >  put_anon_vma include/linux/rmap.h:116 [inline]
> >  unlink_anon_vmas+0x58a/0x820 mm/rmap.c:444
> >  free_pgtables+0x33c/0x950 mm/memory.c:408
> >  exit_mmap+0x406/0xba0 mm/mmap.c:1295
> >  __mmput+0x12a/0x410 kernel/fork.c:1356
> >  mmput+0x62/0x70 kernel/fork.c:1378
> >  exec_mmap fs/exec.c:1011 [inline]
> >  begin_new_exec+0x152b/0x3800 fs/exec.c:1267
> >  load_elf_binary+0x85c/0x4ff0 fs/binfmt_elf.c:1002
> >  search_binary_handler fs/exec.c:1775 [inline]
> >  exec_binprm fs/exec.c:1807 [inline]
> >  bprm_execve fs/exec.c:1859 [inline]
> >  bprm_execve+0x8dd/0x16d0 fs/exec.c:1835
> >  do_execveat_common.isra.0+0x4a2/0x610 fs/exec.c:1966
> >  do_execve fs/exec.c:2040 [inline]
> >  __do_sys_execve fs/exec.c:2116 [inline]
> >  __se_sys_execve fs/exec.c:2111 [inline]
> >  __x64_sys_execve+0x8c/0xb0 fs/exec.c:2111
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > The buggy address belongs to the object at ffff888012dd7ee0
> >  which belongs to the cache anon_vma of size 208
> > The buggy address is located 0 bytes inside of
> >  freed 208-byte region [ffff888012dd7ee0, ffff888012dd7fb0)
> >
> > The buggy address belongs to the physical page:
> > page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff888012dd7440 pfn:0x12dd7
> > memcg:ffff88802647a401
> > flags: 0xfff00000000200(workingset|node=0|zone=1|lastcpupid=0x7ff)
> > page_type: f5(slab)
> > raw: 00fff00000000200 ffff88801c282140 ffff88801b0937c8 ffffea0000c9a210
> > raw: ffff888012dd7440 00000000000f000e 00000000f5000000 ffff88802647a401
> > page dumped because: kasan: bad access detected
> > page_owner tracks the page as allocated
> > page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 5503, tgid 5503 (dhcpcd), ts 67849640029, free_ts 55595562609
> >  set_page_owner include/linux/page_owner.h:32 [inline]
> >  post_alloc_hook+0x181/0x1b0 mm/page_alloc.c:1551
> >  prep_new_page mm/page_alloc.c:1559 [inline]
> >  get_page_from_freelist+0xfce/0x2f80 mm/page_alloc.c:3477
> >  __alloc_frozen_pages_noprof+0x221/0x2470 mm/page_alloc.c:4739
> >  alloc_pages_mpol+0x1fc/0x540 mm/mempolicy.c:2270
> >  alloc_slab_page mm/slub.c:2423 [inline]
> >  allocate_slab mm/slub.c:2587 [inline]
> >  new_slab+0x23d/0x330 mm/slub.c:2640
> >  ___slab_alloc+0xbfa/0x1600 mm/slub.c:3826
> >  __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3916
> >  __slab_alloc_node mm/slub.c:3991 [inline]
> >  slab_alloc_node mm/slub.c:4152 [inline]
> >  kmem_cache_alloc_noprof+0xeb/0x3b0 mm/slub.c:4171
> >  anon_vma_alloc mm/rmap.c:94 [inline]
> >  anon_vma_fork+0xe6/0x620 mm/rmap.c:360
> >  dup_mmap kernel/fork.c:711 [inline]
> >  dup_mm kernel/fork.c:1700 [inline]
> >  copy_mm+0x1b7b/0x2730 kernel/fork.c:1752
> >  copy_process+0x3e6d/0x6f20 kernel/fork.c:2403
> >  kernel_clone+0xfd/0x960 kernel/fork.c:2815
> >  __do_sys_clone+0xba/0x100 kernel/fork.c:2958
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > page last free pid 5502 tgid 5502 stack trace:
> >  reset_page_owner include/linux/page_owner.h:25 [inline]
> >  free_pages_prepare mm/page_alloc.c:1127 [inline]
> >  free_frozen_pages+0x6db/0xfb0 mm/page_alloc.c:2660
> >  __put_partials+0x14c/0x170 mm/slub.c:3153
> >  qlink_free mm/kasan/quarantine.c:163 [inline]
> >  qlist_free_all+0x4e/0x120 mm/kasan/quarantine.c:179
> >  kasan_quarantine_reduce+0x195/0x1e0 mm/kasan/quarantine.c:286
> >  __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:329
> >  kasan_slab_alloc include/linux/kasan.h:250 [inline]
> >  slab_post_alloc_hook mm/slub.c:4115 [inline]
> >  slab_alloc_node mm/slub.c:4164 [inline]
> >  kmem_cache_alloc_node_noprof+0x1ca/0x3b0 mm/slub.c:4216
> >  __alloc_skb+0x2b3/0x380 net/core/skbuff.c:668
> >  alloc_skb include/linux/skbuff.h:1331 [inline]
> >  netlink_alloc_large_skb+0x69/0x130 net/netlink/af_netlink.c:1196
> >  netlink_sendmsg+0x689/0xd70 net/netlink/af_netlink.c:1867
> >  sock_sendmsg_nosec net/socket.c:713 [inline]
> >  __sock_sendmsg net/socket.c:728 [inline]
> >  ____sys_sendmsg+0x9ae/0xb40 net/socket.c:2568
> >  ___sys_sendmsg+0x135/0x1e0 net/socket.c:2622
> >  __sys_sendmsg+0x16e/0x220 net/socket.c:2654
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > Memory state around the buggy address:
> >  ffff888012dd7d80: 00 00 fc fc fc fc fc fc fc fc fa fb fb fb fb fb
> >  ffff888012dd7e00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > >ffff888012dd7e80: fb fb fb fb fc fc fc fc fc fc fc fc fa fb fb fb
> >                                                        ^
> >  ffff888012dd7f00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >  ffff888012dd7f80: fb fb fb fb fb fb fc fc fc fc fc fc fc fc fc fc
> > ==================================================================
> >
> >
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> >
> > If the report is already addressed, let syzbot know by replying with:
> > #syz fix: exact-commit-title
> >
> > If you want to overwrite report's subsystems, reply with:
> > #syz set subsystems: new-subsystem
> > (See the list of subsystem names on the web dashboard)
> >
> > If the report is a duplicate of another one, reply with:
> > #syz dup: exact-subject-of-another-report
> >
> > If you want to undo deduplication, reply with:
> > #syz undup
> >

