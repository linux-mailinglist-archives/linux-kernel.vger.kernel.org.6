Return-Path: <linux-kernel+bounces-201195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4398FBAC6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 19:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DECD11F22069
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 17:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A947114E2CD;
	Tue,  4 Jun 2024 17:42:46 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C13E14D70C
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 17:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717522965; cv=fail; b=gb5WHp40W9Hu71N9OOO9aVVDFVRfa6xmikcoLYgjSol8FXKInoEzkqLco9nbdslyJ88NwgDeaIr+g4jPfrt2aLLzYFdnav6PaIOTktBOzYv1lXUnU1eV8R/ExvIEVkMP4pbP5zOO3dqnEeqXm617cROHiJs9aohER32FdieE9sg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717522965; c=relaxed/simple;
	bh=Pt/9dUu4Lw/XzB+VJ4+0W1s0xT1SH0tGyEQkHEEwXvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AcLGfHE30u+RtAeIyldsoC0d44D4Qi0PJT3It1+LWVuofMdRJe7wB/j7Z3F/L7pgIE0hwLmth/ZM/OXLfmMLc3TYnOeHa8WriRjkGZl2kp7dapYd4+aT7jyOZbL2QCT5a8rbCfhICvpHjkF8/E1a2LnUmNSaTD9Ul6urzwaCccE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 454BnRkg026498;
	Tue, 4 Jun 2024 17:42:27 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DWeX6GL25hnGC9aDaBruf9RjJKsgQfe5nXvPBB1WbfRE=3D;_b?=
 =?UTF-8?Q?=3DQRrkR52dgdB8E69+PjPNGWyEEZGkYiIdHhMn2Tro5Ma3d/co0Zd1e4GDR7GI?=
 =?UTF-8?Q?0k7furWw_Of9rQLLdeyDfRg9GVBQhyrWzRar/EMpbgb7y/dli1PgOqD2s16DpOZ?=
 =?UTF-8?Q?CNppwJiR/cPw9g_vbIlBojRNoclYka/x29Gqi8IEuhbykapAwEtngqZIL7i3s5C?=
 =?UTF-8?Q?tLnU1oJ4Wu7P5Q+mhh9I_hqdnpYSLjdj9hReVw0znSKwIhtN/A6pD3no1Ajbx/a?=
 =?UTF-8?Q?90EfHKT4NmWYA5t/2psUxcYBwG_awHZ1lyGKOhkWNmMx5/4AFA++OWAtBaWXcDk?=
 =?UTF-8?Q?wx1AN745lc9MCBNs2c2c6e3dSplqEZ43_dw=3D=3D_?=
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yfv07wjyn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 17:42:27 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 454HaZ5b005523;
	Tue, 4 Jun 2024 17:42:26 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2048.outbound.protection.outlook.com [104.47.55.48])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrmdwneg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 17:42:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NM6v0rhj+1nwdIn3+vXXhvhVY5r/j0jkr/iQiZHHxlNeDHwtihXdBO9MuHHZidSTEnQNBo+rSDqIoEMS7DLMAXFVZclZMFvIk2ccGKLOcjMQakKRcSBcMY7U+tbjOVfVVaYpinFvWbH1IFmFbM7zrpdffKHI9U1fX0i8xVja08RzbHBkWKiNXRuvcQjnrX0mYU90eR2gfjw5vWovVAdQVONmO12vE25SVUL2fgGnuuttK+10phZiVHLeaq23GiIpAkCKjBGvgOFhYInmYeGqYMCfsCALXmF61gnNyr/wqCo2o9Y2YQ8wu2D617kSy52hzVvky4lzXtA2+biotIqxMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WeX6GL25hnGC9aDaBruf9RjJKsgQfe5nXvPBB1WbfRE=;
 b=AMZOf/piO3d1rYFP5JBg7BSXFoUf5MPWgEax/GPDQF2tsV+BRCFAjlBUF+6PRD5lxvg6SBna9eM7S6+vGUkLFM2D0mEWMneug7kSfJdgPmChuVQE5qItJ1ors1QIzbQPN8/PRQ7lnBU0BM56l6UQ3uX3+k7b2MK7G+Rrma0Cr72R8yZrqhlR/AfbkWu2++Gh0yGPCO9M1a8F2JusXXOfEjcsDaxW/APP90OnUWM0O7ayStf2gfVHeqX09SN7/w8CRVfwK1uAkSsmnEFhW+LGbeTx5JAs1rHjV2jjM0Y5ZrAm91mwMHMLLYYEggR1Ub0u9+dFBi/o5DxO77lN0OxpaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WeX6GL25hnGC9aDaBruf9RjJKsgQfe5nXvPBB1WbfRE=;
 b=ndMT0opIC9U3z7y7JtW2tnRaUQynlyL9O1lDPoLsm7MP3UVD6Mw1NVKks5NB4pxYxGVhZIxX3eQj7g6g6DjKcxirmr7jOfr/2WgCOBYW2K4+1iYO41sws+kQCZnFKCfYAo/QFWKSB1RrgHEa5+IRfabJZIEHKc4Np32Ut1HPHHw=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Tue, 4 Jun
 2024 17:42:24 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%7]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 17:42:24 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        zhangpeng.00@bytedance.com, willy@infradead.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH 15/18] maple_tree: have mas_store() allocate nodes if needed
Date: Tue,  4 Jun 2024 10:41:42 -0700
Message-ID: <20240604174145.563900-16-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604174145.563900-1-sidhartha.kumar@oracle.com>
References: <20240604174145.563900-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0047.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::22) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|PH0PR10MB5893:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ac6587b-87c1-42be-d999-08dc84bdb15c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?r00WyTM7Y1RnVW/wjBUuT+CLcybtSUe1cLn+KavO7kwl+K+0h2c4l91MpxFy?=
 =?us-ascii?Q?Q7u36sqp3hwoqUmgDIQySs3ovSZNYP5UdwDmb0msZd30QxWxfZnm1js4+JEf?=
 =?us-ascii?Q?tQ+cf85ayj6EWOh7TfQPb07IvzNv+rujiga8yDII19fEuKkOSCefBlUFd10K?=
 =?us-ascii?Q?hGcf2pose0Zd2hu4004zjNNA1u1JgX/WDFPoB38TKQOrAdMA2dLx+Szc1tui?=
 =?us-ascii?Q?cCyGRBNxKBpp3L7REYLAbjeAAQNJ41IRFEPQeN3qwafN6FdTVnkrPNl7C8Dg?=
 =?us-ascii?Q?sBifmTQc9ALOG0EUbTSF8Kv96eTW9skU2J1ym+cEGqhNsF+W47sWTQCyQgl8?=
 =?us-ascii?Q?CbrSI18Gk7UI9m9/rrHcS8o/Tl4pQDqr8ETAXl30QTGWgxEoVRbABPJDR20I?=
 =?us-ascii?Q?nWK7XhSagr75KUXhrneWgEcMmg/KylPVPDLxNtqZ+EcooIjdBW2ECsDnrytP?=
 =?us-ascii?Q?x/tl03z3tYbe7wfsHaQheHITi9/RQZ3OC4VEv0NxvG6G3RLw6iVOke48plw4?=
 =?us-ascii?Q?8knkvG+V6M95Tq54hszvTYgE6HGYU0fX1s//v8GqllNn34mWj7KyPuVfUJQC?=
 =?us-ascii?Q?eHgfr4deOyh7YZDbBbWwGC3YcwRdRQHNbFxXsKdZygdtQLZYCK/jH6pjFwYC?=
 =?us-ascii?Q?GVDgDU4/qm704GF+ZFU+ptbRNJu619KdWKW3VrvdZYTAaX2wQFrPn/Pgz0AR?=
 =?us-ascii?Q?DbKWxy/aijGF1zekPDs/Yyd+8et7q5hVdfs4i+pDbwIGdRE6+Y4AND6nKc37?=
 =?us-ascii?Q?kpcXpN6Ux1yhWFHBc84bdT7XwA4X2BMMIRKJNbGIh0+gQqZVoSyS9HuJJIq4?=
 =?us-ascii?Q?qee+eV9TsLXB3LVPBCMdzwAKJtSKdWLrtwTwI+mId46BFH9QkV1c7yfYoKHV?=
 =?us-ascii?Q?bZ4VZJMU6yrLyzBYJEnxg1t+93tNqyHURNeOBFBKNZfCWJBz4Pptd11YZIc9?=
 =?us-ascii?Q?vE0hCmbk/c+H5lX/3KMKNrQyePIoDLQbBfXqGXZD3LdQRYZEpf2ZDpqJIXxI?=
 =?us-ascii?Q?q9LSd/yOatPHvr/2LFjqsp+jjM8qXf9oVsc02a0fljs3mjHUhZNCa6M57iX8?=
 =?us-ascii?Q?UP8cC8aaA9lILcJYKNNmLhySradhB7CYEFwIHVz13ksU1/IfEKvGJ8ubMDV4?=
 =?us-ascii?Q?xffRRYWYdVyINiB/hsYtHqEDPhldIAV9fQK54PHPdIOjSrPUzUU/U5DbR8MW?=
 =?us-ascii?Q?Da/tSnm8g0upbfaPw8fWo73fJFxdcTfnwQjG6sANImRWxNIGCOshofavRmHh?=
 =?us-ascii?Q?4WHO/rRtFdSgv6S7NQmSouLzSTrzuhMWVjOAw5zt2IxUZ6o+Qqi8S17AODBs?=
 =?us-ascii?Q?RRpZ2BcmukvOud8b3Niq8pnv?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?FUNxPaOKGGIpBDcrulIZDC/9QiyIv+tb4656ixOsth2MzU/mtufgXilcliVL?=
 =?us-ascii?Q?qFvejcR7LhX/hq9LCfk/+sa9j/itQSGUgT3jEpp8smhYB4lC/3ztoHbU4vXP?=
 =?us-ascii?Q?0FYTjln7CYCBdnC07ORnIZWEz610wCOn4u69Ac3DmrujqSsjuu5S2SJh5JZR?=
 =?us-ascii?Q?rnfAqxTPG0oS3sS/GotlfEdRoPLUhgzr6HlvmUcrwXNf2z8RKmJGnhqZPAJ0?=
 =?us-ascii?Q?ZHzbqHwxG1mcYHw3wpWAL6GJbHhHLVwEu6gPxkYCu7/eBRUvIoiy0nNqIy5A?=
 =?us-ascii?Q?1o89GEIG6xk5VDNO8G5GnceHh66SRCatzmu/sOF4PxflT+tXS6nuvSmredzv?=
 =?us-ascii?Q?2qfNKz3tpQwZCntuWslsN845O1wqICEX8dUmbMdqvqjuQza+Y2+eWry0M70R?=
 =?us-ascii?Q?HHOEHNOft0opdIavUhEpTGpNuZfw8Y7pPnQ8AJEcKU2N581nko68IMwtftua?=
 =?us-ascii?Q?fLFJqfFfF/v10D5RVdWwTOsuSUZV/Osc9SzplCpkXVIzT3w5naj5RhuaS6uU?=
 =?us-ascii?Q?mEEonHSmExZU7ofhimR1qo5F+GuZh34JKuMoMpRkBZIg7EfKkhM283oHXFPT?=
 =?us-ascii?Q?WgCgo+zBft1wqf4DzZsbOHgJUEr4q1C+Yq3RFouAopyR8flWd/o0WAdA/2gS?=
 =?us-ascii?Q?8VcBEEaXbLvO54822Rf0Bpjjbo01KAYM68hvrwTEROlWqIDovVVLkQhQyMCo?=
 =?us-ascii?Q?OcSyVn3Nqvz1Ajval44skTPz06Mi+2C5Jzj1VXGtyQTCzZ/UI6fVmXo/AVJh?=
 =?us-ascii?Q?Pjc9/8S4y0lGZrTemknHs5KYvFXtCiOEJBMw2BaKEnZpq1uDljpUBdGZg0tq?=
 =?us-ascii?Q?HIzitf3/nLv2ReJpZR6nyfqNkVX3kx78W9amy6MQHNl6ULsl8rkVRI8qEguM?=
 =?us-ascii?Q?gxu6MwD7Mrb6arBYlLxiRgIbQW55lw/X85YLdmoYQeVp8DQMDwla1oRNWmOQ?=
 =?us-ascii?Q?nR9UbZ79fAWaCGCqrOq/e7B9zViQe2F8Mnf8MsxIDlzRw+cORpmq22pFP2pF?=
 =?us-ascii?Q?A3pJMLunBCfnU5GGWUpQL+QANsVfP1fIiO8e7xYI+xA3bNo5fSh3HmW2PcTl?=
 =?us-ascii?Q?S7G7A5omkZ0gKUIl77pxbEhTLvOZVNjRlFbTeomlPB97VNQIVHfErH1T2aIf?=
 =?us-ascii?Q?x+fjfnHdeiIyHx3+nyzd4M5WElSssncx4xNHhviEqsDHCfBDTJDf0g6zR1xv?=
 =?us-ascii?Q?lhaCrUDAbmbr0ADcdYlatiRBXjeg8I4Nll9zRJe/1BOVbCFoszEektkao94g?=
 =?us-ascii?Q?JOjyJxkcxooKa3PxBpD7j1OiPLwsvbPMakkdxjD88edpi0nSI+ecqLKCF+Gd?=
 =?us-ascii?Q?BrieIeb7J7tP99EJ2P46U99IhrLFLec2K5zIGKRdxR3GflLuyXbcf0xVLC7C?=
 =?us-ascii?Q?RfLl5uFWyH+0eJ+VEf27oVeN9NQp0RU4EyIh5A1ZeaUKM1UwGd3921F5r0h5?=
 =?us-ascii?Q?pgXP8NvU4fORK0j7/Gee9+/jCS21/u09gwFs9EF3p6R+HBFUEgWfvEdNUGE8?=
 =?us-ascii?Q?smmyxXg0S4E62LRWVtRd2Gar/eDl2/VQM1U3QT9BoouJZIPa7b9XB97xs9Qs?=
 =?us-ascii?Q?9eRrFh0eWoENYYvZS6tNWBDnOlBwhrd3Sc/ZNhKnSR7oygb0sPmD7NZKj/2N?=
 =?us-ascii?Q?sF32YkfZ8jCgFt23NDVt9oY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ptiEZJZFUa7z2lIyCMEHEZM8yel5ja2Anf0cJxGFI6/zwFfbO4rOkhG2u7cGtYpWT1ln+4KYFcr8Qm7ReTVb3wFMbErot1BVFJIGVAcNukSyBvxS2FYHm/HdtU/MnHel7Ty1WeWEocBrxTPGUelPTQ9ijf/Jy6scSQe6hNu14cFGUzFuYz531aVr45PF3iKsfZEdaO6tA9lmil1MWWsYz+aIQZLpo88TTPFNsgR5VX7HW3/7QCfu4sDRBOz1EJ50t/ibbVsE0NcVw3HZLw0fZgbYmPHu8tCWoJV6ZZYLPF/V6fMTC8YWllgHjw02lZnqB1LbSfs0lQEt0AlVPnMTzQo6qUxmRELaj5/C19OirYk66d4tYkiSZ9wrP6KbqjL7KTmGJO5dh6XoonK1GJe8NL0XcS1FGgO4ErNqlZnOfK+t2lK3NnmxTcLL3ry9tD0pHjL0OaB5OUaNu1BgJSNZEqmzqUg88SwOXNykLzOEjVKx7qXdZD9JL4rK+DwKBeStWsVhO7/Ek9g7yQEuG6vmsfUEHCgewpXiw/KNKSNZScBk/oy0+zD6YVG27ehROcsq+ae7/nD4BeMfRC6QFIlZFQJpUL2hP3ff0JRaw3YFc2M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ac6587b-87c1-42be-d999-08dc84bdb15c
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 17:42:24.0725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wOBtlI6fABzyiKXYfONatcmFi0A4OoYPogci3Cnri53ViV6XFBpFVvuua2z0OZIjBedNPGBOtGFvLA7GxnNQoeChtQ+aD63RaB+q9OI4F+o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5893
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_09,2024-06-04_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406040142
X-Proofpoint-GUID: -P_sf5WsdP8KvgGPyKUYg2Zhc89639JI
X-Proofpoint-ORIG-GUID: -P_sf5WsdP8KvgGPyKUYg2Zhc89639JI

Not all users of mas_store() enter with nodes already preallocated.
Check for the MA_STATE_PREALLOC flag to decide whether to preallocate nodes
within mas_store() rather than relying on future write helper functions
to perform the allocations. This allows the write helper functions to be
simplified as they do not have to do checks to make sure there are
enough allocated nodes to perform the write.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 lib/maple_tree.c | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 74c89aad8bca..42853afc3885 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5527,6 +5527,20 @@ static inline void mte_destroy_walk(struct maple_enode *enode,
 		mt_destroy_walk(enode, mt, true);
 	}
 }
+
+static inline void mas_wr_store_prealloc(struct ma_wr_state *wr_mas, void *entry)
+{
+	struct ma_state *mas = wr_mas->mas;
+	int request;
+
+	mas_wr_prealloc_setup(wr_mas);
+	mas_wr_store_type(wr_mas);
+	request = mas_prealloc_calc(mas, entry);
+	if (!request)
+		return;
+
+	mas_node_count(mas, request);
+}
 /* Interface */
 
 /**
@@ -5535,8 +5549,6 @@ static inline void mte_destroy_walk(struct maple_enode *enode,
  * @entry: The entry to store.
  *
  * The @mas->index and @mas->last is used to set the range for the @entry.
- * Note: The @mas should have pre-allocated entries to ensure there is memory to
- * store the entry.  Please see mas_expected_entries()/mas_destroy() for more details.
  *
  * Return: the first entry between mas->index and mas->last or %NULL.
  */
@@ -5562,9 +5574,21 @@ void *mas_store(struct ma_state *mas, void *entry)
 	 * want to examine what happens if a single store operation was to
 	 * overwrite multiple entries within a self-balancing B-Tree.
 	 */
-	mas_wr_prealloc_setup(&wr_mas);
-	mas_wr_store_type(&wr_mas);
+	if (mas->mas_flags & MA_STATE_PREALLOC) {
+		mas_wr_prealloc_setup(&wr_mas);
+		mas_wr_store_type(&wr_mas);
+		mas_wr_store_entry(&wr_mas);
+		MAS_WR_BUG_ON(&wr_mas, mas_is_err(mas));
+		return wr_mas.content;
+	}
+
+	mas_wr_store_prealloc(&wr_mas, entry);
+	WARN_ON_ONCE(mas->store_type == wr_invalid);
+	if (mas_is_err(mas))
+		return NULL;
+
 	mas_wr_store_entry(&wr_mas);
+	mas_destroy(mas);
 	return wr_mas.content;
 }
 EXPORT_SYMBOL_GPL(mas_store);
-- 
2.45.1


