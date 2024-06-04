Return-Path: <linux-kernel+bounces-200732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 506088FB41D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7346C1C22235
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 13:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6811482E9;
	Tue,  4 Jun 2024 13:42:09 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21D31474B8
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 13:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717508528; cv=fail; b=ga1qsaXjBgA6Kk6gul86DvSsIvxRc8H5HOe2jhh4SA8qbTutKmy/UVa91N+R6Pl30h6esQJf16hbeJx5n8ugFmTTZyZOwzmQbbjyKyP3KsvzcOup8V6/gYqZrN2RvNN0zjhXRrQlGvBge/rQRdRNsn/2E02soklN9g04ZSgRpro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717508528; c=relaxed/simple;
	bh=ObubcWsML9hMLKLBMb7AOeCNH6yesvBIknywJd4S89U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Fl2V4Zmca1R1Vdq8Q/1sfHOTv0zBpyvbkunNs2Rn1Hay8Rv3V357AsTtNBtFVvCem93E2yNbAa213gkrEuzcPmNw3Sbit2p8Q9yB4rm7DjDBbomz5cJJgHg/N/CbCJKxgo2Vd0CsGkauG/R0qjVIyZzH7BY6FlYRU1WEz5VG+7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 454Bnf6l032521;
	Tue, 4 Jun 2024 13:41:54 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-type:date:from:in-reply-to:message-id:mime-versio?=
 =?UTF-8?Q?n:references:subject:to;_s=3Dcorp-2023-11-20;_bh=3DHyuQpeARm2CR?=
 =?UTF-8?Q?CQVbkLNYCH8hco2+Lv3JXGsf3O2oQYY=3D;_b=3DVurn/LEvLawrBCKwGcUQ271?=
 =?UTF-8?Q?eLmtD5c6BKTjMeQLijabKfMivYSd++YspKLjc+9tTvgFv_dXr9FR8hz6I41UxNI?=
 =?UTF-8?Q?ZEoCngddhR5BvLcVNSzCOXvD0PaBTuUwbLRZ3sOfkOTAYPF6lAQ_lAu3RGA2VjM?=
 =?UTF-8?Q?UtrI5we/LEIv34J+XSWbG6AJYcoNWvkXZecMOwR00yZIogJvmoPYtZPPN_e0R7R?=
 =?UTF-8?Q?c2P8sIid9hdzrlz94HRDC3T1iBVWdz+IjE2UFpU1ojHiIp1FraJEtJDCE+PNEIE?=
 =?UTF-8?Q?_KuCH5yXaw6/M8m0r3T/8cfPwo27WWa0yMYnheJ32QVDg3MkTzOAxLdJeLQMLYm?=
 =?UTF-8?Q?oc1BnG_6g=3D=3D_?=
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yfv6u50qd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 13:41:54 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 454D10DS005449;
	Tue, 4 Jun 2024 13:41:53 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrmdk9ty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 13:41:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vv4vxnrUt2YYdT5a9pVR1+4ZtTYPjaRgaGC0ky+wiFaffornvh+39rz5LSAYDRzRTpWROCBGyeeHcBeT+tfflxnIZpDdxxN1o8jMSnQ31RFtoC9wHXeOGOiFkkJpBSM2B3O0owG9/QWbZ+WNknPnvm7KnODgH8c41C9HN+zu64GKzNt0NjdSffEnpvMtwOY6oE72J7FMs4E9NKIDXHWNnsfqpMNZ46WTldxTrcQ4MI4SYdPYKNlZDxOZMxVVaU6RQW31Zpi7nWvvoBzDDyRgdsD0CIW1ZNFJqfCh63yzFSz7HHj+cA5uVZ97sK3685ftQ499nSWCBmLVsE/JpsH58g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HyuQpeARm2CRCQVbkLNYCH8hco2+Lv3JXGsf3O2oQYY=;
 b=eMKqoLi/HylbwNJGcBd58dTqVNaTgVEDAqRs6fKKbgbJCPS5te6YUjjyS3H4aS58jJAZMAfbJTDQPEJZcrDQ9BiGxkg8ZM0NTR1/uyHv8PuKgC8vqksBQt6pT2FJTSLLkRDMX3Ptctz5Y1BIkTHSoq9NwouDFGagQ6l4Y5WSM+e/Au7LlnOwYysKEAHIsYreWK/ltNGc3/MAAQcItKJSYJbUl2Jr+9iEfaqS+Vi37nIbkUgzI/htrBrWMdwTIRnBFhIhhdst4VS14XHZJ/U3Z10OLNmEtYYp6prdi85QGzl8X8kDg0ZqYvrdCenvTVfxOhDtPfjRwkkHrvdtr9KHrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HyuQpeARm2CRCQVbkLNYCH8hco2+Lv3JXGsf3O2oQYY=;
 b=G0PdP10oTPnzalcAyY6Ivz6NXL7Bb1uHi7Fo2MbID521YcocT7Bmxt6LGtLTjiGEhc+NijKqoC/4P5mO4Zsxtn1DytTyELpbfvc+5+G7gmAOCEwtkuFSHvw35IviH9moN0O1IHL+tq5v1eqJ041cSto07jMy4txdFCxvsPV87F4=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by MW5PR10MB5668.namprd10.prod.outlook.com (2603:10b6:303:1a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 4 Jun
 2024 13:41:50 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 13:41:50 +0000
Date: Tue, 4 Jun 2024 09:41:47 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: syzbot <syzbot+c67d06ab25a9bc4adf35@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, maple-tree@lists.infradead.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [maple-tree?] BUG: unable to handle kernel paging
 request in mas_walk
Message-ID: <a4ha35wz3qukr3xhx7cms4dxquv4fvmmaura7oowhnysgc3jvv@u7xsk7zghtng>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	syzbot <syzbot+c67d06ab25a9bc4adf35@syzkaller.appspotmail.com>, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, maple-tree@lists.infradead.org, syzkaller-bugs@googlegroups.com
References: <00000000000066aa68061a072231@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000066aa68061a072231@google.com>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT3PR01CA0026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::14) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|MW5PR10MB5668:EE_
X-MS-Office365-Filtering-Correlation-Id: 19fa2c78-19fe-425d-0840-08dc849c1619
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?+lFmSOsVmarMxB7b0i+VY/VJjrCS/EyWaIPqqmnIhTeFR3Rz00ruityjJkfu?=
 =?us-ascii?Q?7l3N5wWrwPS36IZpgEV+ezNMi6eHRK2sQM70SNrQBGJO23bMcKBq0Kkweaa4?=
 =?us-ascii?Q?c0SzTaLsOYhTPxdT0xB8opSv5EbCosEWvpnQOmEzbERX7665IMJz1jlXqS0K?=
 =?us-ascii?Q?dNxdpK3TXKgBMgWzk9Wgx0mW2cfc09GX9zHTxcBuiWB6EV28ZYdzkfdmHNEg?=
 =?us-ascii?Q?g8lV7nFGs9T7cj86fTQ07eD/1vqN/FoS0+XP9FQ0EEs4tCLuWaOKz+Hshze+?=
 =?us-ascii?Q?chXaXWX4YOT3lLLIKWD8NNCv0a03ONzYqCx6JyatMPDIa3KNwJMmqFptU3av?=
 =?us-ascii?Q?1sepnFBYYXNIQqj7T0rYDLVD19ijrgj/Ct1EMH6IVi3TE073HCMuGjC+b2SB?=
 =?us-ascii?Q?GWA+Fp5Alsqyh4NLOqkwnczW6WeYH/XjpVCcD/PeunUSGav4XqQEUfbqjFXZ?=
 =?us-ascii?Q?DQg9TdDvKk5+YnrOcDxhCMP/2vq8m7h2xfhB05i4b1lW0/dinQRghTPMjoy1?=
 =?us-ascii?Q?kTFSdvf86LX15yKmdvZvpBQTva3huEVEeLtn2eQIsH1jUxg0BJN8NnBMJ5SU?=
 =?us-ascii?Q?D4rjz/dadfwJbC8tUMPdG+R7Rhlx0xr0YkH+k1J8EkeuA82BMGXvanepwUsw?=
 =?us-ascii?Q?dLE1rOKMrN4kQikz18kQCV3N+DSQKh0miz3I6ALS/CAYMhQL6IZRtrWyjqOa?=
 =?us-ascii?Q?CWkPhJYF6ODkKVU6nHAKIHsHssSOEEVZEy5HE9ejZvcWWP+x1fj2O7W/it9Z?=
 =?us-ascii?Q?l3OCozgM43agTaVvL8RVth+kMCgLrkDMUOPsPPJq51AJbT/E6c3UTjkGjgQT?=
 =?us-ascii?Q?IiIMsaAoBbMX6gaz6tgXsgXRMrjaLKV2tktOyE3MhRLhBW8QghoS80bbWGbL?=
 =?us-ascii?Q?vVeEU8pth4gsALlMPTniGNjntllsnVxEaGOf2C1DG1FRKiTmxDX/umdMXOlx?=
 =?us-ascii?Q?pCAiS+tDJ0wfMrP2+0PwsybxRnqrXV3om23nZYshmoNnEsMpT35+3CqHcqIF?=
 =?us-ascii?Q?oGQNP/fd//dUZHtFzeIESSx6D4Xl/1wT5poMN2Ecy4zS/SvEWAI0N8Sd/IDb?=
 =?us-ascii?Q?4fs8zkm+rrro3tDi9P8KUh/HMAaiEvMvGOjMPPJ7BWDmKvKIZqxiRf8+RUWA?=
 =?us-ascii?Q?J2FKKliTn9SoYyW+7Qhx5NBxGl03XUNVrtS3j/hgA7HBseP2EOqo6JcGsdng?=
 =?us-ascii?Q?3wHcyr1r4dRQTZFF9apfD0Fc7wAkE+9J99U8m54kusy5CV55DTKKeouZonKf?=
 =?us-ascii?Q?hwZUQBgkmS7LR6iqgjB7OGYpDwL3GZaAJJBxs9kzRw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?8qldh5lrYW5alLrP1XGUfgauZrKyYQc8wr5R2BP1oFniaf7Pk9Wij6Hj3oDH?=
 =?us-ascii?Q?n5ri+6UKtyVaCMwpd+YqwBOMVCrSV+a2MVoMBXWmYb5uqyG+KYzXJlE/hyfQ?=
 =?us-ascii?Q?B5CGtFcWQAH1nG1bEqU//7cOzwVU4OwrXfGgYIJq0bgA9rlgzNOHsG3+ktAZ?=
 =?us-ascii?Q?c7KobMcQij++C56EDIoS+iqEYWSfdYOagEJSfoURoUFb2nmfj+Clpnx703Iy?=
 =?us-ascii?Q?PqOTpJwlCrG6no/bnkwVbA5aeiYNybEP5D7QKqoqoLhWpMdYT/9cQ9HqeLW3?=
 =?us-ascii?Q?Lx8E573xwer6RLJ/2eCJBC5K6IGI5tr74hvu8KtVW0hIyVrLen8eqzIJSD1z?=
 =?us-ascii?Q?8raFillr3cdWCRZb3v7a7ozcT+Kh4q0VrTmNL/fH4bT9eEEgWSIy685xobzJ?=
 =?us-ascii?Q?Fvg5STI3FifqQJhdFf1YZ9aSR4Xt7wlEZT1fSXgE0blwgFJuBeaSBuepIemT?=
 =?us-ascii?Q?Z6/nSf0QxEAYj4YsKrktw7JsSRqgSiDSI0QRfSL+V9ihRM1IQ+fHgszzBL+O?=
 =?us-ascii?Q?qGPnd4S3WgLSriX7tssF1Iy60B/QAkziieYLX0TgAAIe7+XhNIimev66h9uN?=
 =?us-ascii?Q?Dxayx1JH4sxex6s+kiC50rSl7c7DP/7LefKfQdsyBQDMwcCWvmAMXr6JEOSQ?=
 =?us-ascii?Q?wmuXpqful4mNez8S/PBZKstbw5LVZrFTbXzQpHnnNsMqG0a9KSuUzmoJZ5Rx?=
 =?us-ascii?Q?1Kte0HLyMZEoIHPAzTjeCrd4XiPdxgd8Iws3pQuIp6Iem5u1r+cILBqLZreL?=
 =?us-ascii?Q?HIpeKm2StaEDoEK02OxV1jgLTuc0sEKutho1mfNlWRjwMpmeJzBSbpPdVMcj?=
 =?us-ascii?Q?+Fn6h4N8oSlvm37aZbjfN6zwijMOjwTqiRmt94+vZugVnB/0Yo47M7S7aPOC?=
 =?us-ascii?Q?zaSKxGzDQJ57Of/eUZdsiQuZL3ls/TnZnU5uXPCua92pysHI3oikLclGzDnO?=
 =?us-ascii?Q?T2FJNSJOHkXyeOJDEYj4hDnVrUKeET+8F4Y3jp7jRtL6/rGDUmmQZLsIqEMU?=
 =?us-ascii?Q?QENEMjfZFUJMxGPZVf8G1U+b5t29fDtyP0GNWiXkqtsz+ezaSwwDf74YfOCA?=
 =?us-ascii?Q?SuClBqWqGw0U7DAW2gZNcdZ0PSqH2tVV4c1ytqj6WJwzjLFLA9pbwSxeojNX?=
 =?us-ascii?Q?zFrUZxCLE0mMOkXwl9nkbRh8ith0Ffiny2rTpdSCXINH/R5NvenU1FIFSO8I?=
 =?us-ascii?Q?it50P2aq5Mf14dULd6O+ZeIAldKfKO/+MVcUQnY8IrnS3L5o4WcE/cBaVCS2?=
 =?us-ascii?Q?OF0j9wLu1Q6ROMxyMhlrYNHP9mSEnxPCg2M7/ImK3amk9oGdB+w4lhaC4v0r?=
 =?us-ascii?Q?+vyngG2FP0HGVbJaFnf8WfG7lXkQVsUo8DIhyrF3lf+nBsMu7C3HUg3f5Gdy?=
 =?us-ascii?Q?HeCKi6RmTHjZ6xC/ZepKyeyyuINuH0tFECQe0AeCKt4F35YD40PnMHVPCusK?=
 =?us-ascii?Q?VyVE6FUIIrvaYZ6qjUCc9yA6x7WU+Et+rv48+Bb/7MScPFfPtXZpX+oCKZ05?=
 =?us-ascii?Q?3+vjPrfWmUYQKnjBGBFWATQ8oig6mxtJHrJbWhjLxTS+ffW/aCjvs+5SHRRo?=
 =?us-ascii?Q?G+H3hmeB9e1rzfaIXIpa0mTuAkH40o46S9jtsgJH?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	i92+dz30+WGrcV/m1Q4DH8G+GEceyrEhSSo30+M1Q98q02PCMiFwzWyTbAOaZGPoexaLc4V+3kcO00qZY5G8E1N0vWF/RSRiZbU90Zt04Cjrq990ByIXEIQLTto/vJ0PTXStOtIwhStmU5YD68MzeovIF+XVtW837EynWIb/DlJicSc6Ct0XadtVlfz4LP1JhIlM59o30ILLsNDx2NxyyBz0kTbbbkB535qj7eVKyll6oTtS5RFzHrMuo9R9Opgt2NIJuIPMgbRzMMU0XDQIq53buqS1fwkcYBnfRDMieKPmd0A3owp5SDlu39g+JPFYpx1VbBQATtBW0cm93FASYUWRPEHiQyp48l8KGRo22ZKSBBaH03V3KXdX38ghVAlq1AQ2qt5M2mCwOPl8/4B9486OZIkR00BLrGw31sjrBXr6UiyR0GMUU6OoLCqkq4fx6UXqfyVsmmuLcZCLKPrAQy2e3F8atGWRAJVZPjHKRvcyEwCGxaQ+uNfUP2ZpIRhyNHDLV1fL/n8PQe9eTUa4mq1evEhnToEl64KwQKp/LeNDsfxc4JbFjyufEIYRU7CVYSXa+u5ofKxQGT3Vmn1rdE3moCzrEyC6bZwniKem8Wg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19fa2c78-19fe-425d-0840-08dc849c1619
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 13:41:50.1711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yA5MV4QLEdZHr095Xt1IMbvnxUy8tCXTpEn6qqpymX42re/Ncydi7sgeC4E8/LiPso0whTK/hxCS9q/tmnKINg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5668
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_05,2024-06-04_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406040109
X-Proofpoint-ORIG-GUID: geoR5NSRwrDe7pS5D0UkcreORG5mP1tx
X-Proofpoint-GUID: geoR5NSRwrDe7pS5D0UkcreORG5mP1tx

* syzbot <syzbot+c67d06ab25a9bc4adf35@syzkaller.appspotmail.com> [240603 22:23]:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    4a4be1ad3a6e Revert "vfs: Delete the associated dentry whe..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=128638ba980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=bd6024aedb15e15c
> dashboard link: https://syzkaller.appspot.com/bug?extid=c67d06ab25a9bc4adf35
> compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=106f71aa980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16b4ffc6980000
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/384ffdcca292/non_bootable_disk-4a4be1ad.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/75957361122b/vmlinux-4a4be1ad.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/6c766b0ec377/Image-4a4be1ad.gz.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+c67d06ab25a9bc4adf35@syzkaller.appspotmail.com
> 
> Unable to handle kernel paging request at virtual address 00700000077b9b78

Never a good thing.

I'm looking into this but it's not easily recreated because I keep
hitting another but with the reproducer [1].  I tried the HEAD commit
and the more recent v6.10-rc2.

I have a decent idea of what is going on here, but need to prove the
fix.

[1] https://syzkaller.appspot.com/bug?extid=7eaa0d7b9fccf21052f1

Thanks,
Liam

