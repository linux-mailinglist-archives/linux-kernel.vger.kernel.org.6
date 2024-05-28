Return-Path: <linux-kernel+bounces-191569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB5B8D1101
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 02:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 367D11F21DF5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 00:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4272D71B52;
	Tue, 28 May 2024 00:37:02 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A116F08E
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 00:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716856621; cv=fail; b=S8xhpJ82km2kmlTVk6Y7m8FphscArecBfOn+sX41Yv7XRXxULyc4M5NVkyN7QZkOfjLlc+ad5WpWDqf5jHxz27+Qu3OjS85cz6riGA1d99dMkf9OJ2if2vEQXuEgR4vEgRU52l39xFzULAJ87zSfrRembBdv2pX4GcgcY5l/KSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716856621; c=relaxed/simple;
	bh=yuS1OSjl1GTXJUfUvNIv3z6frezpTVaZ8v2uU87nkXw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YPQiE2Q/Ibl7aYelMY+RAL98LkO7pTaefLqkOr4Q5YWpwdrVg8yTqtg6qcR3MeRqFPZ7y0yRB0qK4Xz8GUn919PqG6xca6C9TN6rmsEOeMlgcLXq3PYI+ncGvOmB6KMsZ1GIV7HK1+jGjCCO5xpo6sKpA1azPacLcrb5yg7HmLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44RDI4vU025167;
	Tue, 28 May 2024 00:36:33 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3D3ePzpSjk362suY20kapEjeWiOOdyFHhQ33nIHlMeCVk=3D;_b?=
 =?UTF-8?Q?=3DXeU0sJF7haCDrjj/LB8moX4oLt8eoTN4sbNV1fECma+R4hcjl9mTa9jGt3jc?=
 =?UTF-8?Q?DMCwFZqK_fY3Vxrp9TbUHNEuyb6u4vOMGVqOZug6nWtW0WJPB/+03rDX32uWGfd?=
 =?UTF-8?Q?8bpft8BI3hGblI_wxL0elbSEJ5HQzdWB7wcZtyvF0t0LEmmkIqIXz/VdLtpZIZ3?=
 =?UTF-8?Q?31ZCSTvGYxa9P9M8Irp2_gxhYpBWqPgML8k4cXCGzkkIj/CPEZtpWVWsDQFczPR?=
 =?UTF-8?Q?luvKXXovwyz5zLy9YymUCJaaZP_kXMT+4k/PoEdo3/RLBdkWgY+ME42Ryrl7Rcu?=
 =?UTF-8?Q?xr+pX+ferBM0j0a9dwR6iwEBNP1ZgB3j_1w=3D=3D_?=
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8hg39ce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 00:36:33 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44RKf1Rr025740;
	Tue, 28 May 2024 00:36:32 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yc50p7xsy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 00:36:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GTLX1rIxXY3CJa6PdB1asP+pWyQyqz5rQWFG4LTMM7en6yisXa2gCM/BLdTk3iK0kjv9LlyIP8y2YAdua1XuswsQrayK6bEPl2EWleCBJGx5wjDdqhqVf/kz7QlDlptOXqU050wamVUhThut6uPj1Yw/m/h2abQZQ1xS0IpZFO9SKyiaHhOdhhp7srIPz0or5z6DkjIXuzSKQV3IikC5kUgxYTU7UQsfzSGRwhZhkIHwAAUCL60lpg71RkOBjDLi/1h6i5e4LuPd3bWMltBQAxag7UMh6pw1fg0Az/E57DZEzE3GQRC012GGnd9NWuvpJ2Wyg4Py9KSQFoDOXdU79Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ePzpSjk362suY20kapEjeWiOOdyFHhQ33nIHlMeCVk=;
 b=hU/6ir27l+OMFa0ziEIN1/KKJ82Kx+Qa12hnEH7lLqERm3t343k+p6G3d1Tiqww+fuVxEIM+SWbUcFbzdFwJ7GhVCd3H0KlH4fxKFlBUAgM7ARb+jjB0yMMS3ezAVITwuZPI2kEbYQ61I+vMv4iHg1tBuyVBr/SIncasgmItmLxH4h1BDk+84lzAKVHnr9aJT2N/C6PbghN3VeClBWezc7emCjGeam9ZEfFwCr5800o0bj5xsuM6j/t7i0B6iT7q2j+csZM8fntdUwXR7kZRl5yaaE2PdawDhuu6KM8bsxuDTsEEANYaNuI3MssfKckfLduUrmr1dMY/pYGQe82DYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ePzpSjk362suY20kapEjeWiOOdyFHhQ33nIHlMeCVk=;
 b=ViZ9xO9W962F1WB2hncq1Psd0QxaYpBFPt3FdismL9iAtwI8vQSmySHfkDUadSqpF7g3qv/75OQ23JX6JCzgyP5QyY8cqOJFNH18O+b/uiF/efhF9ezTe4IsDuDzuIwqni2uc7fAAvZ6/EPBHpdt0pO6PAhOj7PHeJJH0lrYtgY=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS7PR10MB7177.namprd10.prod.outlook.com (2603:10b6:8:e1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 00:36:25 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%4]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 00:36:25 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, rostedt@goodmis.org, mark.rutland@arm.com,
        juri.lelli@redhat.com, joel@joelfernandes.org, raghavendra.kt@amd.com,
        sshegde@linux.ibm.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, Ankur Arora <ankur.a.arora@oracle.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH v2 19/35] x86/thread_info: define TIF_NEED_RESCHED_LAZY
Date: Mon, 27 May 2024 17:35:05 -0700
Message-Id: <20240528003521.979836-20-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240528003521.979836-1-ankur.a.arora@oracle.com>
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0332.namprd04.prod.outlook.com
 (2603:10b6:303:8a::7) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS7PR10MB7177:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e4ae77c-402e-4da7-9c8a-08dc7eae34aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?TzNOQYuxlexlM/L7AiXPEf/FJhxHAdmQabl33W5F9EkePufiUdrdXl1rAmZ4?=
 =?us-ascii?Q?i0C692vKu1kD76dyiLR+qg2/4YSTb9naMQo7b1r+5ZO2yEmdLmjMEmiTDoSz?=
 =?us-ascii?Q?ff+5ND5G4eR0osZWl3O0Bf2jIXzzWgOmkOKwu8ddSeS3UDh1dDNhtmay8vm3?=
 =?us-ascii?Q?tiYs5HfMI7rGMKTyBJVaH8Q3JHbYHADJD+9UYOjXWHnvyUBEFCFrl+H1UAZ9?=
 =?us-ascii?Q?0d4QDo9HRhBnJCXCnAEKS7d57YCwDO3W6V45nvMnJiJCPngqIY6dgcNC8jjp?=
 =?us-ascii?Q?adXu6AbXu2IqfraiB+cpgF9lPDiazz5KacB57hRhxXp+NSiTPyUI6B6AEk7N?=
 =?us-ascii?Q?VXB5VoTSGNk29GXXA+ePCqB2r9PUwmz07dwQiqLKa7TmFpWx0vTjXozDfJnv?=
 =?us-ascii?Q?tT+/et0SMLbBqsQHJGsTM4qa2eNVLdMeLTs6584SgccpIfBJFWuaYpzknfob?=
 =?us-ascii?Q?7aeAFy+TXgKVp/kfiVUhA2jfIk+Mbz/mHEM9o6nkIqM3LjCt2wTmR4Akrnk3?=
 =?us-ascii?Q?9gptLsxXoQgmodcSNm44NTJg2SYMMkoIRC9jSxevfTfNaN7pHJC6ZjUYxrIi?=
 =?us-ascii?Q?7GwtTjQwDWsSR2aF4SEwJSNWkRnqbvTjfoQiczEgqPjQP1BxYsvR+BgoCNaT?=
 =?us-ascii?Q?bUekBShf4vxMltd93zZlAvbqhWh85HbijjgD5J4So27v25JSA+oVeRE/On0p?=
 =?us-ascii?Q?QJjG8r7JS07s6orYp/vdvh62XBIvXALOt3NU3/MFbU959fIP7kp+ki9n2L+j?=
 =?us-ascii?Q?B+KkRzDvElnGVG6GgPssLn9kzT5yzPief5BRdT+f2iGr1znP+b/Urw9Lx67Z?=
 =?us-ascii?Q?feEplFNqacgT8Ea6HMQ6N09K/g3WQ3hoMpo158izKU8ZVpouIT2iNHiGT/fJ?=
 =?us-ascii?Q?aRCktLIyANmPJGqc9G/wqhd5GPBvaYxoDuWMwt7r8K4ToAK9ZT+cXAnJrWSM?=
 =?us-ascii?Q?92FjydsnPnGLnfT9GFzV8IZuMSGvEm4fRj9bW2umUiTdMDAnF8AYd7ozZKmk?=
 =?us-ascii?Q?whSq6S8POv0prqIe9fygmnTfjADIhA5vjDiIH0GAK9P9MKX0bawdxkwlv2pY?=
 =?us-ascii?Q?eP8qwwQEL3YAyOnngrOtUln8yjdUfJH/c6A0j3iPWFqTr6R5+BzIVwLRaoD6?=
 =?us-ascii?Q?mXjekhi1rY23qgAP3BkUCvgkK2AfV7j5HahHfcWmlHPfZ7lWq0tYuBe5HOHt?=
 =?us-ascii?Q?5yC6fQqSFTgxHQ4+8hrpIvZO9cFANrPFQcG/Bw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?3A7YWcTJezE+Jn726fVD0yYmDZAXlxzdMGghiG+cStc0xKY0UrnU1Cs0wZsb?=
 =?us-ascii?Q?l4nFRJCDY2t0+yOSYccurnhBXp7cTR8Gn0ghd0bO8AFGqk3vAr4FxvszSbtH?=
 =?us-ascii?Q?WexsVaEKeztQra0OGmuni4PdgekhVwdh9JEurJolhguekeatLvCGcEPH0Lr3?=
 =?us-ascii?Q?b2/gYfhJCvpjXTDkmq8WChjiNXLM61/cZwL4V3W5b1LX9xG8R3ro89cylshe?=
 =?us-ascii?Q?Z/EXQv8ViHZf8T1mW8MvGFUIc49F2hxo3OKMj7wXFBgSxq3CMqPfmCbIjUha?=
 =?us-ascii?Q?mwFrVBMUiKwsA0J+8fcw/QgwvJbqoRHFvbprMxPlFEiVOrx5sBgrc11If2OI?=
 =?us-ascii?Q?TagCIHA6fXUXBU0bkGUyBhMKsvmi0Vx77B5b8ZI1m6csQDCM4JJSOhNdOqjg?=
 =?us-ascii?Q?FnCJwDBqoDThxvrxOlkx05C8MTDAtP0pmb7UouactBGvUEOO7Ld70g5Cbc5W?=
 =?us-ascii?Q?1oq+JB/h6Xos7UnbCNeew2u7L+BIoz4dTqnorebhy/ciygfP2Gn7caFFa03z?=
 =?us-ascii?Q?4IIJPBeupk5OxZiunVzE9iuymzsrc13R3EeC98t1y+QQdspYwSEmeMGHupX9?=
 =?us-ascii?Q?dz2+rOO4A1q1t4fHeJ+pz3XNBBLN1OVjTQZhKikNT///RvwA8TDx9bYOmsh+?=
 =?us-ascii?Q?KL91Vq7rpH+HJAlsYGn67HyCMjmAnHU6/AHg/83mN/QJy8Mtu8DWlKaFOv96?=
 =?us-ascii?Q?ql7Qo5i5xY5nlW99mOfQ8dRbk//RRbASIAnfQHDVWHm560SsBq3tsuQhXwLb?=
 =?us-ascii?Q?EZmldL7fCEaPs7YGMr22zyJOiJ05sMRVsoNKnq/YtolHbDZqZKJR2tbAHTWb?=
 =?us-ascii?Q?gacSevknkFVkbkvB7UXSvOkQWI+bRMl7g1EBA7sDRWknlZ3ZGcNm9oUuxwjC?=
 =?us-ascii?Q?bfi21Dlyg21GM5scz8xcNvuSlcHW15dXjIi9JcWBfioR0Ts0sJLNcvff9WnU?=
 =?us-ascii?Q?tfh3HZKZbbjiXs4KiYSzllmhGhVvwQKkFMJSDcJP5WL2DQcHsQU12aahWJU3?=
 =?us-ascii?Q?Ffzek0rk0XIGcEnrweq+YGzFDUuna3xiqxSrIt8tqLkn6BkUJC+5oLjAK5FK?=
 =?us-ascii?Q?AyWzSeoGaw9Eqb+rPqoqtwWirrZeYEKu8a/TS85DLJMDtKlPGtT41KmsqpQT?=
 =?us-ascii?Q?Zo+D2sjCnqhGzJjTU3CeD8cVDL57KzSz0eiR9rssj6ynmRyfMiw+XOkbwKij?=
 =?us-ascii?Q?LAtIRRlNatafbwsnH1XpqYSaUOZxS2lKpfTVrLn7Z13cdzhQdRI3EaWBEBN+?=
 =?us-ascii?Q?onnwcrUqWj5N1f+J1GcH3YkqJOuVmN6x7SIeT8YDB6RJ/oLYeYTEB2LunmZI?=
 =?us-ascii?Q?wIJuMFJUAt/bpo7+8wVNW54gdzHWf5BbIO2EW8/B7z7PHsSPJhGtBmPlVrSh?=
 =?us-ascii?Q?l++p0kVi/V0V2Dq3gMmkKoXYArCjMg3StwbgtVWfxt6zH4+rEfBCc4cZmUY8?=
 =?us-ascii?Q?eWvreMOY7CSceexr903fiN7L4zbQKr2lgLM9bdsHdbDcy6OH3yPJJZMQsgrH?=
 =?us-ascii?Q?JQ2V6JiWLQfgnBGWhSIm33dYQejfIh75kuSf0UJqbkaR4ARCYP51FXFCmks5?=
 =?us-ascii?Q?OhxaJgiyNENHOiDSLKbxmh0IqzBdYXc4K8ky21eOlVYrbjp0bwsJ8ImvRUVJ?=
 =?us-ascii?Q?3w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	0Kaf7gtqJknFOagc59xV85aCOVEdAx5GUxrSBEW2ZUZZxaYaP2syYnZEEa5GGTdOCEz8deCMTOfAU1kkAIyzjj3cdlAq9UGIGzWe7D3dJROEE2Kj9uoiRixo4KzH37fUuT1RT6+gm4yyaw5jBNim0F2qtwJAZkGc1tB/FLiJyBmDOp3GFK2rGko9pRPjuYRkQKjwJI6W/PiSB3AGwx5hsTOv691nPnwFijPSg6pF2kPxiL6lnIFAq/3Q1bbn9i2jE/OM65ncK17hlngpskYldOcmfTVRqKHAJFFtKc7N1kEv+EBxPxaZNQr00Ecfggx/8q+Utc3TCSBS6dyPdPs/x9746cbApRtonoxHbBxObOiwWwUoiFhLj3ULE7H60fsDloaQqVP7Er/QjviuEbSpn6/jvopImWw5vRoBV0PS9Umj4FGzho7XFMSGLLwDEtJuTG3N1zxaxOEx1opVi7IGHwC4lbwFB869qTaGaxm9HHsTs11FGypyUneEEyh2YiHUUxUGagWv/aD/oi7mH3wRFRYRLqYrYVq6utRBnv2X5DxOowMW+e/EFhTcwIoRQ2kfIXOo1TLtQ9ZsLarnbz2lnd2qV//ipv/QDb5HA4nLh+k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e4ae77c-402e-4da7-9c8a-08dc7eae34aa
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 00:36:25.3805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 98meQNBRclPEnlvnzA6359Ix8lGoPir2YJAwgfFD6kmENEG/EOSEJ7TWK3rQbn/Knd94cgd3nSwsTM91coo8sF+vSG1s3XEDHpQP2Mq/PmE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7177
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-27_06,2024-05-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=963 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405280003
X-Proofpoint-GUID: K61TMizPoC3S0Ti_SYsMJsUB7gsJHRV4
X-Proofpoint-ORIG-GUID: K61TMizPoC3S0Ti_SYsMJsUB7gsJHRV4

Define TIF_NEED_RESCHED_LAZY which, with TIF_NEED_RESCHED provides the
scheduler with two kinds of rescheduling intent: TIF_NEED_RESCHED,
for the usual rescheduling at the next safe preemption point;
TIF_NEED_RESCHED_LAZY expressing an intent to reschedule at some
time in the future while allowing the current task to run to
completion.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Originally-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/lkml/87jzshhexi.ffs@tglx/
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/x86/Kconfig                   | 1 +
 arch/x86/include/asm/thread_info.h | 6 ++++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 928820e61cb5..5cd83b12f6fd 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -277,6 +277,7 @@ config X86
 	select HAVE_STATIC_CALL
 	select HAVE_STATIC_CALL_INLINE		if HAVE_OBJTOOL
 	select HAVE_PREEMPT_DYNAMIC_CALL
+	select HAVE_PREEMPT_AUTO
 	select HAVE_RSEQ
 	select HAVE_RUST			if X86_64
 	select HAVE_SYSCALL_TRACEPOINTS
diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index 12da7dfd5ef1..6862bbbb98ab 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -87,8 +87,9 @@ struct thread_info {
 #define TIF_NOTIFY_RESUME	1	/* callback before returning to user */
 #define TIF_SIGPENDING		2	/* signal pending */
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
-#define TIF_SINGLESTEP		4	/* reenable singlestep on user return*/
-#define TIF_SSBD		5	/* Speculative store bypass disable */
+#define TIF_NEED_RESCHED_LAZY	4	/* Lazy rescheduling */
+#define TIF_SINGLESTEP		5	/* reenable singlestep on user return*/
+#define TIF_SSBD		6	/* Speculative store bypass disable */
 #define TIF_SPEC_IB		9	/* Indirect branch speculation mitigation */
 #define TIF_SPEC_L1D_FLUSH	10	/* Flush L1D on mm switches (processes) */
 #define TIF_USER_RETURN_NOTIFY	11	/* notify kernel of userspace return */
@@ -110,6 +111,7 @@ struct thread_info {
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
+#define _TIF_NEED_RESCHED_LAZY	(1 << TIF_NEED_RESCHED_LAZY)
 #define _TIF_SINGLESTEP		(1 << TIF_SINGLESTEP)
 #define _TIF_SSBD		(1 << TIF_SSBD)
 #define _TIF_SPEC_IB		(1 << TIF_SPEC_IB)
-- 
2.31.1


