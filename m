Return-Path: <linux-kernel+bounces-191579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4238D110B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 02:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBC351F22D18
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 00:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64335D2E5;
	Tue, 28 May 2024 00:37:59 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2AB1E51D
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 00:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716856678; cv=fail; b=oWSmeFE2lqyW7Q6yeA6zzoWKRyX4ZlTnP2PI3SOKD/KnTL1s2YwhGvt+1ehq+y4Ps0iaWbSOPquucxEP1PChaF+OW39qgffrGwPmJI8IRZWawU/IIb3FBFGJKiVfWg1V/1y027SKPXXwki8/ocHtOxyaAHc/0J+sr9rd0GKXhpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716856678; c=relaxed/simple;
	bh=Sg5CJH6t/0vj6cGCTnHNTOmhXZXdcNHC6cW5SsyLkqE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LWEzuJIEw/FqJg8BqYw+2Q/lPMxfaSOzJ7kpefraN76Ox4h5kOsHrkxNYjpfj4zpjG4X+OGPMn7zbbCVaRE72ESyQ6ctYhwoUKf3kbwkhSy0/ZrmjiOq7HJmevhKt370ncFUDwgtzikNQ7q1nNrfiNr95tPzf3wIkVqady7iXoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44RDI41j025151;
	Tue, 28 May 2024 00:37:10 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DqlePcTV/pdy6LfJr6g4Q3FmG0gjdqxVZWlxc+JGUFy4=3D;_b?=
 =?UTF-8?Q?=3DRo+K/z6MaxVxlbo1Sp/V7SNDPdLphp74fqjgc9AwA5pfChdKyYC4B5sJYkw4?=
 =?UTF-8?Q?9SXvgZfT_f1kArSJHQ1rkBAY3SR24oFPFRqc/3ikOVHm0vxx5P3cEciCJYGGLM3?=
 =?UTF-8?Q?SW6xihRa60LFuC_nObtWk6DQDH4MurihPOgsylr3bp/mgg2mAD4fqpaLo42Milq?=
 =?UTF-8?Q?6ak2Itp9L7epO4mXsQAd_w2geIGOaJXC923ptegJcx1+Y7GVb5YynGjkLZgjE5Z?=
 =?UTF-8?Q?lkjuv6b/duXpRG11Yhzy4gbCfZ_BLYCMnxjLG48kKo2pvhR2Z9tbfyv9ljQwONI?=
 =?UTF-8?Q?6Wk1w3S/5lCsE+B345A5yXHM/my6QRei_Nw=3D=3D_?=
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8hg39cs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 00:37:09 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44RLMQgJ036941;
	Tue, 28 May 2024 00:37:08 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yc50w8d1t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 00:37:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cq6gVs13nooM7H2U/kznFlLb7Zibwp4Uyz1hWZyoi+vyQbvA2+f/5DK1QHhGw3tsJBaEnb3ZGdgY4fuzdX5lPF0eb8tRNfg0vgRixaP3NMmcmyGOFoJ007CyBg0PoajADuqbXgI5nu1LfiZHr5CVV+tQ6vmnBTSIY37sz+gQGN48VAuDo31zXcspZhabrIvmGahFgYy3ubKTc6QEtcLS5jMOXc4AKmkZGeuCQfd67rteGMOJ6gY5zd81XPfeaDCSgLSMSIG4/2Y54B8GBB5nczMokOekISo0V9Of8qKgPBFAxSwbBc94i5BE3F/qGoqtRG2k8kWb2pOtL8AGIJk5Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qlePcTV/pdy6LfJr6g4Q3FmG0gjdqxVZWlxc+JGUFy4=;
 b=TVsF3UKjSr169JIf+69tIPiAsS8lCDDWp/FhvqbPPEvl0muJr9FIrHjrTtZGLdDxHQEZUOB/rSl08DDS7e5hJpDTegdxwOOtB8OBgsr2k/zBFZIMYEhXP3W7GBjT6kAgPBjR1jMp86xKk/FeTr3uEHpnS5XqVrUaAacAbMA3WX+5rME5VuFoyR9sypDdwXmyMpECYoL95R2ow46DWypok53v6MRVviZ5JpQMVjTQ0Ki7BN1wPBeW2GSIfoXuKhUv9HKKUmgzZ6KuBZPfBkf+njYq024x4+38AwwbCAqMdvptbpKrrBGKEeA3oApqZe21iS5XBM/qkh66m/GOTkDeXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlePcTV/pdy6LfJr6g4Q3FmG0gjdqxVZWlxc+JGUFy4=;
 b=Ly5L1pRzNvqzW5iV5yqRHX79MXkm2AsSGLMXvrNqiPZfL4J3e+irtMWORI1AIAf57iCyIofTBFCEjVTNnhtGe8usH5jdc2m7VTuB4RxApfb3j9MpQhjT/oHcMPSqAtj6d6AZm8A2652QY7kMZAhhWDtwcPO0l7G4tbqWPe30DS4=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by BN0PR10MB5077.namprd10.prod.outlook.com (2603:10b6:408:12e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 00:37:06 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%4]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 00:37:06 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, rostedt@goodmis.org, mark.rutland@arm.com,
        juri.lelli@redhat.com, joel@joelfernandes.org, raghavendra.kt@amd.com,
        sshegde@linux.ibm.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, Ankur Arora <ankur.a.arora@oracle.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, Brian Cain <bcain@quicinc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v2 34/35] kconfig: decompose ARCH_NO_PREEMPT
Date: Mon, 27 May 2024 17:35:20 -0700
Message-Id: <20240528003521.979836-35-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240528003521.979836-1-ankur.a.arora@oracle.com>
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0297.namprd04.prod.outlook.com
 (2603:10b6:303:89::32) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|BN0PR10MB5077:EE_
X-MS-Office365-Filtering-Correlation-Id: c887cf0d-c387-4adb-1ac3-08dc7eae4d0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005|7416005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?O3hg7myfUh1uryd2GXgKL2K7gsBNwzNq9RsN2vB2KxUZlxy/7B2t6CY2rKwg?=
 =?us-ascii?Q?27VQi8osCDj18v+PptBdmOXgh8mDb+vcv8wBpVSkPNl/wn55T9btdaSG/QwQ?=
 =?us-ascii?Q?J3kpI7RCw0MOUksjr2xGSSW+PEq11PO44EpGL7mkKRxQD8O12+ueESiIuOL3?=
 =?us-ascii?Q?RcpbegEEphwRoK+wOuG7OawW1aIOgpwfmuBhVwS/OxbnBqeJ/BsMDPAPTsAa?=
 =?us-ascii?Q?xxVpQDrJhL4vqEJqs8IW34ewWcEGC5pCJN72+wkqMqKOf7cfn1cr6wtO/xdz?=
 =?us-ascii?Q?+o0fZ+llN33bmDUGf0V8eghpcNKRhY9ADr/RoonrPueLTpJ+NF94JxlBnIUb?=
 =?us-ascii?Q?TnXt+QJLdImC2u+4oCIRve6PJUq0InrDOxVm8muWBYcPO1Imhoy836FXyaJR?=
 =?us-ascii?Q?8w8VHaFEIcSKHGfJyOV2gHaU0/Nj6Y+Q3Z3RacU7u+K+gKZBwvWCf2TGXMrE?=
 =?us-ascii?Q?hoYBlsx1LQuCMLbnXvJYTvXZfgHEveNLWAN+uNC5Trfot4dlHRMVzfh/H61M?=
 =?us-ascii?Q?gS63yxnXGKPW7DzqTzZdG1LfHhUJLjXgrTHcpR+Ql8cgFd6VbL2Mh20PMMYc?=
 =?us-ascii?Q?MxIpDh736yK/FvVJliDYTVdm0QApqQK2uPRN2f+uevOelunlGJcU7VGf741l?=
 =?us-ascii?Q?MRbiEehrgkNNSek5IflmIGiohJR17nnCQrOrr0FgUF5cMSxmUBb9d2xzS7Q3?=
 =?us-ascii?Q?7SwnZYremOUPlH8dWa8kUvhjNsLMtTaSjOvhBl8tp4YXdN8Lv13mdFy3JRgF?=
 =?us-ascii?Q?kayzaRU6bwVY1tLluCohAwOV7qwgx+pmc2yiWsuHYeePBS0BBFXGGGHocsyQ?=
 =?us-ascii?Q?H+eaT0SWmGbQ4gzlsXT6VUaS21DKL1UhpbxDAaJsAIev5eEOj21o2LJXhn4q?=
 =?us-ascii?Q?h8xFKezt/HmA2NfJQIz9sTdmJQxHYqNiMCA4Hg8q05gkKm4bqXQvaDbHCCX4?=
 =?us-ascii?Q?Btolg0wiMsNoj4oWE0ATwWSNO+DSqRmDRxTv1psHzSxA2KXrfCh1h/iIbxuy?=
 =?us-ascii?Q?DzkbjN6B9ZvwVc9Fv2Eu2XYOFdpu1SCjpASsxja0YjSL6FiVHTYjwwv4R1uo?=
 =?us-ascii?Q?N4s+V774dLM0qkJEc16xUtOeD2kGrdhCcyJRtF0jP7f7cmYrN7MIN6m4Ac7f?=
 =?us-ascii?Q?VKIyHPTxJT3iPsdCRGdCtA5xMeKPJiMLBzMw/jtXBQ75mkvg+IVA8ciM0W5T?=
 =?us-ascii?Q?MTiT2VHw9eYugYEC7dRLMfAR+1H+wJw58MDYK1mugtHyMmBTS1lrdDo1eARS?=
 =?us-ascii?Q?pSrhFRdslrKRZ9LcCa8/ngLbRVbg6WHTRh/NLo0TxA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?z7pWdnlwtSBxOoQAkw1ZTqI4mHIOMJmPeoi3NJiQVaAxHPED9joh2FVRTEwz?=
 =?us-ascii?Q?zEe4wA6zotuyz1t85efv/6NDXLIsnSEWpeVvY9Rgb+1YwHa59Xrzuk+wNG09?=
 =?us-ascii?Q?pxs64o1dTWoOdANnjYX6uqxyu+8FOcvXyjM0FDP5wJJOuwRWEVSGCy1dwriS?=
 =?us-ascii?Q?XyNK5jLMp1zt6FTR70saDRiOi6w0iOfG+e60o306L0+TdwZzLqD4y3wHbAKV?=
 =?us-ascii?Q?WsdfLZkuZmsOS0iOiA7JZ0rDC/NJM+2eb1wHb1O94cn7Ekt+y8ZowedC2AiF?=
 =?us-ascii?Q?muOuCd5CJqw38dBeD7CNSIzIUP1XZ+WYUgrhkBaJAdB7CFgy+6uqbCEWIwih?=
 =?us-ascii?Q?2yMCKAPd83+9NqsN3wdp5E4BSUwuAVYYlBszTe/ZpYEOZLI1XGUt8jJa6NAR?=
 =?us-ascii?Q?XA/BlEoICOaufPjh3ayGSXCbR9st7zPyHXklbBGH3MUKQ5cdzN1q1y3RMEz2?=
 =?us-ascii?Q?XJYAMOrh4aQbyegb54EkDzgLkp54qSpBXq3bwNcRFtN63b0xpPZ/TF4aYXag?=
 =?us-ascii?Q?Gv3lKpjzLENwC2nPLNEqe5J9YcjhHY35stvNkRVWZkCa/8SDFBkfmHAkvN6/?=
 =?us-ascii?Q?kB3S5XaA5F8rdDNwCbj7Wx7BHBGBO9opja5aAl88fJY1QaCW+pTiqhE2Rq6/?=
 =?us-ascii?Q?wBjRS6GASQt23CS9CdWCXXH/EsrQJcDbdXo857XLobTovgFt2L4rBTIp6rN0?=
 =?us-ascii?Q?6cszN1KXbSaXdK22YORQTCbNB7l+P1t6wnN7opi4pKsm9bk6ByyJKBk9H2QA?=
 =?us-ascii?Q?6uW7h4ux/1qjrfLBEkluoq8IwIf95OFlldotGPum5nF+m5wKGJgRn3DAEJ1T?=
 =?us-ascii?Q?WA4MZMYaRczgHOBquzdO/HG4V1bzOFivt9fRm1L1oJMwFtJfytqNBhTH5bWt?=
 =?us-ascii?Q?GyJ8IsWzRegDjsQCnPjJX8lQm//DvD+oEmPurBlsJ9L6l11QlMCQ5QGRujsX?=
 =?us-ascii?Q?GT+RgAB1rUMuQEb/sSN+SdefFI1cf1YEV3Ba7vvd8CBELcag4dDrtpko1/MW?=
 =?us-ascii?Q?IrvWJNzGPuitG4WKx4hZiqrzKheO4SDXnyg2qE+QoRKQZZCupy6Lr+9/c4+P?=
 =?us-ascii?Q?88KNgg4sO1PM9RniIR6rhuCV9kuLCrD5nRzO/oMHfqjLGX/pbfaJmWmVgnGm?=
 =?us-ascii?Q?yrl4vw6feW2U9zb9wBDzFQk4Qr9Kp/SYYBIWokdDENYyW7LVFmc1Y2R6UkcI?=
 =?us-ascii?Q?gk845F/qonuQ52DIcfICiyomh/JFYI+LtORjS8p0CAOsvV/W7/9mqGGk0DZ8?=
 =?us-ascii?Q?cRKi4oq20vDHdHyk6Pze5A9rDF/gjlzxwJeY3OFR1KUnzN91EoyKegj1vnPl?=
 =?us-ascii?Q?kmHrr1Qf+eD5r4A4YIqxbpNBJ1y1tuBZ9r7iKggv1rb428N+hwnYTYx4Fzbv?=
 =?us-ascii?Q?4nMm2ID9ZnfQCtu1E8o7g6dN9Z8c8b64gwpln2bufZBmvk8Y3Hodc4nreOfS?=
 =?us-ascii?Q?7jdsuZaJZSQLGfRm3PxlyNNqbAa0DK32hBXm6KcRhGmY5TBEMrYP8Rmjtbs9?=
 =?us-ascii?Q?K185PHWYDuPoDmNUBI4koXlucMndwhKfEhGHkNTuqowgdFtjPyYBEQvTwCHF?=
 =?us-ascii?Q?MBeqrPP8vmoUZ5UNSDabi/hbssWjGe0o59yiAJIepoK+zIVa5TsRy/JS4x3l?=
 =?us-ascii?Q?iA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	0VTUKeAcDsbO4M7peSfWgKCGPIHPcDVWnKVK/62PiKlFZkLs3AWphR4WLGx5XLjfQuf2juXP1JtHiTKNSK8fH9viSxjzmaJhCPijWlxVE7EWxkaZ1wGaKGIXauT544N4kt0XnmHmGbm1M/q3PLChdLoRJst5r0topgmLSg8u6dwb/7I+mqNuAtTyG6mAZuzXTOFFtqJFmKbkBgoI/LVyDhW2l1L4RaoKV4Ig4KKx/kZ9D9wIASHQ8VW+ZcuIBg2bZnX3fEjP1qmIihWM5ESTrIEZgvU9BZRIcAx+VEGS5nx74XraIHAJ8af3McFsvsRv2SZvEOIhBSfTrh4ZDc6Y+RfJHaFZS5HMKkfODc7CtM+wVntMYFCyMMramR3y9QcHmQgMRNwG7oQNksMEZTBkXbiYY6dvBeD43dwKf+gDNFlQLOBB5yv/0KFdcKtPP2VRi3Cw9XAu3t9pAD/lbb6Swz5EjGZkjTFL7mGOv2cjz0opOsGokE9erUot1j+TTHBl6QIcpmNIxTH6JLA4sM7LQhcxlerlMky4XWQrUdrfsR6saDm4XeinebklvhowbuEpr3O5rY6DmM6jsKYcNez8ijmj4FAOPrjpHghzxl+r9xI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c887cf0d-c387-4adb-1ac3-08dc7eae4d0c
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 00:37:06.2961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CQcV/ZE1KyYNsZsOlJ3yIeBP7M5IagJT2hsl3AWcCPDNvKQlqYhclA7y/Ar21HCro+bJ/S+iMVBAI9EdVewcMuO3h+x0jkLhZPscdHDygV0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5077
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-27_06,2024-05-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 spamscore=0 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405280003
X-Proofpoint-GUID: oog3KMVSqgLtjSeS5sJrqVeL22G2D-jS
X-Proofpoint-ORIG-GUID: oog3KMVSqgLtjSeS5sJrqVeL22G2D-jS

We have two sets of preemption points where we evaluate preempt_count
to decide if scheduling is safe:

 - preempt_enable()
 - irqentry_exit_cond_resched()

Architectures with untested/incomplete preempt_count support define
ARCH_NO_PREEMPT.

Now, if an architecture did want to support preemption, ensuring that
preemption at irqentry_exit_cond_resched() is safe is difficult --
preemption can happen at any arbitrary location where preempt_count
evaluates to zero.

The preempt_enable() case -- whether executed in common code or in
architecture specific code mostly requires verification of local context
and can be done piecewise.

So, decompose ARCH_NO_PREEMPT into ARCH_NO_PREEMPT_IRQ and
ARCH_NO_PREEMPT_TOGGLE, with the first stating that the architecture
code has possibly incomplete preempt_count accounting and thus
preempting in irqentry_exit_cond_resched() is unsafe, and the second
stating that the preempt_count accounting is incorrect so preempting
anywhere is unsafe.

ARCH_NO_PREEMPT now only depends on the ARCH_NO_PREEMPT_TOGGLE.
Additionally, only invoke irqentry_exit_cond_resched() if
ARCH_NO_PREEMPT_IRQ=n.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Brian Cain <bcain@quicinc.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/Kconfig          | 7 +++++++
 kernel/entry/common.c | 3 ++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 30f7930275d8..dc09306aeca0 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1295,8 +1295,15 @@ config COMPAT_32BIT_TIME
 	  This is relevant on all 32-bit architectures, and 64-bit architectures
 	  as part of compat syscall handling.
 
+config ARCH_NO_PREEMPT_IRQ
+	bool
+
+config ARCH_NO_PREEMPT_TOGGLE
+	bool
+
 config ARCH_NO_PREEMPT
 	bool
+	default y if ARCH_NO_PREEMPT_TOGGLE
 
 config ARCH_SUPPORTS_RT
 	bool
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index c684385921de..b18175961374 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -359,7 +359,8 @@ noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
 		}
 
 		instrumentation_begin();
-		if (IS_ENABLED(CONFIG_PREEMPTION))
+		if (IS_ENABLED(CONFIG_PREEMPTION) &&
+		    !IS_ENABLED(CONFIG_ARCH_NO_PREEMPT_IRQ))
 			irqentry_exit_cond_resched();
 
 		/* Covers both tracing and lockdep */
-- 
2.31.1


