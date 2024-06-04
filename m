Return-Path: <linux-kernel+bounces-201186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7929A8FBABB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 19:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E319E1F2102A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 17:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AD114B949;
	Tue,  4 Jun 2024 17:42:32 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FBA14B064
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 17:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717522951; cv=fail; b=ow11qh3lIZ2doOVXowIa3atGYtkIEkOrjZ8I31ErmM//ttujyrZt3f5NhWCYnVIr+kWDoqoT0ooTMS4YPOv7ohiBcwJFNXl8oM39SGs1J10tQKKAZ0v7WtlO5N5/jy/143wuvgvEoE+1RWwzxVyYVtafy5eqqTIuV9Se+tRMSyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717522951; c=relaxed/simple;
	bh=1EHbmB16KRZ2XVMPnEi36BEK8OPFEY37jHi70ip7gv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O0olflYD+iOfDznrhxtknsk0A1QAGhy5sfMnLFonJdf3cwdqadVpqL3BeRt6s2yEbjsaN24MxyFMfzPJUwgpeK9mdRmV1CscqJDRScHrp4QYB0VJ+3xhwlNCrpuGC/uVVZW4WwQ1ehTauNmApSuTFRTvdYs+UotIc0pRAnch4Bs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 454BnW2Y032115;
	Tue, 4 Jun 2024 17:42:12 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3D+orkQoZyCr3o2TgK74ExV+dlpbYMr8fB1RpcQ+RXSw0=3D;_b?=
 =?UTF-8?Q?=3DNxXKnhXC3KJs+OGMWrWoJMFKOFFSSl3SbqHzdUQILRHf955+PN4wspyoeyXg?=
 =?UTF-8?Q?sGIRFR9N_DTUoIDWi1PbAhsIBIo2NwHpuMDGm8lRCTLWkNVkz/iRBo4YKmfOCIs?=
 =?UTF-8?Q?vi+5Ahfn33gNZK_NLCHSFiDxOI+x6TTxbKn5PZjTg0ji7mvVU5ciJ2qOaqChlcw?=
 =?UTF-8?Q?AqLuGVzjVf/QOVpG8i+4_eHSe3KqcBsJQHoEaQ4D0YGJ50S6vL6Uyd/1p3VRSx1?=
 =?UTF-8?Q?mlkntoowCTf4E3lxPsO0tTWtkA_3G9SycVfF9l4wNASfTh1S+kF/74U1FVp1iGO?=
 =?UTF-8?Q?OYXWdeniJp1quKrCLW0HziKAAHNDCQsP_jA=3D=3D_?=
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yfv6u5jgh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 17:42:12 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 454HPTRn005496;
	Tue, 4 Jun 2024 17:42:11 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2041.outbound.protection.outlook.com [104.47.55.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrmdwn4u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 17:42:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AEkEINlsUInWOwV5zEyPxbQoSILhe16T7XqXCmHKh5SQUsvUejuy/YSak9GFAulmIQbSNCvgRfC24h/GHx7GxgB2C3ivHm25YNdXw41RhU6c8JD3wlUgvAAb414NMqlD5obWtxElPjQbKu4Df1YHAMOXqDT98w5GtB82mKuAaHhBug1LWngCHZqwyKXqgx7sS3pjgR4LoY+nArJPSJxz2ZDmsvKFpOuBvTxzcBaEf4u1Kc1h9lTscGHql7+QGuTiHJ44mtTroRNeNyCYpDTYYjN6rotlBogmi2EN2xMtZU7o66NT5JJSSIQT7+IVanb63PfeNYFnxz/zwqDv/ImxnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+orkQoZyCr3o2TgK74ExV+dlpbYMr8fB1RpcQ+RXSw0=;
 b=cljElUESk1qLQCtfjxMDTRINyghR2bZkvA8wAt7RBLEJmed9woSw5lJCsWdcfYsZ+zZ2vP7jZoRrdXBQ/5dmOQNbyKudDMVuNNUjXLF7IodrofDs50ljCeY+Q4hFdJ+C0BRTCNDWu0Ty+Lm0aOtRgjAwjoetN1Ak2M5eEYe0YyVNCs+Hs3Zm2gpaWuQSPOsrGce3jMprSG7xl7Ptv/IrGw6TeJbf7dHbnIVvvdz/dPwpZNaBz0/eJ1oe0qf6LRC7b7MW9zBKY6nV3mSFLMmaEKlO6fEY8J97XBpxIiaVPsoUHD1WKVkm0loWHS7OlD/ZJry9ZTZtnjClQwnuXGDTgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+orkQoZyCr3o2TgK74ExV+dlpbYMr8fB1RpcQ+RXSw0=;
 b=S27tGbpURJJqL9PYkETmrjysNWH+yWXt5AnY6ju87t5ajTsx2w6mryxhj8inOd2a7eDmUBEcyKrA+Dk3hiT7nJWe65pj7FJaFjgIIJyT1Ft9+9g0ex3JzRCLCMz11XCl6bmkVpu7ir78zmsNeu5QOw2j1Pcze33IMFjhNG3T0to=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Tue, 4 Jun
 2024 17:42:09 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%7]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 17:42:07 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        zhangpeng.00@bytedance.com, willy@infradead.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH 07/18] maple_tree: use mas_store_gfp() in mas_erase()
Date: Tue,  4 Jun 2024 10:41:34 -0700
Message-ID: <20240604174145.563900-8-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604174145.563900-1-sidhartha.kumar@oracle.com>
References: <20240604174145.563900-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0015.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::20) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|PH0PR10MB5893:EE_
X-MS-Office365-Filtering-Correlation-Id: 50728357-e1e2-4c51-d5df-08dc84bda773
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?OBrYYCebI6xF5GSuK05RpGef9AjGnFUvhmt4WxnNq6zFLlcUJWaq4PyOjL9k?=
 =?us-ascii?Q?TBjuYXLk7oHA3K1NlN4YkG/9qwr/CWDcL9kfiXNMGQR9L3qIN5cd2FzXXsNF?=
 =?us-ascii?Q?i3jFpt3H61FyIzTIBgSfCxxGDSksfeos/cB9npyueUcJ1GoNf8zGCUqGA5/K?=
 =?us-ascii?Q?lRBximFOJdTAi7j13wHgyF4JrkWxxgiIlNz+9tvKq7EPgLnz0kgKFh1SoBbc?=
 =?us-ascii?Q?b/UfbWHIfUIF+1EIURa6WhnJQwivR7pfA5z00CpsiLfG6LLTgTeSgUGP41L1?=
 =?us-ascii?Q?ZXrb3zoAXKSKPA4imi72z2Kx1Fc4mG0/Yy/9czTv2jw46OCxqW3ibS4pF+1N?=
 =?us-ascii?Q?nrGKGRS2hkqENB6ra7Wpcd5+k6EY2iXSuBQ1y7xcySUNR745kJdP3iGjVtN6?=
 =?us-ascii?Q?dCQKAih2KaPQ3xFYnMh/hti3yxfZSXKYwIbFMdiqT/VRdMICM5x60kS7iBqy?=
 =?us-ascii?Q?f9UwG1qFc7+KT8XawxtWAxYzpXiBwcEYD2lnPnSksD0M6mcLUcX6fPBKhkCr?=
 =?us-ascii?Q?U/z7Kps/+InU/6rV+Jpr4lcCuCKRpInGZQT+rpXDWyK3veD+m+rkt3oP0LdX?=
 =?us-ascii?Q?kAm3ahXFneqP7lIdk45q4fe8t35nNZWqra60KtAkG3YJSg+XxLFyCsOEU9jF?=
 =?us-ascii?Q?VaRa4l6GU80xUFvAq3sVlws7uRVIZZ33ghmI4tmUYwAnWmG2DLIvhrklvIYR?=
 =?us-ascii?Q?DJQo//EjpjDReWPjQDYfskk3BFFIFdR1qq2WtV7PMoNo/srlB+zPuSamoANg?=
 =?us-ascii?Q?MMG5h+mwtqp1uZS874hd7YBxjGCe1rWL5cCyv3TKq0ZA5/29l6RZHgZMoqaq?=
 =?us-ascii?Q?n8Wp8PqczikH8eM/jVJDrSmG5CmTIaSueifctlo2GZXAAoqQjk/OuQBg0/QB?=
 =?us-ascii?Q?YK8Cx1qUA3F1k1WACjoqCPdCWwPuwDXsRh33mOKIvsJGN3CPEt06LFg14sic?=
 =?us-ascii?Q?r8T5omu8hyqN2+8r1aWDTwRr9p5kVAZUbQ3pKi//8XU3x7jpGw4hoPx08CzT?=
 =?us-ascii?Q?A85wFfz+N7QuUt5Doz3rsDvgMRadFeyHV24+J7dcAZOPy30x2VDA/8swMRtq?=
 =?us-ascii?Q?UnWEVYBByF6qCD5e45k6s7vrnEXEAUb5nPqTnUFj+snkIJVyi5K0C9C9QpjI?=
 =?us-ascii?Q?iw2/9pQj8bie1YHDLdcbtJ+dAgnRybxHrJf213CBf/6U70ksfguCrqpqvVUj?=
 =?us-ascii?Q?3/NrjoYQLoJ+AIvDLw/fpzUzXSpd/fGF8xk1rPTlYpB5SMIi2BY2JvLa7shK?=
 =?us-ascii?Q?/lJ2uAOJaXscw0EFYrw3RWZlxXs6EEprWv44pcU5Tww9qIqqtkO10prQpOWg?=
 =?us-ascii?Q?9NLaJWeL+sHp8v1Bld5lPm2w?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ZDG0Ji+r1AVodrTU5zsTS0rHjqJA+vnONnlE2yJdva/eqpqqOziwAv3zMY4L?=
 =?us-ascii?Q?7/7CuJaU7OlThDmFJtOhrWnPGqdxggF7rph7hRcQtAgHo05ueWu5LjKRzDgV?=
 =?us-ascii?Q?JlIOJ7Di2BTizxXA3QzJYCukWJkVZIcyiYeoddy1r14vbEMeeqy7nzlefqSv?=
 =?us-ascii?Q?p4AY3JpxJuFhqlf/166v3ReZTDNDRcwbb1tgpQq8OaJbJm9nV5snlBsB6OqL?=
 =?us-ascii?Q?y0vJfcC+nau5YX3cTlkWsKtENyQZaHAiuelZ8lW04a9oF4RM16I/ba3pl/qS?=
 =?us-ascii?Q?bTxXVVwMRA40CHIAbwGrC4ILq/DzlVHHJzdsSkdo7QiKzZpdI1HSaShSEGVm?=
 =?us-ascii?Q?qKLQ0PIuUA1YaEh2rKjqd3Vn5upDFU58eONf57F1WjX6FOUeo0kfvzxF2yEZ?=
 =?us-ascii?Q?XU0FcuAng8/pFE4uz3DQjB96l46Wj9OQbYmlRNwiGHA8tz1zB//lwxZ1jMnT?=
 =?us-ascii?Q?z4b8IhTSkiTBBpSCEXvWS4B+vRzZJOmHyR5eFPJblVrHY8YI1wO5QQW9Pute?=
 =?us-ascii?Q?c4vlvDi/9VIcYmmAf0lG14KJ+p4nv0IXRlaPFTYdIrLdxWTvarFAljJpQIFd?=
 =?us-ascii?Q?DmIo4Hj2uN/iZMVznPCU1qx7ABIQrekTcnsLTXNxpp9TPxNTe0f2yY+rQOQV?=
 =?us-ascii?Q?McNq+5f5BmFOpsQiStRvDKtqk+ISbS3kM0h6q/xnUOUHZNT1ECxmi5ldihof?=
 =?us-ascii?Q?t8/P2vOf6wuzi1StM2TYUgGuaHzi8njjJZuwZCsaC9/yZC/she2NJQFDXbtB?=
 =?us-ascii?Q?W+vlaA1VcOLJlNtvSX6lyiPVB8iR/gDs1HbYSPJtqyzy75x6YYGk8/yB9mD4?=
 =?us-ascii?Q?TlXzoOHbsbgCxftoJ/Eb4ILEkzBmHc6pqHb/m+La2ST00DDjWgYUsdOXf4AR?=
 =?us-ascii?Q?Kh94smXwLAlhWDEkufyBn3shydAbHo3xQo35Wtxw+YLovuEzuMnt1leMCG95?=
 =?us-ascii?Q?u9QjA1KVrtxcAM21Ubd4bGFWXCVBr0SthuJwqbAxJl7Z8KTHqW/NNg3Dn9di?=
 =?us-ascii?Q?SwI3ZHD6mDgGZ9q10oVx3Ry9N9xozJcGijq1dkktVXKfUtPP7O0+xMMcjbCh?=
 =?us-ascii?Q?dzHo/J9KRS9iYypbaxK2IbZwcAlC/OzoOcPJq1SY876aLeApdRiq2wkC4RGx?=
 =?us-ascii?Q?1DvZJpuoM1S11LwpkUiKaZPhkYtk4U5wsEyghIPK97zl6qG/lxsCpA91GTTN?=
 =?us-ascii?Q?jmQjV8LJgwkxK1/879pDcV3ETmx/uN8RAbf5VriUz6ydbwOm/ZFKwcNdU9/9?=
 =?us-ascii?Q?bV1vAW80R5YkpDNJAEp53SmQdP2YlR5Zpvr/6wsW8zbeg9zUoIflvPHhTmfW?=
 =?us-ascii?Q?8L73MBc6Y7JMgn0q0sYLaVzPZJG5fla5MlDqRiQOR7tjctJA4kreJEf9HdL3?=
 =?us-ascii?Q?hwMShkMkC7aIJulbzWkZID+8/PYhXIqH2ZNIqKKmEhDMsnchcXUak6ituJiV?=
 =?us-ascii?Q?j5Xagou2+5TcjFbFrASeySgiiaZ400FO3oSEg0mVWUWTCUHbe08JCgORgNNm?=
 =?us-ascii?Q?V4+E36EqHYS6bbOXYiwppbItXe2j7qDaYh+ziYjvBKwuRt/Bt07rx6H2jYYJ?=
 =?us-ascii?Q?TAb7HirrGjP+hV5hlfYgVwC1f2P3n6/S6+vCqaufsIwSpwPIu6YkRz3bxVQc?=
 =?us-ascii?Q?U/wvhN99JES/b0Ngw7V+EcQ=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	qsV4eGQcNweP9DQBURVlbrWgPJ++6TLB7yqnO/ZEJIDl9X0/XtkeOCN+vACpvopD49d96fQTL33GK8wM8haBIYIHcnPanEyzv0WdsKcTq3eqXYSVWzg//ilhH04g4oHtwr6K/zP46tOzhesvNV/ut+RmughdFN3PHvXGDbu70S+HQ7g0UZOrF4tNmreaqfgcfxWNmbowFhorZWzFh0PHs3SBYZeOlKtsGUnaiXXSBdsl6esnkhW53a9JOnHpQktzNmh9lNBmbpn3MOLEth3COCplWiGOC0znWd27MRSdKGiAcOjJWQDczMpQXQ4dS/muPZLFw0yR8wHK3A9P0SrMVatpPpErWrpfEa+k+qrcGvSE0XtRvp+u3YL2kB/cWwT/ZevUyR7RIcgLkqRcU5Ge2UVXlmVoqn+Tqey2UoU4KFm3ItgKTCZQIsG/M2vo1xDk7SGgnVYZdSAY9osQ+PZakX8Qy3hIgqZ0H6zVw8TtbOyX0cdSynAIFjC0ikd0DDut7gucSvvJsMOaZx19uCoGzihIh8hrOULI+L1wg1GTa1GLDfUNFT6pTQITYb10/Idp+npr8U/xNG8EjvwPbUU45pGOtLejr/smdbOkwcy7np0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50728357-e1e2-4c51-d5df-08dc84bda773
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 17:42:07.4914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jM9t+DoXvOXLgppLklRBezSxZxDZwvYjaUsCtR6o4uyczbPedAKzwH75n8GSez74uBF5ntkbmYsmZ919+uqWWu9ENNJNWtgbITdXuCXrAA4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5893
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_09,2024-06-04_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406040142
X-Proofpoint-ORIG-GUID: 4o4uQdcgftKhPeQh0lcIiwrGNsrdqlam
X-Proofpoint-GUID: 4o4uQdcgftKhPeQh0lcIiwrGNsrdqlam

Refactor mas_erase() to simply call mas_store_gfp() which will abstract
storing the null, memory allocation, and error handling.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 lib/maple_tree.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index f1496817e52a..d74847045bf7 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -6352,7 +6352,6 @@ EXPORT_SYMBOL_GPL(mas_find_range_rev);
 void *mas_erase(struct ma_state *mas)
 {
 	void *entry;
-	MA_WR_STATE(wr_mas, mas, NULL);
 
 	if (!mas_is_active(mas) || !mas_is_start(mas))
 		mas->status = ma_start;
@@ -6362,15 +6361,9 @@ void *mas_erase(struct ma_state *mas)
 	if (!entry)
 		return NULL;
 
-write_retry:
 	/* Must reset to ensure spanning writes of last slot are detected */
 	mas_reset(mas);
-	mas_wr_store_setup(&wr_mas);
-	mas_wr_store_entry(&wr_mas);
-	if (mas_nomem(mas, GFP_KERNEL))
-		goto write_retry;
-
-	mas_destroy(mas);
+	mas_store_gfp(mas, NULL, GFP_KERNEL);
 	return entry;
 }
 EXPORT_SYMBOL_GPL(mas_erase);
-- 
2.45.1


