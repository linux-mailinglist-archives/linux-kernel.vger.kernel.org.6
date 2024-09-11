Return-Path: <linux-kernel+bounces-325736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5646B975D91
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 01:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8C7E285826
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 23:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61C1184539;
	Wed, 11 Sep 2024 23:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DNpeJrm0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xkRFVL/N"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978414F8BB;
	Wed, 11 Sep 2024 23:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726095924; cv=fail; b=SRgQTExafmvhoXPUjBwb4K5sWTEeWwiXWVYMjYaFQ+gbwM9WC+UO6vIfr512QS/HnkctdM7gTrPoW6xdhEl75EPfNmfayja8KBlgYQZ/+6M5JD0R0bUN4dZ0QkHAd1t3vglF/20lPUCHd0Wq2zeY/r2GTn5zgP89Bw0vGALzUKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726095924; c=relaxed/simple;
	bh=lse1RD/eRExIaOOyio7CX+amlyOIf7R3VWgyh85y5o4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tcBgGCnZYOjc8pPbY41Q6z2GOluo/ZKxHVb63Uf1oZC1qZwjbhKwm+ZcNNqh4xih+ywjr6N3akyMxn3EKINt8tSyAymIrYYw5WDQb7+fpr2rb8NWOZb65FZOENMyjxQ+DLwP7nnpmmqK0RmH6e/jofqeFEErZTWo+8GNmxGFHfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DNpeJrm0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xkRFVL/N; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48BMfXAq007814;
	Wed, 11 Sep 2024 23:05:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=azs+KLCPvW9STGvmgwCFYR7jXL8zJhYnQ4bEtq0YVcE=; b=
	DNpeJrm0zhLy2j4cbQ7Uu3vgcQyl1zEKkyIiDpgRW29jwQ6B/KrqxGXZE7jlyCrT
	We1Bsdcd4tIRyPRCjwqL19Ify0XhnLXKwDziVagEb5QIQhUJB+saDLC+oL+KkxOA
	6FS3vZGd5Mz8glb18GOj10UOdqMuoqZSxPGctHpb5wRFbR3ZphqkqObkHnz3IybB
	qJqu4gQR6dUuITtCeJaFs1UNASfwNGfeo3Q6GRd9yS/DkawTMT75QwOLnRrXireU
	iHHr1FBs0+XELTk3pWryCNdt6hpnmy9A9QfjwKeiu/zA0FWOTGp2kBuuzrB3R944
	B4GrNDrP42BTrQKXK45Adw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gevcsedk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Sep 2024 23:05:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48BMXTCD031639;
	Wed, 11 Sep 2024 23:05:11 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41gd9b2js1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Sep 2024 23:05:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jzEwqHOvtUSQSufzU5sC8060eacNv7yH/Ww/E3XQvKixiTv+Ww98uQvckCr+hI4qAf2FQGe55ljv4EGoq5FFT9WSDlaPgk94SOB3gvC4+omYHZ+RDFGZRcD3YUStLA89ENPLGL7zmtcr04xJ/4WoVLv+M5xD1fEWUW01ay2qhzJ4rxYEwNagkM2D+IDYu0kD3ze1MjIh+SrDfeWrDE841cCxHBKeMrpMMbnKhnUjhH+OrbIFE72swf+DgLAVxsylXufAhtOfohH3/UuqdmA5bRp3ZcwMEjF8iN4w3VnfAqY4F++SIdDrSH6zwvnaoX2stqglVGeRbuNVAqci/MP4qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=azs+KLCPvW9STGvmgwCFYR7jXL8zJhYnQ4bEtq0YVcE=;
 b=qwlJr8lp6p8Pp2RNHEWyyT4LHqzT5tRa+Pde1tqVriGpvYXeTXyJh37B9xlJ1FDUk4/Yhih9MqgmjmqmlSFUdQJTWk+fz9tBSp0Prj7G7NXsgI7y906uS8hS2bKIekJwxPX8+bmCMTmj2YXFUcb3IOxJe01Hc2aYHQJEXH5sd/bjFQ+PT1GCLVrst41EGDHjTzbPEB8Gld323CPQ3SMxnttqn5FoWXDq3Bb+SiGtdyGcvrYqZLciLTSyziVbnc3j7uUqY+Zt3VrxBLpGs7an72QQWqat0F84qnXTcEICBd9VWuI4iBxIf5PbCCSkxLnh+2gsh/z2Uf2+cGlFaJ1xKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=azs+KLCPvW9STGvmgwCFYR7jXL8zJhYnQ4bEtq0YVcE=;
 b=xkRFVL/NRrWjhrrU9RilaKGuNYN4Are0CU+nhStoGaIqqxLB8KcKb2UP9eyDzeVSSvqH6rlQfXGmJB75jlfwe+RNHtHsiGEHlSM0lbDto0GSmnmM2dvdV3k4C9Jc2gmjH/bXceJ+WNubsek9I3c7sh/GqHIWDhJ/DDuuhey4t5o=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CO1PR10MB4483.namprd10.prod.outlook.com (2603:10b6:303:98::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Wed, 11 Sep
 2024 23:05:08 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7918.024; Wed, 11 Sep 2024
 23:05:08 +0000
Date: Wed, 11 Sep 2024 19:05:06 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Yang Shi <shy828301@gmail.com>
Cc: Helge Deller <deller@kernel.org>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-parisc@vger.kernel.org
Subject: Re: [PATCH] [RFC] mm: mmap: Allow mmap(MAP_STACK) to map growable
 stack
Message-ID: <tvllphck5fky6zqhkpcomjj5zuncgligdqapwkv5qwqamtjfc7@3geizoueze4d>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Yang Shi <shy828301@gmail.com>, Helge Deller <deller@kernel.org>, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-parisc@vger.kernel.org
References: <ZuHtb43Ar21ZptNz@p100>
 <focr7orndhsr7vhownfdhrpctwztloz54bfbg2wnd4xmqtcymu@26pn5wteugl6>
 <CAHbLzkqhc2yT=rh6ZkjaRJ8RF_NrZM6bXd-nau6jJjbow8vogw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAHbLzkqhc2yT=rh6ZkjaRJ8RF_NrZM6bXd-nau6jJjbow8vogw@mail.gmail.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT1PR01CA0048.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::17) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CO1PR10MB4483:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c264225-b172-4a8b-bcd1-08dcd2b62e15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZWZpZk1BYnhWZlZEcHdZRFYvMU5SZXhUaFZxdGZXT3FSd0tRc0Y0bkh4TEts?=
 =?utf-8?B?a3ZTKzIyTTNRU2JheVFVMFRIUklsSEk5L0RTREZsZU9rcGxZL3owa2RoaGZi?=
 =?utf-8?B?TFlhRnFINFFXNlFSdFE5eDF2MEE2b1djUDFZRFY0YXJxZlF5bzVMK01waEp4?=
 =?utf-8?B?d3BySnRZSnNJQlU1QVE3a3VWdWZvckwwanI4b3JDZUs4TlBFV0dZTDFnU1Q1?=
 =?utf-8?B?OHpxSGVOejVXVFNzZU9iZVJXMDR5bHZ0ejlZUVFhMlAzZnd5bWxPV3Jtdk9n?=
 =?utf-8?B?ZGhJV0x6QmRTaW52aGZZbHp0a3N3Y20wSzc4c2haRGwxNU9YeWRvSmJhMUFR?=
 =?utf-8?B?MzFIVnJqTUlvTUthbFM2ZCtHU0RXSko1L3BSSmpNZTZhdW8wOWI3WHNPZGRD?=
 =?utf-8?B?VGJuOCsreTVMNUV5MWFDVjJOZHdZbjA2NmZtdVVlTG4yRU9COVhETTA0dTAz?=
 =?utf-8?B?aFg5NGtkQndTU20xR2NOamN3UUJobTdLaklWZGRXbk1NZi8zdWRwemRXR2g5?=
 =?utf-8?B?b0VOVXJnWEVudnVOYW5kTFd3elk4UlU4ME91N1dLczY3NFhLRzl2cUpUSWZh?=
 =?utf-8?B?RU1GS21GS1VtSlhKSDgwZVFKM05BQ21iOXBmdGdZbFlnZ3FadkNBUUJtNG9q?=
 =?utf-8?B?ajNodHNkUS9ZUW5wZ3p5OWtZTm0yYmZGZ2Z6RTVBWDFuS2luYyt4NW1lbVVs?=
 =?utf-8?B?eGQvdXBuOEo4N2l1Zm1DTk5xbEkwcCtKK3NGa0wrVC8wdE1LUCtFSVBXUG9n?=
 =?utf-8?B?L1NmeVBkNjViZmd4MWMzTzZNRmNJY3NTanU5aG1tQ01GSUphYStGM0lFM0Y3?=
 =?utf-8?B?ODJVUnQ2eTEyNDJOejFaWDk2aGtyMy8zNGVtVWZqTWZUa1IyM1A3VlVJTDBl?=
 =?utf-8?B?bElzbVRhSnJhWTRST0hlcmJSUDVLTmJ0YkllOU1LZWIxN0ljNHpnelFpYmJj?=
 =?utf-8?B?NUFJWEVUeGM3eU1UcERUSkhaeGpqVTdpdW02RmJJODNrMkViNXlwRDJDYi9a?=
 =?utf-8?B?WUd3eWNYRmw5eFNXOXh1bzdZZmFwdUE3UldTN0t3OHpqYkJYZnRlbXNXbG15?=
 =?utf-8?B?bm1pd3VrR0s3RHFkMUtzdEJ6WW1yZ1d4d0tHbFdrV0tFaDRJdndvRWY5L2xZ?=
 =?utf-8?B?QVk5TnN6YndKUzdpSHlZaE9SMUNKTjdwUlpzM1laaTlaNFdFUmpkY2hRc3dl?=
 =?utf-8?B?ZjFQbnRaNWk0OXp2eWJ0Z2FSck9DQzhNOXY4cVlIZXRQRElUM1R2RjRiYXNX?=
 =?utf-8?B?RTJOd3ZQN2VQUFI4Yjc4NXFSUXZtbzhhUmFtYnFWcGd1SzJsTDl6ZWlnQ0R0?=
 =?utf-8?B?ellPaEhBVzdxSmtTWmpTc092TnZtNGhncHFMbVlrSnZtaXhIOGoxVFZaV0Yx?=
 =?utf-8?B?K3p3cVNKb0lkaENuOFNWVTN4ZUdHRGU4TTI3QzJ6SjdiMmtpV29MUE5PRkZk?=
 =?utf-8?B?eTBaYlZqWVBLdXpwS2dWVnJLNDl4ZDV0eDYyU1pEdXVlNXFIRExZQUkyN29q?=
 =?utf-8?B?UEhUOXFEcDZ5MjFDWVBXaEIxcU5EWGlUc2RFNnNGZFZQZlU3Nld0ZlZ3U3Jk?=
 =?utf-8?B?S0lLUk1QWm9LWFFSM3plSVNhTHlMQVR1b3p6ZVIvandIVG5VamZSUlJ4NDFn?=
 =?utf-8?B?S0ZkRy9vbXRtV0dMaHhhRjNNR1FwQ0g5OHNZS3dCZXY2MFEzMjVINmtBblpE?=
 =?utf-8?B?Qk1VTDZwbHp3N2JqWmVqQVdCZkVsdzVTNlJKZXpieHJlcFVldlA1YmlzUFQv?=
 =?utf-8?B?ZVk2Smh4UzlyOGpPYmtEcFMzZTlvaTd6Y0tIZm5ZSTJabDVZeE9VYU5ra05Z?=
 =?utf-8?B?N2hhOHNLT01NL2xFWUZTUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VHpYc2R5cDdMQ3AwNGxUYm9FRzQvNWxlVXBKb095aXFaSFVUdXRqbWkyZGZX?=
 =?utf-8?B?NXhsM0NxenBuZ25raDZjUVdNYURmVE15WDZTcGlsOXpnbzNWNFV1TUhZeDRn?=
 =?utf-8?B?N2VORzR3NndLMUNNam5lcWNvUlh5SXRqYmtuQ3JwS0hKWWJTL0pnMDVNblVT?=
 =?utf-8?B?alVaU21ldGJscFArRjRPQXhFTFlzY0JIa0lQeUdINXZLazZPcEpOQzFaRGxE?=
 =?utf-8?B?angvOXhURGJETWVBSHR6NDcwVnFROFRrekdyaHdQa0ltcnUrNTFxN3BOUU1y?=
 =?utf-8?B?N3h3c1RWdnRXUGxpU1dhQVluYjBOZ0x6TGh4cUgxcXRFUGd0eDB5MHpKdkRS?=
 =?utf-8?B?K0VDS2tkbko4ZG40NmRoUGVZTFF1Y3BxejgvaG1qMG1DcGo0a2pzQ3VoMWJX?=
 =?utf-8?B?S0dMbGhvd2FhK3IwWHpaMFBXeFVjbnByTkI0Z3lVWDYrTzA1MUJnNUQyb3ox?=
 =?utf-8?B?SUU2VlBaeWRWeHlyUEd0NDhpRVltakt4RFBWNU96MXB5S0gxSThON0hGRWhS?=
 =?utf-8?B?bnpPUDA5TFJWWTVaUzRMaVJiOHJ4MXZHNlpzb1F2S09MTXdXS3Q1cUt5SUg3?=
 =?utf-8?B?M3MyMUtvc0c3NWpkM1RGNWhNSFYzTE1kenZlMk91bTIrUDVzcEd0R1JQMjVo?=
 =?utf-8?B?YUZaTkI0bDQ0eExQdnNob2YyTXVDT3gvSkJvNm00YVYrSnhQQk5weENNSlJz?=
 =?utf-8?B?ditvZnpuMFJDam9mSDZoaE5kNTRXZjhReHVySVVMYm9yMmdJcEx4NTFsVFdC?=
 =?utf-8?B?dDlIdDZFdWVrY1BhQktUMG15RFA1R1RJZ24vWmpEUHRhQnoyQXE3bzdXNEIx?=
 =?utf-8?B?VHptemM1UWFHeWtvR0pUWGM4QldRZ1FhRUd5ME5VQTRxL0RMREJ4SzJtcG5u?=
 =?utf-8?B?Mk5HSmFRWmVMRGFaaUxIQjJTc2V2T01NUURsTEE5Tm16RjJrUm42emEvdXlZ?=
 =?utf-8?B?RFdJbzV2cmgwUWJ0MUd3akdPaWZYTjQ3Q1dZVXR5Yjc2ZmVRQVFSSUdJbDNW?=
 =?utf-8?B?M1lIdmtWMlZTR3oxTjRSMDVSRFR4YkNXRUdURkFEd2o5anQrNTQwM2xxNm54?=
 =?utf-8?B?Y1ZKVVJmQlZGQlovTWVNUFhqMkx4VkhiQ0VQUnJSUW5IT2lGUVFQUTZzT1pq?=
 =?utf-8?B?b3dMRC9Fd3ZRMUtaTkRkZEZzMTFZL0dLZHZMbUJjNUZVYUo3TjlPSXUwQ2dB?=
 =?utf-8?B?dlNYdzBXNi9FSVoyYUYyRFNabytpYW1hOTdLRktpYU9kK2E5VG5pcWZkcXll?=
 =?utf-8?B?c1FRbllDNVlwQVg4S01LYXJGVHppUGRUejh3QVZBMzRKTDdYSExicUU5WWhC?=
 =?utf-8?B?MjZ5dnluLzdUWmlQaXl0RkEvaHBjTE9xbnFnZkxrWmlmNnNqOFZZbVpicUI5?=
 =?utf-8?B?RXd5SG9rZXFRZGdheEhONm1YQ0F0WS9zSXJ2Z1hMQVM4SHlRak9qMmo5bWFx?=
 =?utf-8?B?dVZaaGhMeENYSXlpL1BKNkNWMUNHa052eU9RVGN5YkdMNGpFZUhaa2JSRmZo?=
 =?utf-8?B?WDhlWDlVbkx0dnM1eTFTTlRlWUxxNWdvT240QkwyQ2Q1N1RyVVIyTTdwa3FD?=
 =?utf-8?B?ZmRxUnNVSkJuUnR3YlRxbFN3TCtRQ3lDd2FIck9kdmJXV0NNVkFYdkNJS2U0?=
 =?utf-8?B?RWNxWk5oaCt1Rzdjd3FCbFZ2aVBDR2VKU0NTcm9TOFQvdXVOVW9Ca05zZ3Nm?=
 =?utf-8?B?aVlTZWIyczJ0V2dyakNmMnhjWnVCVTdoeU83VGNEVkM0TlhlbzNkVXRHdWFq?=
 =?utf-8?B?WlgyS1NaTFRCdTloQ3NqZU5YUkVsZHF3YzBQWEl5ZWJWSmswUHFPRW5yZXVl?=
 =?utf-8?B?ejd5bVVtWnBiQVV5Ykt5NjBLNDM5QTdCdjhWSjhCWFRpbnlQUEMvanY0cUdv?=
 =?utf-8?B?Q0dDdUlOMFVxWFlQa0VXL1MrNmxGK3hxTDdmenJHUEFCS1p6WFVmTW95VWhJ?=
 =?utf-8?B?bTF4VzBVOVRDd2lPRzhwV2tUeDg1QlZPZDFWRzU4bXg3eEFKU3hJcStCNFQv?=
 =?utf-8?B?WHBoYUFvT0ZkZnJpRmppYUVUZjdTbXQrWmR5dGsrRUdkSjdhc2VCY3o5UGdj?=
 =?utf-8?B?YnBsKzhqaXRSdjM4QnJhTjg1a0swdjBWQ21JekZ5T3Q4blpyNnpMUjZGNXdo?=
 =?utf-8?Q?+YUlEyh/0FQWqn4k4wE6JlKUP?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/roT85cL+oUykTHOL8RaiTKT+G5Oqybd9N2fariz03b2SENfPAPxd3mL/Hl38/wM+uZB4MdsgbKFoaVSuO08zAKEUiyRDrOHdwgYUhZ/DdStoZw880VfJlDGRi/nCLthuwSd99SmEGPW9UvSobjhQm5DiHpeMQSYtnhH7oTCEyhHGFdOczOA7NY+JXozyJgYkiQwGYslaO3NUEAUckvxrn7ueNPCIhDCnkq5rg32wMVEZpc05YlXYngL0inSDjwN5yq+4nff3M4988abeGySzh/tZrq6YDtLel77GBN77L/tF2IaUUm3qzbZSblPxK0vZoe+E4k4g/n3Cq41GmSm/Jg0/fdcuwPb3tK1tAKgo/0vm3vDK0EG9g4ySwLGjrFuLCgMNU5G5xmjULuhP4Dxa6/Hv6+enBQdrTvBTANUs+Kl/1BcEU4CcsIDlKJecSspBpWRM1/LD2SPlqWAGk1lR1n8YROuE8lkK4LLUZu3A9Z3LRrwq6Mu1sQhG4yLP18ow9gxVIFonQnM8iA9P93JnX5R/BbTqWRnFuVt6/cboUAeV61KX6uzaQBb04JOEhfWURF5siVqSfEk2acjgn5ao59rtKQzSbw2LK3vsS9KeVw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c264225-b172-4a8b-bcd1-08dcd2b62e15
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 23:05:08.0575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Mb1B5gkbFAtOZz/OM4l8B8XObRellbMeD3dVYfFnB7XPVbWzPJl6UdpyGExgOFhYlgpwRe0QqAR0UAY9flklg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4483
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-11_02,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=805 bulkscore=0
 suspectscore=0 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409110175
X-Proofpoint-ORIG-GUID: ZFI0hfMZoGTFepFL0jaRdhqz-hDLIiG4
X-Proofpoint-GUID: ZFI0hfMZoGTFepFL0jaRdhqz-hDLIiG4

* Yang Shi <shy828301@gmail.com> [240911 18:16]:
> On Wed, Sep 11, 2024 at 12:49=E2=80=AFPM Liam R. Howlett
> <Liam.Howlett@oracle.com> wrote:
> >
> > * Helge Deller <deller@kernel.org> [240911 15:20]:
> > > This is a RFC to change the behaviour of mmap(MAP_STACK) to be
> > > sufficient to map memory for usage as stack on all architectures.
> > > Currently MAP_STACK is a no-op on Linux, and instead MAP_GROWSDOWN
> > > has to be used.
> > > To clarify, here is the relevant info from the mmap() man page:
> > >
> > > MAP_GROWSDOWN
> > >    This flag is used for stacks. It indicates to the kernel virtual
> > >    memory system that the mapping should extend downward in memory.  =
The
> > >    return address is one page lower than the memory area that is
> > >    actually created in the process's virtual address space.  Touching=
 an
> > >    address in the "guard" page below the mapping will cause the mappi=
ng
> > >    to grow by a page. This growth can be repeated until the mapping
> > >    grows to within a page of the high end of the next lower mapping,
> > >    at which point touching the "guard" page will result in a SIGSEGV
> > >    signal.
> > >
> > > MAP_STACK (since Linux 2.6.27)
> > >    Allocate the mapping at an address suitable for a process or threa=
d
> > >    stack.
> > >
> > >    This flag is currently a no-op on Linux. However, by employing thi=
s
> > >    flag, applications can ensure that they transparently obtain suppo=
rt
> > >    if the flag is implemented in the future. Thus, it is used in the
> > >    glibc threading implementation to allow for the fact that
> > >    some architectures may (later) require special treatment for
> > >    stack allocations. A further reason to employ this flag is
> > >    portability: MAP_STACK exists (and has an effect) on some
> > >    other systems (e.g., some of the BSDs).
> > >
> > > The reason to suggest this change is, that on the parisc architecture=
 the
> > > stack grows upwards. As such, using solely the MAP_GROWSDOWN flag wil=
l not
> > > work. Note that there exists no MAP_GROWSUP flag.
> > > By changing the behaviour of MAP_STACK to mark the memory area with t=
he
> > > VM_STACK bit (which is VM_GROWSUP or VM_GROWSDOWN depending on the
> > > architecture) the MAP_STACK flag does exactly what people would expec=
t on
> > > all platforms.
> > >
> > > This change should have no negative side-effect, as all code which
> > > used mmap(MAP_GROWSDOWN | MAP_STACK) still work as before.
> > >
> > > Signed-off-by: Helge Deller <deller@gmx.de>
> > >
> > > diff --git a/include/linux/mman.h b/include/linux/mman.h
> > > index bcb201ab7a41..66bc72a0cb19 100644
> > > --- a/include/linux/mman.h
> > > +++ b/include/linux/mman.h
> > > @@ -156,6 +156,7 @@ calc_vm_flag_bits(unsigned long flags)
> > >       return _calc_vm_trans(flags, MAP_GROWSDOWN,  VM_GROWSDOWN ) |
> > >              _calc_vm_trans(flags, MAP_LOCKED,     VM_LOCKED    ) |
> > >              _calc_vm_trans(flags, MAP_SYNC,       VM_SYNC      ) |
> > > +            _calc_vm_trans(flags, MAP_STACK,      VM_STACK     ) |
> >
> > Right now MAP_STACK can be used to set VM_NOHUGEPAGE, but this will
> > change the user interface to create a vma that will grow.  I'm not
> > entirely sure this is okay?
>=20
> AFAICT, I don't see this is a problem. Currently huge page also skips
> the VMAs with VM_GROWS* flags set. See vma_is_temporary_stack().
> __thp_vma_allowable_orders() returns 0 if the vma is a temporary
> stack.

If someone is using MAP_STACK to avoid having a huge page, they will
also get a mapping that grows - which is different than what happens
today.

I'm not saying that's right, but someone could be abusing the existing
flag and this will change the behaviour.

>=20
> >
> >
> > That is mmap(MAP_STACK) would set VM_NOHUGEPAGE right now, with this
> > change you'd get VM_NOHUGEPAGE | VM_GROWS<something>
> >
> > >              _calc_vm_trans(flags, MAP_STACK,      VM_NOHUGEPAGE) |
> > >              arch_calc_vm_flag_bits(flags);
> > >  }
> > >
> >

