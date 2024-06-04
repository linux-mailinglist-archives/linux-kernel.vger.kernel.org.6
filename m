Return-Path: <linux-kernel+bounces-201189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8918C8FBABF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 19:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C961288491
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 17:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D5614C59A;
	Tue,  4 Jun 2024 17:42:35 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8420F14B951
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 17:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717522954; cv=fail; b=VMHx3kxTfM5v0/4bc3ffTwAPSzs4xhBjJQ1ULHW56BbGAlwfuKqEwAGccXNN49/yqXxGFud4F1QF+B0OkWHRM5+Cmve1lHP4oeYrmtWMsIF+P+vYhtpqZRuUROwqIxvNcZzPS5CQh8KjE3YXJovsqhulIDeiJo/o2lzAwP1Sex8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717522954; c=relaxed/simple;
	bh=U5KxjEVQtKiNRRjlHzjjAsBRxhSg+s6y4LlKqpGnr+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HuwaMrGeWEyhx1nzIpiJmzy3rTIRU/GvEb6KDe1nErIvughucXBNbUPjqXObg/6NVyasIPcGknYKmjcbDsBs38atp5kmrslz5h7vBKGoXg7b1v3CXMx8++FazaQqvej3SrF4LLBEhFOH8xy95g/PofYy4SWCR5s7x7ooCOiEARc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 454BnRx4026501;
	Tue, 4 Jun 2024 17:42:18 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3D7+x3u2+/bHbWB8/QSGmRsO0iD0mdBl8MbJVOtKnMvyA=3D;_b?=
 =?UTF-8?Q?=3DIyNif54fyiEwHSTIc90GOSCgw8IIkLiYMNjUfv/Dnd01lyOMbBstC37tXDQ3?=
 =?UTF-8?Q?xqntT65c_xvdU7lcMD8n9ilwarQ1rRKCmQx2xEsPYrMvEeSqqB92/Z1KH5REwSm?=
 =?UTF-8?Q?+ijT83NycngfJu_/SSRSW/bqG2QkLfb0jiZ1GjFoeZHpkZwVd9j1K7sgBzp/nKz?=
 =?UTF-8?Q?nJSIt2yBY5VrNs2F5c/Z_ZvjY0QZElkIkxbK7LrRJK4ZUZPS9takZW/5RUqH7gF?=
 =?UTF-8?Q?8idbmGC7sJR2LEs5GTeNmkbHxn_vYJaO63RmiNJquJwwzBIJqJvQSSP02ShcZiE?=
 =?UTF-8?Q?NZ7JHNOi1lbUDUhTfTGT2M1q1zJnTIe1_+A=3D=3D_?=
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yfv07wjy6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 17:42:18 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 454HbJvF024002;
	Tue, 4 Jun 2024 17:42:17 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2045.outbound.protection.outlook.com [104.47.55.45])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrqx69q2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 17:42:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=joVKZxE8R4GowqHZCQZ5z9ym5VnlqPzRWKVvFuF7AIMGEA2KoYxEbWx9PbT5bTDU0fEG1iMBqJJDUbPJSA7R9Cxcvl9Y9Mt2YJWktISgRJ/eWmy19tKkD2qyEReKomhVTC0MNZmtFmmJvHsHRAFhKCQKTcb6la9YhuMczSgTGvP6TQkj9P15JZlhcCew3iejc6tydy4SKgdD/MH+rRM3esYQnYyUyt+g+VCpw2FCVp6NfiVjNk/eW4GnVSXKBiLNZvWFRM6wSo4JpTU2LXTEHBtoccqunZgaApEjdVnTqI/x7GMhSUbZ/dUuUvt9RHPN5nA3y0U8SNw8KPeW+Vh3Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7+x3u2+/bHbWB8/QSGmRsO0iD0mdBl8MbJVOtKnMvyA=;
 b=XJb/tSLSftW3D8bH9SQlfaeamiPo8kvyHoywhZOJcQKRZEOOtOyVw4C/0SGdCU9aAwW9BNDTTlr0hvgAtuI0b6oLCapm+xiHFLOhrZ9FxGAoDEShIpZwa2PYF3jUNEgdLafdhhS4bjVVVRpEh6mXP9u7GEaBOKvMh2bITGvZDDposl8O1xJztBt7MRc1XwdK3XcH+varskk8NgA297+W390CwCDQvCeiz2oFXGLfCEuRkbbm8g22QQoo07IpuNNW+3F68ieMqQQTRLPW4/GrxjUQrkXsXM3iUOWnjFs05BuTN8ivQcdVK0rXVwr8hZvxmFVu1bpcUZvLHlu46F7gzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7+x3u2+/bHbWB8/QSGmRsO0iD0mdBl8MbJVOtKnMvyA=;
 b=kG2vutiOhRzOQGPB7N9Xv809UBi3EH1pnwSl8y7jeVCdCgpjLgR0jILtlZbEtCwgYRYQEcdynG9VgeYWNeFsiKcAP9efCcnQGtyRjroIhhzgijgLXeVXOHL5i8BvMiIDpRhI8Afcrf4UFBaaoNrWkLVF27t37hfhVLJh9Psrq14=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Tue, 4 Jun
 2024 17:42:13 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%7]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 17:42:13 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        zhangpeng.00@bytedance.com, willy@infradead.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH 10/18] maple_tree: print store type in mas_dump()
Date: Tue,  4 Jun 2024 10:41:37 -0700
Message-ID: <20240604174145.563900-11-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604174145.563900-1-sidhartha.kumar@oracle.com>
References: <20240604174145.563900-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0191.namprd05.prod.outlook.com
 (2603:10b6:a03:330::16) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|PH0PR10MB5893:EE_
X-MS-Office365-Filtering-Correlation-Id: 405d5cee-37d2-4432-7490-08dc84bdab2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?B5C6gJRc3G9mEcWGvyjccogHpND2SQeeNX5R1swj2dGv3c3I8XScWPJwBdFu?=
 =?us-ascii?Q?Yd9sYNibzziz4wYD1Idmp3r2XyxtQaYXolkweL8BQXWBewHXQhwfpfJjYE3J?=
 =?us-ascii?Q?XiUiW8vKZN/0kfWFjEjmbbkJVauCMXsRFu3TCR5VJVHFFajb//aaCO9vmlkb?=
 =?us-ascii?Q?w9q12mTqQOaOabFesZXuTzA/6+NwbGiJVYO2k+8Ue9btzLRG9DoFNwKzaWbS?=
 =?us-ascii?Q?GQktUKLqmPNYNchUgXjp12QVOMTHPkKBNofniP1RH/BtQeVorkOJhMDLhdqW?=
 =?us-ascii?Q?YUQolJtN4cdHyUnJYJcBO5/ds5zczTsE2nIXCp5cViKA/BJwZo8Y5zcJXElA?=
 =?us-ascii?Q?iKLKvCwoeZFhTss3bh5YUBRSxHrRVTpBdapj6QvOR3HpVWa1srZeKwmg/vpG?=
 =?us-ascii?Q?KLsjqhyr/9cdTMhlOmyXqmynPT5ZKif6PBCpUXAjji2nU1y8T5uf5ZnGpj3Y?=
 =?us-ascii?Q?lONjoJBBt2o9bNW7lkA3AUKW0XJ0wWRkiN1gPZMTeMi+VaYT4upK0Zjgtrk5?=
 =?us-ascii?Q?ANXLCd9cG80VxfI+qwm8V8lF6fOFFYFcvqa44jASzvY/jkO8pkj1NvOkdR63?=
 =?us-ascii?Q?Ejl7zzl3+HZRSY1bZkhsvmTXhleVxBbci5iszFRQPFDVBB8Lp7gf6rjNMaz8?=
 =?us-ascii?Q?WRamTdGjRIB6IyGaqHHTyE+cJ37eFztlrHOaI7LMZMKJX7nSJUYN9P39xRnU?=
 =?us-ascii?Q?qnjEfU1BDU8JhqRaA1mwli3UDGdVAyBEcooWfyaJIhNrpVJoi12H/a15xdD+?=
 =?us-ascii?Q?KnJhTwGohtkmYZf6J0srkO3Gw+0gJVtkyj43+OIg1sgi6CR+FUpvpsnQYcOi?=
 =?us-ascii?Q?QGHQhAO0s2q7szll22z8EnD8Oty1SWW/82UjL4eof/5BtaU3OvAsFJ1udD1y?=
 =?us-ascii?Q?FSQsbM/cbmCZVLPLCoe7s7wEYx27aumIBcAGrelE8ipiX8adCS+2yoAvCczN?=
 =?us-ascii?Q?sWEiV1QPS7xCdwtTyoUAlFtdD8UflpGTlAb/HzY0NOII00Kge4n4Mc5C62Cx?=
 =?us-ascii?Q?uN54eTfA/sEG2LMy72oVOeuFeAgMUswT6ryq9lJ9K2++44SVjB+/eIeuaKPi?=
 =?us-ascii?Q?ZBlVAHaHr4beZATQYxt39FXeu7UelxCLnVS2l6+i/QjDURhU29hc3HXUqCqw?=
 =?us-ascii?Q?42cOe0Ap2Ewb7pdLJS8yCFY1gwnda01XinOPOsFleExfedr5KDiSBm0pdxgd?=
 =?us-ascii?Q?sPQSGik+Mipo58eypI8U+MBhkgt0DoQs2RWVGX+k537cDFGb4EUDhKWcgx59?=
 =?us-ascii?Q?pTwed30X4m4CEnPNyi1ppCVXk4Xpay9Ia0fG8inE537wgrMKK0rIji1jrosi?=
 =?us-ascii?Q?zVVqAabrk4ni0cSRYM08sv22?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?7F/y5xskdkhdGZRMJNUIo7hDeHEz4bFd+iu85SHXxl00EdBo8s5PFHwf6zqK?=
 =?us-ascii?Q?oSDZ0xAwNIxc0N1bGgtcDWnjEcey1RupMljsIQs+88g88Yg/IKvmo8qEjGzg?=
 =?us-ascii?Q?GDWaH965CKcz8NfLNJ6hfoYjjS1WSgAlqLnu0SeY2LaHZ0CowRWl10I7PwmW?=
 =?us-ascii?Q?bmhhescYlsbdJraK9YpKUhXPeDI1UaSsbljGcqbqxbCf+KGIwXt16Pr/qb9A?=
 =?us-ascii?Q?AnsxpxingVUWlw0bcvABkv4HIRXZc9LTKLV2GJ6Je5EdIkx8om9AlEnddE9/?=
 =?us-ascii?Q?WcNN6Go0uso0qaLN1fUpquLgMSYsXIAHzfViVu8WWCgK48iXW2/bJWQ8MhHa?=
 =?us-ascii?Q?vDsXKcqT5wHrOyHtLu/tkK02s1tnaXx0ho8KHFIQ9DML6l0bHIv/xthZjyMq?=
 =?us-ascii?Q?xn+OH2iq/T4xHRspNtpvwOQJMSG+YrXyZ18Gr1uokhPbZKxHm5zHAx06HB8E?=
 =?us-ascii?Q?YseHHKbq4KzWgDTcBC896yyZ+h0cJQAYWJuARi1xHBmX9qEx+e1BtyTZ171b?=
 =?us-ascii?Q?87FjFNW5hyTu5z1SwA9ZA4SQISpCgr7UO3ishHaafDOuZTxgIG6ZwpI9gsz3?=
 =?us-ascii?Q?2W6DRuOwQl8XfK4hjrZHU1UkY+yI0tQXeARItXqdRt/0w4zndhFb7hMZfbpb?=
 =?us-ascii?Q?xY1aRNlHbrsrMNhZRT0l1BSvwfTJtWaG3gjUs1jDhWDBf/5+F1sN0HFLztWT?=
 =?us-ascii?Q?0WrzV1uxjAJe3uq6AWopzOV/XIpOZYP8Xah0Qe1KJ1rQXOghn/LPNmEcb613?=
 =?us-ascii?Q?Y8hWsKW5sx0YboRHQTEivbt826mWkLMT6GN58DqayZrGthlDecopaDWTgC5S?=
 =?us-ascii?Q?yyz8Cru48z1rnQ3zsH6C8Gm3j0jxJk+nvsN+7Hod9tapnxpIzsJRGlsm+VTm?=
 =?us-ascii?Q?nxxFHKIAR5o0qnEYoUnKaCCFwJLuFOe9/sD625RU4tBBLLLTpJzkJ+kUF6KB?=
 =?us-ascii?Q?uq0+g+nhXy1zWqHH4UPCfw9N7c0Mma3W5SAvZ/SftJdulX7DIFYIQaWD2lTD?=
 =?us-ascii?Q?1KzP2ho+2JwaBOn3gxAFHjUUtd2iBQO1oo917GxipnyMDBnVFT0UqTyNdVuS?=
 =?us-ascii?Q?xSB87APS1wl5oZLJ49ENK47AH/dbsui7rfcDQehOpTsOKqoaNn+ZS/KUrl5r?=
 =?us-ascii?Q?TI+zNoFJ89CW0CIo4cOvBohW/X3UcibKM1Ep6eEoZWuBl8Vg452auoRKE/Ax?=
 =?us-ascii?Q?SUNGV9ADuil9/Iv5MOqVfYPLZ3jdDWCkKCKlHyV9rp083Yw4ApeJhK8oXE8L?=
 =?us-ascii?Q?1777tnprwrHlR0qyxoYYj6HIpts6P8KjeMzpDvnqeVlT6SNjfRXixLU/MH+1?=
 =?us-ascii?Q?aXngxT1O3cbwKJnJkYl3Vmfdbj0SvoCcVnxt0eKhxU2X8biTCilbmqThb2vk?=
 =?us-ascii?Q?NWrv1JkkZpl3Bgl2CLllQ31JI2gO79iIUgUp0iayhrHK2hRqPa4/icvCkXN4?=
 =?us-ascii?Q?GP6twZRRJifO6jtDnpPY7QQMep2S3LL0nPAhnOVFlGJPaGkkbwnrevI2xcEP?=
 =?us-ascii?Q?HtbdLTzJKyzloHakvnRCI8EdCJBixjgIQMOT1uEvlzW+O+QqfossDvfrvxzj?=
 =?us-ascii?Q?nMQAwwvpmjzf6hymBGgbtz11ZwuhjBojcoDIaMjKd27gJJ5BuGwxTvWsi2I6?=
 =?us-ascii?Q?hGfU5EOleGPRtuzy6JEaEN8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	AwFAtePsqkSbVCtKJx23r1ADD1ce18c4sz7Vu8gMzaYr5eYDez1XCdvYT6RasVXimWKspy/x+ohgTBrROGl4sKNzNZzSpMbRppz3U+qBfAnbxDkMymhhCtn1DcM6n569gzo4MvF5+lrAbqT56yps/QAqxe5yHqlMGwRFiNDxAR86czPrObPdSkFwELgaNq/AHwvQYkf92ippFJqOIeK3LZdkziZVIJv37giTY8iHmnjRmeDwuGxD45E9d6sza6jM991S8aL0/7dzNUE0xSqGEjqwzaIzE5ozmwR55fqhtJRnYs08vPeoJuF2u9f9FA7ejREea9JNebrjJaVwhGvDz+Mmu2p89nCvtRoVTjXfk21LdDzqHVPIM90HaMhrfwYpZ7vOv0tEEbi1S4ifNYssxlHfvkTjZW44N9SdKX9UXXSgtYlwQu//UEx8RMX41YR6VGfiqoGBL0B9wEJhxSE0XJonY1nb7Nyyz7JgvRFivAlIA0mT0PkTnfjmNPGW+NQ3QS3maPZllc8jMn9bwQoXajhBAxgFjElulilrWiSqiRz4R7SVXvvZ4mm3rzAJH04Y3bD2lwCL9HNK+YTpR1kuD9gvJcdbvTmbkJhYdSO1q2I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 405d5cee-37d2-4432-7490-08dc84bdab2a
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 17:42:13.6768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: txgWmva+J+Fbj5Ol6cTvyuguffRclpQ4qFeHFcM/lPREVppb8FDJsJx8KTgrghZuuyi/ybW87jwiJZRQldYys1Jv/PddwGS/JMFoSnFtcr4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5893
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_09,2024-06-04_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406040142
X-Proofpoint-GUID: 2Pa2Yr5cXPSwAKD5iVotpNt70RXKAHXJ
X-Proofpoint-ORIG-GUID: 2Pa2Yr5cXPSwAKD5iVotpNt70RXKAHXJ

Knowing the store type of the maple state could be helpful for debugging.
Have mas_dump() print mas->store_type.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 lib/maple_tree.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index e3ec6649f7da..abd2f396bb1e 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -7729,6 +7729,45 @@ void mas_dump(const struct ma_state *mas)
 		break;
 	}
 
+	pr_err("Store Type: ");
+	switch (mas->store_type) {
+	case wr_invalid:
+		pr_err("invalid store type\n");
+		break;
+	case wr_new_root:
+		pr_err("new_root\n");
+		break;
+	case wr_store_root:
+		pr_err("store_root\n");
+		break;
+	case wr_exact_fit:
+		pr_err("exact_fit\n");
+		break;
+	case wr_split_store:
+		pr_err("split_store\n");
+		break;
+	case wr_slot_store:
+		pr_err("slot_store\n");
+		break;
+	case wr_append:
+		pr_err("append\n");
+		break;
+	case wr_node_store:
+		pr_err("node_store\n");
+		break;
+	case wr_spanning_store:
+		pr_err("spanning_store\n");
+		break;
+	case wr_rebalance:
+		pr_err("rebalance\n");
+		break;
+	case wr_bnode:
+		pr_err("write_bnode\n");
+		break;
+
+	}
+
+
 	pr_err("[%u/%u] index=%lx last=%lx\n", mas->offset, mas->end,
 	       mas->index, mas->last);
 	pr_err("     min=%lx max=%lx alloc=%p, depth=%u, flags=%x\n",
-- 
2.45.1


