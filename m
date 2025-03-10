Return-Path: <linux-kernel+bounces-555088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23161A5A550
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 21:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BC59173A37
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 20:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313681E0DDC;
	Mon, 10 Mar 2025 20:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NRjcTaTr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DXLdL6+0"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCE31DEFD4
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 20:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741639908; cv=fail; b=VXYP6Qy2fPnbxT5RJQPL1JN4/VlAghvovnkPeKJVUvjimSz4q/qRv/Z4UWverQoK2kfhbcX+24c+uTNE3gJsrhBxt8F58xCxIX0B5qAHzT8/eioac85lwtzQhzs3iXS+bPIO9GyWZ2vQYSUuW4seybuYA+Lsq1aj/cfba78uYwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741639908; c=relaxed/simple;
	bh=PzFGo8XJjJHigsl/vC7GTVKr0AS5wwEI8wamyqD07R8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fzclyLKU3iiIHZRkI7f6ZKa5gj7qxgI4p+xYFCxpVudiQOD27N1VT9BJ/YUKyiOpyy7jQJh8Cuk86WWUeLCU/yhRpDxhAS38DbqNM2HgxUxIkIBMoa68rhuQunvWsmPrLZbkZXfHV1Bh1KtLrZJe+NhLbnF0kMkgxFOEPDuAdeQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NRjcTaTr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DXLdL6+0; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52AJtwlY002661;
	Mon, 10 Mar 2025 20:51:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=3IEXdrd+htUza/gi+AInBAhDpe7VVvHgfAnuFGhv4vc=; b=
	NRjcTaTrCLMhvl9M8xNs3cpC94b5sHvqbWQL/yp45xnba6Tsh5FgETDFMTyUXEsm
	0CDT5ViW8jpauD0v+ISzYaoqKfzDIyS248UBejGlOYTCOJsFFdtu3p4TXlr09nOk
	dQk+rAl46y3rtTJe6zgq5pUo7b1FCWg6ubnJnaIvWiPYMRs6DSHEniiLXq+l9Qx+
	RWY1L9uTsSDbHKNroiEJW2uxJV4dWOsBOJ1gHO90zmg6dq1bc5tQjWgda8YSHG7P
	aU5gbqLFRsJ7dSKspDb+dQ9BBN6I4qq+fR9B1T9JyPrNcc4L5CopCQAaVYNyJzq7
	ZuCg29P9UASb8VSb0TPgdQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 458dgt3gff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 20:51:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52AJupWj021906;
	Mon, 10 Mar 2025 20:51:34 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 458wmnm5gu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 20:51:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LjbBmK8h/sPUftQg2RG5L/OgZXleEnEfO1ITW4P5a9EJKiX2TqGf80Aaw4+UbpqNPsFwUFF0iVogZKkG932MG54YA592ufIYpyiLSkcYVDZCf9gyw/Yck054vlnmO5VLRIiPvwZAZonLXzQq2XZXWuVp3rpsd15BtcaWoQpByFsQ643sXhbZIHUFT0zDLBojJA54eXkjdSqT+erIs25LQZwKH7I6o9vAJCiqK2GqRiHef0wHmYWJf0pIUJqzUeTnmTyiuvkEOxPuANj/om9MZUWuGm53S4kwBzi1ya8lhr3gKaTlu9lDGBS1KavLv2nA+VWNL2gf8XJ/MsxpXrGcQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3IEXdrd+htUza/gi+AInBAhDpe7VVvHgfAnuFGhv4vc=;
 b=gcqTElkCW1+SQXqvDJzRdQbGJj0mQZdEVJD6BpcHTAsTtA5okUT6qvyRjACKLMmDLLG4H/a8y0DJeXw/BSCUk8cLhPEmCdURWuqPMYH+f2CS+FuDsJzcLmMEFCzcg798U4isFC0gRfvI2xIGqwLRWhObJvIgw3v0r1Ou/qKHctYObcNWv9CuSikgGnNXotT6ldcfm2pXz+GviQDLvSYPo7I5bxR7l9tZCjqEyhL/oxYOQ9ZAbhrh9ro+KBrAsaOGdb2dPGGNT/HY7yQJQLzRNjwvZI5x/xmk/XEzIE3+l9eOUbIyknkXSSDuRc0ABrDHbjybWV+KXLszbJ/nfeyHqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3IEXdrd+htUza/gi+AInBAhDpe7VVvHgfAnuFGhv4vc=;
 b=DXLdL6+09+nyRFAu1rHTyW614sg47hXkM6u+wwFH6lDVq05nFLYJn5pMyZoLyyCLfnkFsOUJGLY3DebnXi/LBgdYZJi/++Iu/CzF5I06vBT11Z9M39isFTFv+sQnS8hZsQPQnieSdahttE9qJOa/1RV5JiJeaUab3NpNGduC9WQ=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by DS7PR10MB7250.namprd10.prod.outlook.com (2603:10b6:8:e0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 20:51:32 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Mon, 10 Mar 2025
 20:51:31 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Harry Yoo <harry.yoo@oracle.com>, Yosry Ahmed <yosry.ahmed@linux.dev>,
        Oliver Sang <oliver.sang@intel.com>
Subject: [PATCH v3 4/7] mm/mremap: initial refactor of move_vma()
Date: Mon, 10 Mar 2025 20:50:37 +0000
Message-ID: <ab611d6efae11bddab2db2b8bb3925b1d1954c7d.1741639347.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741639347.git.lorenzo.stoakes@oracle.com>
References: <cover.1741639347.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0463.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::18) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|DS7PR10MB7250:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e883ffb-cf55-44b7-e703-08dd60155669
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MZXNOxVWsS0LOZQV96o0P8JQLCOdz5cVJNLFt02CwE+c7qTNOcODmvIfz7ir?=
 =?us-ascii?Q?iE+22Q7Gv4GHpk72SZPWaH4UuR9ERWlMDgW3uwOAyhbyx5Nua4WeWX0Eh8vN?=
 =?us-ascii?Q?OijMgGGFJaC1vtt+6oOImwS5G9EmqiZpG2NF9OLsZpkvP360ieptOsp7T+/S?=
 =?us-ascii?Q?jAzYx1rzL70Bsf5QaNWyI/ZctbcRNt545zlW29EUz4tWn8erBdHTgdmPknI5?=
 =?us-ascii?Q?c1JHG2QLpkNQeWfnXtawoCZf2MPwKi51GpOdIx8ofS4GEsY2MG1nWu9IgZ+V?=
 =?us-ascii?Q?2SfgDsa936TS3+7n0XqjSEZ0+7RUMz+NpLzFhKlp0M7gwfWFJcYc+SeBLaKn?=
 =?us-ascii?Q?CUB+CzDaiU1+QjoprlLF1cb5rb6pRaCg2p/t5KmXQCZISeZYiR8qJAdivG6n?=
 =?us-ascii?Q?JKOMF+Q0Xkla2jJ8ilTEDkxY3OZ/FrcJuwINrIXjtKbMLHBv1Ner8XB7VU4I?=
 =?us-ascii?Q?9AixHBifc0h+4aOVRBARmQk4PXL5JGHz0aKTVOc5yitVT1up0fFRjEzgrBYM?=
 =?us-ascii?Q?jgxnakUc0MfURNGojIEg/f98IWE1liHY7OiIp28b4lvsu2bs4fPeBbaOQsXP?=
 =?us-ascii?Q?IT1Uj1kLQzszj2M4emVNu/Pqul7i4Bw8j/9c5+ZSwRUkFdsiJX28qQrwMvBh?=
 =?us-ascii?Q?0Hw6fFKDUe1+pgf09M4eCissU8CHUYNwHpDyDQn9ymslEx4yKmkwKrMiRd3j?=
 =?us-ascii?Q?5aBCcu7UClXPTbSb8ChlkLpxwBQvEmevcka58qRdSVaOPjf0/jYltSDbnN74?=
 =?us-ascii?Q?9tbRVqSjxcFmPK5l2ulStso64gP9it6Cn8ELYxym2Cis36QtshHH8LyHoLeO?=
 =?us-ascii?Q?2zN+Akb2j73HwIPzIKmbfZYqddQH2cDDJYG8m1O4GaokpUcM5qf4Mf2/YwjG?=
 =?us-ascii?Q?1gIybLj1PByitPqQg5TYTPJDlsPDZUeFixCD4EUR4USBcZv2DK0UFAs6pJLP?=
 =?us-ascii?Q?Dmi5FMQIiolJfxGxC9FOh5B/zrDAy5Kb0oJpgVjuB6cElMMWT9LYiMwmUkxr?=
 =?us-ascii?Q?evfZFJ6hL4lgstomj/qzx62iZBKmnKzq/3kuAd/VuHJJSFMlY8Hh0Cas7+jW?=
 =?us-ascii?Q?WWYjgfEJRR7KCrZHl3fjrA7L9EWlLlnVvoCpF/zmcE3vXLvf79NtRybhNNEo?=
 =?us-ascii?Q?IH9HPlK0xVH0095zAgEayVMV4mpLfaR3HNnnP2kS/XnQ0BJ923YSeUxAOYkI?=
 =?us-ascii?Q?VXZRCc2RusxMjV83XQN40pbXjbCx7ZodErpGYO878MhbsfnpnsUHTpPS1UKE?=
 =?us-ascii?Q?U7QzWkw278faahInCzsKHvE1on2JgT83KdfIWid8fJ6FmmZrPlfArwhdoun9?=
 =?us-ascii?Q?C37Hat4IFAQmK8UkiDa+rTCw1kswLtr/W30rM23nPgp2ZlEEwN7I/XUMQobq?=
 =?us-ascii?Q?JPhG/GMN5p71Swgg0KKFaRttSN9D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K1zZTVQuNlMDd5mlri2VsvkwRXbnfsFgRy8ROm6nC1+IlAlhpVWv7Lx7XpS2?=
 =?us-ascii?Q?joNYQqshZ63ogLKMPNAwpnoCGIC/eGOYMVPJAcx5t3qikPUgu3e84iRFUUi0?=
 =?us-ascii?Q?Mid5+ZtK/I7402TvUh5uyaNNZ63vjEAei3zzbpuy0Q5XUbG2IGzXTByo7zk1?=
 =?us-ascii?Q?e1NnbbwLvkCFoJbas6xxLfZ8uGZDltdXW1fSumeyLrhIYb3qCiQIueSVam6o?=
 =?us-ascii?Q?555QauA2ugxq4+3AE2Ba8+i2fnjLV/1XBJfnyVIZZSidWDV/QoIcPuTykJB6?=
 =?us-ascii?Q?Eor27p88VRERJtZ5V2x4Owqgcm7Y61SuA1HsDHCZb0HqX0Lf+5xmh9eLhtAd?=
 =?us-ascii?Q?GXC/j/VaoZfJN4pZxcIzAc9xesnesKnK3X7a9liy/rfcG45FqREKtrLTmWQO?=
 =?us-ascii?Q?CphAtJXKEQLG1AScB28dInP0E7FH96NYPoEaRaVmfaKrdDUnn3RjQ0o9JlvN?=
 =?us-ascii?Q?ureV43NxWC7pum+bMk8SRd/G62dWCSlhw8oMytE3hpCzUFL26yFIYDUJSc8V?=
 =?us-ascii?Q?QCmynZ3jX+7BR4CcnE2s18MKE2vvdPxekTqNqe7TGlEvdw+qpMt9vtFMQs92?=
 =?us-ascii?Q?u27ETbBpA6veAWItFysWexPCfrNCqBheY2NloPVs9tCpzMT2DPontGrha+dX?=
 =?us-ascii?Q?MN3axxgfVbH6fxHUQa9wLbzLxYLDMVE3aZ6MwxFMlNm2vSjUxlxnjyjiEDI2?=
 =?us-ascii?Q?ws3257VuXkM12g5NTVxJN74d/D1rdtg3iThwKWiwR4s6fWEzTTpP8VwJk3rY?=
 =?us-ascii?Q?DOEOpF5wypPCOAFG6MoVeykGJCKxQbFozcwXaa7HbSsNx/pCV3Xn6Dogkjlk?=
 =?us-ascii?Q?7PPMIJoQ8MwNHkIdNhHN1XFFEd9q4pkhhQswnMwtWodeSTgtQiTq00YyCcDt?=
 =?us-ascii?Q?Ka5AJJy36yoWcPbnnbVNPc2+rdwz5sSE4SGxuBrgFbbgljbbffTZMWKZz7yP?=
 =?us-ascii?Q?mHdCGSJbBgfKibhNiQoiLfKB3orRPs55ioDvFdg7/n+CvhD38S2JWJAQ3ol/?=
 =?us-ascii?Q?qG/Mk55nKJsuhfCjuCzkW36XuHYWIITRAsUmm+3AdhpPK0uZIWa4SSSF5tbW?=
 =?us-ascii?Q?poYtdHODONlplBiCHcXAbEan7ydMZv5rXxJxwDV4j3ZbtvkEENDLQslM/Rdv?=
 =?us-ascii?Q?6mcA8BfenEYoghrBcbnPgMoatd7+lEcFJP7k5f2DlMK5gXZb7IpycNs1cZTW?=
 =?us-ascii?Q?XtfNA4fJc7LzbrwFo+7UH8lHw3Uu1YL/PGHTTb15e1m1CkjOnTALBA6+X/HM?=
 =?us-ascii?Q?jiQZaaPYaztyH/mrVoFS+JFtxiphKetmhK4lKUe3/C06VwhH7YdQHkwI6zhH?=
 =?us-ascii?Q?gmd1k//IVJ/tGV6PnRi9Es2+5G0XGZc2ILf3BnGWjXGi5KP9oyRME4Zk3aJK?=
 =?us-ascii?Q?gamUuzOpjJyBbiSzADdSMe+C8zCVnHh8dn1rwjkiWQDqoVo/UqjN9iYFN/fe?=
 =?us-ascii?Q?bA7NS0AK0ULpDfF6Gzl6mFh6vehhll4HRbuH6E381EuBU+SiRfZ0ng9Wo1HU?=
 =?us-ascii?Q?dsLcubD/32gIuBcsreSqRZk9vuWNoLDpeG8eXekbp71Gu4RksC5wf8TRAOsf?=
 =?us-ascii?Q?giF/RjIP7w/ho4l+L4Qe85Ibh6qOIz8LYOGEi4KHLtFV6NSSyZ66amsdUmSH?=
 =?us-ascii?Q?Sg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mbvSt9Xd29FalN4RkvoVf9jbzN5wZ8N5iQSx6r6XW9q8Q5pAeUJj9hJDHV39mo7THO6s/sdvL5skMjAJsfudLOVjbOFU43RFf+pukUD019glX4yAC9ckBlVhoTBDqqDTjfOA5mwznibXvcAsPDzFXAMOzDkdvDk+uF8e+6xQaa5cPY7Ekk4lN5k0ctvwHHBNu+DRVJjbrmpJB0m9p2MuENu1CkQUdDsNJ7rHcxliKyaFzOrM+HMu8G1OtXKFtRzgkz+uZs5bzYNHpEligoIebTcklAvC0COXQP4TavKW7IzferkQeMpKEoN/Y4XLAnPgcaMDy43MxsXTwQKGA55jNN5W7gHZIdQGWpNaCYA/jHJiT6FxG0dkOLWykXtU6mx9K1fkrEWB76EJ6XQThOfWqEdoUud+syn1kpkSIe2oUFNueN12WdY151netoz97aRwEFM92yrA/mW5CwYupPRjVBPyW0f/N2SXtOxzbCLYauweFB+c39/qJ6Ai9NI/OJI4kQM/L2sGvIyZJYX0R/0PGJrPOsfpYGiOL4sgqfa2zP9bL56S0eCz8N7+blw942lw/oN0EFMOdey86tpumsvpMi6t4LgDpZ2fkvNVsly5OXs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e883ffb-cf55-44b7-e703-08dd60155669
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 20:51:31.9076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dmXiPmuh6adUxMRH02U1UHvZv6Y48TANT/wfjj3InLKE3ydNt0Z0FJY8sm6z0OEKUuLHUFd1i/5uQTKxJElz7yhbNI7GqT5SPt5q4BMCelM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7250
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_08,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503100159
X-Proofpoint-GUID: IHmFU78Knw3zo7l0vE2w-Dmc8cjUIbGO
X-Proofpoint-ORIG-GUID: IHmFU78Knw3zo7l0vE2w-Dmc8cjUIbGO

Update move_vma() to use the threaded VRM object, de-duplicate code and
separate into smaller functions to aid readability and debug-ability.

This in turn allows further simplification of expand_vma() as we can
simply thread VRM through the function.

We also take the opportunity to abstract the account charging page count
into the VRM in order that we can correctly thread this through the
operation.

We additionally do the same for tracking mm statistics - exec_vm,
stack_vm, data_vm, and locked_vm.

As part of this change, we slightly modify when locked pages statistics
are counted for in mm_struct statistics.  However this should cause no
issues, as there is no chance of underflow, nor will any rlimit failures
occur as a result.

This is an intermediate step before a further refactoring of move_vma() in
order to aid review.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/mremap.c | 186 ++++++++++++++++++++++++++++++++++------------------
 1 file changed, 122 insertions(+), 64 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index af022e3b89e2..6305cb9a86f6 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -68,6 +68,7 @@ struct vma_remap_struct {
 	bool mlocked;			/* Was the VMA mlock()'d? */
 	enum mremap_type remap_type;	/* expand, shrink, etc. */
 	bool mmap_locked;		/* Is mm currently write-locked? */
+	unsigned long charged;		/* If VM_ACCOUNT, # pages to account. */
 };
 
 static pud_t *get_old_pud(struct mm_struct *mm, unsigned long addr)
@@ -816,35 +817,88 @@ static unsigned long vrm_set_new_addr(struct vma_remap_struct *vrm)
 	return 0;
 }
 
-static unsigned long move_vma(struct vm_area_struct *vma,
-		unsigned long old_addr, unsigned long old_len,
-		unsigned long new_len, unsigned long new_addr,
-		bool *mlocked, unsigned long flags,
-		struct vm_userfaultfd_ctx *uf, struct list_head *uf_unmap)
+/*
+ * Keep track of pages which have been added to the memory mapping. If the VMA
+ * is accounted, also check to see if there is sufficient memory.
+ *
+ * Returns true on success, false if insufficient memory to charge.
+ */
+static bool vrm_charge(struct vma_remap_struct *vrm)
 {
-	long to_account = new_len - old_len;
-	struct mm_struct *mm = vma->vm_mm;
-	struct vm_area_struct *new_vma;
-	unsigned long vm_flags = vma->vm_flags;
-	unsigned long new_pgoff;
-	unsigned long moved_len;
-	bool account_start = false;
-	bool account_end = false;
-	unsigned long hiwater_vm;
-	int err = 0;
-	bool need_rmap_locks;
-	struct vma_iterator vmi;
+	unsigned long charged;
+
+	if (!(vrm->vma->vm_flags & VM_ACCOUNT))
+		return true;
+
+	/*
+	 * If we don't unmap the old mapping, then we account the entirety of
+	 * the length of the new one. Otherwise it's just the delta in size.
+	 */
+	if (vrm->flags & MREMAP_DONTUNMAP)
+		charged = vrm->new_len >> PAGE_SHIFT;
+	else
+		charged = vrm->delta >> PAGE_SHIFT;
+
+
+	/* This accounts 'charged' pages of memory. */
+	if (security_vm_enough_memory_mm(current->mm, charged))
+		return false;
+
+	vrm->charged = charged;
+	return true;
+}
+
+/*
+ * an error has occurred so we will not be using vrm->charged memory. Unaccount
+ * this memory if the VMA is accounted.
+ */
+static void vrm_uncharge(struct vma_remap_struct *vrm)
+{
+	if (!(vrm->vma->vm_flags & VM_ACCOUNT))
+		return;
+
+	vm_unacct_memory(vrm->charged);
+	vrm->charged = 0;
+}
+
+/*
+ * Update mm exec_vm, stack_vm, data_vm, and locked_vm fields as needed to
+ * account for 'bytes' memory used, and if locked, indicate this in the VRM so
+ * we can handle this correctly later.
+ */
+static void vrm_stat_account(struct vma_remap_struct *vrm,
+			     unsigned long bytes)
+{
+	unsigned long pages = bytes >> PAGE_SHIFT;
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma = vrm->vma;
+
+	vm_stat_account(mm, vma->vm_flags, pages);
+	if (vma->vm_flags & VM_LOCKED) {
+		mm->locked_vm += pages;
+		vrm->mlocked = true;
+	}
+}
+
+/*
+ * Perform checks before attempting to write a VMA prior to it being
+ * moved.
+ */
+static unsigned long prep_move_vma(struct vma_remap_struct *vrm,
+				   unsigned long *vm_flags_ptr)
+{
+	unsigned long err = 0;
+	struct vm_area_struct *vma = vrm->vma;
+	unsigned long old_addr = vrm->addr;
+	unsigned long old_len = vrm->old_len;
 
 	/*
 	 * We'd prefer to avoid failure later on in do_munmap:
 	 * which may split one vma into three before unmapping.
 	 */
-	if (mm->map_count >= sysctl_max_map_count - 3)
+	if (current->mm->map_count >= sysctl_max_map_count - 3)
 		return -ENOMEM;
 
-	if (unlikely(flags & MREMAP_DONTUNMAP))
-		to_account = new_len;
-
 	if (vma->vm_ops && vma->vm_ops->may_split) {
 		if (vma->vm_start != old_addr)
 			err = vma->vm_ops->may_split(vma, old_addr);
@@ -862,22 +916,46 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 	 * so KSM can come around to merge on vma and new_vma afterwards.
 	 */
 	err = ksm_madvise(vma, old_addr, old_addr + old_len,
-						MADV_UNMERGEABLE, &vm_flags);
+			  MADV_UNMERGEABLE, vm_flags_ptr);
 	if (err)
 		return err;
 
-	if (vm_flags & VM_ACCOUNT) {
-		if (security_vm_enough_memory_mm(mm, to_account >> PAGE_SHIFT))
-			return -ENOMEM;
-	}
+	return 0;
+}
+
+static unsigned long move_vma(struct vma_remap_struct *vrm)
+{
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma = vrm->vma;
+	struct vm_area_struct *new_vma;
+	unsigned long vm_flags = vma->vm_flags;
+	unsigned long old_addr = vrm->addr, new_addr = vrm->new_addr;
+	unsigned long old_len = vrm->old_len, new_len = vrm->new_len;
+	unsigned long new_pgoff;
+	unsigned long moved_len;
+	unsigned long account_start = false;
+	unsigned long account_end = false;
+	unsigned long hiwater_vm;
+	int err;
+	bool need_rmap_locks;
+	struct vma_iterator vmi;
+
+	err = prep_move_vma(vrm, &vm_flags);
+	if (err)
+		return err;
+
+	/* If accounted, charge the number of bytes the operation will use. */
+	if (!vrm_charge(vrm))
+		return -ENOMEM;
 
 	vma_start_write(vma);
 	new_pgoff = vma->vm_pgoff + ((old_addr - vma->vm_start) >> PAGE_SHIFT);
-	new_vma = copy_vma(&vma, new_addr, new_len, new_pgoff,
+	new_vma = copy_vma(&vrm->vma, new_addr, new_len, new_pgoff,
 			   &need_rmap_locks);
+	/* This may have been updated. */
+	vma = vrm->vma;
 	if (!new_vma) {
-		if (vm_flags & VM_ACCOUNT)
-			vm_unacct_memory(to_account >> PAGE_SHIFT);
+		vrm_uncharge(vrm);
 		return -ENOMEM;
 	}
 
@@ -902,7 +980,7 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 		old_addr = new_addr;
 		new_addr = err;
 	} else {
-		mremap_userfaultfd_prep(new_vma, uf);
+		mremap_userfaultfd_prep(new_vma, vrm->uf);
 	}
 
 	if (is_vm_hugetlb_page(vma)) {
@@ -910,7 +988,7 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 	}
 
 	/* Conceal VM_ACCOUNT so old reservation is not undone */
-	if (vm_flags & VM_ACCOUNT && !(flags & MREMAP_DONTUNMAP)) {
+	if (vm_flags & VM_ACCOUNT && !(vrm->flags & MREMAP_DONTUNMAP)) {
 		vm_flags_clear(vma, VM_ACCOUNT);
 		if (vma->vm_start < old_addr)
 			account_start = true;
@@ -928,13 +1006,12 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 	 * If this were a serious issue, we'd add a flag to do_munmap().
 	 */
 	hiwater_vm = mm->hiwater_vm;
-	vm_stat_account(mm, vma->vm_flags, new_len >> PAGE_SHIFT);
 
 	/* Tell pfnmap has moved from this vma */
 	if (unlikely(vma->vm_flags & VM_PFNMAP))
 		untrack_pfn_clear(vma);
 
-	if (unlikely(!err && (flags & MREMAP_DONTUNMAP))) {
+	if (unlikely(!err && (vrm->flags & MREMAP_DONTUNMAP))) {
 		/* We always clear VM_LOCKED[ONFAULT] on the old vma */
 		vm_flags_clear(vma, VM_LOCKED_MASK);
 
@@ -947,22 +1024,20 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 			unlink_anon_vmas(vma);
 
 		/* Because we won't unmap we don't need to touch locked_vm */
+		vrm_stat_account(vrm, new_len);
 		return new_addr;
 	}
 
+	vrm_stat_account(vrm, new_len);
+
 	vma_iter_init(&vmi, mm, old_addr);
-	if (do_vmi_munmap(&vmi, mm, old_addr, old_len, uf_unmap, false) < 0) {
+	if (do_vmi_munmap(&vmi, mm, old_addr, old_len, vrm->uf_unmap, false) < 0) {
 		/* OOM: unable to split vma, just get accounts right */
-		if (vm_flags & VM_ACCOUNT && !(flags & MREMAP_DONTUNMAP))
+		if (vm_flags & VM_ACCOUNT && !(vrm->flags & MREMAP_DONTUNMAP))
 			vm_acct_memory(old_len >> PAGE_SHIFT);
 		account_start = account_end = false;
 	}
 
-	if (vm_flags & VM_LOCKED) {
-		mm->locked_vm += new_len >> PAGE_SHIFT;
-		*mlocked = true;
-	}
-
 	mm->hiwater_vm = hiwater_vm;
 
 	/* Restore VM_ACCOUNT if one or two pieces of vma left */
@@ -1141,9 +1216,7 @@ static unsigned long mremap_to(struct vma_remap_struct *vrm)
 	if (err)
 		return err;
 
-	return move_vma(vrm->vma, vrm->addr, vrm->old_len, vrm->new_len,
-			vrm->new_addr, &vrm->mlocked, vrm->flags,
-			vrm->uf, vrm->uf_unmap);
+	return move_vma(vrm);
 }
 
 static int vma_expandable(struct vm_area_struct *vma, unsigned long delta)
@@ -1248,17 +1321,11 @@ static unsigned long check_mremap_params(struct vma_remap_struct *vrm)
 static unsigned long expand_vma_in_place(struct vma_remap_struct *vrm)
 {
 	struct mm_struct *mm = current->mm;
-	long pages = vrm->delta >> PAGE_SHIFT;
 	struct vm_area_struct *vma = vrm->vma;
 	VMA_ITERATOR(vmi, mm, vma->vm_end);
-	long charged = 0;
-
-	if (vma->vm_flags & VM_ACCOUNT) {
-		if (security_vm_enough_memory_mm(mm, pages))
-			return -ENOMEM;
 
-		charged = pages;
-	}
+	if (!vrm_charge(vrm))
+		return -ENOMEM;
 
 	/*
 	 * Function vma_merge_extend() is called on the
@@ -1271,15 +1338,11 @@ static unsigned long expand_vma_in_place(struct vma_remap_struct *vrm)
 	 */
 	vma = vrm->vma = vma_merge_extend(&vmi, vma, vrm->delta);
 	if (!vma) {
-		vm_unacct_memory(charged);
+		vrm_uncharge(vrm);
 		return -ENOMEM;
 	}
 
-	vm_stat_account(mm, vma->vm_flags, pages);
-	if (vma->vm_flags & VM_LOCKED) {
-		mm->locked_vm += pages;
-		vrm->mlocked = true;
-	}
+	vrm_stat_account(vrm, vrm->delta);
 
 	return 0;
 }
@@ -1319,11 +1382,7 @@ static bool align_hugetlb(struct vma_remap_struct *vrm)
 static unsigned long expand_vma(struct vma_remap_struct *vrm)
 {
 	unsigned long err;
-	struct vm_area_struct *vma = vrm->vma;
 	unsigned long addr = vrm->addr;
-	unsigned long old_len = vrm->old_len;
-	unsigned long new_len = vrm->new_len;
-	unsigned long flags = vrm->flags;
 
 	err = resize_is_valid(vrm);
 	if (err)
@@ -1356,7 +1415,7 @@ static unsigned long expand_vma(struct vma_remap_struct *vrm)
 	 */
 
 	/* We're not allowed to move the VMA, so error out. */
-	if (!(flags & MREMAP_MAYMOVE))
+	if (!(vrm->flags & MREMAP_MAYMOVE))
 		return -ENOMEM;
 
 	/* Find a new location to move the VMA to. */
@@ -1364,8 +1423,7 @@ static unsigned long expand_vma(struct vma_remap_struct *vrm)
 	if (err)
 		return err;
 
-	return move_vma(vma, addr, old_len, new_len, vrm->new_addr,
-			&vrm->mlocked, flags, vrm->uf, vrm->uf_unmap);
+	return move_vma(vrm);
 }
 
 /*
-- 
2.48.1


