Return-Path: <linux-kernel+bounces-201183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7238FBAB7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 19:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC2581C229E4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 17:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6979114A609;
	Tue,  4 Jun 2024 17:42:27 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC56A14A4C8
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 17:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717522946; cv=fail; b=L2clyM7opGdL90wKLAA8r5snWfqfa3+Hz9cUk+yQrYLEqcvn4ccW3jMg9XoRsXAvKnA9nRn0rk4AaU7zv6hBz4L+AsVQyL3Ko+laHxBnjOqprWaL6s2MoJ2BK5MNZRlZbnuqfZx5UK3bCIepS4vDW5EO/rmJC6CNpoMyPBsThas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717522946; c=relaxed/simple;
	bh=2mrP6S2CM1DUFcZIXufZPycx8oMaqIdk47OurEOsq1g=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=O7rj0m1yRzvQJYRQxuqQioU5Ce5io8faZaccLR1FyQmnkxb0zvnc3VNvkW9Z1YhhcQssWq5OnHZaTXhGGM2OhEO88AFIArRF4IQ2T29x39ZQ5wi6lvLu3Fn2xLT3/TTIcJT+nj11xh7yvmcxVlsh2UijUdArKOVG7tpB62RPy+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 454Bn7Fn006035;
	Tue, 4 Jun 2024 17:41:58 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:message-?=
 =?UTF-8?Q?id:mime-version:subject:to;_s=3Dcorp-2023-11-20;_bh=3DhdP9MYQ0b?=
 =?UTF-8?Q?A53N1Ubwu4dvV9GWPOxuMVPDSAhF2bza6s=3D;_b=3DIzKwhwJvtW0ZI9TedlHN?=
 =?UTF-8?Q?4j/skYvo3f22h1B5AwWNR9eJTGZ853VS4Jxpn55tSzPPENWi_gP2uekM2jHjZMg?=
 =?UTF-8?Q?pLbSiP3L6rdz3sqcix5w/hPUNz1W2lGMmyunPglNH4EX/znmNCoSQG_x93AnqXk?=
 =?UTF-8?Q?YBSXoZjsraOLlUxc+DhhWO0e1VroD7ducJ/EyXgHPIN8Mou6RTGaLGEiz+0K_Eg?=
 =?UTF-8?Q?0W+sJ2DBumbvgEyiSNpZmgOQq5Lj583Qhx/9Ml7msW3YrOW/dYu/ebcKSAa5blR?=
 =?UTF-8?Q?cF7_KuD1z/+KrQ3zhuMsS7O7guOUk+4mWOY9RkCHJcNcHfNN3g4tOaYvh4HH0o8?=
 =?UTF-8?Q?ETK3gNzDz_dQ=3D=3D_?=
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yfuvvwhad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 17:41:58 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 454H2AEJ015605;
	Tue, 4 Jun 2024 17:41:57 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2043.outbound.protection.outlook.com [104.47.55.43])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrjcnmq0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 17:41:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gzTjukieGiIFIYD5fM30YHfAfAm+kVMGlBFCliw2awaCiVGINV8z0Q/B3vNaFJIXiFKSDQKaidWBNjGIdhUmltmsNiWXfWjbz3dVbj5k9IRnaG17nyUY9lW1WNOUIyQE+A0bXgkN2HqVF8LpYAFuZb69WplTdP7u/mMvtW+lee1WCTGyF3xXhVm5O2wiApGv7dqeWInF5ZBHs+8mJEDo+15uPtCpqNctp5/zKeAIum1y1RB1pXrqG5iyN1R0AqogmTp8HIDCQnStyMDkbiPZUaRIfDYbEAGLUTT+caRlu7+hqes2FjUa4dkd30/yTnlZ4/LZ54EPUcYoJiKIDofuVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hdP9MYQ0bA53N1Ubwu4dvV9GWPOxuMVPDSAhF2bza6s=;
 b=leizQmpK9OOtljnSi7rbcxTpUuOzcLA5/7mBIOvrDWtT9hlPj4OCYY5UJceT1L7Hsnl8ohSXAfL88E3WwuPm/LFJGPiJHG+ri1XN/OTaQkgXBAAy59rcE0MTtep3akdVYKlatqQrd+QRxT3rNzuBNd2To4f0ranp4ezHrt6yRZ4OkS/SGs8Q2mQXPbyAj0V/PnJe7D0EEdpUKCdgRp2qPZ9IqKJdc7m8carybqXQIOLpPPW63Go7NLCzy6DcbzIRd/+OJlFMhhDt7H5gsdd1NEowbZttL4PQz3ooihl3iYPO/ZCpUq1z0In7iIeJq5VWiepUiMIEFxVuqrn3p6Fhvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hdP9MYQ0bA53N1Ubwu4dvV9GWPOxuMVPDSAhF2bza6s=;
 b=NiqYFx/Y4sjltT3iOAPHTCOvSHEfZ+BhfEZdNrKTAUUWigoeplYBNHQsRU3tXAKWlvTanF8bYN8ZeL1Bgrd8QpUt3FnjPmqSiR10Wwc1JXQgoXOAKgn1xUNC23x6ihFKvV4j1xiCi+vq+SoEAdWiyX+GCm75jjwolBbxxu+zgs4=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by DS0PR10MB7269.namprd10.prod.outlook.com (2603:10b6:8:f3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Tue, 4 Jun
 2024 17:41:54 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%7]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 17:41:54 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        zhangpeng.00@bytedance.com, willy@infradead.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH 00/18] Introduce a store type enum for the Maple tree
Date: Tue,  4 Jun 2024 10:41:27 -0700
Message-ID: <20240604174145.563900-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.45.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0234.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::29) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|DS0PR10MB7269:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f31023f-8d4c-4361-493c-08dc84bd9fbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?KqmmwObaq/v2C29W3EAIK61bebaByeQcN1PKd3ToJBYAuEeh2h/6geLr25mL?=
 =?us-ascii?Q?TN3GI7YRIh51kexG0fRe//4nqAAynRTnT5m+V9fOyAqbDRILWsH2krdvv4Kn?=
 =?us-ascii?Q?KnkZIfHojHb7rwut0MV8LjTXtMqoYvvcWFBTXbWPxL/bg+ZNTqmXoJ0Q7RMU?=
 =?us-ascii?Q?2e+2KNa+XTnmxsbXPv3SllJ/eVo9gtb9+djPPe37/myaV3ptP54pifr1FKIF?=
 =?us-ascii?Q?e8FqmiQHnaRQ01Ng9JWcPof6efm5HNZXuDRcQsKz5EiFB4gPzpGkewQHL8Zq?=
 =?us-ascii?Q?BFFGZC+nLF175gY8qrMIOvExWseN6bZwYY4wqouMOFIPq9v7QRbl/SvUjn8M?=
 =?us-ascii?Q?Y9aXnnJF9qpCGh1TP6dDA3eFRRZh93KSo98a9I/3Xg09m4my+jWVpL/EMP8/?=
 =?us-ascii?Q?B6yfNC57PdsiJnqpMZpyrlOznYbC+THMeB5w9Z3NMNeSpbqMkh37NpjLmGBu?=
 =?us-ascii?Q?g4aiuP7+RUX+5HDMJ/Y8ncF9RESL3/Qb/jZ2vFvDS0Rqub/zMFIJm2cYeEnK?=
 =?us-ascii?Q?nLFHWSbIocP1AtW9p0i4IfW8s3j2HyewSb5trZ+g7ScS38MgBSPiDQZtt79D?=
 =?us-ascii?Q?to2rPhMhXhCrWyd8xPAVxxeiEpFZuvLSJHUThgInN/NvGKyV8ePgRBaCeOjS?=
 =?us-ascii?Q?HkpshJhLYmapOGc1/JolHxamBQhVNPbzQy6P6nDsTQw2yVwwx6tWV1APH/FF?=
 =?us-ascii?Q?c+6+xqQld+MTiPQQJVcoFvP8JLq5OG+Y2Lhs/N5ITTO8W5CCidKugu88iCCK?=
 =?us-ascii?Q?t//TD7DxZzQWmwNBw5c6fMyrGNfnrAeqZkgmp8sPkQXeaqfO0EAUg/LRbFyl?=
 =?us-ascii?Q?ELlnHIKQHWeggStoaR/+uZSCZ24xOYmZBd1IbFyvRTtnmGq3LiEDPtCx9L3F?=
 =?us-ascii?Q?jpAnFFgXqeBef4NhchyRXpnLxskx5k+XIPhZ1iwdhLUuKcdyqmeaL8VrBEy9?=
 =?us-ascii?Q?npC4hWs1SvgnqdGTVOTfeW+tz25vg/k9CwdfT5eSqcCX3KSExIja7wcD4L0/?=
 =?us-ascii?Q?uULpDvC149sfornvi10I8M/tCbTFaKa+qkzF5cJFX3BtpPbZOhjrZ+DTO4+0?=
 =?us-ascii?Q?+NY9ltB/5dNbF/zgpgJqFSpjwmbECS28hma6hu6aeB/1dIkq1FHo48cBCJzR?=
 =?us-ascii?Q?Ny65sUofZEcgWFUcKxiaoDTR+5lPCjCpbNrJhUv6KMmywZZCt8/njDBZ+n8X?=
 =?us-ascii?Q?Vskx33GDlQxeIA+/Il08x0RpLB6jkBXgXYQ1my3KPwjPmBkcT1i3yCBypF2N?=
 =?us-ascii?Q?BIPdfICp/S0jKZQL0p9TQKLJQipJLwvnfC0LkzKFKD32NVWGoDla+a/o74hZ?=
 =?us-ascii?Q?6cXULz+pDB4e+fRt8HwZH6n7?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?a/H27o+gseJ38s/gsStbLJp00VDqkQ+y/TbI0u3HrOBS71qwvXhzU9cMjTRW?=
 =?us-ascii?Q?I74QcgeYvv3Q8b+jVQCn5e+77u6HPNkKIW3+3C8wOAa8K2iKJoqasMQ8S+a1?=
 =?us-ascii?Q?mk2mkAyQdPYBtT1cUyVZ3DpcYP4gPWncdTadvf8wocwLvELIf9Ss+E2k5oww?=
 =?us-ascii?Q?6oIBMGTjA8RR3/dWClrpNBW8roL0ZqDgQaDq4Qfc59vYi0GCOD86t01Xh2tZ?=
 =?us-ascii?Q?IT1QRmQafjGAdC2KG/0PDmy1gZ3SLKbjvWTmqOw1l0tyrSnayX7kj5Ha5zJ3?=
 =?us-ascii?Q?8KaoynBuDw6Jnp8N+fEarrW3HAwZIbq5gC2itugYR5qFAdXWsneYAytKyWej?=
 =?us-ascii?Q?7Jx2j3WaN4l2gAruKqJIPx6bfyZD1pcKnbEHj7dhzYIxkWw5K771JAP67api?=
 =?us-ascii?Q?CWWw/+tmgHOKYnoi3W7OtVvqwdcFNAHo40pp2bIlVgp8efZ4ShD4PjIpWmAE?=
 =?us-ascii?Q?9dbZQRbWuVc3vH8gR1oC583qKg77n7QQyNSKiB4zbnKouq8e8AmTUz/UDmJ6?=
 =?us-ascii?Q?tgTu4ZvG4gTeqVZvEdEleWUepaT3KnJMUDjpVUjh3K8uSEh0TtqNGdf7J/ov?=
 =?us-ascii?Q?LiPcf1QuCgT6hBV406RfgyansR/WYAGHReZLwUhjY847cmH45PZWqUrLVzqU?=
 =?us-ascii?Q?lWXC4DurGIQPQPYXWE2rTbhf+9uQckg1S0pQf/zKSKrvTNjX1wMI/DCBQ+He?=
 =?us-ascii?Q?Ksot718HB+YD5TenHp+YxjRxm2WAKJyUS+D2iwx16Dr2tKPupdfaIjtJ7vhC?=
 =?us-ascii?Q?gIxWi979jBrahS2uYzQtiRuZSy/yk8eF3Krxco6eBKBFAb2i/nUs1hioZh0V?=
 =?us-ascii?Q?KOYboTZwAtDlqophV992ifQKD8fNq+xftpS21ZGIWR/dnNZQxd0OGsi6wOMt?=
 =?us-ascii?Q?rTjBBOQmUgk9ouKzfGdIA5n/JfBXLtZqPc61z+kFFcb9h8/tsmHNlA3KuKsO?=
 =?us-ascii?Q?780hm8HJq/O3vWpRYOvLyIGlKlhRmWxDoIdpszlD95SsScsBV//kbVL3xsoU?=
 =?us-ascii?Q?+Pm4Ta3jIKVBrMjtaWxE4C8W3p+vCZXlCN2y54WLgbT4zKs+7H8CTfuSXAco?=
 =?us-ascii?Q?3ZYe7g81UQcO52r8WOk2OdT3FG4abhR60VnYSuelqvb9oKH6E8kZcS60Jx6v?=
 =?us-ascii?Q?/5qpkv4C872Ih744AcxWWOUf0++8kgU8w9puHKBdFvuSo1iGU8xyDjAd7zgc?=
 =?us-ascii?Q?af/JYOdmgPp7Gr2AwzbPRiWrBug2zIzTzSUUnj9wzGTx6j6+fVll7ErJz/ZI?=
 =?us-ascii?Q?FGTOGWZxFEawsKdJhir9WwZASsczmkeoXvfYty64VMhuSFVPEafVuc9Z32hX?=
 =?us-ascii?Q?C3Eq52+nBCssABkcdfq+bq1bQC+jl+LPGuISRccVPLRcvOXg6QtDQRL2DAw3?=
 =?us-ascii?Q?k6pVsF+Il8LL/1bH2R210zHqnEIHUfj6LpmG5zixOyctXqkH6SVQpwuEtokT?=
 =?us-ascii?Q?wiodUrwz5lYSo1ipOvNwm4qTpRUNOvXrvNi73dx7cByHBlGfp1y75+1qcqVS?=
 =?us-ascii?Q?kkdcU4C21dGsvZjLRabjgTT4yVCMvHoKBanDEKyRa2jfr7Y0R7/csVk+/+WG?=
 =?us-ascii?Q?8VVLfAQ5zrS2UNEgukk152wYhPb3a7QrBRksalrlNMfVF4TtOQxuVRH4kVz3?=
 =?us-ascii?Q?NUYPpnD4iWbijxKUJZiN1eI=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	wwLH/4wnihP+HXnCXK3J3g9ylnf8kUXe0G90cUc09zIB+dzLtWdCngMbVcwg3uHDHROnzxhyTW1ms6MC75fvfLsbSWmlwdo5whDfp3a1jkcMBqzp4gTqDYNkPZtRJC7NzzOEssVa9W3PsVIlHsZMcTyVj3kwpDulRlPTmqgZWVQDhBnKp5XpnmvcPww66HrivoyAI/yObVFgT5DkTanGdqQahpMFbgTplJE4pr2UhGzqqbtooTeIhMmMSMatGFt/ESv+71vbJ+01lHJHvLqfLeE75mKetwnx8hfG0DqyC8LlDKtgmDcqTVi/hPn9y4cZ882zEcae5EVuFKv8m9Fqr8KiPr+disAIf4atzZ9FbmX9WrxAW0Ks6mPThmpzYjDlQdUe9aRlW69vb5mWJZJcHJSKukRf5HQDlcSNYt4YBAdfhP3PPTHhVvJavNudkmP5W5UxfZQZb1g8Mqrhciag3IAiPoF8HlXRppDEt8WjOAR0eLWNZsaR8ZK/xuWUJ+31IsLVKWQbSmIR//DDx9vEcft3DZFJH5xtxEV7b+luoxzif3uLga9/CBkI4oHsRoHgrX1CUg/RAt4NqBxeOtm+hD2tD1BhEH8GTw9p1Hrrfm0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f31023f-8d4c-4361-493c-08dc84bd9fbb
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 17:41:54.5000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tBN4SdO+X4we12FEdNtLXqsazjAzl/JrsgDJv7HT3uhUktOYrjRg4iMrK5jur+nvuhK0bYvF1d+kUsWTfZyMdzXbAcL1x25xFs10jy69cUw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7269
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_09,2024-06-04_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 bulkscore=1 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406040142
X-Proofpoint-GUID: e-qfo8kcv7AZrqhYhpO6BPvqioXHYhgH
X-Proofpoint-ORIG-GUID: e-qfo8kcv7AZrqhYhpO6BPvqioXHYhgH

================================ OVERVIEW ================================

This series implements two work items[1]: "aligning mas_store_gfp() with
mas_preallocate()" and "enum for store type". 

mas_store_gfp() is modified to preallocate nodes. This simplies many of
the write helper functions by allowing them to use mas_store_gfp() rather
than open coding node allocation and error handling.

The enum defines the following store types:

enum store_type {
	wr_invalid,
	wr_new_root,
	wr_store_root,
	wr_exact_fit,
	wr_spanning_store,
	wr_split_store,
	wr_rebalance,
	wr_append,
	wr_node_store,
	wr_slot_store,
	wr_bnode
};

In the current maple tree code, a walk down the tree is done in
mas_preallocate() to determine the number of nodes needed for this write.
After node allocation, mas_wr_store_entry() will perform another walk to
determine which write helper function to use to complete the write.

Rather than performing the second walk, we can store the type of write
in the maple write state during node allocation and read this field to
complete the write.

================================ RESULTS =================================

./malloc1_processes -t 4 -s 30
v6.10-rc1 (mm-unstable 06/03/24)
average:14178
v6.10-rc1 + this series
average:17197

+21.3%

./mmap1_processes -t 4 -s 30
v6.10-rc1 (mm-unstable 06/03/24)
average:24579
v6.10-rc1 + this series
average:28625

+16.4%

./brk1_processes -t 4 -s 30
v6.10-rc1 (mm-unstable 06/03/24)
average:46663
v6.10-rc1 + this series
average:55388

+18.7%

================================ TESTING =================================

Testing was done with the maple tree test suite. A new test case is also
added to validate the order in which we test for and assign the store type.

[1]: https://lists.infradead.org/pipermail/maple-tree/2023-December/003098.html


Sidhartha Kumar (18):
  maple_tree: introduce store_type enum
  maple_tree: introduce mas_wr_prealloc_setup()
  maple_tree: move up mas_wr_store_setup() and mas_wr_prealloc_setup()
  maple_tree: introduce mas_wr_store_type()
  maple_tree: set store type in mas_store_prealloc()
  maple_tree: remove mas_destroy() from mas_nomem()
  maple_tree: use mas_store_gfp() in mas_erase()
  maple_tree: set write store type in mas_store()
  maple_tree: use mas_store_gfp() in mtree_store_range()
  maple_tree: print store type in mas_dump()
  maple_tree: use store type in mas_wr_store_entry()
  maple_tree: convert mas_insert() to preallocate nodes
  maple_tree: simplify mas_commit_b_node()
  maple_tree: remove mas_wr_modify()
  maple_tree: have mas_store() allocate nodes if needed
  maple_tree: remove node allocations from various write helper
    functions
  maple_tree: remove repeated sanity checks from mas_wr_append()
  maple_tree: remove unneeded mas_wr_walk() in mas_store_prealloc()

 include/linux/maple_tree.h       |  15 +
 lib/maple_tree.c                 | 559 ++++++++++++++++++-------------
 tools/testing/radix-tree/maple.c |  46 ++-
 3 files changed, 386 insertions(+), 234 deletions(-)

-- 
2.45.1


