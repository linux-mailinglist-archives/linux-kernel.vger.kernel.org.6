Return-Path: <linux-kernel+bounces-201191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0A98FBAC1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 19:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DA641C22438
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 17:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6777714D2B5;
	Tue,  4 Jun 2024 17:42:37 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0D414C588
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 17:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717522956; cv=fail; b=na1O1oBSYoFj/uLdcX4p7+2mHvFm35xCGucTYceubtM3FrjvcKc5Hd+3JjR64azIHFHsPwiIgATKjIyhMvdDKroJ3Yef3z4tWa5ddOhHsINpHtwzXT16jLE3BFSjcukhtT48ND+kDoLOzVgk3/wrTYcS890ZES9vDKkAAXaEqJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717522956; c=relaxed/simple;
	bh=U920KuQz9P8oqbMEEE5wD4Mz5EglQjz7U2pjJqhKLI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qcGWdqLCPGTsi3AcQCQeBO37wqDv72sYqb8/bBvz7h0R4YrmkRMjWjDVrs00P30PjttT5NTyc6eF2DOkHkohLvmynX3/EDfa0dn23QCsyHeYDRz+i6RvGGLqpUOGpdH+ejioVkbGtFSmMvyLRhgMQhx1r536ty6hOHWZYmf2tmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 454BnIf2028071;
	Tue, 4 Jun 2024 17:42:21 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DEFfMVjj0307ATe57Wpr6UCL8Rk+6A4Ycxlj6HCesF/A=3D;_b?=
 =?UTF-8?Q?=3DMxRPowNGd2saAS3eiLyrnf3094PXk/wZ2viGL1WvVVMa3+ZvQSu5mX150sH2?=
 =?UTF-8?Q?BPfuEB4T_nDufJJu9J5Aa/3ksqNGXgtqfrE6EQzHNhcX+J41n7p2Ei06+R4Dwik?=
 =?UTF-8?Q?7AfgYmE+8uyp04_kN6hwgeZwqlYpCEcLtPTQYrkNlfTaA2C+wOmn/PtTKNSBsbS?=
 =?UTF-8?Q?tUdawznoVKqGSsQYjrwC_pU0bC0YhhTs1fjbSO2Bss31ovyS2r/ppLwtfCL9qbA?=
 =?UTF-8?Q?ye1W8pLZgPdkt9d38/vkUxhDpI_HZOSk/DMXqLu130nxNCgya9WxbyLWyphwOrS?=
 =?UTF-8?Q?fmVbzxiq+XQsSc1SlOoZbRTWWv6zWY8b_TQ=3D=3D_?=
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yfv58dj9y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 17:42:20 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 454GNr3H015565;
	Tue, 4 Jun 2024 17:42:19 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2047.outbound.protection.outlook.com [104.47.55.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrjcnn8h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 17:42:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XpCeQkY7ZBmEoTHs2vdXK8WB2CjJg4JWC+VH7L4sEkPcdy9G0qFPJdjWYl94CWKtLkRNSMEiFtW1WRxi32b1spAB7/du48S/jhILz55ccFYYurjnWlWeL2XiaYFK+RHADuJ4TXKa5Is9+NzPk5NSNolUOHqbBarh2oKeALZPOcnds0i7nGdSpEp8Z/takWl8ge+YueHvCa/C2azn7gp0h1dw6S8ccCAJyH6LLWzVVq6TRgsSkUdAHGS6lQPTp3lY73ln7vN567wzu5VWV0GA3Xl8V1W1DhALcsYvGCSso53bqu/IvZZmqlalQcRN1WM9yTAlLrzAHKqam2A7QsZxpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EFfMVjj0307ATe57Wpr6UCL8Rk+6A4Ycxlj6HCesF/A=;
 b=mJVu2Gg7AgF6BKePpOvI2Av5LN1oihP76yRoy0Nj1LG3SkdtUEwnY0bYGWgwIW9TNxZrSzVK9IjcBCM5ozcVCVEMIEvKJTgRTKbfhmoUguhLZxkg/+RbKnJU2U+d0W859r2aJDrEyP+KiDUrtaiaHieKBAQKToQwR2deLibYqj07NiEhxo87JQpLmyaM7dx+gTVmBEejGtObSoUz72naQMjFpND3InkS/jwBX7Tncn6WyYH6OrH5OeyOa1Sl9frX43vDKxMzJrvGfQ71GEA77D6yKAhb6Pc/1Jm1MNpq5urDuDHIX1JAvDYRj4TYYtVLlRCvMD+ixBjD4UKivBmUcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EFfMVjj0307ATe57Wpr6UCL8Rk+6A4Ycxlj6HCesF/A=;
 b=HrGS3b+P4DbRWhOPIMzuODGyTXiiKIMIpVicHlMkiE1lrAtVSN6Nerp3cEZB9EtC8cXuxMcfZFr6dQTlShCeQ/28NIkmGOKmrt3iFpMTEpg/IfcUGBodDp1YEUpo5ZVxAWwSjwiATO//K/eZBlO1qKOdDwz6//aPruSeLcU7qpE=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Tue, 4 Jun
 2024 17:42:17 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%7]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 17:42:17 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        zhangpeng.00@bytedance.com, willy@infradead.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH 12/18] maple_tree: convert mas_insert() to preallocate nodes
Date: Tue,  4 Jun 2024 10:41:39 -0700
Message-ID: <20240604174145.563900-13-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604174145.563900-1-sidhartha.kumar@oracle.com>
References: <20240604174145.563900-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR04CA0021.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::31) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|PH0PR10MB5893:EE_
X-MS-Office365-Filtering-Correlation-Id: 04ec3810-4fbb-4c8d-5448-08dc84bdad56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?fx8YT6T8OoI7g9f+ur+pbGPrHdctdYfCvEZNDjXQK6r/F6AlgjgD4FvRq527?=
 =?us-ascii?Q?/Y4YC/uPfjYyh7wckC9JPjSrOcj9jNHzGbrTuJTnsvE85gLIhT9yngY4Bi4e?=
 =?us-ascii?Q?qIOiaFlWZblieMABwAul01IgTiMLaq4THSpjn2sOm1RzYwQajz+oW2rxm+UI?=
 =?us-ascii?Q?8ydHlUqk1XfypibJPWMjzyb/MCsOqvCeCh8PS8dD4beKZeYnFiPY7Jtq22h2?=
 =?us-ascii?Q?ya4M4Lk3veYxW9bemKLP36/cVvvTx01HTi30erYqumHmr1Uqyt3/5fPXxeZ4?=
 =?us-ascii?Q?+V00chbdgqjHI8cxl8PGQex0cAW46rs0KVfLsNcX4iJmepnqpYK9bG6H2xGh?=
 =?us-ascii?Q?Xue8FxjAwgVRA7cytigapSFj27C26oCKtyP6Q5BA/FR1gfhTEH3aFZglflKZ?=
 =?us-ascii?Q?HiemgEug2oTKo444L8WKxU89gT35KGsbiyGQuCrTyBblcduFNUcvzrD9HEiQ?=
 =?us-ascii?Q?Ok74RA3UM0JWHQcDnmqYph1IqPox5fTuUi7VDfj1hugZOQdEb5gR4HUyHUby?=
 =?us-ascii?Q?02gw3mvK0mMo1Plgx5JXQ0ZnHkoOOOKWCNmM4/GSDGHazHf7sxuITUrZkI9Q?=
 =?us-ascii?Q?lwTyTkrnh4Yn6ERiqwthGvzwvGwLxtnUSgxYhBWov4U2RYvKnNvncBTvHU/x?=
 =?us-ascii?Q?SMqYDOYI0M65PF2FQ8daxWvNWKCcJr9QuFH3Tu1cgkJQM+cpdtRsUToxeE5c?=
 =?us-ascii?Q?xx559E6PuY0YyjcQ+jUlpNK/4QpG4xkShnbvWMmMXn+VIVZvqce5ufoyDtev?=
 =?us-ascii?Q?sIazoctbpNUHBDIdRSD8QSz9bzw6gyYLx4gDpcjaNcQAEF9iILCcLnBD/+0z?=
 =?us-ascii?Q?4frFAHg81ndSIgzh5FGslQBaXSN6Jogz/ImfxAHez2rbkKXCh55VfHVVhbq3?=
 =?us-ascii?Q?QJYnoNs0sz0yB4rwCwI2kaH96Us+9+P+P62i74KMo7GoKeGPY3/K5sU0gj7q?=
 =?us-ascii?Q?Locxsf0fcMZZ4mkDaRNL/UqlTpdC9sexvfa8t9J/IztH/mne9z9byqjbJTmw?=
 =?us-ascii?Q?iNAGgMdMA6+sJ9TjnFNI9Ms21XsAcT+s8fUtATfC+bh+1nJfdxWXAE/4XxXf?=
 =?us-ascii?Q?DStBDXF3sI/tCNEppuFgLUlgQFKIVkoIf6e0CA8i7GZWb/g6+gaZIJJVr1/+?=
 =?us-ascii?Q?018Ma3ieopGqzKYpnDLMT6UmfTDpMgQ/YpuW3wDnNoQIT2Lai6zE6ljG4PZO?=
 =?us-ascii?Q?e77cfEZ1JXwQwMtIkMIDkAO8QElWdcXLQfu7/h5qJUfiCDhwRdwxveFmTEE3?=
 =?us-ascii?Q?/anaX84AlYAZOV4nAJacwm+Wc2g4B2sT7m9LIBySwjCIkNOgywfcspgbq9bn?=
 =?us-ascii?Q?4uDHzRi9NchJ/PngEeAA8xcm?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ZinUU1qFYwWIC9W1nKI1//VZPfNSM1dL4ZyXfc/Hr0++9jxCblnT7Z4N4/lS?=
 =?us-ascii?Q?WPNBgJ5CpVACT9YchnMvVDemWbitCKnq2xSeFq5wSe8xS4l+egxSfcHr5SOg?=
 =?us-ascii?Q?vAThyU21Eq2wLNEQEC84xLwGbrvdIyOc+Xl1hk65zvzJHkeQLi+4qS7ZrGtP?=
 =?us-ascii?Q?fkflwQA4m1TMPQLLnEDeVS8OohpA/+Q6tf1epWF3zfnCSxTTkutYVB0/yBV4?=
 =?us-ascii?Q?1+RkcrJDY/dX7DdmIvqrzBPnzJbK/2yYEgmsGmViiuD4ESDf6u+1L7MHCWAN?=
 =?us-ascii?Q?AhBPTz98Fsxxlo6p9Spl6Wgbas+ntK41uzZ7Zp3GNhUuDK7fM8f4Nwu4CJCn?=
 =?us-ascii?Q?fN+c39oFhSvyPTvgA7+FnzQ0/2R/0Th3qU0cRNyd8s4DGEYIwazNtSMK5J76?=
 =?us-ascii?Q?KqltDFScYvi1/dCOZyvdmJvvi9PYvkASozv+8E2nUnfXA8AASLfrZVhapow5?=
 =?us-ascii?Q?36bJ3Mfu7/O//x9lAImkjJba0R7GDrqzvClHIZqYmtzMYo+ZEAZm3jgVERCn?=
 =?us-ascii?Q?c8h9HQm83Ckuj0ARI8hT1SBCkkcWj5iBsmmwjj8KUGT4WuDDu74aAv4UZ+me?=
 =?us-ascii?Q?9eDGABl7CYbVwp4U0XbyoSqIwSbZmv1+mXisAhZWVQkzaEcw851hSjoDX2U3?=
 =?us-ascii?Q?BfXfD1us7azZ8/XROIDepmoW3G6Z0oCoJ6yfrEn+3i3sDwl+TCuTHkZspaWe?=
 =?us-ascii?Q?8AItsQNydPL1t9WgbV6s/ipyiJ8t0vj2V/Yno229LnikThjSBzdYXagj/mfb?=
 =?us-ascii?Q?hnis7u9+ssCw+llaLht1g+LWkcMJd6yvKLRblUnRV/wzKxawIIAb85ZiIWIJ?=
 =?us-ascii?Q?D8lXLNF/trR3Y9cuSwy5zfZNLGzx7WkUbLhWFDsJAvFkUgGB9MIcetMhju4l?=
 =?us-ascii?Q?veT9esSMp35qwcoMtsEmzxR6j3SpssMBnu7IqcEBMhSLYwih6C3FqVeqe9f1?=
 =?us-ascii?Q?TO+hzswiUraM+IlisGnlArqUCujf8yz65k3aH41chTqAk3d/h19U6ykJ1FdS?=
 =?us-ascii?Q?ystX5u4UK6Ep4mazwZ17g0v7Nu+VC+Fn/r7isrpH03KBaez+lLG2T/tMaGB9?=
 =?us-ascii?Q?8+OnyS8Sh0uOzg2xMnpMv9eKfJ8oNH/gNuJEqwurlYU4avShFbS2j74nQKsO?=
 =?us-ascii?Q?eXGxUoJqmakIF1IygZJAoi3xDch6gsoe7XCkHZdy4Ec4oIIGMx4TU2XMwBog?=
 =?us-ascii?Q?TJgrJ7SjXGMUqiA3qKWeB2Lm/Pf8o6M4uphLmefGqiYjIECNiPJ+h1v7YxiR?=
 =?us-ascii?Q?G2MzaxXmKhYgSrEXfDl0J6wnFDLSmz29vFi8y14QkB3RvRha2KvuirJWrsPb?=
 =?us-ascii?Q?7B1K79hlyBsakHZWswhjBpHiw39lgIXdnqiXAMm6J4pIM+3kN1nRAUnXWziL?=
 =?us-ascii?Q?KtXPumxA1uPeYfqXZwD/Sk6/tvzHE0XOC8ZCuUMv7Rzba4qGbKIGYpDw845B?=
 =?us-ascii?Q?CC/QPzGW990rMgfv8R0FcAXg+YFOsxQ6+sS+VICbqOFjj0FLc/nv8stoQqq5?=
 =?us-ascii?Q?KTyFWlRpR4hXHxfFnNNfRryNDpcFbZeWVzxWv6Yv8mZJGWLcFxRFT2qhHHm+?=
 =?us-ascii?Q?AwjeFtOOmeAcZHu2KwPKJ9iSGk8okAd9GA5/4iJiUr+JgCQXLpIKd9DRiFJi?=
 =?us-ascii?Q?d/Q8dJgtNvm8Mq+Pqd+HoWE=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	SvA4u3yM5wfYFDGDk9XPpIwjfm/1jTYbdV0vXNGfwog2N5j1ACKkWThQO45vzEeboYue6e42ExgwLDuvOEJbrzydGdCqr6zFOKKK/C11yot+Qb4j/68u0JPiA6RXINCgTFZhFMm5KeDfTdHA7/svCkuBrf3Cp1/uEjZVIVaf9mx6p0ovdDoMjqpPKQO/Jht7yh36v4MPqVjMBZUr58mbDF44CBrFUnEZ2SuBKswbIlLNZWI6wffwsz6r0w9FxTfNchy2SEMs8avTObzRK0eSxBJ7Sco2AReVgx9w5AAyRZngCnaurBF34KGfKK7//QK7dl1KrkDMb9VUdntspqbmsqRays/gu/iBf+9qRQN37OXfgHhQ8CHNyZlwWD0RKCC/YkBCmRqBBV+2DqT0CoXfL47gAOH5EZYb5N3TOMd3LW9Lbck3tXn2ghvjRHij5YHa/tRAtixIeWCV8nOuHz+GGmthlblV0LxiTYZy4Wj/fUdB2uRGH1WuYJ3iOXwERIuv/9k0eUbz/BAn9QGg4Fn8Gqg558KEWde6uU472khyuKegCGAHhjpx1HcktbzjsSPolCOF9EB+JGTleJ+tobgoyi8D/SPI8vcUZduUoOKIdIw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04ec3810-4fbb-4c8d-5448-08dc84bdad56
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 17:42:17.3339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hJb2WTfQgHcTzFpbNcate9PY7xndkOcCA+OlEgNmKK26YiBT2FJmgcxUo6din0quAH/jg9ZQi7tk07ZMuzNmtqZ6/AVk9BrzmMLChgsYYGU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5893
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_09,2024-06-04_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406040142
X-Proofpoint-ORIG-GUID: ZMVqSr4Kl0NzC6Lyq8I0ug1sQjfAqvXt
X-Proofpoint-GUID: ZMVqSr4Kl0NzC6Lyq8I0ug1sQjfAqvXt

By setting the store type in mas_insert(), we no longer need to use
mas_wr_modify() to determine the correct store function to use. Instead,
set the store type and call mas_wr_store_entry(). Also, pass in the
requested gfp flags to mas_insert() so they can be passed to the call to
mas_wr_preallocate().

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 lib/maple_tree.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 20e9d13c2980..314691fd1c67 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4445,7 +4445,7 @@ static inline void mas_wr_preallocate(struct ma_wr_state *wr_mas, void *entry, g
  * Return: %NULL or the contents that already exists at the requested index
  * otherwise.  The maple state needs to be checked for error conditions.
  */
-static inline void *mas_insert(struct ma_state *mas, void *entry)
+static inline void *mas_insert(struct ma_state *mas, void *entry, gfp_t gfp)
 {
 	MA_WR_STATE(wr_mas, mas, entry);
 
@@ -4467,26 +4467,24 @@ static inline void *mas_insert(struct ma_state *mas, void *entry)
 	if (wr_mas.content)
 		goto exists;
 
-	if (mas_is_none(mas) || mas_is_ptr(mas)) {
-		mas_store_root(mas, entry);
+	mas_wr_preallocate(&wr_mas, entry, gfp);
+	if (mas_is_err(mas))
 		return NULL;
-	}
 
 	/* spanning writes always overwrite something */
-	if (!mas_wr_walk(&wr_mas))
+	if (mas->store_type == wr_spanning_store)
 		goto exists;
 
 	/* At this point, we are at the leaf node that needs to be altered. */
-	wr_mas.offset_end = mas->offset;
-	wr_mas.end_piv = wr_mas.r_max;
-
-	if (wr_mas.content || (mas->last > wr_mas.r_max))
-		goto exists;
+	if (mas->store_type != wr_new_root && mas->store_type != wr_store_root) {
+		wr_mas.offset_end = mas->offset;
+		wr_mas.end_piv = wr_mas.r_max;
 
-	if (!entry)
-		return NULL;
+		if (wr_mas.content || (mas->last > wr_mas.r_max))
+			goto exists;
+	}
 
-	mas_wr_modify(&wr_mas);
+	mas_wr_store_entry(&wr_mas);
 	return wr_mas.content;
 
 exists:
@@ -4531,7 +4529,7 @@ int mas_alloc_cyclic(struct ma_state *mas, unsigned long *startp,
 		return ret;
 
 	do {
-		mas_insert(mas, entry);
+		mas_insert(mas, entry, gfp);
 	} while (mas_nomem(mas, gfp));
 	if (mas_is_err(mas))
 		return xa_err(mas->node);
@@ -6532,7 +6530,7 @@ int mtree_insert_range(struct maple_tree *mt, unsigned long first,
 
 	mtree_lock(mt);
 retry:
-	mas_insert(&ms, entry);
+	mas_insert(&ms, entry, gfp);
 	if (mas_nomem(&ms, gfp))
 		goto retry;
 
@@ -6581,7 +6579,7 @@ int mtree_alloc_range(struct maple_tree *mt, unsigned long *startp,
 	if (ret)
 		goto unlock;
 
-	mas_insert(&mas, entry);
+	mas_insert(&mas, entry, gfp);
 	/*
 	 * mas_nomem() may release the lock, causing the allocated area
 	 * to be unavailable, so try to allocate a free area again.
@@ -6663,7 +6661,7 @@ int mtree_alloc_rrange(struct maple_tree *mt, unsigned long *startp,
 	if (ret)
 		goto unlock;
 
-	mas_insert(&mas, entry);
+	mas_insert(&mas, entry, gfp);
 	/*
 	 * mas_nomem() may release the lock, causing the allocated area
 	 * to be unavailable, so try to allocate a free area again.
-- 
2.45.1


