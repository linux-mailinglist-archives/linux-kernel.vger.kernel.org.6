Return-Path: <linux-kernel+bounces-201197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4ED88FBAC9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 19:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8B0D1C21DA2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 17:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DC814EC5F;
	Tue,  4 Jun 2024 17:42:51 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9CA14EC42
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 17:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717522970; cv=fail; b=c9WY6DSXiql8ERUTal3qZWuQX8OfV/Oww/wVzK8ONq6JXlbmQjDVQhAigEoA4S7gSyypNSBKZ9qj0y6tsHWvT9jS4yu0Nlrua3CVPQP4ncxek5V43NAXCTBN+EGqsl+hcmnbdK/qOeh4W6mktHJozgahfOxZj3gAOh6XIQV0vv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717522970; c=relaxed/simple;
	bh=XSIe0Azr+askvOjun3d+S5/XsXbXTxwjTZcGmD7Chq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jLmOu58ivXLGx+zDDoisz1T5vY13joGa3oR3lgBe5bpw13Zg9n/Qv6TU6Utef8SlI4R+FJKxwGa5UD3PQD7IjZO7aRJ1UtRaHpYQ0XjVQ624qmjjlOfOy36CfVBRgd9io92w84P05rGojG1xkynEGobYfnDLDA54nKyxse7g8ZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 454Bn1i7032558;
	Tue, 4 Jun 2024 17:42:31 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3D5zvCRKl+U2ByYXCU/OBlf+JIMmoEO64HTB1VnCJPdP4=3D;_b?=
 =?UTF-8?Q?=3DNeAlU3KggAcL7oCzb245s3ruw61z046ZZMuyQ/lQDOJXFKaTI91aeu9e/uF5?=
 =?UTF-8?Q?/31jUcvZ_fas4l+XakfEzWdnxC+m9KUtIWalDTllZASHb3MKzFXEwhonHCZe97A?=
 =?UTF-8?Q?HM5FA3iXZlpsjx_hM4CEcgNs2CaeMbqJoTMVTgvMBig322enjM7QXtGEo5wqFii?=
 =?UTF-8?Q?QmmhNbX67Ypvictb2G6P_PComKxGm7KJvo0IZYPd8aFVeQgXNczB8cz5C0ozXB4?=
 =?UTF-8?Q?veh8ByRm0OeLcoww+yazKGok7o_qyUy7nXFLEePRS9n6qYIN2D1MSBU5b1mQD7k?=
 =?UTF-8?Q?9DSqdmn0HtKgsy8DTyn9Lz8mAx0xL+/p_3A=3D=3D_?=
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yfuyu5j6y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 17:42:31 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 454HRBZL015719;
	Tue, 4 Jun 2024 17:42:30 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrjcnnes-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 17:42:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hFl7b9SvHKR6MsTQoZ9q/cL5/rR9J/MJGBBszGkYX86Q9f84uIRK8NS8+RjDq9NRvrDtVE/6dzIPwqdlspH2qpiW/AvH7W4Mnktb2F62CEns/QW8tuAkw9wzDzanPzuHVzq7OGxPSVWD6HtMcog36KDw2KuvxPqLse6olhY4c3q7h3CCKGilgd4CE+MD7Zu0NKVThwgseqkej1Xi6Mz1Wuo3EftLI/dgAOx92bo3wi6c5FUPH6/dR3fWJOfZRzq2mD1Z/4UeEAKhVnkkxfKbrJg976RGNiwLfdZCmIjMgaDSNThMxansEF0/8T5WOsOjGoUE6yFEXt123axvrm7XXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5zvCRKl+U2ByYXCU/OBlf+JIMmoEO64HTB1VnCJPdP4=;
 b=iSEC/rkeea8k0sQVO/B+hEIy79HLYDwjC97NBEV9xK0oMHt9XmLxDGbEuEKVJ7n5rEc+xlM5gc0d5YvTiXVGgdwqP7IM7d/zyrrVbKYUJorbMtIML8NgbAnxMSMT+L7XAggWdD84ctbQQwchlsHunC3Z6l33Kg0LWgDI3tFxvw2cl5ffborzehEYDTJQi5eTMVt+DA8d6m7sW/DodoOT1b93+rdPebtZ6uDLyEnNK5YUR4Eap5tScvW0/FCOolj+POz2s5NlIWhhDGnM573846bjmVJx0O8p2fUNYwGWKtF3ky0J+c7viSK9r/iWSahfp0ugzinJ8Xjbt8Ksp/s0Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5zvCRKl+U2ByYXCU/OBlf+JIMmoEO64HTB1VnCJPdP4=;
 b=nDu2E6DwPqt8xqBGnJUuIiQV415gGQ1T+w9Bp023O8Qca5Z9P6Gf429y/57vA1lsKrShaVHd/rGry6YPbYqFmhftU0LdIxDgMQ7FKecg76IwDpZ87gHkRS9/89WT+t086YOFt5iSBf7A5mgudgTvhfN/bo8VkIJSejyzF7hluZo=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by SA1PR10MB7593.namprd10.prod.outlook.com (2603:10b6:806:385::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Tue, 4 Jun
 2024 17:42:28 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%7]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 17:42:28 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        zhangpeng.00@bytedance.com, willy@infradead.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH 17/18] maple_tree: remove repeated sanity checks from mas_wr_append()
Date: Tue,  4 Jun 2024 10:41:44 -0700
Message-ID: <20240604174145.563900-18-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604174145.563900-1-sidhartha.kumar@oracle.com>
References: <20240604174145.563900-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0029.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::42) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|SA1PR10MB7593:EE_
X-MS-Office365-Filtering-Correlation-Id: 92b8bb8e-f776-4443-cc63-08dc84bdb3c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?nUTGd/dcNXJlnlFN2G5bnxHf7IY7R2ArEtXhl1Ww9WK3cLgjE6zxgMpt/+7Y?=
 =?us-ascii?Q?0+bwpfUuxJ6UwPAkQjjuDkqwoJKhZRYN6QRHQ8LspUnr7omgEbCyEaH4NS5B?=
 =?us-ascii?Q?Ii/mNkl1HHV4e4+XqztLLkBTWzaQQDMpffVZCrwtEIazuRvnUS900jQtgqv1?=
 =?us-ascii?Q?HZsRFRlI/wBw/K5lBl9TvCSxkmR/DBYpf/r30rRcocVKXkz6IXBBbyN1cXTD?=
 =?us-ascii?Q?Rie/wfiiknLIkXkyKsuOQecZaPAXTlg40i2fxoVF6tIk84s5ywXvUA1KYKUR?=
 =?us-ascii?Q?2Rkjbc8hQO1f6x5LTW9HKSHqCiIijS0Oivg+xAF+IFKoNixioZ1ZaifCQQTf?=
 =?us-ascii?Q?QFoVjAsp2DEuf7OEoA08xWlMNPc7ECMaWhM2P9I58/JkuECKTWxIh9QkbFm/?=
 =?us-ascii?Q?P0rLVUCDtzw03fUCRceO4+/WcttjA/NlqGnIRezpY/zX5yVZ7Mcm+e1OpjrY?=
 =?us-ascii?Q?zFJXRgt57LqgBv94z2GOl4UYGl0GrMO82D/zg4ZLXXVbsewnhlCpbc9EfdhQ?=
 =?us-ascii?Q?+2zAeszq4GN8JIgpVBvjOBtiWSmmEREhOOm8lgFO3XiuK2fLraJHXjhxqmIU?=
 =?us-ascii?Q?4fLRH+vEDhKT+ZCtaOgQj0U3DggldbcYT23Qgga3ooyCK6Y4NNshT/EScBU1?=
 =?us-ascii?Q?uJMY2S0Pvn4hsl7USolrigz26aDcmIHlhhB6tLug4a25uqx0tMSP/bVvCiAC?=
 =?us-ascii?Q?2APqL3jprRSJpSLdnaBzGMhOBVYbIkMKXPH0CE/moS3+VXf/LvoNj+C37BNG?=
 =?us-ascii?Q?bwBmLqnqXVbiw0HUdaErxztRufwhZ7noKFP24lsUFOi4UT7alEbiGuD8xYYY?=
 =?us-ascii?Q?+/mb28yEbSYImrVgpGXslWX0yrIUfDzA+x92FG6mT51E4vLtw4E5mbmgUYMT?=
 =?us-ascii?Q?NMxCqkJqq3YuZsjbf7zwIEjdLt8lYcmyYEAs6+ztB5ug3++APM2XMfRRF82j?=
 =?us-ascii?Q?VTHw/GT/3bLeXZF7BvhYy+r1BnFMcu0FRwoeqIhpoBhaCRzN/Ct3I6/NETwR?=
 =?us-ascii?Q?jffte2SGv9cjVpcgVY3YLVN3FFu08Pn+f1oefD8FUYUtnmUaeVex36dqK1ab?=
 =?us-ascii?Q?kYwBUOE6e8vhN7Xj7RLZ2qH/E65JQoVG24lRs+cB7GUgvr9+YSTPdCw8dgi+?=
 =?us-ascii?Q?Ulgi4lxexPCN1ZyIGebkg50HM5K1oHPuULW1cS3IEkh5W/mst9z2Nikp0Iqh?=
 =?us-ascii?Q?TQ5hbpZtkyEOkhqT4LDkE2L8pSjKwmafR5S+UToXMhbSOeYE8lSswDACCKh9?=
 =?us-ascii?Q?+kzept1FpTkdo4uUUQ3wWDjLBzGUmQgtfNBorYj5yw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?e1kGhgBKCXxSAav1yd37nRSGR7XM1hngRzfAUrEMvTm/BDKGlRv+y1TC3mDo?=
 =?us-ascii?Q?k8Un1lvuS7A0aKzQZChqDsbUtnTDiRCdji7CQh+lB5cfovoyOAAjAaca9Rij?=
 =?us-ascii?Q?FBk/IM3Grcr0vYvtf2kdhIdpJ1LNXDGHr+19vvGgn4/BBs5ShagMUq0V0gVp?=
 =?us-ascii?Q?g28lKAOkwUo3pAmU3E5BhRR8Lrb2yezZY6kwwNde3/FyDySUxKIgJsHQYxPS?=
 =?us-ascii?Q?JWwysiABSBbne1DchjxD9lw9CPmL3wIcfmbpdPJYuhmwgbrG4sjB3w0GuzCq?=
 =?us-ascii?Q?49LUdPkjhQnowLz4KSyc8jnA65oCEEYdCiZbnoKvLELZH9thy9C/be2m12Ag?=
 =?us-ascii?Q?+cnzUUbCfYd5ii1Bs0+cO7fcA2QuyOcbG7S6IdHdUhlmv7y+Mfppd6gn5biD?=
 =?us-ascii?Q?5rzNR3kYAkYHcFrAWmOtNscG7MO01m6TlCJQry8E+oiYDhNGTutQaMgFOiO8?=
 =?us-ascii?Q?b8vpPzPLbcCDO+a+RrKzg0bT3TpvhukRcbyjDXbdt+JHaRTxpiPa6XMSmYZQ?=
 =?us-ascii?Q?xfOcGRlgqszAbn8I+YbgeFsSsGjYeyRA5ivkK2WkD8khE3oa1rO/G6MrWjAE?=
 =?us-ascii?Q?ybr2eJaYrJT6MVaTSaTwXjmm1ISFhOph3nF6yXeVHYL3p2NcZ8Ely47viiu+?=
 =?us-ascii?Q?ZSMlIwJCbnWMkApT0q2R7AtRosWtKSN6KHGlMqVZmtTkT8kKpT0mqyhAe+U9?=
 =?us-ascii?Q?UZCj7C6G5n3cMp9BCFaHv8sT6pTNRxifu8LcCnHX/D4+/ulRyQ468hvptJWK?=
 =?us-ascii?Q?4ad3boFrEhOIsieHb4PSr/J5iM8cz8GgBeAO6xDLZ0JNru2Po5HwQiZLza7k?=
 =?us-ascii?Q?xhYR16vrhd2R+OtdSanatmdnzwYE3UWiMESw1Oa1Hrsnl6opjg/VjM6djedK?=
 =?us-ascii?Q?ue0ECXXZioqumPE5HWH2LWoXZnsn5dKEG4aSeqde+z39W7fsdWvJHbNjlU5D?=
 =?us-ascii?Q?8wRqNUsnZsL9D0hPHgySLScCq4l6vFY3t+yAfuEwdSB/XyTx0wUfzLNOA0Zn?=
 =?us-ascii?Q?z+lVEGdcB/zowBd8aJjHcuYMO3kQNR/GUa7slQE5sMig1zpVljJO1es00EFp?=
 =?us-ascii?Q?dLRmWN9X/NfiNianHRW1eV2fgHatiafuN4q+moNPTxrxmH7X0LnqzEA1Low9?=
 =?us-ascii?Q?f7g+zsPU2QmWlFQXinaHnoXaqj8ZhoD+UFlrJ/UQF/6Voxr+y2tV7IRY8uEr?=
 =?us-ascii?Q?NWq9NaPlrbVYCJqCqbwS4aiF16zG8GQYLc31Lwyn+KQAA4e4Gkb52aObNWRq?=
 =?us-ascii?Q?jcKUTCoNd0puxfA9JahXaP4ZOkln4KncaSOlUpgBNWXqrtcMSHLRVPnY3BaV?=
 =?us-ascii?Q?vlRMG/c+ubmCTpqsrDWCkVckai985bzaUOXX0mhtLxlKdAqYzOitChy0KTmx?=
 =?us-ascii?Q?bPq07cTdx4uGOZLq3XR27De/8U+QXosccLqTsFPIdNqjrMQoYyTVP3+ipTXt?=
 =?us-ascii?Q?Gg5cX4zY56XXYeWJ4nmpWy2KO45bF41gJOVIv5ouvIig9lr55ho3KN/pVdPu?=
 =?us-ascii?Q?Q7bzbxO552T5tpBzc27HbOJDgi9YYE8J7BJvzDGgDN03qEfENsL0v0JYgGMt?=
 =?us-ascii?Q?JhGN3ScugtCd/1fV7uG2WZlgDy+uhmzEjm+YSvF6oBaCTiRtLPSXgplcEI2I?=
 =?us-ascii?Q?Cm4sptlo4155wELBdNSpIB4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	SIWrxWfRw262gcaH0L0iavJqfugcDUXH8XlH2GeY9N5tYfwWTzZaKTgwS6YZQpc4eV2T/GDYXyLF4uFOsTydJQ1psjbvttYpoYOW3jJSgmXpJ2iq5nPdZ0ytb1XonwvpgYhxt1gryYMJsJunmjpWYq718XVLa6b4i6OibfHhBXi4VENIu12rx0NehXUQjyejCBbYsLok7i2noTWsAAfzUQYTAmubsk2yvM/RYLM2wF49OEcp7L/VRqkPh3HshF3OyOO/RB6Wbr0jqwt8x9O+S+3xELL7dMrqTVjNn40xbqgYXVJhoKHqAiO0WZpepDjzk6i59z4EvqBopUdVYqihbcNZDPB0//DpOJHcfWTp2DdOR85Da1ZCPhxO/67Q6Of5l3+kaslYKgo84tvEc2fnYq5uOoWb0GrZ835LfBLAzeJ5jR3Ae3a3OT+CzfzVhfTv4fIk1d6JPVFMPfPL6Vk0p9OKOP4Oj/X7uPOCh5esp+w3mnrlmJgLsh+VM6S3udwkdoOfLqhAumgdV2fISBHXZEYEbuODK3PlqooX53hzk951BLrsuKuU1J63VIxHcJyePMAQAh72QStGaSiwRaND+iGodYYtlHHItZlkdY0yR1s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92b8bb8e-f776-4443-cc63-08dc84bdb3c6
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 17:42:28.0714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dqalQIRAKT9dG/CWhIooAQmAIDeEngSHw4BlcB93OklvZKJ7RIvlugOnYS/bfgrCedx8tAnnRv7Jd+tetZdVEnOTgphB9//1oKvAiNU76Cs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7593
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_09,2024-06-04_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406040142
X-Proofpoint-GUID: zERGJ5ykFZStswL5NZ8BtfpYz35ybi5m
X-Proofpoint-ORIG-GUID: zERGJ5ykFZStswL5NZ8BtfpYz35ybi5m

These sanity checks are now redundant as they are already checked in
mas_wr_store_type(). We can remove them from mas_wr_append().

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 lib/maple_tree.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 3d2d8c2c24df..a90512d15549 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4062,17 +4062,9 @@ static inline unsigned char mas_wr_new_end(struct ma_wr_state *wr_mas)
 static inline bool mas_wr_append(struct ma_wr_state *wr_mas,
 		unsigned char new_end)
 {
-	struct ma_state *mas;
+	struct ma_state *mas = wr_mas->mas;
 	void __rcu **slots;
-	unsigned char end;
-
-	mas = wr_mas->mas;
-	if (mt_in_rcu(mas->tree))
-		return false;
-
-	end = mas->end;
-	if (mas->offset != end)
-		return false;
+	unsigned char end = mas->end;
 
 	if (new_end < mt_pivots[wr_mas->type]) {
 		wr_mas->pivots[new_end] = wr_mas->pivots[end];
-- 
2.45.1


