Return-Path: <linux-kernel+bounces-301651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9402695F3A3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 16:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 218B31F24317
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 14:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD2C18C910;
	Mon, 26 Aug 2024 14:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="M27RiTUH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pRYUvmom"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95F5179958;
	Mon, 26 Aug 2024 14:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724681591; cv=fail; b=rTW8qDidPLE2jd3Lrwdz1Z696F2vdPN62pqXhakEFdmZlr+lEyqSSDk6qIl9SgkZ06l35s69+9k3I5dh540xdeG54PDBfDBD0vHG/crpX9snj2NpcaPlP136tnfyx8jp3tnBrvEKOt5aglMjTqNOHc41f1PX+/txnwKq0NRpRgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724681591; c=relaxed/simple;
	bh=0bB03QwM/HJS5OykW70daKhqyNvGKzWvi3i4H+YRpkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MMaRTEkwMw3pRetzVsmuxjaR0CCsEuCd0b0B4oG5QaQXJF3LkccbmmyBbvYI7bGrHGMpBpxuz4mHLTft5TDCMMG5EU9d0i6Fv738KiJjzu6XtcaZ1WdRPfXeLWtPK7H6qfqI6e3y2begwQHUItMTpRRSKxGAANT1sW5GPa2ljOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=M27RiTUH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pRYUvmom; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47QE2aHU020932;
	Mon, 26 Aug 2024 14:12:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=4/NEzwftIQ5LNVt
	VCwmZf2zWCjtAvx0Hu/1yJnzBUrE=; b=M27RiTUHMdK+xD40PzAlMapQpKnH8LT
	S7uY0pkKn5H4bB8F5VHxlCKWQOdVe3ZbiExhIKP9Xo7h++rmd18u35bKdxsFrYNN
	YlQd4Jx7lZbHrISICVFc60gVF0oKVplew/9DbaBg0OD0Of8jV+J5nudYqGZOg1I/
	lCP1NzyyWAxqgLKZih5yab/HytT8ydgE1pHaGWYc2diOqHsk7LexjA/EPNs5uSxi
	xr7ONpgeCkYndCalJYrz7jlgZTKR7L2j1LjvXBDSzT+DNbIWH0Bo+RJ+i5Df2hgX
	M62L2CYq+wPukq9eGDh5qJWIm1AF9lJP4kRCvwuunK7Yjh0vxIzRSaw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4177hwk6um-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Aug 2024 14:12:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47QD9J3Z010512;
	Mon, 26 Aug 2024 14:12:57 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41894kk8uw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Aug 2024 14:12:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gLIbcMShLMpjfP/4aRywRrrf6go/5Kv4xh8YBuk9WarF/T3ATk0uMDZJ4aA1Aqf5ZSMyR7GaqrB6cExbrogl6y7sOL+yYD+udYupMFflv0AHT9ZqnBTnMkoR4vVFdXk0aWk/vwq9ZZemGKCgWHHwV6r+bfwyoymumIu7Hj5mYUWIWAaRr26Q5xjfOFsJ+RMzP5rCYYC6MzIOnvMMwilHYFu7kXv4p9RXvmXAK2CvtyGrCByub2wI/HoqSGBM99Svje5pWf8hHBY8k8bNliuB7K+wOOxzU2tA+Eo7u7EqJMLIRu0t2n7R5Gew0nCDsC4eaauPmqkqj+fpqiuRlIQWFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4/NEzwftIQ5LNVtVCwmZf2zWCjtAvx0Hu/1yJnzBUrE=;
 b=AG/HtzLs4zchOUeMHhOk130jLdACrLQKAl6bUfwiM/DviJJk+O3due2sECxTVVF3bXNXeZmNV9u8TRelkdHVdv9TKeyoQXxesveHI2SC+UOoyxy+cSXy/N+AD+UqEZzmRiaL9nwcAf65c9w+ocZkA+Z7M0Xnkyo06U15JOfXjlGgkNJ9ID5rMmClbwi8SxEnzcVWw3UASxcUaOwkwXqLyrXWW0EHym0Q8uiSuijhsLOnJU03d0VzJEfXbA5Gz0YSQ95W1NRQcAlX/LC6dh12wBcnJ7OX4mfL5K/Z+57qMcYrq2IKyEYuW7z/JCi+hgn/sXxjaSEiqMkdIceXe26pUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/NEzwftIQ5LNVtVCwmZf2zWCjtAvx0Hu/1yJnzBUrE=;
 b=pRYUvmomx7yRM9Qfav9E4+jA/Z+QVYqgFCAoxgPdvFG+DuHhgyonk87fuD02OL5uGA15uleuryixnfyZB4QrDVKJvjZN0eo8xaF84v0ghQemavHhbn9JbNvn7zN4xM1J4MboGs3AV8zq7Y+ABLxXWS3YZ86WlxyCQrvxLG2Rn2U=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by SA1PR10MB6520.namprd10.prod.outlook.com (2603:10b6:806:2b2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13; Mon, 26 Aug
 2024 14:12:54 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7918.012; Mon, 26 Aug 2024
 14:12:54 +0000
Date: Mon, 26 Aug 2024 10:12:52 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lukas Bulwahn <lbulwahn@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: adjust file entry in MAPLE TREE
Message-ID: <7rh5ar45l2uecrjppinhoahouhdlfnz7rncxi72xlc5wegzvgb@ftylod6nhtzc>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lukas Bulwahn <lbulwahn@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Matthew Wilcox <willy@infradead.org>, maple-tree@lists.infradead.org, linux-mm@kvack.org, 
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
References: <20240826110215.19894-1-lukas.bulwahn@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826110215.19894-1-lukas.bulwahn@redhat.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0219.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:eb::24) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|SA1PR10MB6520:EE_
X-MS-Office365-Filtering-Correlation-Id: 42b8806e-96bb-42a4-5913-08dcc5d92d76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?H1uCtSw/S9lyfX5bNekthcPXxAgjwiy5o0xEk36ePHOjEf4hHzTTbfhPLf5B?=
 =?us-ascii?Q?BTkkmTvcYgmaxuM96XF3ric+GgrvB0PAN/19IfxW/9qHmbaJ9IKtLRfYBAxO?=
 =?us-ascii?Q?i1cSi7eOhPEw9UAw4Y5wJHi8gEwE0xXfgj3HNbmxZaRPpbxy94AIP4XA3hsC?=
 =?us-ascii?Q?2XIYfBAMZ+8Xl+9H5lviSudP9xTfxSC9JzXyBq6Yiu2g4lqtep/f/6AUkYQb?=
 =?us-ascii?Q?J/zUi76ON0w6AGYmm9iGxhhHNSLpvPLVIh6Qe/SFBPkQv+RtVyjT9hZCMJJU?=
 =?us-ascii?Q?Tvl2lWgU+FlZG3pfrstANhxuudFEtaDsj/ianM+L6stLK2HaDrwKBm73BRK6?=
 =?us-ascii?Q?CGLzYtuhSzFq5X/awB0oDI0mt6HfeD/9tsBWH2IAAdX+8pWHIn/FsudtlV0Q?=
 =?us-ascii?Q?i5xif4Dnd4zgWybOw19I9ePVJOw6dDGfNeGQj4NBAr1E6MKJR0mZ7YqKFQYI?=
 =?us-ascii?Q?FYdxu+aDEloVXt4ITqL47V7l4o+DbS1vTIwL0pNFOlyZ8QMgaPlmdwUVBTpJ?=
 =?us-ascii?Q?Fyn8SDKTgNR0eNpAgDrY35XTPRETmYGK+cSNYshVEI0QHgqWN6jsKyRQNgXr?=
 =?us-ascii?Q?ohzuciZgiu8Zo1izbamGZ3AmZE5tXbbjUypt8o/q+n0wdU4VJBCK3ZQV6Ww7?=
 =?us-ascii?Q?LqI+Wqf5PWOTazkOtjC4ezKzEattfkXuQDJyaUbiSukrDJsMpS/TOxWfo2gS?=
 =?us-ascii?Q?4qGMSvc4YPMUqDczzlFpGitzeFar7Euxpv2cwUCUd5PjVZV16MYc+a12fkF5?=
 =?us-ascii?Q?mWT94arkRUpwBsKNaL0ej0hHthd2eKryiFRFPvL733n94nqFDQH4/u1S7s1j?=
 =?us-ascii?Q?S+6Sdjc2de7vuFosKbdDrgDDGUTRRKLrZReQ0uB5BIjMlNjB+IRX7WrtpatD?=
 =?us-ascii?Q?LfEEUWaqqGA9A7/ZxxAOV9poNIapjbx8gZ2SmNn6m8ObVUoww/QN76zKk5IW?=
 =?us-ascii?Q?oPE1DEhSjN/jM+QyUKQ2GQS1IGIWLTlJ0K8/jVWCfDMN6vC0nUSlc37pDB3i?=
 =?us-ascii?Q?h8cNKrrKqodh6Ir8bIWlwGgtD+KquTmzIuChiD9rnSNfLaGu6voWDbgS8jet?=
 =?us-ascii?Q?cvjqIEOkdiJxMMwvLgZHK99oa6a/l1QQ2wI9QpATEhcKxd+zg05GJWJmgKDU?=
 =?us-ascii?Q?z99n9pd8wqO47Rmm+EcZC7eBAUgQriLmHVK7ycJvxPIe9sScI/7vU1zkcNq+?=
 =?us-ascii?Q?mXgLLe41v/nJe9kG7MQknKVsglAtX9WgBun0wuXPcTC4M3C7ufbsBKmQGW6W?=
 =?us-ascii?Q?9Uay6fidSlQi3g1fwPZVH72qB1JOR0/fov04ucCA8cFxSMDpHN6E9cMcIXp3?=
 =?us-ascii?Q?Dt9oNkKPKLVPFxNJLkFWb+f+z/LPcgwYNz+CrVFvLYySaw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kd656e8eF+bAZ0GtwTzu5ntHUzEr5wZp6bSE/535CenmSY/XVkXKALnARPmN?=
 =?us-ascii?Q?qGzPXIN7mKKeQGUQI6Ju3fDi+xBrVFC4fFEG3BtE8k/YcxOPImdr9amlc9BX?=
 =?us-ascii?Q?cRYcG7Fox/vH2tg5O4cTnyqfMXtGvb1moZkTdZUxGJsLvaiQI3IXd5lUfa3N?=
 =?us-ascii?Q?gVK5c+Arcxt4oo3CeXo6tIbcAaXTPzXwITjqFykzeLPCc756fj0bpRr0aJVt?=
 =?us-ascii?Q?alTF5f5ZwF9wIoHrb+OP10Tg7EToCJDIeVqb77OrB0BqQVacIureS7HWWYAX?=
 =?us-ascii?Q?5J4QBuU94QAUwiHjyaf/hlCIyqiwHSBN9OiWLM6fJbuyeyV9DyZzH/7Zvs/w?=
 =?us-ascii?Q?Kx2UUmx3Gxgb0gspWPVFgP9Vm42Yu2PVYTWc4zF0wG0viVQTwmOlmLIO/Ydu?=
 =?us-ascii?Q?qLhALI/Lzahxe2LYYRMkHXJAyeMKIYZh/cMgB9UOhoWFB+zBDgXRoNdhAOru?=
 =?us-ascii?Q?rGwGdznMd5wuLnr/b3aR8k7sJ4pmEDGyCLlunBB2klAZav7axYHON1ldF8Rk?=
 =?us-ascii?Q?WiJTjcTZOGYpC/RIi86rW5Xn0WmHw1Z0n9iuftq10qX0AofvzDKBEhUKvp+H?=
 =?us-ascii?Q?rUCiUjFioM1Gq8a5YJEp4nyHOfapb7Kly8wVvihm3DjKZiT8YrPe8Bsyrkl4?=
 =?us-ascii?Q?CM+P8iXhPThrAQh0hSTx+7bR0sQ4FaRw5BLwK7uUTGAvL995CGvrHel+910M?=
 =?us-ascii?Q?LTu411eYQ3c/YHAIAN0k8OvTbOSnHtoq8p2VSKhdQsZQltEtHbbFmZNSvgFX?=
 =?us-ascii?Q?CuQha3aLI5z9nGWfb8Sb+2SDyROI9FXcoTYXnftP4m6ifMimkLWb8TQI/Ntw?=
 =?us-ascii?Q?WPhB+ci6ycQg0HZU1FOPRS/etzenxovOYrlxXJ9KwqI39axKK1LlOYbJhaKW?=
 =?us-ascii?Q?+F1LqFrtmnqW+41yhpAUulI7CNn+V0R3di+/D08Uoun6ei5UoSyH95U/vEj6?=
 =?us-ascii?Q?BxWbFSI2zsxFlmTPEBpDDu7PxPwAThJ3R0SYLOjSGCYaUh53MyygF8VC/vXW?=
 =?us-ascii?Q?CccHUDoQ9Opb2uGjXyG7t7mRgVP/y1TSKsj6uSDIIAsfBWsWppsaa/5NNXrW?=
 =?us-ascii?Q?HvFLpCm5j2hJ3JeaUWm1H2piRCFlvH5FGshUlSJHVkHOTiVrB77AvJLQtZjC?=
 =?us-ascii?Q?lqDxg4Snb1FV2ti6FDpwW6Seqo1buawsRHONwg/xCWc8/WxgR/SgUK8yFVhJ?=
 =?us-ascii?Q?htVRVoS61FN6mYO/6IR/kDMkWXShS9IaBHwuaExiyxPALQsbKyaUAXjSTmIl?=
 =?us-ascii?Q?Gq3cUrjt9cN7397r/ylOeirNJx1VvqF1MO7U+tBZUquGeBjpus6dnJSycjxy?=
 =?us-ascii?Q?hy9CO92v8mF/UqSAenmTKmpb4VRrTWdR474dR0t4FZZz6NEjBSVY0h0GrdHd?=
 =?us-ascii?Q?P674SFHmTsLKgVH0Ct35XU+BQEbQk5I3cEs7LgrIcfk1OZIQ2lC4rO/K42tR?=
 =?us-ascii?Q?eBF0fPOKcpXoB+72b2n8LPGEsONF5SqNB5iBHOGL3PqAUReQgBKwBmuxGslN?=
 =?us-ascii?Q?Dx/1gnC3CSaXoyZlP7NGAVjubrawDvQs0c4jtN4iYrUWcj6QziXjI1vbj5fE?=
 =?us-ascii?Q?zCBgLrONkyr9FnyJedvXrqGZgHMFkQSxB5ZCxEKe?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XP0I5Rxxf5GHrwldXDl4Ie6zbo4Fr8QYaBZ9gdCHIUk0zOELOnnq9WGVN213+sOD0q9Z58jSut9fywMmP1FZcxf+o035SEqcftGkzatwB2le7ielgVf9T8XMGV6USp7U/8I8obLw+NKb+cpGKPATZDjQuMnFMYxl6+ELisMZu3xnPxkfCAoZeqikLYPg5BVd0D1AjFwdQCSD4TcGDKRojWQWErNvfhHpx9GeuOvaMYr1XIrzfJwOW6uGDecy5Pd//FTJuFOotfNnV/Ud4zGIH2AfpRYX0+RxO0mm8RL9CnL8fcrAHX9ZiETm+C5hl3GrRdWAgS0PJCHJKqAlcq7bSY4zdsuzTjYi1OcyKEBbM+Wi5MNXN/OWlnPDqq50KzPiFqhrvk9p1GZS4TACBTroDf6sJzxuQ6Un6dDbZYqwCl884rrfZA5FBYzaVvT29OnQ0vqGiCgwoe+TUZXZWrNNLBjdxTR3hEsSyMJvVk+aXyEDIsvUYY4lWV/SXBR5uOaziz9kZVLjRDPQxaBH+DSgUv3bLNGAorofafV0vE/LoiQ5qv7ewbFHA59sDjUIK/teNoEWsPD5hA+fU3OMbNV69MDTTzNspYU8FIPTe3MLSQg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42b8806e-96bb-42a4-5913-08dcc5d92d76
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 14:12:54.2425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6R/XjPlVhoTtDb53qGyxdMe9ZRpGPjAZAmT9t/vMJJTm8U1uItVm+74Bv/PpFJKb28VpCqFfsuj/hMZwMXMAWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6520
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-26_11,2024-08-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408260109
X-Proofpoint-GUID: sn1I1_UCoi7CvsmAvhs1xX-a7mcePoDB
X-Proofpoint-ORIG-GUID: sn1I1_UCoi7CvsmAvhs1xX-a7mcePoDB

* Lukas Bulwahn <lbulwahn@redhat.com> [240826 07:02]:
> From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Thanks Lukas

> 
> Commit 0f3b602e1bad ("tools: separate out shared radix-tree components")
> moves files from radix-tree/linux to shared/linux in the
> ./tools/testing/ directory, but misses to adjust a file entry in MAPLE
> TREE. Hence, ./scripts/get_maintainer.pl --self-test=patterns complains
> about a broken reference.
> 
> Adjust the file entry in MAPLE TREE.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6aa85a43d8c1..2af37835c735 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13572,8 +13572,8 @@ F:	include/linux/maple_tree.h
>  F:	include/trace/events/maple_tree.h
>  F:	lib/maple_tree.c
>  F:	lib/test_maple_tree.c
> -F:	tools/testing/radix-tree/linux/maple_tree.h
>  F:	tools/testing/radix-tree/maple.c
> +F:	tools/testing/shared/linux/maple_tree.h
>  
>  MARDUK (CREATOR CI40) DEVICE TREE SUPPORT
>  M:	Rahul Bedarkar <rahulbedarkar89@gmail.com>
> -- 
> 2.45.2
> 

