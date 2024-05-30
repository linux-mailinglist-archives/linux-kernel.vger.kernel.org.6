Return-Path: <linux-kernel+bounces-196005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCCB48D55FB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 01:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFD581C244E6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 23:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81247183991;
	Thu, 30 May 2024 23:06:27 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3290313B290
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 23:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717110386; cv=fail; b=pxoxMz6Qkx/nOKomTJqBuShUH52b/3xy3dHGRjAu31PYB3fY6giwq8fcu8ewN9TivpnSlKFFV7wIkPlAzFY+i2I3OitdTczrJsOx1UfWYPceKGuXr/5cC/G/CPpjzMXGK5wrwIylMNk03pHxYpLfsxLA4ktvQFTAvtMGGWhdBMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717110386; c=relaxed/simple;
	bh=didVUW7uJjCz9p/FPGd0FC4mmRqUlerPUAdz1r1gFkk=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=JCqThnf+8eDA6rh7Z7if5hUE8t6HbEPckJ4f0fkp0kwi9gWDXVw+hxTwUQEUqgbi2IkgVAbKIASiUDWfBLIGj791GBvectDvwKrEQQgJb7clSijRNWj8+8QHrXNJMbkM8D3c2bDKkauosDnj3siPo5Uv1SZ1NsXBOiqt5DN1QUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44UFSQgb005736;
	Thu, 30 May 2024 23:05:59 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-type:date:from:in-reply-to:message-id:mime-versio?=
 =?UTF-8?Q?n:references:subject:to;_s=3Dcorp-2023-11-20;_bh=3D3QHeGv0sl1n+?=
 =?UTF-8?Q?UUk92CrGNES/tDfsqDMm1MkvmZ15qys=3D;_b=3DjsjhF4udf9vs24fqUbQOC0w?=
 =?UTF-8?Q?Ks/fYftBtDUXdtEFaeoijQ8WGTf6tiAPiVxB60044yP2z_kiQc6oXVw14CuLPHU?=
 =?UTF-8?Q?2/ySLAY6DJFrjQbV3+Er8TNONkl7XrztPsIsfaNjtAnooVJzJcr_0zACAOe/1m5?=
 =?UTF-8?Q?Vjw0ljBZTVPT2o0BUuM952ZwLkVn8yTPYJKr7naU9YxSIoZOW3DWdRQ2e_Ode32?=
 =?UTF-8?Q?Rcwrpez+yhAQmplygoW7JEziUk/c6opsx6qCPwwCuyv2zXfDLBkw4ZkunpnkviJ?=
 =?UTF-8?Q?_fFCpf3pFSo/mOaYlNNwaOaedN3Vo78/NfdnKGONNNKhkHbBBgZoaQqr25nEStZ?=
 =?UTF-8?Q?Ez/NgY_oA=3D=3D_?=
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8g4a3rp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 May 2024 23:05:59 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44UMTsuL010817;
	Thu, 30 May 2024 23:05:57 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2047.outbound.protection.outlook.com [104.47.55.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yc5118dgq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 May 2024 23:05:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Md//HA2F4w8HkoiPyeYxy2cSAe3E97t9zAR+/FH5pRQ0E1cYOHAufAt7hCFeTetMTTKoEvBxnqwEwxBAkVHWz6OfFv2p09qbf3/R5wlQsMKdpeqJ575NCcKubp0sn3slGQvBWwliHAl3QMwZiDBqWluo15EWcPDWfWQ4LGsfHh3nSSs5K3isPBYy98xZM5P4XwdbkRaiouoDkUxLRHtjBE9LcrNF/7+P0Pjccq/uSDi1Y8gdRjjXslWOflKxL0raIVj8O6oeulcKpJu88Mfcct40Nj2Fs4Zvcj0v9VwQw8/pOWtrbsvhFf3L49rTpm6w43dnPYbxOSJ08xCdi7ruLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3QHeGv0sl1n+UUk92CrGNES/tDfsqDMm1MkvmZ15qys=;
 b=BeKtyZM7SZ5uJHLKVa6wRcVeR9iJtXppZxUcSzXHcrG97lXgn/ipE3Ix2VOXlb4DtlJZBMi0vHwzzUW8ih88UrCu/rNAXQHJX9eNu7YTSUKMTdjrMndyA7zNfwf449DZDn6XgfFl9s3Wwi0EM5vJkk1h3swkSFyENKI0XAt40wU3I/HE5cB0bl9lS6H4+opCGoz98x+MWy7lccmsNRw4NedeN8aM99gegECgi+/5WeTI/r1jLbodcTtYINXEdynUJZh8GqTJDE9Nm1XTeudAwNyBBenVjey/HlISellacc6gnEfXczH6vUok4vd69UcE35hxQU5fw/rAFyuaO6ZEJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3QHeGv0sl1n+UUk92CrGNES/tDfsqDMm1MkvmZ15qys=;
 b=N73XRy5D+BXEGfJO/+4z6PC+zR3n02znYvcXH467qanf7sAeVNU6DCCIoj0ChG1RbghDyZesB9rxmlHQZEvO1xij6wYIJ+l4PeSffInJoROr2nmVA5alTvgdMhY/UOzraTizHntRConTrPy1yIRnrOAnO8sU8LmDxATLHr0i/E0=
Received: from DM8PR10MB5416.namprd10.prod.outlook.com (2603:10b6:8:3f::19) by
 SJ0PR10MB4511.namprd10.prod.outlook.com (2603:10b6:a03:2de::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Thu, 30 May
 2024 23:05:55 +0000
Received: from DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::e085:31f:84d1:e51a]) by DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::e085:31f:84d1:e51a%7]) with mapi id 15.20.7633.021; Thu, 30 May 2024
 23:05:55 +0000
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
 <20240528003521.979836-17-ankur.a.arora@oracle.com>
 <20240529081404.GI26599@noisy.programming.kicks-ass.net>
 <b629f8c9-8900-4317-9ea3-08a8dba7d896@paulmck-laptop>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: paulmck@kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
        Ankur Arora
 <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, torvalds@linux-foundation.org, rostedt@goodmis.org,
        mark.rutland@arm.com, juri.lelli@redhat.com, joel@joelfernandes.org,
        raghavendra.kt@amd.com, sshegde@linux.ibm.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot
 <vincent.guittot@linaro.org>
Subject: Re: [PATCH v2 16/35] preempt,rcu: warn on PREEMPT_RCU=n, preempt=full
In-reply-to: <b629f8c9-8900-4317-9ea3-08a8dba7d896@paulmck-laptop>
Date: Thu, 30 May 2024 16:05:26 -0700
Message-ID: <87v82u52a1.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: PAZP264CA0149.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1f9::9) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR10MB5416:EE_|SJ0PR10MB4511:EE_
X-MS-Office365-Filtering-Correlation-Id: 095e178e-8356-4b61-b86b-08dc80fd044f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?/1KBP9DstEghrZc/syqgklb0tbSlXu1DKzWNAWxai549SvA2NG/otgLtVSqT?=
 =?us-ascii?Q?R1IpDh8Hzkak4BuhmFdmLubX2tFJ8oCxmElk6SA4TmEzXlB5Pvk/ghi3nqBI?=
 =?us-ascii?Q?VWFQ+qCKll3FmvNQAAjJIHnI+Q8lP/YAuk6pIX6a/WZTSXqeG3oYP6zZAoW6?=
 =?us-ascii?Q?LcXva8yv+3HQsoUN7ihDfy0DxHa+drJ20wpNTIuEo5m3aGdxIBVJgT19AJoO?=
 =?us-ascii?Q?ZX2tH8533/J9UKWzCw01RMo+6NU7ObLFc8u8CUN+ZouuE7mS0qWAM4TZ4Nm6?=
 =?us-ascii?Q?POO9x+z+Z/2Ar9Xh07re8ta1fVwBlG/ROtTlq6Zo8HTf4x3Wbw1P0cIHitwV?=
 =?us-ascii?Q?F40PsNMEoB3SIBfoJ6IMXz2LEWHz9f+RuUbUqlGeO+8Min7rwQTigAiMO6qE?=
 =?us-ascii?Q?3JXtAaQPaWZMZ4KI1WhB5YdeouELx/W6MlwLS/ASolOEl8mrvFYou0kLIDcU?=
 =?us-ascii?Q?ZVgFyPBQsQvmPtxjWibcqP9dsVsalt5iW4rxNU/7I+PPHGHxJLS59ezmH/kw?=
 =?us-ascii?Q?0ZIhsXgZWgbq7DnKn0cDl5zsdfxUuBNsv+MVZqU8QbFy8jo6sTRqctbp5Wz1?=
 =?us-ascii?Q?g4+m6CtNHA6sutbtmlA+xQPAkv0ZzHoJDBy3G5qlAMnqVoGAnbdlWw4/br5o?=
 =?us-ascii?Q?bqv9KsWjwwxCJVa6usxSXVFWK/4K69QH/oXfs4RBbD7KylQjcw24WZe8J6NI?=
 =?us-ascii?Q?YyAkLn9uxUNBmeE8kjuJqzDVvcYzvGXAS8tejLQQsD/yqNybfAC0r+LJzrLA?=
 =?us-ascii?Q?AUgL95RawK88/Us1lYcRdGM/ld3bZ0xd70adMsFCyORMCltcWjqmGHw4i7vD?=
 =?us-ascii?Q?ivZ5v4QdjmAjRETfECuyOab3EcVZ6kdQPm7IeC0SD7GaeddVcYF7YA9RgQNL?=
 =?us-ascii?Q?pci6ephLdR0ikD5g+8uZrXwFht71KBFUXsj3WUk9a3W1Yp28nRvmiDuBf8++?=
 =?us-ascii?Q?lHGvJctt5kc4neTLr4w/ks4pqMu4lvA5tnL7ZEu6B2Ppq2I/+qWnuqWh5xul?=
 =?us-ascii?Q?ZxuvT+HGluh7VKYGPsVe6ABoJvCdZ3uVUscMMcpYlMPlSy954fEVSgnI2hCn?=
 =?us-ascii?Q?btj2G5JjJgNiLs/QJSA2Z4ckVkFM6RwyN3uhhpudQouWNVoheyq2d8ePo1EI?=
 =?us-ascii?Q?Qr+YwxTx0cd5Kdb5lP5laLtzUnFQx07j/3ZeSmWrpbeVxJUxshJOOQf5q6ql?=
 =?us-ascii?Q?kTvcNXvOClnnR6ofEg+m0t+nfjtuKD7nq84sJ9etLXyMLtEYd6rj+rXkaF8?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR10MB5416.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Dy57pNFvqK4FKEa9I3xtzQO/hcNAGNPX7Qm9aa2Ja7857F69IEIKYueUiEJq?=
 =?us-ascii?Q?s0zLTK9Ot7K1FwvVGqAx0V1+pseX/wVk+F14cDCvy1I3p45b9hQn6bXneKk6?=
 =?us-ascii?Q?FZmjAllCzulY3mDMtpoJsWlA2q9JW+9jxmlxnOWdErS9kEwCuKuNcf2fbbyP?=
 =?us-ascii?Q?3WTMn10F/I1qRHljhefSCtybnLN41mALFzASs6E67m3VHVlSxRF8ltkHZPxP?=
 =?us-ascii?Q?OQh3SMP+EHOAQzK59Ptl28fHzHPs+FEfUDy4Ouq//vTzlABhvLcRgBZaAwb5?=
 =?us-ascii?Q?wpYXM5JCDuIsxFWHTS3tjloiSp7lsZ8PEWNvWYss+CjI/0t7nbPvpmfNDUwT?=
 =?us-ascii?Q?HdNk2dSotYiiNxXl1OG919Bn2228mlLwUJi3zxXdQXTMk9evZXwp5mbrK2Za?=
 =?us-ascii?Q?g/FP02ppKkyb3G+79qA9cIhzfwkNMhoXjKVj8HMjguqOzTUFJXcs46SY3wjL?=
 =?us-ascii?Q?16ce6cUi1AEI/NdJV6heRZ7gdzpirz9V/hNlVRMW2PYqm20OLR+D+fqjW33W?=
 =?us-ascii?Q?UbzTrqBC4iATRyqcs8yZALJqLe0Ty2No89yEclTGcWoW930LJV98dRtoO2/h?=
 =?us-ascii?Q?3AmKdjkIlrX5BIQhPfl7i14LlzeLazBmBs9y1AaoVtx7C/kQMeyHK0J8rmX1?=
 =?us-ascii?Q?qXhLFqYA6D9qmZ6psoWYjZOb3wEd4rP4n/srLKR1sBsAaGfdmhW7jKTAmZdw?=
 =?us-ascii?Q?xkpjoPAwBL1dy9YipX+hYjUqj2jlnhdbWcMAAErLYPqpVdWg2Ylf+o5aQ4e8?=
 =?us-ascii?Q?U93gbp3nK15Su7wlsVA5iopN5diROJxKpZvzDf0XHMzY+pYJz8TPOQKEheIB?=
 =?us-ascii?Q?3Lky3Dq5vsGC5u1R2b0ImMy3ReZYYMauZlQi4MEHADuQiNzzsSYPJqV9I/Ux?=
 =?us-ascii?Q?WfPpcBRy5wSXbVv3SjV0bbBHMBTVU8vVNW5oWdz/pbFzFb9LYp1VFbLc8bbT?=
 =?us-ascii?Q?F9Olpx4ThBZTIaMZL7zQmKUJgdfGZ9ykLncLKil8JCB4SdDA9dAv9mpXrInc?=
 =?us-ascii?Q?gWuUX5q+miCVM3TyYLW5iGPaMy66K7eBfn07nwn9VTnvwnGqy8/Za7kXevfi?=
 =?us-ascii?Q?47sWkYesGhmLjFLE4aG+QdR8FNJqcDXhZ1c7GloUoLz/7QHyjZ3pXf9i3TWH?=
 =?us-ascii?Q?kyoaKjPHvta1Lmfs9G6KzjzWErGvCfq04VFKw9SKmAfL+hu22fVivY3rwaIz?=
 =?us-ascii?Q?mVOXTovaRvrKVOZdRw3X3VyTUzU3FhXzexbDs918CNVJfmhtzhsnUr8fZMiB?=
 =?us-ascii?Q?OtO4EB8+ihKEsIfAGY30mg8kcHHoBG876NEoYaT5R0w/IwFNqCyIxwlsF91F?=
 =?us-ascii?Q?gIW16kR0vSEljMPKOTlLrv+sY8+ftCQyjmGfA8cbsgYc0uZXGDU9UPq1hMhw?=
 =?us-ascii?Q?rIyezIf6ZMEKJJW6PLfwRCie/sr7/DPB4IqBlbxpT2FP1iFyqfxq+AaOmFlV?=
 =?us-ascii?Q?x0Z0iSuS9fgRNLSnonBAAQGT2obln6HA/TJvcI5H1aMDoNwm2bm7eV5OcRib?=
 =?us-ascii?Q?8R6BR/Vjwh5zt8SpaaU6e9XB5FfQmvq2qtN+BXQ/iEzGOXYp3MaPxWrhApHl?=
 =?us-ascii?Q?Kx8b7lu+3VZtit24OLItL1mpzC3Dl5C9a+APWA3h1uqvD2dm6T3fA+fdmwt7?=
 =?us-ascii?Q?rw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	MOab3E+iKUTRKPochHf57KQSGXOaspmDkybA9M5F7l29jKboxE5ShpCXREoenJJ4b7tDPk1c7HjgRqSieqB16kugSE9HmgG0WiGuJ6LXuuUogXnvGNfQcJ9RLmtLhexesAGOMY+tw4daB3j+pIWG4zirfrhxO3ISh2treDYkuhLf/NZdn5mk1gM5KJGOEA4p68pIbeDz4NOBOFgO654zZzMha4g0R+815DViPlicSF5FlI2ZBW6AWS/Snb0D004dHQlik17WKrXFrrWbWiFEQMllCtq1MlPcA8zNARDPfvOaHp5y53svYhNIHrjV3g7L1rsNGDu6vSTwMlhIdS9hmSlPN+3o0AtLZJ9K+l/Saity1fsX1OPoDKOdWFwi+DMqo7QrZcDsezk8fwE9mUAYw3sSN+RZr2eCFK2mjk4Jk/90T/4qTuyJVK5nyv80Ssj9gKiuTztult8OVzxLgHPRCAwCTVTa+VJGkepDkI79pzlSFVagL9kXI1GU6TacplS9DBUbPmRwqkOPwONL4Zfw2YcyZecaKv+7JYd45PGz1P3v2G0hTljkUvM3uINirGGF+K9NCzhLGMeZ09GIIB49fIk0DKsfbCgVb3DP3voY/PU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 095e178e-8356-4b61-b86b-08dc80fd044f
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 23:05:54.9952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5t9KvEc2yJsS9M+o8Ts5vV1/sBvtSTCRuKptpBtHf0uiLosImv4UcmxwIjT4I/TSJteziPw+hSrfdx09My358WML0xYK5MTQulZ0Z59SVz8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4511
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_17,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 spamscore=0 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405300175
X-Proofpoint-GUID: xw5EqvdNEOrsXU0QUWvo5rTTnr8JHidZ
X-Proofpoint-ORIG-GUID: xw5EqvdNEOrsXU0QUWvo5rTTnr8JHidZ


Paul E. McKenney <paulmck@kernel.org> writes:

> On Wed, May 29, 2024 at 10:14:04AM +0200, Peter Zijlstra wrote:
>> On Mon, May 27, 2024 at 05:35:02PM -0700, Ankur Arora wrote:
>> > The combination of PREEMPT_RCU=n and (PREEMPT_AUTO=y, preempt=full)
>> > works at cross purposes: the RCU read side critical sections disable
>> > preemption, while preempt=full schedules eagerly to minimize
>> > latency.
>> >
>> > Warn if the user is switching to full preemption with PREEMPT_RCU=n.
>> >
>> > Cc: Ingo Molnar <mingo@redhat.com>
>> > Cc: Peter Zijlstra <peterz@infradead.org>
>> > Cc: Juri Lelli <juri.lelli@redhat.com>
>> > Cc: Vincent Guittot <vincent.guittot@linaro.org>
>> > Suggested-by: Paul E. McKenney <paulmck@kernel.org>
>> > Link: https://lore.kernel.org/lkml/842f589e-5ea3-4c2b-9376-d718c14fabf5@paulmck-laptop/
>> > Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>> > ---
>> >  kernel/sched/core.c | 4 ++++
>> >  1 file changed, 4 insertions(+)
>> >
>> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> > index d7804e29182d..df8e333f2d8b 100644
>> > --- a/kernel/sched/core.c
>> > +++ b/kernel/sched/core.c
>> > @@ -8943,6 +8943,10 @@ static void __sched_dynamic_update(int mode)
>> >  		break;
>> >
>> >  	case preempt_dynamic_full:
>> > +		if (!IS_ENABLED(CONFIG_PREEMPT_RCU))
>> > +			pr_warn("%s: preempt=full is not recommended with CONFIG_PREEMPT_RCU=n",
>> > +				PREEMPT_MODE);
>> > +
>>
>> Yeah, so I don't believe this is a viable strategy.
>>
>> Firstly, none of these RCU patches are actually about the whole LAZY
>> preempt scheme, they apply equally well (arguably better) to the
>> existing PREEMPT_DYNAMIC thing.
>>
>> Secondly, esp. with the LAZY thing, you are effectively running FULL at
>> all times. It's just that some of the preemptions, typically those of
>> the normal scheduling class are somewhat delayed. However RT/DL classes
>> are still insta preempt.
>>
>> Meaning that if you run anything in the realtime classes you're running
>> a fully preemptible kernel. As such, RCU had better be able to deal with
>> it.
>>
>> So no, I don't believe this is right.
>
> At one point, lazy preemption selected PREEMPT_COUNT (which I am
> not seeing in this version, perhaps due to blindness on my part).
> Of course, selecting PREEMPT_COUNT would result in !PREEMPT_RCU kernel's
> rcu_read_lock() explicitly disabling preemption, thus avoiding preemption
> (including lazy preemption) in RCU read-side critical sections.

That should be still happening, just transitively. PREEMPT_AUTO selects
PREEMPT_BUILD, which selects PREEMPTION, and that in turn selects
PREEMPT_COUNT.


--
ankur

