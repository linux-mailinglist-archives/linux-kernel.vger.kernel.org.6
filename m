Return-Path: <linux-kernel+bounces-191571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CE58D1103
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 02:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 499981C21786
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 00:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3317776050;
	Tue, 28 May 2024 00:37:06 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF0471748
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 00:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716856625; cv=fail; b=giWtPjreMr34zXaOrzCaOllMCmLbMI80D34fIo7IvvCGpz2Do6qdD8uAedIzbBj4tqLyql4sk1Ykmax9YhHMwbQxIq4Zj4QqDBeTzbVLR/NtdAmwRSPMbyAXoYLqc/g+VLk+f0D9Gwk6dVASrfTNGrqA3OoA1SOxLe+cCDzoHjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716856625; c=relaxed/simple;
	bh=CdxlinQAkDAady4M2tqfyOcrUbIp4900EAFo4s6B0P0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nlIbuuDb5k33KJ8zIl9yTM860wzAxYDkjUVxGyPkaX2ZiLIzA3sOdlwZuPfhk5eaxWbXOKHF7zY8Th23KircqzQ7vaSwIBGbbj6Im/lHGOy3GFxeKjo644K+3dP0jCjs4189wTDjCxljofHe5AvKWMOLuBJ+Vz5V1pM+owuznXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44RMHtHW016708;
	Tue, 28 May 2024 00:36:46 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3D+eDBDW7vZvXIevYO5nkc2avJiv24K8d5DPLgh5fgb5A=3D;_b?=
 =?UTF-8?Q?=3DZPmGfscA6EZVMnDxqmrzg2v/zK2+jjZ/YRRPxElPfrIrY2yEG/Z+PNp0eNK9?=
 =?UTF-8?Q?C3VdHp89_arMW+M8jkFtiSnQCbW0twxc9/z4YFBsWCEDXy0NY32hljl4eeBPp4A?=
 =?UTF-8?Q?BOlaJxXbKtzbDN_gziDAmejxOE5pXsw8RgFivkziWxsH2P8ZINnPxOBXQSZYvyM?=
 =?UTF-8?Q?qH5Z46ruPu45szC6SYLs_9pS3s4QK7GHBDf/Ps5kaw+arzJ1QmMHEetTF1+rXSK?=
 =?UTF-8?Q?OOWr1I5YAs9gfTRN9aUorb8UU0_oWp7P5FO4lzCUERf3QWOI3Ifn7ERyHShFkYA?=
 =?UTF-8?Q?vs9m6XTFwC5nv0QDSJ+5adv9lcRvuAqw_qQ=3D=3D_?=
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8kb37rf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 00:36:45 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44S04XNS009374;
	Tue, 28 May 2024 00:36:45 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yc52agcse-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 00:36:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J8m5Ohz1SKxfCqr3D22kNaDVOexsV9E+VmnRbJD6/Xqot0iYHrJGBfZMpoPpyey5bHVdeGB9TY2tWmVSKTwtFY+3PNYDQsaiU8wXNSpq6R6NdzjVJXlKUowMcewY7Ar3UOGKIj02UFYcIbcLmc6/j4M6eZtBWtCSFjL8vtHyRSzuCE8y5Eh9yf3jOWKKu7cquaf5gf74gRM5K/G+uoXcWARR3XOpGbV+7Jo+DiMiJktpEEWmxs9CzpL3j406578CjK6NDRXxpsZI9V9EOJHO4+m8+UTh6HKBGia2V0WPj3+CA8HBsuO4ALyKSQjPpCYVimrLKyLGM5Y9GR0bfnIlRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+eDBDW7vZvXIevYO5nkc2avJiv24K8d5DPLgh5fgb5A=;
 b=hIsBKr2ktLS8HE4pSjmOS+RprgtwtfbMzVdzpvjm7HEx/bKZzItSuApRfF5DbrrjebnmKsBaAMItD9Xmzf64YxVL3XUmPb+RSnjvXNeQCHuO0m1eeM+wzBXu3yJoyq22hEfPFzMas1Qh/JkmkwT/T2Fah+Rne824z1xxqYbQAG5nz1Qh2cBL0Gn3tfrml6WySO5k0hJDo/7vsVhaI6beX7VvnRAXIRlE/vHYaCk/kV8v4+hKKFdn0iTdDb7YIQz99IsywUzemQT+pAH27nC9ImXkPxALpwVKyOeHO9e6+X3/4sMtbQh40GhbBttiG059Hn6WShxJTKTTVkMZTw3RkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+eDBDW7vZvXIevYO5nkc2avJiv24K8d5DPLgh5fgb5A=;
 b=qsSJGACxoy39LtT4bYA2gxdeym3AdAjER8UCl5QehUNzCP8Yr4isWQDTtcLJl+PoouurW2st1i9RfrnlgU9nNCeku8/stA4GuRtoXQh5nRslxes6nkY6SfrINZs+GlZo5ju9Z0GofVHYO+Ne/Gk/iqfE0CUEMblGcaDUJ1GhFb0=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS7PR10MB7177.namprd10.prod.outlook.com (2603:10b6:8:e1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 00:36:43 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%4]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 00:36:43 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, rostedt@goodmis.org, mark.rutland@arm.com,
        juri.lelli@redhat.com, joel@joelfernandes.org, raghavendra.kt@amd.com,
        sshegde@linux.ibm.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, Ankur Arora <ankur.a.arora@oracle.com>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2 26/35] sched/fair: handle tick expiry under lazy preemption
Date: Mon, 27 May 2024 17:35:12 -0700
Message-Id: <20240528003521.979836-27-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240528003521.979836-1-ankur.a.arora@oracle.com>
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW3PR05CA0017.namprd05.prod.outlook.com
 (2603:10b6:303:2b::22) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS7PR10MB7177:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d6ff32f-eba1-453d-d3f1-08dc7eae3f2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?t7u9j6qGujZN/UXaYXFPIH0JscPpEXTQ/u27Ot/248gCqbLNERsDfSVhtc17?=
 =?us-ascii?Q?V5ZpaEwr6aedEsXIzs6tg4U5hHEPRjJTpR+yvjiOY/0fT3KOcwt9mD/65dj6?=
 =?us-ascii?Q?rz9bhaZ6l+e0mkt5glTX1+O1LlDJ7vTI31BFUA+gS5DoiW1LCyr28W0D+P3l?=
 =?us-ascii?Q?1e7E4k/HLXlRaqLfxpMnxsHzRX7yr6fQUH1BRoVLNNpD5e4qei6FTZFv+a1r?=
 =?us-ascii?Q?v8n84Ebv74awfh8fTBEphuSZnqgxy1kiXABfQDhphinlMOeVogKn8ucQIDGa?=
 =?us-ascii?Q?qCHDL/rHjfkGIaSYDAdpk+tyBoldxxziANQkcHrXrsHS//XEwQvkbIZu0496?=
 =?us-ascii?Q?SPzYH54DiCdo1feSxoFPc19RGh4EZV4ZaCjbCFmdKw9oc3vfLpmOi1sj6L4s?=
 =?us-ascii?Q?H0rlxW+cY0Gc/N10kABjLv4Nh3BJ8l7voyNlPyVSSGFX+j2UQiFgvjQCoqNf?=
 =?us-ascii?Q?dwiJBEQYdMExgddIfVI1MKz1KzUp5E7iw0jQ93tE33T+1+g1ZD1kWe2llwcF?=
 =?us-ascii?Q?UpQh2ZUjXtU/kVa+rcq14iTLAX50zm8QDMa39Uqml0tKxBXuF5Z1eTgt/qYy?=
 =?us-ascii?Q?4JH6SbotGet9Bn9gqSaMFuwQC/dxrLF+7B2tdm0H8Iizs2/U9WClqx5q30Mc?=
 =?us-ascii?Q?9sU6lz1Kn/wbmxYIsAOxLYweWvIxswZuR82hqhspQUHgOIYuZu7PVmzYKoNo?=
 =?us-ascii?Q?BbtihCMKN3Gc4miDZJIKZrxiN6E6hNon2YUbBa+JN9pKOYGwfuVAKAdKevET?=
 =?us-ascii?Q?eLRuNWszsPH1IdOAo2a1kEJrlNLMr5g2k8sdLczb4yUbUp/2DUVsRNBchPtF?=
 =?us-ascii?Q?VTFvC+ITgZH9nycws+BXMFiv/K17bvbd7VcOpUzdFIdJPkNWnLGMhn0511Jv?=
 =?us-ascii?Q?StObnSPMEuny1u5o/nzbaPAO39Z6m5SUH/NF0eBEn+vDlzdOETlNqLp/3+dP?=
 =?us-ascii?Q?1pOmR2SeZsLybKN6CHjdW0CtVWrhAePz+Vzxgt4v+W6439wYEBsgMYi9RuWD?=
 =?us-ascii?Q?mmGZ4swXv37k5SZiZ2ecwKTIdqcF4shTHmaLCKEfYTYM8wrTW0Rl6BRmiuJZ?=
 =?us-ascii?Q?7IMvtWPcgdymDh49KFztEEoUf3tO9wCMi4Iuhe0xrQslG/yQemsI6Qv/ljb0?=
 =?us-ascii?Q?q4FSiKgoruccnttzKC6YCVZu8tiSR5hZfjEf+69W2YhgT5gJhsz1h3epMQiL?=
 =?us-ascii?Q?lYHGJlJaVZiZLoXE4LFiUDuBdOZS5V7Wj8qiLg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Sfs/R3Qr/hcY9PR5whTQHGx4B3/01PnIjnMVXG6/WH1C8ostsKS5xoWGnvPh?=
 =?us-ascii?Q?oTpU+ghSwLasISBBMj6a2mWAIW9Ym4koUBghWQOtkB4CWSzVxIfadPKxbfjm?=
 =?us-ascii?Q?tt9zEmMp7/7OAAxfxEMdhIe8639RvAwm0mSXICuEDsxh2MmMbjnarBhchf/B?=
 =?us-ascii?Q?tf8x0LScpo83QwdKpe9LhUVfbpTM+/6wR2SKrThpsnFXAQ9QDkDsZG2faN1t?=
 =?us-ascii?Q?YvZb8w7u+qI8GOPeNYMj8wMBTLjESk95dqtEIN175r8m3D8FfOfBSR03RKa1?=
 =?us-ascii?Q?GGn46peOK3e2vuTwAdJD+Xl7A4IAAgFoLmzUTVdXRjxZQbng2jjYZIvZFU8A?=
 =?us-ascii?Q?InRkcOgYiDl0L+PGMeTO13g9ndyUzMn2+ur7BB1uFDnYnl1ikOP3Doi2mQ/E?=
 =?us-ascii?Q?1XvL+7CarGhaiQDIKBJsQCqtl2G5bT+7qRqhO03YfsNHW/eZwWQK1pqW/tWC?=
 =?us-ascii?Q?bxIzrQfhGHjxaoTwU871+ogVqXdZhQPP0LWbybhmGixPGWivud6RBhRu1zI9?=
 =?us-ascii?Q?NRV6D8kMuhD7ziM0rXIDljkAhd9eTMkKzlX1UsLyHyVCzAHgmS0leLkr2kgZ?=
 =?us-ascii?Q?goL+UknZ3msZ+0rcb8O03WeutvYlvcsHa7achM26dJ12SyeH3o/aq/u2FM3M?=
 =?us-ascii?Q?vDcruZFZzKYhJIjkdWq4/Ryfgm6SKjba/gq4IhU4wwOFTX9vpktadKbnyHXY?=
 =?us-ascii?Q?58D6+4nRUK67J+Rd4iRr8eZclyOOG/ntTXMstxVOT+VIRcjGy4nzi1o7FvaE?=
 =?us-ascii?Q?n4Ll/znz+WJxV/buIt8y92WMEl5SCxHNTJcHujSJ/am2o50fkA5/RRYRQvRc?=
 =?us-ascii?Q?kQ4vHGs8TuFE43f1ZpMv5zGz2TzuDSxD5bMOFCOHBA/XPqn3vXvew7TAUHjJ?=
 =?us-ascii?Q?5jtmeKo5/mSqrVyxC/hSMg2ivX20dyyyJUUQ4zXvS0jZQpDwJVzjIICyqUHk?=
 =?us-ascii?Q?sB61vuMBHBikud8H9lChM7xW4bqHcrP05CurPZltKdibSxQdstOl/uGHl9oQ?=
 =?us-ascii?Q?hWm3EqK24AvCfLwsEusNQGGVcKCrlxa1CdSa5X+rRw0fTUf1mz97bW9woBBJ?=
 =?us-ascii?Q?r6O/Nw2+CTmB6CrrA/CGwY2SQBkIimHG9B3MSvioQbEvZ04NUc+TzpfsaLY/?=
 =?us-ascii?Q?B0PE5zPjSUNZOFotDngtVumjpGVBwyEG8VJkr+piNlCV9sAwJGVfAtZs3rp7?=
 =?us-ascii?Q?E6fw3aG8fqUv6y8gvXNj0qu4LriJIaoPpBQzqlBDHetBXA9SFeB02Wmo8kjJ?=
 =?us-ascii?Q?M0XgGKNlxh6ZyiB4fCZFN6y8FYt61J/ZLbLATxeqGMH+eJicQ9o+uKJZSYNZ?=
 =?us-ascii?Q?ufmsczsYJ036WpBRUds0xxC6e1gqas2uG5fHeHoIfguBfafBU1Kyum0GhSnP?=
 =?us-ascii?Q?4GM9aiE5oXPt0J/WYMWF2UDQOsWuWZZ712YyH/V9E8vwPTcKZO/3eNPlt0Ov?=
 =?us-ascii?Q?bLFqWGALFkJbMwvY2KYUUe2hpCJ1TTMFNt17sez9vw+bDV4ZMt9UoPPQVYKm?=
 =?us-ascii?Q?bpYt1XS38Vh0if83AaUm6bUrdwxX2SGR+n4D2GYqcSOHS/kef0fh7eKl4T4x?=
 =?us-ascii?Q?zlCfauFPc+R+vrdtN8QuhPm4dLSc/K+UPSfVYcSSOX1aJCvS/7xR5H3hwcFO?=
 =?us-ascii?Q?rw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	K7vNHAT0neQdREjn5oqEEQfrCKVruiJWqpl0yRmlJ/X5l88LZUX9uO3ifXjDkbPFi+lIAE8xwlo1ut2KLu8tD2nnvz3mEQVwkKHENq64wQkUSwHrm7UpPoGh1ZZ5/qq21B0C+GlGhUxQBDUfxcJSJi48SZg5iMWiB8Ayu4dlZ+Y+JZmFbT3zmq6t8UMAwn6X99BOEigjeLgUYKdlBle5i8HdrjVF5mMF1UFzdqfZKEZcY0W+mKdFIs7b2UVnBsdgdEz+mFS7Um/hsxCaNsylMH5hfsY4cXpmcyXQONgCUmlAl2LSLDTa1dYnhuobE+vDsvAWzYhCpLiyIRDfe2RYKzbJRYbLMwrS0Y3AlQiLb7G3BFsGeCLzmqm/oqW6nMNU/w++4HDQ7oEKekqS6YoMRN929g2464Ouk8qt9NAIrWP2ndsZlPyPFg94ULCN2Cjasn8SSzS2ZGZg5ezpg7EA2JhdNsELslR70QTph1/JVyoC6/CoKkUVWtiBCR4laSGYj77uLEHaR7PYOkwFLkFlbgu0A8PnezTwXF2hh+gvTWiG4+V2cTBZcgS7q9QelR03S/8g+fOw3emlVOUjqaCQyhL72yjcubEfC5gDE+zqyvY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d6ff32f-eba1-453d-d3f1-08dc7eae3f2d
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 00:36:43.0166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sjGLaMyfYGrQ14ieI6ljkyHuod1XUGl2pdytUaIGDgLXCPVD+OzTiNp1sPoAXdeDhQkP1GsD+Msy1PTj3c9iU/7gg2Wwr/+AxJgzVvWBOvk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7177
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-27_06,2024-05-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405280003
X-Proofpoint-GUID: 9mdEMb6iCce4B2VL2XVt_-MHF0djy8XD
X-Proofpoint-ORIG-GUID: 9mdEMb6iCce4B2VL2XVt_-MHF0djy8XD

The default policy for lazy scheduling is to schedule in exit-to-user.
So, we do that for all but deadline tasks. For deadline tasks once a
task is not leftmost, force it to be scheduled away.

Always scheduling lazily, however, runs into the 'hog' problem -- the
target task might be running in the kernel and might not relinquish
CPU on its own.

Handle that by upgrading the ignored tif_resched(RESCHED_LAZY) bit to
tif_resched(RESCHED_NOW) at the next tick.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Originally-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/lkml/87jzshhexi.ffs@tglx/
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/sched/core.c     | 8 ++++++++
 kernel/sched/deadline.c | 5 ++++-
 kernel/sched/fair.c     | 2 +-
 kernel/sched/rt.c       | 2 +-
 kernel/sched/sched.h    | 6 ++++++
 5 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e838328d93d1..2bc7f636267d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1051,6 +1051,14 @@ static resched_t resched_opt_translate(struct task_struct *curr,
 	if (is_idle_task(curr))
 		return RESCHED_NOW;
 
+	if (opt == RESCHED_TICK &&
+	    unlikely(__test_tsk_need_resched(curr, RESCHED_LAZY)))
+		/*
+		 * If the task hasn't switched away by the second tick,
+		 * force it away by upgrading to TIF_NEED_RESCHED.
+		 */
+		return RESCHED_NOW;
+
 	return RESCHED_LAZY;
 }
 
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index d24d6bfee293..cb0dd77508b1 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1378,8 +1378,11 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64
 				enqueue_task_dl(rq, dl_task_of(dl_se), ENQUEUE_REPLENISH);
 		}
 
+		/*
+		 * We are not leftmost anymore. Reschedule straight away.
+		 */
 		if (!is_leftmost(dl_se, &rq->dl))
-			resched_curr(rq);
+			__resched_curr(rq, RESCHED_FORCE);
 	}
 
 	/*
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index dd34709f294c..faa6afe0af0d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12615,7 +12615,7 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 	}
 
 	if (resched)
-		resched_curr(rq);
+		resched_curr_tick(rq);
 
 	if (static_branch_unlikely(&sched_numa_balancing))
 		task_tick_numa(rq, curr);
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index f0a6c9bb890b..4713783bbdef 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1023,7 +1023,7 @@ static void update_curr_rt(struct rq *rq)
 			rt_rq->rt_time += delta_exec;
 			exceeded = sched_rt_runtime_exceeded(rt_rq);
 			if (exceeded)
-				resched_curr(rq);
+				resched_curr_tick(rq);
 			raw_spin_unlock(&rt_rq->rt_runtime_lock);
 			if (exceeded)
 				do_start_rt_bandwidth(sched_rt_bandwidth(rt_rq));
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e5e4747fbef2..107c5fc2b7bb 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2467,6 +2467,7 @@ extern void reweight_task(struct task_struct *p, int prio);
 enum resched_opt {
 	RESCHED_DEFAULT,
 	RESCHED_FORCE,
+	RESCHED_TICK,
 };
 
 extern void __resched_curr(struct rq *rq, enum resched_opt opt);
@@ -2476,6 +2477,11 @@ static inline void resched_curr(struct rq *rq)
 	__resched_curr(rq, RESCHED_DEFAULT);
 }
 
+static inline void resched_curr_tick(struct rq *rq)
+{
+	__resched_curr(rq, RESCHED_TICK);
+}
+
 extern void resched_cpu(int cpu);
 
 extern struct rt_bandwidth def_rt_bandwidth;
-- 
2.31.1


