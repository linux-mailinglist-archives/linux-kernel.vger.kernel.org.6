Return-Path: <linux-kernel+bounces-195144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD328D4826
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 11:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6784280EB8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 09:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D5F183993;
	Thu, 30 May 2024 09:08:52 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A189183989
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 09:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717060131; cv=fail; b=TIQO+ldnxgtSf6z1TiaaqAWXLX9O9g3WNobVDJYpIdRb+SdT1/SNMfZx82pm7x70ptfUeu/5bkYVobBRIWRpkpo1xKJzWWSu9VK1pkkttNqx1/5KOv75AvmUdPAPk5bLG32AoY1bZHQ18eVAJa3X5fPFiAAznfqk3L7hUYmzj8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717060131; c=relaxed/simple;
	bh=Id7f2DNpLlKcdc6YT8qaTpS5ZHj10wgWSgvrQE4Det8=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=moxOy1wSmSs+lAl9HsaHCH+m3jqnLjl36KHdEdXheHQRW8QKDwqR+UtHwEalxCSxFl8dR7jrY+cBsL3/0wLpTLxOgL6AGCJ3TfikFwYIa9OXo5Rhj4ExUjDQaOw6/F6kqByWWfxXUHFbBem1DisCDyc5HN0P26WXxov+GIMu2LU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44U7mrWk019731;
	Thu, 30 May 2024 09:08:30 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-type:date:from:in-reply-to:message-id:mime-versio?=
 =?UTF-8?Q?n:references:subject:to;_s=3Dcorp-2023-11-20;_bh=3DckmchwEBnbmX?=
 =?UTF-8?Q?4e4mHbJCHEP8r4wKRMaH3YMeZzbxy4I=3D;_b=3Dco+jIqCIZlwyLN4YNCsWYsb?=
 =?UTF-8?Q?jCDzEoBfUmxSdiM62S7qnLYDmmT3C/VcSkkvNaE7Oa885_HjevtHLvVF0GpLXPS?=
 =?UTF-8?Q?g/kv7XnXNa2HHaZzIJgM05ugP8dv6K0LqWjfNXE24rY1YLx99zT_yiFcOwv62BX?=
 =?UTF-8?Q?7w4vFEXRSqhvpP4XPa9xmrxkarLpBS3ndx/FUu8/uT+nTJCc7VkIiAXah_/SkP6?=
 =?UTF-8?Q?0Y/uYWvGWmdTK6DjtKsFhA3dhUDnb5YUvqVe12ngT0WPTksyJrSPNwJa5np6qQB?=
 =?UTF-8?Q?_x2fAXfehh+g+0Sn+5ZvckgWqCwHAXEHPPTPRe36nI56Tr9sC80lnQfui7NWjS2?=
 =?UTF-8?Q?NkPuJb_xQ=3D=3D_?=
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8g9rmq8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 May 2024 09:08:30 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44U7QRee026610;
	Thu, 30 May 2024 09:08:29 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yc5089v8c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 May 2024 09:08:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R+EMO3t2gJxYJoXtngvr23alVwwm0plwx3EcdGHuwST4rsmsXUw9v7a5XRrHbkUungQqWwsugN+nGqFSe/JY74EOznOB1e2MV9f0C43XlEnGaSa37L9GCMU9tOsmBxfUjbx1UjcXSGWmzesw+TpTkfQ6CAnZtRebU37kRRYVShQ0EoCq3uHxiSwlVRRGXXgQOAKxXwNBmfpiH+rbky77wsCYej7SAlk3to2QJVsbDT7S+n0pKaI8EpsXYF2/TZtBdYtx2Z2JW6Vl2/6G7soatHAmQ4u5qnFjxCjKiolVyVp8UggBkOFHkmXnTTKmszN/L9qJpC7rdJ0q3PYSz4zoiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ckmchwEBnbmX4e4mHbJCHEP8r4wKRMaH3YMeZzbxy4I=;
 b=YTtycXYJ7jWwqQwXhj0fexWTgzuMzezzS/giWN8UUJHKr2N6A7if4IU2H8oHqP2iWkck9p4APiIFmjQFWwte/UmVJFozYAonpYvPjepgp6LCdtok2W5gVxVoyBo4U0WczzgGcEXHRlOKbV+B21HDpBECInAxPSV030JjLtdjSISkEq6iEB1razsesY6GcW/7mMSdtzNFjkulfcCAtonWNr98eUGHB1xMJ54nCCWe/l0Ie8Tvf4hH0iMaYS7Sx86t3GSQvgJNvNVOZSgycbg0Wj5V8EmusBJ981wLu0WF+XUg7ViCoc2HU5qk9t1X6DItUJV6dlz57I49WnZfuQAJlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ckmchwEBnbmX4e4mHbJCHEP8r4wKRMaH3YMeZzbxy4I=;
 b=scpIB87Bkm2xZuCO7KhIXcDGVVMb8AvR7ye5QaUMIqRqDt3lPGHNm0FsAHVAzGjYPht05PRrQogaITEYXDBmFgwORE/7OwNGIBk144TDvIpaqD2TnT6xJto5eIc1knSXCwtJ/EqnvQbZMxgc/4/AUmFc4ZkT90hbC2HX/r1SHH0=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by IA1PR10MB5898.namprd10.prod.outlook.com (2603:10b6:208:3d6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Thu, 30 May
 2024 09:08:26 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%4]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 09:08:26 +0000
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
 <20240528003521.979836-8-ankur.a.arora@oracle.com>
 <20240529082530.GJ26599@noisy.programming.kicks-ass.net>
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
In-reply-to: <20240529082530.GJ26599@noisy.programming.kicks-ass.net>
Date: Thu, 30 May 2024 02:08:19 -0700
Message-ID: <877cfb7jlo.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0164.namprd04.prod.outlook.com
 (2603:10b6:303:85::19) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|IA1PR10MB5898:EE_
X-MS-Office365-Filtering-Correlation-Id: 59b5f586-d96a-404e-cba3-08dc808810a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?A+YQSmSMHOJoDVEQFcWqvIjpXQb+kJFOktEYW8JRgVlplm2usexXl2JxVBa1?=
 =?us-ascii?Q?N8Fc2fwmJq4UnZlxwILmqSpUUgeOwEx6QFaKKYlI3E7cXj2cjduEq7Pi3LW/?=
 =?us-ascii?Q?pJgZp/Ngr+RQ1P3uS4rsLLvHgPt8oiWb433eznnU8fREbbAW1GGcg3764tcK?=
 =?us-ascii?Q?4NajCuSncw20KGXKR8TBzp0D+Ph8IXZOkEcU44Fnp9ny03mMGBLoBxhB96Zg?=
 =?us-ascii?Q?AJZvz7tR0emRiIGf34GT0GNSOUZNWT4ApqHLruQsgU6USSMgMw3j1Do0qzPf?=
 =?us-ascii?Q?YdsBFWL05R5C1CFvW2YdKBX6DP+K+oHBl2xMnnmn50Wx7GarDScZlz0eYZWn?=
 =?us-ascii?Q?qkDMLR2wXhbTAu0aAwxzqtRDbW/0aAG2EOh60dZRZQfs/qDzu5gXwwAvJ3it?=
 =?us-ascii?Q?eVoTO7D+CE3aEWe7euIzo1v6Dcvg48K771ucpA6+ZORam0taU1y9UccE9vs3?=
 =?us-ascii?Q?rro4FpO3ULPjsMB4AMLO2wC1gO5pqQ3QmUY7tYqLlFO/PFZNBfT4TJhwxiSj?=
 =?us-ascii?Q?c9aQ316h7EB+3v6fth8JCRggEigzPWydnp6S8AWX13cRvEJJFgF129UJX7dy?=
 =?us-ascii?Q?UN6Xa2xqKR/VEuQuiqYTzwsOFpY8CVlMz7cEjblXbQclZS3hRjSTEgnVt/hZ?=
 =?us-ascii?Q?IZLM3D/+UZHOsbfHeeNtvxm+4dG55DJRvnw+QpcAHQa5iDhSlOk7zmGhA2h0?=
 =?us-ascii?Q?1ZKsn5ryZAleFqFY89NuVBluLDjeAuuTKEW0yPsRq5WNymQ7pH3l6T2wyuD6?=
 =?us-ascii?Q?hvdpkBaRn+EwwivYGAZ4TqJVrExNH/PNVWRWyQQ+ghk7iwKm/+UxdpBaQEO1?=
 =?us-ascii?Q?IpeUBa8aTNlG+cT/xfhdc1zfu5i1U0zJZuYcBZd2PwmlRGPjo0jGBEqFOMY7?=
 =?us-ascii?Q?C+MOy1JM+j7lKFg+Zv8kVijIN6qP/LyDdYtX7dV9RTUXJx/RPHZZw81wG3C7?=
 =?us-ascii?Q?FsWGqECYsUM9HK9E2kW/TrvkkypzqK1ZM6JOJ6d98N4pzaSDRgiHwMAk61/D?=
 =?us-ascii?Q?S4xdfxsjjCayceb7FAt4RQtQY4/Qwuj3QOwCcgVcHN3Tgsv+hDeKsffUAqMK?=
 =?us-ascii?Q?6+EoQAD6aSdew+HZfFlp4dvYBUvZeoH154vKbGiCLAXZ8kQoIbhdOFFViNJw?=
 =?us-ascii?Q?COXuWGRZuM47OyGpw4dkVBsoOTN4AUsMHF5aCYMnBh2D7m5xalTC3i6fK/ub?=
 =?us-ascii?Q?HD6wagq3/0b6m4tioZfWF+NvfDxU4hOVhoRAiCtppGjxTe8cZeD3/mT0h/Dt?=
 =?us-ascii?Q?CDxHtLKTDqaqnZ8Gp2T8Wq2kNTNeTs7Zfybo1Fjmkw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Co9kMIghd2NFNjTWOoYzLNpd87RY5dUVgJE1zFlhD/yOnq3pitmyLi4dmmTV?=
 =?us-ascii?Q?HqcVyU4rV1eps4SFfEM8mwQnBQOWK+8xNVS34AKJGsukBfiQS4XT2FU7QXws?=
 =?us-ascii?Q?+TBHYjqDZd6IuRI4fxUcWSVDYnpH1zpSxGzlpB9hy/oRL7slZGZT1AEYQ1ys?=
 =?us-ascii?Q?p0YuKt3B4XOQjLG7Tu9ot/LLRBXweqKpDNHU0F/1n3CiABmrmY5+sIUjVJ6W?=
 =?us-ascii?Q?xk5hqDMKWKzzaiFktPkEt7/9tQnZZ/ZycHQeinptTJLURBgUkYD1FzXPx4FQ?=
 =?us-ascii?Q?Ou2qFJDmM3xg+cjzelQNgzjgGc1rTkKicHCRNzBpjJWb8GSfOZgi3jhDDYC7?=
 =?us-ascii?Q?37pY38TYULflgl6zMRhw+1lbJdV270hgJRA9N2W+j3LQkv17+mrAuXjq2Mbu?=
 =?us-ascii?Q?SPH2W+ZRpfjyvij8EnycKCMKJunKP7LepBo3XareCpS+fhmp9YkSdlFUOHn0?=
 =?us-ascii?Q?PFq6gzf4EokLznXOOO3UaFausJ50sd4fBptqMiXt7UZmMQLHHaWPvU8gF9A3?=
 =?us-ascii?Q?me6gFhLezuYaIgeMoN2koMu77PglxrURWzrfx/iRJLDSfUjcVCoh7XjvlU/Y?=
 =?us-ascii?Q?it46HtNACGHX5pd8rNqwECzr8GwnuZMKHGUG6Ncwb5GRYLtImuQuBbhqKlR+?=
 =?us-ascii?Q?yZKxEig503z4LvEZWc7aqVEgrCMxdZFGFARBddB2iG8cPvXwRKYp/iZmTglZ?=
 =?us-ascii?Q?krEuQYDjup49LbYJmqEHo866ejB0eX9/3hdzsV4ou3GQLDwZecvbLPeutsw3?=
 =?us-ascii?Q?NXxmdVFb/oQTmMXacmwSjBgNQ8wAN1z0REE7jirAVNMPtt/uyN1NslRKCR/0?=
 =?us-ascii?Q?LJ0nhKhNscVoh0jAvjumk+OWiDpsE03qlC4phbujsP0gfUc3SP9eHW+6Nvod?=
 =?us-ascii?Q?s6NnhvS/WLm9RNcn+8NZhBOrSjst9Up1ANOsuwmkhtBhnWDX+DlMCsFsy/+G?=
 =?us-ascii?Q?UXXgJVpoNl3oitLI70eqwyTKgIoWYCxczpoUktB6ZChvwMATs5x6WP3ubq5b?=
 =?us-ascii?Q?9dwEShJPLy3Y/Z0t0FREN7U+nkck1zHFAkfC44A7fNgsm1ovBqopryoXD1Yo?=
 =?us-ascii?Q?ePoGlE8liKZLoOA4luLaOQaEHLz0HosgAxGnm4yXBqKFJM4lEoG0ND0YsigK?=
 =?us-ascii?Q?kake9EZK4/vqzde+Q3+aoYE9Zfascn4AhhxeBLcjflCfPot2fc3ElhAtvjeJ?=
 =?us-ascii?Q?TF6bxjatrRuPZ3qZ4uDpLFz4nEUgBVid4iHKzaMSUtgPbhjjPi9klp9rCQPp?=
 =?us-ascii?Q?M3P2wUw13Mdcpiqvo8W3cDHvM4qpO2Gf5PFswSjTyQ5HxOdz7nTitDvxiEFL?=
 =?us-ascii?Q?Bngan9FbHOLDwge4DwowgG5MN5ltbj8HMNDqD7SN+ZOS5Aw9xvaY519Ol+qM?=
 =?us-ascii?Q?DJ3Vgt2R8zsD+x5AVxxreuZadZlNXuwCHr38PlgzM80qSWjB2ZJHpTUm6KBG?=
 =?us-ascii?Q?z8xhHK1H1rj2pqi7tgW6o9WwrGEWU8l9DfR8zh0RS6fOGYERo6lCkseVu7ux?=
 =?us-ascii?Q?KNodN+/H8KpODCTpY0zgZ3O0VyF/zf14s8OOlIKJzyT1yz9eLqkzX6Vqp6Of?=
 =?us-ascii?Q?Gjy/iOPA3VVdoJu1A8HdqDQEsIFL9221dJ3PKFFQ3OMWVPatg6S5qeJaIfQQ?=
 =?us-ascii?Q?fQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	aUhcpTA/NYuoizExeJiRhfa0hEQgcBJRouhQFFIj5ZmGrNeiTac3Lqt8CQZvg0bMQ/EzD1CBJVUL5EXvmoSOMwYaasVNjRK23JFxdcILdHFToQiCQwCsqdIZ3CYpHOB3Wlb5dShQ72Ab6GyKzsKAGGz3NFM+z+Y9K2BcbQ1nEpMYI5S1SxEUqUYTWQshtKDHwBt2AKmpPgF1Rq3HLXZiCo3V49pscx8BUmNgV5j2Ywj0d/TbKsIDMEq2/IMcQ7vDDIpukDGyS1yXFxxkumLjDUiI9Ko7/WWXNsJRWtpFBJ6+/SjmFAfWBvn5gY6ZEnggylWV+eypPnwiE3u+52r5JK0yuU5EFbcm9UWltPGWF75Se5/2PUyOAa8bpdg4ID3JTaXftQRLJQ6+3txq8VG+OnP3RHQXBakhlGgcgi8ostT+OgUcHmXbAiPfZUfp2HhweLewsETCBZr6b258uTXQ+UyQhmNhXAXJrqS8zzv+2cChIiZUgApX7BP86JBpyWvZBa7QzjqgUYFsAHW8M+2kO/zjUVEAMAM9aWZy2qZbrMZZDFX8tslNldLU0qIkMTX28d2I3WwhHl2wFdrxDnYpVWyvbX7FgsmK89gN9TgiOwg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59b5f586-d96a-404e-cba3-08dc808810a5
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 09:08:26.7731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e0bXCJydeeCNpIBiGPnHnbdbbmnA978bRZ5otdHACtgO1cs+gFUrUaarQNTn0X23AGTLuQ6NTkgMEx65Siqb4mbPjifY4kR5qMgiDM4Jvt4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5898
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_06,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=716 mlxscore=0 adultscore=0
 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405300067
X-Proofpoint-GUID: POsN1k_qymhbHXdUVchH7mjNcAVCh7t_
X-Proofpoint-ORIG-GUID: POsN1k_qymhbHXdUVchH7mjNcAVCh7t_


Peter Zijlstra <peterz@infradead.org> writes:

> On Mon, May 27, 2024 at 05:34:53PM -0700, Ankur Arora wrote:
>
>>  static inline void clear_tsk_need_resched(struct task_struct *tsk)
>>  {
>> -	clear_tsk_thread_flag(tsk,TIF_NEED_RESCHED);
>> +	clear_tsk_thread_flag(tsk, tif_resched(RESCHED_NOW));
>> +
>> +	if (IS_ENABLED(CONFIG_PREEMPT_AUTO))
>> +		clear_tsk_thread_flag(tsk, tif_resched(RESCHED_LAZY));
>> +}
>
> (using tif_resched() here is really uncalled for)
>
> So this will generate rather sub-optimal code, namely 2 atomics that
> really should be one.
>
> Ideally we'd write this something like:
>
> 	unsigned long mask = _TIF_NEED_RESCHED;
> 	if (IS_ENABLED(CONFIG_PREEMPT_AUTO))
> 		mask |= _TIF_NEED_RESCHED_LAZY;
>
> 	atomic_long_andnot(mask, (atomic_long_t *)task_thread_info(tsk)->flags);
>
> Which will clear both bits with a single atomic.

Much better. Will fix.

--
ankur

