Return-Path: <linux-kernel+bounces-195132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DBD8D4805
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 11:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67BE11C2408C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 09:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31C618396E;
	Thu, 30 May 2024 09:03:46 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7F2183960
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 09:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717059825; cv=fail; b=MDYmoObcB7qlE1WUZ+zyamut5jNHAkQGYkymZqSGGeWO+NSbx/vEK4gRtFT9KHtcoeaXNEqywaeVWKcSLV08Kq1Isbz8QNDAB4piWufh/77iMF3+Qa1bVMWKZzCisrnSGJ0FdGx2Tb9lZ7a6FMYAmLVBvn+0F3A/5qr1xbjlmlg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717059825; c=relaxed/simple;
	bh=0XAlZKjvVi5dDqtor2/ke9E4eEE99rL5Js7tE+nDWWA=;
	h=References:From:To:Cc:Subject:In-reply-to:Message-ID:Date:
	 Content-Type:MIME-Version; b=JTB6EmubECX1TEhrAK68GsD/R9ySwbYDXkSb/fb0uGVRQ1rD4Ov9OYUWSKB0iGtDo+fG+OoQYTOnqaKCEVUSPrIy372gUJHll1PUyglm1hHbjGfmBiVot87P8VW6zfN2ukrYVVGCzUe7XlveDuLe0XJ2rCNeaZD3Drz8oYjvejc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44U7nLWs006321;
	Thu, 30 May 2024 09:03:09 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-type:date:from:in-reply-to:message-id:mime-versio?=
 =?UTF-8?Q?n:references:subject:to;_s=3Dcorp-2023-11-20;_bh=3D8kcTCukif6su?=
 =?UTF-8?Q?rdtmK+doukoufMK4K5S8XUChyRHeXuI=3D;_b=3DIXeAi6NnBNheZPjHSymBHqB?=
 =?UTF-8?Q?xG4xI/dfpmjOzGoZv7/NCUkfmh70MJ1f3dHQOZWEb8hQ6_02PAv6GBSv6HfYaqm?=
 =?UTF-8?Q?krewKmCfqBfLENWzsOjavZuE9N2mHiqtDBuvE3Yy6OGLHnZgp56_fbTQpi/DkUm?=
 =?UTF-8?Q?Re8OX9d0q5SGl/jI+pV9Ufg/CwlXLqWaQxQf8twxICqVgoRI4CrnW2q9B_Yp3EW?=
 =?UTF-8?Q?guIKPc72UnKBmN+ip4K9jfD8qglpJPKvkrwGNvzxQmLBASJ9CwqDl2cER0sGf7+?=
 =?UTF-8?Q?_mT0MZJqPpG5Pu+pdRwhuL5+lhx06HI38eVlpdh4iDsfd1KdDKu5u/WJ7VIGLVF?=
 =?UTF-8?Q?8ANg5a_Yw=3D=3D_?=
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8p7rdur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 May 2024 09:03:08 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44U7JQmk014942;
	Thu, 30 May 2024 09:03:07 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yc537ur8p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 May 2024 09:03:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JtqMrvUUzAYHqbpxoVQU58yo5bgaLVAOjL+sOCWO/GVcHR2FhnapTxoEbxRk7lh6NUyanlpoioITtfYUN9J2CuiwlTT+2iZC59pWoDczBwN3EWf1QlT8V9BkG/BEU2TwsUcYiybuMmNvwXLOUiJXzgy63udBpoeVK5nQnIH6w4teFAjdLvMuS1Uyw5nhkvcwp5s6AOAubBUXK76Hui8jK2T9rwhyqE8YgCblGx+9MuGk4VVcEGdiQs5GNZYT4zIYDLX1pZE0i916XmeOMZ4ZrJ3/MtdlYajBXx0XnSKexAV0+gTzLtxVss6wAddg/Lfk9KpmDcVv/Vnw9Fc3eBQfUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8kcTCukif6surdtmK+doukoufMK4K5S8XUChyRHeXuI=;
 b=IUdGirunUTVk+sDYzwCc8perb+tLlkIjGgFqbr1FvlYHT3shPZQtwPhIyGDCbCJWevjlH7jg1RaLtd/j+sFBNzG7PD6dkH7RXXbFb75T+Af1w9xja9mdbML6IJkQGFHoVDeFlMXL4DAUvRqsZnT8F62maB6wxiOFSAeQVJsyYUKfUiIG/9695Pg10p27Y5W1EHxM9/V+9F9NlMLTj7pmU2oOoNramRHtmLWF3yNM1LwaLNJaGA6spOgeZFV151MdS/xVCxwv6JS2oXKVFgXlAJ81hIWgPUF4OyGTZ5nHVgWAMnAsSlY6+bkSkC0LXxo9IQGC9vnOVw+u/o1t+cI5Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8kcTCukif6surdtmK+doukoufMK4K5S8XUChyRHeXuI=;
 b=Zn+qsfSJrMMTQfBuOnSkufgwTQDv7OozdAb8mdtzVJszdMGvpJ7usKFdG5FjV35DnVO4/2Z3PS4+KOylhNmLQuoT3fK61uBPXjxdNC4PNQPEnxoP4v+WKakm9AvEzo3HvqeiS9OeQC685bQymZmihAHqt3KR/mCsjRLNyXssTqo=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SN4PR10MB5656.namprd10.prod.outlook.com (2603:10b6:806:20f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 30 May
 2024 09:03:04 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%4]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 09:03:04 +0000
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
 <20240528003521.979836-8-ankur.a.arora@oracle.com>
 <20240528160905.GC26599@noisy.programming.kicks-ass.net>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, torvalds@linux-foundation.org, paulmck@kernel.org,
        rostedt@goodmis.org, mark.rutland@arm.com, juri.lelli@redhat.com,
        joel@joelfernandes.org, raghavendra.kt@amd.com, sshegde@linux.ibm.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Ingo Molnar
 <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v2 07/35] sched: define *_tsk_need_resched_lazy() helpers
In-reply-to: <20240528160905.GC26599@noisy.programming.kicks-ass.net>
Message-ID: <87r0dj7jun.fsf@oracle.com>
Date: Thu, 30 May 2024 02:02:56 -0700
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0071.namprd04.prod.outlook.com
 (2603:10b6:303:6b::16) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SN4PR10MB5656:EE_
X-MS-Office365-Filtering-Correlation-Id: 53e19009-49e9-4c99-c810-08dc80875081
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|366007|376005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?hBX2xyzQ5Jlk5Y5ZPOkEi0dfdpLYWlVt/SdrX5dZr96Rf8um/LVNiEpKNimV?=
 =?us-ascii?Q?O0fkeTHVlaYNuNe71E/aLdArT9IejFVgebUG1HxIL6q0YkcTLstJ5m0Aqxsl?=
 =?us-ascii?Q?NtPJChEv79DjXoeN7cfVN6kLZaF1+WgO3+fEorwxp810lVm/nysuSXkKHVR+?=
 =?us-ascii?Q?/YDxB5LwW2HgncB3hknjlWXFnCvwKrn/PhDxHRQ8r2+HW+M6H+dM65PnGFZI?=
 =?us-ascii?Q?n27Mnl150bhfPhxyhz4SWsgslAflpCsKPFG0bsU+us6SFo8CRkExyjaBLloZ?=
 =?us-ascii?Q?1L+gG/7cNm7+P407VMXW8FpOD+UUzixJwi+dudKJJR1DnP/YnoslqHpyoSw8?=
 =?us-ascii?Q?j1AefIeNhz+gt8Yvvvhs2gpvtxG0osqP3yVqxLe5RUpF9sfMivjM04/m+dA4?=
 =?us-ascii?Q?5kNIk0094CVc3E6Dsn9Ayu/c3FTs9tAszZJ4b02/Ne7AhWsksdF68BR9g4EZ?=
 =?us-ascii?Q?870YPx4omrZ72oIOs7gup6N/CrOilRK2WL2WUtEi0moS1CkWwhd7xkmfNRE4?=
 =?us-ascii?Q?Yo0bcPRF9adkS5KvX5Ez973dmWBdTaHubmYou3JSO3MIdxTBAMir65jC6dRc?=
 =?us-ascii?Q?muBeF8LGgViEJFxmNVH1c1sP/ZYxFhaAnNERZE8sdGY8PRVHIKpJd9jmSjv8?=
 =?us-ascii?Q?Uf8S1jSQRTX9o/z1hvrNTuwFgtDjC/Zh4R2BJFTF2scCvPdJidihtPiutLRu?=
 =?us-ascii?Q?DhUfu2sF65G8MfXGo0BE35jTKvUo98+oEEjSsTo4zfV+pyoJH6KVLaBsqBq8?=
 =?us-ascii?Q?9S/1i3heQHj5Upwaze6hsxkbKUWxFa1HXY2FOAaKuV58UCFNd6rk3lYCk8t/?=
 =?us-ascii?Q?cN7BXQ+YRYjOaY81TBQIA1dBkQO46y+PSUx83vVh0nF9E5tVQp8XycI1fTsA?=
 =?us-ascii?Q?UxLDZ7LoZAiXFsh5t7arySSpN0B9z8md/L28J+m+CrwHy3leEiVglAbqJv7j?=
 =?us-ascii?Q?jg6pD5haoDJchrBoAOv9nNvI5VRZssXxb6aV6AJyfMHwmzDnhpB5AYY/5QGo?=
 =?us-ascii?Q?jft3yj9iRnsZVKsQ14MtZ/aAhLZCNr2Ckk6omI45T4x1ilRRqhDicoZiQZ0n?=
 =?us-ascii?Q?u73I/SM2Nj3D19eP16jsTs7ouRBKCmGgrAWkOKCwO+U+Y3O2dWYmYZql80JN?=
 =?us-ascii?Q?BkEnT794bVy7McPuyTMowfq058KWX++4alufMroKXpmq10C6gfOtCYcTIoYF?=
 =?us-ascii?Q?q8V5ApcH/+mWjYT1x9bpiQpzFFIotzcN9VaYuEwgC8S1MFO66dzUXrWRf+g?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?onasb8tjTlTjpqgxr0V6xTXw3xHSUdvQ6ER5bv/EC8mhkkBawSghb0K2jkSI?=
 =?us-ascii?Q?kpKBqRzot9LRxYcsJAmV9F9f9gGCtnbLAyIj8zu3aslDuvDSNJaT+5cYVoMx?=
 =?us-ascii?Q?MzmlFfcT9CK0GRuUj19K/hvKqObQZ3uRwyP9UZXhKN4aVz80m15uTIHpUh+1?=
 =?us-ascii?Q?7EtFWMKvpmoafZ8ghgr2QKzXjUYLa2y9CzyTFhfoOvVMJaYPz6fjHvOczW/1?=
 =?us-ascii?Q?v9HhcxaYhjw114mWuD8pzfSBzawl2C2j4pJcuzIpWMtixaP2DH2dZ4acGKRl?=
 =?us-ascii?Q?EWkJdniQXThYpDfn3cwLrziPTIOgDkSOrWVaf4bDPWcGHrFbt8+21vblV4GU?=
 =?us-ascii?Q?mS4NUJscHzMuaIf6bLzdKhCGuWS1iZee6Svm3oqXMV67YYF37TIjMg0XI7Tr?=
 =?us-ascii?Q?hriOlGbPalrNxF8vkhqC439N1njHGtiKfdcSkXSeqUOSvCOa/T5WFxSL+YqD?=
 =?us-ascii?Q?djozR8LTXfe0GHP9gYlHmec8LcBwJnkHt5nebVg4j7oWfJ04yqJjqvIk30Gw?=
 =?us-ascii?Q?+Daedkhesk2uumoFQICooapv/ySlZ3GeFWKji1FqtykYd55ltj9XfERBLXPw?=
 =?us-ascii?Q?TGrRPaHiXReWRB6DgF+Z2isFlKmVlGUQBONLddD/TMz+c50Oc21VyoLL/wOE?=
 =?us-ascii?Q?Ln/HJdskMwnSIcRDRh3fCGy+8eHAKeBIJOyOV8E+3FkxIOL2mBEZqDZGmXJN?=
 =?us-ascii?Q?ZlY73PsH3ErddG1aKGkFopyuVuSi2nQhuETK2Oa31uIML1YuGaR5zAWi+Nk3?=
 =?us-ascii?Q?/zLx4nVtAojwboXPC8s1F3W0mpapBy0/vE/UnzyRK4F/0fDTe5y+vuVkw4kh?=
 =?us-ascii?Q?rw1fNiDbetrnsye8LI3jKUEwiDlhsXXSzoVnw036bOu0Q97wPFj7we0G0u1H?=
 =?us-ascii?Q?ARqPE9jaWPG9Ag/aEg2FUlXIfEHSZtpkY4aS5zlfcZmgDFBXy8M7tJZqQDfS?=
 =?us-ascii?Q?4XX9W3znP1WLcX7ZlJUGpliPIWbidl7Hbfxr5i5lVlfowlRS7YlMxtSwPuyC?=
 =?us-ascii?Q?Qz2ftd08mf+dKxw2sYhRtPQH7JjYQQ/MLov+wyAQR6Zk80Fb1PgmEqnERPK6?=
 =?us-ascii?Q?kQzCdOA/5X9M9OFuE/wEZl33fzj92oTDOCBr8z3AO+lMspd8yC0JZwUDIuHN?=
 =?us-ascii?Q?rQoF0Ol0KuGfBjv5i2OpHjoFJQrWGrk11dFMlqCp3qtumuX/DgI/zhbDE+K5?=
 =?us-ascii?Q?npukT+pdi7MMKMtC7xOIXTpQP5gVGkmpJOcM5rWhhcb3QkiU/aEq7VqZD+4D?=
 =?us-ascii?Q?BZPED8GsMXJz13U61tUeGXgkO0DHXsEcC8cX7Rf+f7FviupKO0gIumcbh31j?=
 =?us-ascii?Q?HB7WXS/EXcEXrgNtj8641YyTVohOjGWS3fMNgA/vRgmknvNog7yb2ONlhD8U?=
 =?us-ascii?Q?mV0B1bA81VxPDEFFdI5wbB/I6rlU1fMRzXJcxDTPwu0CK0qONVPQtkbcVn20?=
 =?us-ascii?Q?BkLC6yNylCLpwqZTVG+5SOC3gAWPQ1N8Kug9xdHUczAHK8IyZzkBXzU0gRjX?=
 =?us-ascii?Q?ixdb2z+G+NzgvZsp4KhNX0tr4+YyYeKlpzP4yxbZufMAXNhmBPi1fOFFT8ne?=
 =?us-ascii?Q?bBmY8spn+wh+kd9Ll4stQNrMYk85hsTo71y7AgHe2+HPbAmsP4ofqluzzmTs?=
 =?us-ascii?Q?Tw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Dk6KIPiWCyIZ4NtCNCE95bQYHgMqS25Vis5te2nj3xtL5z99hkysAxPezLUyIz1IsHZE3Zc46XVyl+Imusqt6276XZwsJBgBLZfb5OkMBbT+61lpcwFZnYEf0hCRG/KO61rQNXS7/eum7/gM7Im5T59Qqq6Rb79f9TERNBLiQeuADDcqwOhmVu3Kk0g1qmWujn74zLEXucW1bN9l0lLv49V444EjaCBTKfsUQURSWz76GTBWgp7/oG2cc2a4TS6SpFh/N8NpnxTSjwvAt/so5ptXau4PRRQmpUc2w9UzT4JmNqiDregtGq4ig/bKEivsc63CoOQUhR3361P98JPznLSG1SV7rt6n9Ter2Sw8ZkYjSE840DatYLDeXYMUJp1uszqFMFNxfOWxMh6zQENB8U3e4zYUZFn/zaKq/O7AzKbFBSNofXv+woWWjqgm1BmUFMBkCSASMvqB1FECdS6xZaz1tuMLoTylPYPoOyXxZS5TsRlVl5qAeBaguUEbbUI/48+XQuAn7lVzfJDbjN6MC7FTZTwEfIzrbc5IsNewZ7fWxIF2rFg6aP1daZnkWxvQgjND39LPnk9Q/DK6y3sM06YyCv9dCDk68m9YtKW6Y2I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53e19009-49e9-4c99-c810-08dc80875081
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 09:03:04.4440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zKzneRqF6GWzWVQai9kk4pbFZfNK8kQSxATDo7p9H3Z8Ulxg40Bcm7tA2GgrluYHHdFZn444Hv+A8pi3QR8LIA4j/b7v8sJXK1c1oG21AAA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5656
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_06,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405300067
X-Proofpoint-ORIG-GUID: F1KkMIfyb0aivMUHORtA4asTBL1AY51b
X-Proofpoint-GUID: F1KkMIfyb0aivMUHORtA4asTBL1AY51b


Peter Zijlstra <peterz@infradead.org> writes:

> On Mon, May 27, 2024 at 05:34:53PM -0700, Ankur Arora wrote:
>> Define __{set,test}_tsk_need_resched() to test for the immediacy of the
>> need-resched.
>>
>> The current helpers, {set,test}_tsk_need_resched(...) stay the same.
>>
>> In scheduler code, switch to the more explicit variants,
>> __set_tsk_need_resched(...), __test_tsk_need_resched(...).
>>
>> Note that clear_tsk_need_resched() is only used from __schedule()
>> to clear the flags before switching context. Now it clears all the
>> need-resched flags.
>>
>> Cc: Peter Ziljstra <peterz@infradead.org>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Juri Lelli <juri.lelli@redhat.com>
>> Cc: Vincent Guittot <vincent.guittot@linaro.org>
>> Cc: Paul E. McKenney <paulmck@kernel.org>
>> Originally-by: Thomas Gleixner <tglx@linutronix.de>
>> Link: https://lore.kernel.org/lkml/87jzshhexi.ffs@tglx/
>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>> ---
>>  include/linux/sched.h   | 45 +++++++++++++++++++++++++++++++++++++----
>>  kernel/sched/core.c     |  9 +++++----
>>  kernel/sched/deadline.c |  4 ++--
>>  kernel/sched/fair.c     |  2 +-
>>  kernel/sched/rt.c       |  4 ++--
>>  5 files changed, 51 insertions(+), 13 deletions(-)
>>
>> diff --git a/include/linux/sched.h b/include/linux/sched.h
>> index 37a51115b691..804a76e6f3c5 100644
>> --- a/include/linux/sched.h
>> +++ b/include/linux/sched.h
>> @@ -1952,19 +1952,56 @@ static inline bool test_tsk_thread_flag(struct task_struct *tsk, int flag)
>>  	return test_ti_thread_flag(task_thread_info(tsk), flag);
>>  }
>>
>> -static inline void set_tsk_need_resched(struct task_struct *tsk)
>> +/*
>> + * With !CONFIG_PREEMPT_AUTO, tif_resched(RESCHED_LAZY) reduces to
>> + * tif_resched(RESCHED_NOW). Add a check in the helpers below to ensure
>> + * we don't touch the tif_reshed(RESCHED_NOW) bit unnecessarily.
>> + */
>> +static inline void __set_tsk_need_resched(struct task_struct *tsk, resched_t rs)
>>  {
>> -	set_tsk_thread_flag(tsk,TIF_NEED_RESCHED);
>> +	if (IS_ENABLED(CONFIG_PREEMPT_AUTO) || rs == RESCHED_NOW)
>> +		set_tsk_thread_flag(tsk, tif_resched(rs));
>> +	else
>> +		/*
>> +		 * RESCHED_LAZY is only touched under CONFIG_PREEMPT_AUTO.
>> +		 */
>> +		BUG();
>>  }
>
> This straight up violates coding style and would require a dose of {}.
>
> 	if (!IS_ENABLED(CONFIG_PREEMPT_AUTO && rs == RESCHED_LAZY)
> 		BUG();
>
> 	set_tsk_thread_flag(tsk, tif_resched(rs));
>
> seems much saner to me.
>
>>  static inline void clear_tsk_need_resched(struct task_struct *tsk)
>>  {
>> -	clear_tsk_thread_flag(tsk,TIF_NEED_RESCHED);
>> +	clear_tsk_thread_flag(tsk, tif_resched(RESCHED_NOW));
>> +
>> +	if (IS_ENABLED(CONFIG_PREEMPT_AUTO))
>> +		clear_tsk_thread_flag(tsk, tif_resched(RESCHED_LAZY));
>> +}
>> +
>> +static inline bool __test_tsk_need_resched(struct task_struct *tsk, resched_t rs)
>> +{
>> +	if (IS_ENABLED(CONFIG_PREEMPT_AUTO) || rs == RESCHED_NOW)
>> +		return unlikely(test_tsk_thread_flag(tsk, tif_resched(rs)));
>> +	else
>> +		return false;
>>  }
>
> 	if (!IS_ENABLED(CONFIG_PREEMPT_AUTO) && rs == RESCHED_LAZY)
> 		return false;
>
> 	return unlikely(test_tsk_thread_flag(tsk, tif_resched(rs)));
>
>>
>>  static inline bool test_tsk_need_resched(struct task_struct *tsk)
>>  {
>> -	return unlikely(test_tsk_thread_flag(tsk,TIF_NEED_RESCHED));
>> +	return __test_tsk_need_resched(tsk, RESCHED_NOW);
>> +}
>> +
>> +static inline bool test_tsk_need_resched_lazy(struct task_struct *tsk)
>> +{
>> +	return __test_tsk_need_resched(tsk, RESCHED_LAZY);
>> +}
>> +
>> +static inline void set_tsk_need_resched(struct task_struct *tsk)
>> +{
>> +	return __set_tsk_need_resched(tsk, RESCHED_NOW);
>> +}
>> +
>> +static inline void set_tsk_need_resched_lazy(struct task_struct *tsk)
>> +{
>> +	return __set_tsk_need_resched(tsk, RESCHED_LAZY);
>>  }
>>
>>  /*
>
> So far so good, however:
>
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 7019a40457a6..d00d7b45303e 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -933,7 +933,7 @@ static bool set_nr_if_polling(struct task_struct *p)
>>  #else
>>  static inline bool set_nr_and_not_polling(struct task_struct *p)
>>  {
>> -	set_tsk_need_resched(p);
>> +	__set_tsk_need_resched(p, RESCHED_NOW);
>>  	return true;
>>  }
>>
>> @@ -1045,13 +1045,13 @@ void resched_curr(struct rq *rq)
>>
>>  	lockdep_assert_rq_held(rq);
>>
>> -	if (test_tsk_need_resched(curr))
>> +	if (__test_tsk_need_resched(curr, RESCHED_NOW))
>>  		return;
>>
>>  	cpu = cpu_of(rq);
>>
>>  	if (cpu == smp_processor_id()) {
>> -		set_tsk_need_resched(curr);
>> +		__set_tsk_need_resched(curr, RESCHED_NOW);
>>  		set_preempt_need_resched();
>>  		return;
>>  	}
>> @@ -2245,7 +2245,8 @@ void wakeup_preempt(struct rq *rq, struct task_struct *p, int flags)
>>  	 * A queue event has occurred, and we're going to schedule.  In
>>  	 * this case, we can save a useless back to back clock update.
>>  	 */
>> -	if (task_on_rq_queued(rq->curr) && test_tsk_need_resched(rq->curr))
>> +	if (task_on_rq_queued(rq->curr) &&
>> +	    __test_tsk_need_resched(rq->curr, RESCHED_NOW))
>>  		rq_clock_skip_update(rq);
>>  }
>>
>> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
>> index a04a436af8cc..d24d6bfee293 100644
>> --- a/kernel/sched/deadline.c
>> +++ b/kernel/sched/deadline.c
>> @@ -2035,7 +2035,7 @@ static void wakeup_preempt_dl(struct rq *rq, struct task_struct *p,
>>  	 * let us try to decide what's the best thing to do...
>>  	 */
>>  	if ((p->dl.deadline == rq->curr->dl.deadline) &&
>> -	    !test_tsk_need_resched(rq->curr))
>> +	    !__test_tsk_need_resched(rq->curr, RESCHED_NOW))
>>  		check_preempt_equal_dl(rq, p);
>>  #endif /* CONFIG_SMP */
>>  }
>> @@ -2564,7 +2564,7 @@ static void pull_dl_task(struct rq *this_rq)
>>  static void task_woken_dl(struct rq *rq, struct task_struct *p)
>>  {
>>  	if (!task_on_cpu(rq, p) &&
>> -	    !test_tsk_need_resched(rq->curr) &&
>> +	    !__test_tsk_need_resched(rq->curr, RESCHED_NOW) &&
>>  	    p->nr_cpus_allowed > 1 &&
>>  	    dl_task(rq->curr) &&
>>  	    (rq->curr->nr_cpus_allowed < 2 ||
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index c62805dbd608..c5171c247466 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -8316,7 +8316,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
>>  	 * prevents us from potentially nominating it as a false LAST_BUDDY
>>  	 * below.
>>  	 */
>> -	if (test_tsk_need_resched(curr))
>> +	if (__test_tsk_need_resched(curr, RESCHED_NOW))
>>  		return;
>>
>>  	/* Idle tasks are by definition preempted by non-idle tasks. */
>> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
>> index 3261b067b67e..f0a6c9bb890b 100644
>> --- a/kernel/sched/rt.c
>> +++ b/kernel/sched/rt.c
>> @@ -1680,7 +1680,7 @@ static void wakeup_preempt_rt(struct rq *rq, struct task_struct *p, int flags)
>>  	 * to move current somewhere else, making room for our non-migratable
>>  	 * task.
>>  	 */
>> -	if (p->prio == rq->curr->prio && !test_tsk_need_resched(rq->curr))
>> +	if (p->prio == rq->curr->prio && !__test_tsk_need_resched(rq->curr, RESCHED_NOW))
>>  		check_preempt_equal_prio(rq, p);
>>  #endif
>>  }
>> @@ -2415,7 +2415,7 @@ static void pull_rt_task(struct rq *this_rq)
>>  static void task_woken_rt(struct rq *rq, struct task_struct *p)
>>  {
>>  	bool need_to_push = !task_on_cpu(rq, p) &&
>> -			    !test_tsk_need_resched(rq->curr) &&
>> +			    !__test_tsk_need_resched(rq->curr, RESCHED_NOW) &&
>>  			    p->nr_cpus_allowed > 1 &&
>>  			    (dl_task(rq->curr) || rt_task(rq->curr)) &&
>>  			    (rq->curr->nr_cpus_allowed < 2 ||
>
> These are all NO-OPs.... Changelog says:
>
>> In scheduler code, switch to the more explicit variants,
>> __set_tsk_need_resched(...), __test_tsk_need_resched(...).
>
> But leaves me wondering *WHY* ?!?
>
> I can't help but feel this patch attempts to do 2 things and fails to
> justify at least one of them.

So, yes all of the scheduler changes are NOP. In later patches the
scheduler will care about specifying the specific type of resched_t
and so cannot use need_resched() or need_resched_lazy().

Changed that here to minimize the interface change noise later-on.

Does something like the following help justify why they should be here?

  In scheduler code, switch to the more explicit variants,
  __set_tsk_need_resched(...), __test_tsk_need_resched(...) as a
  preparatory step for PREEMPT_AUTO support.

Thanks for all the comments, btw.

--
ankur

