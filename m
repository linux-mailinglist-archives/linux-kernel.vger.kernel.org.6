Return-Path: <linux-kernel+bounces-201229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 244068FBB48
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 20:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDFD228197F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 18:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C8A14A0AD;
	Tue,  4 Jun 2024 18:09:01 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B04B179BC
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 18:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717524540; cv=fail; b=aRKKloCv/fonqJzrwKf0btiQRVDg8FJvjRzEAMAXsJ9D1GYvbIbJDqzXvzAABuNVSCNBT3h2ArWP7/AJjSfoA8VSq/tM3ZOKl/zlloPIuh897o0QCGj1OZM/QznQgGnnHHVs5CJsRZtiBM3pCHf7BeYowqx2JJxrNPwEtV5tCdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717524540; c=relaxed/simple;
	bh=/1IGvK9y9Pd7cEld6Qe5gu0L69+zMxrxw0fIBjRz8Tw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=t4b+qKCoW9DOBjHSoh24xaQPF+363tcEX/VL0b1qRz+fiIcHktieB/CsVhM58/+UfeLNGjtmkeOFMWdtWOb6+a3SqAXKbbyfbGd601MLz8ygIXXCJUqvNmWtzbLgbHZPSUHSLW/sclNYAekZJiQqdYLFvGE1ZpEeNgej5YJLGPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 454Bo0ct024658;
	Tue, 4 Jun 2024 18:08:47 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-type:date:from:in-reply-to:message-id:mime-versio?=
 =?UTF-8?Q?n:references:subject:to;_s=3Dcorp-2023-11-20;_bh=3DLK3mPREP0Bst?=
 =?UTF-8?Q?bBfYop0ovErZ9XiftyVF9fadBRswrgI=3D;_b=3DlNFV9KcqrljPKmoNYxMGb+z?=
 =?UTF-8?Q?uPV83vsDbe3fa8YZ5QQFxCA6OBy8BjhgzgBY6V7I9Q8XF_x5DDxrgXjyICsFUlY?=
 =?UTF-8?Q?OQIDsw2xktn2BjwEqAKo5UJopmAhLRxVdEVKvOf0ZlTrYj4JlRA_PJSAO0wIPxo?=
 =?UTF-8?Q?xtalAiJVM7xsLzSToMwhY/HmV1ixKdyuaLA9MakOoOe670rM8fOF9ZwTx_Em0/4?=
 =?UTF-8?Q?KYrDqofYuj45Z672xmPZYHYTLMwwdPp8FetNzXJFLjD4lDd+VHIg0EMHTHnEcx0?=
 =?UTF-8?Q?_bc7eltRIEoxJX+F1bGmqnlKC/BrZU9ONdUc26K89FfYyUWqcq2/GLE3HBTp7eq?=
 =?UTF-8?Q?QGbZHM_Hg=3D=3D_?=
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yfv3nwkky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 18:08:47 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 454HhkSJ020535;
	Tue, 4 Jun 2024 18:08:46 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrj2ck8b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 18:08:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dSDDAk9LOSqgqTJuIwj13dpMbyat2f+mOc5ZFeAOJBarWDbUjfXSun3w3xyYJ1iz4ht8N7A37DASrIHo5aeWxGHWuVwvoqyps9z9JiDTAFOAHDKhedlinyKvSiE3/h9o2DEUPK8g3IVGxyKxshB//vB83Th0yB4AqZvcV/R0SirNmhD+Tzv4LUbkQXhVgpMjwwgywXaY6uaP9a+RyBKimrE1V6SPGqK4KwLCOFnUaTtzkj1o0EwS32NmOKmCXFsdccmIlcyvT+f31Hu8eiO7fGK9hNd17M5xnByfA5eKIQIyri175ELEABEmV5cihL34ZG7++7vksyViDy2oE4+e2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LK3mPREP0BstbBfYop0ovErZ9XiftyVF9fadBRswrgI=;
 b=I/671d15OKuTucuMh4p4h97w1B6TeR0mT4k/63BWUWbXW2Kgtt7HT/Y8TOrbDqaJrXAPZnDSmKGmOmr/MhovM14Eybn4ZduqCBLf07HUoppE+iU7L0Y1NFragMvLDu97pagJFTh3GPDqXci2wlMGliIdGZcV0R3ZcD9ZGHFQoU4RdmF/JLkZHRceiGVR0gpJhGvmQp+j04BZmF0vo5z+X4NIfpjMsWnU/FG04KzVuvFk1GBYq3U57z0Gq3S4eZ9XwsjpyNF6+aoT404ZwZ/+zEOnRjGy0e/4fo/YzeM+n7EvkFjddUUXgzT1FfD5G/Fj99WpVXwLMFOPSQoFFJZvvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LK3mPREP0BstbBfYop0ovErZ9XiftyVF9fadBRswrgI=;
 b=PlDhvfZFPxGI47hYJgV5OpXEmc79ispnXWTpuMNzI1IgPefg6DSwLqcxJgoIaGinPyN+8JQf0rESFSIq53o09ahC0O/1fm3ux5WngDZHSQhfdIoOxbCjMGFxnEUyIorSxN0XVt0m1Xzt0R5ukWL6XLQTBjP4h4xv4lDucKhGyUM=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by BY5PR10MB4385.namprd10.prod.outlook.com (2603:10b6:a03:20a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Tue, 4 Jun
 2024 18:08:44 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 18:08:43 +0000
Date: Tue, 4 Jun 2024 14:08:42 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: syzbot <syzbot+c67d06ab25a9bc4adf35@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, maple-tree@lists.infradead.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [maple-tree?] BUG: unable to handle kernel paging
 request in mas_walk
Message-ID: <pe4qk33vuo5o2y3cpz6wiz2cpx4d3ka3esqfe4jkayhakb3k2h@7yti4hkgmwvo>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	syzbot <syzbot+c67d06ab25a9bc4adf35@syzkaller.appspotmail.com>, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, maple-tree@lists.infradead.org, syzkaller-bugs@googlegroups.com
References: <00000000000066aa68061a072231@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000066aa68061a072231@google.com>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT4PR01CA0494.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10c::25) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|BY5PR10MB4385:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a776489-4685-460c-5937-08dc84c15f04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?C0kZFK3WnaPeK9EtonuRIVWC6ezm9ddDXwIePZFbp+3bCHw50YS8HnTJlgKW?=
 =?us-ascii?Q?SeiLvQordv6HXsfcyBnhhknT1NG0xVnTAputxo5sjD12hIaiZqWM//qxAvak?=
 =?us-ascii?Q?SrokgmdgPQkRbjEJ+IJZuV/aR5A/Cl5y9/mmgQZtTnkm2QiHnbeaKC757jqA?=
 =?us-ascii?Q?9L/cRCJwugkDSof1TrSY2jhLMWIalzt5UO6KZ/tdKKGfypOGLB86L/tmFZdO?=
 =?us-ascii?Q?gfEB8jOaKUa4UVvdSWjoCo04W4Xg5DSkKwi0qLZpKEiKdENmkcW76+s0X5o1?=
 =?us-ascii?Q?3+9QtccR/9t4o/65DNnYzR5qZ6veEi4GovFHwNRF+qw4BJBlKBODmLST7Qs0?=
 =?us-ascii?Q?mjF2rlMJIUpyV3tl7Hy2ecr5wjMLSpG/D0ERsS95Wm6eVF0Ui0+2shOjyHld?=
 =?us-ascii?Q?8RZm+GF993f2bgK+EmEoBlwwjTcsUE7uOc4+wkZq+0gu0QcQt8vLtPWpKvEI?=
 =?us-ascii?Q?F0kqBkbuDwu2vRbzQI0wj5PUWTDe6zShigwDvxoweflzr5CFCI1aieRvCL/j?=
 =?us-ascii?Q?e/1UP7y0Tn+Xl59aYNa2T7iksuEB6q3i5Q3ex4vdI+8c9GG7s73eYAsJe9Nj?=
 =?us-ascii?Q?4rIzzW9SZlVKkDJ8a3TWslwcV28axknLnehsBLelsZYnt/KVidAjX9jcANVM?=
 =?us-ascii?Q?h06aReao7eMhXt6fuvzMN5L6WSPyTqJ3q3vvTeuJuxabpAswA/7ankvhj/8/?=
 =?us-ascii?Q?tD2k634MyEULjqs92eNLkc/Cw9TNah4NF4yhaGw8m+akPKffLKBm6cOYEQ2M?=
 =?us-ascii?Q?Cx7RjyJADAfjVDRG5WOORJjtutU261qK43f/P36mCwZgKw1iYHrcv58DgWsM?=
 =?us-ascii?Q?7IgwdOEQCWbyeXeDU7vpqnUGcOPZTnvDFz6sX2NJ9k1O1487+iSIpMPNSUqF?=
 =?us-ascii?Q?FKMmx0W6UUBSD3h5CdvhUxKTLUgnK3VqHhEsNcHbD+qckTGZqco5V9oiuwLY?=
 =?us-ascii?Q?/A8VnUyv2Jtw6cnfbDKBbDMhtSgYfMK0sg+qeuNnQ2ino6gSTy/lz+k4QNUU?=
 =?us-ascii?Q?2iKZaiIkcpsBZsCtKqnn7V7RDgKKeYLQJZ14T9ZIWF4vgASr6kDLq4PSP03G?=
 =?us-ascii?Q?CgMyr361HIdPkohnycsbXyqEnl45TjCJdA5XQoGhGPDGl+U/6DbWPn+zsFGq?=
 =?us-ascii?Q?5VfRH3SvRkjZ1UDxcNuJvijReKQnxkifki1LugBt33c7rjqvEUyv/TC1xorn?=
 =?us-ascii?Q?sD2fHvNx7qZYyyb9rkwk0F43G0UpMDKyiXuMNF8X5JN/vBk21CnEMwFp9MIG?=
 =?us-ascii?Q?rMHpSY3xJHHmakceAl/3qRNIUgEuysnUbyYkeAqZSQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?VcOlQ9snzx2ecDn6WxUfOTy2/ho5j96M6Cx+ERu9LVAf7pksIetXPh4PlfcN?=
 =?us-ascii?Q?oRyv0rsmo2q9x9cpcds7dlBy+t4WvOiTxA3/oIQEH9z32LFHl9Dq/nrnmeBI?=
 =?us-ascii?Q?We3WWiKCXbaRXd5PypWqGueP84iAs3riHCgqEqUvnhmWYX2Lhh6U84qtOe/j?=
 =?us-ascii?Q?Z0DqCes7G/Ii90c8fYp44yfqjpXN36gMQ/VxaMR1uYiGj1mTgtNUvKqBVc0J?=
 =?us-ascii?Q?Am9SxHYfBqmsxQMALIU29lTVqlTRxMTfwLblEptYz8vh2hZOenH2Aws/p2Q4?=
 =?us-ascii?Q?zs4Z6CARPVmaS3NME91Im7NwgMD7dyfaVdyrSxlxi5RIS/uLxvYr9QX07+Sh?=
 =?us-ascii?Q?rWQxJdVisbXf26bJ9T0aDRwy3brp6a5RYpctE64e4eoXf3FbF2D21KxEEp71?=
 =?us-ascii?Q?XqOyzg3qESYqDGjgmApHgriACKyUKqzVvEDuE5uqxSc5Km/t6/nzOWqgzddO?=
 =?us-ascii?Q?QglUem05sqjqUvJZGlDvVyHZ/jnX9cgRxgu3dMReGOaHRGU+qD75qQ4R3VJ3?=
 =?us-ascii?Q?Mc9UWo1ZrBczIyo/zlRw8b+UoO01LhOHzJ1AoFQBYGGb6rZqwZy/hxGU5TRt?=
 =?us-ascii?Q?mY/td31wGfoW5uhBLoiizT6NYNFCxST3yDp9YwY8eThQDsOGrQWv9gBnb1A+?=
 =?us-ascii?Q?RDmemBQfBcdCI8wFgBKqGmDdkhRR1CdhtIpxH1iFKp2flA35YjC/lU0tNmAe?=
 =?us-ascii?Q?GrRRwDx6SWfQ/ho4GZiP1WyunKoqpW8nNfCsAXLSblVkWryiWR+fsEQOeqQk?=
 =?us-ascii?Q?I86ZmTKhdEbqcOoBFwyIo8mQOFG/1nBdc+fJKqFI5cGJ1H1YVUwAzrzXZHI9?=
 =?us-ascii?Q?3CY7WD80XVHPNiwkPGF+0wrzEMPI/Emh8fapRkwov+I5NkWYNMh5VLa9kBaX?=
 =?us-ascii?Q?JAN6lPSiCVd8VAhLybkUmTfaOE7GElLKTWEv5cVIbUIxM+h7piJRP2MjM5Mp?=
 =?us-ascii?Q?UeY5QV1l1twDv1j2o8I2uoEM0JQtgs/qdkbjjRV7O1tV2V+71YUtGR3syR6I?=
 =?us-ascii?Q?fG+y6xZSixopeKtDu9ixzfbPPMmubKY8g/Vwps14x+M0ePNkqasHzZqiC7lZ?=
 =?us-ascii?Q?zyjuvm444q6f4l3jiYttOzVAbcwtFStG8yFHkW72pVNeayapof1Ef3XJic9W?=
 =?us-ascii?Q?I25hsnw38Mq4etHU056EidV8CZ0QSc6RfHY0H/7OlQFjOke9yQqizwmKlhdd?=
 =?us-ascii?Q?Re3yobDqxVpIC6Ogf2Uad2O/2muQDn8ZTSBTUIJTSe1xLWnqJP9YSuvJAFnW?=
 =?us-ascii?Q?q4GhLP9ULL4WPpYGAbPV6Ewm2k18DSINQyAYWPFAI5TLG1Y/Ag/8PgEsgMdk?=
 =?us-ascii?Q?rTfU1bKHtSVs1PaGDSEdBxUFQb7ibjg9mlFxLRLgTWPN4pRIcbzZuLjsAbdB?=
 =?us-ascii?Q?/RtRYWpDgGz4OpnX6v5cMEwkvnfUoxbyoaEIezYPqLXu1TTJXroDKEQYoAkX?=
 =?us-ascii?Q?RG8RgmrLb7XGimb7PCFddjB9zKn9qTGbl42BXn07IzG0D6Arkx1kOhkMohyD?=
 =?us-ascii?Q?zf9EIWoAMeG5SC0Kux4X2zxktV8OhVEQn8QJnVPeAWdeooW6NHqqkAb2XaEt?=
 =?us-ascii?Q?rAP9l27TX0OkOEf+Jt38uM88xr3xGki62MmKt/GB?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ydmZLfjuUDbdY1+2xATRbtHsbJIojyZv9T9JsohqcptFhj5AHaIvDXABhGYtNEoSqxH1HmIp5a7fZhlEkCDqb+67Lq9zx3vZBcKPkFr99HnP35k+sVXsJsyvfDejMK66d11JFY49NS2LP9kDngQCmY0WTvYwtKm16x6UZJXXdnwOCSxo7rckHJ6IAwbo4PO2YnJDd6knDrbwJhJYhiZrT63hFbtY/CPUnVfRPiCrZD00QPeHxSzWrGMiTtFfSzR0MJK3TbMxB/4f2v/YkFENDfcDbGG5HD4iyQz4i9EQXZis5byeRcrvbn9PqyiUycJTYIyNMQd/ezgqhlCukopfrDRFdEfXF5qYAGCbW2cZGfDbydQuFx4dyU3pN14T2yQ3brAHOb2CU/wNT/S5Zb/r2xoAJaF+nPky+B1rLK2y+Pm2yyiRvVntXnfZ6i2V8+Yi6o361GpQDWaTeVZBSw01/I7kg/mBPpBpFBxULa8Xc2JMitTdhNFufbsWbpH8HrQZBn/AP0ckYtYR44rM0XjbUVl//CzmcgZVMNYbzvi0ytYkV6KvaIhigQY2dqj0mUQM88jz5dHNr8WXYUQPDpJVJxh113TX6DBdkRhdiTY/+WM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a776489-4685-460c-5937-08dc84c15f04
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 18:08:43.8673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bYH1QoXKD8l2NawXX7kbyibQ8NnwbqrbBfaFTCPjwCiFhVwndCxr/Bz+m+O0w/L9OM/99XDuBRj64ek5kMBkVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4385
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_09,2024-06-04_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406040146
X-Proofpoint-ORIG-GUID: 2VXXLe4LQtos4ksbWzYeXuqPmpeTQ2MK
X-Proofpoint-GUID: 2VXXLe4LQtos4ksbWzYeXuqPmpeTQ2MK

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

I don't think the bot is testing my forced update of the tree, so I'll
try again.

#sys test git://git.infradead.org/users/jedix/linux-maple.git syz_20240603_v2

This is a revert a some patches - which seems to stop all the crashing
for me.

Looks to be the same as this [1] syzbot report.  All seem to be related
to madvise and these patches are the last to modify the area (besides
mseal() specifically calling out madvise, but that would not cause the
issue).

The patches I revered also name arm64 as special.

[1] https://syzkaller.appspot.com/bug?extid=7eaa0d7b9fccf21052f1

