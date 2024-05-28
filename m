Return-Path: <linux-kernel+bounces-191550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA35A8D10EE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 02:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCB821C21001
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 00:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49CD7525E;
	Tue, 28 May 2024 00:36:13 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED2D1B806
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 00:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716856572; cv=fail; b=iHv+PDZ3DhNJZSv32nT400Pt5aiLXHugjGdq5CubPwZZWLU/ht6P1lALEzWuTBz04k9EYk5fMzguzSxOifKfM9uw2a+Rz7IyL+7/e8ALaJx3QoEyfQZ4eCkad2wdg0lHzGwKqr1pvGMuKh7DRWzbWVW+zkuCB/DpCYkPVl1c0v4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716856572; c=relaxed/simple;
	bh=0DAd/f8VO/6qaAZ+2NVJBCFl7M359s7LArrDvUIVuzI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nOVpHoacvmSHJFNuL1tnC3bE5QBbHdbEk1grg5EdrvG2jCQKPEj643xCoztN0rVty/pRPaJikdsaQuBXrIhrnp7paEE1q++vz8nNGLR7wNugAssStGR/lPUbzwvjZHBNFsevXFfnUVIJu0IZDSPN0eDffJdwXce/urmsX6n6kbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44RDI4rL025170;
	Tue, 28 May 2024 00:35:52 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DwkndxcNpOo5dcu1xnkuIwkRcvCSZ+igxtkgaOKdrPBQ=3D;_b?=
 =?UTF-8?Q?=3DSfljOBzhTu4bKAnRplSvemwIqVXie3O+8j1TznClkBCqgTnn08H3s7KIQY9k?=
 =?UTF-8?Q?hAw5HMsc_BsOaQ/vdjCvpzQgPR5+W3UQGc0+2UltYFEsY7aR3GzieCVee1vxam9?=
 =?UTF-8?Q?OmBZTAaWURT6Yv_b3rrJvELI3Dv/OE7S1YZJvFam4zUg4+wPTxIeCLaCE+yUH+b?=
 =?UTF-8?Q?85mi9nG9794T7ftpaWqB_efq0TmxcQDVuc7tSaCfFnZDWXD6TKEZY7cc2ZCZd1t?=
 =?UTF-8?Q?2xU+XHsiLODVP8anduDgSioKRl_fkawgT0Ffp0eUR0EAHtwTzF66qXwLDssx/4E?=
 =?UTF-8?Q?gzz/qIh/RxMDrcgl1hlv8f+h1gLMnWlD_Og=3D=3D_?=
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8hg39b3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 00:35:52 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44RLGu7t009236;
	Tue, 28 May 2024 00:35:51 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yc52agc1u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 00:35:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oQmoQAdCbb0qTVyFRyXGGrPF1qbgdY/3hqzL3kiEwMKOb8Bsr+KTgo63Y3nCdJpWMBtUhkc95CAD9erHinU4OG+icBAXGcwDnqCZPoHCV12/CPf4PSg+ZnmJxrLFsoIMHZ9cAm8I8LKTXcc70Zfs8QW7Md343KYRNyMbrt5NmpmrkouHTwgpN5d9oTplcVIM1AfnBKE/fldyT6Ufc2N4W5k8XCXwdb+g+mIj2itqYQJPpl01fnPpcSwmwbSloVPefPOVhvj62iHQ5uBCNoSwNz2CoBZDLJKKqfDTEga1nUfjd19INyaDn/mqx2gMg91zlRd23f/McdlgfPr2rOcy5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wkndxcNpOo5dcu1xnkuIwkRcvCSZ+igxtkgaOKdrPBQ=;
 b=Q6xEGO1DzgZwJWVmqa5cq1rOTpMZEvuKgnw2tNLeoxFASTrWtmY+AAvWCdw54SJ9mn3o9+9ICijMI/hAkIxNSYRf/bxtXV/yYuCdalaxypbNn4RdmhyLILkl4ZY9WMOPyxAFCaI4jEnw29C8wHllossNj6IPzaHrZ/16/IxxqLzjtMZw1GCuoAxj4KYVb1lWJLUwkHaf5s9iQP4H7EFG3HkOeqevFX/kszEivXEkjWSCITTU0zXzAbBGipUjrDPDLlhumZSOs4jAvW/L/626drwFqCPsJ8iDW4VelUIPqCq5MDS12j8QPCTr2Eq0764Z/+S5AWdTsTT92F3zQoEprQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wkndxcNpOo5dcu1xnkuIwkRcvCSZ+igxtkgaOKdrPBQ=;
 b=JFAeXFYL8vFZEPT4ED+Vv0hu0xyX9KpmiIcbq/biVHzCIWIfUChjLzvbBtkJJUjG0TEBKGNafhKdpxX/CjKHbkPazMbpiUF1mRLDOCNox7jxuKUfqif/LCdfEBJb2SYwjZmeDsvphaTDSDvxXNPf0SwTrejxiZuZuV+Ls2rl+9k=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by MW4PR10MB6510.namprd10.prod.outlook.com (2603:10b6:303:224::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 00:35:49 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%4]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 00:35:49 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, rostedt@goodmis.org, mark.rutland@arm.com,
        juri.lelli@redhat.com, joel@joelfernandes.org, raghavendra.kt@amd.com,
        sshegde@linux.ibm.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, Ankur Arora <ankur.a.arora@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2 06/35] thread_info: define __tif_need_resched(resched_t)
Date: Mon, 27 May 2024 17:34:52 -0700
Message-Id: <20240528003521.979836-7-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240528003521.979836-1-ankur.a.arora@oracle.com>
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P221CA0010.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::15) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|MW4PR10MB6510:EE_
X-MS-Office365-Filtering-Correlation-Id: 6801088a-202b-4789-033b-08dc7eae1f1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015|7416005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?HDMy7AaC/s8jczGG+LW0MmiVZxP1tn1XS44yegrrKI1HihSiuwhBp2VqKDNc?=
 =?us-ascii?Q?pF8cHUcDm9rsKayvZIdes1PKEr8iVUAzooctG7ToSpeCwgp7Wj2ovnwVhc55?=
 =?us-ascii?Q?p5uhYkoGKiKSHh0D1wzu4XRZZ+es/losjwb0/wNYC1Je4GW2biDcmYMLtsEd?=
 =?us-ascii?Q?GIDfPJMDycOJu4C+1jy0S4H/ZVPLgea+Js5XNVwFEJ1nXK6+QokB5KJ96MAP?=
 =?us-ascii?Q?k1HfInSEyEs117jZ67ktRI5YJx6aMP52dRp2g3G7sOXd/oxXJCDh5Vvp52TV?=
 =?us-ascii?Q?RppPWmvnhywvKSHbNnxnUnV0f+2yhRpUr9PaTp8fwwBAmyXRB+vSQFo6x69c?=
 =?us-ascii?Q?VLh7hrDVQQ9kE8wO/83BbsKpd4++dCCu81sjeU7EftImU8FMKBHQtgDvJaRZ?=
 =?us-ascii?Q?ljp8Ougbxyrqbe4efWK60CaeqM6sM0xZcrDkWBgjVbOO1YrfxifrHBE1ogIC?=
 =?us-ascii?Q?DXwDRhGKMeETaYrcgUp7bFfEd47/W9oWjj+Xs5/pS8li+2Qv+PmTswm9XtuC?=
 =?us-ascii?Q?WcXpCp70fU7TEy5VfWY+2rLs29QZzqTJTanrucuxQtamQur0ditAgDoe1BiG?=
 =?us-ascii?Q?0oMrwecsHTIRNHX6n6dHWm4emL40+Txk5SMLKl/K5R4nVajywq6t1C17VX6j?=
 =?us-ascii?Q?2czSFjL6JVM/Zs31oVQ2vcrvkSXA3Wt9vLMRBrNK7sLGADcRqNamNDFjXSGj?=
 =?us-ascii?Q?CtpGxOMbas+uB478loNIjksfDpKVKybLWM3Q7mJex+Ec2x3rCEVgINUQWITt?=
 =?us-ascii?Q?FV41s9TQQU4+t24nl3Rmp9MBqNV7mG1J4De2goG+dZZvoVpoGSqTHRwP50zD?=
 =?us-ascii?Q?1dxtdKkauJFEdoLbwsXpQ/IgrQ3MWzAdRU1GVZCrtpTH6eLpzY0GE2x3IVDf?=
 =?us-ascii?Q?areqfl2ebbDsQUbWBbSiqnrt0Hc1FhV/y4W+8BNXmP2WpaLr4QGaZNo/FqXJ?=
 =?us-ascii?Q?VPsbkNYTnFxpu7HIAaDwAFeaPxtX0o+zNAIffpUVr0HEGSt/4lG2cMwz3Igk?=
 =?us-ascii?Q?Ob/q3kl0nmsJOQDHOjF7oybdTdbelmqwBgCleHyouAsWLY2cLDj8yaS44HrL?=
 =?us-ascii?Q?cWvNL1FedyrJO4LhoxvkbZWI2MQLAIrAlJxeJDV8Rq1QWETTAzW31V3Btk8Z?=
 =?us-ascii?Q?1EgCjRk8u1iCY/AOyw58kxx2gtbUSRerAGANXQcL/fuETClQm7f5vIpPn8Ld?=
 =?us-ascii?Q?46ASzi8LYrO6M3AlYGEZahge2rk3Kc5UIVMsSb3KmXbqzxyp9oWmsWxRD7s?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?4+pcMN9sKtlJ7T1CHR7aTq1Sn+YSVsizV0R21FL7GCVb8t6k6/NXiW5rQEAR?=
 =?us-ascii?Q?olYRSmeOREGN3iZ1CywKMRy7CEtRoqKLbFXgJaNN1ZlKEBXB/DAaHw1wCp/L?=
 =?us-ascii?Q?4L2fEZgS+560nzJ+qVSgoUK+mf523j3Tba5TNcku1ciqgP9UgFE0ocaME/6x?=
 =?us-ascii?Q?6vYZ+S5pnZbZWNh0yB9kaS1FhOHQjSsYstaMeC4d2X3d3ffhzvtBWRlLpRpi?=
 =?us-ascii?Q?23k2pWiNu1jCkZbtAOnhTf9GwRr+O5XDeaT1ACCI6mhywyKUzq+Y180NshrC?=
 =?us-ascii?Q?VCl3iPS6mOwhx3spVMtKR9FP8WW1QJfByKHKUAIoJvP0JiKKqrNpxrj7iKdY?=
 =?us-ascii?Q?MPvtDTFdqlHQLLMbQPE2rbuwFKLaDyefOHVXPEgYyho5Bfna/xxrG1LC0j8N?=
 =?us-ascii?Q?YxLUUY4mASOH3e8bKF0fPCGnvTw8N+1pHdJAGVeClJy6cQB0EGuLuiRTi7jG?=
 =?us-ascii?Q?P0G0oH+4IGCQjd7QP3O2fwwER/iSJxOmDPpghk0obR0iAa7TqqkDFXTJ++8e?=
 =?us-ascii?Q?fYOsv+3e6Oa2faL+nHG30Gvujtr2nGyHyRXi7qzUO1iP+c5ULc9J41Fy7Wu8?=
 =?us-ascii?Q?ccbZAbZzm6SfVzfU8wFOilyL5xa4qZkb8v6DK+hwH/y1W3fhzu2rjBMbQkDd?=
 =?us-ascii?Q?nUZfM5i8ZFhxtqrJmrWcX443rJr65ojzkydK/p8X76YDgqoWwGEEnkpfRhBL?=
 =?us-ascii?Q?f2grEAJsymUOFq0tdxnTFRUByPnKzu565fE+wYqQvgNh3hEHBPUxTw7YQWz/?=
 =?us-ascii?Q?pp3dpVHzlqvIdygSXyfqSLTOakMNlVkw9jWj5g/lfxO0y0VFCXoh4eGrkxIA?=
 =?us-ascii?Q?buTJVQXLh/GMewbl1qIyO9GH65FZcLEYlsUT0ChlH2Oaj2IU1hUDZ9lyXcvv?=
 =?us-ascii?Q?RloHzsufFjg+N8YP0JahPvZAtDzvPGngfOxPHRkJrR3r8gf2ZZFF1j616/Dd?=
 =?us-ascii?Q?ACAMcOHNO1wjZmp4GK6HqTsk0ztPnU65fod2gw3wVt+MPXc7hQJrB9VPLcEs?=
 =?us-ascii?Q?J1ItAr3gcInf3Rbu2gt/1Vu/eA2J7DpqLwsCQO877Esx9cQvv5BhcemMtWo5?=
 =?us-ascii?Q?9CcXwgFG36XlEhqDqmKvfiYx55tDokAdqfCGqL3KFvjlZCjjpQD0A0Ze6ttg?=
 =?us-ascii?Q?wDdcTGYfJ7RImZk9fnaqcvjeqjpEVH8BCYNGSQF35TLt6SRp4RHQZ9GMrzvO?=
 =?us-ascii?Q?9SNmrMs5CNiqFDDW9TPN3pIAr/vY3MFMQA0zJ9H4Wl0IwekxUWkpbf9Xc2mg?=
 =?us-ascii?Q?AZ+AoiWA6Ub4gfTU14pYY3molMr0FGDpn7JxioKxMuWh3l+gMGiI6LbH0DzD?=
 =?us-ascii?Q?okcv+e2oV+Ao0MZ9WbWOUtiO8fFTWTIQfZZYp66fd8KuedapB7lSSNvC6RKs?=
 =?us-ascii?Q?GD1Bottk4TVC9NwxXbQ9xu19dr+WPZ7Ii7bNQe+avIBJWZqPpEL1hvXGqmdd?=
 =?us-ascii?Q?XVsjSJ3OhtgxXqnK4PjrMCtGZGPFN1bPExeAhjwK3g17Xiy+GHHn0t/d8S3l?=
 =?us-ascii?Q?cLawm8BlYKpCnZ44TW8rfL8YYZ35XARFnEbp3YayD9PZey9RwPqGCkdfrFbL?=
 =?us-ascii?Q?CKN61E7Z7FT8BF29KXvY/W7QAlLjm80LOVNuFKxZCpzTD0tLijNNefHB6pVm?=
 =?us-ascii?Q?EQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	VUDFVU19w2bU72undWPWzmVF43gqeB5S0JMn2uNhQ6aFETBln5/HVvShGlYCt43/qv4Sm9++rDDgRLPQQCAihCeiqPoJ3DeRR5tt84KDbSUzPvHVu3+blwJVYNk0GRaegQmatdtDN/P4wEJm2xcDosucBqDPC1bPjlMHDBypFFqnW7dXccFeTzxQnfdo16niB2S+dT2EVNXLRUutoyDjADqbgpMPj33QbfBNabd8UmGZr8VvqcIZtv0W5xMb7ubD61tWkuW5AbK9KZQKlnredznKV3PlUVVENUCxTrD++gJTU7bmEFxGpfZGAroHefzL7idzO3UZfvuPhJPNOtY/okifEMP5QUYngtDrk58THxhFB52BW5iQvwkiIsZ5wGniYcjaxO8u7a7Cfq9ENSVjJdCSUOFndUfInyElyO2qKoZODhcJGmf2/AVKyY6t/XGoHJ5/sNnyoqkJKwbIcuhMl7kIFEcC1gM360d9leRiiat/rKocYSJfWDOUR7I83df4vH1Yr1brw98SXxmScm0qY2PbicQt48Xd/p2keApKohF1BiBT4c33qC+RzR9DfUak9ytEznmgxcBC0UVTRaiUw4pm12R+GK2DU1RAQNDqrH4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6801088a-202b-4789-033b-08dc7eae1f1a
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 00:35:49.2100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xkUtwYL8ol1cNMKrq7P/WTRjEl8LpRm5Siw+zb0jYP6rqkwln3icCeSMbZ9pCVj0435EJd8KW7Wnpurp2/twQpbC72wlg1UGwimF1cNDfcU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6510
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-27_06,2024-05-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405280003
X-Proofpoint-GUID: DeB9pXs16TbrUZq8K_lkNXgjV-E5n00t
X-Proofpoint-ORIG-GUID: DeB9pXs16TbrUZq8K_lkNXgjV-E5n00t

Define __tif_need_resched() which takes a resched_t parameter to
decide the immediacy of the need-resched.

Update need_resched() and should_resched() so they both check for
__tif_need_resched(RESCHED_NOW), which keeps the current semantics.

Non scheduling code -- which only cares about any immediately required
preemption -- can continue unchanged since the commonly used interfaces
(need_resched(), should_resched(), tif_need_resched()) stay the same.

This also allows lazy preemption to just be a scheduler detail.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Rafael J. Wysocki" <rafael@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Originally-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/lkml/87jzshhexi.ffs@tglx/
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/linux/preempt.h     |  2 +-
 include/linux/sched.h       |  7 ++++++-
 include/linux/thread_info.h | 34 ++++++++++++++++++++++++++++------
 kernel/trace/trace.c        |  2 +-
 4 files changed, 36 insertions(+), 9 deletions(-)

diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index ce76f1a45722..d453f5e34390 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -312,7 +312,7 @@ do { \
 } while (0)
 #define preempt_fold_need_resched() \
 do { \
-	if (tif_need_resched()) \
+	if (__tif_need_resched(RESCHED_NOW)) \
 		set_preempt_need_resched(); \
 } while (0)
 
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 4808e5dd4f69..37a51115b691 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2062,7 +2062,12 @@ extern int __cond_resched_rwlock_write(rwlock_t *lock);
 
 static __always_inline bool need_resched(void)
 {
-	return unlikely(tif_need_resched());
+	return unlikely(__tif_need_resched(RESCHED_NOW));
+}
+
+static __always_inline bool need_resched_lazy(void)
+{
+	return unlikely(__tif_need_resched(RESCHED_LAZY));
 }
 
 /*
diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index 65e5beedc915..e246b01553a5 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -216,22 +216,44 @@ static __always_inline unsigned long read_ti_thread_flags(struct thread_info *ti
 
 #ifdef _ASM_GENERIC_BITOPS_INSTRUMENTED_NON_ATOMIC_H
 
-static __always_inline bool tif_need_resched(void)
+static __always_inline bool __tif_need_resched_bitop(int nr_flag)
 {
-	return arch_test_bit(TIF_NEED_RESCHED,
-			     (unsigned long *)(&current_thread_info()->flags));
+	return arch_test_bit(nr_flag,
+		     (unsigned long *)(&current_thread_info()->flags));
 }
 
 #else
 
-static __always_inline bool tif_need_resched(void)
+static __always_inline bool __tif_need_resched_bitop(int nr_flag)
 {
-	return test_bit(TIF_NEED_RESCHED,
-			(unsigned long *)(&current_thread_info()->flags));
+	return test_bit(nr_flag,
+		(unsigned long *)(&current_thread_info()->flags));
 }
 
 #endif /* _ASM_GENERIC_BITOPS_INSTRUMENTED_NON_ATOMIC_H */
 
+static __always_inline bool __tif_need_resched(resched_t rs)
+{
+	/*
+	 * With !PREEMPT_AUTO, this check is only meaningful if we
+	 * are checking if tif_resched(RESCHED_NOW) is set.
+	 */
+	if (IS_ENABLED(CONFIG_PREEMPT_AUTO) || rs == RESCHED_NOW)
+		return __tif_need_resched_bitop(tif_resched(rs));
+	else
+		return false;
+}
+
+static __always_inline bool tif_need_resched(void)
+{
+	return __tif_need_resched(RESCHED_NOW);
+}
+
+static __always_inline bool tif_need_resched_lazy(void)
+{
+	return __tif_need_resched(RESCHED_LAZY);
+}
+
 #ifndef CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES
 static inline int arch_within_stack_frames(const void * const stack,
 					   const void * const stackend,
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 233d1af39fff..ed229527be05 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2511,7 +2511,7 @@ unsigned int tracing_gen_ctx_irq_test(unsigned int irqs_status)
 	if (softirq_count() >> (SOFTIRQ_SHIFT + 1))
 		trace_flags |= TRACE_FLAG_BH_OFF;
 
-	if (tif_need_resched())
+	if (__tif_need_resched(RESCHED_NOW))
 		trace_flags |= TRACE_FLAG_NEED_RESCHED;
 	if (test_preempt_need_resched())
 		trace_flags |= TRACE_FLAG_PREEMPT_RESCHED;
-- 
2.31.1


