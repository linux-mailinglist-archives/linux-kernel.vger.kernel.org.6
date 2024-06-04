Return-Path: <linux-kernel+bounces-201295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFA48FBCA5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 21:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF581B21BA8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 19:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CFD14B077;
	Tue,  4 Jun 2024 19:35:02 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1772414B945
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 19:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717529701; cv=fail; b=Ob2sPrXn3XzwwFMkrQyp1SVMFYteKleM9FT3pKPvlujhJDcGHg6fdfN9dJOJyurbgIP8iOMIVNiqVEoI5PyjnMF26wg31EM0C0ub8KsI5BiFFYCuYRWpW+cJxfUnYOaFuMCN7N5MYbg61GSgg/hSwhGRQt2a0vui62myND4+yv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717529701; c=relaxed/simple;
	bh=2QPvmna++U008XhJgEMCW+Gyym0d8+PiOcjWqkdPIeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ffd0V5XNw6IecOBtpgS8C29CyQNuaX7vFUDFBi00E4QWXU8tgz38Wx498bf7YZVa2Wf334IUdnYxxZ1gFaKSs6WbOsY7YvWSWb+L2PrifK9wPaFA62SXLnkkHtqN2sfnDXHlhVH2kUir/9VHKy63KZFDP1g7JR7Abu1Hk+C57/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 454JFkFu024630;
	Tue, 4 Jun 2024 19:34:41 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3Dco10d3lQC88M20IyXskdzzJdaLATeibvbUB5Esx7WY0=3D;_b?=
 =?UTF-8?Q?=3DWrD6FXAUvkyMXt2dwCRNKHRgKHk13SH5dRYBex53WldSv1w/vGIiAsi96yy2?=
 =?UTF-8?Q?ZZl5PsbS_EMgbRxTkdt3BEblKx6uFe9cHOdNXBQnH6U37gmzvJybIwJ5pKGx7dY?=
 =?UTF-8?Q?w4evaW2gKw/h9+_7lqqHGFY+yjS2NB70T6At53PSlr8mCsHeUW1oIUexxWPuEao?=
 =?UTF-8?Q?C6zFSBXsOfzm1GKYUm99_7pa4bhoOGtqPqmtpfE5Yim9QGb6FFi1zXM6ASTRcBV?=
 =?UTF-8?Q?RyYJA7Au9UR3AuDvPPpF00LN9J_Dn5EMtXl/KfVyQBb9b+vJ0k0PfEyn4DRPfFf?=
 =?UTF-8?Q?sb6DZVVnV2qKcbHmKrAudHihkO0yhOK8_CQ=3D=3D_?=
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yfv3nwrsf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 19:34:41 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 454JV2Pe015598;
	Tue, 4 Jun 2024 19:34:40 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrjcsj6a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 19:34:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lsAud1O2g39DoJQbs1aIv7LSv4ouNIkvcXIuE1ZxLlRqR8a/W3UpTBE7CvhIkgwvMPkyDvQweaUCsbyyLRtjL2mRnLrfiMuWTg2XeJQihqAV/+1Ye3DA7f3y/4lV+ZtmHVoKg05f4ZSIAZVcHjbUavmqnZUJSBQXT/q9A72SCeHJVYEo4FbnIJCkFglZfAlg6vxpvlAv6EgoOaE5QFi72lBA4wGxpxWISe8W9Ih5tBUde7JxhPCDuC0KJCIuFzMJ6s3+uZPaFdDTETpkU6cSalEy2rLN0YnmnFcsEbobR/H6uyKWJ39LFKP93kc/R2uG40z5N9hjFHZwxSR5eAhgUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=co10d3lQC88M20IyXskdzzJdaLATeibvbUB5Esx7WY0=;
 b=bf72TSWpMuUQfjLVToc+v2fB5wR7hjtyomRIerPppDGEjNjoBoGp6C4bt/zAySRxYrEDbb3NbBkJHAMWPprtDmii3xhF2DYNhVdcZfV88sWr4cRcKVqtbP+RiiEfX35Kxg5qp2DfzuO2g6UahYKek+CXLNsei4cD83WljMWSscQh5mNP7Qw/nlWLlzTxKnNRogy9oBCHGGhT+iiZMEzhpRTNUyOtoyLZD6bcI+fmkvskONRhBD9/q4IZ2Nh6skbVWcdgHejxOLeofgad5o9tQfUhfCtgFbgokGyUQbkzs17nhzBq6uJsF5qHCFjMc1URRjp7M/Ec+s5kQ/K5IrgCFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=co10d3lQC88M20IyXskdzzJdaLATeibvbUB5Esx7WY0=;
 b=h2a/deip/1u3sljnLQCKXrjUyEDeB1Pel2Sfi6mU8Grqcs8zHIj9EuHF7CsR7C9/vYk5KZiJ4E7pNEP2DnKzvHL2PN+EQlc9dYCQGfehDCtixWwq2iyQDmz1s+dRQP5b/MtYiGh0DnmYAul0vYn4jiGDoMkH2m8x2RjIVu1p5OU=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by BL3PR10MB6042.namprd10.prod.outlook.com (2603:10b6:208:3b2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Tue, 4 Jun
 2024 19:34:37 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 19:34:37 +0000
Date: Tue, 4 Jun 2024 15:34:35 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        zhangpeng.00@bytedance.com, willy@infradead.org
Subject: Re: [PATCH 13/18] maple_tree: simplify mas_commit_b_node()
Message-ID: <zhbyib7htf37f6sw6futnsjqy4w6ru442jd3v2f3i7hhz35hgz@jkv7i6osu5jz>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org, 
	linux-mm@kvack.org, akpm@linux-foundation.org, zhangpeng.00@bytedance.com, 
	willy@infradead.org
References: <20240604174145.563900-1-sidhartha.kumar@oracle.com>
 <20240604174145.563900-14-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240604174145.563900-14-sidhartha.kumar@oracle.com>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT4PR01CA0081.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::15) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|BL3PR10MB6042:EE_
X-MS-Office365-Filtering-Correlation-Id: f524396a-d06c-49b8-3f19-08dc84cd5f0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Z3gk6SfUm/LssMPw5yFmjrsd4Uiie7PqfdwmnhaPSTGfnxPVpyMVGIkpLOJc?=
 =?us-ascii?Q?KyRyjSBv7wm5D6F2nr6yyD2YKm8oD7gi1d3dnEFbwMzNKdyszbpClXM2ERjb?=
 =?us-ascii?Q?ydgD8glGCOq4yJKVMuLtdWJfVL1/A6V2w3MmvXK9PSfC5WJ3F8Z9WB2elfIH?=
 =?us-ascii?Q?dWUhWOTGxeBjRQSQpMbx+g7JATDNwMTYUO/QPqTKGWzcmasVUXdtbiio/iQu?=
 =?us-ascii?Q?Bvc75CV/GemtEXrVESkkUEwxFM5Jxq+7zEj0d9M97uDLSnmel0DdkRgkzPXr?=
 =?us-ascii?Q?Qi1oYNH0qvckgH78nBPONCOf2drJqI750XaLXUR0LJuv/h2GsXUIwuz6zN8+?=
 =?us-ascii?Q?JJ4Zc2TZO2PMOMtGyvIGn7WE4T5SgYZKYLROYIa0xub6su25Abuw7O37IQGG?=
 =?us-ascii?Q?1oqfV5gztpxxM0hhL3NEr8TuNEdJXd6j22rjg97qKrLEdRKtjbkv1yXN9nzQ?=
 =?us-ascii?Q?DcpyZvFnLbiachd+KkP9Wo9+bOavUR4ILqO9X5GxMP5HCPvJfAfRr1r8wbvZ?=
 =?us-ascii?Q?dRujAJJJxtlu8ekkrmGVsHcZbirloheN/++ucEZhMph4R3A95mgtEBxwHUTW?=
 =?us-ascii?Q?tsp3GanBjvIknTvxNAN180jvznQMvFFfaZgqc2ATFH6f2Bt5Vm+oO7nOyO2j?=
 =?us-ascii?Q?0LxIuBCkjPpCGaaPwy8nB2GFh8B7nGwMOQ8LFWMTA0deDWkkOKISGlkIXCl8?=
 =?us-ascii?Q?pFtVmoLC0VOT2S2w2VYxtFJrWxD7t7rntHOID2DKLlcvh/Er5MbuAonVhghc?=
 =?us-ascii?Q?o/aDkmE/QgG9b7gApMxbU/HkFiIZ3CeVGrGEr8Wo0phT8oYTk9WK1R05nxVV?=
 =?us-ascii?Q?81dk57thMw+1oir3H1F53xMNutSAdSblY25UT3ECXPkQ7ON78tcyrE+hB+Cs?=
 =?us-ascii?Q?3FGBIh2XJxD1AHYLmmqRuVmV2Ol/mzEStdcH3KKjrKIP6eXyEQmm2F6PK8C6?=
 =?us-ascii?Q?MwuXpjmLtAMzsTISN/Bdzq9J0SeKcftNRQaCPv5w3dZOQZWCrMChFcTc8nsg?=
 =?us-ascii?Q?Y2uIoL3E22ZdgoE/5SZZpuubzonH2EomDbCrNxbPzrDiGvqOA3zI32n+6KWI?=
 =?us-ascii?Q?oour3H0T7TQLAHzfdUmT03ia12HzQjODnP6rdgrTAXE7sQ0kGpp0WmJbgB9Q?=
 =?us-ascii?Q?P9hYhjVgCLz8SJ3GDZqrLVYfffMVqzdmOnmHmTqB95LZ1ehUqUrCTHuqhwj2?=
 =?us-ascii?Q?hGSW3JrqOJhicB1Z3rnP3rfGz5cxmCE2SjtS9s1EWlfKZJJ65dVkM5Gn8sFt?=
 =?us-ascii?Q?7objY6ZFRMP4BxeKhQW7iDiYF5btC6OZqm/zQpqc3mxbaa6MbwByee+sWk5s?=
 =?us-ascii?Q?7g/xmlc6IlYQ3/DnKfO1/sZJ?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?XrXyv3iECQYJorzttDGI4QCK2RckFEGtpxylqmHmOM2mLbyDLXZuMJuOW9mW?=
 =?us-ascii?Q?jgz1aR84Wx9rizOkJpdRfw3QnEebGRd4Zu6BOVzu/cPjQxJJbEsvOsKS6L3t?=
 =?us-ascii?Q?bup5sSAx8AbYVHZC3xEtH93iwFw3WglS6TOGuz0JUISt9SqwiTC+QVRWErzk?=
 =?us-ascii?Q?fbe+pzajvFDXeLinxcvdB+n+w7Sxdjt0n1yvDNACm/ghye+PMl3Is2gPlaxW?=
 =?us-ascii?Q?jjFyxCFZozOzCluGrHUnkd8Gc0fiw6WhUcBisWKSmAgTwscplDp1tzXJE4pr?=
 =?us-ascii?Q?hKdE/wlGmMzgCUCtc4xs5s4FRoe8/0o/zcGVQkXyMN4jLKOwuUWd1972v/xG?=
 =?us-ascii?Q?mY1hvmJfd9ZCcekAc6+ZLdpiDFIgT+zDAVWNYVZjMz+4WGzr0SrP3jyb7+jC?=
 =?us-ascii?Q?PK36ZTJDgof8BOzv9jFTxHR+t9k3mcBstQi2x+/fE4nzDnInCjTo2YacASLc?=
 =?us-ascii?Q?soMssoO9yZyVDaosBxJQXLFvbT2h6K3E+TJNdI5nqqAMpPLiuaPgcc5k2eb9?=
 =?us-ascii?Q?7ZLtgGVYN+ZR/g2z9rBPbo7GbPD2/7baGcFDBP1Bij0Yl+By2Dpwt9hTHJRu?=
 =?us-ascii?Q?5WDq7hiIqdfLNYpAUBxoI1JPCxiCS9AsVloioE0ncAlQWJ+LXsNMLgF9fFRH?=
 =?us-ascii?Q?nJg0O8LGBu45gUwSXYzJy86lcyXiDi6D7k7oNTs5SpOSKDPTRmZ2nrLKD4NC?=
 =?us-ascii?Q?gevo9inV34qZBUegtOJYjEy8U1/nCa9cZoKcOfBh1MNSTuYWFV5U4uE/cfm5?=
 =?us-ascii?Q?QJVKrDUQxPDQB+XuUwyjegH1AY904/9TGEbjiGjydWs0b6hxMIe7Asd2/w3S?=
 =?us-ascii?Q?omtaT7zWPclvbusXdCczyrks8cT0pDBqPzmMfAQThkIdV0DCzv1Aa5H5QNkY?=
 =?us-ascii?Q?Bam3MH9HCcA5j0ys+HpFD2XnyIRZhwEXTfFaCP9pcyMtSFniQZrWvudiQHVG?=
 =?us-ascii?Q?9dakIspweANl7iP1R6ubspxqO4Pk+lfuWlgX4yMqqBZWQiKN9zEHoaRMkOla?=
 =?us-ascii?Q?+7T1m8+MD99u7EHX0LkS0aWXG3DA5yBA/47iYf2efOChoaqJ3Nk3j9YP0ug2?=
 =?us-ascii?Q?DLUYX01U8MKjkk/LIEjIKinqdaEUwl4Wr/QjEU8L5FQl8a28X/U6wTZjx3IN?=
 =?us-ascii?Q?o+bUwjpK6VuMfBVY4Kp5g14alNJMdEgKfKYsZo3btVHG/iBa/PaE2UUVj6Iu?=
 =?us-ascii?Q?1R0yr+jOnsi6sxdt2Qah1uHtu1rDOdZYcMGFhOQOxIrK5leDm+IwjcE9eyB/?=
 =?us-ascii?Q?7ZBqRhW3ZktiEuORg58l2ORAGDVUdunr2TmdcMqxxYwx4CPR0ouIlGD1ImJo?=
 =?us-ascii?Q?fpx5Ia+CenME5V0Jon7cRn8OU6MrCjKcPdrCZiaoVzv4+UTZtFNKhvajynbk?=
 =?us-ascii?Q?e/BTYOZtaALG2rPfkFYxy3EKC3rKYCPc7Tq1iqx64a4S8TvKRTM2bN1MQXNV?=
 =?us-ascii?Q?meTlfIdUoh7572jrsHxdZasgzsrk6eRb8r3qGBiW5jxvb745yQ1WxZMi7VVk?=
 =?us-ascii?Q?XtsDTvmG8e1O1W2DsUYaAStDmzs74DX3hrz3Wc7AVnKwDm+rCQUvLm7hoS2q?=
 =?us-ascii?Q?DqfvhbYtTXx7obZeKTCz1S9FLCuzM4OFmi90MYll0eYFRnOgl6k2x/0qEgZa?=
 =?us-ascii?Q?wg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	CysA0FZwNxBBgjuez1Kw9aH5ZhCOffxyHF/b6fFuhz4KoYXQocLLbLeqG+V+YWFMvjjReVS+4ONgBGZ4JJS6UkJ9zgdmxFysBDRH/9aaAXwI3gif0nphJ8jBEmW/uH0eD9AkSqGZsMpCPZsO3pBTC2R91tSOxDQAggDBLswkJbQgHN353tCA3Jqu4t/Zn5D4DZwRtT62vGeYPzAF7a2O8pOVCYNyBse+/sMTN/g5Shrajt00y/3TAy4fW4rKLpfN5hZX0Ce63++hnQj+j0rozNX7FbIZp9ktUE7wCn7ZFOICnfZJ3NXg26LumUxVkSJF5lZbIv1knEgBJDNX8q5uMJ9JCL1OlQYsDzlXi0T8S7Y3MRtmJ/xE8PAdGLgs331VxIvWFICvYgKLZ+sTwzEXPWnWtT2FdUPbEH3e64gs09HP6ZAPe+efujNosDo8Q5d0e2Ct9XHTgeKE6MtqWqCfPM/2OYot6aSgacwdMT2VcL3W/K20JfbV/CBdyJ2/TGJjVsw3tHT6glX7i8oyhHcyA6MeLrNyNqR5NCamOibDwQnrMGkhCzo3e0BaTxpdqplJidRThdyAtx+tv+ZQTZGy/WeIFTlwJaZu68K3ABwXQu8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f524396a-d06c-49b8-3f19-08dc84cd5f0d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 19:34:37.8466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rprMWALVspGy+cZCTNk12dyQ7B71QNnNzIlTu8ziSiXvJaHL3RtbKlkj2VSUimiAavIbH3FxWXbxYoCMAEIpzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6042
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_09,2024-06-04_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406040157
X-Proofpoint-ORIG-GUID: -eWVeXr26t2Oguao0N5eRuNy8WR2m7_g
X-Proofpoint-GUID: -eWVeXr26t2Oguao0N5eRuNy8WR2m7_g

* Sidhartha Kumar <sidhartha.kumar@oracle.com> [240604 13:42]:
> Use mas->store_type to simplify the logic of identifying the type of
> write.

Since b_type is now only used in one location, we can use
mas_new_ma_node() instead of mt_mk_node() and remove b_type entirely
from this function.  This is also true of the maple_node *node pointer.

old_enode and b_end could also be moved below all the returns as they
are only used after all the other options.

>=20
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
>  lib/maple_tree.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 314691fd1c67..faadddbe2086 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -3437,12 +3437,10 @@ static noinline_for_kasan int mas_commit_b_node(s=
truct ma_wr_state *wr_mas,
>  	enum maple_type b_type =3D b_node->type;
> =20
>  	old_enode =3D wr_mas->mas->node;
> -	if ((b_end < mt_min_slots[b_type]) &&
> -	    (!mte_is_root(old_enode)) &&
> -	    (mas_mt_height(wr_mas->mas) > 1))
> +	if (wr_mas->mas->store_type =3D=3D wr_rebalance)
>  		return mas_rebalance(wr_mas->mas, b_node);
> =20
> -	if (b_end >=3D mt_slots[b_type])
> +	if (wr_mas->mas->store_type =3D=3D wr_split_store)
>  		return mas_split(wr_mas->mas, b_node);
> =20
>  	if (mas_reuse_node(wr_mas, b_node, end))
> --=20
> 2.45.1
>=20

