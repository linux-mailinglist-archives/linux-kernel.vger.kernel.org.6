Return-Path: <linux-kernel+bounces-198076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B718D7334
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 05:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E86C1F21772
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 03:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CECE98F5A;
	Sun,  2 Jun 2024 03:04:55 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06DA8493;
	Sun,  2 Jun 2024 03:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717297495; cv=fail; b=IuJOJr876fa0eLkqoFJ7Y5Tx9cpuL4GRFhZPoqycf6MaJvbhHqV/af5NfdJqPo5x9PdOcZ4cdb7XJbR7XorNr346FvCy6FAWyhSvV61qbxE7yfuxw98tff+AuvoZjdU0XVhfQd+D6qimtxjC5WM54qpPQCPHRz/NltkjajG2XiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717297495; c=relaxed/simple;
	bh=NcShpJIpTbfHoYsiNzaep83AJHqEgatNPPAfZTz1hAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uma9k5VlvReSmDOhn+11BfEv84qtNhrPS6wVtiTxx5CYH0hoWsscBvIyhkVi7pelcf4wctliXpffsY6lt6c1dmurNyYgHr4ZmVBs54pNDiAZJR45vF1c0tuGKM9CKx0lQeCY16DJ6LMky/Y3dI0UQfVrfuuJCiU3ehGI4V/7yRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4522eeXL009823;
	Sun, 2 Jun 2024 03:04:37 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-type:date:from:in-reply-to:message-id:mime-versio?=
 =?UTF-8?Q?n:references:subject:to;_s=3Dcorp-2023-11-20;_bh=3DgwX3uptjv8O3?=
 =?UTF-8?Q?+kipGPCFU9/ZOsFT2Zva4mKlZoQ2gb0=3D;_b=3DgGF8YpPG1cb2jG0zlVefB16?=
 =?UTF-8?Q?fMHpAIGpK69mIxaftc4bo1oMMkpclSxsHs5cLlxaMKbsb_mdU6kctDPOn91B1AR?=
 =?UTF-8?Q?DNsWJftYRtGj7Jhyv7jm3HAvpblYH68wLr8xYFmuQg5C+wtSo0I_/792lwzcOsV?=
 =?UTF-8?Q?w9VY/33Ca12dDgi2dcwZfBRc1eZ09j7jSQkxYVal57eo0tX+Vt6WA0TEm_pVZvO?=
 =?UTF-8?Q?qdLV6thfqVYG5Skn+uBlR9eQ15X4Qoiq7CJDZw1MrFgWWmXWE0pKIFuVWxJupOr?=
 =?UTF-8?Q?_BSzq1cAiDMNkd0cFG59Hnl5bMyWH6lp7Q/ZR9r6eB7iXu/wUWJfkwr5Wfl0pnK?=
 =?UTF-8?Q?Yo6l6f_Sw=3D=3D_?=
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yfv588spb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 02 Jun 2024 03:04:37 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 451MGMxu021129;
	Sun, 2 Jun 2024 03:04:35 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yft34x2yc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 02 Jun 2024 03:04:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TerOYO3k8pfhfB1kAoealMhsYeTERtFSDkWmjs2AKBaBVXXyBgy2zIc9xg40H7vflW3aEuLIqxXI1KkPSN0NeWiQ4r9LyBGHewO28PjYPHFiT0bHTGzaUBDH+FoX7J0kIcW0w8QvSPVeZUw+oPQS6ntqX8Aj5vsmuA4gQT0zgAN2v0n9FlGVD8t4YicYy98mFFhq3njwLrBtRztmUtvPZjOPPmULKPAVSULoEmznkkjvPW01iW2dd5I17bcWUUeny7UN8zCm168tPC7htcfaRQEMEVelitx9ZkZqcr/eatXRVB0A5q8MKDHbcpoNMMze2XHrZAH6VJeWy4X0gkqYVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gwX3uptjv8O3+kipGPCFU9/ZOsFT2Zva4mKlZoQ2gb0=;
 b=dwsVuYHOLIfhK5avMDyYyboKCb5NZFw1HsIpa0L2GD3nJcstvWhnFZY3WcyrYy/ph38FfT6PVdJ8mNvuk32wHZfVYNdczKU/UKxSYVTZ6GdOkOlS6dJ4OViewHftdXz+/09xv7yaui6bkhJXDk1z0hCy29Tlfcq4vW5R36xhLU/GLvEBbvfCWInpnU+ncczJtAXIwJV+KEUKujLnacFJGgURQfxB+qSLb+QQACMTI2qbWSegNR8+DbWD9Jeb9Oie1RzSt/V13B6gcFRsHedejqA/+RcEV7wwTVO4ay/xspLlqQ9DjEw+lb6avU5kSvJ5MrfSYMXB7FdzdyAcrR2tog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gwX3uptjv8O3+kipGPCFU9/ZOsFT2Zva4mKlZoQ2gb0=;
 b=Lb47IqzTzIl1UVChDoXiKHt3gAIAUSd9CQz8n6adNwqj+j/aRWpbLuGJF1xPf+/ADXQxbOI+AZ91qxbo0tTmt0oOToy/CR+YzBUAxAZcLzlx10IOLP06exU05dO6iG35CFT9whIzKbFnQttj711XpF+OV3r9JBGaJ6YvN/16g8Q=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH8PR10MB6410.namprd10.prod.outlook.com (2603:10b6:510:1c5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Sun, 2 Jun
 2024 03:04:32 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.7633.021; Sun, 2 Jun 2024
 03:04:32 +0000
Date: Sat, 1 Jun 2024 23:04:30 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] test_maple_tree: add the missing MODULE_DESCRIPTION()
 macro
Message-ID: <eo5ttlyjud2r6ubtxhsbkfiu2wspjm7g7j7lo6fkld3vvdaock@kl2i2domasd6>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Jeff Johnson <quic_jjohnson@quicinc.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org, linux-mm@kvack.org, 
	kernel-janitors@vger.kernel.org
References: <20240531-md-lib-test_maple_tree-v1-1-7b1b485aeec3@quicinc.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531-md-lib-test_maple_tree-v1-1-7b1b485aeec3@quicinc.com>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT4PR01CA0007.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::14) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH8PR10MB6410:EE_
X-MS-Office365-Filtering-Correlation-Id: 556919b8-55fe-4a49-bd16-08dc82b0b9ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?C6Ermd9fesmUXNC6iweG6YTXcq+bD9BJiaj4zPyQpc7GKp4ziOphvwkxQ6EF?=
 =?us-ascii?Q?lP2ebRFFjV2UDYcu1eLURufI8+eOSyscQcB6ip23ml2u1/XXpbzdZuj/Ny24?=
 =?us-ascii?Q?GH0FfSC8LmIYfJZwC0RAZs/Ru6S5/U/iWg6eSeBHCENqkBURWpzfXT0K84Ht?=
 =?us-ascii?Q?4B4dXMYff9in56OWt9tJ7O1/0jhZlMpUFAGDFBg0i82ZYHY3wicxqs7FC1oo?=
 =?us-ascii?Q?V6DPH/wpd5yj+mB3N/qpIxb+3DJi+r+1ziuiYSv6Ic7wK6TlcA2l/rj/7JyD?=
 =?us-ascii?Q?fprLoEI16o4vink/CWV3nvlOzU92qziC5XgyeZFWjbMAa4VMFD+crX3Pz8qQ?=
 =?us-ascii?Q?SQEBovKT9w0+Be7gf7LGrV++rEkkr8sTsZLPgCb80n6y7JrNKzVcDYhKwmIz?=
 =?us-ascii?Q?tD+SrsP23TJGlhjEJkMUkW8bv+BE84rxLGV2NooKmq0CUXHk7kcklH0M0u6N?=
 =?us-ascii?Q?UdR1YDo0Kx3CsH9wtay5mfWOYzf4Z5LHqQ7jGU84hSDPesEWRA6EaR4Vyp2H?=
 =?us-ascii?Q?qYMTnfZXt4LcKcvQnHOL4BhHfZHCWv9zS/7hZhMynXOJXkIvgb/FmyHgb3VI?=
 =?us-ascii?Q?X9l+Eae6iVgDoc8GLkGr4Mz4R/7hm20/tgOWo8GwXRbiQHqinR+yHN7vWXye?=
 =?us-ascii?Q?S0dUm98AnilOfyLFyvhUNWetsG1no/f3ZEIoCrMHwj+VvB09+wCTdPL7WXmB?=
 =?us-ascii?Q?+ZIhsSB/yo8XhiRHnvvuIxtVJg3LeNn3T8qFcrkyMeeaIZU2tUdj0R/8uS5S?=
 =?us-ascii?Q?GZSKpHyix7WZgeKU8eAZwf3FgoRL73YLOdBVTmUN0+s/i9/DNjMYuznao4b3?=
 =?us-ascii?Q?F1yLZHPr3QotESYDwgIqvVnsly7NUub+WlQU2EIs77u9ecd7LZ4MbhdJIQJv?=
 =?us-ascii?Q?qI0ytaAlmQBwixy+I0pdvB7VaD6ZoQCteseQxiGHElLOHxNYNHVSpNBFZFHB?=
 =?us-ascii?Q?PuX8QxnuzogRWAR56ytjkebV0aTXGUa3XHua/RS7GC6SETCb0ckqx+o8/HFW?=
 =?us-ascii?Q?VJXNw1vdGrxoKj7bbRdwZ05m4MLumhFer3hi9LlvD16T7x00SJ+/+mnfUh+4?=
 =?us-ascii?Q?ZFMpfZVjIaEgLEcj4OI+7qvrVw80OGE1G88n/QEADE9pjG3OdTfbJHO7/rXr?=
 =?us-ascii?Q?jFCtM/293qyTbykbYOfrN/13hCjhSa2wYHWC1sIpHoEN9ZQ16ci6DlTVS/dz?=
 =?us-ascii?Q?OIEFQjTsNoeLyliiP11QeTh6uND9Bk5TzSqlz0gm37WPOeoiqD5P0W4KpUz6?=
 =?us-ascii?Q?8XeMNhT4JXd2h1hZhNPeP0+siiWbDgOjAHvc/+oNxw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?7VKa3aVBP7tUj+IX6BZP7aHDm0VNLDS9/cxKFWra/IuECO5BV3QI8wAv/dlI?=
 =?us-ascii?Q?uQOpHoEJvDrnr9spQQauUZ79c/dAAeUJOA7WBQqjGeS+XS+U3U8MdTg4/3jU?=
 =?us-ascii?Q?WbkIGtFDH8wP4F2UqC4dLuWCZsQAbKLkzGz5Wzkuk1oI3zm/czQks/hCZmfd?=
 =?us-ascii?Q?0o+9kpZW+aiMFXtjVzAUah+ZGWK2KLBDYriJ+jctFyKRkIzr875gM+gvGLxA?=
 =?us-ascii?Q?Uz+HiDVNYOtwPl/Et+oejfSvH9Hdx4V7Wq2JxVLZ3w6VVTjiDET0kyWmtzB9?=
 =?us-ascii?Q?abcqplALL3p36cowlq9qrxR+8ybLJ4dNwil1V0AmwkO+xDALw9bpvTxk/7S7?=
 =?us-ascii?Q?9u48xtNTjbAElndikuhCQfAm7EB06utPBWguaQ/Z1XJ3D/TqZdfpHVt/infv?=
 =?us-ascii?Q?sKP3q3++dZzQW0ZRxVS8nTlruTMGxaziuBM8qj2Twodl7RRNtsjaeIvVLn4v?=
 =?us-ascii?Q?GHrnpHnX0OOL1trA0ZsozvElSt5CMFDf6I9OznywSbMAxau5lBDsF3v8Twyi?=
 =?us-ascii?Q?qQsoyPOrhv3Ksj2Cjt4y8S1gqIgLWbKJ8+cPTlfI1HTh72vXxFfvUjhfj92H?=
 =?us-ascii?Q?tACXlB3fl8v3JxDwm+FM8yQ1DRRQgDo/QGCh/GeEoo1soarsnFPW8Ze/vHDm?=
 =?us-ascii?Q?QSZSL0W9hwV2OKKVZ2inh5gR89TvAQNibZ2H6kTG1287efHvdzFz+Vlhdve5?=
 =?us-ascii?Q?iVa9S1p05jIoP50M9yLXVJPsfkidxNpZCQLgNlAhlAaGb+nzdD/5NkRkGQCL?=
 =?us-ascii?Q?ZV/sNhC7rXlea4CiGqd6raSIz9qHKnvkrpa40rBSKpROw8lKrwElO+o7uLmh?=
 =?us-ascii?Q?CdXZkrNFxvotyIkqV7HWm8hCQ2pw+jNxjRipyNRfPLvTGDnwE0/2tofVnbnU?=
 =?us-ascii?Q?MixmjrCWXzv4Q8hUAVA+F6bQ99lfrytbayW6k42jn+teXVX9MTsRYrE3uL/N?=
 =?us-ascii?Q?VdGgNuX+mbyGtme6g78XHIJk73sIMfgU8zfPHRBkjWB/47QMx9BW+5B2YC12?=
 =?us-ascii?Q?AjNEh19nKHQjzt0AbP0hq2EotL4HR4+z3MoyCOBPeW5i+dx99rnHxmWHiB1I?=
 =?us-ascii?Q?McN4UNHT5u7sGtG4E4JyyntOX4qrVKPBQh8oz5mu2eE0WjepJ3BOlVl+AA2m?=
 =?us-ascii?Q?ZNqdKviK/QcYfTA/ceyJiEFUTK4F9NEsik9j0o4VEIld33Ct6oHDUEXr9IFT?=
 =?us-ascii?Q?p6WcH3RZQqG0ZPZO/pXJJDSwKPOPpHrqa7aV8+/Ywq6E64HqlJffmpFbLgnP?=
 =?us-ascii?Q?Lct+Nqskb1fKRsw7fiytTyKP+jGGE7kvNFRjrCuOTjDEduPDI8AJqCh0eKUf?=
 =?us-ascii?Q?qCMiHZC9qfJ4gsLRRmC4/swA0qjz+QTOCGDTYy2/MfYCRUfKKHpk0Iq+eCuV?=
 =?us-ascii?Q?9OeHi7Ezy8FX9ffL8E7iwhr/8Yb2ngCXtRxGG58naGUMj7eBP0dXgirf+9CG?=
 =?us-ascii?Q?x2BEc9/npIULckfJf5u708QBb7f//v9JX+T+VbhqRRs4i5TCUT5FS2++S7qc?=
 =?us-ascii?Q?YF88AbNpzNJZdxNkp8kK4p0hayJko5pG2peNnpQMzVelvvllLueZeplm7xSM?=
 =?us-ascii?Q?ljfgGZOn8Tk2dhKk4bn2C9V9yXOgJW4UNaem0m7T?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	l1Fqm82ojD81CX6jx8i/txo12ZAajT18gTaqhIELB4Nw4EOX7pJvY0MQKch1mW79j+ceRBUk00QEgBXOwbjY7/tHwhANeVQnmQW9ie9DTD9h6zDaDFW6jLs1lVpml8FKD2cNvzxb3pgYP5QoEqJviFCKqjLKQ/00De6VnhYkz1wc/dy1Af55N7H4ZN5Se5GhRMXaSVDnPXl5tPFGIFyhtEv0uwyQYJ940uFwtKX0hpxwJnrBx01Q4+I77ruMnGWdy/Vpk0nqjiPeoMff++igRH76uOOcvAgz4m76QVGd/0sJoEJxIUGSLXwzbU+Bb7u+MMX7cXqNYNwmV5Sm5IHx6nkz3ZFde002pmhdAtfiMEug9ppSzIiDMDwS65VsKZn1+D6grP3d7C7JquP3LdhBrtUnTFndDChnhe1sRLnzzvw256aYq6iJJPT0tRGndxZV63FHhAAeMMBP0uKBFoMvRqGWpqz7/adaUvulRWF16wGHKi72MMFZhCxSTliTziuKf7JAWFLMip1kblbRF2y/vIe8xtiAcwyOs63AWcFF/CmJ/J6daLwT6Aj9t4pO7siURLBg+Eak4DeWHFfqGCOACU5j/CCXglHbje9GVFFy7cc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 556919b8-55fe-4a49-bd16-08dc82b0b9ab
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2024 03:04:32.2046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dkDvZOmBCngy9ICJJ13MN2d2612URnRdPAx+q65+7kf/W4HZvmEjXS0fdHaLvGGCRAa/PlhEyQPC8237ekzILA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6410
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-01_19,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406020025
X-Proofpoint-ORIG-GUID: ToKruwvthTTTh9lM8IDehCKolr6-MF56
X-Proofpoint-GUID: ToKruwvthTTTh9lM8IDehCKolr6-MF56

* Jeff Johnson <quic_jjohnson@quicinc.com> [240531 20:13]:
> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_maple_tree.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  lib/test_maple_tree.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
> index 399380db449c..31561e0e1a0d 100644
> --- a/lib/test_maple_tree.c
> +++ b/lib/test_maple_tree.c
> @@ -3946,4 +3946,5 @@ static void __exit maple_tree_harvest(void)
>  module_init(maple_tree_seed);
>  module_exit(maple_tree_harvest);
>  MODULE_AUTHOR("Liam R. Howlett <Liam.Howlett@Oracle.com>");
> +MODULE_DESCRIPTION("maple tree API test module");
>  MODULE_LICENSE("GPL");
> 
> ---
> base-commit: b050496579632f86ee1ef7e7501906db579f3457
> change-id: 20240531-md-lib-test_maple_tree-51da39617917
> 

