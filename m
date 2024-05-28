Return-Path: <linux-kernel+bounces-191562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2EF8D10FA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 02:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55DE51F21DC2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 00:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A135FBEF;
	Tue, 28 May 2024 00:36:42 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4602C1094E
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 00:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716856601; cv=fail; b=JZTCMhTmzr9Rlx+Lv15StmF+pL3P/56mHtWQ0Z75XDKDAkGbMtkbaoJRPbRA0/EW8cAWvJ6RcfPiT2gO5VEu/W6ukXgj+pvXr44O38R9btOOM0c4VdPI1AgpSsnomDuFGAN729iB3bjhh80TtydbUkkIGLOeVB9lxcUWb6mGiZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716856601; c=relaxed/simple;
	bh=9lUWvzxHZpOZ9cC86w4mNYxi5YkUshxcBmxAJN3aI8c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mluX+DuXZfOSU+F4yR+SiV/9CoeAMnNkbZaZLLs1L9In8bTkXVA8vDAqpm9wWRn87O2q4UXJn7yGSonRlDgJlMlub9/D6PVh5E1ITQs0U9La6VKd0X6VN/OouOaUX5cf/odOYaWLXfbaNYyZWvd8ykxbosqBluQk12uKRWx4Fd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44RGYJA7025223;
	Tue, 28 May 2024 00:36:18 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DIVrQcpJMZc8IN8APUEjJt3FMKCvaYshsPTK1xQu8Bfk=3D;_b?=
 =?UTF-8?Q?=3DKmNM0giZ5Zq+Rh4GieIZU9HXUMWwYbPlXGhxjBeaK3g0Wvf7UaKY6uusdfcW?=
 =?UTF-8?Q?JXfaB9lV_rXixDlBdrzqPxUF8ZRFiJg71rdKPSNPMcZSE6ymjDJlU0T0PQ0J5LL?=
 =?UTF-8?Q?s17Po8PnPCobq8_PeXCLIVF5SfktD0GX/DUyAvfA/JKZqtJhh5lY1uZ5qmX4WUK?=
 =?UTF-8?Q?EMphqKUdsr6R8op83RFx_h79J7mK3TFPWJJmoQjIX6W3cR0k04tGhHqzevGS4zJ?=
 =?UTF-8?Q?0BOqkOnKXuec64CwAfX6/6VCku_Bk9eXOQX2TikmLktdiXkyvRiMAsWrdoHpCba?=
 =?UTF-8?Q?Hb6Qy7Bjc9/5ZTamYhIJVNhM2tznb93w_WQ=3D=3D_?=
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8hu39du-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 00:36:18 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44RLCf8x038346;
	Tue, 28 May 2024 00:36:17 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yc5057y5e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 00:36:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I3Rvmw2AV/QX8qPsIkBZ/p/wHfy9Wusfy/7+SCsbgYZXvJ9U5U3n34vFsI8KW5fO0TwffnzPbC7AzwY6g4Er+z/GtR5GFrX1XPXWyj83VeUyVhixCcQxDLPp4t5Fsi9WcldkV6+Iez77t65LAS1hXlk2JrAo9mhsys6LAaPbHhOuK2TgEceaUIkSIMfN7ks2EDX5d5p68lthM8u5Z8AYoFwOABBn5Z0y70C2T1Kmq7OVKbK68UuhdS1KoAPJxeOaevvYBUAcxpCO+irDtYjYQA7yozHk6K7T766lPqukTWVohkeQt81ULXrHsn/DnLWcwVVdxEanVzlKfVgS9xoZUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IVrQcpJMZc8IN8APUEjJt3FMKCvaYshsPTK1xQu8Bfk=;
 b=NvcZXHUa+sJC86R/huS/GSObokeEgoWTCcv/HRih1ySRfF1oCLO2v9FPevOardXmQmrsFDNiSjamI5S6XUesQIWsoSzmhGgwRw7ICtFpjOFKNGkbQXlpCBCrvzryzgSIGh7R28pVs5BoniwxytKg7FNpmDf5dkrm5L+2gaSIOtCbJ1kCSu4GEnEmQa4q0RF6NaOQGxIZeHUsb+rd4mlH8esBaNvw11nbcN+dboPADvRPy91Htn9zP6nr97MOMW9td2DxLDtqEL5aFBZWfc69knmzRwWa45cv78JYIt5BAgtUHF8MuRyNiRrdIGI0703eNIOFYXqmUsVfm45Z6YOizw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IVrQcpJMZc8IN8APUEjJt3FMKCvaYshsPTK1xQu8Bfk=;
 b=yBC4DGFsDbfSHQqgPxZwwIL68iRFHKzFfO0tn8WgJf5UDwioKf5FWH2FltHIkvFiwvFc1cmiDD3FyMRSbtRy19EU8nFBb6ux0l2IgPXouZ0nsRSIjRzbTyTkZVOR0I5YYrhoo7tIdXTtFEo7qehcouZblRBewAhtjoqrk1N1xsA=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS7PR10MB7177.namprd10.prod.outlook.com (2603:10b6:8:e1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 00:36:15 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%4]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 00:36:15 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, rostedt@goodmis.org, mark.rutland@arm.com,
        juri.lelli@redhat.com, joel@joelfernandes.org, raghavendra.kt@amd.com,
        sshegde@linux.ibm.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, Ankur Arora <ankur.a.arora@oracle.com>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2 16/35] preempt,rcu: warn on PREEMPT_RCU=n, preempt=full
Date: Mon, 27 May 2024 17:35:02 -0700
Message-Id: <20240528003521.979836-17-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240528003521.979836-1-ankur.a.arora@oracle.com>
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0171.namprd04.prod.outlook.com
 (2603:10b6:303:85::26) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS7PR10MB7177:EE_
X-MS-Office365-Filtering-Correlation-Id: c99fa60e-45f9-40fc-8f9a-08dc7eae2efc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Up9d7I6bhnJvt7lL/h9vlkbXLg+bbmvVs9vhvypKpjjyxYljlbMUek3X6rnw?=
 =?us-ascii?Q?pywOhp9V+DGhnG87rPxbGxruA5yEv1WDsjj+oBk15Suj/ubW3UxNaU0LBeme?=
 =?us-ascii?Q?5zCi2euFj8hrIdHehoJu6uzdcsV3xvSIOUeS2Vpq5razxcvkPhkXfovDLHxo?=
 =?us-ascii?Q?ia6CkJ6PdREmiFT0DE7Ej2ZKRp/8FDIK13V/AQ9Uw0p9R+aJXzwm8YhYZOUy?=
 =?us-ascii?Q?pL9Q1q+At2qP/omq/J5tuRrN4mr2K8PoZoo9MoX4an1RIHOIHpUSOgVzrtGY?=
 =?us-ascii?Q?3E+IpMGyDrJCbpjPjujSaaqbRNyNAhYVZvs2/vn0PI4UATloYgUKyr2YoVGa?=
 =?us-ascii?Q?4CODSnK+qf8VIrDMtBlTlrNULW6VHFVWhJLRilTO/LmOtdeJ8HvMYmRemzBB?=
 =?us-ascii?Q?tCHn8t0ErPrbreBsVv5c90NcxKro3jd9Jw2P1fsWEf6VgRrUrDk1TLeRyzW7?=
 =?us-ascii?Q?wI4LgqQk8EklaFx1/ePbq+xuCsTRb6OHVjifj9MwpvOgWUhoIGo4XzavnSlr?=
 =?us-ascii?Q?FyjoBsnOoByxHfTnukxeukOLtbpUOm7b1nBEIBNXOxtABTT8ixxkLMle4854?=
 =?us-ascii?Q?1A8MzlgPHqk3NsvTL/PQxg48AnOGLiqy/E9raNDkSA5hmcXSGymlgIht7OMw?=
 =?us-ascii?Q?UbdnvWfFw7CM3fl3o00I1fT4oVYZZzK8LMzqgCTKHll0Rcl0e/w8hQdb7MDH?=
 =?us-ascii?Q?cLQWWg48T7cafZLrrp+iMxDXWkbzNB5WyOCuu9WkaMw7hnZ1iU8Vn88JJ/1s?=
 =?us-ascii?Q?VveRR/gCWM7mqB6wpAGKZILBm7BaTTwnx0w0LvlWawNaBD+ppYs0Y8zrd1LZ?=
 =?us-ascii?Q?Xf+8j/zFI1UeUrUwn/C//mJZePh9v6gNw1AgqbxWhr04k+SKDBc949Psi7eU?=
 =?us-ascii?Q?B029arCuAuGzRTWLiXoHIDtHVvlm+GC3ZVj4TLk2iVGqQRxAA/kJa0shZoAz?=
 =?us-ascii?Q?2mmG7FxtQXqq3+T2E4b3IxGMsI8ganRRxIjk4heV8yDyIQ3x9NP8CYesymrX?=
 =?us-ascii?Q?Ds7iWkHsg34dZdPmVHrF/4h5UtIqn10mFVZ+Rjz7FEIw0G7E/MogrZJ/GtY8?=
 =?us-ascii?Q?awnjZdR+jvaO7ZZ+bGwljsLXP0q3qEh4jqA/pjniV22vW1zIRm0u27FoV/Z6?=
 =?us-ascii?Q?ipJ/bobbaSMSnnr5UbDfTZi6jTpRZu7dG5AJQFhjl99WFPZNKPlhJhig/cfZ?=
 =?us-ascii?Q?HGEXFhHSrVWAKSfUAWHbSRpzZt87zDBV5Zx0EQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?XZ6W9jdicFggdLC2IQ0Z//LfHfOVrkUkEXSjjrwmv5lbR21DuwvsGor30GWg?=
 =?us-ascii?Q?SF56EqVBUbtFydyjfTHCphPxmguKxs8Nq2nJ35kZZ6oxuYXGjJ3At4n66ULc?=
 =?us-ascii?Q?pQIizx6LwuJ16gzPXTlB+EzwA5MQbvVyRTKRm6zp/dzcb4xhDdaRTV8Hp2Ny?=
 =?us-ascii?Q?Iu6R8/ON8KA/2rqeGPkkVGNof4UBq+7HX6u8W88M0MMq/vkCleDCtEtunA0r?=
 =?us-ascii?Q?JyYlgyI595FlXJ4HoaxumddFn0+425jsam4Bs1BbSV+JoEzDqvb7CMLOnrOZ?=
 =?us-ascii?Q?4Rvyn94cw5EUSsM+PVZXJucSfJ8n4rD16Jd8OmgY5OoZJN9BQOuuCs+B0IWq?=
 =?us-ascii?Q?DsKkjtw0eJCsRXzBVT0RAEXlxSUpRcAXXrrBbVbJ7mfMzXGs3pQdE8Z59nPY?=
 =?us-ascii?Q?+JXHDysfbLkqYfr2CnmpGaVh0xOqNoaazaKSu2fPW/ESivAI9hKDToMaFdmi?=
 =?us-ascii?Q?enIyE++7DBzkQaiBqtDCEW9089BWjHM6D7mOy13/PyRBTXG/yRahTXuwrcqu?=
 =?us-ascii?Q?zrigyFODdYtMbQdsMHDwShRxWCBEIQT5v0Utr5jCyvLiikZ0b6PK8B+u5XXI?=
 =?us-ascii?Q?RRQQGCmC/KZH+o+Wtw5dQFymrkEFDWxPICQqZ6Hiy2T9LsZ6DR4ZMJYeMYkQ?=
 =?us-ascii?Q?IF+swKEDBzrrF0m+LYEqRF1wr6cMVvUEvEik1qLfoLrMV9M4FVJtO5IjTkLG?=
 =?us-ascii?Q?nE0T4M7YFYzMbLoPHEgya1f9B3s3OKBgfWk63OiFnnffYllXKXzfVYO2ySll?=
 =?us-ascii?Q?iA0qHHCa4CYB76fqOkRkTY2R6A7UQ3rB7vJJ3OIBoy04CV6ValCxAqxxxEkp?=
 =?us-ascii?Q?g/4ioxviJAXnCtN2af7zFc5e3MtCqDu/Bbd1AxHMrLWX7ru2eb6zA9y/8fRa?=
 =?us-ascii?Q?h7ODuWIXsbYgIskqsZw+zDq0v0lE1Pg6voQfPAIwSfXAFFI8Uzuia+x350Cz?=
 =?us-ascii?Q?J2RdoOmmePJzg+PvP3/CPuAzgLiItzw7r4CmVxITnkaesBTKuy+gZGwSksWA?=
 =?us-ascii?Q?+v3Dts12d5zgfIJsJr+NSxOVzry1y+sPnDzC5dFOePFd54ZZArFvqRj3m8ty?=
 =?us-ascii?Q?2T5we6XuplKyEoQrUrkxYCDyAEk20mYdlNNc6IZV4ZJeqh+any7lieOgwUBr?=
 =?us-ascii?Q?t7BLWQNdQHsHmwPHlry6ZBLBpqHa4OhSfA7zsCOD6w/9Bg/PcnNxwz+jIIQi?=
 =?us-ascii?Q?A2GWX6e5vZ1JQ3LeUnHmvU0RpNCivkBNQV5ESAQM8q2+s9B+4XcoZb9tFDjB?=
 =?us-ascii?Q?C9Scty/75U6jz68Hc/BDSQUHsTTMywCIjjXkPV6n/Cx9Fik06f5Za7itIYfH?=
 =?us-ascii?Q?+gGrWQJl6pHv0Ctx0ANaB1RGVvstaMtVuKPTcr8xIJCON9NyH00PMxFK8S1v?=
 =?us-ascii?Q?ZuH5SNAn7ps4iexJjM3EbGikb/W8hhQ7xPdghesT9irLlJXdGo+xbdN2qXl3?=
 =?us-ascii?Q?xIiPySPyPtj7PL9COVg46pUcXa+iIf7KN3ijvncO4f+nao/D89AT4Tzk8Nhe?=
 =?us-ascii?Q?LOnbUP5vjn5AJ38QY18ANU/IB0TKVKJhIGhEyN9K3dvMNI4lWubK+I4TSjEM?=
 =?us-ascii?Q?aDNjh4t6j3RdfkGKODbppiHIJZNe4Qvjxx5+la6DcmCypJAL+mA1YYGnNgas?=
 =?us-ascii?Q?+g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ulHI4Quq2cwD0Nb3LjD6mdT88CXRse6O4JMlA6b/S60QdWtjQ2Oyarviw4Kcr7yIL0R7jTHs5RwNPOvFfWL/eKhJ8fsW18v9lKNzJ5KNIpa7y0JsdOWpTDyrdqzJ5mk1MjiIjmE75M2rz+r5c+Mltk+1SXR3nNS/XTDs2bVuz3ym3ODQ9T5pXQaFOtoJ5oeSI08Wc9GhLGe1Ngf/F8TMarB40EeyPd61QxT+k6HCwHrjmArnSJAgDnmUFooGeEDp8mqijxd4Ir09eWoSs19zog4eDkLWdALJ4ZxKepGsmi6vD3ZLfxuu4I2wUqw7G1mlHB7GGKKqDeFd7a9o1tv33laIO5doMjmETtDfBB6ykhWHpU5dx6pDrHo7/crxFMsF/OS+lJxdXHHsUGz44PHJNSFQetcBoMjbaGKx+dGRCRLyqOjcDXONce5AOt605dAb2wvMKFVjkrQsMU2JyFMLQIoOM04cm8HNPqflBRqNB4jI0F5XIQbKZyUXS142O3+s0E6kO0nk2ioJDzR52eoIu2N6aUbzY0rFh3SEoWdsheJFPqGLW6RAkcb+jbopCtuTeU4rHOvDXt/B4StjgeFLtLA/SPxVKw8l6o2xEITk9p8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c99fa60e-45f9-40fc-8f9a-08dc7eae2efc
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 00:36:15.8206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ezj+qiJDPzcfvi3isvRAbTO8kIGsFnqv/aKcFU2s0g8vdap+aIVBX6iOIrWiIltz9pS0r1gRhoPl5ag1a6e7J6tmaQAwMNAVaHsLtGzv3iw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7177
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-27_06,2024-05-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405280003
X-Proofpoint-ORIG-GUID: 1Ujf-DHj2w4pTiFG4swvKiTmKbKhcZuN
X-Proofpoint-GUID: 1Ujf-DHj2w4pTiFG4swvKiTmKbKhcZuN

The combination of PREEMPT_RCU=n and (PREEMPT_AUTO=y, preempt=full)
works at cross purposes: the RCU read side critical sections disable
preemption, while preempt=full schedules eagerly to minimize
latency.

Warn if the user is switching to full preemption with PREEMPT_RCU=n.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Link: https://lore.kernel.org/lkml/842f589e-5ea3-4c2b-9376-d718c14fabf5@paulmck-laptop/
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/sched/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d7804e29182d..df8e333f2d8b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8943,6 +8943,10 @@ static void __sched_dynamic_update(int mode)
 		break;
 
 	case preempt_dynamic_full:
+		if (!IS_ENABLED(CONFIG_PREEMPT_RCU))
+			pr_warn("%s: preempt=full is not recommended with CONFIG_PREEMPT_RCU=n",
+				PREEMPT_MODE);
+
 		preempt_dynamic_mode = preempt_dynamic_undefined;
 		break;
 	}
-- 
2.31.1


