Return-Path: <linux-kernel+bounces-514924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A59A35D66
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 13:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA63F16A5D9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 12:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1590263F23;
	Fri, 14 Feb 2025 12:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="om6QSdws";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EMJom52N"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B954F204F6E;
	Fri, 14 Feb 2025 12:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739535679; cv=fail; b=SdeJ75kQDwqvGmwMjfKXoGrenTx4gxFmH2MJC7INRSlsnS43llu2WZ+eKf8aq1RM/7Y7CinRqsECAs9p3GU7NN0BIXCVbb4ccuB8AfM2zkd5fkMCiNyd9D/4Whb4uEEmqy6WtqOQNK0i4NSON2xTf83B3SGy8r21NvLhwwoiYxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739535679; c=relaxed/simple;
	bh=s6PfXpyfwIotrBHwI9cr2d2E5D/TkuFE56DG5zUQx6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LFVHUvNotivlAiymdu3EqGqOcv/8RL6W2iumiAUkCKJWTjxX/8zktWKbhItP1KZYnVxfMyifUByr6jxjiQoKMx0Rut8YQuzLhZyDN5ZEcA06i7kZioo/MvmQFzNuAN8uJYR4ds3ghKdTFZnZxdU3+3IW+1SLOhLBP9j8xWl5KeQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=om6QSdws; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EMJom52N; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51EBfecd018951;
	Fri, 14 Feb 2025 12:20:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=tbxyI5eBkfvMGRvqwFwKU69dXw26sEelJx7WIE5eBps=; b=
	om6QSdwskiQhMtzIcHEcMUVb6iJVEoDsptoKOZOgCk+ID7b4knmnh8o7JJln4lTj
	Guhak303p5G+Kebw6ulEn/n0VfdOiFUpgQXXhCcIMtfIs6UoF7V/XK7deKa4x1I7
	M2bx+eO3YILHjDlrwlexd4SlUR1KjoNol9NhPrWd2hRFh4H7/y190eL24U7T6sFv
	PtOIwjnyPw4ZwVXjwptcTZZoKUGeEzDiuhTrzpOgUgwyc6Ygca/GkGxSeUCxN8lh
	euGzMu2MpXmhzT2e2lbalzTbE/2VBpHLdb6OGpk0SBlD1aLZbe+KBFsQZAnJaZGE
	wabPV//zgQxjxnHt8tLOgQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0q2kkc1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Feb 2025 12:20:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51EBwmGr012300;
	Fri, 14 Feb 2025 12:20:28 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2042.outbound.protection.outlook.com [104.47.70.42])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44nwqd3gvx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Feb 2025 12:20:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bgQz9mBndXT/uHmXfez4YAZWOCkqyYJYuma1fnwAoL4rB4jAWDiYVJ6w0SEHk4DEiUGqZjirolfgEFlfQrJacqO8vh0EcdgT/MycYZ+Sn46x+BgVK+ANvutYpS3LhIvPUWMDHQBYkgtPFRtVvc8iHHlqESTUV1QmvjjXNxTRjC/jLsoayKz8y66pw7Iomnttz2BYkPgKfXYdN4rsMQ3W0rzouMlyr5cftsQNemQt3aY8CX5QZVAHV12KIN6YDdpqsBjpERAnfttGT/q4JVZ6+tZkbdz2/wlfYdjK1f1/9U7f5+WIwqg9mvKsHPbVcrU4l/T1RsyLG3Anb2+SQSv6iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tbxyI5eBkfvMGRvqwFwKU69dXw26sEelJx7WIE5eBps=;
 b=yUl+6lu+UE/WrK8Xe94sMzxlZkusjIzaFRW2wJtFYQDDDnXl8u0AW6f+Aj7/etVWfTh9X5o+AXnNGGtUjWnWHdGEYUi+MlH8t4zakdhJXLq4C51E7Hd5XD1iEx5OwMQpYc8rx5Xrs62ULgzBcHzEMRYNTBiGV2Yv2Ubb6ynx4C91u+tvES8FOKsQceKq838xOE124PCxi87mPip6uvptpwUO2zbydyzXwPiQ29In3iMWaEZbjUVsALN9Pk27BXiNXWDPb6iIPb7TrVAz2SFNdzityB/+euhl6bEuRalEUBs2IK2nqiiTryy3YwUqZcAgrvl6xMpl0RD4TNSucKaFvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tbxyI5eBkfvMGRvqwFwKU69dXw26sEelJx7WIE5eBps=;
 b=EMJom52NzQ6SZx0PkqlSS06w2CVIOI3tN0SYWwTpRWp0z/b/z8n1hOmrh56HfqTcBvaJzXZhWQ+jBTsWO/Yq48FEiKWurJ0bjzsbuWbyptgwTrzP0vk8xqh/cuKqJp5rjwMA8UYvqsIXqxkPAAkCXXDGKpP/XdYj3ZhT3zT2rqc=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by DM6PR10MB4332.namprd10.prod.outlook.com (2603:10b6:5:220::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.17; Fri, 14 Feb
 2025 12:20:24 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%4]) with mapi id 15.20.8398.025; Fri, 14 Feb 2025
 12:20:23 +0000
Date: Fri, 14 Feb 2025 12:20:18 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@kernel.org>,
        Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, rust-for-linux@vger.kernel.org,
        Balbir Singh <balbirs@nvidia.com>
Subject: Re: [PATCH v14 0/8] Rust support for mm_struct, vm_area_struct, and
 mmap
Message-ID: <30ffd737-d0aa-44aa-a647-686e536ac548@lucifer.local>
References: <20250213-vma-v14-0-b29c47ab21f5@google.com>
 <8130a6d5-a7e5-402b-b05c-2d0703ac1ed2@lucifer.local>
 <CANiq72nBx3cRTUC9HWVR8K64Jbq3GCVMss5wuABzra3OLhRUQw@mail.gmail.com>
 <c8e78762-1429-4ab6-9398-ce52370eec08@lucifer.local>
 <CANiq72mKyvoyk_tgbMKUdzs-sJOoyEH7f1M9ipiET+XYgwCqRw@mail.gmail.com>
 <2d132129-fdf7-404d-b1f1-8ee87b838dcf@lucifer.local>
 <b6b5tnaw6vnuib7nzcm7ajszxiptqz3i2hex5yengzbsirztks@l3coijkqwtpb>
 <CAH5fLgjMC2Q1tjuVtbhMvU-pmEsn1Ai4=AAB3Tm8HTWi7PFHfg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgjMC2Q1tjuVtbhMvU-pmEsn1Ai4=AAB3Tm8HTWi7PFHfg@mail.gmail.com>
X-ClientProxiedBy: LO4P265CA0081.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::9) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|DM6PR10MB4332:EE_
X-MS-Office365-Filtering-Correlation-Id: cc3099e4-073d-4f04-3e82-08dd4cf1f4e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SGo4QnhTQTV2clk4Wlh5ZXZTYVk2L3FtbXFZTXl0UWxPd1N4T2ZIZUpQMUx0?=
 =?utf-8?B?ZWE4NUMrZDdjRnVTZmlscTFNVGovc3JzaWNtZXZHdVNEMmxGZklReTYyYzVX?=
 =?utf-8?B?cTdYQUNCNDd6MmNVckRaSXhLM3dTb0wwYmhRS21LK0plNWpGNitmT0hqNjhz?=
 =?utf-8?B?MDAza0NKdTJpenVnWUgxZ291bG1tTWVueWJ5YkY5YVpDaTdiU05KVGFiL0xQ?=
 =?utf-8?B?N0dJV0wzbUVqM3QwTU9mRHlMeHJVYko5SDFlbjc1eTloVTlmeFVnSFU0L1N2?=
 =?utf-8?B?ZG1YTW51SE05M2h0UjdMRGRxM1FvdkhMY2ZsSThkTlU0ZUtyTVpsUUo5ZWdp?=
 =?utf-8?B?QVAzMzBUNU1aOWtNTm9rT0V5eFk2bHVCYVY4ZkRQaHU4SS80SC96Z1h4ZHdF?=
 =?utf-8?B?aVdFbGFBeEZ1YXRzeTZFcGtFdjloZ3paQkhWMG1NZGxhcDFTS29tZXRnbEFU?=
 =?utf-8?B?Sk41OUNNRXJweVlxT0hPYWE4cWR2QUVUT3JFRUtTL2hzUElrUlFiODBoR2Rh?=
 =?utf-8?B?WXdVNy9BZC9mS2Y1YmpWYy9KV2o2VVQzTndXZ1VKMmUyQzNzempPOTB2R2Iv?=
 =?utf-8?B?OVMyWGJGTVorS25mSzR3MTRtUVBSeDMrUWppQkhwV1NNY0thRmUrVkhSUmpp?=
 =?utf-8?B?eExJczJnZDlOdDk3cHF6aEpsdzlpSEl2enhNR1Yxd085ckphR09KaC9ldUZX?=
 =?utf-8?B?Ui9zY0ZiSkNSc0VHOUNRL2JkV2ptclRPcCtXN09oN24zQ2NIQStoVXlGN2ww?=
 =?utf-8?B?elIyNEoycmxtWTNSTEhIbitFTUNMZHYwMU9tS2lVUC9Cb3o3SWlQbCs1aC9q?=
 =?utf-8?B?OE1yL3Q3YTBQbXRLT1JBbFp3SEtFREx1cXNTVUR4dVdqYXBQbmR0Z0w0c3Bv?=
 =?utf-8?B?MlVOd0MzbGRwa1czYnI3dUpSV2pUODNocVpyNnIrN1huQTBBT2lSQ3VBN01q?=
 =?utf-8?B?T3JhSllJTzFoT1dYWnhrVk1ZNk1KQ0ZWTm45RjdiSGsrZ0x3N29jMlpXaXpR?=
 =?utf-8?B?N0w4YTJsMUxLaFBCeGU1S3dPUHNIV01jZ3o1U3g1ZXN0MER1M09HeFdqaFFX?=
 =?utf-8?B?UTdKWWhoVXBMNStCZXN1TVltWkFzN05OYlppTm5wdnZ6THFWQVJGVTU0Z0lR?=
 =?utf-8?B?RUZzeU9sWDhRb01NMXhwdFpmTCtSU2JUV1VMU1B0TWJvSk5JNjYzS01LOS9u?=
 =?utf-8?B?eHZTL1BOK2tjTXFWa0VrSmxkVFJ4cVp0d1BYTUM0UHJyUUc5MldLZTkvWDdt?=
 =?utf-8?B?RlhTMDFlK1FUeSsvWVVHUjM0Ump4aHFYdDQwa3BmZ3VxWjNaTnRNOS9BVkly?=
 =?utf-8?B?WnVrd1hsTk1HRVZUcERlK2pCeGE2VXo3emU1aW5uOFVqSXdkN0FMU0d6SW5W?=
 =?utf-8?B?WWNnM1ZRNXpaUHd4NFNhRWV3eC9oV2dmdU9wbUY5R2tncXNHS3F6eTg3Mkw5?=
 =?utf-8?B?eVlKOEU4UmRXRWVzNW1TL1MxT05ib0VzK1plNXJwWWVsVzNSVnplVTdFMDB3?=
 =?utf-8?B?YmljTmFLYmVORkFPc3FVenVEa1pwVWQ2aGVhS2Rpc0pkeUlYaW50UU5oS1Zr?=
 =?utf-8?B?cmJZNHBSa05LK0VYYXh3K3dESENxOFFxZFFIeStXbHhvSnR0NXlvNEhyVFhq?=
 =?utf-8?B?U2N2KzkwUHh5TkhoOUhSY1pmR0dwVHdwdzZ2c1l4MzY5THlLV3N3UWI3U0oy?=
 =?utf-8?B?NUIvNmx1emQzWTRNczBSOVhFRExlSzZQbVlScDlGQkNlVGU0OEFZMFViWVJF?=
 =?utf-8?Q?kGg0hs4YEAz9ftASWDswCUtJIzNH4dJ7HDxjTPD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WWwrY3FDUW9VQUxUclFjeDBjM3NUM1huWGU0N2ZVbnNOdWJEQ08vTG15UG8x?=
 =?utf-8?B?L1FubVRWaXdNQ0wxcVBaOHdvaTl3YTNNdHFUTjZlb2NRbFg4TDA3Wlo1dE93?=
 =?utf-8?B?MXdWTVFHQTRzMjgrWWt3OG9McktwVlBETzV1VWQrNVhITWhBNm5Lb3dzYzhk?=
 =?utf-8?B?clpKb1c0YUJXbSt4SVRvamhNNXdRaE1UeVE1WkVhT2QycWdDRWVjM2R0dlAy?=
 =?utf-8?B?QnB6NUVhdGlicXVHK0dKY1lNejA5NFAyZ0RYSmxIUStZSVltZ0s3V29SNmZT?=
 =?utf-8?B?TmRoMThrMDhldHpLWU15Nm0rY1AxS3dwTUE1SjNHYjd2dy9qSHYzNi8raWpD?=
 =?utf-8?B?RmRxdlVpY1F2ajN5TDFiSUdYU0IvanBCYzFpOWFnZzNkR1Z1SG1HV2E2ck9Z?=
 =?utf-8?B?dUt6Sy9sVkJSdkVUbXlDZ2RHOE9ONlRlcXl2MGs5bmRGSmxuWlF6WE9jcVF4?=
 =?utf-8?B?UmlhRGU0TEtRUUFQZVJtTTAxaDM2YjlNWUMrcGhEMVRoelhxcE04YW5aWFRQ?=
 =?utf-8?B?ZTB6NTVEWDNhZ0Z3YVh1bVJ5TnNucTFha216SHFVUGtaZENja2Yzc1ZSbFYz?=
 =?utf-8?B?NkJlT3FuT3NlZmk4eVRnTUltZzFqTGZoZG8zcWtPWnhocFFlUnpFZFZTRmFR?=
 =?utf-8?B?cEFKVmZhSVo3d2JGckdNeFRBdGFiUlFQSGpiLzVsTGJaOHMxd1VRR0lMWUht?=
 =?utf-8?B?WmJ6QUZ4Umd1bDNnb1o4Z0M1R255ckVMd3k4N0tuRzlubnh0S0xBbjlnY2E3?=
 =?utf-8?B?YzQ5NHlYKzNqeHNXN3BsV29Kblk4OS96eFNDUDdiSGRvVzNSYVZqSnhyaG94?=
 =?utf-8?B?L3U2clRndU5yVERPd0NJVmJyRkI0Z3pZaFBiNzdLcDhVbXlHd1RXaEFmd1h2?=
 =?utf-8?B?K2NPcEphaVRJZjBqTkM4VWgzWmZobEhQMGZ3bk1KSDZtZk1YalZqbnUzV2dz?=
 =?utf-8?B?ZFZidjNTUXdjL1JSamdyRmtXRUp4ZGRvZXJWZmlSeCtPME43aVU4OUxaNWwy?=
 =?utf-8?B?ek5YK2c5dHN4TWxkTlFwRGtzL2psRzlKbmJhUEhKK3MxcUZSWTRNTjkybkJx?=
 =?utf-8?B?aHZQVk0wSmV4UWh4RUxMYlozZmwvZ25Sb2FyTHEvMG5RNENNbGFrVUpJK2RS?=
 =?utf-8?B?bzFPSTlYZU9SSnBLT0QzTWc2Z2Q0Nzc4WVkwcUd2Z3FCRC9sWEw1SVlEdUpM?=
 =?utf-8?B?WnltVGxWTzQ5Z2N2cDFNV3dHU2I4cWxwWEFwb2IvL0g1OTd4eG0za2htdkRY?=
 =?utf-8?B?Zmpjck5lU2xwY081MUtNSVpEV3RNZmlkQ1hiOUNQaFJyaVNWSGNSR0t0UXFH?=
 =?utf-8?B?T1RPVTByQm1MU0o1Y3QyUmRXRXB4SHhuU1grZ3liM0dYOE1JZ3BJWHorelFF?=
 =?utf-8?B?Vm9paTJCRGJQSUJwMS8xaG9TUFUxaEFpVDlsTlVsUTUyTlNJOTVVd2lnMjNS?=
 =?utf-8?B?RnhMVkNZVVhCeE9JQ0dFbW0vcm9oSktLeGNLL3NIRnk5Zm9tbzZGZm0yUkp0?=
 =?utf-8?B?NUlFSEplV1JKNmlwaTRxV21Tb2FOdmVOZ1J6UkQwUXYzaUxDOXFrWjJuU2Z6?=
 =?utf-8?B?dDRlQ25rY3VDQTVjRThuRE43TzRGa2pNTjdnSHZXYlFCb01ZSUFJUmJCYmhL?=
 =?utf-8?B?Z256REJnbGZNN0o2NEdkdE9tR0RxcXlZZEMzSkQydDM0dU1FMkJ6Rm1YWk9t?=
 =?utf-8?B?dVB3QWNJU2xPa3hnVEtrZ05EVlhBS081Wmgza3BZNHM2VVZ5eEJqQ2V1ZXBZ?=
 =?utf-8?B?NVh3cHhVa0xxQUVCN3ZBWWFjM0RuNmZ1MWtOVUJNeDZlcUlRY2ZjR1pIcSt4?=
 =?utf-8?B?SHNYU1g5enJBWGJ5WE1KQzRtMzd5cFdxSy9ka1AvbnFuWFpKVVFGdGlWaFdx?=
 =?utf-8?B?Q0l0bWEvdUZncjc4QnRqZncxZUQxYmFndlBHUTNZL1c3TEtpNGR2dzdNNkNW?=
 =?utf-8?B?TWU4ZnRoUkdnR1pTcXZZQ29lR2lvVUFPcFBPdWEyVGJTT05wWTNpd01aTWkr?=
 =?utf-8?B?U1FpbXZjU2g1YXc3UzVYMHQ2NWJSanpMN1dsQ3ZzSUdYWUZGQzJjNmhxbDV5?=
 =?utf-8?B?MzVLNkUwQXNSR3ZDZnE4bWFTT1ppNEF2ajhsRldSaHJyYXRYb0tTbTlLVktw?=
 =?utf-8?B?S1RaUTBlYjRLdjVJV2w4dkJvaitWS1BXU1VnQUJxdU80RnNWME9zVWZPNVJY?=
 =?utf-8?B?MWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lAtqTt7Nro4I5IX+c4Q2G+4MkrDchKmzuHmsL63KPYKmVNgd/ZW9nqjtQU0HlcO5UyM7eybaI45UbSYt6IN87PPVAUppkPeoYv1eceknnsf+u1SX9ggy+9gAz9L14OmBcPl/XIq1L5U7pEDAKbKM5BbDeWLamVNdqM7ImTb7dFNElZY+srdFLkRs0O/35SEVAv7EGn7myoBzhKypJ2E8XKrUzlPLIXAH2mL4+YnavRp5pUAvWU15h2qzEVNOh6qO43J7FgOr3WoHBmVd+HPrKZl5Yy7XNTSqitMEoj0XyGMcCfz3zPXAtWS07IpjZUfG/s/GU9stTCYw36lljSYAcf8yyR6ijRJ5w6EA/iNUrSKpBcocTffzTtds+HvUYSAyl4LOdZVJE4ZjoKY1NlyWARNG3qIYoiEhoxqXABFlutkcu2+CkZnaknuPalPUp2HMF7B1sQGgwwMHe8v4+BbEn7HF0KiJrsXWStK/5zwpziv2NdAdPU4/x+R/CTu+bAxnMdIvVNkiaS7PVAJlr4TLLunbywtNWMnyU5btlE97v6BEzuFePyXwwql/RuybeobgYc84ZWtWv0BZ2pEIotOPzGPPhnvgvsZrXtgGo5snJsc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc3099e4-073d-4f04-3e82-08dd4cf1f4e6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 12:20:23.8975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aqMnPB9jkeEdR4lX9oIvR687abBwjQfJcEbw4xTt9LfcWMZpXeA0ZcI7aUagAfMaG6FafJTj1C/31a/mEfBDeRAaTWeFKmIDPDarx9nUNUk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4332
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_05,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502140090
X-Proofpoint-GUID: NUeFfqY2t854J-2g-X4Lip8p03gZg7x0
X-Proofpoint-ORIG-GUID: NUeFfqY2t854J-2g-X4Lip8p03gZg7x0

On Fri, Feb 14, 2025 at 12:56:29PM +0100, Alice Ryhl wrote:
> On Thu, Feb 13, 2025 at 8:46 PM Liam R. Howlett <Liam.Howlett@oracle.com> wrote:
> >
> > * Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250213 07:16]:
> > > On Thu, Feb 13, 2025 at 01:03:04PM +0100, Miguel Ojeda wrote:
> > > > On Thu, Feb 13, 2025 at 12:50 PM Lorenzo Stoakes
> > > > <lorenzo.stoakes@oracle.com> wrote:
> > > > >
> > > > > Right, I don't mean the rust subsystem, I mean designated rust
> > > > > maintainers. The point being that this won't add workload to Andrew, nor
> > > > > require him nor other mm C people to understand rust.
> > > >
> > > > Sounds good, and apologies for being pedantic, but given the recent
> > > > discussions, I thought I should clarify just in case others read it
> > > > differently.
> > > >
> > > > In the same vein, one more quick thing (that you probably didn't mean
> > > > in this way, but still, I think it is better I add the note, sorry): I
> > > > don't think it is true that it will not add workload to Andrew or MM
> > > > in general. It always adds some workload, even if the maintainers
> > > > don't handle the patches at all, since they may still need to perform
> > > > a small change in something Rust related due to another change they
> > > > need to do, or perhaps at least contact the Rust sub-maintainer to do
> > > > it for them, etc.
> > > >
> > > >     https://rust-for-linux.com/rust-kernel-policy#didnt-you-promise-rust-wouldnt-be-extra-work-for-maintainers
> > > >
> > > > Cheers,
> > > > Miguel
> > >
> > > Ack, for the record I'm happy to help with any work that might come up.
> >
> > Ack, here too.
> >
> > Without the drama, I'm not sure how we'd feel so alive :P
> >
> > Can I be added to whatever list so I can be Cc'ed on the changes on your
> > side?
>
> I'm happy to format the entries whichever way you all prefer, but for
> example it could be a new MAINTAINERS entry below MEMORY MAPPING along
> these lines:
>
> MEMORY MANAGEMENT/MAPPING [RUST]

I think a general:

MEMORY MANAGEMENT [RUST]

works better here as it ought to (at least for the time being) cover off all
rust mm stuff.

> M: Alice Ryhl <aliceryhl@google.com>

I wonder if we should have Andrew as a co-maintainer here so people also
send to Andrew also for merge? (and obviously as the mm maintainer he may
have commentary).

> R: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Am happy to be a reviewer this is fine!

> R: Liam R. Howlett <Liam.Howlett@oracle.com>

I am sure Liam is also, but of course he can comment himself :)

> L: linux-mm@kvack.org
> L: rust-for-linux@vger.kernel.org
> S: Maintained

Probably need these here too if Andrew is taking in his tree:

W:	http://www.linux-mm.org
T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

> F: rust/helpers/mm.c
> F: rust/kernel/mm.rs
> F: rust/kernel/mm/
>
> Alice

But in general with tweaks I am happy for this to be added to MAINTAINERS
_personally_, am I but a minor figure however, it is up to Andrew
ultimately :)

