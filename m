Return-Path: <linux-kernel+bounces-191554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9BA8D10F2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 02:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4E5B282D3E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 00:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBECA28DCB;
	Tue, 28 May 2024 00:36:19 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADFC20309
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 00:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716856578; cv=fail; b=Fu1ypABzXn+eSUHMzWYg+s4QfNUbrabLdBv2cCu22krW/HsaaRq0rTOVpSNkB3Lkd9jXesJkl58rGVIiVAZWlh2GpbNC+2V0Xc41wqh9AVU9J/pEfWx8IpTrnjZBcRcvAnyT60oe9Ja1UA4AiH9MFkY+/B8CBDFmw8jJ/ymafcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716856578; c=relaxed/simple;
	bh=L84gfAYQ81E+gA8uIm1JdV7lY8twisDRcCpKSLCIelw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MXlD+kaXYl71Sz2EmI/i5Bl5j60xMwph8f5X1/L6sjIs+wYtuAbBKjM7UpRPLMRcS8nVj/6zISNx5THBkpTFFD5C7mVdw4zG2Wb749olAfOCdAtzKGA8lSrny42fOuvKVnMCxGboG5xX+YaBZeSL3sMuXayvXIoJR8N/dS+oQa0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44RDI4rM025170;
	Tue, 28 May 2024 00:36:01 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3De6EiB3lC+Ersv7Mw7KyxtkiBTvGLpqTJLPo7B7DSKZk=3D;_b?=
 =?UTF-8?Q?=3DlZa1BTBcBdI+8QIt60DRzeV1DM8ZaEPrKmlPoeN7SRD3kYi8hyk/qVMELZOM?=
 =?UTF-8?Q?pOeEccab_4cuH00+ZapKvvPeWvZMly1OZ5udYKlzlBKfemhyMuFYA9HE6IvKhKa?=
 =?UTF-8?Q?7kZkZRTULaff/f_e7x6e4WHN1tROaCPqW4/2mp1guCrc4pNPSmOfcP9qF/dZ+rU?=
 =?UTF-8?Q?aqbt670LoTRz5QzJ2Ccx_C3NPQIr2B3rLEBJL+zmwk8cD183TBZORPx5nRbm6vB?=
 =?UTF-8?Q?faeOH7sJ/PcLm3QEKqD4bOL6e0_gwFaQ0xz6/ldBdS6GZC7vEuonQ8Z6+opZfm7?=
 =?UTF-8?Q?cJH2B5V+zs4ZCECLpW+4Bi64bIqIT49D_5w=3D=3D_?=
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8hg39ba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 00:36:01 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44RM3W3C009302;
	Tue, 28 May 2024 00:35:59 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yc52agc6f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 00:35:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dgxr1hOmYtVBjr1wjZ+bktsvEaiofWIqB6Vf1JjEyC0GrcTkH6Pfs2O+zJxq8BwhKaPToAsqGiRIDUyd2CtZKf6kUH4XeNr3EWuEv4yqztaF0wUaeq22eacO66Auzv4DrF6PHMNTNRIiB7N7aKdEIWnWgzfxTbTvbGXlJerx7dP1a735k6hQrylZCYKU4pjYDhMI9owE7p0uV15wP6D0vby2kZc+6LFlo1qH8rPFr3AZKOD4ox7f+eLjqka4CBp2nLbdkYKJpZu6FUIFSW6mGYzSbOoS7Br6s2diqWYfv//0JQ++PllE0+wraSj2+VKiSF47hJOr92yX5UeJ5KSJSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e6EiB3lC+Ersv7Mw7KyxtkiBTvGLpqTJLPo7B7DSKZk=;
 b=mR5NlRC5rt5TgEF3HAjEOuGLXfHR3tGt6I41YEtzNbRWCVt4jWZhy2/L9GCMGqqwpfp3E3yJ9+AIrMYxhKlk+tnSJuwiEKuGCjkb4Rp3eR+8LILlxAGkkbCsfBqkGlDVAhhZDvKeETok713+5J3SLSaSgCERSkBdIiJ3UcMRVN59viIblxiUPVPtElJv2Hl2puTOlkeyfPLfEGp8sOREObl/22Lq0fujAVrhhSUW+iN9LCgbLhv5yjOO47vmZrAdQjQnm4BiqtsqmUv4MhDh9wMkbC3lbbOJUWGXXknryoZg6bjbq9R5V0Kk0lAPyiKSrre/FuTrXxoq+OQ2lTue4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e6EiB3lC+Ersv7Mw7KyxtkiBTvGLpqTJLPo7B7DSKZk=;
 b=OAf3LG2i4BeGUc3Df8N3RTWmgrCFmJAMMK9bh8z33Dl/QUa8Hp+zjzEVtGS/hl5jSQ8nOJv97YaJ0TNGgfObPzj6sJyn40tLNcoKc2kPCi+KPQHuOTOd3Y6QxEOB9BFKHPozvFNnbdmMbzMDONlot5i1wTkZMQO6hkWNn7mUjeM=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by MW4PR10MB6510.namprd10.prod.outlook.com (2603:10b6:303:224::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 00:35:58 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%4]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 00:35:57 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, rostedt@goodmis.org, mark.rutland@arm.com,
        juri.lelli@redhat.com, joel@joelfernandes.org, raghavendra.kt@amd.com,
        sshegde@linux.ibm.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, Ankur Arora <ankur.a.arora@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v2 09/35] entry/kvm: handle lazy rescheduling at guest-entry
Date: Mon, 27 May 2024 17:34:55 -0700
Message-Id: <20240528003521.979836-10-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240528003521.979836-1-ankur.a.arora@oracle.com>
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW2PR2101CA0028.namprd21.prod.outlook.com
 (2603:10b6:302:1::41) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|MW4PR10MB6510:EE_
X-MS-Office365-Filtering-Correlation-Id: 086defff-5018-4c6e-44c9-08dc7eae2435
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015|7416005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?qf4kaUUOD+iKyEx8r1SSFW9baEa8A2RdaWrjsIObnOBWDXfvqb9ht5QTIQCY?=
 =?us-ascii?Q?gl02EAus1i6Z4uKF0s5b+UeZvsZSuLqkLFopM6TBJLckSz2FoKecZmSn2glU?=
 =?us-ascii?Q?S8baiAzluk0M/xIiOCS/35OIaWqKJyVss2aPOVXUuF/RJKREgVkYuAtiQ2Y+?=
 =?us-ascii?Q?7tQQQWyczEEml8WFXGtz8Xgl3Srr5eQIw2zJFDzhP9gDcHvWwuZbUXyZXpPy?=
 =?us-ascii?Q?UFGizrqYA13FmMqp+7JfqR9apmnzIYbhl+jsblQADtUBM5ftLbPS28I1vIvS?=
 =?us-ascii?Q?La5a3Ngu3HbpDhsjDf+OFZRJVwPaYPpILt8CB5TpE+kkObvbzRSqD0A1l9+l?=
 =?us-ascii?Q?1GB65Rx6JseC/bVenHkOaCdMb3RaXTSXF5owny44vg1q4xuf3eNKITDEp0BP?=
 =?us-ascii?Q?L7OVtkOyuSNKOd0JeXZalSdztUJJUc7CGjuf3dQTebxuqw2OBioPZXZRc59n?=
 =?us-ascii?Q?vnDAkJueFQy0OwxuoaeewDhbvXsQ3aouKrMJBqhn5Y3ka54M8MBkAochIPRm?=
 =?us-ascii?Q?DswKnv4VwQBRxMPJiJoyLyNkH2pbBuA7od1ED6eNkgy5JKydkRa4WkaPsqSc?=
 =?us-ascii?Q?v1RclINEhsu1a8eUKZgiYvnkqqhUa1J6l4FeAKeuVk9csX5DckH40VCEf/dN?=
 =?us-ascii?Q?SlsrvYNImEQgOaiN3qjNUsnPTLLj7pxd3NXqhLCKLERbidlqxyn6dSPiUj3j?=
 =?us-ascii?Q?dAVO+x+Ghe7bfVv37k35xYZJpVRxDmx9JnZmfcrH3UbJpVKf6+aAg8tovY1j?=
 =?us-ascii?Q?uyXlGGlBrDsABLFuJJYPojISR4xZEUe9ooIlJz1voi7w+cMTyrzOIRBR054t?=
 =?us-ascii?Q?zQ1fGefqh/6osukKkOvoHeFzJsjCFOG2WBS6Ujznu9w+tfhmrc8Ki9iKSYRL?=
 =?us-ascii?Q?AFIJf6p1VgEBVv6CGgwH87VjKqX3Zj88a/kDaHGcDCa+GSFDFCCiH3JIZ+Wo?=
 =?us-ascii?Q?06ehaOuG6qerNBrOISv0yKp5em7TTiH6H2FSHEntBG4qadLkr7PMcaIiiFtR?=
 =?us-ascii?Q?7uB4lKf5WNPWMy7OLny4U8VO8X/gYRl7s1+AySrnsoTi4IGjzY4VecXxcRgC?=
 =?us-ascii?Q?ANlLSGkubAbFNZL/SoLwi+I8dHpbC5jn/qCdbbgwjELljVIaxD1tMGS3NAWU?=
 =?us-ascii?Q?8x/SPO3uSXctAW+OFPIb8Paqto+dCHaYjECWrRrOUQ6L8jfEYcDqv+jivNY2?=
 =?us-ascii?Q?sl4gbkDUx3xiTARlrVy1G0SWxIk2Q6B7S/xqyjm292rMZsqM1iDVduK1WTA?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?O3xl6gNLUH1vXnnNbT4ooA51yMWyZfs0godikMA+d/ytFap4Xkr779ofZS0U?=
 =?us-ascii?Q?0ujwoMgul7HKptMuHIN3rPc4YC6cyHbcux/w2aZ+Edkgv9U4+lBb2amd25WT?=
 =?us-ascii?Q?hZUmQq5b1AITfDdGemKdHGFQ9wgx7h3Yis60nA5f2Rdvs2LNeEL+PZv4TIQg?=
 =?us-ascii?Q?m54gPSE6gLWxYlOLWkIhkth4EPeXUuIVeGFnQdPGucDZtDF0Q1G7AS54GUue?=
 =?us-ascii?Q?oXHW7iI9Jc+3HKIskFa5iFUJU1wMp5OJN2qhqElTfXuvgJs7oakzub5EjLYA?=
 =?us-ascii?Q?JojSfHxu9Q3c8L/xF0HwNAqJX7iaIWnB9AdtoWJfBp0RqrM3lEZvUZ++8Lji?=
 =?us-ascii?Q?JJmJn0oMvkktgOzGUM86uBMJAa2087iGg0N9fyPkRRdW3AMWkXi/nqOTyrnj?=
 =?us-ascii?Q?CDHm6LZTH3P8SQxnWSe5NF9nkNJpaLRvC2svakum7BR7ISuEA8CyoFitW+PT?=
 =?us-ascii?Q?kD2gP58l14Qh8BqFiYW9bfc47OT2NwvJ1EaxEm22Stv8WJq5i82QtgnYlu2s?=
 =?us-ascii?Q?XssXWfNKMUERSARriB6suFQAoZzQt3UT5ONq19nrHoOR8MfwLe7fBmrZK5Eg?=
 =?us-ascii?Q?fDwkjXeBKhgRmSDcETofs3/6eXsbAuHFoEqmvDJ1BshuzNukoOCESc5vM/6X?=
 =?us-ascii?Q?pGF22HK3f70VeW6MWVENbdHROWRg3DDgy6a1Xw8jv2pY3cZoQWfuGE17koc2?=
 =?us-ascii?Q?SFkN+WzVXpTfuxvggjUMrG5ico7F+KsDIn3hlpfCz39eRRqLlpZSQBOifsYf?=
 =?us-ascii?Q?4XRzYLToio+BWYpWKlQowXGb4qF6fhIIZRautJFmUYZJJv+NjeDDLGm3zmqb?=
 =?us-ascii?Q?ycY9GoSu25E8oDYkQQ41AnV8XtNvQCTd4WVDrQRutAolj1t8bpvdgnH3uNYF?=
 =?us-ascii?Q?T8CYcjZ8a1Z+wKtUPbEK/byWfZZq6ldkrAaU3y8b9SmKFY8U8HGbQ1PZ4rL6?=
 =?us-ascii?Q?1Fpahp12hZtPJipa8c24loNYQbEkvMbdG26r96Idz2xLNKBW9I+ISY2SKLeC?=
 =?us-ascii?Q?dG5aEzQKO4Lj2g3L1GL6573dviTaQxY5j2kjOm9inTWE9MUDdZDU7gj9Tb5K?=
 =?us-ascii?Q?5lfQrUCXMGOx1JcTnF+mQmyJeX1DLRIOqVR73iXCDf12TdA4keF68OpW0CzD?=
 =?us-ascii?Q?wGAhajrX49VFCrOlnUAVCffKQlV0MhoxoWcwcH1Rt0EmVt4/i9OQixZIvm0A?=
 =?us-ascii?Q?Pc3elYE9vOoWxBYv0m2VUhAevbyly8GsA6wewjaQ41tOr9YKZf6knlgiaFsJ?=
 =?us-ascii?Q?g9WVK18NRQtzrAku9dblP8/O8lk8xam+q1flXtE65i+IvKm9XRZioOfCU1Jx?=
 =?us-ascii?Q?8Pmd4V0MBBCYMQPCkPOIq6lryafzN5jNctxnckrJlcaXUfJdjXIhyPOOyjKF?=
 =?us-ascii?Q?VCknv8i7QhKIixMinFngbgL3qPWbZIha0tYO5K4sG2e6pq/vpRwHnjw8AdCM?=
 =?us-ascii?Q?xfbUFIuzCfmm3ZwnErSJ8R4+QYTsQhZ8BFizU4s183hYfUzbrbebMAloM9V7?=
 =?us-ascii?Q?dCn55pnZRlTpuN2m0VTXR+QvWrw6XZpWUhLx+83433a3GNtf/9VK7zU675KL?=
 =?us-ascii?Q?mecphHOjgIsicaTWl8q9e28u/WqxkQLWnhcbM6VLmpWnTLVOCPe2jftI4seH?=
 =?us-ascii?Q?Rw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	rBSGSD7ZcoiwPqurplBJIFa0FjTn0EjAYQUJVAcI4V1xT2KpQyga4uzd13cWYQD7i86mxe0+bJ7xr3dwAP1BxmsjPBhC/CvANjFpNNEoSr96wwv/X6Q/YjZ4TOaH2Z/+lSE8c/+6dRiz7sCI/lgfs8kznDkH9vNl1FgdAOemzyh+yI1uaMn3ncXOz2nKwXhk62oI/r6IsX8JSBrXwuzf6jz9kc1mSdfunGhtoa7l4r71ggCPRDiHXtYjVJRWfQPdzgaWIeczzCsjBblm/Zktsei03Fw37tFjiJ/COdEpkrwWmikK8XMEDkeg6+BSzGCjn5mJIZm5qHwL0GU8Px12mK/ZUU5fIldtAc5Z6T5sttnfs+ukYDlZbrMSHyrnV3Ft0kY5aMWIBil1q1fdvUvUxXJlsp/q5Tax9C84PN3aWfxUV3FKTgMGiNGC+kGPROL8P/UuFyDbRiwT1WmYE43GRz9Kkz1ClqBzxyJNA5uEJ271r4m9pGaADXAQ3gs0TXtOvSdGLMfW0FmmITWbvvoxwIjnO6mgGtprGCXdh4OnoQ9S6cO/cmhlhtcCOit3SzOiQhBDFBayoNgN2CbjxlR1frugdwUi134b4vWTXZqZyHE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 086defff-5018-4c6e-44c9-08dc7eae2435
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 00:35:57.8455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: efNiwVArlxJyzHw4PJE4QO5z7zruHCXEk2V11ivEDejMKq+f1Nv/L6+elOaU598BHUv6qJXQNWAgCC7T4u4JrHVEP0sD3setcDiilGdmdkU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6510
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-27_06,2024-05-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=884 phishscore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405280003
X-Proofpoint-GUID: dPSxCsbDjJCKs0Ud4bFLwQjfd67qmqL5
X-Proofpoint-ORIG-GUID: dPSxCsbDjJCKs0Ud4bFLwQjfd67qmqL5

Archs defining CONFIG_KVM_XFER_TO_GUEST_WORK call
xfer_to_guest_mode_handle_work() from various KVM vcpu-run
loops to check for any task work including rescheduling.

Handle TIF_NEED_RESCHED_LAZY alongside TIF_NEED_RESCHED.

Also, while at it, remove the explicit check for need_resched() in
the exit condition as that is already covered in the loop condition.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Originally-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/lkml/87jzshhexi.ffs@tglx/
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/linux/entry-kvm.h | 2 +-
 kernel/entry/kvm.c        | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/entry-kvm.h b/include/linux/entry-kvm.h
index 6813171afccb..674a622c91be 100644
--- a/include/linux/entry-kvm.h
+++ b/include/linux/entry-kvm.h
@@ -18,7 +18,7 @@
 
 #define XFER_TO_GUEST_MODE_WORK						\
 	(_TIF_NEED_RESCHED | _TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL |	\
-	 _TIF_NOTIFY_RESUME | ARCH_XFER_TO_GUEST_MODE_WORK)
+	 _TIF_NOTIFY_RESUME | _TIF_NEED_RESCHED_LAZY | ARCH_XFER_TO_GUEST_MODE_WORK)
 
 struct kvm_vcpu;
 
diff --git a/kernel/entry/kvm.c b/kernel/entry/kvm.c
index 2e0f75bcb7fd..8485f63863af 100644
--- a/kernel/entry/kvm.c
+++ b/kernel/entry/kvm.c
@@ -13,7 +13,7 @@ static int xfer_to_guest_mode_work(struct kvm_vcpu *vcpu, unsigned long ti_work)
 			return -EINTR;
 		}
 
-		if (ti_work & _TIF_NEED_RESCHED)
+		if (ti_work & (_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY))
 			schedule();
 
 		if (ti_work & _TIF_NOTIFY_RESUME)
@@ -24,7 +24,7 @@ static int xfer_to_guest_mode_work(struct kvm_vcpu *vcpu, unsigned long ti_work)
 			return ret;
 
 		ti_work = read_thread_flags();
-	} while (ti_work & XFER_TO_GUEST_MODE_WORK || need_resched());
+	} while (ti_work & XFER_TO_GUEST_MODE_WORK);
 	return 0;
 }
 
-- 
2.31.1


