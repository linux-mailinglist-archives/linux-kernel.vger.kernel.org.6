Return-Path: <linux-kernel+bounces-191558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AA98D10F6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 02:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A50161F21CC4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 00:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95ECA3FB87;
	Tue, 28 May 2024 00:36:31 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C66F3F9FC
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 00:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716856590; cv=fail; b=G8D5Qu/WAu0tiXolZmlv3/2iuqftwJ3r4kV5ade6sKbLBenbJRFPFHCoooQ+wVLTG05usBwC58izRPlvtp7DrDdfzDWwmM66GQEfgE3OKUeaQwrhH0RQLoNGa7cP9ukJDOPQXYLJtcddi+oQMtjthUqrn44l6wVEoIWWMQVjUe8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716856590; c=relaxed/simple;
	bh=GTl1Vj5CaMpVkcSFhPQ/wtSV6wgUx61h8Bxpl/hbCiE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qxd6slu4JHFdgxCdCETYHZOlKbQPN9gKB6E44QMxNcIUXbIjZnmG+BiUjBy4MUGyEnG97Kc60y+LOr6FpL5VuCLinrL5R3c1e5XuJ2WC7M03bjROwbL1SQH5qBwxscBG6q98PG8K4UxQR6mE+IeZH085dDzp7Cr3koZeTaC/ELg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44RJR72T027730;
	Tue, 28 May 2024 00:36:13 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DYX7Tvq2QNJ8VjUJCxqZh+pc2CGD9rZAvhEhJH1ssuI4=3D;_b?=
 =?UTF-8?Q?=3DOqAmpsbvVO8MiyDZ8jKsVWpRtRmQsQB/70ylBrFjg8uGR+wf4XJz/VD1XLGa?=
 =?UTF-8?Q?IyR7cqw+_iPSYqGBbgMjpyA5rIdmE3bXQO1hN9x2p8bY0JJ05Bf856LzMi4xQKx?=
 =?UTF-8?Q?3b3pLLNi8RS+H7_FAkGZ1D1mrS6Ei+5+MfXdIhDp8rl2vrUVsojyeNQEUF6QYEu?=
 =?UTF-8?Q?yD6/LVEApHchKIdYN+4P_4ZkdetI8GYGQmPxS1qj6JhWiX6Fm0RTM+7aUKRiLsT?=
 =?UTF-8?Q?edzAv5HtO4fTiBmU70AtH0IdxZ_VmS2yYv/eAPkfYN9LGTu2tuyeIyvoS+mY9m9?=
 =?UTF-8?Q?+qzv/UD3pnRE7osYWRi5V33GX7Y1K/sj_aQ=3D=3D_?=
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8kb37qy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 00:36:13 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44RNMbXa016167;
	Tue, 28 May 2024 00:36:12 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yc55vtfwk-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 00:36:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nL1xmGli8TyAoaqTKoH6j39rLrX3TtwDrNQcpfUa63Intx63cIqIOqwLJK6Ag5iBRRjW87UV5PpHjMXtdhgaZpKnvdVJ+JhQjdadb3Rf2zre/6bkBTM+sFHa9l3+TLjTbCgoEqa3BapK/W13RBFKD1eaAHZJSPHz6oFAmShzZYdmOZRI4hRdY+ibI8LK7Ktq789dzYKBWPv/C06ZRWpDJHp1DpwTBwy+BBCz9qab1uONxI8cHh2wybC/CIrM/Uo4lh8vzprs+3g5ZwxvO/7sr7aZFgDPZZfsNab8Le9StA16bbzGHnaf0q8VTGzrhIUpvbao2sXbn08dZBH2z54bqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YX7Tvq2QNJ8VjUJCxqZh+pc2CGD9rZAvhEhJH1ssuI4=;
 b=clMi15ygEYGVlQSprEaBQozVi/g6ruu99JXHN7nBDAl7nfcMNeMx+TSwzEZ2ezQ7KqEb1DynE+XoAm4ZLYudUT28t+VTPdFrxDl5A1/0/2bUrj4UOr/prdjsSSXStsQptbkA13h3ZbaDve3RprbZYUFpTVMZofHUG911wzLipdhnTRbrS4+5nySrvjKYkRM4vXNK6boojyc6ZEdUYh0cbMT+56pvMaHfgxHBdOnWHzQPgYQg0HghjTCnOsvbFyUZhcBFjWaSlZ+ispSWIISUc2+7if+cBXBlal/x6iMd/ALMi8aNeswr7u9SZfJtZH+Ryi0spMcF4XB4IlI2tHTPgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YX7Tvq2QNJ8VjUJCxqZh+pc2CGD9rZAvhEhJH1ssuI4=;
 b=st7676dqmA+WmHijEOo0FZpPVEdH7vFL/Wcrndrl+FXp3p43V1AgYZgB5jhG6jA20LCC7zLoHK86GcRRl1jhOr6JRZwD3/nJ4xIG4ZnrI+n48/BLMtk+WPSAlnHKVAB71Ky0WP2Scn0O6K9YW1nQ9nX9DWZ0ZDderOZhNN+Y9ts=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS7PR10MB7177.namprd10.prod.outlook.com (2603:10b6:8:e1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 00:36:09 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%4]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 00:36:09 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, rostedt@goodmis.org, mark.rutland@arm.com,
        juri.lelli@redhat.com, joel@joelfernandes.org, raghavendra.kt@amd.com,
        sshegde@linux.ibm.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, Ankur Arora <ankur.a.arora@oracle.com>
Subject: [PATCH v2 14/35] rcu: limit PREEMPT_RCU to full preemption under PREEMPT_AUTO
Date: Mon, 27 May 2024 17:35:00 -0700
Message-Id: <20240528003521.979836-15-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240528003521.979836-1-ankur.a.arora@oracle.com>
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P223CA0026.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::31) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS7PR10MB7177:EE_
X-MS-Office365-Filtering-Correlation-Id: 80f5ef99-799f-42a0-d084-08dc7eae2b50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?NGc2+uT2sCRZvB0Ao54/p6tsmKnHYwKVIGQgDywNs4fTIk5SW5374QOuh08K?=
 =?us-ascii?Q?bAtfukmnpOE+dNYpZ6R8M6qKg+vReXvnpphobT7Wwdy4hYdwlDJZalZZvkbF?=
 =?us-ascii?Q?Ae+g3Qte9Mal28axj4hRu0VQbeKyg+eYKuewdIVN2fmU87SVIoUKtDMWk9Uo?=
 =?us-ascii?Q?CxNN03M128b00YcLpXzh4v1fD9c/sFN6opedZfDES913SInFQ2bqskiIyX3e?=
 =?us-ascii?Q?i8f5qBCADmtAajjQn311ckyGACgsS8uWOyzc/6UHwLuMQh9Yh4NrI2eIP4Bk?=
 =?us-ascii?Q?tCckRpawazQw/yKFz0KVlj54BJIP9/knyWWXEVz9S6XP1+lMudUzh9WsQRMW?=
 =?us-ascii?Q?sGUcydeKTzOWDQ1TGmXvVWnR5auAuTMENTQFO6JCTPf398XFh3IwLgNe/JRf?=
 =?us-ascii?Q?l91jFlTdhSIM+oiGKOHhHi1Vl4UJzr9OJrX+yJZ0HLjABhgoD5Ckj4CD5b+9?=
 =?us-ascii?Q?YV2piaZzorZm9tUEzQ5sR0kx0Ha2khK82GbcFhbFWuWhVvpcPxPJv7PIEEuL?=
 =?us-ascii?Q?IVdkxCHIKNI3WalzV8tn0osiokdHE68Cfq6+teix8TgL8aVLxv7Jq16EZCSF?=
 =?us-ascii?Q?z6++wmMmqlpMms3dJ0mkywrTjfs3NX7uPLxQAJV3h2Eb2IV+EPPW1poOroBj?=
 =?us-ascii?Q?0mHDH/sNVghvXxsnkOtNIPiOpySU8VQnhtZ8uh+xnqCKEfKDHElaV5F9CHww?=
 =?us-ascii?Q?ab7HeKwNbzO6BEgn8nYtNqUynwWB9vagbwnC9Uv+6TpwYYrH+JFVy9PVLHRI?=
 =?us-ascii?Q?XdY/FFIX4LEmLZTPHhtN/ktB4It3k46RLGAOf3AYCgXdhWlfHn9HpVcM1AEK?=
 =?us-ascii?Q?rS0/p2lzyKSZnMreZS0xdXQn6/j6kLErczMlqW1kiYofI4byCl30DwOugDsw?=
 =?us-ascii?Q?dC1HPvsZpeE40jpW8ncD5ke5zrL9pFtKqB4/Sd5GZgGn+QWANjokOSARGAor?=
 =?us-ascii?Q?UTD+37Z0llEF7dyU2j1+wqwASFJqsiuKuepeQ9l2Klw7Oj8WmyIBu8UGOXhC?=
 =?us-ascii?Q?E7zoE/QDlX2a9CGZfAaQ2l28xeMwni+VrGjxrS6Turk6gbeBZ1t/xatvHvIl?=
 =?us-ascii?Q?CveIODkNwGqHnNbDTRUoha7X9kIAAr2oO5EqWvyLuOpiuDlkZ3JnqdRABGXm?=
 =?us-ascii?Q?qBHUhx4glYM5lKUQzku85gYvSkAizk0HbWylG4DsDBHMqWRhgjTcxD2Rjvqh?=
 =?us-ascii?Q?XmNLjgMukdeOfFIAd4uHpPTXWrDOF3u0dQrI5gSYCSWTOWWBFJ8iSI/Rw5Kr?=
 =?us-ascii?Q?YSwyZgTAv+I9ZQMGklyf+EAJyhdYXyQ1n+UER7pEbw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?d9tmOp73Wfo+epHiHt10p84GSiPbIQOj8kCsGgPjKwAJBw53jsfBzpWsb9Dk?=
 =?us-ascii?Q?m+5jclD1gYPcn6dDLiN2ugXg6Jq3fragYSxsuiADAhte5DAbvtQmTbtB6AKw?=
 =?us-ascii?Q?MoQW/QegpjHjdQ3EYJiuBPCk/pODOOiCX5pXdlb9x67Zn+hUDelQnDL7T8uR?=
 =?us-ascii?Q?m9wtGoPVR+oTtDl/iZJvsZdQwWb/nAmvvWEetSYcwsY71czkNqWmKAOac2HC?=
 =?us-ascii?Q?dhD2g+vBTH/skQpNob4s6GaInQpNEPPCC0sosLws81BbJaAioaXZtRyBmoKI?=
 =?us-ascii?Q?vwbS6o3iOyiIj8+A7QoIs+xx5s8DjbwYWQP1dCtBGpBQ0grO6DG5TxB/+YNK?=
 =?us-ascii?Q?8fLWAPrYnZ5H8HOMPbIxXHXvx43uuaQJiDOdbCPPQVQN6ruNnL0vXabXamNw?=
 =?us-ascii?Q?FIfm/oiwP/fO76EHKjMHYt2hTTf5rBVzHWaKD6GHTDFcxguYUsDgd8chVPY0?=
 =?us-ascii?Q?NqA8fzvUJGPDnneDxFzzgsJJRDSBIM9oyflWMdhE9EO2t8lCDXiHwI0iQfm/?=
 =?us-ascii?Q?hUglkOKuokntgqxXmoS/pnh1uRRFj5TPb4Rprdh5h3BP0WK8mhVnw39LYIZ6?=
 =?us-ascii?Q?a4n37r3Y3NPps9l0U4Bua56NtHJxkpx5dgIU+ziV4z1hT+KU+vddqwmonYfa?=
 =?us-ascii?Q?F1NsVW3R6Swk99+VmEaCm9xjaWjjclwF3oQfCSA/m9mpTckyD/BFwolyVSFe?=
 =?us-ascii?Q?1V+er9xymyIgWeSD/R3NLZ00Pss3CuvqQIcZLPI0Efg2yXtrl5dXfSrwsccr?=
 =?us-ascii?Q?SP8JsqdHCo4svkdp7xtzn2H8Gz7+4LaqM67Lc68Qd/SZ2vXwFknTDxoNEKJI?=
 =?us-ascii?Q?LVoT75/MITMsRcNmA/K2segACIIshY7t0eJRvC9rKzV3vPUHA1CzZURbVWnH?=
 =?us-ascii?Q?/U071iBigkiHUcXajzbhBK7qp2x3+++0v3GCVEDG7PFutlZzJy9gbskKqhrQ?=
 =?us-ascii?Q?YlM/LLmBwIXIJ838W23NmyL7ubpAdg+QZfLjkMQwL9gHR8tapoh41ESynbL9?=
 =?us-ascii?Q?zABtIBKQstX8U9b38rUnEkh07CDcOeNOyHspZlI0gksqq5fhb6CTZR5kHKoO?=
 =?us-ascii?Q?j3MZ2adTEFopxYB7ma33KxzxK7OL/TG1dg6+T8UG9fiRFSEMw2+spWySliTk?=
 =?us-ascii?Q?tG5N1UUPy19krq8x73f5djRGVe4XPZjSv5WkS2kx7bOFa0DfmTU+drAvi6Ip?=
 =?us-ascii?Q?xJboyoOgE1NnaswRWE7IFUvVk4qcMEo6EKM49nWlWJ6hLGVsSJsYVC/cZApt?=
 =?us-ascii?Q?HzyoXojlbl6sc+nyYoX0jF/qYCGgZh9Y/xRa1UchqQA0YE5ve43n+ymI0ojc?=
 =?us-ascii?Q?N+HlBVFk9fpEPzAx2JoSBff2RQ8gPZX1RxxW1gyIDWAxMOfWBKMIDbh+y575?=
 =?us-ascii?Q?g0VQApVd9aX+zcdxNOKpGYL8bLfLp/CNsW88zwhrqtUMeyNtHoMq/MkYKxgM?=
 =?us-ascii?Q?U71dPqGHG/vuAE22nkm9OD2Q/zgXElZOhY22Eb3R8j78jTUa1tWh6GNhkIlL?=
 =?us-ascii?Q?ouSmBfxGHG2nmzwHIP2+CcMVORrV5l4BrM5Ckl1JUxIXn5LHI3wpxXj6ELaq?=
 =?us-ascii?Q?CJefdFJoVliUyQ3zrhirWOgt+PJRO22s/6U4KQi8rr1lKNFn9Owi8OfYC9qg?=
 =?us-ascii?Q?tw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	r9FNCbvHqEKbWyXSzXxmKG4CIz7jjRccQjg/N1x/AUb8lwXk0RYPbjcHccYU8g7g4B3KkheXQrZz5ZXsVyPk8UwADuevxMBx/VLCDVySOTMPNdLBJJQECFg7TFbC3XtkqaNomElkhlTYvGQI0i+NA4OBQiqJ14EgND4ZlKNeBOFqVZg5nfdGCD7ca6BP7VqUybjjxaAl0MmU2BIUm2w8oaCZFoP5uTGxCZuLtm//4gSVZPvQsJAqcK0TcJ/GspesIYt/TtFSaxDCSPml7gMVQ35YcLMjc8A4FeHj/8cmPufLmI6rUHEjfeDfuKvMGbxmpZEqUUMIhcuOWgzGLzlM9qmClzbcSTzqh4FSK19pGHZcSnKt6TnGFKxfn4E+94YI+I6mMROOU2kCNdt0OI19i6m57dS1PhBEyhqmcaOIJPyYPN7CFCAgqLM7/VYYDve4Tr8wo0DSsjvaoKQ/+UcPdB6t+0v9IiMdmkMXklvFG5Sn8Umd9SvXqHhP2zmcCwx6tZgNjd3jjM8E/ZlLoCnlNewM63IOBGRmlBvM6wHqke6byf9EmfDgD5UKsKpAdwDDkTj+8pCznGEAOHMMfH9arpeDoakxj6fpVFuR90gMaeM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80f5ef99-799f-42a0-d084-08dc7eae2b50
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 00:36:09.6761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hQYFCqzgeluDJX1y1ACnHkRUpuiZwF5HUa8br5PkePuDk4Fi2naTFECCjawPE06id9JDWNvlZ9Vczd2jCRtyA6l3ybBPE3V1DpjHXIZiteM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7177
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-27_06,2024-05-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405280003
X-Proofpoint-GUID: MgTvxlWSaqDyBlDN7sh6PIKIlgBmHBvZ
X-Proofpoint-ORIG-GUID: MgTvxlWSaqDyBlDN7sh6PIKIlgBmHBvZ

Under PREEMPT_AUTO, CONFIG_PREEMPTION is enabled, and much like
PREEMPT_DYNAMIC, PREEMPT_AUTO also allows for dynamic switching
of preemption models.

The RCU model, however, is fixed at compile time.

Now, RCU typically selects PREEMPT_RCU if CONFIG_PREEMPTION is enabled.
Given the trade-offs between PREEMPT_RCU=y and PREEMPT_RCU=n, some
configurations might prefer the stronger forward-progress guarantees
of PREEMPT_RCU=n.

Accordingly, select PREEMPT_RCU=y only if the user selects
CONFIG_PREEMPT at compile time.

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/rcu/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index e7d2dd267593..9dedb70ac2e6 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -18,7 +18,7 @@ config TREE_RCU
 
 config PREEMPT_RCU
 	bool
-	default y if PREEMPTION
+	default y if (PREEMPT || PREEMPT_DYNAMIC || PREEMPT_RT)
 	select TREE_RCU
 	help
 	  This option selects the RCU implementation that is
-- 
2.31.1


