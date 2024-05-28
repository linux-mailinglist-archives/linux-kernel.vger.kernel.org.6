Return-Path: <linux-kernel+bounces-191545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 224748D10E8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 02:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 806BEB21590
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 00:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF2279F6;
	Tue, 28 May 2024 00:36:03 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0455E10E9
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 00:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716856562; cv=fail; b=Wp5R6MP1iueQhLjLyVCMt6yWxtt1E9m19RKsVNC0bvhmQ//YFoL82tVm/Vt/zL0giTKVJGVvuGlVbDNqyc1MraiQzQpJrQE/Uvg4LXZ9l7cyQrfkFR8KjvpqT+yPkICN1kp0or7grbc2MN7HTOtZlRrhpZ9Qw1BrVEGIB/+wZ94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716856562; c=relaxed/simple;
	bh=gPa8FuZDe/yUM5tbumYLCUhldtqTKILL20GuK0bO/gg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N+4IhT/7rSPlgcGXvOw3BIibGX3Ck7HqtsB62uYfqy6dpPgyjB8oQYdyqn9f86GQfBDmgExS7s915xVOlMCicDBnIpyuANHkvFeCCx7XRTATp0u2N0YNuJ5zX6fG5k4s97Y8LELBmZgLipxZh1VBK/nFnBndC/vtmKsXtr/CYnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44REO8Rw025930;
	Tue, 28 May 2024 00:35:29 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DS2H9JaXjS/U6WjAMQnKpq2ERfUlXB9/+1zLNhOsH9JY=3D;_b?=
 =?UTF-8?Q?=3DLt15dLHpG81YSU7lrZmKPMKGnfyF3HD1ZxY4e31Orh4XSkGxzDGm/b10uzez?=
 =?UTF-8?Q?1BXo9GM3_msNy2aLkq9elzGBn7kd0JBzurFe32Fhog2e9ojlr8eNEJUrxFY6sFX?=
 =?UTF-8?Q?dWu+41+/Ec91X7_nv6Y7bGVYHDMmE6f4oF84SfZoNJSRXzusUt3ph5vBltchxlY?=
 =?UTF-8?Q?4LDlPKvPCy4KvGb4ttLP_JFudWzV4h8RJsOEGMj2e5ds5nN/DgqLLOwXfDNHzhu?=
 =?UTF-8?Q?KnsQE0KWZEzfqqbMrQ4lTStcV5_TYZHJAIKPOskEVRDU6GuE+WYbG1fPW0j8EO8?=
 =?UTF-8?Q?+romorGpPgtoxrNUxvT0WW5i/wjfh+HJ_XA=3D=3D_?=
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8kb37q6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 00:35:28 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44RME2Oi016172;
	Tue, 28 May 2024 00:35:27 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yc55vtf67-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 00:35:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XWaQz03+osaa52jeG0FpEIwcWfq1ft5yyi9ncpM0KYSnyVy79jT/ISCT81IKdVFgjmlSJNz1LmRCZTFiga5RYms2Xj9lDazUBasVsqZ3Edvv/OxVaYupwSXj+B+kC3WsWfvq2SPwJPJtC+dYa7UZ9jlMoBhIENar4Zh6WAxxXn2tYsELHirtxKV5FEU+r14hNmPeZMzMj86G736BJ4YBehjS/yWFGZJ4eXDBMHFyvOCTnDptBGQN+Hh6Blq7j2TYBGEmIljFgShRIqh1f7fZ7lEM8OeLZFwN0t20DjSM0YyL4LuFDOjBgLTrPgTo+KWHXmoYoSno6ecuqYodKxkyIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S2H9JaXjS/U6WjAMQnKpq2ERfUlXB9/+1zLNhOsH9JY=;
 b=N32Cfk704G5yZiTfddwUY7ylmFQz2IK55vqWqUyIi8qSRGzpEYoC8lesU3d/YEZSA01bFscV5ye6PmHNMY68pps86eXSNRFc9bSYp40oh9AArUH7w2cutbhkBuhtb5w+8evh/BrKkYqZi2FOYsJph5p9hPQRiwhq6rFJtSkyqnpthgPPPmDA+PkX1b/kJW3lde+6ezJg14z0bhs0ABynmoBVA+aQ5bbMD4FycC2pSNdmSE8AmLzKZX37xRLXjgiLUBsusqqNs8mYSNvA3hcTzEi3qCtzrOeVJl54TWMq3HaASHHdsAjIiI2v9RwdMdkZQIO5loj8TwbhY10bKxfWOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S2H9JaXjS/U6WjAMQnKpq2ERfUlXB9/+1zLNhOsH9JY=;
 b=KHmEZ1eG2u32iXgyxupqhff50C1ybM4eGkthnjsnfMBQiKJHLMx98LIvZGdq+PgPlVxLcsrnRSJCYHw553Ea0nHefpmgQ/PnP/ZC+atTiTTj08LvlyZ+/iJtXgJF/sN0ez7M3AVb+ssoYj16jCMoMDTzqgAObodWk05IZD25kpI=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by MW4PR10MB6510.namprd10.prod.outlook.com (2603:10b6:303:224::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 00:35:25 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%4]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 00:35:25 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, rostedt@goodmis.org, mark.rutland@arm.com,
        juri.lelli@redhat.com, joel@joelfernandes.org, raghavendra.kt@amd.com,
        sshegde@linux.ibm.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, Sean Christopherson <seanjc@google.com>,
        Ankur Arora <ankur.a.arora@oracle.com>
Subject: [PATCH v2 01/35] sched/core: Move preempt_model_*() helpers from sched.h to preempt.h
Date: Mon, 27 May 2024 17:34:47 -0700
Message-Id: <20240528003521.979836-2-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240528003521.979836-1-ankur.a.arora@oracle.com>
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P220CA0026.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::31) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|MW4PR10MB6510:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f429ddc-e135-49fc-f32d-08dc7eae10bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015|7416005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?7KBwWMvwdnLUgjSZ+/lQwisnjk+OFOHkXVKyCmQF2hJs6UZdUCsmGHAcorCe?=
 =?us-ascii?Q?JNrmxK/DPc0LCySJI72IPMznI6LiL3BrH0AGA5DppnA4bfOmAgg3VH20G/z+?=
 =?us-ascii?Q?3W4hNLjjLZxFju/ySp1xI4p9WKd0Yd4oOkQhATJfJm6KSwd0fuq/F4lK7Myd?=
 =?us-ascii?Q?X5UdqGDLMRiU/CJ4nAZCxg9wAIbJB5o7GGRGhYy3U//4DoS+P5Hf8/LwP+Wu?=
 =?us-ascii?Q?JDhv7xXk7nGfEdORj/1PrOu/cPXptrTFlR3oebSKS13CYDfcffR4d8LIxi6n?=
 =?us-ascii?Q?ECPopSlJtnuR65uBBZHMPV+cyYb0lS91rllR/wEV5z8LyReN18+SaGcPMzEc?=
 =?us-ascii?Q?E05n0q0gmmVZg2TkYXHnHHVq3BC79klpn8OeONxmHF0sfa5+rIIxUODES9F1?=
 =?us-ascii?Q?YP3UVCqUS+7DMqDGcOAjsoIQTGiQvgYsnob6hkbgKFtrDaIVwSIOojzMKCc9?=
 =?us-ascii?Q?RvrHDfPn55LQhBB9frNJ7FhSapacxjDppOhJF8hktK/r1NZocf4yIsEbNEJt?=
 =?us-ascii?Q?Ri/jkb6bF0I5jKVC/k1R8BlUxOC22W+G1wgGXDA9LVYfNNVNUC6Qq25mKl3m?=
 =?us-ascii?Q?WAhVwQCDLuUxThE+m6z4T5XKInQg4FRdvVdO2X26F52pwm67Y2v8otMu6wnl?=
 =?us-ascii?Q?9XE0YZNLf+qn4UBPQND7p8CkM8pFjKgqvGGI+vAqVy2b5JjmGqM+ivXc3OdY?=
 =?us-ascii?Q?T5EwgPbM6ABNvYXfPUurUEWuKcWYeAOWqet+cQLISOYJE1etUfW1StT48Xlp?=
 =?us-ascii?Q?/voksPrZQLjEnXAm/BQ+jA7Yq1OdIRGIZmwrSer8RPR963nTlO2/+B4NvOxd?=
 =?us-ascii?Q?TVPevWjnEIbOGWWQ/aneCOrrP9idcyDeq43vSzsHK/kikZgXVxeDa8j8h90i?=
 =?us-ascii?Q?6NwTOqPJZhytA9ORogLHNC8OV6GGBriNH9WMZYf3O+pAt/6gwrHUMUF6MgtR?=
 =?us-ascii?Q?lCdSupTozCcw2Ih1H03EO38nR3E6XOElS/msZ+HQKKjHM47zdy32a7MgW2QB?=
 =?us-ascii?Q?NWQGzAU2Jo07cbgRGx8bOEYmuXofil4B4Pt3S8O7gE26iJ2B8fFTQYmg1iKS?=
 =?us-ascii?Q?Vh4VNqiVlY0YszzVpkmvfcFo+UXrjFEvXhGTF8CJKc+0h0i7ZtNgbtiUzsOb?=
 =?us-ascii?Q?UVyXg8Rte9DLWElUHmX0n8Fm+aw1AXPF5dORXw5UI2XvFPhW2PUjc2S/3Ms8?=
 =?us-ascii?Q?Y8OekgQA6wSwkI4XMSbCbUhAupmdw+Zz1B8MAC5wQRpkpiKQreANZZGHrYvP?=
 =?us-ascii?Q?nnFVGi6KcWUODltApdVBZWg9yYPlxGeLW8cSkP+BgQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?KJqb0JLGi5nIoHidtFv9sWBpdRHSYQjfULMb4sW0AE5/3viJU9PcHrYiKGgt?=
 =?us-ascii?Q?quu8iuzz/18wCHGdbI4AY8IwXzGiVGowq/Oahpwz9iKbxoeQeaLK7QY7vzay?=
 =?us-ascii?Q?IHb1dSxUG1CHXnaX0cqIvqGwc458CBoampyOOxKvYSFtg7AxPwZjugV+ADzy?=
 =?us-ascii?Q?pNbHKR+hBVyfqRjTlSHYVFc1YKv0EwptvjXFoNjgrarCyq6B7a0lQdSGc55I?=
 =?us-ascii?Q?LW2/50XQvQbbbjFmje7QkDnRCmd1syVXJyACI3vTXM7OuyLaw/mrCZxX0dAy?=
 =?us-ascii?Q?UCL0+HKpT2YHPMIQFrZcVw2q5OWvIBvuzRRpZ7x72+2wrjtd30WQihXdbrl4?=
 =?us-ascii?Q?UVRzk/gUbzffsVhOHKXH7pBwU6dgyABksknlGjv3cjZzvjx/fZSP9Wg+clfL?=
 =?us-ascii?Q?bxoQO+l9vMWHW/+zVhErUir/8XTNK73tiGFt3QzeJgOe+fgJUhYqV+GnEMFe?=
 =?us-ascii?Q?HzDTBRDua1PCoIUZfihYdDZWtv9TaMEHsXeqp6Gt6bdrqbxFkPRwl3V34oGY?=
 =?us-ascii?Q?hO70ZdgqrK98gIP1dyH+hRBIRyZmaPuhS0xWgGDypK1qFaqTRYU8/3GTh9ZV?=
 =?us-ascii?Q?e1BA4rcXTfD33INQ2yyf39/IsX6CLiz7H3Z91T99LKdZlO7h9PX/vRLzwmin?=
 =?us-ascii?Q?xtaSeOcJXbgZEibn04hBuErWZwaeiRTGJ72UClDKNU13h5nMKV7IIJIZKJiK?=
 =?us-ascii?Q?Rm9cqgwWepCs9ounzpfPVbCuoLxLjhhAGn1dea+XsVi7PpVlqdkcA61ZpxG+?=
 =?us-ascii?Q?s//jRiVygEAN5/55vskhjD11MYCQ08/mUqi1nV5N12dR67i+JnHuEA1uWJk4?=
 =?us-ascii?Q?Dv2slJIKdg4bYOl8OM7d10hBHRpK0ErMAWlFZtya+7r0+onFYVyixa9vJwzg?=
 =?us-ascii?Q?nTzVKyxz1RXmub05bBRN5NUX2yAEiE1PdojSsr1s8WUmjrv4r1FsZnFZC+yc?=
 =?us-ascii?Q?wL6Jy31bN3icTkOS1Szs8p9ildWhJQtMoSZ2xgEz7wyPMNzkM/yibKx/tFef?=
 =?us-ascii?Q?nZ1ZeRqQm37geypqoSFXk6hL9kwuyd3EVICinh8//3QP9upu//4DphUITP+V?=
 =?us-ascii?Q?2rVLNXp51n2eMWbuEpNkn3KpNKuYh0WJsgBpM304ZEdB20p7iI4k6pZTvqtU?=
 =?us-ascii?Q?/sKTOTomxeU1ctQpuIEjk6Pop8dfoXB8wz9c1YBEQEuJJ8zEkoipqFq/amjy?=
 =?us-ascii?Q?IfeecHrKcfyr9CoGWpYaEc93Wmbo+QaHJ/ScUYkLg3IHCgQOrr/FmNU9LL75?=
 =?us-ascii?Q?GeSGfeRdt6zKwtGej8wM0FDGHX6L5SzHHr242qFsLP40YHq4QDXMRm8BxKAj?=
 =?us-ascii?Q?3dJrjjZAryxUNDkmFEwGxop5hlX/UGE5SAARTIjqGIQTtURK4JK000sf15of?=
 =?us-ascii?Q?3O2ubQNEo1FFlCvlA9Fn7FfbEPWMZ5BOCmg7Q99VpzyWdHs0WrpCX/3J7bSN?=
 =?us-ascii?Q?LfpZiqPs3EakvJYgIdUo22+EIjIEDQYo083ccvj3sp1tEpaSFbcl5aV1WwLV?=
 =?us-ascii?Q?3A8eKviRnBPgT/nfs5DUCAPugkF5+/YJ6feFF2BJzD2mnWXLHWZlab8yq1E9?=
 =?us-ascii?Q?cV0/Cror5E43K3OUudwRwUpHQDn7vhfEPOaaodoR8Z4Mw4S5q7d4KEyeqfvV?=
 =?us-ascii?Q?Gg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	cG+VzrE8rmnzSFGOatR8krpEdiKmqbAmFH3P0zJhhJRE1in9fvQEyShcj1Cm35vBJpMCJgCr6steww0VtKqrKOTyuagA5zbGo0Jnd8CpIv4cXUJk0jPTwzqbQBQ4hR5dU6aUGJuCTZCYJqYvszGAAlEZAN+eGUgOoZeoI6u2RPRS35OSsRUte337XNMXSKm0smEvdL8PilSyCERFx4oQFPM8mm/WQcSJSuDTFMw8W0XzYNR8FAzZ0k7aADU3nm7/C5j3aKroiG0DdzQCDLv51BWYGGCle9/gQqq3Nm4bfpyLmy/wbTuU+pR3GtBURWEqRKc5tyugQVYV6DMyVCRkh0xwQsNuSseh18oRVx5h6DNvTKFObb50lGs51Md/Dr7eGoZv9bGYMnOolBG2R2lLbpy8rO0D+wDu9J61RbdgM3BjItX2hftMRuW/9Z4PlhdvkXNx3zPlBfBzXX676BKc6+NK3l+btORNuIBKXS4oKCHjvpz6xGJLHUY275LSJI0nn/HTy+Eh3dh3Fb1yqAqALpgq+Idv/0YKsf6c0oKqpKHfb9jwHk+szo/5NbSgZ1uetyuF+QvU8qSQ78etLpqT1n1GWHhP1UtSS7a/KS4/rUA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f429ddc-e135-49fc-f32d-08dc7eae10bc
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 00:35:25.1587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ONOwvO6UYj5KLvpVf8pZ1FPCGHCKpjnoJZiDrkK32E6wf5QhhvsL1Ezj1SDTcaNicZdptNCXmFCapVJ2UMTkXnA2POQ4b/M7MmtFzOwcc80=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6510
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-27_06,2024-05-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405280003
X-Proofpoint-GUID: sqQF8NwCgKKtjT8AtbbIFawalAkU6iL1
X-Proofpoint-ORIG-GUID: sqQF8NwCgKKtjT8AtbbIFawalAkU6iL1

From: Sean Christopherson <seanjc@google.com>

Move the declarations and inlined implementations of the preempt_model_*()
helpers to preempt.h so that they can be referenced in spinlock.h without
creating a potential circular dependency between spinlock.h and sched.h.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/linux/preempt.h | 41 +++++++++++++++++++++++++++++++++++++++++
 include/linux/sched.h   | 41 -----------------------------------------
 2 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index 7233e9cf1bab..ce76f1a45722 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -481,4 +481,45 @@ DEFINE_LOCK_GUARD_0(preempt, preempt_disable(), preempt_enable())
 DEFINE_LOCK_GUARD_0(preempt_notrace, preempt_disable_notrace(), preempt_enable_notrace())
 DEFINE_LOCK_GUARD_0(migrate, migrate_disable(), migrate_enable())
 
+#ifdef CONFIG_PREEMPT_DYNAMIC
+
+extern bool preempt_model_none(void);
+extern bool preempt_model_voluntary(void);
+extern bool preempt_model_full(void);
+
+#else
+
+static inline bool preempt_model_none(void)
+{
+	return IS_ENABLED(CONFIG_PREEMPT_NONE);
+}
+static inline bool preempt_model_voluntary(void)
+{
+	return IS_ENABLED(CONFIG_PREEMPT_VOLUNTARY);
+}
+static inline bool preempt_model_full(void)
+{
+	return IS_ENABLED(CONFIG_PREEMPT);
+}
+
+#endif
+
+static inline bool preempt_model_rt(void)
+{
+	return IS_ENABLED(CONFIG_PREEMPT_RT);
+}
+
+/*
+ * Does the preemption model allow non-cooperative preemption?
+ *
+ * For !CONFIG_PREEMPT_DYNAMIC kernels this is an exact match with
+ * CONFIG_PREEMPTION; for CONFIG_PREEMPT_DYNAMIC this doesn't work as the
+ * kernel is *built* with CONFIG_PREEMPTION=y but may run with e.g. the
+ * PREEMPT_NONE model.
+ */
+static inline bool preempt_model_preemptible(void)
+{
+	return preempt_model_full() || preempt_model_rt();
+}
+
 #endif /* __LINUX_PREEMPT_H */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 3c2abbc587b4..73a3402843c6 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2060,47 +2060,6 @@ extern int __cond_resched_rwlock_write(rwlock_t *lock);
 	__cond_resched_rwlock_write(lock);					\
 })
 
-#ifdef CONFIG_PREEMPT_DYNAMIC
-
-extern bool preempt_model_none(void);
-extern bool preempt_model_voluntary(void);
-extern bool preempt_model_full(void);
-
-#else
-
-static inline bool preempt_model_none(void)
-{
-	return IS_ENABLED(CONFIG_PREEMPT_NONE);
-}
-static inline bool preempt_model_voluntary(void)
-{
-	return IS_ENABLED(CONFIG_PREEMPT_VOLUNTARY);
-}
-static inline bool preempt_model_full(void)
-{
-	return IS_ENABLED(CONFIG_PREEMPT);
-}
-
-#endif
-
-static inline bool preempt_model_rt(void)
-{
-	return IS_ENABLED(CONFIG_PREEMPT_RT);
-}
-
-/*
- * Does the preemption model allow non-cooperative preemption?
- *
- * For !CONFIG_PREEMPT_DYNAMIC kernels this is an exact match with
- * CONFIG_PREEMPTION; for CONFIG_PREEMPT_DYNAMIC this doesn't work as the
- * kernel is *built* with CONFIG_PREEMPTION=y but may run with e.g. the
- * PREEMPT_NONE model.
- */
-static inline bool preempt_model_preemptible(void)
-{
-	return preempt_model_full() || preempt_model_rt();
-}
-
 static __always_inline bool need_resched(void)
 {
 	return unlikely(tif_need_resched());
-- 
2.31.1


