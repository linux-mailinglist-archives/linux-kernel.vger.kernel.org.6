Return-Path: <linux-kernel+bounces-255627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 026609342FC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 22:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76B5B1F2376E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 20:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAEF919149B;
	Wed, 17 Jul 2024 20:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YJtJR1aJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Rk12HtaU"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E343190074
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 20:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721246884; cv=fail; b=pNJMkPPkSls3n8l1uoSY0+JWeu+uGz7qR8sKl6O9lID8wnkGXwiZnhv2DvPZCwNtDs4zmg8ekXYUYph+Ey60K4CoHNa881mQhGQZSJQkCUKDkTB3SU9rpwRNdyP/cp2ldUR3hiwBPo2bPkEF3RC/3b/IZQlrM6DdSvSY+w7bgSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721246884; c=relaxed/simple;
	bh=eEExHOHq4j7tkHp9ro3kOjJjyQXpaotOoRKT5wkyWAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HOuuvckVfCblijorwGYsbDKsgCNxq0nJRYcQ9RlgazYfXaUqt+5nunaAYj/OV/RQ2ywYjeFWhfJa8OuTzDfmuelozU9Nbk9CHEO9c+qS+z/UdwyIW0PWEK+waSD86+7aR1BbRD7k9jf4woqjHtGudGKuZlsihoSTy7QWtSodvmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YJtJR1aJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Rk12HtaU; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46HJsRp6016980;
	Wed, 17 Jul 2024 20:07:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=0BaWiKTmL5k+MzajqRbdkupIu6HCcw1ZcSuzW844wgw=; b=
	YJtJR1aJw2jVohMrMmS0IF8HW7gRhl8vuiFra21mX0eLONTEIVAutIYDhc3Y1e9C
	+B5fgP+gpsEH55dgufX/YEd3erNP+lzDqIAKQbZnwA+Y8o0v1eLCgTlRsu1evczu
	9C42ua3S+6PXBjkTOFDp/P9O0CPYr320C8eMDosT4WMKWPfLMha0/4YunULAUpi4
	9+b+9hGzq7db6lUY14cCUqEN6P2E59r9vAC3sqkCUEvgzFzo9Fkd8yxrIMMYpGVK
	G5skKKI28bzO4bHQsUsfRWPC2sMvC6srI8imd0DLSogU00BJ7jW8LN1927neP24e
	23OK6vO0b4lGERJH1A0djA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40em3m033t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jul 2024 20:07:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46HJIY6J003738;
	Wed, 17 Jul 2024 20:07:48 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2174.outbound.protection.outlook.com [104.47.73.174])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40dweyhkpk-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jul 2024 20:07:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P1Ld24LK8hRV3kTR7gZvwP4mXjXjiFimV4j+4IVYeeT+PfGh+FyKXERZGkOSr78wpX05WfzporEG48lUHt7oOJfAQHrvfe8NeRkUnrXWvkQwAYv6B48c54GCCP9ZlXjgshcLe9SR/JNzuM3Eo8aFp9a/w5RIazz2xs1dl3tefErvn6stFc08y4OF0aLdVpiZuKbr7LeJkAXblwER+nGyYvrC0P5Cgiyc6cYrTqzFQv7/bIChG/GO6QV4qRNLDT59DG6DR/6xBHeWDXNfp6CKd9cLx/NdA5/zOIthEgQP2aepdHGGPYoGrwjRa8lCvHERgydzevoWJ++faJOhHK8Ngw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0BaWiKTmL5k+MzajqRbdkupIu6HCcw1ZcSuzW844wgw=;
 b=cR7+T6CYQqOh8gXYPnSns/Kr5C3Z2KZVN1avTxW/GFtfW6ppYzyB/xhhTbxtlrP+IF+4e+JbdVSmUr8vD4Xp8gAtOjaepQMb5U1aTM07mlvdK9U764KYJrFjaVxT5+vVXRIr02qyiBoqgx5pezDZJONiEuGXYb6jGalKvrlq3GI0H9wwf2rzPAWDK6WyEkKbWUBcTbIY/XEZazVtsYBGTtSBlqhQN2ROz2Ojb2oL4hhzmiG/r9ikpTdjHegqX6vfg9zGZd+1by+8ox6TH3aNmcuOWI1D53o91XaG1GgVpHJOy/9Fbg3fdSycWKk0yyCg/ZA0lyaWb1btYBHflC8YCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0BaWiKTmL5k+MzajqRbdkupIu6HCcw1ZcSuzW844wgw=;
 b=Rk12HtaUqHvgf9THmGZWRndZAQ6BfD9gERU1HkDDW1wvcTr8sRX6EpU/e94b8WlUFkfYoIKYHPIrolX2+1wldo1iEWC/mGCwnAUCAstjLkzJ9qxZG1eoUTXtWjDT1o5/iRPHMrGC6qGw3uiDQSd+Gm4PjHS67IoJaRjmMUFZt4A=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by DM4PR10MB7507.namprd10.prod.outlook.com (2603:10b6:8:187::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Wed, 17 Jul
 2024 20:07:45 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 20:07:45 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
        Jeff Xu <jeffxu@chromium.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Subject: [PATCH v5 15/21] mm/mmap: Use PHYS_PFN in mmap_region()
Date: Wed, 17 Jul 2024 16:07:03 -0400
Message-ID: <20240717200709.1552558-16-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240717200709.1552558-1-Liam.Howlett@oracle.com>
References: <20240717200709.1552558-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0034.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::16) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|DM4PR10MB7507:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dc7fadd-b0b8-4e12-a5c4-08dca69c1f61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?V+wEtXyUyFDe/Quihil2olE7jxBr6Ir2knpvIlIz3cYwIFbTwStJ5YyF9Uh4?=
 =?us-ascii?Q?UNi9G0Ffr4m38Vr7Sb1UssyZo/61PzrVkbWrPhKEdKUx9ubi9kalSqJYPhQ6?=
 =?us-ascii?Q?pJshj9uQB/OV2PybBR4wgAapvnZ/ojLq/+x40anwoPhFG2v73ISkoT+Kawqh?=
 =?us-ascii?Q?RfaijejCrL7+rEoUL8VpMhx3gSBBIs24EqVi4TunxP9pdaN95a1LUf251ipA?=
 =?us-ascii?Q?lqessfvqdJx7CIfjaSGI1iw9DajbHjpj549KguMpEi+Az4hfVJdHgWmAYi9F?=
 =?us-ascii?Q?+Th+6vSuSExURiKEnQ+V1bUSpGS4pKP9yzhObbf1n1g5HTUBXiZJtPE2WfZG?=
 =?us-ascii?Q?+mIAWwio+HFsTOZ+xGV48G5eh38RuzSlWoZB6WDpW+1LgBc2zG3UNu1fuhjR?=
 =?us-ascii?Q?GLs5DnCRxS6GLaPOfz0HtgTQNUqEep9oOyW5KwOhG7L/c/d1NgLkiEcqACh9?=
 =?us-ascii?Q?jSmn/zMrK76aDGisYzogrWiQ4L8RpCY7axJmJcohgYjBabGIrIKadLtpwhmm?=
 =?us-ascii?Q?AfDQgJGMf+nN4rk/cLB88E8svOLZkmKwe+1MuyRdMHJIZcZI6DY5Jjo0iZuY?=
 =?us-ascii?Q?5H5RUnncQpxBycbE3lmFfaA/4+0ahxtgejoXsxmLixcl4e5RCrz0QfEziFxx?=
 =?us-ascii?Q?mF+Pla3nTstgjlCtHQyD5AYubqO2kJMD64U9cc11rlbZIDGyzDv5jlTvfX25?=
 =?us-ascii?Q?+ALp9u+nk/qUM3PXjuj9eQ/6tux1GR8bAwSS07SHciGO4+8Xt67sxJg2xVvA?=
 =?us-ascii?Q?DH9IAtujGA11xYWSOGMNiZePKzi4r6j/zUC/c9H9loPrrEGLsF/FX/hRul61?=
 =?us-ascii?Q?voEXT4xoX1aHKwvmOh1dp9FLj9jx5U3BFjyFNdWRRBavp8k+qoGu4pmC9iMd?=
 =?us-ascii?Q?EVnK5WXqTHVwCtM0FuFpuUs6/N2TFpGtAYkEhUW6JlWtJXJPBB7A4X3lacmE?=
 =?us-ascii?Q?04MlUiqjpva5DJXU9GxSDKtN9+JeP0fZhOiswoO5gIJHFFcEAO0i2qnpl+tF?=
 =?us-ascii?Q?RLdzM7eEEymQy0FGXuWFQL0gaU3Mx5jcY8JuysWFHFNRyvJPBPO0FJ/2e6+W?=
 =?us-ascii?Q?C9u/gDCmbVXpS3YzcETZryxW79LezUF2SAQQGjpLYG2IzrQUXx2XRU6cFhGI?=
 =?us-ascii?Q?1eGbsXVFKyntFI55IGqVVRgEcpnWAp6Kq8iSBCv5cuhdwl9u7Kv3vxbEKJe/?=
 =?us-ascii?Q?qxLJwfhEPrLfT8rdCHYSs2eVn9ih3GKGw4achP1srQWGg/mrixgQsVU7vpAZ?=
 =?us-ascii?Q?ZhSsMwcQXotFOmaN8zQcyovp1oPkXXI0k1bqDqI4bCHVfAdeJMaKLg/Efemb?=
 =?us-ascii?Q?j6n9JPO+Kme8eFHBCS+se2P2YUVvs1dehduYhPtI0+f+jw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Bc/OnrVn+Hzg2nyFYy+aXmqOjw7rqNp2rq0rbQMYcfmS/tMiixig/wEq7ACm?=
 =?us-ascii?Q?FWVx8fSEPL2u0BHfgXJeM0P1+XcmlOh3xoJG6LLl1sH2YmKjD0ZQlhnfdm3V?=
 =?us-ascii?Q?SFLnLxGGqZv7YS70HDnuEa0H5VP6N2HYepD+aUxpRRIXB8WIei8S/vcKSmBV?=
 =?us-ascii?Q?FWtaf45p7/jiJb+dmVwdeuSMS6/AHdV720BTuZ8tvUawvk2f86VLVgMdu3rk?=
 =?us-ascii?Q?yuQO/0WKXgXXcc0UJ8ASY+N9UJ/15OdTQmov9HSgMz6anG8cEMd69GR1So5v?=
 =?us-ascii?Q?Z4GruEY8jEIHMtrUw+scRylLjoo/MN6WbCoGoV1WcSNLhv8GK9lftGkwzDTn?=
 =?us-ascii?Q?hDEPFQ+33Ffw+1rrx38eN0/F+It8nRqxTSRVx2AWQJCRziU0GqUhPqJ5PbzV?=
 =?us-ascii?Q?GaJp+nLGLuwMue/2A+BIRHQlYPLMqOqEQEGOa1TRyQfPO2uSz+exjAFU52RT?=
 =?us-ascii?Q?h6u4DL2T4l7Tmlshe49ZziyafSEhqyF/Okock572taxpsRjnJ7j+7ToAyGL2?=
 =?us-ascii?Q?Ki85ZpyjJYONbdH8qWxcx9eiE275E4p6qmBHrqgdzIP/bk2uAYXO9nF11N4U?=
 =?us-ascii?Q?GInG/VktJ4Y3G9KZ//rEAMiW5SD5N2W2yxjMWZLimFUQGcnXY6yda4sROnvz?=
 =?us-ascii?Q?UqsD1FF5JMAv8o0X4J4DYqQ09ZwFz85vwiMp4J8gGnHJalnJSThkYOvPb2Mi?=
 =?us-ascii?Q?vMDYyONBaq0YSDrWXhZ9nwXOAD5Wpq2k6S4qw4dZt2VCPwFJfoBlqTqe/S7K?=
 =?us-ascii?Q?gBKu9zZ3D1L9QYyj/M2qRRb8RTk4GYD7Jde7NwiJQRTPInRpMAi56VroxStS?=
 =?us-ascii?Q?nDt6144DzcPXnnzaQ/a5+kPnexW6KtIzXWfWlf4kFdZUNn+wwPqNEZ6I6n4D?=
 =?us-ascii?Q?f9pTSyZT/1XyWiJ2YMxCg2IVSU14YmuAJc/rD5bXz7wCnQyLXtLRB3W81d8n?=
 =?us-ascii?Q?lvO9ApJ9npqjyr7LSfCpadL73/8W/pP27jb3BfotjNicIl2TvBB24BLDLQqF?=
 =?us-ascii?Q?wOuM3B6yHwcu2UKpfGlV3eyqIVeOSkFS2/dsnATrf6IyusvhfXdCMku9k82D?=
 =?us-ascii?Q?hJ49h4JWZ7UPDoLmqKGygtsilc0SSYbnxyrHaBmfUcYRp7OftyYldo8Hg5yJ?=
 =?us-ascii?Q?FWbhvYM7Rp9iaYS6zS49fuOMyLBF7b1iRgmqgL5Oki40nwI8QdJkW95AMVqv?=
 =?us-ascii?Q?maP9ThuiFnjTT0FyHXrbqjNq+XI6sPZPE0/41pgnsP4/zxchrqkBUJpB2ne3?=
 =?us-ascii?Q?j7S0Nj916kuWzZpknLaUI1jrbG1KAqo3hz6F/JTbKq/x2ksBc6XSqto/Sj/Q?=
 =?us-ascii?Q?Dn6XFr+DrnoRQNTvR1Go40O1iu3xKHRrFTKgSCEhGSyk5lg5S0CqIA3ABwHC?=
 =?us-ascii?Q?eGlOAOypTTJL4ARBuiaRlzdH7g/HoTQhWiFFnkbU8egQbnhvBqlBhnpR3cnD?=
 =?us-ascii?Q?9GebH45BFZaxeLvlyK3taZEfmkjoA+9TE/J5yKfYKF4c84nyxJovwnUixIyk?=
 =?us-ascii?Q?ZnYDeHrA2DipEyAlhPQD+mg7Oc6GHE3mA6ZBmU1s93Ih03bxLfXMMfpmtSHW?=
 =?us-ascii?Q?BE9jZnlFdoMTIR1Df554kTAB4dtMVP9GokPKlWHcuqK2ZymeuUbEXFd2Iq7v?=
 =?us-ascii?Q?vQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	GOOj/1HjxAgxkUosa4U3StxeFtLt/WpgJjqO49Se2g3ZjBz/evLeWxcXZOCm4CDanGEvNc/rDjF7/JvWZJljcyoK0mUssPdKNNfSYKoLoMg/Rldh3ppg30UwGLkDDPc5jwNAX01TP58ndyVcHRmF6GxTYaG80PxsghwylocmtzTkKx59z64irnIWBh9tlcoGsbVxHuZco8NJOCPj4wdmc8BXgT8zO3N54uQS/R79K8n6tKOvQuTWN35Zn5qsJ1cNHq3ui/RqvRibQxhaQabZbvU2d0Jq/p+Iiekmd/XJq4jlIx5ZDGtUsP+fCdiOQoyvkVPZypJoUxM2+qSjLx6HQXJ/VpbkXShuKlW+QfG3PSmG4MqKNhHXgxUA6Dy3WFI37b3SKR6KUzlburxR6KgnO6FPmP17b3ua84uZI6riJQ3NNaBQfNO0DVItAZAXV5IeoFNo6z2C5F/STGNuBeIzTOYJ/f4AmVYsGmpryMMVWMMrDurrP7f/QnsQ78jbpfaef4kfoLxGGI/1m7FHzcH6AkbzfrG+dBxJk7OO5Wvxp8HRP7bWkcn6w4cS5Ti6BrBaROwFvCn7XysHZbhLvzVhMk3Tk8FtRnUhpQNKLFtxTXM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dc7fadd-b0b8-4e12-a5c4-08dca69c1f61
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 20:07:45.2592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T67CdT9UamGa5FNdKMa2fU6v4z75wr++3s32tmTvqVbr6N5HzH0FrGyCnq/7FLs/3VMZeg5AIevREB10++ejcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7507
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_15,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407170152
X-Proofpoint-ORIG-GUID: i15cWQNC84QuNNyqJ0Bp1gfmyk4gk1gx
X-Proofpoint-GUID: i15cWQNC84QuNNyqJ0Bp1gfmyk4gk1gx

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Instead of shifting the length by PAGE_SIZE, use PHYS_PFN.  Also use the
existing local variable everywhere instead of some of the time.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/mmap.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 0b7aa2c46cec..45fb8725a6c5 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2971,7 +2971,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma = NULL;
 	struct vm_area_struct *next, *prev, *merge;
-	pgoff_t pglen = len >> PAGE_SHIFT;
+	pgoff_t pglen = PHYS_PFN(len);
 	unsigned long charged = 0;
 	struct vma_munmap_struct vms;
 	struct ma_state mas_detach;
@@ -2991,7 +2991,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	 * MAP_FIXED may remove pages of mappings that intersects with requested
 	 * mapping. Account for the pages it would unmap.
 	 */
-	if (!may_expand_vm(mm, vm_flags, (len >> PAGE_SHIFT) - nr_pages))
+	if (!may_expand_vm(mm, vm_flags, pglen - nr_pages))
 		return -ENOMEM;
 
 	if (unlikely(!can_modify_mm(mm, addr, end)))
@@ -3025,7 +3025,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	 * Private writable mapping: check memory availability
 	 */
 	if (accountable_mapping(file, vm_flags)) {
-		charged = len >> PAGE_SHIFT;
+		charged = pglen;
 		charged -= nr_accounted;
 		if (security_vm_enough_memory_mm(mm, charged))
 			goto abort_munmap;
@@ -3185,14 +3185,14 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	if (vms.nr_pages)
 		vms_complete_munmap_vmas(&vms, &mas_detach);
 
-	vm_stat_account(mm, vm_flags, len >> PAGE_SHIFT);
+	vm_stat_account(mm, vm_flags, pglen);
 	if (vm_flags & VM_LOCKED) {
 		if ((vm_flags & VM_SPECIAL) || vma_is_dax(vma) ||
 					is_vm_hugetlb_page(vma) ||
 					vma == get_gate_vma(current->mm))
 			vm_flags_clear(vma, VM_LOCKED_MASK);
 		else
-			mm->locked_vm += (len >> PAGE_SHIFT);
+			mm->locked_vm += pglen;
 	}
 
 	if (file)
-- 
2.43.0


