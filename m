Return-Path: <linux-kernel+bounces-191577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 045CD8D1109
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 02:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D04A6B225E6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 00:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2096E1CA94;
	Tue, 28 May 2024 00:37:22 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F089913CFAF
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 00:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716856641; cv=fail; b=bwe9m35+SnlpuMU6uhDDQjkbrNFnlEL2Da9ouVsyE3SVtPsuy5F8gCUzmGT+Sl6ruAyD4wr3UJvDdbFFkXG8H8ZS1pCeGhukGsEtayorUxOeqCh3utSsVfb+WMlhNIv3MY09VLhsHtcSu1XCyiwhDOzZNQCXpalZc4kBaFuecuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716856641; c=relaxed/simple;
	bh=Hh7g7P3QkviaacmI8bsuKVGg/QOjNTgaUsSh4DIuSqU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S7aTR3D3V+/kJZ2fjc3EZfOTGlTpSsffY9oro1DUPOe3Nx6mIqt9rQmAJb9REBvHvTj70O9UfhLbtf4aCY0V7Wb+8B7ar064E3N48Bt8QaPD9DkcNdMjK7LeC3rCHNAMPZeumXYpc/WfDeAQNFQnYDLyR8O2iuBa2IwmnbhHccg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44RHIDdl011242;
	Tue, 28 May 2024 00:37:03 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3D1gzu+2Xh2YBhraKNYVXIbFY8o0B8DJKjS8/hWnD2p+M=3D;_b?=
 =?UTF-8?Q?=3DkOkDt3ztO8DaEwgd4JiGpUAIfJ7B3CylFmDu+wywuzsDD/vxk8bOLIsf7gkw?=
 =?UTF-8?Q?SREYOV/y_UTQfmPlElSrCQKapNzPeMjMJPF9h6Tf+aT5JqJLIet8NUcAWUtwYe0?=
 =?UTF-8?Q?Fy5+6e5521q7OX_jeDiSMnKIocnx6BUIKMfxZeA+5j9TWN9CSzxuS7fZHgEGp0d?=
 =?UTF-8?Q?s8bhqyyYgoc3mPnJFG6X_vCOK5BR2zZrnysELC7faduEcnRZVm6jwORHpoX4qn2?=
 =?UTF-8?Q?kk174h3joaaSwn3zCUaoXuz+lY_pSnwiomZBZ7psmu5Ww2WebXL6Q6Lqa2xs5OI?=
 =?UTF-8?Q?FjjSgOoWWjTjgzcvYrCdxOwm0yIw0ZtT_hQ=3D=3D_?=
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8hu39em-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 00:37:02 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44RLwlok025981;
	Tue, 28 May 2024 00:37:02 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yc50p7y3e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 00:37:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VlFOy2dcKa1TfWm/RRiFTEcTl5X13QCsMbBOt+/oE1YjqM5rouLBJUrCgCkvWyOecs9afWf/SXxbj3BF5UmRtjMGcfoWQi+c6cdR+mYHTwmAsSeuJS1mErddnOWb9XW2QfMAsDx/pVnjCAAe5r1zMHxJ3BWgJfnNAZHnteiht66ec93Qua9uj2PtnHrEVRWENEUrBwLFvNQ5QuGHAS/rBxRABu5ug0RrpbCwKZd8pniyGcnK3KmqOkVE///pRyMqDiGdFDJdc7Z4iOglbuGSFjWJwpqS5mhoiZEKpNIVQoTUs0P02r0B4a6qKJesZKsmqHy/picTEnOOHQt+XGVI/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1gzu+2Xh2YBhraKNYVXIbFY8o0B8DJKjS8/hWnD2p+M=;
 b=Qv9IFM91kSAJKf8ewp7q9qXZkONc20FBYzDlQK5ck8SFpu9fIChf8Q6ti5q8grCiBBLeuUpe5tzNLWPJVp8hxIzBUW4m7dQil04p0PlElpjXmNNJBExxDLrXYoanQv/tbu9MW+dbfJvmbwoOMeyeFYPK6MGSL+7mpYYesEhs5jjcKbRzmqdJN6sOWnp6yVFw5Og+PAm5XTTehDM6UkqmuvtvBu7xrs6ZdG8OLyJROoIQQ9YMT0nmhR3CaYenLyz9Z5SJu9YajqG+kNp4ECRpjZ2fNpe1cvQ1ndujVvG6hytTm1pfqzFerE9DzYHDXCoZv0NxuKj+IEcxdIcrV5CzqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1gzu+2Xh2YBhraKNYVXIbFY8o0B8DJKjS8/hWnD2p+M=;
 b=YkXUZyHhryWVlJHUYERv4tX7IF/1rh9/xRnBHQubBCR3NxHdGmg6ypRm4Xu+spJqReEoGEE7AHgSLmRhfjxYb4+XJs05Wt9VVewRAwN2vUr5AS4Dlv8dUVHuEaTpABYuR0frrNFBOAu0UkunwuV22w1dc2Hdedy1zFWTFa+gvco=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by BN0PR10MB5077.namprd10.prod.outlook.com (2603:10b6:408:12e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 00:36:59 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%4]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 00:36:58 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, rostedt@goodmis.org, mark.rutland@arm.com,
        juri.lelli@redhat.com, joel@joelfernandes.org, raghavendra.kt@amd.com,
        sshegde@linux.ibm.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, Ankur Arora <ankur.a.arora@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 32/35] Documentation: tracing: add TIF_NEED_RESCHED_LAZY
Date: Mon, 27 May 2024 17:35:18 -0700
Message-Id: <20240528003521.979836-33-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240528003521.979836-1-ankur.a.arora@oracle.com>
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW3PR06CA0015.namprd06.prod.outlook.com
 (2603:10b6:303:2a::20) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|BN0PR10MB5077:EE_
X-MS-Office365-Filtering-Correlation-Id: 383da980-9564-4977-a8cc-08dc7eae4885
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005|7416005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?QQ9dYzj3Thcdubgll45VYMp2BXTCTkvD7VpNR85xZwpTwjpC3KLcFChlWFKn?=
 =?us-ascii?Q?BjWJDbGEk2Wi6jRejUf1aW8+g7bGfc+bYj2DS3MUib3xr/fItK9E6+siT6Zn?=
 =?us-ascii?Q?cHprhlRzGyBwz3LUAhMdbCj1mfCp61yV1UUNJLN0RR9NKgzGySXF0spZHnxL?=
 =?us-ascii?Q?3mPdz65hyh2lFjhf5l7VzCXLU6iIEkMKJhiMgF51RcTSLniKr/+t+BHAVFhr?=
 =?us-ascii?Q?eXTZ7Q07+0Xf9XKWfrZryALGfF7RzvRJNNK0KOtL17TYQ44dsSl/AcpyU8cn?=
 =?us-ascii?Q?1B4Nms1ij8RmS6p0ZXf7W6x+659pmCEyK2AD7bJ9p7DTVpyEHpf2qMnUnAK1?=
 =?us-ascii?Q?JU85u1z5gSv9N2+j7qkmCBdjET+O5D5W0zrYeZzBo+YjOCsCexQ/Tu1jHP0p?=
 =?us-ascii?Q?wVMfiDd3JhpzSs8Z6Ps+sMtlcfbgUZhi5RHVnZFwZ2ItBqY6wc2jdFWJxQy0?=
 =?us-ascii?Q?GTHfE/Cz5mlxQXS4/TaaugI0wHJihV0+Zz/7S3VsCovfeoZOZNjEKLPBJtDa?=
 =?us-ascii?Q?3f4zFETsVv5nfJ9OvITur+gvn0Gy/HOFwSJA323t61sP16LU6+YkC13wfKHU?=
 =?us-ascii?Q?ihOWpq6TeAO5bIQ9/2btnhJNY1MESWxgzd33gwn2Lsn3KVPGM8h6Ss7DuF7l?=
 =?us-ascii?Q?x1LOVorPqoGXaxdEvahxOLQASl3DUe2g3WNHxkULF4TBZ29J8cQrW4jZifs5?=
 =?us-ascii?Q?2WTq3GRGuQdYg3OQZDLWp3khTRrjqJ8POeL7qIOg00AAy6/y/8i8adYJ0jaz?=
 =?us-ascii?Q?3tyUiR7SQQihGgD0z0XF4G/jv9idYqwibUgYtoEgNMBUnPL48PHPTR382yr3?=
 =?us-ascii?Q?M2R5yiXxYfQxFlY0Dc1TE//SGtEoDtuX7Nk8qxHeYBgb3jIheNSbCtida8C3?=
 =?us-ascii?Q?VNB511JsfS0L8Jl7JzLgpu7UvfOUsr/H0PV6KZmgKxxGgTmhwjF/14SIz9Fc?=
 =?us-ascii?Q?aJVBjZnD75j2h+/Xbg60LQ7tbYDQKZUVQsJkUJwxwiECw+7KWXRq5YadqlpN?=
 =?us-ascii?Q?FTK+BqcX+2SpSHj5MLKkDXsxTEk1lOxPJywU8qmtBJGPtmO0o+VdtZa7Z+eD?=
 =?us-ascii?Q?2oY5zPMam+EY6M3LrZP6mmd1zoQ6Xfk8cDP88OfZ3PWisr7q/71Ab2gKES6j?=
 =?us-ascii?Q?j+UtiDBQdNKyLwWHABrBpbiXFtxGDbgcFeUzxt1JObvD9zoc2OUuOht7FWDo?=
 =?us-ascii?Q?UjEeNkH3vEIqUNUFL0qARk+P2CSDO46oFPAouvDxKJG6dBMt3Rsb9YIDrOg?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?uPV+rHm66OLQW/U9bBTJorP5EigrkDb0qgFCr9DamsXoHsOxBnBAgCTRMZCj?=
 =?us-ascii?Q?Q/WTi48HB4aTY/hm/0PweeSoIIDOiDpPw7emQVW1rx8ORdJxh9FsYcxdtzIa?=
 =?us-ascii?Q?xar12tnmZEok7sJwEL1kzXBdO92dgbF+6DbVDqXu+WWENEePUdqCmI8z08ZR?=
 =?us-ascii?Q?JEw9hM33axsyjsQlBnGeeN5Su2B6W5Y9FoystXlGHLhcDUm4O14MkvSEa9/W?=
 =?us-ascii?Q?xOY4RTwOGMBMWR8qYhuTls1WufTQqqurBRcWNhEFUak+j+iwc/uJKI5FBNz8?=
 =?us-ascii?Q?sFK0OHu25oqB5Qn0yNWYau5BHWBq2HHdPI9fIVpJ/MIUNYYXYUQEWGIN6qcS?=
 =?us-ascii?Q?nlffYlYyz0nAZcmWFRgzkNIIGdO1/qZ4UkZOyz20uyGsAXIlVvRgLpvFbPpg?=
 =?us-ascii?Q?R75B/TsPYwgdzIDlP3uD1TCg8ZEUe2XMPzibIR5ZeBJbSkkpo2Gq7JxYEMjV?=
 =?us-ascii?Q?mPeh5elDsAYgyXPgTRC7lsQ0STOjlT0hntIJYssNrsk6bjW44i+tLxXpUVot?=
 =?us-ascii?Q?T0R3A2sCgMCRQYaRKkcYres1x0aKC0fR1tf9Zg08WFGWqm2deUYtdufGN+l3?=
 =?us-ascii?Q?9PfB/bG8VMKiloX9FqEL6/LqscKrRJfBmX+kUPsdkBKBmom3lpPb+1B92Zx4?=
 =?us-ascii?Q?D94QsqAuRDxyOl5OD2G5DOQpSTxO4/EF4t3Kdz6LzZG5wp/Rfxq4OzXaGg/M?=
 =?us-ascii?Q?1Jc6iN4ZVwrEtG3EW6b3ikbftkMIwnmXaxcGQNQRKZiatZTCAjzwfA9bL50G?=
 =?us-ascii?Q?vSu3qdJxkv3mTfWYRvkLLoHtxXWfuUEuRqcBzLFZR1ANlWdM0NLU8NRQk2IJ?=
 =?us-ascii?Q?7dlF9Xs8bz/etFyIg5yk09FSdjHoKZbA1GzEYi+4RLpcqJWdJFw9Heb8vwH8?=
 =?us-ascii?Q?myev6imevsoo5ecKpZfcE/nLululA4aKasS0q6x+OFxtYRnBpXVvm2yuf90j?=
 =?us-ascii?Q?qJL6Ami2SGQeORy0CTXvK+Ec+IW1ztYcKo5FCl3S+RYuL10vFiQ5MbkG13Dd?=
 =?us-ascii?Q?Pt72buJllpcW6f0wmZfHP/zS3gip+9/yuJPABIbi4KrTfx0z88DRII4KFnZf?=
 =?us-ascii?Q?zu1nIn4XOF5qqRmvh5BtByS77g5fcCQjUfu0KRhj3p6DlbBQIkFOQsbP8FhU?=
 =?us-ascii?Q?g8XkgdmRnoHEldMhce6bWczJIjSHjxJIeRXl2xoy0p9iflGXyxryzwOQaR9A?=
 =?us-ascii?Q?MkhhRdrRcdEmHrEHcd1j7CmfZ4ui+CKIeUpCL403zVziCO/uDVZlx2VDku1J?=
 =?us-ascii?Q?OcRJocc3P+yZeATf2XkvZeKDkYiZc3+ZBIzNreGt70ZWjnjZ0Si2Gk6wCnYr?=
 =?us-ascii?Q?lRxVOZ8CnMp5RsfGNwfacaJFdrnKb3GaQ+8tE+pDhFXueQTJ3jxfQcVfNxGG?=
 =?us-ascii?Q?KFaRNeoGbLdiBpUBsWpXKyCChbf7ECJLyarDm5UU062qX0xLj6hmXoPyv+3o?=
 =?us-ascii?Q?YQr3AcKWo3AK+Dusy1pnEgYempUil0ReU26VQshRH17W8XpLBuPlOs/3iL67?=
 =?us-ascii?Q?YNig+FxYi+k1nr5KqfzyOlE9GvFgdithOUYDHILgyJD13L1EhRKOE7CHOaUu?=
 =?us-ascii?Q?kc/Xx3RHULpRuCm1BORz4nbeFqRHzWxBq7xerJbZxPMAofszRwikvqh+aM/R?=
 =?us-ascii?Q?HQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	mDE18V+hpelZC1UTy37OiXAIimqGO0lWDApd5GOtL1nchWkLL7GGTIT5gL9Lz8gCMiqPAFd5SqRKLq+kXdgQgj8rCu9pkxm+LC/dIWlkOQpLRH941oUaaAktsYKC7jd8DSVHzdPFrR3iHYmj7MMc2wI3wxrc/0dOzql9Q4MQgKCtTt8Hvmsz/3m+jumtNgcCJ3/Srv1X4TRLpU4lDALM2FGBzpD4oi4wCXS4PTOlzweWcKwMIy8UggqqWWFuj2ul5xYT5av+jj9K9wszBf/k4WDe2AwFsceCWRXeazWMNIqb5/FlOw7eq+uU4Xfb7ym8Yl96tuqiKDANALSnHkIWFQ/DSWE7xvHCnwOVs9Nvhc6ou8/h56rlMCyDXnn5c5Il3tWuKhCMaum0CS6IDtNEOvEY/557lskSXIFwj9VOYezYGq7uwpMWMfQa75KtrDT6cXvFGm0CWUg3StyQyubJ4fywhzuBpdFz78MczT1cANdFKaUv+QK+9NetxCs2agSpgE7HjtHPPyOKjbeVriCcpsGnp/UzuTRkgu7xsQSAClH9w1hlJDkfYWSvIJNJuTQ8Lvnen5tfYocVOjDfqZvRN7thbR79uHOFdQ6Nrc+0f8c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 383da980-9564-4977-a8cc-08dc7eae4885
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 00:36:58.6537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TxcPwQuYWg0aQJ4YYu4I2LdPWMQoPWCZVmF/PCWcrDyrF45A8YFIEdA4UP6tU6/o6p6SCdXxQHSf3kuesdfDorRs5XwjEaHTENwEplprkgE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5077
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-27_06,2024-05-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=862 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405280003
X-Proofpoint-ORIG-GUID: kZH_przXJO-B2xpU1_v6nScRxLcS7drZ
X-Proofpoint-GUID: kZH_przXJO-B2xpU1_v6nScRxLcS7drZ

Document various combinations of resched flags.

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Originally-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/lkml/87jzshhexi.ffs@tglx/
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 Documentation/trace/ftrace.rst | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index 7e7b8ec17934..7f20c0bae009 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -1036,8 +1036,12 @@ explains which is which.
 		be printed here.
 
   need-resched:
-	- 'N' both TIF_NEED_RESCHED and PREEMPT_NEED_RESCHED is set,
+	- 'B' all three, TIF_NEED_RESCHED, TIF_NEED_RESCHED_LAZY and PREEMPT_NEED_RESCHED are set,
+	- 'N' both TIF_NEED_RESCHED and PREEMPT_NEED_RESCHED are set,
+	- 'L' both TIF_NEED_RESCHED_LAZY and PREEMPT_NEED_RESCHED are set,
+	- 'b' both TIF_NEED_RESCHED and TIF_NEED_RESCHED_LAZY are set,
 	- 'n' only TIF_NEED_RESCHED is set,
+	- 'l' only TIF_NEED_RESCHED_LAZY is set,
 	- 'p' only PREEMPT_NEED_RESCHED is set,
 	- '.' otherwise.
 
-- 
2.31.1


